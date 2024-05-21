Return-Path: <linux-kernel+bounces-184499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7478CA791
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695DB1F211C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA42EB1D;
	Tue, 21 May 2024 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw6lzc8U"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877362E85E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268349; cv=none; b=gDdwuC6E4jN4pOeBhLoKv+KDoKwtrlyWJz9X6BMgaPrMQZumorVDB5oHmCgxpidhh0zlpzrbML1yA8UyE7ylj9zF+ta5f/ooLHWjn7ORctUB/MuCV4azu8sLfhk6NcA8Ib8lzONKUd30PUNZNlBi3Yb5I3TmIStd0zSojZjcitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268349; c=relaxed/simple;
	bh=DJcQJid1iwq86SYshDjjvgo7lJTAqL3J+xs5+ZhIU/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNd2Y5sXJLom8ijXUCouZJCN8BhAVPLIv/tsUSlO12/6DE8Y8S6DLYywaRJOem+GG9jXJfwjkuTwYLHbaCMPumUR+j3Ig29q90jRXaYVM0V1JiNltcrjY8UV5p9HTN+mKbl0/dFldaVDCN6jPgPmaCXvXjIVW2+CsiYNAX/wtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw6lzc8U; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e2da49e86bso5936441fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716268346; x=1716873146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUapn7dPFkmrdlk6ElpkaCznwDwGsC/allixWXQKesY=;
        b=Yw6lzc8UawtHbKelfELy31eKj6XJwJBG7BoaI36fccQ9oaBlXRhuIxEIWV00bCwwQZ
         +ZLTMoPf+QIe3/fyk4hGyg0sE0iafH97Ir8aBS2h9yN0gnJxDRRWW8btH7xeeL8BYzIY
         U+ZqlejFx5c319g0vHJD8Ed2BcUJenD22oG1b8LPiZrfD5UOPkdgYZBQExuel5ySdVqU
         75ciI9F4IZHZpgV0yE3+7yNfww9tFqWvSOvseTRV0xCLXLfoHqvLso3ZJQDykyrQBysL
         YX78DRmEAffM+Uy+iD2cD9JIn8nVEowPRjOcCGToGZIzfZjyxQ+VRpbkgA+TPOEqsRa1
         EZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716268346; x=1716873146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUapn7dPFkmrdlk6ElpkaCznwDwGsC/allixWXQKesY=;
        b=AyE800LEfVk8V4KbXwQkcR/mfAqXyS/z1UBUnP+1fdPnycvEWuM7fXwrF731HLvns3
         LkcN1t10BL19A14ubsv/xMT1891263sk6VmjoOs92VkJoLCAEoDljFHR9HJgA+T+vZtn
         N7wiVLuuMztqBWTK1/dmmAR1NrTqU3R9txfhckbO7EZ+kBIw4nyw+R2nzMeg9Iv/MQWN
         ww4omG+NQcAMNmVJL3uC0rLPDo4RiNdOcR5Gy63wzPcOT8raA0zBCEUyQQ8/VTiQQU9C
         C9OF2stT3H67jmsWRW6cNabh/c7i0tVb0WbbLNhjyPvqIVjgYPwVmDJkXnR91fi7/LAt
         5ijg==
X-Forwarded-Encrypted: i=1; AJvYcCW8QvUwf+K8GqfJk/MwsQLGBKrayE7ncaNnBNzzOajex/ind/qVtZ1bX/s1aIWGSRT5FL3JF7Xym6zKyQ4DeobVLkZNxeTleWo+nlqg
X-Gm-Message-State: AOJu0YyXIRIIoLzfYqY2habMqlKv4ASUmGG6Jd/OvZuMwJPCaEVWQs6j
	+YeILOt4kAlN439RHENzG+wkfq751gafnCfesmZpIhqVBN2tRCsp
X-Google-Smtp-Source: AGHT+IE2K6Julfu2AI4B9GNwgJRleFux2hV74ux3F8eePubIgAX73mqeQXyDMoHW0hxgc0awiuq59g==
X-Received: by 2002:a2e:a1ca:0:b0:2e5:67a7:dda7 with SMTP id 38308e7fff4ca-2e567a7df67mr201821891fa.3.1716268345399;
        Mon, 20 May 2024 22:12:25 -0700 (PDT)
Received: from workstation.localdomain ([2001:4647:930d:0:6cc8:8362:4e13:c7e4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2e4d0ef09ffsm35540931fa.59.2024.05.20.22.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 22:12:24 -0700 (PDT)
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
	Hersen Wu <hersenxs.wu@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Add pixel encoding info to debugfs
Date: Tue, 21 May 2024 07:11:23 +0200
Message-ID: <20240521051140.30509-1-rinoandrejohnsen@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com>
References: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com>
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

Changes in v2:
1. Do not initialize dm_crtc_state to NULL.
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 27d5c6077630..4254d4a4b56b 100644
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
+	struct dm_crtc_state *dm_crtc_state;
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


