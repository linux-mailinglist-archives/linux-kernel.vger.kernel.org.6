Return-Path: <linux-kernel+bounces-213143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99C906CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BAA1F26DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02414A089;
	Thu, 13 Jun 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJdn2JSK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F2149C41
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279464; cv=none; b=T6sVCp74F+BgTQA22fvfct6E9tWolzx+Oem54YRVN2Crie9T7xAgyaNPibGDaYgGyldIvz6DwPmyW6Aoiq4axju29Bx2zA0fypeeLg24w+LVvqUFC1BdGaHNbXZ/PIdeQ6vxB3deSsPaajQ2URmJvM6klJ8qrtdgAILfz7WocRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279464; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8vmr/dnBK3qiBveU1jV/fUqDdUczZlFjNgfOIQgMBmeUUrByw/z8GSXFG+v7+9udrgEYwjM5cZjt5NOQ8tJn5cEr1bJmnxjfB9K8OQSD4ydmVUP8nNlzvy246ocUQ9OD6WA48Jo/EwFTDaXa1+Aydl0JFGg5hKA9lpPG87QYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJdn2JSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=iJdn2JSKo5UmFrR0ugN7WDNJnADI+q/iHS3wsxwrBwj0luJgq6wF2hvbiW1zzZZ+ymA6Wz
	BukKK2Twj8vyoNVea4PtlWEJ7+8+ZXyUV/BEQ64F5VHv5KngFs0QzmihAov9VIH7jq2Cpg
	qqx75VA8vuHAGvh64DHELqNCkzwrGmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-EwyvKO4VMD2z4flqWhLWnQ-1; Thu, 13 Jun 2024 07:51:00 -0400
X-MC-Unique: EwyvKO4VMD2z4flqWhLWnQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36073543200so107649f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279459; x=1718884259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=mpXvRBPiGuUgletKKDPnfibWNflYy8LlHmlU6wi4wAM2QWVfBn9TLHh5XFbVSiJZaD
         lqZ07RgyUTmu9Bxu9Phn9muc4mb/0rbdTl0B6uqCB1NW3W1D1RVNTt4uIbUeRfjJRDdH
         6sg4mlVrnE97m0bsioSQW/IU8dSDStbOtII/O2kGwodfGfJmEmawygbZ9ttrclWtwFio
         A40IyD2UPJO5nfslLwHVzCq0TWpfcN9KXeTxcI6dpWT3tK5VcCEggpRHPokFeGmZfYUi
         aOO5qhdjT1U92VegZOr24HgDAgJf/Cl+MQMJCmHEJmCsPJLmYNCsZPmyC7CFpwz3lC1c
         9BXg==
X-Forwarded-Encrypted: i=1; AJvYcCX87m7Vyfxd8+/+c+MsbaWPnWPQ/wmjz1GXXedZCG9AAWQwTkDVugvUdJJcpj+xfTkMso6DVEM3Je/b7FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXjiSle2UPxLbTv4FhCru8Wsmm9fdo/lcuBwgYc1XQrdRsb7P
	FwklV/07v0Yr9INWFvHiRm/RcJOY89XKLN+o3SUZSa1DQAIhOsKvuEilonwQJm1kT6lFCSNWDGs
	Bz/AOyWfTuPkyzMOlYoRo41DxZHdaEG0firvXSrX5vf+VDfWpvGSqI8Lyp44Tzg==
X-Received: by 2002:a5d:6da4:0:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-36079a55d96mr164404f8f.5.1718279459403;
        Thu, 13 Jun 2024 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElWKl4RSn/FE/WxBDl2/l3vU5Ab6FM43jl4nz2rwpq5A2nGMHBM+4ko0mCUeuR7gvoXMoyQA==
X-Received: by 2002:a5d:6da4:0:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-36079a55d96mr164394f8f.5.1718279459138;
        Thu, 13 Jun 2024 04:50:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:58 -0700 (PDT)
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
Subject: [PATCH v9 13/13] drm/vboxvideo: fix mapping leaks
Date: Thu, 13 Jun 2024 13:50:26 +0200
Message-ID: <20240613115032.29098-14-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
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


