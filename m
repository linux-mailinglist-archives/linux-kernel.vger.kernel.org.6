Return-Path: <linux-kernel+bounces-342812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF94989336
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033CAB23A16
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0A13AA27;
	Sun, 29 Sep 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds0YKh0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5A52F9B;
	Sun, 29 Sep 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590228; cv=none; b=VL0i2y5erzZDhW18+8nPArZwp/giUNiH3fJrH9LJbNvfp7PV3ISbeH48ynu4AVV20aiPA/sMzC3XVC2gQVeRXCMe7kkZfeQqoXh11eDlyH7cXe5BcNk4dn/ZV2Ql3SQBDgXe2d3cH7c7myLrBuXitPdWpDyDQJ38ycCgMuGQMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590228; c=relaxed/simple;
	bh=5CPvQ6p78bqZi3ugnMq/mnWHLrGLVbFRKmPC/Xy/YmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljZUohDKNcocQ66+jbCQXkmZRJxYB807cWAhcEJbtaTLHkmnM/Sm1FwEI/R1jQ3AxqIoEaHBINBIFpIXyGUKvhduNYxApKqTIKGZfzdTdtg9DDu3M5KLcn+SkNrlR0RJ7V3NgkmYl7wIlOmcVsgMhUJDtJU1NGwLWBD0LsOdBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds0YKh0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E01AAC4CECF;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727590228;
	bh=5CPvQ6p78bqZi3ugnMq/mnWHLrGLVbFRKmPC/Xy/YmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ds0YKh0beBd1iKgeQ5XGCN1JTMNladCMo93PoXhkZJANmbhL4FUjro3aQnSDowEr+
	 N6V46h6RQpg7js0KeNuisgkFOsyPKSHlXO1/J9oSWaMGQ+v64B3C4YQQdkInKXyV1T
	 naM3V8vN2HrPgmSdQonm1FJin69uBX83LzZzBXf5ig35wMpIh4I7fxmpbWOHh+o6Hm
	 qHpKyXSR6rJtL1zeaZe2KoIPCUNJHcP/GHeBfuwy8YTyoUo1kqQQa15IV0+bT2jNx/
	 IK2h4vk5Lsz1kPrD+1uvVJiKXG/jNVi6tiGnPMuZFbQ+73h+k72BfiQ26NKlTQS+UQ
	 3wFGy8eBITMGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9CCF649E;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Sun, 29 Sep 2024 14:10:06 +0800
Subject: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
In-Reply-To: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727590225; l=13770;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=L3VAxB25xJXcMFUVId4du0KkatengYbFRtL0k4k303o=;
 b=HnvntC8NRHhLcjfJshb754IypomnY64nXnMOtUom66/OC+DxSEl//wq8Y3bPb6NxvDODM8DWs
 q/mWbkqMuGXAzo0U52qUc0v5rUyeXjARIxZoqpjyVepvCK+W5RHPAgS
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

glitch free mux has two clock channels (channel 0 and channel 1) with
the same configuration. When the frequency needs to be changed, the two
channels ping-pong to ensure clock continuity and suppress glitch.

Channel 0 of glitch free mux is not only the clock source for the mux,
but also the working clock for glitch free mux. Therefore, when glitch
free mux switches, it is necessary to ensure that channel 0 has a clock
input, otherwise glitch free mux will not work and cannot switch to the
target channel.

Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
switchover to suppress glitch.

glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
has clock input when switching channels.

Change-Id: I6fa6ff92f7b2e0a13dd7a27feb0e8568be3ca9f9
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/a1-peripherals.c | 12 ++++++------
 drivers/clk/meson/axg.c            | 16 ++++++++++------
 drivers/clk/meson/c3-peripherals.c |  6 +++---
 drivers/clk/meson/g12a.c           | 18 +++++++++++-------
 drivers/clk/meson/gxbb.c           | 18 +++++++++++-------
 drivers/clk/meson/s4-peripherals.c | 32 ++++++++++++++++----------------
 6 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 7aa6abb2eb1f..7f515e002adb 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -423,7 +423,7 @@ static struct clk_regmap dspa_a = {
 			&dspa_a_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -471,7 +471,7 @@ static struct clk_regmap dspa_b = {
 			&dspa_b_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -489,7 +489,7 @@ static struct clk_regmap dspa_sel = {
 			&dspa_b.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -569,7 +569,7 @@ static struct clk_regmap dspb_a = {
 			&dspb_a_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -617,7 +617,7 @@ static struct clk_regmap dspb_b = {
 			&dspb_b_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -635,7 +635,7 @@ static struct clk_regmap dspb_sel = {
 			&dspb_b.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 1b08daf579b2..e2d3266f4b45 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -1077,7 +1077,8 @@ static struct clk_regmap axg_vpu_0 = {
 		 * We want to avoid CCF to disable the VPU clock if
 		 * display has been set by Bootloader
 		 */
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1126,7 +1127,8 @@ static struct clk_regmap axg_vpu_1 = {
 		 * We want to avoid CCF to disable the VPU clock if
 		 * display has been set by Bootloader
 		 */
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1144,7 +1146,7 @@ static struct clk_regmap axg_vpu = {
 			&axg_vpu_1.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1194,7 +1196,8 @@ static struct clk_regmap axg_vapb_0 = {
 			&axg_vapb_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1242,7 +1245,8 @@ static struct clk_regmap axg_vapb_1 = {
 			&axg_vapb_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1260,7 +1264,7 @@ static struct clk_regmap axg_vapb_sel = {
 			&axg_vapb_1.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index 7dcbf4ebee07..27343a73a521 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -1364,7 +1364,7 @@ static struct clk_regmap hcodec_0 = {
 			&hcodec_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1411,7 +1411,7 @@ static struct clk_regmap hcodec_1 = {
 			&hcodec_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1431,7 +1431,7 @@ static struct clk_regmap hcodec = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_data = hcodec_parent_data,
 		.num_parents = ARRAY_SIZE(hcodec_parent_data),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d3539fe9f7af..21a25001e904 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -2746,7 +2746,8 @@ static struct clk_regmap g12a_vpu_0 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vpu_0_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -2790,7 +2791,8 @@ static struct clk_regmap g12a_vpu_1 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vpu_1_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -2812,7 +2814,7 @@ static struct clk_regmap g12a_vpu = {
 			&g12a_vpu_1.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -3035,7 +3037,8 @@ static struct clk_regmap g12a_vapb_0 = {
 			&g12a_vapb_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -3083,7 +3086,8 @@ static struct clk_regmap g12a_vapb_1 = {
 			&g12a_vapb_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -3105,7 +3109,7 @@ static struct clk_regmap g12a_vapb_sel = {
 			&g12a_vapb_1.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -4039,7 +4043,7 @@ static struct clk_regmap g12a_mali = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = g12a_mali_parent_hws,
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 262c318edbd5..812b3e20c366 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1132,7 +1132,7 @@ static struct clk_regmap gxbb_mali = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = gxbb_mali_parent_hws,
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1543,7 +1543,8 @@ static struct clk_regmap gxbb_vpu_0 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &gxbb_vpu_0_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1591,7 +1592,8 @@ static struct clk_regmap gxbb_vpu_1 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &gxbb_vpu_1_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1613,7 +1615,7 @@ static struct clk_regmap gxbb_vpu = {
 			&gxbb_vpu_1.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1674,7 +1676,8 @@ static struct clk_regmap gxbb_vapb_0 = {
 			&gxbb_vapb_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1726,7 +1729,8 @@ static struct clk_regmap gxbb_vapb_1 = {
 			&gxbb_vapb_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED |
+			 CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1748,7 +1752,7 @@ static struct clk_regmap gxbb_vapb_sel = {
 			&gxbb_vapb_1.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index c930cf0614a0..cf10be40141d 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -1404,7 +1404,7 @@ static struct clk_regmap s4_mali_mux = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_mali_parent_hws,
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1466,7 +1466,7 @@ static struct clk_regmap s4_vdec_p0 = {
 			&s4_vdec_p0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1516,7 +1516,7 @@ static struct clk_regmap s4_vdec_p1 = {
 			&s4_vdec_p1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1536,7 +1536,7 @@ static struct clk_regmap s4_vdec_mux = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_vdec_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1586,7 +1586,7 @@ static struct clk_regmap s4_hevcf_p0 = {
 			&s4_hevcf_p0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1636,7 +1636,7 @@ static struct clk_regmap s4_hevcf_p1 = {
 			&s4_hevcf_p1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1656,7 +1656,7 @@ static struct clk_regmap s4_hevcf_mux = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_hevcf_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1712,7 +1712,7 @@ static struct clk_regmap s4_vpu_0 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1756,7 +1756,7 @@ static struct clk_regmap s4_vpu_1 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1774,7 +1774,7 @@ static struct clk_regmap s4_vpu = {
 			&s4_vpu_1.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -1921,7 +1921,7 @@ static struct clk_regmap s4_vpu_clkc_p0 = {
 			&s4_vpu_clkc_p0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1969,7 +1969,7 @@ static struct clk_regmap s4_vpu_clkc_p1 = {
 			&s4_vpu_clkc_p1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -1989,7 +1989,7 @@ static struct clk_regmap s4_vpu_clkc_mux = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_vpu_mux_parent_hws,
 		.num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 
@@ -2049,7 +2049,7 @@ static struct clk_regmap s4_vapb_0 = {
 			&s4_vapb_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -2097,7 +2097,7 @@ static struct clk_regmap s4_vapb_1 = {
 			&s4_vapb_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	},
 };
 
@@ -2115,7 +2115,7 @@ static struct clk_regmap s4_vapb = {
 			&s4_vapb_1.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 	},
 };
 

-- 
2.42.0



