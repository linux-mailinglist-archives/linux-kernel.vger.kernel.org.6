Return-Path: <linux-kernel+bounces-171573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7FF8BE5DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8A61C20BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4D16078C;
	Tue,  7 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j5B0TW5n"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9C15FCF9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091976; cv=none; b=Bwy2lBNe/G23jdTVWmYNkq7oY0GS9vkbZ09UN5oI0Njc3gl5EfbVQjcPlrrByOUcKnkRw6XwPuPPpflywMCl+mDA0t5iu3x8wgj32G9o90XQAyjOyDhSmbi+DCtis9IPDno27OtWl0aWNMRA2C6y7QTFCwRANP9MD5L61ePajvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091976; c=relaxed/simple;
	bh=dle2cRslL/eml8rQHKVoHJTE4hJnwycWESm76X81LvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l3FAAKMQo43W3CznA8aECQByn3GFKed+ouJbRdaCpFughBkTTk00k/aOsQJqBbOJB6/VqdTbtMPIMrV6ijmjcZd2PHLB1Rlo9/wDRqjUDaRZotxWeC4duGrFQVIxFKRKwfB14lBQcZWckVu8MQwawrrHLMp6X/9qEfeqNKBbS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=j5B0TW5n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so2388328b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091974; x=1715696774; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5Yiv5A35fqkZLewYyNasBxNRcaYrtDBJ52Nob0v8A4=;
        b=j5B0TW5n7wposDagnyi1GHTtyStH/FVuILUgGSlu5kgE9Uop5CkGhBuXJrtNT6uvxV
         acxYu2wysQwfQCXzc1cYvLjDciMsvFprYQMFyWJXa/ZtJ913o4zoPzTmqy3aanGGyXlq
         Gsp+yGZxFbaWv/ztJ6RwFCLfRhzpbbSof0NZN8JiSIv8su2P40+RZslYobuRy83r/qlG
         SP5imMIXrAqHBbNyGMTG+XajteI08YtEdyLAO5/BovA45Ky0784ZDwx+V9xcloKcJUew
         l2o2kRD86TmXZ7hiqmNG7X4y1YLXpuexNNAulLF2PHEiMXRdIII4wn1FhUwD70Dc7zPF
         tIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091974; x=1715696774;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Yiv5A35fqkZLewYyNasBxNRcaYrtDBJ52Nob0v8A4=;
        b=jkzjn8do0w8rwPYGMb24MvpjZIe4T9QWV0G5R/FFJmfUSnazcshaZKWPxNWOzFzPaC
         JaI3wN9/UAiBPnM4LrsRgfO8+Dcz42B88gVXxbT7xDiTV/gySsZl9DVVlY2atQkUNE6p
         L7eMelnqmJm5Cu8VZY1nvbyaLClu7B+fH+n89M0Nl9hohLVjDVmuxH6BDyXkz6TJTtSQ
         xyT2dv2duuOb8JeW/+vhYz5TySV5xZEOU72qZub73YReEntJLdvr43oiQDBFFA+RNHk4
         Gv7iWyE9x48DeXfWMeyf3Xpgtwp406FoyvbRWotlQmsLc58p4fGhbvWDWzVIURPaKqYd
         ADJw==
X-Forwarded-Encrypted: i=1; AJvYcCXHbxM5O5eL7tWxqnj9ObckvSRFzFwKYvfpF6sMBomIKTIkJCkzqnTJWwjI/DDBWNbyo2GJNGjUS71YIcaRhr6vZmPMIh/4vvbZQgKh
X-Gm-Message-State: AOJu0YxT6opmd17k2BgrKAk6HQ+MNEA+b9TbaUgR26y43ov2lKjZkyeR
	Tb6o6asHjVWyk4Z8dSYRx2jQH4OX3uQRWWWfjDJ0PWlLKQ/AXGZ3xAljp5YBivg=
X-Google-Smtp-Source: AGHT+IHdg7+7I4bSI4CruHY7MHG+tPkBhVw4YY0PCUXdy/YjCBHjgssv5B+jlzNMBIZ1jyV/U90aVQ==
X-Received: by 2002:a05:6a00:4f82:b0:6ed:21b2:cb17 with SMTP id ld2-20020a056a004f8200b006ed21b2cb17mr14575610pfb.4.1715091972855;
        Tue, 07 May 2024 07:26:12 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:12 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Date: Tue,  7 May 2024 22:25:57 +0800
Message-Id: <20240507142600.23844-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch adds a global ID Allocator for GSCID and a wrap for setting
up GSCID in IOTLB invalidation command.

Set up iohgatp to enable second stage table and flus stage-2 table if
the GSCID is allocated.

The GSCID of domain should be freed when release domain. GSCID will be
allocated for parent domain in nested IOMMU process.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 +++
 drivers/iommu/riscv/iommu.c      | 81 ++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 11351cf6c710..62b1ee387357 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -728,6 +728,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
+	cmd->dword1 = 0;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e0bf74a9c64d..d38e09b138b6 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -45,6 +45,10 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU GSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_gscids);
+#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -826,6 +830,7 @@ struct riscv_iommu_domain {
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
+	int gscid;
 	int numa_node;
 	int amo_enabled:1;
 	unsigned int pgd_mode;
@@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_lock();
 
 	prev = NULL;
-	list_for_each_entry_rcu(bond, &domain->bonds, list) {
-		iommu = dev_to_iommu(bond->dev);
 
-		/*
-		 * IOTLB invalidation request can be safely omitted if already sent
-		 * to the IOMMU for the same PSCID, and with domain->bonds list
-		 * arranged based on the device's IOMMU, it's sufficient to check
-		 * last device the invalidation was sent to.
-		 */
-		if (iommu == prev)
-			continue;
-
-		riscv_iommu_cmd_inval_vma(&cmd);
-		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
-		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
-			for (iova = start; iova < end; iova += PAGE_SIZE) {
-				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+	/*
+	 * Host domain needs to flush entries in stage-2 for MSI mapping.
+	 * However, device is bound to s1 domain instead of s2 domain.
+	 * We need to flush mapping without looping devices of s2 domain
+	 */
+	if (domain->gscid) {
+		riscv_iommu_cmd_inval_gvma(&cmd);
+		riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
+		riscv_iommu_cmd_send(iommu, &cmd, 0);
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	} else {
+		list_for_each_entry_rcu(bond, &domain->bonds, list) {
+			iommu = dev_to_iommu(bond->dev);
+
+			/*
+			 * IOTLB invalidation request can be safely omitted if already sent
+			 * to the IOMMU for the same PSCID, and with domain->bonds list
+			 * arranged based on the device's IOMMU, it's sufficient to check
+			 * last device the invalidation was sent to.
+			 */
+			if (iommu == prev)
+				continue;
+
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+			if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
+				for (iova = start; iova < end; iova += PAGE_SIZE) {
+					riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+					riscv_iommu_cmd_send(iommu, &cmd, 0);
+				}
+			} else {
 				riscv_iommu_cmd_send(iommu, &cmd, 0);
 			}
-		} else {
-			riscv_iommu_cmd_send(iommu, &cmd, 0);
+			prev = iommu;
 		}
-		prev = iommu;
 	}
 
 	prev = NULL;
@@ -972,7 +991,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, u64 fsc, u64 ta, u64 iohgatp)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1012,6 +1031,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		/* Update device context, write TC.V as the last step. */
 		WRITE_ONCE(dc->fsc, fsc);
 		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->iohgatp, iohgatp);
 		WRITE_ONCE(dc->tc, tc);
 	}
 }
@@ -1271,6 +1291,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
+	if ((int)domain->gscid > 0)
+		ida_free(&riscv_iommu_gscids, domain->gscid);
+
 	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
 	kfree(domain);
 }
@@ -1296,7 +1319,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
-	u64 fsc, ta;
+	u64 fsc = 0, iohgatp = 0, ta;
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
@@ -1314,12 +1337,18 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	 */
 	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	if (domain->gscid)
+		iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, domain->pgd_mode) |
+			  FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
+			  FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, virt_to_pfn(domain->pgd_root));
+	else
+		fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+
 	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, fsc, ta, iohgatp);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1422,7 +1451,7 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0, 0);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1442,7 +1471,7 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V, 0);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
-- 
2.17.1


