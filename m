Return-Path: <linux-kernel+bounces-303363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D7960B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602BE1C2269F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49E1BA270;
	Tue, 27 Aug 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf4+64bJ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DF1BA87C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763430; cv=none; b=aqu1TJWvc++IApj/JPDZ5ce1ThxY9KzkneK5S18H5HJxlNm5jeXPql1d/TT86AGiwr3QSHcYQzaGmb1SwqsVJWVK72IVXoWzPkFq5jbtWg9Nh+EKfxPLQ753bEWsCHjv5gUK/Ro+cw0YId9e3016LjDYxE29TynBR02r87GAlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763430; c=relaxed/simple;
	bh=BbZamD6LlCd/Ke7Au06d6ACEbsktPFos16QcBbayGWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRDdxkTL5gN6+x8R242mRClxL1LZ0/5tv2JYCJqB5yfmRda07PVbdDKoa/Lye/soFoEUDCfTXzNqr1AAk/IpufsHcyLuXxKmJod8lgPH258Foxk0iryoWLy35tMAUgx9+t3rcsxWDF2bw1+9X9Y6c7/ZHxLmBWibGwqI+WvLvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf4+64bJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so3656988a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724763428; x=1725368228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOnVyUAI+k+AUmy342rz93t96HsQeIGF39AfJfIncUQ=;
        b=Wf4+64bJiA76dnQkV6GTCWsS0OI+PmRz2wrcsgpg2MYKmltgw9RSYhxTzTxe0t2sDf
         nnkb1ac038Hu5qsIXuSxW5qU6+pqeGxPaE50sTssgi+DWgL4tHe3P0iH8U6UgjH4Qwz3
         ULsHv4wt36/xx4RUY6ew6NMR13smZYTmNqHDtivqt5GgQaMTj4aM87pO55KKFX2fhCNG
         OoCu9FNCVYUYcmtlB0kL5fDP3Rcdj6zDMiXXEN/IV17+T3hK8SbfvpxgCkSURiHVkp+x
         Pw2QL1Yj6vx3B0vL0oxhsSmIvZ6doLSHzKKsbOxASGt8qIfsbzPf6Bw/5x2F/2g//Tnt
         D/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763428; x=1725368228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOnVyUAI+k+AUmy342rz93t96HsQeIGF39AfJfIncUQ=;
        b=jrf8+5t8mzuSoBfryHpMZ68b8NMs+65sne9ABcZbx4Gse974ludaj1FqwYTqptwR7T
         ys1NKGeWxKuueIJqSz07ujBFV0OQTnYpO8rRsm4aF1r6m9cRpA5Kx3qXJfifuhCLW2by
         MDcZ2+9WLXS6mxF+j5K7ABJuxi8bVRSOql+/fELH0rKmHB+n+DPp1sNTDbccEeNn7rxd
         MBJzgOFshImUNCln8i54mAP5ezDCx2po9/wZPR66Vad3KXa3gvVcgeXMILpVRZ5gFYu+
         eXGUyRM2eLG53CTS8YJDzd62zE6iLDZgQCC1K8vPsdK22mKh/dloESyrQIwKA9SMGhZd
         gEPQ==
X-Gm-Message-State: AOJu0YwHsqXxpqgP90k7o63Z+Oyge/DTNK3Fg7APbaQF7EWuPkOjKbwU
	4aDNcgqqx5ryqws7u66p1FmyUB/RDUGzJv1PxwPUf1CMeSEQW+Pj
X-Google-Smtp-Source: AGHT+IFTLAoJWERHi+MiSdIholShXeXkfXIpGUgaYhi4kTbinj7aU/KGiBmwujDgdcH4H6kf2rkLpA==
X-Received: by 2002:a17:90a:8993:b0:2c9:81a2:e8da with SMTP id 98e67ed59e1d1-2d646d4ecc0mr12558438a91.35.1724763428156;
        Tue, 27 Aug 2024 05:57:08 -0700 (PDT)
Received: from fedora.. ([122.180.189.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb007csm14228143a91.44.2024.08.27.05.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:57:07 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v3] staging: vme_user: added bound check to geoid
Date: Tue, 27 Aug 2024 18:26:05 +0530
Message-ID: <20240827125604.42771-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The geoid is a module parameter that allows users to hardcode the slot number.
A bound check for geoid was added in the probe function because only values
between 0 and less than VME_MAX_SLOT are valid.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
v3: Fix commit message and remove redundant comment.
v2: Removed unnecessary paranthesis and changed pr_err to dev_err.
v1: Added bound check to geoid

 drivers/staging/vme_user/vme_fake.c   | 6 ++++++
 drivers/staging/vme_user/vme_tsi148.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..c4fb2b65154c 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1059,6 +1059,12 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d81be8e4ceba..6b6ad781b966 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2252,6 +2252,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.46.0


