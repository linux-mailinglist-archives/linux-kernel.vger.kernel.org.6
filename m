Return-Path: <linux-kernel+bounces-213133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FA906CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC651C20E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EE9147C98;
	Thu, 13 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NX52g99H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4E1459F9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279453; cv=none; b=l20jZoYnA1zHM5RYhEdRn3eu44NZlKv/68o4c6J0dEEmuSq9T93Z3o/c6eSMQCUhJV37PxKVh+qD8qrB/Ogjk3U8TUj9hn36HSQ/W0Drj8l4pK2ox41YVESs+J7kdbDTQUEWWwt4fhgCaU/7IwtgQ/AR4xG6DIQxyJEv44tomRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279453; c=relaxed/simple;
	bh=uxWR+cyvQnS6F+Ku7i7pYs3ZA+OagBoxvbut16jkiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkAVxICPRWt6IK1Evg/zIWRsaKZnx8EjJrc7yq1ZljntYrINNz/FgSu5G27xgm+VelXHKTmartwOj5gwZCTL2Xg1lsGaMb8Bs9VnD1yluUF7RKyMgLnzCdr4MUPIz5vum7C4WUn0cMAr8qXHPae5FinlBWyoP0utdKnb4oxC+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NX52g99H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
	b=NX52g99Hk0H0FIKhUpXswNHRiDDSQFzCZznmq3WOB0NESB9BP2bjegGvvi9aGAzPJsRgKh
	P5aCCaqKopxc7Q5R/Mj5Y00V5+66P8Yd//Vr16TNkdhhgIVbwYBkG6C6/lHb1Etg0cFKSY
	6/duLjD8iu97vMYwcjby8uV2x1vnftw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-j_XODUmmO46GQOVy368ySQ-1; Thu, 13 Jun 2024 07:50:47 -0400
X-MC-Unique: j_XODUmmO46GQOVy368ySQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebf1470cbaso442981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279446; x=1718884246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
        b=ark1gKI/P+fi8GTawVopjZsffm/1oEmyOblS7jAcXv0wJJXtth26u/FX2+IyqHJjqa
         5fRUrST46gO4R+GTLlQwBJWZh+1zOUMoDTqj/FDldNUw69qms2sFWGU3Xvm2qHpJNAO7
         QLuqTix+jd9Zx65FmvLfBhrFO0lGM2lEwZFZQ9D8VewABkkfNGSkawvPi2e5OSXcoPhG
         O2O82kapilo6Z0o0uyIC72NT4509xOriNskTqwqs4Hp1lK+fa22R5lUgUJgUsPKXS8I5
         kDTzG+iV2osXXidjoyCO0ppmyC/AEBihW7TuDRpL9XABH08uR0acZrqtxdmu6HJKwBEn
         pJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9vRwI41GU3i6bNdj28oDcw+/nX5BFTmfd5cxac4nSVXWHCaiNs/3s8lpseWWGELucxSFfsuUgsT0pjJVwzxJ3VTxDxD2/4sCHyYum
X-Gm-Message-State: AOJu0YxMVsp7IQwDFfr0ke/P2Scc24w5F/NGxVzzbRPn9/uSg2Ztudn5
	a7mHwhgixWxjQcWx68prMS2io958wx7VfvK8DRmU2c0gvFhZMD8xpyJOfA7PN9giY5uGqt0sxwE
	vMKNdBtpF8DpBmEITmtGys/ETfrWoqsLjp+0Tkr3C6N+5a8XpGnQ0pB6xMf7Xfw==
X-Received: by 2002:ac2:4db6:0:b0:52b:b349:c224 with SMTP id 2adb3069b0e04-52ca59e8a34mr41630e87.0.1718279446136;
        Thu, 13 Jun 2024 04:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLhEgk5PVdiMFlFsN3ltE7pAoZnfjyVgZ6hFXz98dULDmP/AUIKfgL84nHKqB6KbULbimrYw==
X-Received: by 2002:ac2:4db6:0:b0:52b:b349:c224 with SMTP id 2adb3069b0e04-52ca59e8a34mr41612e87.0.1718279445706;
        Thu, 13 Jun 2024 04:50:45 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:45 -0700 (PDT)
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
Subject: [PATCH v9 01/13] PCI: Add and use devres helper for bit masks
Date: Thu, 13 Jun 2024 13:50:14 +0200
Message-ID: <20240613115032.29098-2-pstanner@redhat.com>
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

The current derves implementation uses manual shift operations to check
whether a bit in a mask is set. The code can be made more readable by
writing a small helper function for that.

Implement mask_contains_bar() and use it where applicable.

Link: https://lore.kernel.org/r/20240605081605.18769-3-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2c562b9eaf80..f13edd4a3873 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -161,6 +161,10 @@ int pcim_set_mwi(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+static inline bool mask_contains_bar(int mask, int bar)
+{
+	return mask & BIT(bar);
+}
 
 static void pcim_release(struct device *gendev, void *res)
 {
@@ -169,7 +173,7 @@ static void pcim_release(struct device *gendev, void *res)
 	int i;
 
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (this->region_mask & (1 << i))
+		if (mask_contains_bar(this->region_mask, i))
 			pci_release_region(dev, i);
 
 	if (this->mwi)
@@ -363,7 +367,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		unsigned long len;
 
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 
 		rc = -EINVAL;
@@ -386,7 +390,7 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 	pci_release_region(pdev, i);
  err_inval:
 	while (--i >= 0) {
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 		pcim_iounmap(pdev, iomap[i]);
 		pci_release_region(pdev, i);
@@ -438,7 +442,7 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 		return;
 
 	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!(mask & (1 << i)))
+		if (!mask_contains_bar(mask, i))
 			continue;
 
 		pcim_iounmap(pdev, iomap[i]);
-- 
2.45.0


