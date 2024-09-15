Return-Path: <linux-kernel+bounces-329956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2579797F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6276F281C50
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412DA1C9DD7;
	Sun, 15 Sep 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="BUkaGEHp"
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CC18B04
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726422071; cv=none; b=Y7y/lUo8op/i1fP9DcgTXbEwgernzDKOV30tdrS51pkNTe8GN4DmFs//6TobyE5YMtHJi/fMh9Np0V71QPGIDe3N09PNpJmt35qiW5nkOJjstqNNX3H8PoaIHT4Nt+QcGGyhO4NZCcovxTna6JY33MQhbY0Rrm5PfSE2bAa6opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726422071; c=relaxed/simple;
	bh=AWlzurw8TjVSJHL81PnGiT03F3c0KZ6Bu9J4LY1ExbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UB33NYscyNa4ffWEChdqng8Xm/CTLuBsveizLCSWcIOgO+8NaLws0UQYIGjSYTZtrZUqn2zw4zHFWjqAo+JC3Z+YDdzKAeyrhPEkcRmMJc0gjd07HstsJuPQDGy+sKZ/kBdfPfF0EPSZWzke2G/U2VwwuHMGTGHWBZvZtQQ8Ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=BUkaGEHp; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=AWlzurw8TjVSJHL81PnGiT03F3c0KZ6Bu9J4LY1ExbA=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=BUkaGEHpVeR+imcr5SkWnflzoRg5liO3N7CvuAJEVGFMDlxP3VUuzrA5YLKmJF1OiJ/2ooQbAsr
	rtvjcZWfiWvJSqX2Gu5hJycCU3lIJmw/wotEe791xvLeZ+ixWC8ZW9tL2GJZkWgBWpcjOzpGLBjm4
	7jgxOm+0pzLa25mzTOs=
Received: from [194.9.26.89] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 130329; Sun, 15 Sep 2024 20:40:54 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	Jake Wang <haonan.wang2@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Swapnil Patel <swapnil.patel@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	lvc-patches@linuxtesting.org
Subject: [PATCH] drm/amd/display: Add NULL check for panel_cntl in dce110_edp_backlight_control
Date: Sun, 15 Sep 2024 20:40:50 +0300
Message-Id: <20240915174050.78956-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If link->panel_cntl is NULL, the function dce110_edp_backlight_control
attempts to dereference it at line 1019, leading to a potential NULL
pointer dereference and a kernel crash.

This bug can manifest when the eDP panel is not correctly configured
or initialized during certain power or display state transitions,
leaving link->panel_cntl unset or NULL. In such cases, the dereference
of a NULL pointer can result in an immediate kernel panic or
system instability.

Add a NULL check for link->panel_cntl before using it. Ensure that
the function safely returns if link->panel_cntl is not properly set,
preventing any attempts to dereference a NULL pointer and avoiding
potential crashes.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 06ddcee49a35 ("drm/amd/display: Added multi instance support for panel control")
Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 508f5fe26848..1269628a4014 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1016,32 +1016,34 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	panel_instance = link->panel_cntl->inst;
+	if (link->panel_cntl) {
+		panel_instance = link->panel_cntl->inst;
 
-	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
-		if (!link->dc->config.edp_no_power_sequencing)
-		/*
-		 * Sometimes, DP receiver chip power-controlled externally by an
-		 * Embedded Controller could be treated and used as eDP,
-		 * if it drives mobile display. In this case,
-		 * we shouldn't be doing power-sequencing, hence we can skip
-		 * waiting for T7-ready.
-		 */
-			edp_receiver_ready_T7(link);
-		else
-			DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
-	}
+		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
+			if (!link->dc->config.edp_no_power_sequencing)
+				/*
+				 * Sometimes, DP receiver chip power-controlled externally by an
+				 * Embedded Controller could be treated and used as eDP,
+				 * if it drives mobile display. In this case,
+				 * we shouldn't be doing power-sequencing, hence we can skip
+				 * waiting for T7-ready.
+				 */
+				edp_receiver_ready_T7(link);
+			else
+				DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
+		}
 
-	if (ctx->dc->ctx->dmub_srv &&
-			ctx->dc->debug.dmub_command_table) {
-		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
-			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-					LVTMA_CONTROL_LCD_BLON,
-					panel_instance);
-		else
-			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance);
+		if (ctx->dc->ctx->dmub_srv &&
+				ctx->dc->debug.dmub_command_table) {
+			if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
+				ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_LCD_BLON,
+						panel_instance);
+			else
+				ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_LCD_BLOFF,
+						panel_instance);
+		}
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
-- 
2.39.3 (Apple Git-146)


