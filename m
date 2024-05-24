Return-Path: <linux-kernel+bounces-188748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD948CE64F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589161C218C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026D8624B;
	Fri, 24 May 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7bIi0zj"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7AF18E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558502; cv=none; b=es/DRQNal1s+4SO+FcIbGst1IDm+qopbyzdmNXSThhRfhqHMlFhjT3mB4ffxUyKKXIe+TkHe7+UAiaCTyv2vQdYizTn8KsCChWaAnLXsertr7aEtqNEUc39i1r4EfqxQ1hxMvZnLjR9zMKHMOZTKiL7D2r4z74dX4xWql6c4xwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558502; c=relaxed/simple;
	bh=w3dR26NbGjOlarZLz5MR7N8wajh4hdLjcuJC80SA6/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1otPIBOErEkbdJQ1xXsw1o+89XtDbax196arct6mPX+YSQZfU+lvmUNV48REVBu9zlqVcRgBRd5FtIP2aoAQwarJ9i/Qx/CZFtze4jDOzn5eU4pNpJtPmoGPuaZy94NFFnheWTuzgLb2rab1FYtPh8+QwyyhcLURiadPFEEisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7bIi0zj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso3264453b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558500; x=1717163300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YIEeY0+RnmZng19NXAwQF+NfGbhg49taanreXH5yL+8=;
        b=B7bIi0zjT5ypSZnouGciZJ+Hn4rzJSfKOt+ZYxrh0+dj7ilIu5A+0mvASNwReMMHmg
         Bi/930raFEiVmQKIeL+MWZylmYbXjiPLDpPGKslC5uGyVJRXx2ZehXbeaBt+oH7BnRVm
         btb4L2MF29+370pfyZ/7iM6gwrTWI7jPoHPu+DrzD/gWmZC6hnIDuYa6pZ2m794W4dW7
         zf78VCXYjjJiBevjLag/Wbwqeeq37/Snnm/HvypypnfZma7XsTXJUUQP6GPj4lvXOPYM
         fzSm/9LTaojehZXGZUZ6YeCsdzMZ+eyoAoWs3W2ES/yWtc6OMDNKCaUx2l3FF+YsGWvT
         tDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558500; x=1717163300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIEeY0+RnmZng19NXAwQF+NfGbhg49taanreXH5yL+8=;
        b=FFh3fdjKTGh2PkMdEDtu+8y9fP9vQkSD5JPF6fdRuv6mNjjgQ/PAVP73R4FSfSAIBX
         X3AHeOxRKpklrMUdulTvVcN6RaVVHHOCe0l7FpRVS6hugq2XiyoaBPyb1k6hUmu+BQlK
         5IjNS/kiFIjaVts8eGg11CZfSFr7HecamXvcg7Cr5FyrH/IOAC+S0AdApSwJt5tAI195
         DYvD/Y0ZNPefC+tamD9c8eqdZlHX2mzs+ujKYuo6tzkdaeXmnM3dVa5f/cArBQMjw1UP
         xUyu8NKIJl0avsoXCJw1LxEbeJ5wNTRM9PzhlDu/kvz4oPC7tsJCIX4OaNy6ly8v7h1/
         23Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUFLfUJ0A7S+fhYx56oUJ8XyXGNWuQRidI1Ec5pafMQHtBPU+4hLUm51HGNBW9ib4WmAccLaqCc5pmktV/Edgtk9FXqY4omdKoF1sXr
X-Gm-Message-State: AOJu0Yy2VUFv6eg4jcs5yNpwvdv137WnIRPmlsJ1z3KgCShzcON+pT68
	AEnVRVgsGXNVawnwQ4OMQq2ewHQqMTEWTmw0VUGPB7G62Qb3Q3Yk
X-Google-Smtp-Source: AGHT+IGhbkcGjUJbmZJcY4isvA2oPLb6egvbHqqkkHxWAtES97h4D4AL7LJBpaP2EFezAAdNct+Ivw==
X-Received: by 2002:a05:6a20:9707:b0:1b0:2cae:4622 with SMTP id adf61e73a8af0-1b212f0ea28mr2312580637.42.1716558499737;
        Fri, 24 May 2024 06:48:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb14asm1121660b3a.118.2024.05.24.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:48:19 -0700 (PDT)
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Joe Perches <joe@perches.com>
Subject: [PATCH v3] drm/nouveau/nvif: Avoid build error due to potential integer overflows
Date: Fri, 24 May 2024 06:48:17 -0700
Message-Id: <20240524134817.1369993-1-linux@roeck-us.net>
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
allocation size to avoid the overflow. While at it, split assignments
out of if conditions.

Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Joe Perches <joe@perches.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Split assignments from if conditions.
v2: Use check_add_overflow() to calculate the allocation size and to check
    for overflows.

 drivers/gpu/drm/nouveau/nvif/object.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
index 4d1aaee8fe15..1d19c87eaec1 100644
--- a/drivers/gpu/drm/nouveau/nvif/object.c
+++ b/drivers/gpu/drm/nouveau/nvif/object.c
@@ -142,11 +142,16 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
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
+		args = kmalloc(args_size, GFP_KERNEL);
+		if (!args)
 			return -ENOMEM;
 	} else {
 		args = (void *)stack;
@@ -157,7 +162,7 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
 	args->mthd.method = mthd;
 
 	memcpy(args->mthd.data, data, size);
-	ret = nvif_object_ioctl(object, args, sizeof(*args) + size, NULL);
+	ret = nvif_object_ioctl(object, args, args_size, NULL);
 	memcpy(data, args->mthd.data, size);
 	if (args != (void *)stack)
 		kfree(args);
@@ -276,7 +281,15 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
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
+		args = kmalloc(args_size, GFP_KERNEL);
+		if (!args) {
 			nvif_object_dtor(object);
 			return -ENOMEM;
 		}
@@ -293,8 +306,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
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


