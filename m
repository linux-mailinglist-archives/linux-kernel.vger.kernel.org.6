Return-Path: <linux-kernel+bounces-307099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074296480F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D271C2270D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5C1B581B;
	Thu, 29 Aug 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZ7ZlKMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B81B4C41
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941145; cv=none; b=a15f53RmYh8yjdMMohAET2GnVMa9oWQDyjKckIpfQsT0HXIMZhjjbSuOsZ+ge83k7Myq3ufXqX4ZB1xsqRRB9wWhFs6hAksTR2DhLaj7KykHRYsc1/055UCIlC8oJkm4QAgKHiDhx4+Gu/20jnd8HM/wjDydLwQ8XOW1UwdRgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941145; c=relaxed/simple;
	bh=DthlLOD0XWT9pUXf24uzdmG5D5JXhN126raQjVqCgeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBIi/qL2+26T11ylkRkVWZL3sWzGOmT/yaeco4Bq70+fmXPW9iLJ2Qd/rg9ZGBD/1OmzQYI0jQ/jZiVaZNz/EHiBIDRC7F+5925X1YWqfncGzCSD09WXRwTQc/bK1S46b4KZYZpUrPAgCwDAXpxLt6V5C+8DP6Q9PC+OUt9FJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZ7ZlKMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt2kRlQoJgJxTzxQjhrYYWN0zj4xz5nEsQIR91A/520=;
	b=GZ7ZlKMgT48O0gwGI7prQRa8WDJvAsnXIOGSxVSJmcNjHsDRcEn0JBNyRBRp3xKzFeq8cV
	15/VuJkaMGwzTdFyHuGtY/9QeQLip3yjSsyYo5Vgsi6OC4fV8fR/YE/0P40cLmGj4vC1VK
	0jqITKNzKQJ1LnbSKrYFso+jr6ZDOnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-eYHQSCjePuelyohDFb6ZkA-1; Thu, 29 Aug 2024 10:19:01 -0400
X-MC-Unique: eYHQSCjePuelyohDFb6ZkA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718d9d9267so580318f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941140; x=1725545940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt2kRlQoJgJxTzxQjhrYYWN0zj4xz5nEsQIR91A/520=;
        b=dwSyfPSsOgLeFVHQGsdUFPdwkXuKqowSo0YOeHwcJXnYCoE+2Vq9k+eRJsIZNydzVK
         Gn4SlFXrS66QMi9cr/l1RMrhIxFNRU3zczItotSdDSChTa+zPIBwR64JV67qbrfBd4SC
         qs/0sh/RxCOzbeziZNE3+yDyafv7leT3ggFvZ4dSnWAd1Kfp+urHwAtTgZQUeDyxzp1U
         cupvfEUHVb32+ZHTSFkvlA0jvsOK1g9KGXnIyoJVZ2LOlAokgFfPQ2xP0USAQ2YR2C7j
         g2LuSWEBbUkYVtkH99c5w5V2tLpjVuLi6lFQ9i6+5TcXBMnh+QZD9uGQOM5SnJ3Oo4V8
         oXGg==
X-Forwarded-Encrypted: i=1; AJvYcCUvhCfxMFOtHql2jUvQunHZF92Q5ALeUIALcfsRULjyHFCbGuyinJMAHEAmv8RxXck20/ec6+Rw1c5dsug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4cF2zk8IW12Ew4f1EnDNlc8pNdlJl3IZN7lPH5TycvcIys65
	zEg2w21UC6Dj2Xvsj5DTOfCC7vClQrN6YhvFcFyopUdUcFH8R9llPuQgVpotwPqfxYBcFFFnGQ0
	EroZl0STs5Dg4x1f92Y1K/i9fFNfQcZ9hfuSuMVpC12KkD0od9q7uVyLyBuu8fg==
X-Received: by 2002:a5d:588c:0:b0:371:a8a3:f9a1 with SMTP id ffacd0b85a97d-3749b52ec54mr2845185f8f.11.1724941139754;
        Thu, 29 Aug 2024 07:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVKE4GA6MoFtMHaGld6Pjw11VpfoD8Zbo28+LZWJJjSK41LEicR+xodyvjjYoPw88n/IlaOg==
X-Received: by 2002:a5d:588c:0:b0:371:a8a3:f9a1 with SMTP id ffacd0b85a97d-3749b52ec54mr2845129f8f.11.1724941139264;
        Thu, 29 Aug 2024 07:18:59 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:58 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 7/7] vdap: solidrun: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:26 +0200
Message-ID: <20240829141844.39064-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..2b7ff071aab9 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
-
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
-	if (!name)
-		return -ENOMEM;
-
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -594,21 +583,18 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char *name;
-	int ret;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -656,15 +642,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.46.0


