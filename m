Return-Path: <linux-kernel+bounces-207952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A9901E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD7C1F22383
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881A81737;
	Mon, 10 Jun 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRiGn2ji"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1F8005B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011940; cv=none; b=IcXnUJpA3/Ce7+HLPQnkFR9BfDxhC4Uy34wdg1HXHhww50upjwCCBx0KPIf6GAtza06vH4ojyZjFWzS7ye9SYCv5gOy75b7aOtBqb2rQoeqG89x1FHRCl3bwV9mbftkHGkblV211teCdzub7ttaqtDQdzNdEPokCBxfgM1pq744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011940; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1efuVhVqg7y3OBowjQVPfpkJPiGRG8bnQLp4BiL/trlaD1lBOwew2s7sxvFYTfQlNxU1TYnUgL6rpfAPfZq/rw6wqhjZ5r+NIlKwlIk09fcezFY6FbNCyThZItSdrfNwhNa+jO1hbzNlUm0ei46fnpFYVs/Fi8Oy7N2qRN4nK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRiGn2ji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=hRiGn2jiTKeoe6jpy3OAr3JM0PnnpWtIG7YuFWuY3A0y8I9Q4heDm+4RaXHDblQePfbacb
	OaMurPuqTK6UFRYT0pWY+M1ZwgeKp3/uUg2zZND5nhtYh7EY5nleqmX2pLXfjGd8Jb2o1C
	PekcFdP26u7hx5L1OJofLMfkiMvutVA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-WmZVQbNOPZGY2KqBT5Fseg-1; Mon, 10 Jun 2024 05:32:14 -0400
X-MC-Unique: WmZVQbNOPZGY2KqBT5Fseg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eae267d112so3093191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011933; x=1718616733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=WwsIPWcLN4KNYF2ALETS/H3q/l66ooD3/Muo9zbESlW9VPxEh95cH4WE7EaSg7jOXC
         lPA0oOh2DfS/M1pKjJLuGdF5qyAsAlG/Txgr1D2A4tH26wYJmRZ5CMEhn1UawACFHmaV
         l694Ar11iHr5W1O8qbzBo9uKAg9o2hVzY/cI10dg81q5hMy/M6xjv7vZyp3zQvaoc7A8
         DlLSXLag9BtAJf6d/HNtBIXeiYKqFc0Cv6gn6r0+MyKQPZYmDY4js9MZ95Xr1glMxs6d
         yr5wGxbXvWLXP6r/QCWcGGKuXeyAuharDiF6udXJTg7BhehQrN2AzfLZYsdcHHCzTM5x
         57NA==
X-Forwarded-Encrypted: i=1; AJvYcCVSqFuS/k9622OudMwdipXkk9yMT1kJ6Y4CTbpCG9XI9lE0rvUlt58WnIU4PX/IiNqZ8OTE73GBmd3T4Yj99Dq3X2vrHDK1TtP7eJVb
X-Gm-Message-State: AOJu0YxPIdjrrY6hA2nXcMSLF4s3hJe1bQKCxZgWuR346px9rUwCFd6X
	n3G1EmXp+MpCcay+CNRfusTM7if9ofD1KS6QJywTeoh+S4H2ZORh0MZ2sFbwkQMeqwEWBDuWpJU
	LB5ZC4LDcixiH6rRoF3sw20HQl1XWtQdDyOje5mQ8f/+ptdksjlZioelfPMjdVQ==
X-Received: by 2002:a19:2d0d:0:b0:52c:8857:7631 with SMTP id 2adb3069b0e04-52c88577793mr2123921e87.1.1718011933078;
        Mon, 10 Jun 2024 02:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUeStS0N5eJVU1XtsiGlp2iqafq61SQZHkJWQKYKYv8JTZLy1IaAESVE2BsaioUjz+IfNVg==
X-Received: by 2002:a19:2d0d:0:b0:52c:8857:7631 with SMTP id 2adb3069b0e04-52c88577793mr2123916e87.1.1718011932865;
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 13/13] drm/vboxvideo: fix mapping leaks
Date: Mon, 10 Jun 2024 11:31:35 +0200
Message-ID: <20240610093149.20640-14-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PCI devres API was introduced to this driver, it was wrongly
assumed that initializing the device with pcim_enable_device() instead
of pci_enable_device() will make all PCI functions managed.

This is wrong and was caused by the quite confusing PCI devres API in
which some, but not all, functions become managed that way.

The function pci_iomap_range() is never managed.

Replace pci_iomap_range() with the actually managed function
pcim_iomap_range().

Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index 42c2d8a99509..d4ade9325401 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private *vbox)
 	/* Take a command buffer for each screen from the end of usable VRAM. */
 	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
 
-	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
-					     vbox->available_vram_size,
-					     vbox->num_crtcs *
-					     VBVA_MIN_BUFFER_SIZE);
-	if (!vbox->vbva_buffers)
-		return -ENOMEM;
+	vbox->vbva_buffers = pcim_iomap_range(
+			pdev, 0, vbox->available_vram_size,
+			vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
+	if (IS_ERR(vbox->vbva_buffers))
+		return PTR_ERR(vbox->vbva_buffers);
 
 	for (i = 0; i < vbox->num_crtcs; ++i) {
 		vbva_setup_buffer_context(&vbox->vbva_info[i],
@@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
 	/* Map guest-heap at end of vram */
-	vbox->guest_heap =
-	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
-			    GUEST_HEAP_SIZE);
-	if (!vbox->guest_heap)
-		return -ENOMEM;
+	vbox->guest_heap = pcim_iomap_range(pdev, 0,
+			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
+	if (IS_ERR(vbox->guest_heap))
+		return PTR_ERR(vbox->guest_heap);
 
 	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
 	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
-- 
2.45.0


