Return-Path: <linux-kernel+bounces-279121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E037294B92E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2521F21612
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4F1898EC;
	Thu,  8 Aug 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGkuPVRd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DD18953C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106490; cv=none; b=ZUDpUDUiYlvQcDkPD3za9EfRQaPaXuargfnTcyo0sSChP2cSSPi5IOr8KSfLnreT6c+mAWPLl9PqQ/PGGpw+BCqILMVkjcrpnzd+BOAmNme5qD8+VaN9bt6D/dEIWUgRXw5E236oDiSd/fI6heUCQhafV0uozTjJckud24Or1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106490; c=relaxed/simple;
	bh=ETj/1vJ4Bn5tGbr5IRGGLt5Kw64YHd3Qx25HzEKkOn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nF6Ti6S265BMxHrFYhWJsfd6klF0mWHtCAduvZbXMXiX5Zr50RYLWn8+U8n2WarzuRJMxttAwB1HkHrcv9ffvSmiSiokWwQFu5kpfAndxXrUlOSDHIubmRlpnTfh7/kaRBelLBO3Jg1UEVN/aOsdkM96jegTN+oEZfpJkA+kd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGkuPVRd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc491f9b55so6769255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723106488; x=1723711288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Prg3p4IJXod2uYAeJPsfBfeNoizjg8s9RfmusbUKHaE=;
        b=jGkuPVRd18khjDajkpW4qO/Ipy+kq3nbzkAb1cT1tPcUFhUrz+AE+0D5z/kB406v/R
         OvZ/g4dQDgDzfXae4YrgZcu/il9KOWNodVcrdzwuTJkfadFSYYm7/rm/LrVFfCnMxbJp
         Vei+gtHHAwUt7WDQyi0jNyBywfNY9hY8Z8k7eydAP2x68ZLXtx0e1Wl4O7ddsa0WpDnM
         qS+bxsFt7YIofj2tzdBGRA7StsLztWPZV5j1yT6Ph06woUbTeReTLbJEsr5RKVkSwQqK
         sYNloKyfH40G/i9B7pB7jKUVNEAljj2zyYgcMzZwcGa658hwAcoBzTYWcN6MK/xB1TIB
         gQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723106488; x=1723711288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prg3p4IJXod2uYAeJPsfBfeNoizjg8s9RfmusbUKHaE=;
        b=FLfupm2N9k2vK6vGPRR+KhZn/PnVmIzYj9XQH/W/zgLsJ29ZjOv3xpHEwM8rZsPwGV
         l4+VXI0YNRrJYoOnh8CB4qZKecCqdOzSVc5rgNe9brpF/AcN9x0WddkApaCKPANniqxI
         sCw0Cte4cKu6o8Sa4hOq19BZ7qVtbmLt4ltEPkF/HQFZVtbJt3CG6ktBUMxlTUxsqb3K
         ommE+4PvY1eQOKccXBHTWJj553/cB0IsnZ641PDXYlT7l9GPSyl2hyo7q0vWWuUg6VTC
         d453QyxjZl5sE/y5in0PUX0ggHvOW5KgVAKPFG5Kfl1xWkdkXskxMer8g41XH7X9Bf4k
         b1VA==
X-Forwarded-Encrypted: i=1; AJvYcCUipyy6lIEx9oc+aUWv5ol4PWlGz+al+OujGL/rCVkmJ7nBp0I/WHCoRc2Dac8QiMMqjDwBIIQX+1wMuJGS3P9UgUBhpthVbyFNaXbY
X-Gm-Message-State: AOJu0YzSbk3sPJFeWjEcWGMDV5UrpqRPubJJdqIrLTrMnpEMtckOvCqK
	X+UwW4xZJQpt8c7t0DQYNglaYiZJEFoznw4aka8EPcG/JJc+W8+J
X-Google-Smtp-Source: AGHT+IGf3LYFo/KitokxOs8qD5G6qV0YnD3haJ/FkUl/QoGSzNpGYzzB9WmJzXyty11nqtWDCa1YrA==
X-Received: by 2002:a17:903:22cf:b0:200:7d10:b88a with SMTP id d9443c01a7336-20095303b3amr14581445ad.56.1723106487794;
        Thu, 08 Aug 2024 01:41:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-147-99.hsd1.ca.comcast.net. [76.133.147.99])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff592ac867sm119091335ad.277.2024.08.08.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:41:27 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: skhan@linuxfoundation.org
Cc: danielyangkang@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kerneldoc: Fix two missing newlines in drm_connector.c
Date: Thu,  8 Aug 2024 01:40:58 -0700
Message-Id: <20240808084058.223770-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_connector.c has two kerneldoc comments that were missing newlines.
This results in the following warnings when running make htmldocs:

./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2344:
WARNING: Definition list ends without a blank line; unexpected unindent.
[docutils] ./Documentation/gpu/drm-kms:538:

./drivers/gpu/drm/drm_connector.c:2346: ERROR: Unexpected indentation.
[docutils] ./Documentation/gpu/drm-kms:538:

./drivers/gpu/drm/drm_connector.c:2368: WARNING: Block quote ends without a
blank line; unexpected unindent. [docutils] ./Documentation/gpu/drm-kms:538:

./drivers/gpu/drm/drm_connector.c:2381: ERROR: Unexpected indentation.
[docutils]

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 80e239a6493..fc35f47e284 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2342,7 +2342,9 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *
  *	Default:
  *		The behavior is driver-specific.
+ *
  *	BT2020_RGB:
+ *
  *	BT2020_YCC:
  *		User space configures the pixel operation properties to produce
  *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
@@ -2366,6 +2368,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *		range.
  *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
  *		driver chooses between RGB and YCbCr on its own.
+ *
  *	SMPTE_170M_YCC:
  *	BT709_YCC:
  *	XVYCC_601:
@@ -2378,6 +2381,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *	DCI-P3_RGB_Theater:
  *	RGB_WIDE_FIXED:
  *	RGB_WIDE_FLOAT:
+ *
  *	BT601_YCC:
  *		The behavior is undefined.
  *
-- 
2.39.2


