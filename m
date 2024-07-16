Return-Path: <linux-kernel+bounces-254298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436693318D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD3F1F25C21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655631AC435;
	Tue, 16 Jul 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjBuM3Ij"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563801AC245;
	Tue, 16 Jul 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156363; cv=none; b=QoDMUAi5YlfCarYdX1izki7SpHLdPNXlGLenyaXxh6STEsmu1w9Gb4aUESElMKvkYPYPytLJiv6LZGarLL6yzeWC1uqLa8C+T2BbXIvmDkWnWJR6cZfPxNa4WzwmE/H9a/uEfq4AR3VusJBu0EA1w//vxc0OaftClZJDtaSMjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156363; c=relaxed/simple;
	bh=iX3YPrehKsc8JYsY/MYFOXIO6YJ0coOili+oIW2ckmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnJ4lAWk6FyjIo2WvGHBrNvI2Yr3/Mx5hmXDpgzTT5uZ9MIStEQIIOIk12SKNA6ZjAX3z6SsaflU5TJXe9CcLkPLK6l2n3z+n+/0iUi3XuzO1h37CvCVLtz/aQ2OyP0CC1Y5lP5xfXZBQfEVkJrPLvrHa/bEs6qa8ihq/cuwDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjBuM3Ij; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f99d50c1a6so8660339f.0;
        Tue, 16 Jul 2024 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156361; x=1721761161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=QjBuM3IjAs1RuQZWkVfY7Q3qozfsA0fcjbpValTODKIraMLKz5ntH4eqV2QO5n6aYJ
         scy5AfK92R0Jt64/TwB0+7a51H7HMlUeORjUco4NICl0g2GsWXFryyXLetcBX1yHqSeO
         JhCvFbXHBtBbFd4UFEYjupaxHDKm7g4jK6wgW3OXvKyozqerY4YCh1AjJHyrTPcFCUp3
         IPRyM1NwjHVB9NajxBhEmewAd+SSzlX32OjgabrKS+fBh95Vv3Q8TvmrAv2nuTj1P9Z6
         hrrZ/eOxnaEcSc4s+9BusgOB7xsKV5ZUNUR3i3avBeFaleRDeimGVeQAtGauGfXJUx1s
         VCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156361; x=1721761161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=LmOEAJCxkynPD4wUC2xV60inRnuCUhF4K0pqvLsSmrIvYuiMacphkw85wAxVV7UhrF
         t94HoSu9kFDZITcOeb0nrOGQziB/OHbQZ4H/+ybNBe0iMSxB4eF8rYMJl0+fVrL2yXe+
         yO67qWRMvFcBk4BaxY+r1paw7H93hBa/uzDz7wwwgE56HGISw4YIAztkVDzbOHZSNm9N
         xAGdAg9UcdjRbsgcLaic0nkCgoR/jlAkp8hWfAwsUv8vNgWcRhB9iXuljGKSCvM/1oFF
         yUePvdrmN+7HBHQ+xHaJ18s43FAtNttXEwSQ3gby+pCDC/IpcU10ldSUbCQg40BeIJ6e
         GaZA==
X-Forwarded-Encrypted: i=1; AJvYcCW+HGbPsMyzRopFdYIaRgalmLLU5Gyi7jSEdiwS1LJ/Op7bHtk4uNbRfZtJa5MhsKqYG8fGgR+4n2B2/mUFo4nUOVjg/q9bUlU7
X-Gm-Message-State: AOJu0YxFc/PmAUyRZs793b8V3jixIt4K/y5Pi4ZIEQixppwfuoAuzPvM
	VChIOcJrF83o6sUba4kggBKlsBLQNS9uirgZV9Rmly409bmrr0/cpuMWMWlR
X-Google-Smtp-Source: AGHT+IGtnYxBzY2m77Nru2t8Ww4iLoER0sn1zlADUp06c3lK5XjVl/QUreG+Vnsvc+0HVrc3CXJwNw==
X-Received: by 2002:a05:6602:1595:b0:803:6699:787 with SMTP id ca18e2360f4ac-816c00ab42fmr43054439f.0.1721156361195;
        Tue, 16 Jul 2024 11:59:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:20 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 44/54] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Tue, 16 Jul 2024 12:57:56 -0600
Message-ID: <20240716185806.1572048-45-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..d22308328c76 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -247,6 +247,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
-- 
2.45.2


