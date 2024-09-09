Return-Path: <linux-kernel+bounces-322101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87206972403
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F5D1C21CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53218BC31;
	Mon,  9 Sep 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTywGg9S"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68505189F50
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915252; cv=none; b=epFpfjRegBa2YAzw3qzfpBndnI1mpOKJHaU+KWcUDVb8hegE/yjcj7Kl7qtImtQEYWjnAem20KrlPuxMRDOGpD+OyxEwJDeHr2HpMZLcRusG6nV8xTbmtcy6ByHHno8lAbYLVHqodii/fR7vU2CwY2PyS8srm5st+eE2OJoayKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915252; c=relaxed/simple;
	bh=vL5o87yw2s4ssE0MHB3dz9K8j1mEOcSyfz7IPB/qipc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MikFKfzlU+YpddvrhzoX/WbMeEKXTbH4mkeBYVlozb7e3le08uvb9W1JdoA6IzMbZU5YpIvBs2oApViiQEUhu5Nw5mnoFag/x7VpTnFcnjsGKy+5KbvVhYdRyrLC5fh5iJzYLCMP8oYUdgwSE8Vcr/bbszr3teeg9EEVdoUM4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTywGg9S; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d50ac2e42dso2983881a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725915251; x=1726520051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WeKmC9FnbgEe6fOW87kQOk6OE5+Tj5Hd5JhdaW8htRU=;
        b=cTywGg9SvIDtTULXV6GeA3oc3us/peYa9Z1lL6mvreRS2belIsc/hnH7v3v+4SHiBx
         lV4VluK/meddrqan9qAjX7tJMLiXLnRAovnR6yFuvBpe4nQKQc8sx3IaSo1EVKEGWLn3
         UgReesvMi7AHTlHHvScXjEXHG1fq5VCobQULnqvvB+n2M+TXVXQSr6h2fFg78+40U08I
         nnLKPVrnFmDAO7z7dy9pgOhr3e4xZrjdLBFjnYFoqqyIScH0K6uB6F7ptQ3cJp79bIns
         URgKwWJ8hGnMCod1elyR5QSNqhCiaYYXhhYPEQoKdr58pJQKPImSKm7grDQdU/YwN4QB
         /BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915251; x=1726520051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeKmC9FnbgEe6fOW87kQOk6OE5+Tj5Hd5JhdaW8htRU=;
        b=PWSjVgGrWalidEI5U2+Im0qh+PItBklYVY93CYtAm2Ss7gQw/EdGYcf7STY7ji6QpE
         0Y95K9t3vtd9OM5KxSN08aJKdurq+6TOysb4pMa6YwLqGvOMLKB9hvYqqQWsDjvHexhL
         nhqUcYNq9torYZ0dsc1wIlR/KOidS/eER2qoTcOG37LuTB71Fj2vJ5cnY/wNYeQXb7W1
         u5iPy0hvlqnI3H80TX1TfQX+xvkOXFYzjr+mFXNFjs17Mt9wAnNjMZnsY+jE2q6hvcZf
         fe+s80eM7qtP92V7sSWptoWV/DvqJjbs+hLrIrBtJ8m/SWfWmbvlBwzbrfpp+sPD4Wlt
         fmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiQ2+GeoDN3ze9uL6JCXM8oyYWFaOy5GK5tY6w4ajZIpBaH/A4DVnTP8SBAWeXdjTVJtX0C1thXbAijD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDnZ14d/Rvndb6JhjHFMHCYvDFFFrSY6R23rhFTQWajjmqSs1
	B3XHT1itZxf0bhc9Jc5ECLgXdLCzwVi4IKUKD/MlswiijUcEqn7T9b1xikjn6W0fe3uiu3B9OzD
	+iBIDLuzLWBhyCQ==
X-Google-Smtp-Source: AGHT+IGY0VQuaZZPXhKDdZl8yMzvGLZQlqOz/QGDPNv0228X2E5wWrrJX+Bx4WbRGEMdXUp3Yh52ObY0j4U/Nsc=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:903:18f:b0:205:71f1:853f with SMTP
 id d9443c01a7336-206f051c88cmr8372105ad.5.1725915250444; Mon, 09 Sep 2024
 13:54:10 -0700 (PDT)
Date: Mon,  9 Sep 2024 20:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240909205400.3498337-1-tjmercier@google.com>
Subject: [PATCH] drm/syncobj: Fix syncobj leak in drm_syncobj_eventfd_ioctl
From: "T.J. Mercier" <tjmercier@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Xingyu Jin <xingyuj@google.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A syncobj reference is taken in drm_syncobj_find, but not released if
eventfd_ctx_fdget or kzalloc fails. Put the reference in these error
paths.

Reported-by: Xingyu Jin <xingyuj@google.com>
Fixes: c7a472297169 ("drm/syncobj: add IOCTL to register an eventfd")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/gpu/drm/drm_syncobj.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index a0e94217b511..4fcfc0b9b386 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1464,6 +1464,7 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *syncobj;
 	struct eventfd_ctx *ev_fd_ctx;
 	struct syncobj_eventfd_entry *entry;
+	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
 		return -EOPNOTSUPP;
@@ -1479,13 +1480,15 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 		return -ENOENT;
 
 	ev_fd_ctx = eventfd_ctx_fdget(args->fd);
-	if (IS_ERR(ev_fd_ctx))
-		return PTR_ERR(ev_fd_ctx);
+	if (IS_ERR(ev_fd_ctx)) {
+		ret = PTR_ERR(ev_fd_ctx);
+		goto err_fdget;
+	}
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
-		eventfd_ctx_put(ev_fd_ctx);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_kzalloc;
 	}
 	entry->syncobj = syncobj;
 	entry->ev_fd_ctx = ev_fd_ctx;
@@ -1496,6 +1499,12 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	drm_syncobj_put(syncobj);
 
 	return 0;
+
+err_kzalloc:
+	eventfd_ctx_put(ev_fd_ctx);
+err_fdget:
+	drm_syncobj_put(syncobj);
+	return ret;
 }
 
 int
-- 
2.46.0.598.g6f2099f65c-goog


