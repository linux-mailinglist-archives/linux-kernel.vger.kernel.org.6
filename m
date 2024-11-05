Return-Path: <linux-kernel+bounces-396311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118B9BCB54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382831F237D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EC1D2716;
	Tue,  5 Nov 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQcJF7HR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE51D3195
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805139; cv=none; b=Pcxkj21n9s9ENMK/ZnGF5bzdJdhIIwy7BztwYjI7VjWpsSW9qpe7fVa5inU2817OKnIWoJCKCVsTA+wZjli5jUPYlbJGHAcLe2+Rd0u4AZpt/1eiV5i5On1MlYOa83aNXx2+Jyzl2UXbt2nScGIIEkBH7FcFomSKOg0pGqRPTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805139; c=relaxed/simple;
	bh=EUjOR/V1/Ff7FCV0KtVJ6a801ILitSsONPj8+8g6O7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qm64+YXhl9lWu2aWVd/CFHD+9EwF6eRXgiw4bBgwudE2kfe6UnNFwZ1VpJ/UMiIKAglRooKYUrVLWcl2+gRO8b0OSYKY3e64QGQIICXJpJb+A06IHU7yZifzdyzXpivG6KY6GM/UqBCxAJMtOx70/iSH0RtikQqRIr5CM6oo6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQcJF7HR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCvdUfc//ZWvKe194x55fTwuIp9lO3BXGQHJFfiBiaE=;
	b=dQcJF7HRkaQZ90vtbZLpQImlE+I0AGqt/+Zs2ierA92l9+cNmMeG1EELzxL5o4kMPYR6KN
	/yzBbjtytteqIEMcamVMb2orxWU8inRPuCjVwuqRsKxx+2UQoL6/9y+KlFD0ZbWF1qBKP5
	9RaUaKip5ta19OxKAccQuy4gP5Fnsr4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-pJV_URfTOuOCrVgpQ98duQ-1; Tue, 05 Nov 2024 06:12:15 -0500
X-MC-Unique: pJV_URfTOuOCrVgpQ98duQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso2663421f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805134; x=1731409934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCvdUfc//ZWvKe194x55fTwuIp9lO3BXGQHJFfiBiaE=;
        b=X2b1XEsTKUuEUkC89SuWqBNLfN+IAoHkr5p0rxjq/ViBr/6iOX5gRWFTrg67M2duj0
         w4YPcUdT6IgTmrxOkSL4AWm5Jv2z+01J9vWUQhhE05kujebFYrQFysJTdMOUB+XnBmy9
         DsxbYRInzJhoomOowFAK1QY5CXA7zFcaYgqvHJrRDama9tlPlxFDPZMEYHdh6wBrnrj/
         w6myZ9Qt0lnQy31Yr0enNwURBXPNP2vc4JeNm5df1+1ZZgkE+cUjIiK0W+2avePysjjX
         pxd3Do+BKUFGOpRxLRL5DISVzTkvBMi2hmfnFCycJJbbgvgWZ2RAf9rjwghNkB0WBSHo
         WAZw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ktKCtbT6rxvVy2Qlca/OOv8Z8kQjlHY8jCM1zKZ4Yo3nkvlzdHwDVQtCNElt57nWVBDdamK46x0uuCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMW8CeKwlhM2j8i/FjYaP555mQnpaKqt4LXb4ag9n4r8AxdtH
	d8qxBu97hH/z8cSWjFNarSvGm9hGJJYlRrsP1VczfExcK/JgAZXaRnK7oQSX7Ia39JveKdbcbTQ
	sHzoFp0QkzA9rwek3ZUfTYDnEqoHwzTAzzOuRKr+B6VWh9jNa7KxNmElFp3HxAA==
X-Received: by 2002:a5d:5f41:0:b0:37d:4f1b:35d with SMTP id ffacd0b85a97d-380611ff128mr28662024f8f.48.1730805134147;
        Tue, 05 Nov 2024 03:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESHCOZomXTbsA7mek+NYOSWPjCHtTlyjVpOUcf98wwcSXASlnKPOIrcK6yEt/H8DUdWzsINA==
X-Received: by 2002:a5d:5f41:0:b0:37d:4f1b:35d with SMTP id ffacd0b85a97d-380611ff128mr28662000f8f.48.1730805133781;
        Tue, 05 Nov 2024 03:12:13 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4392sm15860512f8f.36.2024.11.05.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:12:13 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] thunderbolt: Replace deprecated PCI functions
Date: Tue,  5 Nov 2024 12:11:33 +0100
Message-ID: <20241105111132.57339-2-pstanner@redhat.com>
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
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/thunderbolt/nhi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 7af2642b97cb..1257dd3ce7e6 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1340,18 +1340,18 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (res)
 		return dev_err_probe(dev, res, "cannot enable PCI device, aborting\n");
 
-	res = pcim_iomap_regions(pdev, 1 << 0, "thunderbolt");
-	if (res)
-		return dev_err_probe(dev, res, "cannot obtain PCI resources, aborting\n");
-
 	nhi = devm_kzalloc(&pdev->dev, sizeof(*nhi), GFP_KERNEL);
 	if (!nhi)
 		return -ENOMEM;
 
 	nhi->pdev = pdev;
 	nhi->ops = (const struct tb_nhi_ops *)id->driver_data;
-	/* cannot fail - table is allocated in pcim_iomap_regions */
-	nhi->iobase = pcim_iomap_table(pdev)[0];
+
+	nhi->iobase = pcim_iomap_region(pdev, 0, "thunderbolt");
+	res = PTR_ERR_OR_ZERO(nhi->iobase);
+	if (res)
+		return dev_err_probe(dev, res, "cannot obtain PCI resources, aborting\n");
+
 	nhi->hop_count = ioread32(nhi->iobase + REG_CAPS) & 0x3ff;
 	dev_dbg(dev, "total paths: %d\n", nhi->hop_count);
 
-- 
2.47.0


