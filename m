Return-Path: <linux-kernel+bounces-303904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949C9616BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84801F26025
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550801D45F1;
	Tue, 27 Aug 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="badvCDmQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1C1D4176
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782649; cv=none; b=O1hvNJ+GSVU9oBF66NzsrNCjnyT5Q73UVIqI2dslo3saExzUgA7F4fHnXeZ7t7pJRsqouMt3Lfs0J4CEfh+ZM71F/853YJq0iIM5+fkp4Ou+hdABDlPvODRbqS/tv6B7TlDJbmJcoIj/xYXm5BBAF2LFZUFeSUhqCytjzfivEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782649; c=relaxed/simple;
	bh=0Rk9V2/hD0rJcjKDKxzcXvMS10n5ckBqPtI6KzWqjaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDkZAkFzCabpQWfvo1fKlvpJuF7AmZnRldur+xEvuHKyrJ3UETJk97fx51nNSCyrtKC0Se3p0gdQfgms7csXj6zOxK0k0qSdZI5f4mp9Ke6IKLkDQuMEx1qElOKjDgoILUTuXdld1Ejt42+xoAOU8DVwQNHhvBeh9c4aAegMayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=badvCDmQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-204f52fe74dso641385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782647; x=1725387447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlnDL4DTfIpU6WguUty7oq+VmfQ4+6diTuDRQNVtIjA=;
        b=badvCDmQ9hq73FnLCsWSibnLEex+cMYmA0VT4SnF9SynduqXo8+XTohJ0f/AZxHwL4
         /joB73bHzFZfp0ThcAisSCPRNUNLCFIfchoAftz908Wo2Pn6qtvt2V8OSKfpZftrCbYC
         TfZn3OY1B6ERFDlsIWumvBmaGAbsNEgeeC/dArVykNpLXnzzKv/tpK+Cx0J7jBBBfPus
         BP+BXjkqhXRoNMascwGeT8Sfg/OeZEOhzbrMuY1HkRwQYj1g3JTiKvTWSV/xrI+p75bQ
         CdmGOEmLF1yB1MLVAbOrhNmMjMqvnO6N82eQBwYx+eAL2raS93SyARpMYTPnco7ABx3b
         zWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782647; x=1725387447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlnDL4DTfIpU6WguUty7oq+VmfQ4+6diTuDRQNVtIjA=;
        b=k47Bn9gSqUJXRrSs73UM64HDLYFqVx1l5oqnoo7G+ZGTRAa/YAbqb3pShlo77xDPxW
         GBKhtUJ/rtwp4F1JTR4earmmVa+7A9MAq7oiIL2EFRvYDrx8wYSIBs8XVERdn8MSmIpC
         +9srOtJqYpNg3h2EMsTVgZpCwhLC5U4Q7h81V0TacfcsAWPu/lJr8tjuKzYohIEDdV+X
         zLG0XhD56iCCPzf5KRvCNZmhhslgOeFg02+YykWYqkMm3C0gxVxes68m0ALMXvMW5XdG
         X0/tFERHbjBzbbAbBI2CUyK/2OdZS4y0AOywkM3fvprZ0k5vbBwL8uoC+f6eQprL10Ux
         F9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1T+3rxqyYtC8TdEkWMWqmp3ewJVNzpQNhBx2YoYdCSf8QVaA8EIgYq6+xmAG4b62/dNR5xIhdjYoCFaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfMioVHsH2hOJpWJNZPz4ssADDbY0F+zq774V8tzqRCQYHed5
	Io/fpbkIJmfryq8/nF58W1cqnAJQAPvEwPm0hvRlclAf5LQWBwWF
X-Google-Smtp-Source: AGHT+IH740SM6E9kgQZAZ/5lLwngeaj4TPfrfm6aQ5M9xb8MdaSEXtw7CS0r0ewtH7ZBKZzhgIkHbQ==
X-Received: by 2002:a17:902:f60a:b0:203:a279:a144 with SMTP id d9443c01a7336-204df45d558mr40520575ad.25.1724782647112;
        Tue, 27 Aug 2024 11:17:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566551sm86532335ad.13.2024.08.27.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:26 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
Date: Tue, 27 Aug 2024 11:17:10 -0700
Message-ID: <20240827181717.187245-3-robdclark@gmail.com>
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

Re-use the generic pgtable walk path.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/io-pgtable-arm.c | 75 +++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0132f1eff688..efed8e519111 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -710,42 +710,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	arm_lpae_iopte pte, *ptep = data->pgd;
-	int lvl = data->start_level;
-
-	do {
-		/* Valid IOPTE pointer? */
-		if (!ptep)
-			return 0;
-
-		/* Grab the IOPTE we're interested in */
-		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
-		pte = READ_ONCE(*ptep);
-
-		/* Valid entry? */
-		if (!pte)
-			return 0;
-
-		/* Leaf entry? */
-		if (iopte_leaf(pte, lvl, data->iop.fmt))
-			goto found_translation;
-
-		/* Take it to the next level */
-		ptep = iopte_deref(pte, data);
-	} while (++lvl < ARM_LPAE_MAX_LEVELS);
-
-	/* Ran out of page tables to walk */
-	return 0;
-
-found_translation:
-	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return iopte_to_paddr(pte, data) | iova;
-}
-
 struct io_pgtable_walk_data {
 	void				*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
@@ -760,6 +724,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
 				 arm_lpae_iopte *ptep,
 				 int lvl);
 
+struct iova_to_phys_data {
+	arm_lpae_iopte pte;
+	int lvl;
+};
+
+static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
+			      arm_lpae_iopte *ptep, size_t size)
+{
+	struct iova_to_phys_data *data = walk_data->data;
+	data->pte = *ptep;
+	data->lvl = lvl;
+	return 0;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_data d;
+	struct io_pgtable_walk_data walk_data = {
+		.data = &d,
+		.visit = visit_iova_to_phys,
+		.addr = iova,
+		.end = iova + 1,
+	};
+	int ret;
+
+	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+	if (ret)
+		return 0;
+
+	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	return iopte_to_paddr(d.pte, data) | iova;
+}
+
 static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 			    struct io_pgtable_walk_data *walk_data,
 			    arm_lpae_iopte *ptep, int lvl)
@@ -776,8 +775,10 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return 0;
 	}
 
-	if (WARN_ON(!iopte_table(pte, lvl)))
+	if (!iopte_table(pte, lvl)) {
+		WARN_ON(!selftest_running);
 		return -EINVAL;
+	}
 
 	ptep = iopte_deref(pte, data);
 	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
-- 
2.46.0


