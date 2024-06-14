Return-Path: <linux-kernel+bounces-215013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F0908D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7746E288680
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB5D52A;
	Fri, 14 Jun 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lmq6k/xn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0D17C79
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374942; cv=none; b=pmfLUzfNUOUVBRtcis0VEQvrbxvSnQWbl9eCgfEbjKthAS9w1rJV+WYzZzfwH2VLWuFQt0G06dU14yGk5X6XnML9vB19s/CS8ZgeeYcUid9diXMyWTXTxHREajVeNDCv0YxwGkM1UMTeSPuAcPlVHo2Ilw7ifkIcgaFUX16R6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374942; c=relaxed/simple;
	bh=skj2/BWRX5MDxu4BMRzPV1cfBbCsNidIjZimfPy4/xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cwg1kFSx3/DhNnEIrk+yaqgeEcwxiK5DzmGxnYk9aUnCuuLAjKT+7d4CR0NJ5ZZvebG5LiZyi1k0EZqg3PS/oWCsiJmab0d/FhiVclLDbRBDfRK0FJ6bV6R7qD9O0cjrzhmxrucMiQd170ohtHCU8Mjd1DRltUP+9WC2sPlXUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Lmq6k/xn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f8395a530dso20581175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374940; x=1718979740; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7iZUV99NQN3RgJM91vO01sfzoKXhBrbq1qPqNaXoaI=;
        b=Lmq6k/xnHHKEm2EmYx8erFaet3tZe6n31YPknnqKkZ8LOHBcMoM5j4iCRKw4Mg/Eoo
         57Pn8PCiHIeMObm30+cfxxIHMuCxGzef73j3PV5Qd6inhlDO8dWjf64wcScChcMDIB63
         T1AK6JjqveqP2K/pk24tABkIJzVKEi6oH/0AOH12YfmgoBvDI+84Q61OLYyWEvwSFztA
         Rr+Gwd7eDosfp/Y2smxSSapG2wq2OBueNqQVL8YF6ghzT3HprmOssFSVH4Ds9O8qy8EI
         27FRnqh1d/MFn1lO9l67vJ01HWTZKoc699oEEY1YNGMZlm4PmtRRsp+leuZA5/pS4cSX
         s7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374940; x=1718979740;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7iZUV99NQN3RgJM91vO01sfzoKXhBrbq1qPqNaXoaI=;
        b=MWGIERSrDosJKDqe0vbKnT1k1r8qkqFYExNywitlD9bmwwCGVPvQK3E34+ELTyZ7q2
         szqxtlwese4R9zb86AG5G6wWI6ZYlyj2jfq6oQy4kmbuvFk/wuinJ6pWqxjkk67S+Aa+
         fORmuFPt/qjSaVzqaSVD4LivwISXfPuYcHrCC+kSCPxnSsO/2KWKoeslT/T5TVzIe+q6
         CE4Wp1MhMpwNjWOUgm5jzwvL5wqKF48ynVwjiCbolwW3x7Jbqa8WzAIJl8+m/T8zY4Le
         t0q7TNi90ZTOzXiLEkXxOcU5XRdA1aPmNCBXivHLqBXsbMoP/NE7me3ekgq/sbtZGeIx
         TAxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZX7Fmm4bJJucs95XRADZMDknLVJAuLkCr1FqN283jgWLrYZDiamqjJPoF4DQ0bp2eg3FQ6F04XbhKXjwsfHpebCnMBwPIVbleWI0E
X-Gm-Message-State: AOJu0YzThfbUtHWLh9ovSGphcbcOLJdllS/QeeJIo08MbServUtVjH83
	9/CHeFjtH98OtgTIKSe3XbBQe2X3F/hz1rmBmLqtYVjRmVYOObnSKq2vTXvY/yU=
X-Google-Smtp-Source: AGHT+IGJERSTIzaOjggWWP0rQrcqidvG0Fn1shO0SdaiGkk+fF3agyv6rp5JLRqhxN5jNm2HLZv71g==
X-Received: by 2002:a17:902:6906:b0:1f7:21fd:ab83 with SMTP id d9443c01a7336-1f8629feaeemr22250365ad.54.1718374940068;
        Fri, 14 Jun 2024 07:22:20 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:19 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
Date: Fri, 14 Jun 2024 22:21:50 +0800
Message-Id: <20240614142156.29420-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add iotlb_sync_map operation for flush IOTLB. Software must
flush the IOTLB after each page table.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Makefile |  1 +
 drivers/iommu/riscv/iommu.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index d36625a1fd08..f02ce6ebfbd0 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o iommu-pmu.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
+obj-$(CONFIG_SIFIVE_IOMMU) += iommu-sifive.o
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 9aeb4b20c145..df7aeb2571ae 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1115,6 +1115,16 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
 }
 
+static int riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
+				      unsigned long iova, size_t size)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, iova, iova + size - 1);
+
+	return 0;
+}
+
 static inline size_t get_page_size(size_t size)
 {
 	if (size >= IOMMU_PAGE_SIZE_512G)
@@ -1396,6 +1406,7 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	.unmap_pages = riscv_iommu_unmap_pages,
 	.iova_to_phys = riscv_iommu_iova_to_phys,
 	.iotlb_sync = riscv_iommu_iotlb_sync,
+	.iotlb_sync_map = riscv_iommu_iotlb_sync_map,
 	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
 };
 
-- 
2.17.1


