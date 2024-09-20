Return-Path: <linux-kernel+bounces-334075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A997D255
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0183AB229DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF137DA6D;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR3R6Mgu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D526AE8;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=AjbRfn+dCe9NWVXobmdXQ8W0yHFXLyPouuwvs+W0/XcHYhjrt46q8CttG5MOe2V1y4h+ggJ5LdvV4+lnGgVY8Q2N5MT2DRMpoKv0NV5laoaTcQE3ZZKdQiJ/NKevdHcFnXwAnJIUwa5V2DTyokIEx2yeB9PvhROAt/GAkvFhpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=uDJ/JfCAZYzKjfsCM7SEEMTMXp/hsTtivqJC8/88TmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMWUfHMPCeUNEffxbNkGiiLXtT3O5z3mwsxpd6FT2/K7DhD5bIJCMipI1x5nZ04YpdlocuWJMcZyL2650Xs92ie56zAFr8yKPDdjEZ6Pg0vTRp60oGpfBiWgS5/0v4ekBi1wrLVh11MgG1toQ/P8BBtZhUGgL8v+Zf61NZP+hNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR3R6Mgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5AA0C4CECE;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=uDJ/JfCAZYzKjfsCM7SEEMTMXp/hsTtivqJC8/88TmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sR3R6MguRXUzRqDWyPt9p6vqAPTNrX+We6G0fTU+DbxS2ndvmqYJZr08N9wlyBMg0
	 uglZrVlhz5TwGDqhk3DHcG6VkAuEQsCZZkwNYHMKkxKAegI6cce0u6HLi47Fq9brOH
	 r91gRteRO1b/qMlMxcaru0Psecmup3LhNlxJSMis+9d/Qm3sS8grp+8EcJwdu5AK1+
	 rPZTZdjgBLjzoaGf1jhkWIl9K72h1Ga90WO+PQKYd56GgmFJEdlFeCrIBie5DcYgCj
	 R12jpj/SVR7iB/CDKBVnrCMM/ewzB30qSaGH0GFHs+REhERxdE4cwOmOtKNNZr0Dxg
	 Zs9jI1cZexriw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD3CF58E9;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:12 +0800
Subject: [PATCH 2/6] clk: meson: axg: Delete the spinlock from the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-2-5249a9a7e2b7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1500;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=A66AwGhQ5KfvBGuX3+8YPfqlQmWjyAOHLmEF/9YfExU=;
 b=bC07qWlOnIwGnXk6bbO3cqsQy+tRulPBMDppiO6cLZkxQu92f1niJme+f0EGewC2yIcRM9eSX
 uoKBnEkizCdDJKW8+cYsx8Ay+NjiznMnc324fuKn0XBL08ySyMbrG3s
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
 drivers/clk/meson/axg.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 757c7a28c53d..1b08daf579b2 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -23,8 +23,6 @@
 
 #include <dt-bindings/clock/axg-clkc.h>
 
-static DEFINE_SPINLOCK(meson_clk_lock);
-
 static struct clk_regmap axg_fixed_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -506,7 +504,6 @@ static struct clk_regmap axg_mpll0_div = {
 			.shift   = 0,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -557,7 +554,6 @@ static struct clk_regmap axg_mpll1_div = {
 			.shift   = 1,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -613,7 +609,6 @@ static struct clk_regmap axg_mpll2_div = {
 			.shift   = 2,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
@@ -664,7 +659,6 @@ static struct clk_regmap axg_mpll3_div = {
 			.shift   = 3,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){

-- 
2.42.0



