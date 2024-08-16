Return-Path: <linux-kernel+bounces-289280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81F954433
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9329E1C2097A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1615572C;
	Fri, 16 Aug 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arzs1D00"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040114EC55
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796614; cv=none; b=IKPdG/yFy0y99hWHmi0iyCej4O9flaevwlUa/VG8bzSB7m+4XYZMHRMpiB56ddd+GKF/Z7TfzOkp3O67L2G1jkayhAt/V8Y4opZ3u98IF/NFNP7SVvw2OvLoDkdcNYtsgtKP24UbBsBd6FbVg/TY4HCePqGzaD61TZ7s70nUJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796614; c=relaxed/simple;
	bh=eSFUZ1JCsMVzaieqrfZ6sP42002jGDiUhoG3EeqHIyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDq5MwUNFEg6MS2rPkL5y9jjHioBpIx2rwKPAIRrlmV6M+JXyvuba0FdzE2R99VdkH5WF3BDMi6mYD7le9I5pK6f6X7H55jZYg7d0+iI/xY3r/2srifR/PrbvjNaHh87mDFLHEs8S6+zyYN84rZtwjofr6rcKrftXlqZJImiq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arzs1D00; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/TWDUwF4muPiT/wIrowwWqBmpjVYWuLvHzzBlgJVA8=;
	b=arzs1D00NIESGn4E/Dkpj9vHGi76FkR4/p9p45XbCRRBDRuRrIquMMyZwaNjuRhDgracIx
	DdKcMNsuYYA9o/52SkGQ8vlzOujE1lZEJohJ43VF2yHlCaNtAm7cEhXB6w5w44vqs5hK7e
	QRbK229eD8Al3utXKXZpb7NpAUoR9XY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-VswjCq7SOcOoD7qirSGPWQ-1; Fri, 16 Aug 2024 04:23:29 -0400
X-MC-Unique: VswjCq7SOcOoD7qirSGPWQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4290cc01eb3so2932765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796608; x=1724401408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/TWDUwF4muPiT/wIrowwWqBmpjVYWuLvHzzBlgJVA8=;
        b=fHSYMjmHYaeFhTrj/U+RodSWr31QBnj8gBByi1lSFso5aLmqRmD8a819AI+z0O7L/C
         aMuKo53iQTOIIJBHcDRTDbfl5Engh+jsCoavd5xSDiwQZOBomze4f86zQ/1oAJQA5cku
         6En1g77XRnMIG43whgTt4IZbO74kPVapuUVpw8ObY4NU+uj8bfnlZG8V69ujcsdiUrC+
         dQNp4rrNVxEW9fYGsebxvOQ4FoMlF6q/+6b9oUMxR4n4BY4vgW/odU9SbrurTqvKMmo2
         SSVCFF/rWBi092X8J8kLeIcpxwOS5VTcPRArDJA0G14HY6wayolCKk0HPnC2BZKURPcq
         skPA==
X-Forwarded-Encrypted: i=1; AJvYcCXEZICwODWVO058JhPzUU3LPonG1lM4j3cO5x4obnL0+wXYoXwsdguSd0RpQDKSTt2YoZTeOnFEpHid4VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecE3JKfDtLaoWlCBKVXVlWnzjtZiFwoomRhIjOLPXy6+gzEf5
	yNySqNF8wge6Wp8E/niMBimdDM1yfvzbO9W/1w5RJwQwegQ8zkOrsZJxfW2MrJuiCCSVfJuN8yI
	LhI543JmOlFCW4rSrZtbtl9zFtBUP3SJlyWQZmbziQxWQvAgdSzlosol8WFZtmQ==
X-Received: by 2002:a05:600c:3c89:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-429ed81ef7dmr7718405e9.6.1723796608214;
        Fri, 16 Aug 2024 01:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIAo2an9uYuqB4ahCNPXZI8UwawbGrjuMMGbskgXu9LAjCjingMPPNd3Qcq6DzQwqmUyfoww==
X-Received: by 2002:a05:600c:3c89:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-429ed81ef7dmr7718215e9.6.1723796607736;
        Fri, 16 Aug 2024 01:23:27 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 07/10] ntb: idt: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:22:59 +0200
Message-ID: <20240816082304.14115-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
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
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48dfb1a69a77..f1b57d51a814 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2671,15 +2671,20 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	 */
 	pci_set_master(pdev);
 
-	/* Request all BARs resources and map BAR0 only */
-	ret = pcim_iomap_regions_request_all(pdev, 1, NTB_NAME);
+	/* Request all BARs resources */
+	ret = pcim_request_all_regions(pdev, NTB_NAME);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request resources\n");
 		goto err_clear_master;
 	}
 
-	/* Retrieve virtual address of BAR0 - PCI configuration space */
-	ndev->cfgspc = pcim_iomap_table(pdev)[0];
+	/* ioremap BAR0 - PCI configuration space */
+	ndev->cfgspc = pcim_iomap(pdev, 0, 0);
+	if (!ndev->cfgspc) {
+		dev_err(&pdev->dev, "Failed to ioremap BAR 0\n");
+		ret = -ENOMEM;
+		goto err_clear_master;
+	}
 
 	/* Put the IDT driver data pointer to the PCI-device private pointer */
 	pci_set_drvdata(pdev, ndev);
-- 
2.46.0


