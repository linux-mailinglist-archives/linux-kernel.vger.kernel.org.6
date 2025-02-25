Return-Path: <linux-kernel+bounces-530600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F6A435A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6ED1793F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E425744F;
	Tue, 25 Feb 2025 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HZ/TbVv0"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642492561B3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466130; cv=none; b=hLhrUTkV/sBh4xCua7kSkhqfv1jIQtO1kcnqpfcqfbn6g5y44OoBmRMPPTE9QW2HgIbXX5aVuc3qZmKfQRLBl6AFDa2WJKOVfTC4flTf9HGQIMlB8H3WJNYun/XNRKlpsIKdylnE2+uMbUNwQZADKIrC/Y3s4fSCzznMAynR4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466130; c=relaxed/simple;
	bh=qkNshxsIu1VNvGOtXlviStG5GAuRjYKkl0IXRJMBtiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9pQ8jCfO9lwIzHJygYGs17gNrZf7IQybeNRIWSaj1ZhOEptw34MhYEJsp+68gJzdOb1WbhPpZE6ou7yowK4jUJg3b/VqVQNABW665CRuE+4o+S3OH6H3rxDSvCT2xxjM75QbpuyK5cVeDgt6gptc6EDyT5lN5aG6J2WmuW2yH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HZ/TbVv0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2212a930001so29813975ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740466126; x=1741070926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ0t40lf3Zpqp9U9xvw/UOaqAJ7hNs97Z58vlfZM6bM=;
        b=HZ/TbVv0oyXvprNKlgQZkgKIQ6TFkNJU7nOW5RkBAMeccOFHMM1n3oAjjeb11KhWFD
         R9ZCP9c5bDHRgD1ePOnmrFJ/cFPzE1/3YSbpglrZuYRchiNhjVMVNzNvef3o9WWwsRVn
         E/zzR9N9bi8yuxc9hLkPd6+Fqwka4tJjL11bycH0JdCPcB81Qgzb8ImVfyiqx8j+MznQ
         yZKl/NJx9FloSdyaqdoMQX1/wjsLB7wv+LNtt7lSJURiV0SHLtc9fRf2pIOIr7/k/usw
         UojHVknvfBRQQRIdQJ2kz3YPWT86F0tJFERy5yVIWMxlOwJQAg3TOe4qDbHoYo0jIsBP
         /Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740466126; x=1741070926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ0t40lf3Zpqp9U9xvw/UOaqAJ7hNs97Z58vlfZM6bM=;
        b=DiwlcXOC6i8MBpsfkWch2Yq5l8zJ+lhX1bCEXnVudCFR+g4k3lw3XlHZ2UDtPA0Xnt
         w1HUa3p1ohau+0FoWJ7JH3y72aSAxggmSDNkcU1094ioU9pdpgH/G8Y7XCxPJQoXUbrE
         WSlA3EaieK8+nq0a4VMQqIPfEBvYaAiBZlvvAXXGJHBM9hE17Vux4+xvmpWMZVrsr66v
         80ygbf3Y3MpaqwR+4mqDTzSw4R4hGswB74BLEKGpiHkuRxavFvwA6ip7FWVreMKiOfUo
         xiYlDLWJmmV5gD/kFrtWmim5Rv/8/ULzRVqY+p0As1K6OO9JIVZHZq2+r9F9gCLpYLUx
         JkxA==
X-Forwarded-Encrypted: i=1; AJvYcCWL6O7w07T44Ls0DVwQXvHQMSN1HkOz6ZtnyRrB+7UMvLZnmaamn7L1cohxhSINBGOHrbCnqrdPjpV5XeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPkzZIw1MJ34s0YLlrSbJP8Wv1L1K2m1yGCUey72k0HFah2Xj
	n4Jas8vAz707HOov2dYzEPSvXoLq+MQ+VEneMCrObU2pEaPtxWE+dT5Bw//1GNI=
X-Gm-Gg: ASbGncuq88oxlFruhPpdgb+TS1qBBMnUJW+qCaVmZFfkF3yyNXrFteS0TIrsbtOx1JD
	VrNI/dDxFCobjqbO2qbqjf7w1CCZxWsU2VRFBbWIb0GM+jMrLIbjBjkuKDTdwQdNZYogJ8xZMgF
	XnMabrX1FwJKKTuP/BPn/358rM/mCJ0Xfl8dzCQehJsFYPZ+QMn+/Ty9o8FvlmrM8GKQDzuETsx
	GRRiBt1dBqjcD1LXhyzPnO5g1A1O3EeuuMmau1SkhkUqG5JsKqeUpAKj/0BsVvlp8tcjGdRXOrs
	87nB7Tr+619AYSPMTDLbtJmHXryMdSOeb5T2eFh1s1TNCSlJ+kSeinabTh57
X-Google-Smtp-Source: AGHT+IEmF+kunrtV4SwQahUfF+lqeGQraTMFNE8ukoY7seNYajrO7afhAsgjmW/AtFIgoZ9t/QM0lw==
X-Received: by 2002:a17:902:cec8:b0:215:b190:de6 with SMTP id d9443c01a7336-221a0ec33a0mr200283845ad.3.1740466126612;
        Mon, 24 Feb 2025 22:48:46 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00a8fcsm6903775ad.53.2025.02.24.22.48.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 22:48:45 -0800 (PST)
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
Subject: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Date: Tue, 25 Feb 2025 14:48:31 +0800
Message-Id: <20250225064831.63348-1-cuiyunhui@bytedance.com>
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
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..6d9f2e56ce88 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,16 +2871,12 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
-
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
 		iommu_disable_protect_mem_regions(iommu);
 
 	/* Make sure the IOMMUs are switched off */
 	intel_disable_iommus();
-
-	up_write(&dmar_global_lock);
 }
 
 static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-- 
2.39.2


