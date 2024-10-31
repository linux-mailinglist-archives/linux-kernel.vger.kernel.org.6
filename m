Return-Path: <linux-kernel+bounces-391098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97A9B82B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232451F233D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA11C9DCD;
	Thu, 31 Oct 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLO1zZu0"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FD1C4612
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399923; cv=none; b=bTShIuqf9MvznH0/H5DIoYbeTZDqwsubp1f9G6lgVP3i4/2DMOlECt8JOM1Xc44ftRHzWIAr6pUOr7O0mbOVoK2SBoh8YpQ/0iloeFRZ10wQgXvyugB6WXKjoR5QV4163xa+U4rZy+UH03RuMbBMAfk2YK2GZLEFyaaTr10V4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399923; c=relaxed/simple;
	bh=ubAUk9a/uZwLFUFVncOk2oKn0dQY9SCol2seADmFrBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dd+eN7W1mTjDScVRzdPogRnc42/nVku7g5bxDXJ5vAz5jURomkvMZe+ZjqlB830KDl2a6O+Tljc/BKGewgqmUl125g+nt58FdQs7dnZzM9AxB8pTWHQdYZUDRn1c4wNw8SaB/7tSs2tjErXKfpVUpSF9EbIdUGz0s8zD/M3QKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLO1zZu0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37f52925fc8so720637f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730399920; x=1731004720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27kCo1mR4iJmRM3zJrNqpDvOFiT8VVKtUlW/1QgXgq0=;
        b=kLO1zZu0zc0siHIcRs8TepRHsHIZeKMGW+vLn+sz2FW0IIPvTTwjFnW0QTYsOcVxMK
         xUW9pkecA3QeAAguqUdjhK5S76CZWjUk8m9+ZTl+B6bu55OkLvf8oHuN+9iP1bqajy2P
         e09pRQBA8gD2IZQT5tfnI8mU8ll2is8OhepwENCHuJ7eVNs/8kOIYZCv8/wZnKEQf/0o
         6lpxz2I3eTjWp5ug+CoNM8mG1nkUs6m47uT4pW1NHCZ7E/X31K8HMhX7tTDJ7BuUkB9c
         xwxSeCO627P1YUfRMbxre/F8OnVcchq5WVbuYwRb0P41lGtIEjDHuz+kdY1daW5/v6en
         YOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730399920; x=1731004720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27kCo1mR4iJmRM3zJrNqpDvOFiT8VVKtUlW/1QgXgq0=;
        b=a7GVBD8t2TM4o1jrk+Tr4RDajK4mYsfxLMsxinpydrRU3IzagD/oTlVpC8Qgc+Sjeo
         4FG0nLXVWTzxn8AEoWUuVVhLqcdFCIFRXHdxaVUSDcLqwoIW8eDXOU9IXTQ+hm1ojNGB
         WrhHY8ULjw7N3l5CDIHEAyF5j4llzHmr6Lb/OFFtwF6RwCU81WAxCyFb0Va74dL6Y+5D
         u8YXqNLcYjeZyHv4Q+kCE87RBMJiDAqChvRsrYRLDuR8Y4P1gBMZJyPrquWUjx/7bQcn
         WjmOzU3xZ8egcAoJEL1S+oZXyU1BEb9EUYaFQrTragALUv9iJFKwNIKALfgFQif/8KzH
         BXFw==
X-Forwarded-Encrypted: i=1; AJvYcCUGi4exWlaU+xn0qhmAe2KDOIhaPt1PYv4thq9j7wjSS8RFqOQ/30DNO2I9pNU/wQpQKiyQ38uqN6m4X2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VmMpvXjCbskEmR32bXHS8v1lDZNrUJb5fFzCrNPeIgXPnwJr
	zdNqCbGt/+TnXVH/1sTk6NHpBJmPT+GkJ6KLcyVz5h2NZBEN3glf
X-Google-Smtp-Source: AGHT+IFiaoyewmrju5yI7tATCE5NVdZwpDz1t6VbsmauInkDV3+XBSdCXBMl4Glx/g5ldfJR3Ucf2Q==
X-Received: by 2002:a5d:59a7:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-381c7a6d60emr737043f8f.34.1730399919476;
        Thu, 31 Oct 2024 11:38:39 -0700 (PDT)
Received: from fedora.. ([94.73.38.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm2864049f8f.112.2024.10.31.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 11:38:39 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: Drop unnecessary call to drm_crtc_cleanup()
Date: Thu, 31 Oct 2024 19:38:35 +0100
Message-ID: <20241031183835.3633-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CRTC creation uses drmm_crtc_init_with_planes(), which automatically
handles cleanup. However, an unnecessary call to drm_crtc_cleanup() is
still present in the vkms_output_init() error path.

Fixes: 99cc528ebe92 ("drm/vkms: Use drmm_crtc_init_with_planes()")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 0a5a185aa0b0..25a99fde126c 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 				 DRM_MODE_CONNECTOR_VIRTUAL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
-		goto err_connector;
+		return ret;
 	}
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
@@ -131,8 +131,5 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 err_encoder:
 	drm_connector_cleanup(connector);
 
-err_connector:
-	drm_crtc_cleanup(crtc);
-
 	return ret;
 }
-- 
2.47.0


