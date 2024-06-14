Return-Path: <linux-kernel+bounces-215014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579B908D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060EB1F21B71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F02837A;
	Fri, 14 Jun 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IJlrisRM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68320B20
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374944; cv=none; b=TFIGT3qayCTgFOejpBA+sSw3xrVJPTFult33EhovliZ75ZK0XRI0Cs/90v2gH55JMEtIa42Ds8XoZWaNG8XUPspGojc+8pVY1Zutkjk4w0LFcnJLhVdqLm+tC6KzEd3EbR1PvjqF5U8re3P0s90Fym+Z0dEoopth5s+4Ay3r+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374944; c=relaxed/simple;
	bh=HQCoIv3Xpbx6DOVWD61lR4O3qkiOmoi7Eje3+sHhmEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q9RhrKqwErvxuqSvqrbdRe59mF8/8aE05VpmahX9KH9vDigMnIjfFnHzsMxV54wp4yvZ1/NDx5XRWQa9mTnkaVRO6vcAVSDUaoZHFDJbF1/iY5N5jqFmezTXGtStPlH6k8otflBCyRKDrvf0EzAaApepajtQK7L+zOl+jbMCY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IJlrisRM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f862f7c7edso9038015ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374942; x=1718979742; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Daef6kUbuf4+6WFIjDcTl7WQW1O4tQM7jDjBoLtjZ4=;
        b=IJlrisRMrOQYPG46ITS2iloUP2y9aX83eTnTSVFPolwiQj7g1aDCrOthwl/Jeo2cl0
         0bxi+MO5uJOG5WsuXCDyxM4Qa+0EjdrihWn/IXjKGWiRWcOkdSaq5zxAyadddixJv0vF
         yNIuCxb+mzfe6ozvA9dCx/dRGXJTRVM0uRFQXpPK6QfASv2O6xXp9mKR2zy+gmh2PNQz
         cXWwZfhlHD5COTb0hGNfgj5R/czH00sxVrqqLTxkz8Q1P+Poblih5O7QILGwcy4JohNq
         AmaSVAUfXr6/ltqSbEV8ti/G2ODZMxGdKD1V5OK79bVSyIKC9K0sqGfI0Pf0os6jxwkM
         yV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374942; x=1718979742;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Daef6kUbuf4+6WFIjDcTl7WQW1O4tQM7jDjBoLtjZ4=;
        b=FanuJCscdbNFHjXx1XDJswqkGBjs9kxdJgsIi+LWULc+fv8VZIydbYn57To9Vsf2Pl
         nQAKCYlS4HqsAtFJ68Icu8whpTOYvwqQZNFxQIk6rBSHL0c5erTA5m5XsLf9gMP+2rEF
         B2QHCj9PZgc6edptDPsHVqlO+FOm5g+0cvd/8oKuQQ5NeXD6SXki62eYGI9YOoPWaqE7
         ZvVCikey90vYFspF9J4M9NQw2Ep2h/JJGPL+ObN7qF9vqrB8sZKZYGITr3W9XVi/ZgBo
         69RnmeqKFNUs+3rEeaTYF18W2yUsB7irFEhHrdmwcCjh1kj3rUov/JqTuOFF6csi9W/C
         L6qg==
X-Forwarded-Encrypted: i=1; AJvYcCWJJ2015xTnE98jig1f0zQOlcxrM2a07YNwchOysLDCCCF8H/CPSKOlRTTSqVQrKuNQHMR8be68mEfX2cVVjjHplENj3zopSGqNo505
X-Gm-Message-State: AOJu0YznIeYyjN5UqgGoFBk7X1OLjbI59JNGZ06Mzi917sqGNNZVZte+
	VHYD1XMnq6GoLgJqeWNJkRlAiKynDNepNpNUy07UlayYKZ8yyomUavCyzUz5EYU=
X-Google-Smtp-Source: AGHT+IFqgOZYvBJ4kxh5nI8iWhYcYwWgqXcjlHpYLYmYilMYTECy6aBNWzRZ7wIFJH/yInxDq6z0lg==
X-Received: by 2002:a17:903:32ca:b0:1f7:c33:aa92 with SMTP id d9443c01a7336-1f8625c06f1mr32662045ad.9.1718374942583;
        Fri, 14 Jun 2024 07:22:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/10] iommu/riscv: support GSCID and GVMA invalidation command
Date: Fri, 14 Jun 2024 22:21:51 +0800
Message-Id: <20240614142156.29420-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch adds a ID Allocator for GSCID and a wrap for setting up
GSCID in IOTLB invalidation command.

Set up iohgatp to enable second stage table and flush stage-2 table if
the GSCID is set.

The GSCID of domain should be freed when release domain. GSCID will be
allocated for parent domain in nested IOMMU process.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 ++++++
 drivers/iommu/riscv/iommu.c      | 39 ++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 60523449f016..214735a335fd 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -731,6 +731,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
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
index df7aeb2571ae..45309bd096e5 100644
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
@@ -845,6 +849,7 @@ struct riscv_iommu_domain {
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
+	int gscid;
 	int amo_enabled:1;
 	int numa_node;
 	unsigned int pgd_mode;
@@ -993,20 +998,33 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_lock();
 
 	prev = NULL;
+
 	list_for_each_entry_rcu(bond, &domain->bonds, list) {
 		iommu = dev_to_iommu(bond->dev);
 
 		/*
 		 * IOTLB invalidation request can be safely omitted if already sent
-		 * to the IOMMU for the same PSCID, and with domain->bonds list
+		 * to the IOMMU for the same PSCID/GSCID, and with domain->bonds list
 		 * arranged based on the device's IOMMU, it's sufficient to check
 		 * last device the invalidation was sent to.
 		 */
 		if (iommu == prev)
 			continue;
 
-		riscv_iommu_cmd_inval_vma(&cmd);
-		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		/*
+		 * S2 domain needs to flush entries in stage-2 page table, its
+		 * bond list has host devices and pass-through devices, the GVMA
+		 * command is no effect on host devices, because there are no
+		 * mapping of host devices in stage-2 page table.
+		 */
+		if (domain->gscid) {
+			riscv_iommu_cmd_inval_gvma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
+		} else {
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		}
+
 		if (len && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
 			for (iova = start; iova < end; iova += PAGE_SIZE) {
 				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
@@ -1015,6 +1033,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		} else {
 			riscv_iommu_cmd_send(iommu, &cmd);
 		}
+
 		prev = iommu;
 	}
 
@@ -1083,6 +1102,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
 		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1354,6 +1374,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
+	if ((int)domain->gscid > 0)
+		ida_free(&riscv_iommu_gscids, domain->gscid);
+
 	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
 	kfree(domain);
 }
@@ -1384,8 +1407,14 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
-	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	if (domain->gscid)
+		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, domain->pgd_mode) |
+			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
+			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, virt_to_pfn(domain->pgd_root));
+	else
+		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 			   RISCV_IOMMU_PC_TA_V;
 
-- 
2.17.1


