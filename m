Return-Path: <linux-kernel+bounces-184187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405B8CA3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6BB281685
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB3139CF8;
	Mon, 20 May 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpktOe/i"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4261D531
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239403; cv=none; b=MFplvBNJDuTEo7giP2d1RiX1X9+mPXgLxU/nwboVOYTGx1hIIXYoruuuhGLqlFIrXAJsq6ArilnanS/7GWdfP6D2eXYhHEw6vCOnm48nIsXdj+OIk70gxlR5Y1sU3Tts1/Mct/sT5xdz2VsPlqKycflgQPyXZcmOCDCSbFXOs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239403; c=relaxed/simple;
	bh=1NSUHCBmGv7pQlZ4E+vb4HVdw8WtSWyEOs4r/OAG18k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPAqBjoY6vbCwCShVbHWJ9+Id7ggmvaB/0pfh/7JE31j5O5CM2mCIxuKsuDfFKkohm2ivTb6tGaxfTLkh46nIUk9cAwisyt+ADfmAkeJShbI86zy4ucTb3o30BTTsL1LSqRRnPWay2QHJr80bW3kbn7qkkrpH0oqkwhpMAFFgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpktOe/i; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e70f6b22e2so4089571fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716239400; x=1716844200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53034YuVpVfciE/wvZdryAxloQYpHQ6ctFzAU7LweAw=;
        b=YpktOe/iTjvnMkAgJGIsKTrVsOSIRbJkHIOo54+/6lQaM51CSR06ONsycLrsVtt66A
         EEJ1HaI0QJlKR6YYbBjKJT5LYNTEMokjITZ4lOyqIARYtZeFzTk2ZC1XxBdPtHXCQEWD
         Se+moeDVWZNuTsb5iw0h5/G6e0qVg4GTS5odASprR39gBOcfbPf9CRc33PQ4jlbeu6/D
         xOdbwG/uVg8JYMZG0j4BYhkDy11WI8q0z6AIkIJwwcPOEGNlPsfB3xCJsLCvO7uQa8Ot
         VMcKoQz2Vi1gN2ek0BhMD6KbS7SewGnccy2lNIjWHgO9LB+58zk50mpoTuKaksWa4RUD
         CWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716239400; x=1716844200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53034YuVpVfciE/wvZdryAxloQYpHQ6ctFzAU7LweAw=;
        b=kevIKeebUN2T459rgMcdNfzLSSh73gTrMzArS6bFNh0JjM5oqRrMGFAM25gWPgJB5z
         k7CIkDcpoVVtMDI2zmRu5QLDs/3Hv3MiG2sCe2JfJiAVwDJHo81wPcLc/93Zf9fvxxqf
         4bZGsVLMHkbs+NE7VdR8bfCJLxjAbVhmzyeDi7k5/WEW5805upLDNmzN/nV4p8bkhcE6
         GfZgS0RuXkUr9Ur1ZDL/xL3bIj5X45iCizwjWuToYIm3MzMSBWcX6O5tDuUVONaLcVYF
         n6FQb/AuFNtSfHadboTUiCYR96MEqPUmBZWi3ksLjPEIc4tUEujBTwcQzYBbE3FXGjs7
         CIww==
X-Forwarded-Encrypted: i=1; AJvYcCXmcf7f0xmtTBFCY0KB0zKkNcvIeIiF3OZgNUj5qjsdMS1E/vqG0QBQLqeYuge7k7SS6qxk8NopHb2rB19m4wwYOOoHMWCJ60URf9HZ
X-Gm-Message-State: AOJu0YzysUuNyAW1jOBoMkhIzc68FP3tMvcFsZpZxWajMikyEXwMsyN+
	ViA4ZFjWy6CfLtGq8XOQd/Uws76qEYlgaJw7SQQbYIOlOEEFgIqY
X-Google-Smtp-Source: AGHT+IGuVINOVLSuTvcBYbUGI0Y+rtIxJJEd/lKhqREuXLWhoprXeoQAz5Txnnw7cn6iVWuH+a2Q0w==
X-Received: by 2002:a2e:b985:0:b0:2da:320a:6739 with SMTP id 38308e7fff4ca-2e51fd2d098mr142671251fa.1.1716239400333;
        Mon, 20 May 2024 14:10:00 -0700 (PDT)
Received: from workstation.localdomain ([2001:4647:930d:0:6cc8:8362:4e13:c7e4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2e4d0bbcc5fsm34781781fa.20.2024.05.20.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 14:09:59 -0700 (PDT)
From: Rino Andre Johnsen <rinoandrejohnsen@gmail.com>
To: alexander.deucher@amd.com
Cc: Rino Andre Johnsen <rinoandrejohnsen@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Add pixel encoding info to debugfs
Date: Mon, 20 May 2024 23:07:29 +0200
Message-ID: <20240520210817.9943-1-rinoandrejohnsen@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Why]
For debugging and testing purposes.

[How]
Create amdgpu_current_pixelencoding debugfs entry.
Usage: cat /sys/kernel/debug/dri/1/crtc-0/amdgpu_current_pixelencoding

Signed-off-by: Rino Andre Johnsen <rinoandrejohnsen@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 27d5c6077630..d275e5522335 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1160,6 +1160,51 @@ static int amdgpu_current_colorspace_show(struct seq_file *m, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(amdgpu_current_colorspace);
 
+/*
+ * Returns the current pixelencoding for the crtc.
+ * Example usage: cat /sys/kernel/debug/dri/0/crtc-0/amdgpu_current_pixelencoding
+ */
+static int amdgpu_current_pixelencoding_show(struct seq_file *m, void *data)
+{
+	struct drm_crtc *crtc = m->private;
+	struct drm_device *dev = crtc->dev;
+	struct dm_crtc_state *dm_crtc_state = NULL;
+	int res = -ENODEV;
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&crtc->mutex, NULL);
+	if (crtc->state == NULL)
+		goto unlock;
+
+	dm_crtc_state = to_dm_crtc_state(crtc->state);
+	if (dm_crtc_state->stream == NULL)
+		goto unlock;
+
+	switch (dm_crtc_state->stream->timing.pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		seq_puts(m, "RGB");
+		break;
+	case PIXEL_ENCODING_YCBCR422:
+		seq_puts(m, "YCBCR422");
+		break;
+	case PIXEL_ENCODING_YCBCR444:
+		seq_puts(m, "YCBCR444");
+		break;
+	case PIXEL_ENCODING_YCBCR420:
+		seq_puts(m, "YCBCR420");
+		break;
+	default:
+		goto unlock;
+	}
+	res = 0;
+
+unlock:
+	drm_modeset_unlock(&crtc->mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return res;
+}
+DEFINE_SHOW_ATTRIBUTE(amdgpu_current_pixelencoding);
 
 /*
  * Example usage:
@@ -3688,6 +3733,8 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
 			    crtc, &amdgpu_current_bpc_fops);
 	debugfs_create_file("amdgpu_current_colorspace", 0644, crtc->debugfs_entry,
 			    crtc, &amdgpu_current_colorspace_fops);
+	debugfs_create_file("amdgpu_current_pixelencoding", 0644, crtc->debugfs_entry,
+			    crtc, &amdgpu_current_pixelencoding_fops);
 }
 
 /*
-- 
2.45.1


