Return-Path: <linux-kernel+bounces-334078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B997D25B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA03286624
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB913C80A;
	Fri, 20 Sep 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqnpXtnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056976C61;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=cN9lFhOcuqOMGTA5f/zVy4Dhdx1a0sJeEjslSpezBRmkZNq+hAYWjwMjgCv6Qlpkg22eYTyCg3BsW8Z91JVbPQv7HOpFa3A+5l+xQP+PEzBUtavRaTM4op2vhghAwSmLO97+JJ3eOMnspyltZvthdaJ+TyHqafJog72Iol8PdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=+Mcq8HQCyVmQFXDqiSObnUSgLIkezOO5EMsHAPIWPUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvlHi4NppIRZFiD/9zqoUJYHayNe/i5Kumub5JRPl4SIQSpD5gclhJe61XB97U29pNHByZiv9RDlVvjUu60xWVSWuqS99EqdekFS2G+7z3U1xHDSrZ3zYSSUIKJSEc48t9e7MU9Scihc1pKZA8Xbfja51hGUk2JLWmehpZMSQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqnpXtnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3F68C4CED5;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=+Mcq8HQCyVmQFXDqiSObnUSgLIkezOO5EMsHAPIWPUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dqnpXtnAJw9jHfRlMwR11g5ByIKieefRsy79eFQAmp8uKnSkxq7qTnwPryf58bfX0
	 k1pUm4ISmGjMwlG8C3/YuqQltMgbfnTmB4zb4MRrUu8rUBrgnkNh+OfeFkh9qT84zs
	 LHZM6zJUnYGehKWHvxr0MFW1pjRZ7VXBWSqU1eeQgcXPSa+wzQ8U1V8mtHi0G2ktNr
	 FWree7PlZ5rhlIaZanb86eOXF7NC3HNOn+mMnXCc8G6ti97yLapnM60biIJ1Xzjynd
	 BDMrf4aQHkcvjeaknfA2/1EgsYoE2PoxoY4bYetCr9i98/8wjhz8/cVkBOtzmNG/20
	 X2QwnYPOB5trQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA191CF58EA;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:15 +0800
Subject: [PATCH 5/6] clk: meson: g12a: Delete the spinlock from the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-5-5249a9a7e2b7@amlogic.com>
References: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
In-Reply-To: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1559;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=MZl3oPXVbFrreOWsDGIWEgWOlrCQLcqRIhkDzjt3Cc8=;
 b=rP/mr0KX0CYpSvUBB4/ILbi/5tZMB85fblKCbF0E0b2repGNwdGARAflq4jCqraXN5U5FXntI
 GPjaJ4vFjmqC1ljnYvzbDMZT3fLMLx8vU1fFX/HMF92Onx3NjkXe6O1
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

It is meaningless to define a spinlock in the struct meson_clk_mpll_data.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/g12a.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 02dda57105b1..d3539fe9f7af 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -28,8 +28,6 @@
 
 #include <dt-bindings/clock/g12a-clkc.h>
 
-static DEFINE_SPINLOCK(meson_clk_lock);
-
 static struct clk_regmap g12a_fixed_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -2225,7 +2223,6 @@ static struct clk_regmap g12a_mpll0_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = g12a_mpll0_init_regs,
 		.init_count = ARRAY_SIZE(g12a_mpll0_init_regs),
 	},
@@ -2279,7 +2276,6 @@ static struct clk_regmap g12a_mpll1_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = g12a_mpll1_init_regs,
 		.init_count = ARRAY_SIZE(g12a_mpll1_init_regs),
 	},
@@ -2333,7 +2329,6 @@ static struct clk_regmap g12a_mpll2_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = g12a_mpll2_init_regs,
 		.init_count = ARRAY_SIZE(g12a_mpll2_init_regs),
 	},
@@ -2387,7 +2382,6 @@ static struct clk_regmap g12a_mpll3_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = g12a_mpll3_init_regs,
 		.init_count = ARRAY_SIZE(g12a_mpll3_init_regs),
 	},

-- 
2.42.0



