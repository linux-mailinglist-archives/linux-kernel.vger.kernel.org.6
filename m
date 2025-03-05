Return-Path: <linux-kernel+bounces-547144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E7A5036A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E2F3A9C57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF22505B2;
	Wed,  5 Mar 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTuv3S0V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0E24F594
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188397; cv=none; b=Ie2I3bnjZPPLKQ+DE4l6tAESOtauhe96LogUHJ+0G+bY+VF0z26JROcL6XmEWz+akG3d7ZiAtyeZAFOwSbUrSd84JArY8/rl42u07rHZGYAKmqXCnpLPuQNWZLKHtsb8WsHYe2tik2Gf1tZeJdiG91Bu3moKcPYvQPa9joeWoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188397; c=relaxed/simple;
	bh=ZFMnP29tRojoZAYRWn2YoJlKwVnOhe/hYMgtVR64B/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ukqy8u6rz+m7JPjY03/KXkTNx2blb7nXChzyYVvaEwlnVCCYxUg3+GFF8RZ11LsdPHVktznaLpwrbquAgA6Arnp38otVV3aKAULDIz1UZyEMzHnKmjmjkmwBKQRQent9xYPu8QQgaj0mQUY4ACOunXeRyP4K8qxlvi9t2gwu07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTuv3S0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EWytTCujcELs5/4BiTEaWtlYBtC+JW3njDIGrLsFaXA=;
	b=iTuv3S0V0Fvlqh/I2OIfIKXEZFFb63GUTiJdBAktgRzPTHJrOb6Blc50Vpcoz6bVP1qI+n
	47CPxJE2LF6xRJEGjYn1MQhwbw0l/2ZwhQ6y/4A9EePTiUAhNTDG9+ikKC3W7lvq3iP95Y
	5Yf74EqilP96qwpXys2nIXUFYPb2IyI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-V-F49tz-PGyTL-Bai6Wwmg-1; Wed, 05 Mar 2025 10:26:33 -0500
X-MC-Unique: V-F49tz-PGyTL-Bai6Wwmg-1
X-Mimecast-MFC-AGG-ID: V-F49tz-PGyTL-Bai6Wwmg_1741188393
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22366901375so21239215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188392; x=1741793192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWytTCujcELs5/4BiTEaWtlYBtC+JW3njDIGrLsFaXA=;
        b=eheeWpiDNjeEMcdembIy2GNSZ1C9vHqdgL9QJ0QGdNr9C7HYGu8XwfkETSeu+md9xt
         iF8Vx/emG1ELOMdhc+KlFNWEMf6VMzIZbA0oSug6JDFvVvS7WW8BDVcNuoxD+ccoIXjs
         YZLTuBI56r6k+i3xwRIccj4hzxwleQfaJIVjuCWilMNOXUdzbZc+9ZXCnbZUx5nUNPop
         wXsV2nrJ4eZTKc9hIRh1FCSN+OekH/7Bglwz9stKLSo7aK/jf+UNVtYz3GyEJMyaSQxD
         LOlcNVe1vVVt263WZvzXS/u/N6QilKiOcakONjXVeheV0qOkR4hX6xEOlKUuM1fBlDgU
         Jqlw==
X-Forwarded-Encrypted: i=1; AJvYcCXRocMAb6GJEx4bIUEAAbzZfr9/cBMZWIe3LIeOtbd2FzjGS0FSA+ygFJxQgleDJp/FcOIiGr6MvkLqBFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3i731Z4eVSVzUaR0L3zBh77OUZBYkD7dqFqPS990wcp3/HdR
	CSkZMEw5FYOfkjRYTgYoEQi4j8K9O8buc1Uxb6fOvMGZFis0MBP/hY5lqySltufPsMnDAcb89IE
	iSKJRAZuL9oaE5nXA9Ow5BTZLR9nV5j4YRHs761169xgvItA74ttgqixpLCMFrg==
X-Gm-Gg: ASbGnctFGX1ucQYXD4Inmyz5yUTWN9F+DyZf+a5HyZr1GT7UAOt3O6ganRFt5akxKcb
	8rTIS7quwTX5M8vRRIKin0SGfbRag5xo5PHDUyoxfogwQvKUf9hxhJD5FgoozHxV9swqrO0KOA0
	vIqSaecrdObaiBR4Wh4ZSxYK7oC9fhfkQJA4RCSjU23bmx5FU137D5YCGxgcJ1gkS4GX+F8JyB7
	GioFSVmpW9txz5iBm/SzjLEBdm1uhHx0n5x0ymAkGcnsvHgHU5wpD0BQXoekp6V+TnT+8q88o05
	e1cGIMNxpnOYE7ld
X-Received: by 2002:a05:6a00:9a0:b0:736:38b1:51c3 with SMTP id d2e1a72fcca58-7366e75b316mr13315925b3a.10.1741188392501;
        Wed, 05 Mar 2025 07:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1AgdJworx0wc6ga7cTSTBOuDEcumamKctgiwANw8/Rb3cfxQmtMLlo6lyVJUiuFftqJ0LQA==
X-Received: by 2002:a05:6a00:9a0:b0:736:38b1:51c3 with SMTP id d2e1a72fcca58-7366e75b316mr13315865b3a.10.1741188392100;
        Wed, 05 Mar 2025 07:26:32 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364b4eff66sm6983292b3a.83.2025.03.05.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:26:31 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	dmitry.osipenko@collabora.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH drm-next 0/2] Enhance drm_panic Support for Virtio-GPU
Date: Thu,  6 Mar 2025 00:25:52 +0900
Message-ID: <20250305152555.318159-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

This patch series proposes enhancement for drm_panic. While virtio-gpu
currently supports drm_panic [1], it is limited to vmapped shmem BOs.
IOW, it does not work in non-VT FB environments, such as GUI desktops.
This limitation arises because shmem BOs require vmap, which cannot be
used in a panic handler since vmap is sleepable and takes locks. To
address this, drm_panic needs an atomic variant of vmap.

The first patch (1/2) introduces atomic_vmap, and the second patch (2/2)
updates the existing virtio drm_panic implementation to use the
atomic_vmap. I've tested these changes in both Gnome and VT
environments, and they work correctly.

Best regards,
Ryosuke

[1] https://patchwork.freedesktop.org/patch/635658/ 

Ryosuke Yasuoka (2):
  vmalloc: Add atomic_vmap
  drm/virtio: Use atomic_vmap to work drm_panic in GUI

 drivers/gpu/drm/drm_gem.c              |  51 ++++++++++++
 drivers/gpu/drm/drm_gem_shmem_helper.c |  51 ++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c |  14 +++-
 include/drm/drm_gem.h                  |   1 +
 include/drm/drm_gem_shmem_helper.h     |   2 +
 include/linux/vmalloc.h                |   2 +
 mm/internal.h                          |   5 ++
 mm/vmalloc.c                           | 105 +++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 3 deletions(-)


base-commit: e21cba704714c301d04c5fd37a693734b623872a
-- 
2.48.1


