Return-Path: <linux-kernel+bounces-321126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED139714E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA4A1C22D65
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4831B4C29;
	Mon,  9 Sep 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxQNulY8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE21B3F12;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876558; cv=none; b=XFmCKFCpU8fr2UAEMNRyJGrA57pUYm+VdwAbQPxmyOsv1Q/lhnsnVHB1SNmC5n9mbm7Rm5vzk3miOjAlGMIu7GHcr4emjbhG2MBHiGZhYzfhP5OVqcfILFzIL/OYx7QkOfnfyj3JhhddLh92Vnq2ww6/vPTtgBigBVEVqHrrW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876558; c=relaxed/simple;
	bh=uCQdKOYsTP4hrdyMRlGaCSGI01VPRdBPeBN372SaHDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGkZ9JGACnbDpMo+dt5K7jbcCyIs/ePD7MOADD4rTM3BJgCfoZOfA90F4Es2Zrv5LJutUdh+Epafx+HDDfS16QzjZGWDREKEm0kdbvPxRANhvYx6nv+1VMbgXA9rogjWlOhSihTBKCSWA2+5XUmQLefxBfA/wzMmdT0OPSlvQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxQNulY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754F1C4CECC;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876557;
	bh=uCQdKOYsTP4hrdyMRlGaCSGI01VPRdBPeBN372SaHDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PxQNulY87u5/JVzGFlANjQm8D2poWanBScahXoiT27qgfOSZJACpHGAKBue0+w106
	 4bjqgF5BjlV+hBr7D1a8vUjB5I2azY+QXIoT/hLJtFkutf5Qb2lRJT4KfiW2JKhCLY
	 Rri+qgrEymZw3p9Sdtt9qJK4RXI39CwQKAkrdfZKF5P5E/ysSGC1swIFqBwmgfG0pG
	 6uQ3NbcnaeEhN0Go1fhycNqQMx4em+pr3AdPY4YcbU3hbPAw8CtdgBqs9tdEBkVg60
	 szsJB+W7ocdADklMsXVdCzUDnQ6fI3flmLP+TqyXxbhq4asqNqQ2HPMenrBhxTDJMa
	 cEvKwA1aNWOOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFAECE584;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 09 Sep 2024 18:08:58 +0800
Subject: [PATCH v3 3/3] clk: meson: s4: pll: fix frac maximum value for
 hifi_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_clk-v3-3-a6d8f6333c04@amlogic.com>
References: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
In-Reply-To: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876555; l=793;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=0Clx6bfIj6hxSYsk/ARky+mR6oBy1RRrZhsjk6VQ2QA=;
 b=kW8tt0TPN5U0gdUFRbA8YWbIIehLdHdhtzws/z4AezrasCh7v4VlykiQ5tI84OkY62bcGPxlT
 z/4cFfsxf5RDwcO6cTBms1LwgLJBDWjner2BfweVSBII5r+prmbwmco
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



