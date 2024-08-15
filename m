Return-Path: <linux-kernel+bounces-287358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6869526EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5361C21ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B8257D;
	Thu, 15 Aug 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHDvuWBZ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995B382
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681844; cv=none; b=tA1IbFe/talkPxesm4StlYSrnLZMu5FbEtNWicJarabS/W8wGEcnbcofAcS5kdCoU4x8rO3Ac0x9EmdpU7l8F/Kdc0fRkZ6VnCZJtoQdC3KBxyOPwdAtZtHY74kIra4LWFdM/7CX2cV3GVxHUq+ipjCb8cXjqs2xL6yFqerscKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681844; c=relaxed/simple;
	bh=Ha8WGJZY9OeF9s3cQPyRaZDQfFYebanex3oH+X5N4aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGXfuAJAUH8Som7UcXVKEOJYeDjoZ4GLpJ7LHICuWUUtUtRvIXYapb428A4VwA+Bg1ik7qfx3mma05ctUcynWsURgRhqrUT2+3ayoAoBG/D/CIA5UCKkqQNBmK+lzyjusIfJeE5XO1qfgZ4Lgak0sm/5DrmEA7lvc5KvgsZa1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHDvuWBZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b79bb7705aso559576d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723681842; x=1724286642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwqWhO+Cug5+cipPscPPeRPr4g13PnMC1hmaB4oZB3s=;
        b=HHDvuWBZrTcBJaZHAMvGA+0COyvERT9Y3GKcZEsd3OVT6Mpz244Dm9TAu9p5TdUx5u
         GURmTMkRXiW9ZLNrNGKNCV6W4qGWlp91pPvpLC/tBiQQ3833LuvSQmOox0jaW1ZK0L3V
         6RMMjH/l9UvuqoJ1jdhQnSvmM3CmQNQ4J/nkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681842; x=1724286642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwqWhO+Cug5+cipPscPPeRPr4g13PnMC1hmaB4oZB3s=;
        b=pQoHIW9eQ14/NPnJcka3eRO/u3uBWhBvQNzjX62mSE7IRLt2EuMXogAollFVVQG76J
         l1YzfU3znRf6dQxy3+bAHRQLN8Mm19PCaE2XXzdsa03uq5ad4+PIHBzvCFBfq1o31iru
         ZAVRJsVUxnxUnoBNiO2jsZ5zb9rvB02gst5E2NdRRHnGrQSY88lrh4ZjX9HzLNEm/Xto
         3j/fSsnWH6n1EZMriBbEqPeSA2OECKHeEEjfB5mS/i0n5wAuswfxf7MwAwHibaUBOQ3P
         AJFYuL2prJ99wxqLUPqX77LxyroftO3oIR4BKvhbVZg6f6j19wxajaZNzsjAc7XigzPQ
         XfSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3SCWyS98tvJxJmPT3qOtzduc0dnRnD5OlopIV2XPqlGrkJ5IZvmwHX55qSKaOXhhxGAVAW5OnDIkWsBR2tW/oVFmdhqnBnkiyUGG7
X-Gm-Message-State: AOJu0YznHqjd5jZbRI+A3y4Gqofjs3QMu6uklO6IwhHn+ZR496KjPtLc
	Sr0ryPyC04LFDulgDytN8tR2vx1e6DHNvL1y81U2J4tiGLYT+cOVp2UcpwaXow==
X-Google-Smtp-Source: AGHT+IECq99oEeNU6c2XicrDKqlBtwmbkES/pMaQwdndLSfaYiJNLKbdNT5f3tSXhMqpKC+4qLQKSw==
X-Received: by 2002:a0c:b542:0:b0:6bf:6ef7:c636 with SMTP id 6a1803df08f44-6bf6ef7c721mr6354386d6.0.1723681842121;
        Wed, 14 Aug 2024 17:30:42 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0dcdasm1921136d6.140.2024.08.14.17.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:30:41 -0700 (PDT)
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
Subject: [PATCH] virtio_pmem: Check device status before requesting flush
Date: Thu, 15 Aug 2024 00:30:34 +0000
Message-ID: <20240815003034.2315639-1-philipchen@chromium.org>
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

Change-Id: Icc1d0a4405359fb5364751031589d15a455f849b
Signed-off-by: Philip Chen <philipchen@chromium.org>
---
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


