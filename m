Return-Path: <linux-kernel+bounces-514008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329EA35143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206787A4F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA8270EBF;
	Thu, 13 Feb 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b="wQ+otXL/"
Received: from mail.mvand.net (mail.mvand.net [185.229.52.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E226E15D;
	Thu, 13 Feb 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.229.52.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485566; cv=none; b=aI+61OJ1w7NwRlZKustztxzzWorMdQgRqCwLUZ6RzuYmjPK/wZuwvVHgX68mUKJ3NG5GVXarU0RVuwmZf8U9rL3npQzYIHa2fuJg7RKl9Sa0YFs19Bl6tTNwap+l3iFsD+UFvkekiUJ0HfT2UA3Na8PlFYkp/Po1Amyy+4agNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485566; c=relaxed/simple;
	bh=++zlBheuf2ghp6IKg2VkyhrcpY1H9g9JvPugZj9lb6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ItujleHTMyDivYxde2Rv8tNb0aDPCir5ZnLrRexg+6EJb6nXSGhu43qI3mhHRZPF6ZMDvw0Yi9c7ys4YRXMEYsyqbZIyMs4AdzAuDhw4HCOHZNgsxsxFrCxbl/2+VYHjJ3YQOz+lYz9jh9TeY7mPOelI9PADTcwZC4oYkA7oaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl; spf=pass smtp.mailfrom=martijnvandeventer.nl; dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b=wQ+otXL/; arc=none smtp.client-ip=185.229.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martijnvandeventer.nl
Received: from xrossbuild.mvand.net (mail.mvand.net [185.229.52.35])
	by mail.mvand.net (Postfix) with ESMTPSA id 4E4D21FF3D;
	Thu, 13 Feb 2025 23:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=martijnvandeventer.nl; s=default; t=1739485043;
	bh=++zlBheuf2ghp6IKg2VkyhrcpY1H9g9JvPugZj9lb6c=;
	h=From:To:Cc:Subject:Date:From;
	b=wQ+otXL/AsRnI0M5Wli7eTKcR1/hhmmL/vCU/O1IhJgNCGT7hTbuBSjpI+2RlDVQ2
	 vNBKUGLbrLt7BuIbR/sr98pFGcsxJpO4V6wg7ZEfTK9x9PtOAL8a0vwBYaW0+jDfSE
	 yv3oblxoousTZWjoAWLYGD3akzcFCRTO+f5jC51/VEjvVR7dUubb0MD8Rl0fSQWVdN
	 QaXHBZkqMHh6HClJNQBSgndP8VJwIZ2HXQ2a4NZsoiEWa+ItYcVlLje011BRFs8yKe
	 6CMAAdUy04lLaOLmm2IIYfOIZefKiENDwZzArE4ADVmbMHRE6EXVPKJTX1Y2yDE8yb
	 PT6ice7j7RwIw==
From: Martijn van Deventer <linux@martijnvandeventer.nl>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: g12a: Fix kernel warnings when no display attached
Date: Thu, 13 Feb 2025 23:17:01 +0100
Message-Id: <20250213221702.606-1-linux@martijnvandeventer.nl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting SM1 or G12A boards without a dislay attached to HDMI,
the kernel shows the following warning:

[CRTC:46:meson_crtc] vblank wait timed out
WARNING: CPU: 2 PID: 265 at drivers/gpu/drm/drm_atomic_helper.c:1682 drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
CPU: 2 UID: 0 PID: 265 Comm: setfont Tainted: G         C
Tainted: [C]=CRAP
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
lr : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
Call trace:
 drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
 drm_atomic_helper_commit_tail_rpm+0x84/0xa0
 commit_tail+0xa4/0x18c
 drm_atomic_helper_commit+0x164/0x178
 drm_atomic_commit+0xb4/0xec
 drm_client_modeset_commit_atomic+0x210/0x270
 drm_client_modeset_commit_locked+0x5c/0x188
 drm_fb_helper_pan_display+0xb8/0x1d4
 fb_pan_display+0x7c/0x120
 bit_update_start+0x20/0x48
 fbcon_switch+0x418/0x54c
 el0t_64_sync+0x194/0x198

This happens when the kernel disables the unused clocks.
Sometimes this causes the boot to hang.

By (re)adding the flag CLK_IGNORE_UNUSED to the VCLK2 clocks, these
clocks will not be disabled.

This partially reverts commit b70cb1a21a54 ("clk: meson: g12a:
make VCLK2 and ENCL clock path configurable by CCF").

Fixes: b70cb1a21a54 ("clk: meson: g12a: make VCLK2 and ENCL clock path configurable by CCF").
Signed-off-by: Martijn van Deventer <linux@martijnvandeventer.nl>
---
 drivers/clk/meson/g12a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index cfffd434e998..1651898658f5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3234,7 +3234,7 @@ static struct clk_regmap g12a_vclk2_div = {
 			&g12a_vclk2_input.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_GATE,
+		.flags = CLK_SET_RATE_GATE | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3270,7 +3270,7 @@ static struct clk_regmap g12a_vclk2 = {
 		.ops = &meson_vclk_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3354,7 +3354,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3368,7 +3368,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3382,7 +3382,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
@@ -3396,7 +3396,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 	},
 };
 
-- 
2.39.2


