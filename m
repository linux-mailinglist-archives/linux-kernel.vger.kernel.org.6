Return-Path: <linux-kernel+bounces-303903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2F9616BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54231C22A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECD1D2F59;
	Tue, 27 Aug 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrJ+aa8z"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805791D415D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782647; cv=none; b=sOGN55/ZjSVHcaiYxtyVNMLnpZ5wO4c/6qdj8fUTZRa5DdB23izxD1IjWUAEbDB2aMfJYkHL4x007mOqc+fcnDHPIgsX59SSjTZS9sSGY30NuHEe7n2Xpv/uBblN+kQ8HZV/YeR1teec0h9XPDeDjsBkJrhUgoJsOey48w3IfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782647; c=relaxed/simple;
	bh=IHBkbRTSRs1I3VQNuuBQURPtkVM0/9Lbyd7rf++i6iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngRu314uUhYEZ76GSVmiIuL4nVa3Zt0aY1UOUaww7Jm0xbKmI3PL00lIym/JPAODyhz1tWToJ2Lqc0nucOTSFABSKCfE3abhWfcyZPJx73AVhROdfyFcrnP5SBVBBi61hYFePHrH4Ni6h7S/fYLLpWDbZKz77dUQGOOOKTYkJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrJ+aa8z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so4606994b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782645; x=1725387445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKDm3s2TCTU5rY2IssAZFvBpqQYJOpn3EVObKPXkHYI=;
        b=ZrJ+aa8znpX+iIo+Fr5SaF28HAaaVtfzXkHaEVgsgXm9wwzheyfjVccOfHnMxuwaVZ
         XRIxdqc8t3vAATfpv1tWCOLj9HVOruTVhMUh+ohR6U/5eyGElV+2ZhpPok8YNkOqBRlj
         lCGdXuSqQIGQDHNX2izpSRSnn4bn/7ztcdK8iv6CY8GsprZ3QG01671SvnSD6huArPpu
         zysiCH5Zgkc6aVoamvjvaKT5DpK096PKX5dkXwGyn7gTvxa8KuFrsd+Z8f8uLdmliZs4
         a5LjkCGAY5o9a6O2gLyc4B+7rSPohvXcOc/IORJhIFB5hRAkfSzvDpwfuV1fkqqleRti
         vy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782645; x=1725387445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKDm3s2TCTU5rY2IssAZFvBpqQYJOpn3EVObKPXkHYI=;
        b=rwzSWFSXn9GaQWy+d7b7Jax9rWQR0+Gy7G1mgFUSj0M/e+HvvBFSDoso0D3CP0jeu3
         7fy5dR2KLTr6q8gLyCmoPtxR2MlcqTpbC05Mbb2fBbX1v1hnacntREel1yYZzjhOBero
         FaoDna/ntiCQncj3GQZaPogSj5I8n49KuuPn0K2GJwQS6DOHNsrkiIhe8o2Tb16WncZy
         BFDfCtqaNSUqY04qdbnLW0HF1ZyKyKkoCgCoeV3QUy1dlC0q88kT646vxsRrgViFEbgu
         CWxxbWg4k1kaKPQpDuBAjmncUr0pTxTAEAmQAEu22xZBMWBrRCSztEx7M1ChLjO49rbm
         TWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxzbBrrDwiFZ/iXbiItok3JmsAdOSUbjkAfl+zzO6dvlI2eTtOeolau13++4TruRkfQ3xAqZ7o23Z9qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwC3Fy4QK7pyc2RhWrcgAIip/cNeAL2juHCdAMD0UoRuRr2J1
	W6Pdrv9bQ2ovcGwrfDjnm8bUfm4oShN/UFr+xfodhCFAm9IgSJe8
X-Google-Smtp-Source: AGHT+IEdQtuPGHWLGK9dVGESUarAI6mwcJzwOmeoDY/at/WLDRJDTKjtiierrP3Jt3uEQb5wm9aMDQ==
X-Received: by 2002:a05:6a00:3cd2:b0:714:1bcf:3d93 with SMTP id d2e1a72fcca58-715bff709c3mr4918008b3a.5.1724782644533;
        Tue, 27 Aug 2024 11:17:24 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342316e8sm9196285b3a.16.2024.08.27.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:23 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/4] iommu/io-pgtable-arm: Make pgtable walker more generic
Date: Tue, 27 Aug 2024 11:17:09 -0700
Message-ID: <20240827181717.187245-2-robdclark@gmail.com>
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

We can re-use this basic pgtable walk logic in a few places.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 59 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..0132f1eff688 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -747,33 +747,31 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 }
 
 struct io_pgtable_walk_data {
-	struct iommu_dirty_bitmap	*dirty;
+	void				*data;
+	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
+		     arm_lpae_iopte *ptep, size_t size);
 	unsigned long			flags;
 	u64				addr;
 	const u64			end;
 };
 
-static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
-				       struct io_pgtable_walk_data *walk_data,
-				       arm_lpae_iopte *ptep,
-				       int lvl);
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl);
 
-static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
-				  struct io_pgtable_walk_data *walk_data,
-				  arm_lpae_iopte *ptep, int lvl)
+static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
+			    struct io_pgtable_walk_data *walk_data,
+			    arm_lpae_iopte *ptep, int lvl)
 {
 	struct io_pgtable *iop = &data->iop;
 	arm_lpae_iopte pte = READ_ONCE(*ptep);
 
 	if (iopte_leaf(pte, lvl, iop->fmt)) {
 		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
-
-		if (iopte_writeable_dirty(pte)) {
-			iommu_dirty_bitmap_record(walk_data->dirty,
-						  walk_data->addr, size);
-			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
-				iopte_set_writeable_clean(ptep);
-		}
+		int ret = walk_data->visit(walk_data, lvl, ptep, size);
+		if (ret)
+			return ret;
 		walk_data->addr += size;
 		return 0;
 	}
@@ -782,13 +780,13 @@ static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
 		return -EINVAL;
 
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
+	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
 }
 
-static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
-				       struct io_pgtable_walk_data *walk_data,
-				       arm_lpae_iopte *ptep,
-				       int lvl)
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl)
 {
 	u32 idx;
 	int max_entries, ret;
@@ -803,7 +801,7 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 
 	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
 	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
-		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
+		ret = io_pgtable_visit(data, walk_data, ptep + idx, lvl);
 		if (ret)
 			return ret;
 	}
@@ -811,6 +809,20 @@ static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
 	return 0;
 }
 
+static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
+		       arm_lpae_iopte *ptep, size_t size)
+{
+	struct iommu_dirty_bitmap *dirty = walk_data->data;
+
+	if (iopte_writeable_dirty(*ptep)) {
+		iommu_dirty_bitmap_record(dirty, walk_data->addr, size);
+		if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+			iopte_set_writeable_clean(ptep);
+	}
+
+	return 0;
+}
+
 static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 					 unsigned long iova, size_t size,
 					 unsigned long flags,
@@ -819,7 +831,8 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	struct io_pgtable_walk_data walk_data = {
-		.dirty = dirty,
+		.data = dirty,
+		.visit = visit_dirty,
 		.flags = flags,
 		.addr = iova,
 		.end = iova + size,
@@ -834,7 +847,7 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	if (data->iop.fmt != ARM_64_LPAE_S1)
 		return -EINVAL;
 
-	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
+	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
-- 
2.46.0


