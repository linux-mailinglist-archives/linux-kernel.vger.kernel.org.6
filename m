Return-Path: <linux-kernel+bounces-388581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE59B6194
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B657B23251
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833021EABBA;
	Wed, 30 Oct 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVAxjaG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A31E8823
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287706; cv=none; b=nD2Jc7Om0CvhyS7zJYyiYewUT8CKkRxFXvM2ol7fu8+e2wiIxFS0LPkTkw/bFjQOzgXwa2yDY33PY6lVe4XkhN/wNETqIuRCRPNzskP4I71e+dVAH26nhfkZc+7dfM/qXS0zUnLSBgV3lym9SopFk71BjC1lm6MDz9oP5YRdbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287706; c=relaxed/simple;
	bh=YCSleCRL8+zgmB0F5bhpOuGHDhDr1YVS5o/lIBwlqhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHaezfC5dsm/K0mKg4wx9hz62HmDW8nq68BmCq6/KftjMfczQGrCAEU3xkbn76igxP9UqZtW5Ni86WIChMjjpDKrLFY89AzWJmqT0jYHCEut5QoP0G0WREemh4hiCp/4CTW7qXLPNOt95f7MViPnAG1ncws8Ir4Osr9kkixG5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVAxjaG4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
	b=EVAxjaG4Z4CAWwFRwkChz+W3EM6JNQi5hf+smGKVteSfT7wjRSWox7m2mkc/juG7d5122p
	qbMEU9JzoVzJjZNAcxdT0ivWDxo9oXg7vxjUr+gB3unXwiymfk7OTo5e071BnPOnBngVNT
	mF+F5BNwzJuuVbUv3nACXRc1Slcj2bk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-q_Wl-dzXO1eQ115R3tXChg-1; Wed, 30 Oct 2024 07:28:20 -0400
X-MC-Unique: q_Wl-dzXO1eQ115R3tXChg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539e0fa6f3dso4940458e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287699; x=1730892499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
        b=pPB/KUJpii5lHtXOuXo0ekYQADJPUU0Mhie0kWdmUqWOQs0dzStxr+fCKgNfEp6Ini
         +Kq9NNK7nCpZPieH7M6WFYQlriS5JIqW49Xag7L310XXBkpKrwq6xvqoW8P05bejlurz
         GNgvVxWi6PXmT2o0+OUJBtfV3PLCNWXDAlT2p5K2EHpqUyBnDOjAhINQn6xTluVEwMfb
         T0h52pnmWm+s04tO0BvJRxMir1jFBvaVwNGj2G+TVMzOzg3Mb0GrSlrOy8/FECCRgMo+
         SmV4gVkln8NSYg6Wj7nFBFlvhGsuq1aG5br66Sot453X9ePSiOmPwDEjImqom0UrGQnA
         5O1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXItkCsHd/frrYrvEDzlxf8hxl4268jZd5zqiKsSsPkEPOdgFYOGBc1OWwR+JYD3YKI2Mv2wcEDubNStwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz7M8WyT6fI3NIA4SLsaU+xOpUr4YoVbhgiKWyf71sTodIKyd
	Rs771U7N4IaotglbIiL9tW+nffPGfD+gYBt6JWyl0VFLtwf0yFCTtjgvKUZIZyZ7rnoDxL4XE9H
	IBTfGycaPCoBFbEQI1HjjmctyGBCNPvUt/FxtOq0duGu8Fh5q+cqI8x/nOKMO5A==
X-Received: by 2002:a05:6512:3d06:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53b3491e062mr12333061e87.38.1730287698745;
        Wed, 30 Oct 2024 04:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBPHC+7mDGBZejhuxNPIAbldUy5rOv5CXnQgrngWn35PZTJpvTSwKiUrRZBkTh6tcloHeZoA==
X-Received: by 2002:a05:6512:3d06:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53b3491e062mr12333000e87.38.1730287698209;
        Wed, 30 Oct 2024 04:28:18 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:17 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v6 03/10] crypto: qat - replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:36 +0100
Message-ID: <20241030112743.104395-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c | 11 ++++++++---
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index f49818a13013..788a11cdb34b 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -129,16 +129,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 659905e45950..115eabfd1f6b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -131,16 +131,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
-- 
2.47.0


