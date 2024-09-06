Return-Path: <linux-kernel+bounces-318181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8396E986
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EFE286604
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3013BAD5;
	Fri,  6 Sep 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFyRRY4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294913957E;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601957; cv=none; b=c8Ii+m0g2jGdl4q0XFgIet4EEkjf1vxQyIxs6ojKmvFv4UppRew26+DOXV55SULBhu7IBNKcJw2hAC1KDOY1Ihf/q9FS+SOt263bQtJHscuM5ifev1nanga3X54ViTge4UdKenEntp4s29b+aCCvJ3QeVt2xUj24GB1k32qflWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601957; c=relaxed/simple;
	bh=NF51BZTpHooM2jXXouuv+vaFnFg1br4o/kba70yIL58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nD3TPuYFFGjhtgXeI5OatUqeCEMP+AAis/kOtSxomDtt15L2NICMDYknIa4GbYrcSn1mJ0jaXayyozga29DxaYe9cLppnuPrVSuPI5AdxdPPPxwvR48XX1wNnw0mQn0tXDjly9o0ayrmvRbflrEFc+7Nv1uQv5vWIjv0LAyvT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFyRRY4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F10CAC4CECD;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601957;
	bh=NF51BZTpHooM2jXXouuv+vaFnFg1br4o/kba70yIL58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BFyRRY4NFXwkS4wHF0H/68dCuyWVIwSnIn0mPwTReAkVJRSePaPLXj5DQtiF83o5G
	 GH/lzZDuQbcIleoQ2bAYMx4i6j7//0biTUnE59KtzQaJQIhpNzCD2l/WU+VwgPnGNA
	 yoNUlLd9uGIoCwUGlkwv+rquLXNWHyILYMdjzLiXpiaDncRYAoWxzkhrursQ714/XK
	 X1ybSLWhNaVRkwHBlZMu/VAWJXvgAnyG7EmdQaydUVXhwGgiQPZEPA7METuLqxnmJv
	 VRQqzxo8/4iHxnESYxXh5FA3VEhFbsYbCqDPZbuip9AcXaYLMM9v996ebNUg/vuzRY
	 VE/eYK9RuUvdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0DCE7AB4;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 13:52:36 +0800
Subject: [PATCH 4/4] clk: meson: s4: pll: hifi_pll frequency is not
 accurate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v1-4-2977ef0d72e7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725601955; l=856;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=ro5ykdJDKk3Y3xDmm5Xm1OoCgPIR4AFyD2bYCkCFPEE=;
 b=IZ/yVuY2wLIpYN/mhZKmh78eSRhQWPOQXk6dCtA0gTmfYzo0NItf/y9PgHvE5d6fhK5WadFzv
 FjJPFyhAp4AAYn5pGpB2DtD/haOcypyrWQKn+SK+pRys+RXlfwNHg5p
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The fractional denominator of S4's hifi_pll fractional multiplier is
fixed to 100000, so flag CLK_MESON_PLL_FIXED_FRAC_MAX is added.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index a97e19057b05..a793ac2e8cc7 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -371,7 +371,8 @@ static struct clk_regmap s4_hifi_pll_dco = {
 		.range = &s4_gp0_pll_mult_range,
 		.init_regs = s4_hifi_init_regs,
 		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
-		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
+		.flags = CLK_MESON_PLL_ROUND_CLOSEST |
+			 CLK_MESON_PLL_FIXED_FRAC_MAX,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll_dco",

-- 
2.42.0



