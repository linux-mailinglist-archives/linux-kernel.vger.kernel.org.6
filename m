Return-Path: <linux-kernel+bounces-398396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAC9BF0C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A24A282684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD5203709;
	Wed,  6 Nov 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhPh6hAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BD1DFE3A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904812; cv=none; b=PabnI4Nyf5puaFja+0yTfHk1i4L+8iQXWUOYINlFwLODldDc/9E9eBCyP2nbqPbm+MhyYlYcRQT4os/54HK8hUYWOgD+trIAlC1o0f1adsrp58EUA++Mwh+41Dnf1ButemsSxS83tQcakmvGlcm+GtIWVtC+/OHF/jjScDX84XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904812; c=relaxed/simple;
	bh=VnePaPHmlv7i/nnnyChjq6x43YKF5Ar7+3PST2zxv8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJUp7Pc1IfCT+eKjlE7zAgJFBsb3TjQo1/tHOisE7Mes50pGWkZxeX5neP3CbywLDokogf8orY+iTMQLe1KU9UK89GlKR95P82AFOD6C2b34BVeLozIAfvkNH53cgGutOuCeENM05EGFMF6qaSOK4CbLmWno2iD2btiWRtFkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhPh6hAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730904809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zhNdkFjEuaL+ue96DDquelqda/uA2K1QZKXu3ul/egA=;
	b=DhPh6hAmrleixfpy7mNdCk8NyaFSI72k7QQprGLmjPK6ckRFvKn8SBhfUwkPd4kJoanuxY
	cWTFNvGnmr+3xfMv6GEB365sUAUH9peHrBZcsEcAPVQuIOJZmcnEsZwMTSHLfqYfYYzqc9
	1qh6yzNTDoirxyceDnFNNE3nqaV3mwU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-U9RUgdDdMPWHBa1YFjLeMQ-1; Wed, 06 Nov 2024 09:53:28 -0500
X-MC-Unique: U9RUgdDdMPWHBa1YFjLeMQ-1
X-Mimecast-MFC-AGG-ID: U9RUgdDdMPWHBa1YFjLeMQ
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-718058978bdso6238536a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904808; x=1731509608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhNdkFjEuaL+ue96DDquelqda/uA2K1QZKXu3ul/egA=;
        b=krIZNmw03dtES/jHl1OFxt1nybBojbLHKW+pTlbtyZbcEzL/HGk0Wq/QFBxEm0SpYg
         ENCFutjQuksxp5r0E7aW/u1/A+ktqB4+S01PSxqn5LNfgPcq5u3NMq3IzqIG7jEXcH4N
         bOMmcq41QekX9beAfj4gelXw88Lo7oEr6OxWsMZph+nE3ZRqcRWsnyJ7o2LlqWkximI5
         8uuECQliiND43Kk3IEn+TbU04Jt5KS8Rlsbn1k0bSDf2fTzSxGWA5Astb4ffRf7a8h51
         Hv8ABALtNu5QYRLW+VdYbRGl4dEgXTzn7TcfLtiEMabBxxgvw0au06E1a/bPePcibrDo
         ZK9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVwXUV95gibcSzkS/YlEtLBNfTT6pshuX/g4SDwVBUINaLwi/8HPwHLWz0mbjhYA8xXAuAyC1E6PO/2hI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0PtEcyn1353gHcDB2vMPTXNZXtAI2GYaUuaHYidGGW+4st0b
	4N3Gk7B2x1TS4krroqhCLiBhZnKoxzUeJHXDhQWvyVE4zrSsD4inMtzcr5/bvSyfhg7QwrSuZAM
	J0cbZMHd3NP+G3WKO1uKi+6G1aoDl6wwlbu6nTfKbzfncFeBMI/JKTqe7GicKOg==
X-Received: by 2002:a05:6830:350a:b0:710:f879:a15a with SMTP id 46e09a7af769-719ca25bec7mr20442526a34.27.1730904808170;
        Wed, 06 Nov 2024 06:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsq51w47iT662Km72nLQPeQu8djAs8QboqY5C1WT4nq+oW7/h0uMI2jzD2Ad6z5rq3DVB1ng==
X-Received: by 2002:a05:6830:350a:b0:710:f879:a15a with SMTP id 46e09a7af769-719ca25bec7mr20442500a34.27.1730904807836;
        Wed, 06 Nov 2024 06:53:27 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc69cf6sm2910192a34.26.2024.11.06.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:53:27 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Li Zetao <lizetao1@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtip32xx: Replace deprecated PCI functions
Date: Wed,  6 Nov 2024 15:52:50 +0100
Message-ID: <20241106145249.108996-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
respectively.

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 223faa9d5ffd..43701b7b10a7 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2701,7 +2701,12 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap_region(dd->pdev, MTIP_ABAR, MTIP_DRV_NAME);
+	if (IS_ERR(dd->mmio)) {
+		dev_err(&dd->pdev->dev, "Unable to request / ioremap PCI region\n");
+		return PTR_ERR(dd->mmio);
+	}
+
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3710,13 +3715,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		goto iomap_err;
 	}
 
-	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
-	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
-	}
-
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rv) {
 		dev_warn(&pdev->dev, "64-bit DMA enable failed\n");
-- 
2.47.0


