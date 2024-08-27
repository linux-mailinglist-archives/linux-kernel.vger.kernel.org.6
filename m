Return-Path: <linux-kernel+bounces-303905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B09616BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84521C22C89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C361D4609;
	Tue, 27 Aug 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyS0z200"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC001D4604
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782654; cv=none; b=LyEzhz+byVfbfVnoyqtReN62/EdbzfzX8xOvs0LEwC7D0rlYYhP8GNPIyf9w6JQX6DLCmxntUNZfmFi0jkp+PydH3R8I1MwVGDkjVdJOgT2wxQsmm007IYL48wRoH7oWgl6emVpoLw0ZkIPTR+fmIoMnyGNEqsCmBXBIIxjdiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782654; c=relaxed/simple;
	bh=I90NUqSplO+OUpgx4frtAQS27LaYivRbF8zKE+14v70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiU6aDqkcE5irFrc1ush4sCGRq5lyU3dpZ5GLnQpPFirvewZKpCS8DpBQ7zKK8+rsGmLB+aNPW4ordlDdwaxjL4QsKJ9T4dgien2e08joDehOUpop81sFusXHRXClWidopmPqjSLyqk9HJB9oB9uzyUVpzppXbo3iY8o5TrKhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyS0z200; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20230059241so48683475ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782651; x=1725387451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLUmHTIZzlGw27lOXBe2/x1CsKIYYG9Yp6GcbVarkT4=;
        b=PyS0z200nGIb5pMlYzDB1sVW51v6fHobvhRyQbtse7PtK+JFIxX4eAHnSv41NB3bAI
         WqMUL76aWGHJZ+bWfjV7v8bVDrzIlmSZOzd/gRtSoYspMTBEPBUM8gc7DplrHHKA0ucr
         bCzxMF51ljD4rWJcdVlpy8XeicJdpnF8L6xuXQ5DulX1guKgQV4eLYHbzSFoMwLBrb61
         ECTBz4osn1pC626MCwIgpCUkTI9lyFvIhWTOWrd9pxyFl8C6qbIAzMFTgGN6RxS+HQQ0
         KF/rVk5MTmzFA3nQCwzBDbDibVMMDCRAuz9UMnGHWFqj0mfbyPnZjEf2f5ExiYv/ttBw
         miaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782651; x=1725387451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLUmHTIZzlGw27lOXBe2/x1CsKIYYG9Yp6GcbVarkT4=;
        b=P33w9cdiBDlHHMBL7AEu2TMnrF6eImoGNDzP5ba2Z7/WJRS5bjejEgkC+bH4nrRZeJ
         y9O+DDZVbGlu9/hPoPc9pOYpXImZNVMzSAeF9duCHjzG4EVXwM3IkcaNMJ5sGLM3eZC4
         rRmiiM9Ub2V90SGB4Egs9siC1mjw+UuBrQiCMg61wMlqqCMwGNraIZH0yfoMOixwvAc4
         Me8PQ0vJjzaXY4WPLeuNh3mVZ1F5RWggLiUoNxeytf7v+oCINmXWDjjx/id+XuwpSu+e
         UamQ/i9nzLySeyPlInRxqH4srArgmCix/vJOvPyyEEDnHdwY1BSI6C7Ma1TdhUcDHlBr
         NzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7dbeOAXoeIWMihc9Nlvj8He+gKvtIgVjWzozyL/mMWlB/jCb7WYAYLjtF9NyjFCnebBdA3w9aZBEIDbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAkqFqOge5UnUUxjk3uHnBDAF89epWl6+DhFesuJt6lUlXlVC
	ZDAveIEH9XZEovwzGDZOX+IaDcDzdPriRGSM12aPwfY796ceaBiI
X-Google-Smtp-Source: AGHT+IHYyoolcYxZtR5c29wHJT7jmBszW3F5rBHLKaZnAGuTG+FmizoxCTxOLMcJ10P4+O/V0/dwMA==
X-Received: by 2002:a17:902:ce0c:b0:203:a0c3:b342 with SMTP id d9443c01a7336-203a0c3b4a4mr132648915ad.9.1724782650615;
        Tue, 27 Aug 2024 11:17:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385704048sm85663225ad.215.2024.08.27.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:29 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Steven Price <steven.price@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
Date: Tue, 27 Aug 2024 11:17:11 -0700
Message-ID: <20240827181717.187245-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827181717.187245-1-robdclark@gmail.com>
References: <20240827181717.187245-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Add an io-pgtable method to walk the pgtable returning the raw PTEs that
would be traversed for a given iova access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
 include/linux/io-pgtable.h     | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index efed8e519111..11af49119f37 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
+static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
+	data->ptes[data->level++] = *ptep;
+	return 0;
+}
+
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+				 void *wd)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_walk_data walk_data = {
+		.data = wd,
+		.visit = visit_pgtable_walk,
+		.addr = iova,
+		.end = iova + 1,
+	};
+
+	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
+
+	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+}
+
 static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    struct io_pgtable_walk_data *walk_data,
 			    arm_lpae_iopte *ptep, int lvl)
@@ -930,6 +954,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
+		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index f9a81761bfce..76eabd890e6a 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -174,12 +174,26 @@ struct io_pgtable_cfg {
 	};
 };
 
+/**
+ * struct arm_lpae_io_pgtable_walk_data - information from a pgtable walk
+ *
+ * @ptes:     The recorded PTE values from the walk
+ * @level:    The level of the last PTE
+ *
+ * @level also specifies the last valid index in @ptes
+ */
+struct arm_lpae_io_pgtable_walk_data {
+	u64 ptes[4];
+	int level;
+};
+
 /**
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -193,6 +207,7 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.46.0


