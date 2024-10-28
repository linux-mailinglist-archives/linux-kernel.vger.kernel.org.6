Return-Path: <linux-kernel+bounces-384604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7959B2C32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09711C2205B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E831D1724;
	Mon, 28 Oct 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2Ow7YgB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0261865EA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109622; cv=none; b=eQaXbGDQwvWesSxNtsdpxWyGBtBxwetA3swL0IUU+6vwX9VVDqnd4uqjXVeUea8mk5b7kYolDojixnGMeCAu2s3OZr59KgZ6/FIppu+j8RFWissWFqB8VcmOe366jqZXjHCZRg7zuoEyUX2QZrkcV5S4iWc1BIpoR9JQFol+ZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109622; c=relaxed/simple;
	bh=cVMe9I+xf7ecSwjH1FSm/7gF6HNNdaU/Br9lzJNXdTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmPvDiARV0tvS2vYfBBKb8S+flczKz63r1GLgNDPfh5EpDSE40gFHzQ8lWCKvlkdpgPxWa2Gb9EwrlfX3WnfuIOARoDd3aePSPZfQvxj4ufOe2iKMrXY7ct+0ixUtiNjfABreN+1daO6KN1cg8Ps5LDAnv4KNIdi+7/z9Mveu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2Ow7YgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730109618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8YpabpOTIA5fu+COziF12YDYMmgu6EaSPVt0xaySJZw=;
	b=V2Ow7YgBpnSslSIkNtXg6gwHyQkUvcdYvkt2ueoWDydAccphuLu2u36nDJmd9VZUTIkIDO
	xMuFc7tVMFaDp4SybpIxdEUxASKqHfOY0Bsu5FUHJJpHe5Mqgrd4Yevi+TV80r6L2ii5Bl
	AXLg3FKAloRsOV1OqYEmbn/v5ims3go=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-zdtcv0wYO--Bs2QvYhOldQ-1; Mon, 28 Oct 2024 06:00:17 -0400
X-MC-Unique: zdtcv0wYO--Bs2QvYhOldQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so2022512f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109616; x=1730714416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YpabpOTIA5fu+COziF12YDYMmgu6EaSPVt0xaySJZw=;
        b=cZmRTGhrP7Rrxh+ASztsrEt0bS75XN7Eb6hyVQyPfTxDZmFRL1hiUEK5oCELp95xJL
         WlQrpuUQiWoYkcqFNbkw3vXcFC/Mjqawx5iDo99QPd+vcX57f8DyDUkLkDmfT9ROS19u
         cYmyJ/aRtHzxRML+L0/00qOQcail8HuePKDi8qoz6JQ7ddGRYATO04kJpFCHxC2Cp311
         ISUYKBsIfEdERMWzeLsXmSQ+WG8YBkYF7THKuDIdWQejlbFNNzIOkPLJezzgVHnD3ubn
         oHKI7tQe9Zs8Lzbac/yL75gJx0J22urtprkj7zZQ+Pwd9g+gvszyZoDOTdggVMclac8l
         1YKA==
X-Forwarded-Encrypted: i=1; AJvYcCWCRYVFpfVpKLyQGDH7Q02SBdgIuBT23LGpza2NfFHBrgt0PVNjrnZqcoInjY8ARO9b5ICkCBAhLuqOtvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiU5nWIbvc8FJ1fGgR3KbT/tmWk69p3lOYxLtK8uaMqlZfgJJ
	DZT7M2XrXWl7OREihK0TsZzc8E47o/lzMUYDVgeOTeBgBWpAON6KzWlBS9vLp20kzlALCzwfTqQ
	RJlH2oxaEVUWEVj9716CLOjEuPj7qtUVMSoICES3wOGRiMerarlru1QU3wv4JtA==
X-Received: by 2002:a5d:4a43:0:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-380610f4bb4mr5224635f8f.5.1730109615718;
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIi6IZdt1MNfNyvMwAD0TZOBvib02WaB4Udm2NRudgqSX5IaZwE0C9f76/Y7ROIYfi1CqIoQ==
X-Received: by 2002:a5d:4a43:0:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-380610f4bb4mr5224621f8f.5.1730109615369;
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm9077706f8f.70.2024.10.28.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:00:15 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] ptp_pch: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 10:59:44 +0100
Message-ID: <20241028095943.20498-2-pstanner@redhat.com>
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

Additionally, pass KBUILD_MODNAME to that function, since the 'name'
parameter should indicate who (i.e., which driver) has requested the
resource.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ptp/ptp_pch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index 33355d5eb033..b8a9a54a176c 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -462,14 +462,14 @@ pch_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pcim_iomap_regions(pdev, BIT(IO_MEM_BAR), "1588_regs");
+	/* get the virtual address to the 1588 registers */
+	chip->regs = pcim_iomap_region(pdev, IO_MEM_BAR, KBUILD_MODNAME);
+	ret = PTR_ERR_OR_ZERO(chip->regs);
 	if (ret) {
 		dev_err(&pdev->dev, "could not locate IO memory address\n");
 		return ret;
 	}
 
-	/* get the virtual address to the 1588 registers */
-	chip->regs = pcim_iomap_table(pdev)[IO_MEM_BAR];
 	chip->caps = ptp_pch_caps;
 	chip->ptp_clock = ptp_clock_register(&chip->caps, &pdev->dev);
 	if (IS_ERR(chip->ptp_clock))
-- 
2.47.0


