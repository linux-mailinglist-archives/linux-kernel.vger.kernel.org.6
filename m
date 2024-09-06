Return-Path: <linux-kernel+bounces-318180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE296E984
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B51C217A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9913B79F;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPqB5D00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A6130AF6;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601957; cv=none; b=YAv1/6f6RFyxNg3kHsVhaSl6PxsWyB79a3ja+pQfIgUEIIHM4Wyj+DfQZdyS1sKZN1ZEePH4DwkfHmF2XQoUSVx30D73TpXn63tu8ewJ9oMHDavsEFBOwP4r8QkfhmhS8OLojorz0Ar0OixPmJSKukp/dxb6Bldg18Z/bJyzGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601957; c=relaxed/simple;
	bh=fZnb4eOdBuuUWog66uoDoe+ZN8bX/78YQ6P8dpOsCpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/rXaiHytu9fLa/zaTvYxOwK6+LZ3E9h4aO1CnDMXKLZUgSdbun1KVHjkrseWoEqm4YT/XGkz8/imh9zhTS3/vo06zz/O7ZcicUnZdxBgcY+ubivAPSyp7IBZjxMTu41rjUoKxBfcK7MfiIbCzpSo+4jMBgeQi1y6i43dOknylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPqB5D00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF67AC4CECC;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601956;
	bh=fZnb4eOdBuuUWog66uoDoe+ZN8bX/78YQ6P8dpOsCpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qPqB5D00PLNLktkk6j0d+tG2sR8G64MDsJr5f4NK8gjwvX6sFtCEr5cL+fabhHS9+
	 Ym0V8JSSIqYsvxImVvHy62JdxbKrNOH6SZicXNt3P3JAwaaJrVnAnjNhBgGbTY7IxQ
	 Zq2gjICUFWB4AUfqv86yaoKRDRScqyLZu3PCPNjhl8tTbm3ufHkLdBN0wYBouFLs3k
	 Dt6L7hEyHgDN2QqcRozRL1a85o1vwOQyp1nNRTVQ1PI5PICp9Y9IJeG42BB8P+2I2X
	 Su1AHtaLZZtZGEj1INrzEUrfLAN8ezUYe3qnXD/BHBbNBy0S2FAAVjW/sANowTlJsz
	 YedEFGttKdjqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671ACE7AB2;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 13:52:35 +0800
Subject: [PATCH 3/4] clk: meson: s4: pll: hifi_pll support fractional
 multiplier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v1-3-2977ef0d72e7@amlogic.com>
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
In-Reply-To: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725601955; l=1150;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=9arg64z8UgGz40ls665ct4U5mW7FxNd6ZQXnRFwYvkw=;
 b=IogfYnGomgoFnpWnEW+aCeCWGoCRu5sjduQc9ITv14leLMU9GP9TTYlf8pekBb+LXLIr543YO
 OhNH1AkivSsAjqqOQYQGUTeWrKmzZRYalqnckEaeovZLnZ6Hg/9bc83
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The s4's hifi_pll supports a fractional frequency multiplier, but frac
parameters are not configured in the driver.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-pll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index b0258933fb9d..a97e19057b05 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -329,7 +329,6 @@ static struct clk_regmap s4_gp0_pll = {
  * Internal hifi pll emulation configuration parameters
  */
 static const struct reg_sequence s4_hifi_init_regs[] = {
-	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x00010e56 },
 	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
 	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
 	{ .reg = ANACTRL_HIFIPLL_CTRL4,	.def = 0x65771290 },
@@ -354,6 +353,11 @@ static struct clk_regmap s4_hifi_pll_dco = {
 			.shift   = 10,
 			.width   = 5,
 		},
+		.frac = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
 		.l = {
 			.reg_off = ANACTRL_HIFIPLL_CTRL0,
 			.shift   = 31,

-- 
2.42.0



