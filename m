Return-Path: <linux-kernel+bounces-541054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A1A4B7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F17D3AB434
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56E1E51F8;
	Mon,  3 Mar 2025 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZuxHgKI8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B25156237
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983079; cv=none; b=U6QLM/AZC+hRQQHjAHKhvAq8IoOnEAbh9fgyAypUTDWwMcLugt9TxdZeAJYxb7OANUqBNdS8+FE5jy3ZF4SowBdFuAGuoZXqmTdl/4gZvjn4K1QDP9HUBfdFSL8st+ttthMUdO9g8pJ/qrn/DdmXWZm2XN/pw3eU6ZRbp3lMv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983079; c=relaxed/simple;
	bh=EFHcnY604PxZcDX9hfXViUWhnTcEbotkGUIzzO6QMHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FBCjgwGjj14PKqu3WDpoeotjhccCnyXiZ7GsxgZE2cpPcKE7m81Fd7BUysnfZNK1qGFW9nflbsZcP+zvN0qvOd1ZWaGS2rPGU22IMI+mTS04NJg6P7VkT/pvPj9ZOYEDJix0VGvu0Ktye7OC8XbY83PrfDOlsUs6GyB9y/5t5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZuxHgKI8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239c066347so16633995ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740983075; x=1741587875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRPqvj/QlUv2dtShmOMDUHzRRPiCU0B09cpBuKE4KUk=;
        b=ZuxHgKI8DvZpkH2TiP6TDJGd2ehgbjTxjdCF0v3Cf76ii2+ew6h0Sal1JiYmU5DBvY
         ydBR2ZHOeK9KQvpq9BOt0VyuugnOdeStViVFbtqdSPLC6nrG22sgIQWOV4ZASzPyT+Cw
         eVXLJR3t970VickcJMVd3HDBP4YsBwya2wXBlQEkmgoUfCDQlMCzwbESWZOCEkJiNYjl
         x4SDactqEWqoJww8oEra17T8ymC8JG5uYhRAfr8dwf7r0RUKCoA6ZqqVTQCC8yXhsY00
         8TVoFKfPoPgqROxtyH6Vb1BLKKE/xSvxVdX8Vh/ZTWwvpaCTJwni8NmQID+vuDqAvSnu
         HVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740983075; x=1741587875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRPqvj/QlUv2dtShmOMDUHzRRPiCU0B09cpBuKE4KUk=;
        b=f7EIVpwefMIi9YQPt6Vz+O97QoliK8SpqLz0fjO7HlrRRAY8WZ42ITJFI5nYDbT1Wd
         lBckdE+xz+ws9vPJrvxhPW4+U7WZqCm8GX1JbdmYAZPKhf9MtCn3F18Q6cV3yzuEL4PW
         33fgkoqYsWeyi+m2HKUgZ5GeAD/+Npw3WoZJzCIi++waKXwm8cfbxdgffL6gi1p85x1Z
         LbwIdflKJ0O0vK/f7rhG9M0g6oY5IDCGrgsdHJSRTOOL2j5q5Q1/rTapiOI+5AvC6/I/
         w5YVVpwuj7Ji+S8kYk8VTKflYd3N8/rxT5Di2llyRCF9ZAz3qj1d35iu9s+XApaqiM6Z
         W4mg==
X-Forwarded-Encrypted: i=1; AJvYcCXs9rVNGlg7bJaFc0NBoS6ft2WYBsN90YZHf5xgtQd86HCBrM8gaLztJrXqURDD7S1wPi3L5qok4tQRNwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEi+NKm4ZPGsmEEHFqZUfIwq6nPREYJoaJ5HFOuyjBO54JlSIo
	vVFqHO6iuquSLKO/7HtLrwvU1CVoFfK/tjI0bcJKjsvfPMAPIKdzF15VQ0S0Dm8=
X-Gm-Gg: ASbGncttD5JZZlTGLHeM5Ai+Y14hkVJZwnLQyIDYHiw4BcraLPu1QKu3Os4QJ7dHHGT
	GiBfmiThqLIf7eVXhLfEZwN7vkATuOp0rIFwEF0pm7WWovBhbUsF3/Pwx3+cqrjqMAojCfPYxC8
	hQyv/0qM8vomzO4y7VIax+vp5mbARJWuuzeCm6weD0ESR/jk1T35jFgwsCvT25vT88TaWL67+p1
	0uBb/JLv7Gy+06iXyfj/PTjpvfV0/yYmqFterrd2NqM5Absq2dUhdTmmkllKNpE0JhOCbcfuI3X
	mVQ/15zz4HlHXvn4C7UthTouu5/wv3D2vwCvvTBwycQ7RH27incO46L6tpZtou5VQiu4E+020dQ
	mAIb4N3wu
X-Google-Smtp-Source: AGHT+IESh4grNErcs4++ANOa0SJQc7p6X5v8H9Dq1ufSFbL0K9GWmhRDomZrzfEl3a6jzkJkwrNomg==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr152240345ad.3.1740983075253;
        Sun, 02 Mar 2025 22:24:35 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d329dsm69791145ad.27.2025.03.02.22.24.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Mar 2025 22:24:34 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v3] iommu/vt-d: fix system hang on reboot -f
Date: Mon,  3 Mar 2025 14:24:21 +0800
Message-Id: <20250303062421.17929-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found that executing the command ./a.out &;reboot -f (where a.out is a
program that only executes a while(1) infinite loop) can probabilistically
cause the system to hang in the intel_iommu_shutdown() function, rendering
it unresponsive. Through analysis, we identified that the factors
contributing to this issue are as follows:

1. The reboot -f command does not prompt the kernel to notify the
application layer to perform cleanup actions, allowing the application to
continue running.

2. When the kernel reaches the intel_iommu_shutdown() function, only the
BSP (Bootstrap Processor) CPU is operational in the system.

3. During the execution of intel_iommu_shutdown(), the function down_write
(&dmar_global_lock) causes the process to sleep and be scheduled out.

4. At this point, though the processor's interrupt flag is not cleared,
 allowing interrupts to be accepted. However, only legacy devices and NMI
(Non-Maskable Interrupt) interrupts could come in, as other interrupts
routing have already been disabled. If no legacy or NMI interrupts occur
at this stage, the scheduler will not be able to run.

5. If the application got scheduled at this time is executing a while(1)-
type loop, it will be unable to be preempted, leading to an infinite loop
and causing the system to become unresponsive.

To resolve this issue, the intel_iommu_shutdown() function should not
execute down_write(), which can potentially cause the process to be
scheduled out. Furthermore, since only the BSP is running during the later
stages of the reboot, there is no need for protection against parallel
access to the DMAR (DMA Remapping) unit. Therefore, the following lines
could be removed:

down_write(&dmar_global_lock);
up_write(&dmar_global_lock);

After testing, the issue has been resolved.

Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
Co-developed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/iommu/intel/iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..47c74b20d342 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,16 +2871,19 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
+	/*
+	 * All other CPUs were brought down, hotplug interrupts were disabled,
+	 * no lock and RCU checking needed anymore
+	 */
+	list_for_each_entry(drhd, &dmar_drhd_units, list) {
+		iommu = drhd->iommu;
 
-	/* Disable PMRs explicitly here. */
-	for_each_iommu(iommu, drhd)
+		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-	/* Make sure the IOMMUs are switched off */
-	intel_disable_iommus();
-
-	up_write(&dmar_global_lock);
+		/* Make sure the IOMMUs are switched off */
+		iommu_disable_translation(iommu);
+	}
 }
 
 static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-- 
2.39.2


