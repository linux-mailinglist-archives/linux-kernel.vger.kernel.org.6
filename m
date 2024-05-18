Return-Path: <linux-kernel+bounces-182895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2A8C9173
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEB7B213E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97883F9CC;
	Sat, 18 May 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpYoODkd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BE125CC
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716043068; cv=none; b=rM4ikVBNMhU1UCO1LLNFmlai2z7k87PWL8GyWVDeeJmdY9UxEmtasT8olrE+7BhuiDsxQmAdpSWxnpkDldxnqo1lKr4b9oa1wzoCRkbZ8UJt43k0E7idVXwd5huS38qu2OWxgsz7JwtQICEri2zim8MqXSEEuHWx0TIPDgxDQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716043068; c=relaxed/simple;
	bh=7OkjQ0L79LzNPtTFobFn/mgjZvvIp7YvqAVVik9RRyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vGCR9VAunjEYQddgZiyyFSCxqT0+zTr79np9OhzBZH+WgaYtpAl249EtrfplED0NR/T9yCB51aowSBI9N/xsyb22d3guldI2P5eh3KpUsBRgNLb+9275HhZOX8HRtl2svLXTSMe76IY/g55zb1KeA4cbEZCaYeqFToRFc0rv8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpYoODkd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eeabda8590so33978745ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716043066; x=1716647866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FKsSBBFxiA0ly77raLTlMP1yScB2JsDo1G9Qw1p73GY=;
        b=CpYoODkdcrK2h/AACWuDxz1ff2r/8CyLzHluQ5PY3u5AbspK+bn8HLvjnpX7aZlF0T
         1swHtjnK3y03Cm0cA6jUAQxfP2ix9Txn5u/nw10rkK5IR7stFSlRDcv3LWsqdoAFH3hx
         osUHgbDdIY0cDoEoAYzZ0cbTlLlJHfx16Dx/EbwYIAA7RbR6hfAG5t1djR5Q3XMT3IMj
         /iPvfD4jF4RwVo+sa6m54A2Z3BAudZkicqvf1tMc4X4OD+YQhCU0YnvB0drdcilkXVOR
         Zwp7+h18Rt2MGDxEoizue6kA9oe4Z4bWRUvBrt9CLqXvW4TkIKeFkcRZde9zMivzSRJ+
         mFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716043066; x=1716647866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKsSBBFxiA0ly77raLTlMP1yScB2JsDo1G9Qw1p73GY=;
        b=aDK3i7mxDtfw6HKg8g9L1J0EKE++PzIHxD5tbnc/v2jv4K2p3oY8qLSorxMZ0hPM0j
         wrQLG/oMi738sn+bF90a2ClQmJ9l8JWJ/pddX17hQ3m45pAJj84fOH9GGvO5BnEJzlSa
         qTLhzsj9CDL7mEtPUtQu8CrBuga30+Ayabk8R1Mto4HnjyGdOcE0wmdiJDWp3eu+EIuu
         oeBffrBeduVcvlAz+BerVJhac7GTiMPJ2nHPPfFqD2jJaY/TQeoPW+YMAV7OGDlR0uV5
         hOuPdI2X9uJheQZRDtaeYIYwgYvx6juozBnn7sePqOfkdkrLL5uktxJlJRvZcb8adOgG
         4IAA==
X-Forwarded-Encrypted: i=1; AJvYcCW2cw8Hbq5hxvoCZAZ/ou6K7Xufo3Lw0fsZVGeBX/pMfPG8Rw4jMbsqBo73P1Pfikx5BlFS+OPiRxQv/J83Iln+PveuWFH/9VxUonMY
X-Gm-Message-State: AOJu0YwyAPrKdacmKS/DwndS6Kv8M8bDK7QtoJpUIiM7VDEt4RIXj13y
	9i0kgGmdV9AS+9Hjd1kU+IhoqWevugT2th67CD7nyAZ9H9unku1q
X-Google-Smtp-Source: AGHT+IEU3d5YrWonxdjaRa3pMlUejZK6T/8P9yb9msWLq7aHGLOolYZGTo5U9Gm+a0ELvmk9ix2KMA==
X-Received: by 2002:a17:902:ecd2:b0:1e3:cf2b:7151 with SMTP id d9443c01a7336-1ef441a6e2cmr283064855ad.59.1716043066561;
        Sat, 18 May 2024 07:37:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bbde9d7sm178417435ad.106.2024.05.18.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 07:37:45 -0700 (PDT)
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
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] drm/nouveau/nvif: Avoid build error due to potential integer overflows
Date: Sat, 18 May 2024 07:37:43 -0700
Message-Id: <20240518143743.313872-1-linux@roeck-us.net>
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

The problem is not new, only it is now no longer a warning but an error since W=1
has been enabled for the drm subsystem and since Werror is enabled for test builds.

Rearrange arithmetic and add extra size checks to avoid the overflow.

Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
checkpatch complains about the line length in the description and the (pre-existing)
assignlemts in if conditions, but I did not want to split lines in the description
or rearrange the code further.

I don't know why I only see the problem with parisc builds (at least so far).

 drivers/gpu/drm/nouveau/nvif/object.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
index 4d1aaee8fe15..baf623a48874 100644
--- a/drivers/gpu/drm/nouveau/nvif/object.c
+++ b/drivers/gpu/drm/nouveau/nvif/object.c
@@ -145,8 +145,9 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
 	u8 stack[128];
 	int ret;
 
-	if (sizeof(*args) + size > sizeof(stack)) {
-		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
+	if (size > sizeof(stack) - sizeof(*args)) {
+		if (size > INT_MAX ||
+		    !(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
 			return -ENOMEM;
 	} else {
 		args = (void *)stack;
@@ -276,7 +277,8 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
 	object->map.size = 0;
 
 	if (parent) {
-		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {
+		if (size > INT_MAX ||
+		    !(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {
 			nvif_object_dtor(object);
 			return -ENOMEM;
 		}
-- 
2.39.2


