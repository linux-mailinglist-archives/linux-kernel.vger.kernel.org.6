Return-Path: <linux-kernel+bounces-201969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D348FC5FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C95C1C227B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1B3DABE8;
	Wed,  5 Jun 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOz+EZaY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7E194A7F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575404; cv=none; b=BOLa0ZstZjp/+VKGxrTcJI6e3XPbOfHYqePA3Z3pIDqkYOKzwjdDn/aUshCFLbYglXqf45JcFl70ieFT5uTaLY/g1TztoXyZsYaz6J98XUPZvnGW0WONTuQdEAfFsLqk903+OZMfkbZxzdNpPf7wAyToFhqNeDBI6HDACPcVd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575404; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzU0RZsfRmWFr6YznLY8R9/WmMcEdJkjtbzCVN5FJTT7xMAcl2G2z4LD0F7/b24U+hxFVE1jdas/24Zq0t2Tk/voeCpbfvB2y8b69mshe7/goBooYEPsByj5LMwXoIiZy7+AWxFt84Bseh+ch/5GLmEckqy8jrIdV4Ys8UZDcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOz+EZaY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=YOz+EZaYyJaKa7N3Lt+aqkaavE0iz6ZxxyV3TSxSLeO+O0w1neesXovQjaGjfX+5oqt5Hy
	uQ3GVL/ULBV8RXvMgSGRdkgcHRq1pOSObI64NYMUdSFigZf8QGSEUOcJve16hD0IZ4Bub4
	xpjAqbz2eccGdwv5ItvAj+zIoJBc39k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-dszJv2-aP5-CLUybHHshCw-1; Wed, 05 Jun 2024 04:16:30 -0400
X-MC-Unique: dszJv2-aP5-CLUybHHshCw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42133136397so6120005e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575390; x=1718180190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=CFqTg0+YB6PoSZWrY9DpcMUpPZG0yeQD19E/6QAyri52Z+4upPoBG9Uxcmt89XqSAD
         SbzG7mslpI19BbklFNxG5hq1drfwdF3sGQebKnZuCyTvtg6D5xVudGLY3vCEsr/IVYpb
         HIcaFX5mx6YN5asY0cRS1WWxeWa0Dd2kpyRjTThrAl5ieQ4qa1iHTTzJUBcpDO8dxATD
         1ZbhYfsO4gksjFAWDsufeU9dpLMVk6DZfm4G4DrxCgE+nFeVJHDmbmCBZe2mFzWOEQ87
         ch8G8rmzy4ZM3DHJR15wusluffZ+yqoIAa4RP/wDJXVwQvtTCmhCQmUod7bixRbRSqhG
         dUog==
X-Forwarded-Encrypted: i=1; AJvYcCVPXTOTOq+NbH9ynxGGziCBnz1ccMPwlh36KwfKJPnIMP6zOzhYqONPjAzwY/+ZLT1+DP2797qX5/HTxVlfHWzMcPgBtsTHOeokLTrs
X-Gm-Message-State: AOJu0YxDPNYlaBhWvFMt19uWY7YCNsxAXhjzo3Rk0mmw0+qL9zOHxx+L
	8CaZTf9rM9tzywfn6hMjfEuc9wepvKxT1e1NR6QNdDnD8lQBEjoJ223+LVvRgdqR2bBc89qLl3g
	lPCFQ2L/CWe34l9DV3FVLYsWTCsJifHsQ5Y78/GqdVbrbPIUsHPb0IR+/ZRpK8g==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241478f8f.0.1717575389876;
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjXIQcWcnmum91rBphrXn5QVRVx0JrE+Ei0yMho9Onfe+TO5zfd469TFQpM4baXxySxHqFTA==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241464f8f.0.1717575389558;
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
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
Subject: [PATCH v7 13/13] drm/vboxvideo: fix mapping leaks
Date: Wed,  5 Jun 2024 10:16:05 +0200
Message-ID: <20240605081605.18769-15-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
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


