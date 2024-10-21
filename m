Return-Path: <linux-kernel+bounces-373951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A89C9A5FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB3B281F67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82B1E2837;
	Mon, 21 Oct 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjnlQpro"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F801D04BB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501887; cv=none; b=nptceZdeK218uIObtE7+jWhRCAAmCFjvHFUKIkvuv7XJvRtMD2Pqgg+SknLjS67rKEqcUHC0agJCD8HgeUi5RXoPLJELH5v5myTVzz3rSZ0RzcFPYz0Sfb5H3KMpoRAZPYe6GxN8Q4iSDIMNnm4YEeK0/SPPwn4/pbn6IYUG6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501887; c=relaxed/simple;
	bh=WLs03ierjdWj+gXgwTiHSzKdOnnNqdylzhJ97VfIjDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nd6I5Yx6fE/N2QzO6LZnOWyplUxIHkMz+hSJhmE3xRw7tjH3Hao84+h7jOY14Jlz2joBvnvvo7TZsI41+2CRkNP9dycKK4VZeTFKaABXnfIKvjbWh2oxAlxYAzcUEj4KtK75D1DeMk5XVP1PJcC8pTfkVHR+DVRNuuYvc8c8yWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjnlQpro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729501883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h/cZ9ik40jZqCmA8LDM3aEei04H39Rf+nKGJ7o3V87g=;
	b=UjnlQprowulipIEpJojBYnX2+t2gw5DMu2MUWALHknOAWeWqNcjkt+bL/KNR7II7i99gI3
	izWx2G9tElKNNNcKh5erxTUPKfT50szemN9T64OHyF8FDFFO1bANtcsQrz4fiq458FFJ6u
	p3EIrF1da5odV6B39OTDNGk2RX5LGTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-JkekbuHCMoGulrl33gtppw-1; Mon, 21 Oct 2024 05:11:22 -0400
X-MC-Unique: JkekbuHCMoGulrl33gtppw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314f023f55so34532295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729501881; x=1730106681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/cZ9ik40jZqCmA8LDM3aEei04H39Rf+nKGJ7o3V87g=;
        b=KQpEIGY6lM0b0z7/HCVF3mYZLkSB1ApmswzgAr6va7WwrWwLpJcGpgHIVv6nah0Y0r
         OKva4rDbQ7+FGGjQb4pZTQxnk9IqajsJaWQ57y5NG2HJb+X67qqViHb7y1WzO+AILumE
         dlIO4DHlCV2FLi26yDIaHh1s2XpBxFvICu8LQm8nFxnlMTp4EIyN00ZNPTB8zHxdoxKK
         y+XlKUy2LwcOrEmwE8ulRcZJOMXl9oLGbawGa7JirZEeC4M9jShaa+sJjYC1ZoyTtkD2
         YsSSO0oUHl4FF1yE0GTTqCHb+xFCE9JYGiVVI6NfEu7CXNsxe+cXeel35xJv5blkdZXd
         Ou/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV6lUasX7Mso6sN/Hf08FnXQpiYie11JtcNT/XVOMgNXKhvPgGgKt1dX6AdRumsWyXoW6cRaW9no+peEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvRh+kDkPvegxBKnJoZdsNFJRgXEM3seY6lEJnkDcXMgm0I5t
	CseJ9lnSraVqOYB/XSKj4U1ftx05yQECZpJnMxCjQ8awqp9QLGYx8kEsXS508RA0L7d0pKqGdva
	2L6HHFI2+gVClaB0NaFacoULaLxjO4Lo0HWQw2EHnvJVHzYDu0yLWOh+cBtUrzg43dnEShkLg
X-Received: by 2002:a5d:5649:0:b0:37d:4cef:538b with SMTP id ffacd0b85a97d-37eb486aaa5mr6145655f8f.26.1729501880850;
        Mon, 21 Oct 2024 02:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKnogqVvTQRgKVaEROMhzo1GOWp3yCyMp59Ns7uFRLsJYvM2xSpczrhdqT2HHz14fDdQIqlw==
X-Received: by 2002:a5d:5649:0:b0:37d:4cef:538b with SMTP id ffacd0b85a97d-37eb486aaa5mr6145636f8f.26.1729501880417;
        Mon, 21 Oct 2024 02:11:20 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d449800aee93296d73e68da.dip.versatel-1u1.de. [2001:16b8:2d44:9800:aee9:3296:d73e:68da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm3804855f8f.67.2024.10.21.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:11:20 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Sui Jingfeng <suijingfeng@loongson.cn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/lsdc: Request PCI BAR
Date: Mon, 21 Oct 2024 11:11:16 +0200
Message-ID: <20241021091116.14368-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lsdc currently just ioremaps its PCI BAR with pcim_iomap(). Performing
a region regquest additionally can make the driver more robust.

Replace pcim_iomap() with the managed function pcim_iomap_region() which
performs the request and ioremaps the BAR.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index adc7344d2f80..592d01b6767e 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -230,9 +230,9 @@ lsdc_create_device(struct pci_dev *pdev,
 	lsdc_gem_init(ddev);
 
 	/* Bar 0 of the DC device contains the MMIO register's base address */
-	ldev->reg_base = pcim_iomap(pdev, 0, 0);
-	if (!ldev->reg_base)
-		return ERR_PTR(-ENODEV);
+	ldev->reg_base = pcim_iomap_region(pdev, 0, "lsdc");
+	if (IS_ERR(ldev->reg_base))
+		return ldev->reg_base;
 
 	spin_lock_init(&ldev->reglock);
 
-- 
2.47.0


