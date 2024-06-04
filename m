Return-Path: <linux-kernel+bounces-200431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18868FAFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C49B213F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC241A286;
	Tue,  4 Jun 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mBYUVo5C"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35C1448E5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497576; cv=none; b=AEUaTlnHTXngXrGIQcLbELi3+KvTupOxOOHo3bBrV5WAReIdi8Ir1VCA3VfqhNIFJIysqGiG2/CyEsI4hCZCl/9flXFCNK1vA5cGOEuL0BOpKTsjyL7G4Ifv/5vtjNWYZx/mAlGOI4BdTQCneAXY34gHlFO0NLSRceiREwcuMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497576; c=relaxed/simple;
	bh=uu24MvOLTSDrGtaB+9R342Vu+OPQ+6CL46IPrj7xBmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TM5dZ9imbOk/LGLuS1+8ejQwRZjEVGUkGkKlBWNnVGqYPvzQsGfYJ/MMt3Thw8+Sy9HSnX+fMvtaAv6hcNmkPfOCHqDcWxx93H58Grx/SgeJTjjHsOeIMskjhKgvKpBAFtM80/ja06uUnLYxWl4FjQ3tAWYhe6MM4g+uFRZN2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mBYUVo5C; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b82d57963so5574260e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717497573; x=1718102373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3WCRRHJvbBRghgXSmEq8Fvp6W4aBxQB8LzjGg3Uzwg=;
        b=mBYUVo5Ct93Uq26UPw1rezUJjqoTI+XXq3Mb1DucQW6m89GHybK0883G46qyk4Ynxw
         +kuW2KVGNPqyWNHMkldH8dWzmkji+70uvw/ovynX/oI6R2fq2IGtOH0S77pJ6ZdPlEIA
         USvnHUF3VpCdFiPFYCwefYhUoPyB4EKd0gRxvyX3wXaCHH57Vt755zoglBeC4z3JglOg
         fLt5I7VbceLe5Jcs3PCOSxr3+MiOIw9FrXlEOO6t5y59F2x9BRBTO8S/iMAjRVpNJeiC
         MYx3876F20BR+AsDs7z4nzrYYcYCKYlDEdCSWjbs6Oz+GuxsZLuXcDglR8hWZBCIjfd1
         YUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717497573; x=1718102373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3WCRRHJvbBRghgXSmEq8Fvp6W4aBxQB8LzjGg3Uzwg=;
        b=c2LnfFMKi/8X7q3yVBZE5ZK+zsiOzHJQhlHCUCeGwVdNGRuDIVHxWyqN24f47YlPtP
         mDeQU1FmZ2FrZ/sYBN7CQhkBBqoG2CMdtQMPMbyF5sPbtCcdUkihu5WIkTyCrU36GByy
         HoYkkJpOBYWeLTtpupiOiaWzLPvNk/1OEmFeVU7K13DcdV1H2TyZQh+o/jLyNs4nYo65
         AS2RsP2I/rmAHS8geUum9LNLGkTbO7/qzQukJ1VnIoXrquVHR6aAS8R89+pFHdcRCAyr
         1zR0kN9vs8rrd5BDKlGe2xRtatfPKTmtROcxrIxBujRT9i5GiFQPL7z5G2ARf95mF7I5
         MCtg==
X-Forwarded-Encrypted: i=1; AJvYcCXtBE/y33ouAjlXtTGRDGaPZlVIGU+tmyh96FOknFwPq/i+tL4xuv8E42RY2+gujjcv3W5VnHpVoJIEhLUMCQ3FJr3XRNGkR/1D4z2x
X-Gm-Message-State: AOJu0YxVmyz1fa1ZRatAiYxzEpNptwVykp+pt4ceekzqy8BnvGvDFimy
	bnrW8NFhEqBGwRyeX9180cNIeJpc37ULcRfycP57KuSrveU94+qhKUn+ujb3WlU=
X-Google-Smtp-Source: AGHT+IETd4msXoxRl+ud5mCwMFNofqwpac+oO3fwbkx5DB7asjTWSlI02keQuaJBEBR7nsu+b/81Pg==
X-Received: by 2002:a05:651c:1991:b0:2d8:930c:bbfa with SMTP id 38308e7fff4ca-2ea950c5fafmr91095041fa.5.1717497572574;
        Tue, 04 Jun 2024 03:39:32 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84be78sm149457245e9.17.2024.06.04.03.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:39:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	daniel@ffwll.ch
Cc: Qingqing.Zhuo@amd.com,
	roman.li@amd.com,
	hersenxs.wu@amd.com,
	chaitanya.dhere@amd.com,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	sungkim@amd.com,
	syed.hassan@amd.com,
	syedsaaem.rizvi@amd.com,
	dillon.varone@amd.com,
	charlene.liu@amd.com,
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	jerry.zuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/amd/display: Simplify if conditions
Date: Tue,  4 Jun 2024 12:37:37 +0200
Message-Id: <20240604103736.3068-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if conditions !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warnings reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B
	WARNING !A || A && B is equivalent to !A || B
	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 +++---
 .../gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index ad2a6b4769fe..940081df6dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -68,7 +68,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
 				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+					(!is_plane_duplicate || (j == plane_index))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -707,8 +707,8 @@ static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_stat
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
 			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
-			(!is_plane_duplicate || (is_plane_duplicate &&
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index)) &&
+			(!is_plane_duplicate ||
+			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index) &&
 			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index a41812598ce8..b2bbf7988f92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -979,7 +979,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *conte
 		if (context->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
 				if (context->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+					(!is_plane_duplicate || (j == plane_index))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
-- 
2.39.2


