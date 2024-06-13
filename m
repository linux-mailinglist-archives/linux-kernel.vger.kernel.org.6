Return-Path: <linux-kernel+bounces-213141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757A906CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ED91F2682B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998E1494DD;
	Thu, 13 Jun 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZscrAdky"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2C148FEC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279461; cv=none; b=V23Z2O1qtCmP2VxObCJ1cGdaXHZOdTqNEHTrzEC96uuihEf1/0EHMW9uJUqJXL499Ln5qBxoKWIMH5MYcheIe02EAkwW5AkTCbMVMmmnInlZ4nm5bPYhKBqhSFcqgK/VuR5VJE/0FwENzm3uYQP8Vz8qJ7GYM9JUvO05F9Ojyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279461; c=relaxed/simple;
	bh=MwGxicOTdTG5eVnpyN9pPmSLSF5RFtnjndQbPoUTe1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX4FW60yDaemorjnhpKBU3AZNfoMuxfdaX1zi+ZTRT+pfj9+pBhQFRcWTeA9EugRaQ0Wxgm8dGt+SjaflR+d2DWOJGZPzaacchT39ZrooqtFoj+5jdjbk1O1lZ4+R7BDPI11TsMZB62hY/UU+wT71pb4UmjmJ5NQawLhqUzG57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZscrAdky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh8+O2F7jgAFtGp/MUXcCP7XcWz8NnTH6l7tP4PdYbo=;
	b=ZscrAdkytuizXlRLjQRFgt3xqaczA8XoXyeoc2EdSLbWJowhfsWRnr7XmIlvKiwkhLd+V9
	XDmscMIWP717gXFuGJvzrCk2+TVjyt7TxCGwdO7DarrIBNtIwyBQL+1jVc7hipjNVQyC51
	Auif768ud4poYzjDe64yV70yn3MVCP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-o7XV-61yM5Ki2tFy16rr1Q-1; Thu, 13 Jun 2024 07:50:55 -0400
X-MC-Unique: o7XV-61yM5Ki2tFy16rr1Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36073543200so107624f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279454; x=1718884254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kh8+O2F7jgAFtGp/MUXcCP7XcWz8NnTH6l7tP4PdYbo=;
        b=SSm1IgE7QyGykZt2iEshll5pWVPZ4EbXUxEIadw6cZqOEyBQYGQB+GtEtc6oBqqjoS
         Jr/BLZPxEuPEVy9bus9oemw/CRnYlvOgk/t7F7gJoeuKDsEhBK5Gw3qM61gRrJDbp5p/
         0Tcm0yYwNaVYXO8UNAKVl3rqcTGlZ1hGk7xitLnB1xspIzeCDBuWJJAJqTwNVMFCDNhs
         Fr1F2y3LO/o+VzBEzhAxzqMo0A4H5f+gyQH9N+FASlwEXub8AOMpupbN8BgAbCrFmsdP
         7nCfwLTRpPuaEuvqMWbqDV14MfWv84XhfvJaAB/QqOU0+VBxq73M94Q2FtMcocORZ4lS
         2yJA==
X-Forwarded-Encrypted: i=1; AJvYcCXvdSynWaFPSvtjRiYAYECJoiuZTrDBlyU5lHZbct0EzzCmHs1g9CXozQqAXNkPcfK3tNwOWjufGjjcPKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDY0SZ59j6T/O1iBCJl8qB4jBpfF6N0848weHCFhZBaj8/TTy
	NXiOBIxWWblqvhBjTFgVmAaGaSm2W75Br0BrRcpWudJNtq/SpujZF6UUs6Qs59KgEqwy5CKmVpD
	NpUj65Q9SreE2JC+9xK8dTskTOXwYhdP19B7Yfhyz4KcRKrnK9TWhAs4LkOi/Xg==
X-Received: by 2002:a5d:5f93:0:b0:360:6f5c:f5b3 with SMTP id ffacd0b85a97d-36079a6be34mr198411f8f.7.1718279454632;
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWMTtngZAgGMBECTjwydMRwQNlXRtCSyH8PxV40YfOhooXvc8s+2rU6f0CqUMNMS0veU1KZA==
X-Received: by 2002:a5d:5f93:0:b0:360:6f5c:f5b3 with SMTP id ffacd0b85a97d-36079a6be34mr198391f8f.7.1718279454381;
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:54 -0700 (PDT)
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
Subject: [PATCH v9 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Thu, 13 Jun 2024 13:50:22 +0200
Message-ID: <20240613115032.29098-10-pstanner@redhat.com>
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
index 84caa0034813..e8de93e95eb6 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -366,24 +366,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
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
 
@@ -397,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e02ba1b5947..c355bb6a698d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.45.0


