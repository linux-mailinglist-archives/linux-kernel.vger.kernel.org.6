Return-Path: <linux-kernel+bounces-403550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD19C3714
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223851F21E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691314AD19;
	Mon, 11 Nov 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="All2Leeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5D14037F;
	Mon, 11 Nov 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296230; cv=none; b=gtq/x3pvm1CQeQ0N9mleCa4KQxD/phngbBKscmL74MmXMV0ZXq0Q6IfZLkqBXeJiLEN7jfqo7HZIjSI0kAFIA0SSwLCFhuJyz25XbVuSWm/cdZtfDH4a6u79NHq/MmVqCe5gNhB1mS8jX4v5di0T63OU/3mcfQVs7H/knDNNB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296230; c=relaxed/simple;
	bh=nYbSMyAY5KMAdoS2ugyZMdKHOHfvsmdyGjahtE6WqS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e45kwPrKkMEEcsznp2zegwco4kuYVm0uf4iK4qXdFwIcjC9XdOKhHsMOXKGGTRqjipAIvWhWMVEmx2FqA5S1+26q8aq1CiPi/pFZmJsYud2LoMNkDqWVS17rzmvhh0dZXnUiWkfKBeH0YVb6i6gl8ZfnYJYDUaYBn+hUhSmROf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=All2Leeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC7A4C4CED9;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731296230;
	bh=nYbSMyAY5KMAdoS2ugyZMdKHOHfvsmdyGjahtE6WqS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=All2Leeub2vLtkgMokXyxiO17uyb510PsqDL8/nWLB0BSlJBmZWs4Cufvkn3lNESB
	 lNye+Bg0HIxqK0dlbf9D0WXF5gf2b0Mczr0wmj9oirRfZ4UCqPzzSHlf9kdgeSWTif
	 1x5z9vRHxPVmDGUdnMsuo/HZIxoujL1ur7WBJS8B4wRpLqyBT4A5ZfqteKdvWYtDxC
	 6sua9wLn5TfI6Ud4R4tdIjzHyIVk2f6fHf3oI72NW6/dFnzG8XHVxi9Wqovz8bBtjx
	 Lx50OLnUg2PxFce1Vz7Z7/zj+jd5pE7YlQBJhpUYYkX2YxIOclHB/z3Hot4bd9w7j9
	 uAPuvdp272ljw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A1D12D6A;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 11 Nov 2024 11:37:03 +0800
Subject: [PATCH v2 3/3] clk: meson: Fix glitch occurs when setting up
 glitch-free mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-fix_glitch_free-v2-3-0099fd9ad3e5@amlogic.com>
References: <20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com>
In-Reply-To: <20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731296227; l=9556;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=14bGE9sYOEx+b5MpaosDAU5c7E9221JER7/akkkpyQI=;
 b=87LGzbmMRXSyu8oy0ZGzgmHOdsqYg9UC7pAj0lFPfWns456G42M1cSzMH6cVTq9gMqpYri+rx
 /dcbvMA+08ACSttJ7amw9V9S8vQysAH2+fQWaMFVAEyERZpvfPVoHnp
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

glitch-free mux has two clock channels (channel 0 and channel 1) with
the same configuration. When the frequency needs to be changed, the two
channels ping-pong to ensure clock continuity and suppress glitch.

The glitch-free mux configuration with CLK_SET_RATE_GATE enables the mux
to perform ping-pong switching to suppress glitches.

Fixes: 84af914404db ("clk: meson: a1: add Amlogic A1 Peripherals clock
controller driver")
Fixes: 14ebb3154b8f ("clk: meson: axg: add Video Clocks")
Fixes: f06ac3ed04e8 ("clk: meson: c3: add c3 clock peripherals controller
driver")
Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Fixes: fac9a55b66c9 ("clk: meson-gxbb: Add MALI clocks")
Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC
peripheral clock controller")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/a1-peripherals.c |  8 ++++----
 drivers/clk/meson/axg.c            | 12 ++++++++----
 drivers/clk/meson/c3-peripherals.c |  4 ++--
 drivers/clk/meson/g12a.c           | 12 ++++++++----
 drivers/clk/meson/gxbb.c           | 12 ++++++++----
 drivers/clk/meson/s4-peripherals.c | 20 ++++++++++----------
 6 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 4b9686916b17..7f515e002adb 100644
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
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index a1217dff40fa..e2d3266f4b45 100644
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
 
diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index 4566c2aeeb19..27343a73a521 100644
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
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4d3b064d09fc..21a25001e904 100644
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
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index dfa9ffc61b41..812b3e20c366 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
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
 
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 79e0240d58e6..cf10be40141d 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
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
 

-- 
2.42.0



