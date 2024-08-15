Return-Path: <linux-kernel+bounces-287401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02803952760
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46EE285020
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB453AC;
	Thu, 15 Aug 2024 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jliPxLdK"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913115CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683823; cv=none; b=lf6x3dfBJ3mkmieniEIBtrCmx8x9BJuQEmCDKCzXb/DCizEU4MSXNr61ReOTWMXbUctQWtsnZ3uqQqUx4PbbHKsAjizGD2dw5shR430OhTbxo56qB+hPCLfnPH+PkA8XM/3ycCuARrCwxm9eK2qREp0kw9KyGnvl7Megz9c1dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683823; c=relaxed/simple;
	bh=cUxt0up1TK679P2htGrK886ysRT04vOMzqU3A8VSJ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ec9jj3ycpZ8sKkahF+8Spb8TUNN/dQUDHLTYQ8IiO+yVpA+GzmXwlzeJoxidcGgcPoJ9Dh03vJ44QXsC0/3so0RLP3aCtIORnDjK67SuWzH6hTOWq1UZsQ/RUkr+si2+ywpmoSDn41NthWNRUiRtyYCKmz9uFE6BK3CSvPWfZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jliPxLdK; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5e2de5d78so27949eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723683821; x=1724288621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khMHVPKCTDHVonG/wiILjKhvjw+3YZpJ69x4MahYmgM=;
        b=jliPxLdK0fSFomJaMtGnWBFCaQ2xl2l6y/Ax06UOmfR9CDS6XuLjj/va+skm0g0yXk
         o2DgxYlDFZCWGVHIZbBVMCnFrx9I9WepKpEGRmSVf/Mw0bFHJg4/GB67kFuiL+xnPfvT
         dXffs692L7OW2+bWsciaxYC0iDAJKWveZkDrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683821; x=1724288621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khMHVPKCTDHVonG/wiILjKhvjw+3YZpJ69x4MahYmgM=;
        b=MM34n67zkC74QPDOJexpOdVlquI6Eiu3gzEh7G1G5r0lR5Xe1HQROwrokWnwPeZe+c
         RzsDWHPBx03GTnwGk0xo/V4nHWlyRk7vdb0l4ZJ/yui9wTFQT9OVm8belUvEUexfeqQ+
         Ji8pjfkBfb1aPyrw17AyXvZCShJaG0Cdr6tvuOWbyx4Pxg4Q24iPIGQIv4mCZ7Vz9jTu
         rJ6hcP3WStHYbAewqgiavUOE+8i1OwhR+4s1xMv/4Rnb0F4+KEiFeTiT2YX0jFmqDihZ
         KG1RlflAStj52WEByyQVSq79sPx5xL53MboT/0MfTGG5aUzjcBN06foxTAWijd/OapFe
         2gIA==
X-Forwarded-Encrypted: i=1; AJvYcCWK2WNUV6rSdFp0BgjOMDz2PhFN2EUWgUtqlDEWJRVqf1sk1iW/vI2Dv3Pm8akjeWBDX2E+tXrQimENpyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0hdWFAmpS789CFG3YqKcRiWY5SUBU9aNu1kJiK09qtScjbzq
	BUnpCxqzzz/bcWTt5wvCyyhLRO2sPhgD3UrQPENwAXtzaL0MJLyPdnSJHafJ+g==
X-Google-Smtp-Source: AGHT+IF+8XgKQDkaXk0vfQAks7fyXcwVXvAv57Id3YITxLxh/ZxwgsaZs42QqdKu7qhMO+nTdLC4Iw==
X-Received: by 2002:a05:6358:4883:b0:1ac:f436:c8ca with SMTP id e5c5f4694b2df-1b385ac1c24mr111855755d.1.1723683821360;
        Wed, 14 Aug 2024 18:03:41 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02c7e1sm24485285a.15.2024.08.14.18.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:03:41 -0700 (PDT)
From: Philip Chen <philipchen@chromium.org>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philip Chen <philipchen@chromium.org>
Subject: [PATCH v2] virtio_pmem: Check device status before requesting flush
Date: Thu, 15 Aug 2024 01:03:37 +0000
Message-ID: <20240815010337.2334245-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a pmem device is in a bad status, the driver side could wait for
host ack forever in virtio_pmem_flush(), causing the system to hang.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---
Change since v1:
- Remove change id from the patch description


 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..3b4d07aa8447 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to send the request to the device if the device is not
+	 * acticated.
+	 */
+	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
+		dev_info(&vdev->dev, "virtio pmem device needs a reset\n");
+		return -EIO;
+	}
+
 	might_sleep();
 	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
 	if (!req_data)
-- 
2.46.0.76.ge559c4bf1a-goog


