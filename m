Return-Path: <linux-kernel+bounces-201963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAC8FC5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F41B22395
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4D19004E;
	Wed,  5 Jun 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ0bE7tA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5A1922EC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575393; cv=none; b=Hial1CgLUvqIbabO1BLLV4J3SQZ5JAKHsUMXQ2MR5C5TfFUy79+PMbdduEcxQzchl0tcw4DBsSWwh0HgranU3BiGO0exiKOQKM7cJ+r+GcJOutAaVN1PIVg4B0EeDH/Olh9CtzYIaqY2TQbLnyiBcKixKfX29QBU9RTyj0HT608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575393; c=relaxed/simple;
	bh=2mEh5RHmzkYaPBcMwiiWhHuqTZ5Dnp5rad7ZVzxAHNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNU9QEFTCqa2pS3ezlU2tGskaHcVI+KGFIju79fv5wb7z0MOcB7rfZuBTlZ00FcM8F6uLAigTRqSeQzk3u/2O4WKr9LggAmCcErDYNULWeb9iXFJTjNjAGKRuCVlfkO5JzZT5nQs6+08TMUYDWDZO/0TvYkGBf0KkZGlbgUuX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ0bE7tA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8EKelm4Vr/z+BAYmppwUIfAU+aHPoZvlqPBVkyBuTo=;
	b=TJ0bE7tAcq10VtKVgADA4P1GNmCYV0OFtJ8ktGw7vSuF4bzg+UKhceojgqRbKCCQ3JRoVj
	fJhE+tP6Kx2KRSU3SZY+KI67x0hqGBxEMARfSaqIUvhSH3gxkneIiIX+h/8USfIc4k8buE
	NIGfEJ4E2kqyQPLQlgt8PQM6nLenDVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-Gqxcuy8xM3q-icJk41GUSw-1; Wed, 05 Jun 2024 04:16:23 -0400
X-MC-Unique: Gqxcuy8xM3q-icJk41GUSw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35e532f32d8so213640f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575382; x=1718180182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8EKelm4Vr/z+BAYmppwUIfAU+aHPoZvlqPBVkyBuTo=;
        b=PJhblfqP+I47EzgOtNK8eOeMXnKi+CgU/5JSTDEuBb+7N2iy6NzQn6x6f0Uh14+A+i
         3x3iydC4FmM0GMUt1xTeNQDJt7Thmtewf9xzuiKpM62oqW8MMblvtmPwLz/5A46BHJJ+
         KGkytUXKnjfjpuSbJHdJIHOWI4AY8QZ0fU8QrGEK1ojsK9EmVb4QI+eUCH9BPdT9P57l
         QUUVq7UVAhEyzEDksn+14zOsH/gvbdZZnbNCvRW/PVrcENgFbMSFRdLNr0rhip+Yd8wN
         AB/gMqocT1erO911yav6rT05cfI5ekx0w7vi8L7DT7YpEEuoPPvEcxBDDb5dFHTdkl2O
         CQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCVrV+sFK0hDGaRFMrVa7KTai3LMUeua3rQiM9PgEorQ/V8cZ6aSUqkdaDm8O6BmKQzlcQT3LaSXVaKHpCo4EwyniWRckYYcukTM2zbZ
X-Gm-Message-State: AOJu0YySqV1UpdO+HHWQww4VAJmYGBtG27fglo9qLVIpNnSG/wNpecIp
	lXA5Uac+Exr8anMvxgW+1DUcLRrfWBABIZ+F/aNEkokAdBcSS+P59zdYwbEHt5Ypqmss+nRH5Q4
	YCIlHu18cj23g0TPs/Tq0xC9yoMM36ApmUHsZlGnalqFHdpJyvxHKRCzBCwe2Aw==
X-Received: by 2002:a5d:4a8f:0:b0:354:fa0d:1423 with SMTP id ffacd0b85a97d-35e840559afmr1138298f8f.2.1717575382444;
        Wed, 05 Jun 2024 01:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUebdKcHHSvFhFyVCS++cJOWzefX/LKmBJWeBrOSXnXJYMyOYfKcerBpQ0n6FW3HDKgKUtbw==
X-Received: by 2002:a5d:4a8f:0:b0:354:fa0d:1423 with SMTP id ffacd0b85a97d-35e840559afmr1138268f8f.2.1717575382085;
        Wed, 05 Jun 2024 01:16:22 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:21 -0700 (PDT)
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
Subject: [PATCH v7 06/13] PCI: Warn users about complicated devres nature
Date: Wed,  5 Jun 2024 10:15:58 +0200
Message-ID: <20240605081605.18769-8-pstanner@redhat.com>
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

The PCI region-request functions become managed functions when
pcim_enable_device() has been called previously instead of
pci_enable_device().

This has already caused a bug (in 8558de401b5f) by confusing users, who
came to believe that all pci functions, such as pci_iomap_range(),
suddenly are managed that way.

This is not the case.

Add comments to the relevant functions' docstrings that warn users about
this behavior.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c | 16 ++++++++++++++++
 drivers/pci/pci.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index c9725428e387..a715a4803c95 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -23,6 +23,10 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -63,6 +67,10 @@ EXPORT_SYMBOL(pci_iomap_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 int bar,
@@ -106,6 +114,10 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device(). If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -127,6 +139,10 @@ EXPORT_SYMBOL(pci_iomap);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e4feb093f097..8dd711b9a291 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3897,6 +3897,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3947,6 +3949,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3954,6 +3958,11 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -4004,6 +4013,13 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
  * @res_name: Name to be associated with resource
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name)
@@ -4012,6 +4028,19 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
+/**
+ * pci_request_selected_regions_exclusive - Request regions exclusively
+ * @pdev: PCI device to request regions from
+ * @bars: bit mask of bars to request
+ * @res_name: name to be associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
+ */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *res_name)
 {
@@ -4029,7 +4058,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4061,6 +4089,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4070,6 +4100,11 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -4401,6 +4436,11 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED!
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.45.0


