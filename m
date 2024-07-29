Return-Path: <linux-kernel+bounces-265442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CC93F14B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A661C21A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3B1411FD;
	Mon, 29 Jul 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF3Ey2Xw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FA140363
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245828; cv=none; b=BG7mYkDf3U5evamCig7d9QFSfwtHP/KiWStsB+VEBlq3p5Jb8eHGkvG+mgDkKfZSK/c/0t1EEo4f9JRQyKafuWhlXtazB1aKGFhi9+4GKhn7Uo7GNT9VPsOrEQOPt+anVO2o84LYtfyZ0H11iwdLFGyEvvDIbVPj06Zj+CtSK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245828; c=relaxed/simple;
	bh=sOPFbdAZcLvZ5+tla0cjE7R9UahwXgYuHDOyDiiXoq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9wkPLUlA17/ll1cDhhllaxIYgRaVrTldhU8YOaRpNup5B9l5QR+q5fg3709Gtnk900qjurt2XSwsGvoUzQYkZ/MuFeAotyuhKdhl3mI3iDZoeZH86Rbe6Di/KiPNH5umZ5T55eOBX+YDzQF4VognzXQP3mxvUF+zrJAe0WZzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aF3Ey2Xw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42kYX+we7aWmN9i2s2pGfyq6/m9TDK9MaaqQ5jcnuoY=;
	b=aF3Ey2XwdBCS7+RKsj3zsQN8qP3gZmPHMpl8BK1VRiQ2o6sXh6+Uso2E/CDgrqRyoNWvCY
	S38Br4VVxOYHlqbmgDbSvU7BYy3TDFlTRXTlZ7a4Tw1uK/khM/n1xy/MVmQD4szITh8uZF
	KYngftd9ZeuL2C/oK8CVdeWvZ/7RxUQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-XPE5vhrJNNuvcDS6Wg3ipw-1; Mon, 29 Jul 2024 05:37:02 -0400
X-MC-Unique: XPE5vhrJNNuvcDS6Wg3ipw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7b1d79bacso6528066d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245822; x=1722850622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42kYX+we7aWmN9i2s2pGfyq6/m9TDK9MaaqQ5jcnuoY=;
        b=tc+RGGrgSjri79C/YH0HI/I6wvyRsBqZoHo9MG9a1phe/r9XlkfijxE9fVtUAx06uW
         yIEp88kPiZknxcwI2MAuWIrFHtF+KyFr29JX9oo9Sx19pxRUpdR5sTWNa90r+lKUJqFF
         goBL/EI6PnqcO9A+c1D9U/sSZP/nZCE9UIBMWl+T2SCaVPIeM3G3IVCK84LnTZIGEMnD
         mRrLFVMRji+Sw93CpjqQQVF73kL9mdgfg9Mff0ODglpoBVdpRGIC3FMrbESVXaV1a3fG
         F48W5xBDz5yqY1X8LxeuvZqcYvCRAIznvm9gIGDahBY/MYR0CVtnz5nKMdM0SJRcyVoX
         N19g==
X-Forwarded-Encrypted: i=1; AJvYcCVhyXFJg7r4ZGHCTwwS9iY5JtuNZKKFiNYff2HNeav4P+4QlR74rVyrK9KsAYtrZVU4++rRtDSZd7SBqflwc969SPlZ3PMylghDdgk0
X-Gm-Message-State: AOJu0Yy/2XgrHCMbJLnxzvBnhySJIn0JjOH9D3l1bMVNRIidmM6mHipy
	gAk6dCVNJMyKNN4RzaI0PQuoe+LegTaV4nFywezzTXvjfhZespMzuxLNoDdMfG8gyeNc0Bvp6ZZ
	VBXIZKwxC1/di1vf87AjkR3jYV3jUiyuoQ07gO+JMD5PSehGXUCZiXJ3m4YEntw==
X-Received: by 2002:ad4:5f87:0:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6bb3e38b497mr93633326d6.9.1722245822100;
        Mon, 29 Jul 2024 02:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkPP99cFbQc6WSD5piny1t+VTMR84B7lZvZiZJT2aKKHRfx8A/j8DuWgpWI66gNwcsld6zA==
X-Received: by 2002:ad4:5f87:0:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6bb3e38b497mr93633256d6.9.1722245821694;
        Mon, 29 Jul 2024 02:37:01 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:37:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Make pcim_request_region() a public function
Date: Mon, 29 Jul 2024 11:36:26 +0200
Message-ID: <20240729093625.17561-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
References: <20240729093625.17561-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_request_region() is the managed counterpart of
pci_request_region(). It is currently only used internally for PCI.

It can be useful for a number of drivers and exporting it is a step
towards deprecating more complicated functions.

Make pcim_request_region a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 1 +
 drivers/pci/pci.h    | 2 --
 include/linux/pci.h  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0127ca58c6e5 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -863,6 +863,7 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
 	return _pcim_request_region(pdev, bar, name, 0);
 }
+EXPORT_SYMBOL(pcim_request_region);
 
 /**
  * pcim_request_region_exclusive - Request a PCI BAR exclusively
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..2fe6055a334d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -887,8 +887,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 #endif
 
 int pcim_intx(struct pci_dev *dev, int enable);
-
-int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e36b6c1810e..e5d8406874e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2294,6 +2294,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.45.2


