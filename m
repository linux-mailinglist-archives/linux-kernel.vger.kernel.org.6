Return-Path: <linux-kernel+bounces-421142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C664A9D875D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186B4B3416F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5B1AE863;
	Mon, 25 Nov 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYqgacvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AF376E0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543385; cv=none; b=hYlHOgfTzjlkQ4NyTPhJUIbRaDWKQ/WbejZL27N66yVTcznHEUMRcfGlacTNP+iU2j+1GNmUzhdEyL6VUHlGCiRkuAJnSSYZBZOH8ZByDS/F85DGc6V2g+rzdnOpLRTY3kfN/2cHe6KoB7bjEmYq9/AG8XT4dF3FBc9OKlA5P3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543385; c=relaxed/simple;
	bh=2IekofnAhK15cZIwqSrN8ORu/Sp3CPa1z5biLsoDHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS5tD4wxlDL1vv78PgwfTI0PQeCXWsrZp4S30vNYOuj4oY1UWYvfPRjMdRdURntc3o41Ks3G6XV0kYiFqzyacjxL75+JUiaps4CbLNDSWNJH3xfPC1GdIyjC36uinCYmOTSMRgJzJTLj612Vu1Hnc/56ej0MUiPSzcmj58vno6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYqgacvX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732543382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDC6pto2u5wQTWJgEumgXmAUimdPOWzrNSwboQGTueY=;
	b=GYqgacvXN5dR8AtQ2ZPWm8CgGphcKTkXMa/JAw1BNS4R5USYs+dSs2KmkAi8uKbip6/qId
	ziVrIoGVCVRKtiVttCtZoOUKhb11OckGDYvok5BLROyF36/Ph0nvMMXYz7t8uRTwLZI4w+
	AK6SZq/5hOdF17KxZKmr4358uJGe4Dg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-j4_GnA3uMjuLdCk3btyr7g-1; Mon, 25 Nov 2024 09:03:01 -0500
X-MC-Unique: j4_GnA3uMjuLdCk3btyr7g-1
X-Mimecast-MFC-AGG-ID: j4_GnA3uMjuLdCk3btyr7g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa529e707f4so179719366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732543380; x=1733148180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDC6pto2u5wQTWJgEumgXmAUimdPOWzrNSwboQGTueY=;
        b=n93d2/dnNJEb878lnGzRF63l0PVS3kMiheh/Wlg9vv2Y94SPCxGofLhuAyxFx+brks
         yj6ylWcMIXzq792tibHPAvKKMkfAJzrGlE4Z8gu3GBnpDjBZyhPTDbPv275YljaTKfCy
         sdzEitD8BKoN9SMp/VDHaCmhloso56eN1JGemX/PjCYWWr5V5p3FV13XIXJs6HOfIlN4
         QiT6LNkBqS6CE1q1qT0KHRnX5uDkn6CDAt+xqj8zT1nQcUD/HEldPoZvilwV32JtMBmk
         OiL7oED2GTqI8yUnYOexvRHPPyRzRfnA80QvUvBO+RMlSGWja2kMh6IREn89xHdYdRpr
         AMpA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTWfewjSLZ09rDmDsAanUSYbajD1Twb0zzHdsxACXi4OAfYjqc9DlCBCDtZJN3CDIAaRceZhesFiEa2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYLd1pfg1UtToW7SQIqsvHQtiQGAVPpoIjWcclqSnMuFmkON+
	gayg1KMAHwOqRdjanPmYb0kExN1N+dIaI5Mto168adv3q/xckEcRXftXnQpHskDOASIRcQdZQ2D
	RsEaZyMRg16tTYSUe1W21Q8HYLjWLVWvcrXzvBJhbuHAxFXPjRWEo7Iwh9UCFJQ==
X-Gm-Gg: ASbGncuAw8R1tA78k/DfwL1z2V14WbZ+Baflpy0W8BNMoW2xmZR/o0T91hMo6LTrK3h
	9MsLbq8gdZtXjnbhDiEEjIA0ROQve6LF0lOwuUXHhjz5VGQaZLW+wSKFAA7kRe90jPrjn+j+QUz
	6fOieXdWnWPbhkkTcRikKaSWnJKrzC7AcfZK76zktcxM0BeEjuTtXN+2RMYN09Cwbc73qJ/o3AH
	pJt8FPJMieEi2mRmaC7y157Adgfu/0BTQF84yVO2KpmhZUFnhNO0bMrRtTD7m/u
X-Received: by 2002:a17:906:328b:b0:aa5:31f5:922a with SMTP id a640c23a62f3a-aa531f5930emr659886666b.19.1732543380213;
        Mon, 25 Nov 2024 06:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDiCZ6k982ag4d6O8/RFD5z8+azZRqNsYYVGtgwxLY+Jn66AWlV3rufysIZ2OmCphBjOoqqQ==
X-Received: by 2002:a17:906:328b:b0:aa5:31f5:922a with SMTP id a640c23a62f3a-aa531f5930emr659853666b.19.1732543375954;
        Mon, 25 Nov 2024 06:02:55 -0800 (PST)
Received: from eisenberg.fritz.box ([2001:16b8:3d40:1c00:e57a:25ed:3c10:67c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fa36sm473635466b.122.2024.11.25.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 06:02:55 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Sui Jingfeng <suijingfeng@loongson.cn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2] drm/lsdc: Request PCI BAR
Date: Mon, 25 Nov 2024 15:02:29 +0100
Message-ID: <20241125140228.58492-2-pstanner@redhat.com>
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
Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
Changes in v2:
  - Add Sui's RB
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index b350bdcf1645..d373c13a007d 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -232,9 +232,9 @@ lsdc_create_device(struct pci_dev *pdev,
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


