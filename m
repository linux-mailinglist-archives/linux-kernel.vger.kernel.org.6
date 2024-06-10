Return-Path: <linux-kernel+bounces-207940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F92901E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5711F23AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBF17BA6;
	Mon, 10 Jun 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjAjzY4d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED2745F4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011927; cv=none; b=D0ejyE3FmJzvNYSVAw3IzpZQXtSTNDyESnEL7U8u9Oa4bbEIYvTLGiJdlKda4Yf6EWacz79VOOk5uQa+IGM8KBDfx+Ip0uPajbyoOgC174KOW+sSYa53qIHx/vQlMlQ5aIVxC/9IvWWPafpVmDDctNrk44JSIU6pQm/M+VrBERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011927; c=relaxed/simple;
	bh=uxWR+cyvQnS6F+Ku7i7pYs3ZA+OagBoxvbut16jkiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTUnFdtUsAWVUokmKMBsWb0UfRjW5xKa+FgsVpkxfecw+EumRAcqMum1Fv8lhkw+d7kX5+Ff5vsn+4DcfWP1QinaWOvBeESheCm285mAjuDgnWm+SRQdkwZ6aID0zjiXflP/bbU05awVnMZKJaK6CTXtntq9PnrHjqWtQ1jAigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjAjzY4d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
	b=bjAjzY4dZQ04UhdkOLzNLGH6i7y/hSEUK/b9wpeeeBKmNcA0GviTq3a0pEDm31G+5q27lZ
	W4RvMcDPnSi23LgKCne3ZHuHCAo4WS82SkvOSNs0F/Hw6ywvuMDgtVdjXkkiR+xyO3SoF6
	yIcRLI3NJbgzaFulQDN4gJUgySwpqvA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-XeSfhOfXOhiqCldYe3d3Xg-1; Mon, 10 Jun 2024 05:32:02 -0400
X-MC-Unique: XeSfhOfXOhiqCldYe3d3Xg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4215f69475cso3516505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011921; x=1718616721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyizp71aDVZTVSj1hEgGPWD4Zgvxaje3MhAhMHAAQDo=;
        b=o7TIt4yvTdaEEmBNiiNSu3upEPluLOCiO2kgWuoMq91/dNmeeJ2xJImq9d6R+QLOrM
         PwYX/i6znPKwTtDgtf61HsuV0GUkk/qhk7R7P9BEXV6xFZljLYu+kRwjT+s0CEmJSBco
         dP6rmBLbmRBatW3Az/fKL2gc567OqWdHORF704NxXXMI0rEulItjHL4RPwBLhmNzYShn
         8dEbzBKUDh6UUxH1QhKxqwtA5BLkxDrB6TmGSWiU3Tkf0ui+lGPbJY8g3HgBRxGFG4aQ
         DNubH81YY4UkVdE+dKYv9Hn1qimyOX58ipSy7Ys0+os+VGgaBGyn81yvHI8yAARqbNvc
         20FA==
X-Forwarded-Encrypted: i=1; AJvYcCX2H7v5/UDGFx/t5BkYDTiDOs/wr3rw7oqJacGWpi9PawCIEagiqY8m7DtGiPrAKqFyWNDFzqAaM0IeGtrwq6TQe65oe/BU8169E+SJ
X-Gm-Message-State: AOJu0YyVS40OGTZAxWTaqEkUIK1i25Ukc8DbdoxbcXtlE1fUhIRpJEN6
	LMJ8E+muEVWpBZQKhyi2yOM3eIMv5PhDPrrhtFnf7meIWEUCKoPT9z2lyg15nVqOsruDpq0bhuE
	oVNBuiifDeNdV1QcCV2uKar34p53d9FGvPpjqtAt2g7u1i2o3g63r+KG/ZvvAMg==
X-Received: by 2002:a5d:64cb:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35efee307bamr7423570f8f.5.1718011920873;
        Mon, 10 Jun 2024 02:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBB6YZLiS2HIy0dE82G5S8NImrCKfK+wiAnir8JXLqf86PoMnWoXCllIT/8+SHiawccCY93w==
X-Received: by 2002:a5d:64cb:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35efee307bamr7423555f8f.5.1718011920534;
        Mon, 10 Jun 2024 02:32:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:00 -0700 (PDT)
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
Subject: [PATCH v8 01/13] PCI: Add and use devres helper for bit masks
Date: Mon, 10 Jun 2024 11:31:23 +0200
Message-ID: <20240610093149.20640-2-pstanner@redhat.com>
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


