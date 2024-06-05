Return-Path: <linux-kernel+bounces-201968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B38FC5F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E292822D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5413194A5C;
	Wed,  5 Jun 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcATQzJ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C019005E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575402; cv=none; b=qOYD+QWD5otFx7cJBK+7Kc1W+ZogHEzzEi7nRZGjj7GpkFc0k/hxWURsMd3dcEMtvI4PTo2ArNOJ8Y224QYS/YUKdOPTKcDQA2zi3XcwTgy+neJlOvgjB8sCC6dqN9pKTEesMfXX0HUlcCgKgJOngf3W+yC7HdcTUQmbxfSUS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575402; c=relaxed/simple;
	bh=tV49a5+qMkVnfBuVcqqm88/YXQEYCtYEpLyZHAId3eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0tDQOS4fF9et/f10uvW7+igkV6Kcs3/Gb2lSOecz4XJq8Zjb6lsRmBcHCQ+ihjgF0IKG+XJoHsOQMhG0wYu3swEebwN6aKas8n14Mc2sK1Ce6eSAHbpbTmt5DSoyh9xROnQ79oGqZ8TLJU8hy4v4Q7TkRE7UP8amy3cEXYIfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcATQzJ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FprLruSafewJCGyfXmuQwDL1Jg/OKDGH6ODfzThcTic=;
	b=IcATQzJ38ppLBxal9GgpUxwy3M6wOu/dOQgOaZhpBIjXqfcGGhsFBME2uvGfw6I1aZDJDm
	ZpuTulessRW0CIzTHEbUnQ2ZiaouEYg1XnfxSAFtKSmzA4LG5vmK5WVTUqdyaME3oURJJt
	KFGQIseBiLeNOil3iDLsY/8upy46Sb4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-1AQwBByBNyiGHy7cOxeRkA-1; Wed, 05 Jun 2024 04:16:39 -0400
X-MC-Unique: 1AQwBByBNyiGHy7cOxeRkA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68b839d30fso15033666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575398; x=1718180198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FprLruSafewJCGyfXmuQwDL1Jg/OKDGH6ODfzThcTic=;
        b=QuWc6JXb4kTB7BnoLEA3l/nbaoh50W/HrnVktjaEC7xOTMQbMGyeoNHYETFOizmyAK
         er4sEnU1cHqpSb6YajjolzcR/vy4vvSpqVC++dK1kEhaazCg1d4VfExLBDH9weyj54SX
         QZlcVGR5S/Indq5+K61WzmU2aSIKXII0LZskzfCcJ8NfPxuiRqpTDkzuBSw0XwDe2HZD
         3desoiGfeae3ZrA72mCNTc6gU8ErHBVU8tF204Ol6Vc55r1H0apAMlI1IQsok4BpGo+5
         vA5brpULBpx8y62l1FwW55BT1w1H0F4xxSq4HuKu7JSvScO8Sa87+Uk16GT9WYwO1/r6
         EqCg==
X-Forwarded-Encrypted: i=1; AJvYcCW1kxOJw2KevrC2GujmqYeLYYK2/7HG+eSc7kRhMo6dGYTr2v1W6nOi+WPAb12e0Jv0HKxIKoxsIheSnBF8ZjRVaMji1EMMrWF0jkWO
X-Gm-Message-State: AOJu0YyyKhg8nmYgnChrkKvvnVSDY1mPlF4CYy/tDtnmyVlNV+ziwD/Z
	e2p6KHxUHRrby1KbkmgOdhueGHIb8/VdObAq64MlSq6ET72kwOspYhHQrMNLodhECOf7BwNXwTB
	KN3YeOi7PwSB2Opx4sMBYds1JU63VIMkFvxLN3BXZMk/NhUvrew268Gi/TkMH04EeCsD2FQ==
X-Received: by 2002:a17:906:fccf:b0:a59:bfab:b24f with SMTP id a640c23a62f3a-a69a023e515mr111477666b.3.1717575397914;
        Wed, 05 Jun 2024 01:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH01zzkiwwO2rlaNoVMW4xlWaRAMHnpBHn33IIaKEoTGFWWRSfd/BTk6G3QT5BqGH8wLV82w==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241057f8f.0.1717575377322;
        Wed, 05 Jun 2024 01:16:17 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:16 -0700 (PDT)
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
Subject: [PATCH v7 01/13] PCI: Add and use devres helper for bit masks
Date: Wed,  5 Jun 2024 10:15:53 +0200
Message-ID: <20240605081605.18769-3-pstanner@redhat.com>
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

The current derves implementation uses manual shift operations to check
whether a bit in a mask is set. The code can be made more readable by
writing a small helper function for that.

Implement mask_contains_bar() and use it where applicable.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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


