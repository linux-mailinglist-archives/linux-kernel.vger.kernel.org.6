Return-Path: <linux-kernel+bounces-318678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D596F19A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765B9287E11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6D1CA683;
	Fri,  6 Sep 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCC7ONT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784571C9EB6;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618898; cv=none; b=odKdPmVj4bh4L121MpqW4cxN6TIWzBEHXhTScT7rzfx5ftf5SCJS2gixE2IRJu9xOdz/nb6ax2aWTNem4fcHg25qtMkNWSY1ocwFDDEaF84ikKa84J+LGPOKjgtD8yVfYXEqEL4indoZBJ+Y8VFDuTEA47s+UpEJZOxeZYem6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618898; c=relaxed/simple;
	bh=uCQdKOYsTP4hrdyMRlGaCSGI01VPRdBPeBN372SaHDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2zblbOi5sqvADi7lYIGRDQ4JVJgKh4DL85czWg+VRP9TTI3LS4ftE7jo6IhZlO7P+nDQ6kViL8NLG1+YcUqsROyoxyvXQf6/2cfS9Z2TZKJUQU2WUdGbpXUWKGvRljCtu3mw9FevbNkOZOHj1GyxtjebM5k68R/gwCxDt94QZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCC7ONT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D86C4CECC;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618898;
	bh=uCQdKOYsTP4hrdyMRlGaCSGI01VPRdBPeBN372SaHDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hCC7ONT/cma4aU4Z+r81N9RKtxKkYiwnLLzscmNvctmk6zKdwO5veqtwaJfrH6tGL
	 rX3BAgm1wS+ptOGNdEucxbMgzafuu+ZwE6ArALAFYpXVL2qnD1oqB4FsHFkwOKCd6H
	 3d89x0ihJso6L7UdL537YUJDILXENHayvC2n5SwL92huhMU0F9gXyIJ9HRFrVIUUru
	 O+yz3469o2aOf7/7oMjjxP0F7W/aGC3HMeWR2btV9WkVkRJSSZvK5qE6SD/Qo4evm6
	 +48d/CSoragLY6ILimAndiWNIgEAtiHqexOmqswOTYdoWK9w8whsg8lJZQuT5OpXHH
	 c1gOCnSIU9xzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16738CE7AFB;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 18:34:42 +0800
Subject: [PATCH v2 3/3] clk: meson: s4: pll: fix frac maximum value for
 hifi_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v2-3-7a3941eb2cdf@amlogic.com>
References: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
In-Reply-To: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725618896; l=793;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=0Clx6bfIj6hxSYsk/ARky+mR6oBy1RRrZhsjk6VQ2QA=;
 b=ThDaSqaw71UK6w/lWibNMR0YeJltaOgEuPPvwpd+6M1NwIFlx1gS3eMXr41yBZug7ojGK0sGw
 EBsrcnT4InBBrsES6cADjt0jMtjpw4fJjYCzE5zDZzNdk8sEla4Wvfn
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The fractional denominator of S4's hifi_pll fractional multiplier is
fixed to 100000.

Fixes: 80344f4c1a1e ("clk: meson: s4: pll: hifi_pll support fractional multiplier")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index a97e19057b05..9697f6577e06 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -371,6 +371,7 @@ static struct clk_regmap s4_hifi_pll_dco = {
 		.range = &s4_gp0_pll_mult_range,
 		.init_regs = s4_hifi_init_regs,
 		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
+		.frac_max = 100000,
 		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){

-- 
2.42.0



