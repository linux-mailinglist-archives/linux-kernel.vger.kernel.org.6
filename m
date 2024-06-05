Return-Path: <linux-kernel+bounces-201967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF568FC5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A541F2162C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C94194A6D;
	Wed,  5 Jun 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPSdV4MO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A1194A5C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575400; cv=none; b=MIOtAXxVz2cZKbsIswcpNqhtkRpts5qrHwN5SAL8SBFRdit8ZRf86KvBjxxKl7r74iWQOQ2C8RG5EXiERi76uyJ7vyBWI94W3b/C4Jmph/ueQKhKRDMkhN9w+F8gQZkMPsydnhrIhN51/02v6AfSGEIWY8bhJeIr522w8P6ei2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575400; c=relaxed/simple;
	bh=JHKzjaKvnMGmn24TasdPaKkcQ0DRRNWgFayHL5mcauY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsOUBvcV64CuPkcabnjgwrLh5sAyrmh7HWO6N7SPNyNBgQ71Tw1Ffez32xpaY7AUw8PWhfYXZguzzJ254IJucnQYXK3YIEcmvRzU/Q6pY94a1V8w8gGYiKDtRaqBiDW8WdiMq2gNNJxOp7Sq4wuKAVnFawm1z+vkn/SlsHIGJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPSdV4MO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aq3kAX8nkbuHPE3PafYDv6N/LvIBaqvSpbXV+kCTCaI=;
	b=HPSdV4MO/CWw+bvLDCYhdgJdRSWWZ3jv0sNyZRBeHuoWfeOzUT1KL2I29mAqvakfTUWS9x
	K9leF8IPSLxcTxYzRvLilNq9UkT1oJ8CS6jHXt9KnezVKTHhkXGgxPOzVQW9jEZ5mo97bL
	nBrfubvtKLvZOy9qiOsJybJlggh3o9g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-sxAHiYdiO1aKO6TZJBoWow-1; Wed, 05 Jun 2024 04:16:27 -0400
X-MC-Unique: sxAHiYdiO1aKO6TZJBoWow-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ea940c4061so6865491fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575385; x=1718180185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq3kAX8nkbuHPE3PafYDv6N/LvIBaqvSpbXV+kCTCaI=;
        b=KS6ZLpNCwdBym9mQu+Aj/HbD2XI9ZAcs7DOv9q36C3CT13kD3VDKePWtzp5eNBnGk3
         N/MZ0VXZzTq/Y1zDTa6K7Z1y/lpexEShthA6xJ8SSrxwJJRhFNHMFsxh352q2eCOFiKb
         QJtHUwhwfeim+HpbF0WlLwxyrGc/8AI9GV5M+oXOnj3oBtdKIAUp6kKCc3u8yHylcAst
         Po+6Gc0yMygjsBbzPJckQm3Qv06SJ3QfiC9l5T5YHZReULBdYIWoQf/cFEZLWvkIoOiu
         kry3TJlYWv/r+Y7h5UZQ0saXI3iadnQV065JqYrjG8P0GYSvsPPXR5tZVNicqwTn9TMV
         +s/g==
X-Forwarded-Encrypted: i=1; AJvYcCUE3yPTCTahraJKpRlzUJvwAdR1fiOYufWvny4usfWuXgNmFKQmzsIXqThv1VVGI4POn1XONYsTaY+tFvqOutZI0tE9714va+drlAxv
X-Gm-Message-State: AOJu0YwIrPYZVXSFLQNa5uqPIZRxbp+365RKlF5nEy03mYl5skvaGOMv
	r+x7TQHteb4HiGtzbUoMhvFYFQYsEivPCpBkHH0xHfduH1R5cQyHloTEIg4u7iVigcLE8io+JuE
	UZi80hKTlmrhVwAxfOmtKh9SvqbDPfbPD1Bhnhmh5JHDyDFmOK7d35tjmjjWNHQ==
X-Received: by 2002:a2e:7307:0:b0:2ea:9449:7713 with SMTP id 38308e7fff4ca-2eac7775f64mr7590471fa.0.1717575385678;
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUtE9m1ruCD6JqFnfuBOCwZgT/GH33J2kpoHwk2yAvGJmqDf2EMoDqqUDaKApN4Naw9gsyQ==
X-Received: by 2002:a2e:7307:0:b0:2ea:9449:7713 with SMTP id 38308e7fff4ca-2eac7775f64mr7590191fa.0.1717575385284;
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:24 -0700 (PDT)
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
Subject: [PATCH v7 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Wed,  5 Jun 2024 10:16:01 +0200
Message-ID: <20240605081605.18769-11-pstanner@redhat.com>
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

Managing pci_set_mwi() with devres can easily be done with its own
callback, without the necessity to store any state about it in a
device-related struct.

Remove the MWI state from struct pci_devres.
Give pcim_set_mwi() a separate devres-callback.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 29 ++++++++++++++++++-----------
 drivers/pci/pci.h    |  1 -
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 936369face4b..0bafb67e1886 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -361,24 +361,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
+static void __pcim_clear_mwi(void *pdev_raw)
+{
+	struct pci_dev *pdev = pdev_raw;
+
+	pci_clear_mwi(pdev);
+}
+
 /**
  * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
+ * @pdev: the PCI device for which MWI is enabled
  *
  * Managed pci_set_mwi().
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int pcim_set_mwi(struct pci_dev *dev)
+int pcim_set_mwi(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
+	int ret;
 
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
+	if (ret != 0)
+		return ret;
+
+	ret = pci_set_mwi(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, __pcim_clear_mwi, pdev);
 
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
+	return ret;
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
@@ -392,9 +402,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ff439dd05200..dbf6772aaaaf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,7 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.45.0


