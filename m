Return-Path: <linux-kernel+bounces-369795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67689A22C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284601F23E60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BD1DD89F;
	Thu, 17 Oct 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfLeCZmC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83661770E2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169525; cv=none; b=eVQUqZMlQ3zCX6TcDPblnRo13FDCH85xit1F7Nm0bTyIgNx3gHfnPw4t9x3tV2nyD5YPLmLoLMyQRDEJ0uxIbCfWg2e9Kc1MWyVybZaP1RG+sKuFIzq78keICO7yf+2GLxE0fyPllmILSsMZx7RYArNfCP2FOzn39fC8TD+/edE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169525; c=relaxed/simple;
	bh=e8SdBWX5LcZecSoqEGGdswWYrfPe2dBO7nVZ2+eJaL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Py0dFHLXAUEa4d2nHEE0REjhX7znSaBo9ksUjiMJmqEkUf+xo+y4mpxT8B5+T7fvCUcSbbGm6QZg6ZOrxWvPvpuAV88trF/zruxJTlGZ5b31/ZO4rMp+UTHo5tLPlComcsa5ALgby3/QTZjS295utnY4Op8s90iWBc8cQAjtGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfLeCZmC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729169522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=um5kPuJ64llVoLwmFFHr1GyuNJY8DQ3vVEayxTgqCeU=;
	b=EfLeCZmCclwyVxuU8bq7p38JOlwNKh5FDbmAhRsLkpv0TLdwKGcC94xUaaOPU5pJs6C961
	I64+68UPUL8Wm+N4ym+DdVx9dG/bn90kdViSVVsrD6fmGp9IDBBa0ATIFSBnj0rVX/99/s
	Gta/D+d5shGDStSpAa5UAi4zyv6obFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-DYzGtpjxPqePb5FneA0Ptg-1; Thu, 17 Oct 2024 08:52:01 -0400
X-MC-Unique: DYzGtpjxPqePb5FneA0Ptg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so339195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169520; x=1729774320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um5kPuJ64llVoLwmFFHr1GyuNJY8DQ3vVEayxTgqCeU=;
        b=TOhniHu49BEVSFJNgES7vtwwOu7DiIfb8c+zEX7q4lWhj6p2wmOmpgVvp8GfM3dovp
         uZ81VfgYavRXhrha53idvllg+rV+maaB10+woCFuNjzXqF4u8eufyV9chboScUkrFdH+
         HEMfubYl020woRA5P0UJOHxrnT62eq7Sp6i9HEKTxoWv/eRWIktN27Yvs1ZJbW+Ezx+z
         BmqrThUdFOiMD6CmMxLEwOfv2x22wUWT3Nq40ShMHhA1YfovcGohNMnw7UpgE9W5SUqJ
         FX6JNYfKZ0vHSDhyZmclFqgOvTMNp2q/pYiXjH7ttWyXSyaBw1nudUdOH3wZKUCFvAUv
         zitg==
X-Forwarded-Encrypted: i=1; AJvYcCXGVT5TINJz2p86ih8D+bIroDKJxc2JP7rg+Ocbn2TdmrTggXZqvCLPlS1mdq/Yr4Sh54LIJf2wXmyUSdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZWT9OrUgqa3g6UW129GJqGp68BVdWuDQ5kjSTnQrud6o8YF6
	mZIwRecB3ICFfnlZRo7H0ZEplZpQ3775xAg10AD4ZXvK2hriLHfrif857evJcazPN1ThubHpc2V
	nWHuW4cE0FG6uMdac3TMITr17ja+3aCcQu0Vc3KWrvoPf8LxmHucvEk/qRN8HFw==
X-Received: by 2002:a05:600c:510f:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-4315bf20381mr16130675e9.29.1729169520177;
        Thu, 17 Oct 2024 05:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGYFzQ02xHqa9DwuB2IQl1STrx/TjGYcJn3bnqxHl7RZjfzQiYdIGcS5/o7InyDdXexXUkSg==
X-Received: by 2002:a05:600c:510f:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-4315bf20381mr16130475e9.29.1729169519778;
        Thu, 17 Oct 2024 05:51:59 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8228sm7178054f8f.81.2024.10.17.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:51:59 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/bochs: Replace deprecated PCI implicit devres
Date: Thu, 17 Oct 2024 14:51:46 +0200
Message-ID: <20241017125145.34729-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bochs uses pcim_enable_device(), which causes pci_request_region() to
implicitly set up devres callbacks which will release the region on
driver detach. Despite this, the driver calls pci_release_regions()
manually on driver teardown.

Implicit devres has been deprecated in PCI in commit 81fcf28e74a3 ("PCI:
Document hybrid devres hazards").

Replace the calls to pci_request_region() with ones to always-managed
pcim_request_region(). Remove the unnecessary call to
pci_release_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/tiny/bochs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 31fc5d839e10..888f12a67470 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -217,7 +217,7 @@ static int bochs_hw_init(struct drm_device *dev)
 
 	if (pdev->resource[2].flags & IORESOURCE_MEM) {
 		/* mmio bar with vga and bochs registers present */
-		if (pci_request_region(pdev, 2, "bochs-drm") != 0) {
+		if (pcim_request_region(pdev, 2, "bochs-drm") != 0) {
 			DRM_ERROR("Cannot request mmio region\n");
 			return -EBUSY;
 		}
@@ -258,7 +258,7 @@ static int bochs_hw_init(struct drm_device *dev)
 		size = min(size, mem);
 	}
 
-	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
+	if (pcim_request_region(pdev, 0, "bochs-drm") != 0)
 		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
 
 	bochs->fb_map = ioremap(addr, size);
@@ -302,7 +302,7 @@ static void bochs_hw_fini(struct drm_device *dev)
 		release_region(VBE_DISPI_IOPORT_INDEX, 2);
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
-	pci_release_regions(to_pci_dev(dev->dev));
+
 	drm_edid_free(bochs->drm_edid);
 }
 
-- 
2.47.0


