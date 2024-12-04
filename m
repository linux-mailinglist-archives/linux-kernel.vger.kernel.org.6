Return-Path: <linux-kernel+bounces-431832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FDC9E41DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83932839D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB491FC7C6;
	Wed,  4 Dec 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKjxTBqb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8F1F03FF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332250; cv=none; b=hAF6LXDGiq/akBVvvRLhN6pVEBgtCvN4B7r39bEeVBBE/gGKrYZw0yukQML2eyj3qWCOONKG5dHrLPreDSp9YqvCHN11JEgChghizn1aoNCdPRkLbIQm1SHGBFJzocGmiEnKZvIgM5RAfRyj447pV+vM34Kjvw2DvaXYu9hG6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332250; c=relaxed/simple;
	bh=6TTwfGPFIWFczOWcfnDq+V9viCPV7/G6Js5yV44vQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2DDLsm5hTbIwUowngpf6AMcWsZPpni4wNEwW7N1wFRqT1PaVCItMevuHKz8wRQD49k2AK35TYPzpx5Td/HQuYTeDTxIMA+SMdYNvTI9bekXdMmi8zxbLyITYWvPzF8RRLmEs8DNQ/bOqsf1ji1gL6kPHXdnyDGV22JMHFR9+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKjxTBqb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG1/2+soXrCZJT+4aLn7BzvFulsaukH4/7W/e6kTCqA=;
	b=AKjxTBqbdFqCnpuycoxrLAgXliNsNvTkVq9eIh71zXNB5csK9Lu3zRvTbAhxUkR71gXHr4
	d+smdfBFI0yAjkzxbGbFNgIVhFK9oxaLAPsWlES9J+FT+EISsKPwsNWmrmAb1e2ysZt/rk
	RrVwdQvCTwhQLm7TO8z0sl+xFsDHfGs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-s_MwofKKO8Gd2yOy8weCyA-1; Wed, 04 Dec 2024 12:10:45 -0500
X-MC-Unique: s_MwofKKO8Gd2yOy8weCyA-1
X-Mimecast-MFC-AGG-ID: s_MwofKKO8Gd2yOy8weCyA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385ed79291eso618548f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332244; x=1733937044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG1/2+soXrCZJT+4aLn7BzvFulsaukH4/7W/e6kTCqA=;
        b=LDcNPsH6ETznuB/ybGK0J88dYFJpAsBArxtrsRyREn9msrLMXaK+UJ+PF5pYAFUG3v
         LQE96j9BCcmB3Oiex7+JME1duDlRQzLn1XKAIx4hNeo0UHs5KLJ8QTbEgmjWRaPEe/Pu
         O4YNTMy+p75XzgCsx229Goh5hLfkwG5644hEuccbhUpj1M1LVqZL3ShQTE+Sr2eD2i97
         BVFfpsC2NV82oUw6GNTt0AHCqkItkYQhZyJH56BUT/ytvC82BU8Nb5JFqerNCIkaXfxm
         TRPWv+zUeMHhxlOd0dBcksOQiYGlbMGm18X83/9FYV5pAOQwp5djEdWkb7V939H7Q8eD
         54XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZXy9O/raiktiviFS2RP5wSf4HdYCqCoLe0jqcz0recB9tOyHN9LoHtSlO/nTzk6Quei3aLeQj9fWfB34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFhAoyQdRX6gQCUqZMGLTUjY20DshAEulEDTyj9M6m6JLGZm1
	kamItpoC8HlpsRNL7qLATa9TmFCvemWsRRvcufmAwHj+go7pzHycG/EdQWGrSmxI5Bi66yuRQQX
	6UBRZrFZ+L/qDK5rwDZUcda9uBO1hGWt/uOJbkqNo2Y38PlV0tx8Mb9ENCincTkBTXCz/Ei1Y
X-Gm-Gg: ASbGncv8NXEuhPYBvOCxxwMUwiTl6glyMPCrmWvVGEp9gaLW95qnMaLyti3SwUORrlZ
	AaCGjvalWJUS2nY+js0jWdP5QhYqADl1WxXlRxH2R9IAhpCK49YNvLik1Kl3/x6xjc1fA5CD7rl
	iAC5EF/vEFPdBQNjUrXHa8GinDrvFmq7FZ9T1aEQqbReOIb2GtyWwEsPQHI4jjyhvMGWTiIrasU
	tX5UebXXIYxdtD1R4lVjvIMTKvZl++eZZoaC0uuMXiql9XisfAEMyWLc3Yramuym8gAsS5m6kW8
	L+J19jKG
X-Received: by 2002:a5d:6daf:0:b0:385:f79d:2196 with SMTP id ffacd0b85a97d-3861bb84f06mr161790f8f.13.1733332244556;
        Wed, 04 Dec 2024 09:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8gqG0x5z6r+CpCNJZYk6IwXVAInAa+0ev2uqKnvVIxSzQStTv5+56YC+HQsvFIshU1b8iHg==
X-Received: by 2002:a5d:6daf:0:b0:385:f79d:2196 with SMTP id ffacd0b85a97d-3861bb84f06mr161763f8f.13.1733332244246;
        Wed, 04 Dec 2024 09:10:44 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:43 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 3/3] libata-sff: Simplify request of PCI resources
Date: Wed,  4 Dec 2024 18:10:34 +0100
Message-ID: <20241204171033.86804-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204171033.86804-2-pstanner@redhat.com>
References: <20241204171033.86804-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() has been deprecated by the PCI subsystem.

Unfortunately, libata-sff uses quite complicated bit mask magic to
obtain its PCI resources.

Restructure and simplify the PCI resource request code.

Replace pcim_iomap_regions() with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ata/libata-sff.c | 130 +++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 67f277e1c3bf..1d2273c0f447 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2127,6 +2127,73 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
 	return true;
 }
 
+static void ata_pci_sff_set_ap_data(struct ata_port *ap, struct ata_host *host,
+		struct pci_dev *pdev, unsigned short base)
+{
+	void __iomem *ctl_addr;
+
+	ctl_addr = host->iomap[base + 1];
+	ctl_addr = (void __iomem *)((unsigned long)ctl_addr | ATA_PCI_CTL_OFS);
+
+	ap->ioaddr.cmd_addr = host->iomap[base];
+	ap->ioaddr.altstatus_addr = ctl_addr;
+	ap->ioaddr.ctl_addr = ctl_addr;
+
+	ata_sff_std_ports(&ap->ioaddr);
+
+	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
+		(unsigned long long)pci_resource_start(pdev, base),
+		(unsigned long long)pci_resource_start(pdev, base + 1));
+}
+
+/*
+ * ata_pci_sff_obtain_bars - obtain the PCI BARs associated with an ATA port
+ * @pdev: the PCI device
+ * @host: the ATA host
+ * @ap: the ATA port
+ * @port: @ap's port index in @host
+ *
+ * Returns: Number of successfully ioremaped BARs, a negative code on failure
+ */
+static int ata_pci_sff_obtain_bars(struct pci_dev *pdev, struct ata_host *host,
+		struct ata_port *ap, unsigned short port)
+{
+	int ret = 0, bars_mapped = 0;
+	unsigned short i, base;
+	void __iomem *io_tmp;
+	const char *name = dev_driver_string(&pdev->dev);
+
+	/*
+	 * Port can be 0 or 1.
+	 * Port 0 corresponds to PCI BARs 0 and 1, port 1 to BARs 2 and 3.
+	 */
+	base = port * 2;
+
+       /*
+	* Discard disabled ports. Some controllers show their unused channels
+	* this way. Disabled ports are made dummy.
+	*/
+	if (!ata_resources_present(pdev, port))
+		goto try_next;
+
+	for (i = 0; i < 2; i++) {
+		io_tmp = pcim_iomap_region(pdev, base + i, name);
+		ret = PTR_ERR_OR_ZERO(io_tmp);
+		if (ret != 0)
+			goto try_next;
+
+		bars_mapped++;
+	}
+
+	ata_pci_sff_set_ap_data(ap, host, pdev, base);
+
+	return bars_mapped;
+
+try_next:
+	ap->ops = &ata_dummy_port_ops;
+	return ret;
+}
+
 /**
  *	ata_pci_sff_init_host - acquire native PCI ATA resources and init host
  *	@host: target ATA host
@@ -2148,59 +2215,31 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
  */
 int ata_pci_sff_init_host(struct ata_host *host)
 {
-	struct device *gdev = host->dev;
-	struct pci_dev *pdev = to_pci_dev(gdev);
-	unsigned int mask = 0;
-	int i, rc;
-
-	/* request, iomap BARs and init port addresses accordingly */
-	for (i = 0; i < 2; i++) {
-		struct ata_port *ap = host->ports[i];
-		int base = i * 2;
-		void __iomem * const *iomap;
+	int ret;
+	unsigned short port_nr, operational_ports = 0;
+	struct device *dev = host->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct ata_port *ap;
 
+	for (port_nr = 0; port_nr < 2; port_nr++) {
+		ap = host->ports[port_nr];
 		if (ata_port_is_dummy(ap))
 			continue;
 
-		/* Discard disabled ports.  Some controllers show
-		 * their unused channels this way.  Disabled ports are
-		 * made dummy.
-		 */
-		if (!ata_resources_present(pdev, i)) {
-			ap->ops = &ata_dummy_port_ops;
-			continue;
-		}
-
-		rc = pcim_iomap_regions(pdev, 0x3 << base,
-					dev_driver_string(gdev));
-		if (rc) {
-			dev_warn(gdev,
+		ret = ata_pci_sff_obtain_bars(pdev, host, ap, port_nr);
+		if (ret > 0) {
+			operational_ports += ret;
+		} else if (ret < 0) {
+			dev_warn(dev,
 				 "failed to request/iomap BARs for port %d (errno=%d)\n",
-				 i, rc);
-			if (rc == -EBUSY)
+				 port_nr, ret);
+			if (ret == -EBUSY)
 				pcim_pin_device(pdev);
-			ap->ops = &ata_dummy_port_ops;
-			continue;
 		}
-		host->iomap = iomap = pcim_iomap_table(pdev);
-
-		ap->ioaddr.cmd_addr = iomap[base];
-		ap->ioaddr.altstatus_addr =
-		ap->ioaddr.ctl_addr = (void __iomem *)
-			((unsigned long)iomap[base + 1] | ATA_PCI_CTL_OFS);
-		ata_sff_std_ports(&ap->ioaddr);
-
-		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
-			(unsigned long long)pci_resource_start(pdev, base),
-			(unsigned long long)pci_resource_start(pdev, base + 1));
-
-		mask |= 1 << i;
 	}
 
-	if (!mask) {
-		dev_err(gdev, "no available native port\n");
+	if (operational_ports == 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -3094,12 +3133,11 @@ void ata_pci_bmdma_init(struct ata_host *host)
 		ata_bmdma_nodma(host, "failed to set dma mask");
 
 	/* request and iomap DMA region */
-	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
-	if (rc) {
+	host->iomap[4] = pcim_iomap_region(pdev, 4, dev_driver_string(gdev));
+	if (IS_ERR(host->iomap[4])) {
 		ata_bmdma_nodma(host, "failed to request/iomap BAR4");
 		return;
 	}
-	host->iomap = pcim_iomap_table(pdev);
 
 	for (i = 0; i < 2; i++) {
 		struct ata_port *ap = host->ports[i];
-- 
2.47.0


