Return-Path: <linux-kernel+bounces-182932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FD8C91DF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080371C20A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8F4D5A2;
	Sat, 18 May 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ir0uKV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44B43AA4
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716056968; cv=none; b=FlR3Gih2iCxiLrIJCk0LL73cH6h7LkRwtAJYA1JqLbuUADGuHxeY6fdy2prfWS78uhd1xnpq88ZcAvJW8jyFUbiwWQLcUfOYovRNRkg2FG8QWWB2a8CDLKAIhbC/zVdrEk+7xqOGkSQ2G7jDSUmvD8nyrHasrNYvZ1zXLcr6Ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716056968; c=relaxed/simple;
	bh=mZ+9BwD7al5hfRfca2Ba5G+6wZ0QhXCkQvHVYE3Gj38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tq7JEyr5usFNoOUNQbqHZDkGgPsa8DXU4pFWOkqQ4nzRCgJ1HTjNdvqKtpQbLSoOigzuJTKEZnalCFwx1rt8W7jwKYMbe9ZIUDr5SYEi3l+GmcKGTFD+i0dgb6/XExIpiS2Jb+Aibkj4hnTWdL/ZSCaH6VJUqAaDUYTgIiz0GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ir0uKV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed904c2280so34787345ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716056966; x=1716661766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JiRUq85Ly6zqWge3zqGsIH/ckCQ3+fLPP5hj7FWXBBU=;
        b=T3ir0uKVBFKmHKF3RoXvaLJGkf9sbs9DiazV5C1Hv+BaNo/i9eFPk0uYGSjfXPJHH8
         gHo+YauB0T/u0AyhbnipW8mJyf2zcffjvJU2k1O3cC3m2cJg6qSDZQrcaO569ntfwe0f
         tEYwvPH4g9biHbAr+/FgoHIcER44iAEsn6aLuB1SQirXtKzMF8WNY7yRIOFe8+vWMksn
         cupzPfbkumjFnjmO4j0ToUgFVQ3VoscvGMV61XadPS4mBLelX+ochJUKxtR7Et3Ap9ZR
         O/cZY37zXdzQqmmkvOctFni92Otsoul02qAZ150rU1L0Odd/T1/c/CKCrjPLy7a/IlvT
         G3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716056966; x=1716661766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiRUq85Ly6zqWge3zqGsIH/ckCQ3+fLPP5hj7FWXBBU=;
        b=IQ61LagCKn8JGFmlcbKU5PhKPMhERC25/CESQ8rzNJltUEmYmXUTK6AOean47KCNgd
         ZJ3Zk7ROW0i0VK816BJyLUW/ML6V8vvq2DOv8W0vTOQHaSyMsWNqCd+ne2ASxyOdoabI
         tRboXz8cGrH8tRvPmVOq4uxGIBPjtWQg8V4583TOiCgJkH6pmDtiFJBkyMbec5aNjKM8
         O2DDD8mb/HJNv71T01Q+bKvlzFvedBpCRpPIBWlQVlHnfGCS2akipkGID9L27MmKGUy+
         rgHwN9dF/pD3JHMrNEZuL/p2uWoIA3wOe6iXMb42T/3hYQaiXIvOJ0jtMf9s9h2P5NHU
         63KA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIYNT7/8Bh3NPOhPJorIdIXiRjlsWW0EdVpRoS78T6A8aFRiIeXqBpzvxsj+6J0jz5QgNGLD7teWc/U58Xyy3og6PZZskrO+tki9s
X-Gm-Message-State: AOJu0YxLIWBbm1M1Prvlzo0hJoWSUKj3H8Rjw++srt3mlx+FvNB2q+nq
	TZ+P+d96+1jPbw7MwM76hFa/u+xrZqQ0jRlRC1+ql97Hy3DMNrVl
X-Google-Smtp-Source: AGHT+IHrchQFBqcCRziDIkRqhjVokcfHXnTHGOpiDCIh9oIqWZpJHQZ6+lBwn2M5/178hOdM1GGESw==
X-Received: by 2002:a17:902:fc45:b0:1eb:1d30:64b5 with SMTP id d9443c01a7336-1ef43d170ddmr319568685ad.19.1716056966303;
        Sat, 18 May 2024 11:29:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm176922435ad.68.2024.05.18.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 11:29:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: David Airlie <airlied@gmail.com>
Cc: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Danilo Krummrich <dakr@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] drm/nouveau/nvif: Avoid build error due to potential integer overflows
Date: Sat, 18 May 2024 11:29:23 -0700
Message-Id: <20240518182923.1217111-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to build parisc:allmodconfig with gcc 12.x or later results
in the following build error.

drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_mthd':
drivers/gpu/drm/nouveau/nvif/object.c:161:9: error:
	'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
  161 |         memcpy(data, args->mthd.data, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_ctor':
drivers/gpu/drm/nouveau/nvif/object.c:298:17: error:
	'memcpy' accessing 4294967240 or more bytes at offsets 0 and 56 overlaps 6442450833 bytes at offset -2147483593 [-Werror=restrict]
  298 |                 memcpy(data, args->new.data, size);

gcc assumes that 'sizeof(*args) + size' can overflow, which would result
in the problem.

The problem is not new, only it is now no longer a warning but an error
since W=1 has been enabled for the drm subsystem and since Werror is
enabled for test builds.

Rearrange arithmetic and use check_add_overflow() for validating the
allocation size to avoid the overflow.

Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use check_add_overflow() to calculate the allocation size and to check
    for overflows.

 drivers/gpu/drm/nouveau/nvif/object.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
index 4d1aaee8fe15..89a812f812af 100644
--- a/drivers/gpu/drm/nouveau/nvif/object.c
+++ b/drivers/gpu/drm/nouveau/nvif/object.c
@@ -142,11 +142,15 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
 		struct nvif_ioctl_v0 ioctl;
 		struct nvif_ioctl_mthd_v0 mthd;
 	} *args;
+	u32 args_size;
 	u8 stack[128];
 	int ret;
 
-	if (sizeof(*args) + size > sizeof(stack)) {
-		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
+	if (check_add_overflow(sizeof(*args), size, &args_size))
+		return -ENOMEM;
+
+	if (args_size > sizeof(stack)) {
+		if (!(args = kmalloc(args_size, GFP_KERNEL)))
 			return -ENOMEM;
 	} else {
 		args = (void *)stack;
@@ -157,7 +161,7 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
 	args->mthd.method = mthd;
 
 	memcpy(args->mthd.data, data, size);
-	ret = nvif_object_ioctl(object, args, sizeof(*args) + size, NULL);
+	ret = nvif_object_ioctl(object, args, args_size, NULL);
 	memcpy(data, args->mthd.data, size);
 	if (args != (void *)stack)
 		kfree(args);
@@ -276,7 +280,14 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
 	object->map.size = 0;
 
 	if (parent) {
-		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {
+		u32 args_size;
+
+		if (check_add_overflow(sizeof(*args), size, &args_size)) {
+			nvif_object_dtor(object);
+			return -ENOMEM;
+		}
+
+		if (!(args = kmalloc(args_size, GFP_KERNEL))) {
 			nvif_object_dtor(object);
 			return -ENOMEM;
 		}
@@ -293,8 +304,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
 		args->new.oclass = oclass;
 
 		memcpy(args->new.data, data, size);
-		ret = nvif_object_ioctl(parent, args, sizeof(*args) + size,
-					&object->priv);
+		ret = nvif_object_ioctl(parent, args, args_size, &object->priv);
 		memcpy(data, args->new.data, size);
 		kfree(args);
 		if (ret == 0)
-- 
2.39.2


