Return-Path: <linux-kernel+bounces-384644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030F9B2CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BD0282997
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D531D5171;
	Mon, 28 Oct 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7wJXbIH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4A1990AD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111087; cv=none; b=CChMGsoziDuX668VUjM9R+Bkan1GWArteXQgk2WbSPrb0W0UEXKsVD4+4GxcPByd1ux6jlaPE5NWA/R0L1y2IvOmDwPZssfs93dh8rjCm5RgNE7XC1N5vd9NrATB5JQpTyxB/prB3zD55NrHWnOQJSEYZ5dG/LnLdnmx30R5mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111087; c=relaxed/simple;
	bh=PSXcW8y52t+sS2GK5KwCBNYCko4EWdoLOtCU9synXEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MspvjUNCRvibtpq4FxXQuKO4IboHSEPPfMydqW31uoNBnu314W0oey+p25AOq2ktufeHM29B13Tgk/6m29MNIORxKk40VLU8oWZ1EC/+yy2CD1ho05coEtw5WJDboKcbmlN6HlUwnczS4a878ZlUd+vDRh0aM50gJXrZDj5mR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7wJXbIH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730111084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xc/RGz11YWPABh0H4B1/0347FqzAk6dVpdVvZMq9SS8=;
	b=S7wJXbIHtH1eCJtA/mjJOzfSp3d+URhpouGWsZYuYaA8fB8Yi1E221EnTDXBDt5r1ihuH/
	qn+w4GC14qE898r4xL4R/zWNvTE+/DM9Emd+gQjBNNq30yzughj3Rf9pGJgV//3VlC4xwb
	Ytmr6dlJH6g+l7b4rzzc3PzyCmW8Jwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-OZt_YqqIPUq6eN0npqc2Pg-1; Mon, 28 Oct 2024 06:24:41 -0400
X-MC-Unique: OZt_YqqIPUq6eN0npqc2Pg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so2175629f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111080; x=1730715880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc/RGz11YWPABh0H4B1/0347FqzAk6dVpdVvZMq9SS8=;
        b=kzQlUThLqkwbKMs2ojwGzrm/3E8j/M+k6LYiOB7/K2mWEh/muiB1sLY5ccUXXDZLHe
         mUGBHKFB7CCoKCR5Zbl52/zRN344WzWSylJsKvYx/Zbvx7E0uTIQFLnxErqby6B8fz5Z
         X+Pz8U66C956l1z4b8rSz61QaYogG9VV6RZEm8AASuSiYDterqFA3eL9Pyi7Fgowh7lD
         1xjfFVE43abk46/fJS3iVblaAC9Oyn38VYHzYUPX4g3BT9ukE3hRMSqoMX/5k9QSR2V2
         J4x/Srg1Lc94p++132ULQj+GxvzUs+tavfE+Y03v+PLayIQYE5iZqIjfaf4hcsJPptT1
         wt3w==
X-Forwarded-Encrypted: i=1; AJvYcCWwEbwBfnCZkwbOatGMhO6+j8LlwVQFUPNY8IHXAfsPhUrF6t8jaN8dVgBhQB2w6nPQ5WhsKKLSAQPxdr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zl/8MRW9q6L2n1ksp5wYyO4tSWUfDifVjV6TS5ol9qyCrDmc
	LfnfuAg/ZhjgeptvNq2JTXHI1RjXHiMsnVevgl9I97yENf+OUT72l2AfKAtdyp4xCXNBAhB3Ft2
	DBZp6AwGmrTHl1wRS0jOLZ2yzaNbJLWcs/g57mzfHJvXCBGh6m0A5pqii24SQeA==
X-Received: by 2002:adf:f106:0:b0:37d:3dfd:cd92 with SMTP id ffacd0b85a97d-3806117dceamr5365154f8f.28.1730111080018;
        Mon, 28 Oct 2024 03:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGExDH7Nq1hm7ppK1jbeRo2k+cJOHRjlhoUA91SFSHg9aqnEaUekKi+z3ICfdmUg8xcIHYp+Q==
X-Received: by 2002:adf:f106:0:b0:37d:3dfd:cd92 with SMTP id ffacd0b85a97d-3806117dceamr5365142f8f.28.1730111079680;
        Mon, 28 Oct 2024 03:24:39 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595c51sm103279845e9.20.2024.10.28.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:24:39 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Pedro Sousa <pedrom.sousa@synopsys.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Minwoo Im <minwoo.im@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] scsi: ufs: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 11:24:29 +0100
Message-ID: <20241028102428.23118-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ufs/host/tc-dwc-g210-pci.c | 8 +++-----
 drivers/ufs/host/ufshcd-pci.c      | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/host/tc-dwc-g210-pci.c b/drivers/ufs/host/tc-dwc-g210-pci.c
index 876781fd6861..0167d8bef71a 100644
--- a/drivers/ufs/host/tc-dwc-g210-pci.c
+++ b/drivers/ufs/host/tc-dwc-g210-pci.c
@@ -80,14 +80,12 @@ tc_dwc_g210_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	err = pcim_iomap_regions(pdev, 1 << 0, UFSHCD);
-	if (err < 0) {
+	mmio_base = pcim_iomap_region(pdev, 0, UFSHCD);
+	if (IS_ERR(mmio_base)) {
 		dev_err(&pdev->dev, "request and iomap failed\n");
-		return err;
+		return PTR_ERR(mmio_base);
 	}
 
-	mmio_base = pcim_iomap_table(pdev)[0];
-
 	err = ufshcd_alloc_host(&pdev->dev, &hba);
 	if (err) {
 		dev_err(&pdev->dev, "Allocation failed\n");
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 54e0cc0653a2..ea39c5d5b8cf 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -588,14 +588,12 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	err = pcim_iomap_regions(pdev, 1 << 0, UFSHCD);
-	if (err < 0) {
+	mmio_base = pcim_iomap_region(pdev, 0, UFSHCD);
+	if (IS_ERR(mmio_base)) {
 		dev_err(&pdev->dev, "request and iomap failed\n");
-		return err;
+		return PTR_ERR(mmio_base);
 	}
 
-	mmio_base = pcim_iomap_table(pdev)[0];
-
 	err = ufshcd_alloc_host(&pdev->dev, &hba);
 	if (err) {
 		dev_err(&pdev->dev, "Allocation failed\n");
-- 
2.47.0


