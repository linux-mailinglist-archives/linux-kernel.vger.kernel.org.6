Return-Path: <linux-kernel+bounces-334079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E397D25C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA060B2376B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9413C80C;
	Fri, 20 Sep 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aimu5PHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A574BE1;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=dvbxucs2JxPeS1Hs4lnsWOXfXJlVn2X/iJsGJ8w7TGx7V8k8czAju32XkcoEV60SGjT5PaGC3LbB9HK43o1K7khrRgBnhhlMfE1uZU9SvRe0/M6KmPRmju438FJKV7VYQvyinhty7+V9f9LS8wKilUB5HKJh8oOcRA5BiaKhINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=DradNtZLKYKI/pe922nGMOfjuaKzkzgQd7KVWBEvvso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=su/AJCQvOzZqeeCcUUuvM1bOufNwgUNwZcMibenFYQPAG9ls1T3cz5sMtwuegwzx/j3yA5WfuzRxGYcif8BUhgcCgqley4CR9zja5m3oDRlSmxtGFfLoEzKkVpdnls1ER6KRE6+pfXVZxCaN+/LNF2s8YF+uqhaBB6jCXWXSExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aimu5PHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D399AC4CED3;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=DradNtZLKYKI/pe922nGMOfjuaKzkzgQd7KVWBEvvso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aimu5PHdTxRSviYw9IsCYWW8ejEKajFIc+y5xuoRBSDZ9PGRi5K73TKVN3QHu2Szv
	 mMQjURBzxf901Kz4Zl2JNwmTh7yU/8SDCUQxAIEY0H8Hb/iYpBIt3Yu9c9a9ih1AQ3
	 Sdto4RJCrHUs68epLAPhIaCdYKGdxj84vrj5UrxCpEjUxUPRwLarV2Jv2sjIzliNt2
	 KIcDnmvY7f5TLgUvmlTe3kozbMIotNuDDrnP9lhJ/rAQOepWJgDCYQ5wAvmY97IsSD
	 bg7yRrz3zZdBK6ersKzt04Kq+V1c9XGPh9aiFQJbadF2eyT1XmaddU+TSUCind7iml
	 LC8vSj3PZkriw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D9CF58DD;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:14 +0800
Subject: [PATCH 4/6] clk: meson: gxbb: Delete the spinlock from the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-4-5249a9a7e2b7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1458;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=r/V4f8IDG1LGpMtumtpaJ0LFZXwZ5q/tzNNHh8H7+Ng=;
 b=NtifgucIpJ4Mvxn1mZSWmWBsWYiHyWJUsScY1EzaHpJAZqr8qLzhX8/r5U3bVyAU6Q7KgpmrE
 5Qi+Dq7JQwADH+ieFl7XPqEZ9egM5mtM6IaxvziEggqp0Z8Gfgv2thW
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
 drivers/clk/meson/gxbb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index f071faad1ebb..262c318edbd5 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -19,8 +19,6 @@
 
 #include <dt-bindings/clock/gxbb-clkc.h>
 
-static DEFINE_SPINLOCK(meson_clk_lock);
-
 static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
 	PLL_PARAMS(32, 1),
 	PLL_PARAMS(33, 1),
@@ -731,7 +729,6 @@ static struct clk_regmap gxbb_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -760,7 +757,6 @@ static struct clk_regmap gxl_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -812,7 +808,6 @@ static struct clk_regmap gxbb_mpll1_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
@@ -855,7 +850,6 @@ static struct clk_regmap gxbb_mpll2_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",

-- 
2.42.0



