Return-Path: <linux-kernel+bounces-301392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24895EFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11CBB21583
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2A15572F;
	Mon, 26 Aug 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="H6EB9Nj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PV4X0N52"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7414EC77
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672458; cv=none; b=fz339rZ7zI6fH4U7PaHN92Rw7HIb2/ncZRuec4KsSzRE19fIxxjKhnghpuWQP/zt9BCv8+5E2zrIPaVpEvqVACHreEMit1jF42A2b5hKBjlIWh+6ooCQBd6vZ4Z8mTPn9WZarQ4ux6dxrSJsG4ZrqY4QZLxCCPrgue1wNRpkXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672458; c=relaxed/simple;
	bh=nuFvxp/M5IAaOxTYl1jnlb6xI3ep0l9zxNIoSeA1838=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djLEJpu468iHqIzAURbj/usjke3xKe9agq+5eUz/tROhP3aRibKIKs5EgNQFjHcolGlLJAGgnvY+FVjtwMGqf8lfRqCtXdKyIAQab6+CUuBD7TyDUPdSAAnHdpNIPk6W4NmjVhwIkTHH7MKz90Ja4v4MydOuS9MZyt4BPrCWlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=H6EB9Nj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PV4X0N52; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C64D41151B44;
	Mon, 26 Aug 2024 07:40:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 07:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672454; x=1724758854; bh=3Cs2r3GrVO/pQuuCnExnOKv/xk1e+riS
	WLlhLEUxL8A=; b=H6EB9Nj3aXdIKaUnP1vXC+IL+/RXp5a9q0PnGQY9KUW/2GXV
	Xo+PBNKbmx+Kl0xZSKF2BG0Xh+/CoVQWy5yDCoQ7t9VDjaLwzJZdb9oG5X2C1C+p
	RzEPB3r00XtSvuFgCag3SWfrv4wRsc609EExAGCjXgwvpb3wYMBJiyaslzaMx1zt
	dFekhlIWoddcCQO35S93CryuQCLnm49Dwk1+YkTgHNXNSwPH2G5kTV+IoVQnbiTk
	+MMtfaTmfx0VM3ZBacVrYEiJoNzWuoTX3Q4EVr+mZ8SCI/jydWwunBUmCJnv+UGL
	YwBBEc7BFTYv7RAOO7yaTFfGYkod6Fny6UtUjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672454; x=
	1724758854; bh=3Cs2r3GrVO/pQuuCnExnOKv/xk1e+riSWLlhLEUxL8A=; b=P
	V4X0N52RKKjOF4vL3ogwkptSUNooNmDzwfV0hpbbJcvU3NovTPx1wCiYbnCvalIz
	8tjdi6hlFDBTACIVS5mtIRBtu+rmLQUzC+d+BOOLcZwV3Ni4AKofS+G83zdYIcL0
	H2Qge47NqBK/Xv2GasEd71LMoekvwHFFunS8gM0OpKMw585jFSc60+U2pk/onY8f
	n3Zgcqm9JT9bA8bf1KlLIAtLHWnnLucTF8QQU2wBOuMNbihDbcoCl5iXNzKx9lDC
	JuUqIFa+fia1j1j5M61A/Mp0vQOSjCFO0b99pLR+M8FxDH2bLHy4OTovsN0gNMMP
	tPYZ6ZCe4qO21p1FSKmpA==
X-ME-Sender: <xms:xmnMZqmBoIaUkDAEvgrksao3cgIIJo-CmKoIwioCtipb2KDUFKZzfg>
    <xme:xmnMZh0nl-Sk11lzqDHETWiO0cWvIpXdpmi7TZpdX1eQMVUN-WaorpmNEyt-YnMEb
    CLZC1wt0isqaU8PN0k>
X-ME-Received: <xmr:xmnMZooNnE1HmfV3W8MyRdN5SKwElaOv09K97kg8-a-LRF-ekcFc1N4oudW2-66PvHHkhRCGdqbxjbypwNZyLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
    drughkqeenucggtffrrghtthgvrhhnpeejleffjeekudffteekleekffeifeehveeghfdu
    leeifefgvedvleeftdejvefhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhdrghhrrghnrgguoh
    hssehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhu
    nhhgrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehi
    ohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhosghinhdrmh
    hurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhinhifohhordhimhesshgrmhhsuhhngh
    drtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhg
X-ME-Proxy: <xmx:xmnMZukrt6sgnttKwceqyXhQ3BgylgDb3-uxavzaMlklNTQQXEvtkA>
    <xmx:xmnMZo3MgHPtLpJNY-tz3e9gSSln3dI69As4pOTKTNwq-w1PZrKV7A>
    <xmx:xmnMZltigD4ITIaLY_UfF2MOPyxD5KbtzHs5rPiSXSK3khXYVJOBpw>
    <xmx:xmnMZkU0if1eSbdgSiUv6TBqEZxn77rmy9V6HsZtHtMK3azsZ9083A>
    <xmx:xmnMZuPPLqjRwoUkMJsm3M05iT9in7LWY4lmA-1YJazvEi2upSXGjD5q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:40:52 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:27 +0200
Subject: [PATCH RFC PREVIEW 1/6] iommu/vt-d: Separate page request queue
 from SVM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=23262; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=Cw8vFAdG8yu2OkPDBe2zQUVFQKT7ftWvIP+SquT6slw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekF4ZWo3Y0wxaHJqL3ZTO
 GJUYWtrTWFXY3k5KzEyczI1KzQ3cm83TFo3TnBhcVIzNEkrSE96CnlQZUoxMXh1RjlrZS9KaUpx
 NnlUMFppRmdaR0xRVlpNa1NWSXczaFY2YU03enhhNXB4MkFHY1RLQkRLRmdZdFQKQUNaeXI0WDl
 2K3V5OTY4T25mVlp0VC9pWjZXTWwxamZDZmw4am0vU3RkbmZ2KzJxL2RYUVl1U3FOcTNGdnQxRA
 pVL2p5eGtNekZhNXlYUlhxVy9IVStmYkV0dHVudk00VW1EWkYrUFFjUzVmVDdGcjQxaWZITjFPN
 zM5azVmMW4vCjlQQ0puOVJXaVBmTTJIbjJzZjRWNVVMN1JZazk1MUs3MzVZSHMvRWxGWW90OEhQ
 ZkxPVE1XTEVpeWtUaWRienoKMjFOY3MrUlZsbXpmN2JFajlmKzNuUXVuZGE2cCtKZ1gwMVVmbFd
 nUStuYS9oTmV2cS83T2k0L3h1Q1J1clRrUwpxZUJibDNKc1cvdk5Hc1B3RlMrMEo2MnpQWjNibl
 ZZc0pQNnQ4RUI4WHF5T2d0ZDluMGQ4TFZaTGVDd2ttdjRsCnVqMzRsNkRoOFhpYXFYeml1M3E1V
 1NhUmk2V0wzYjFGZUZQcStYTG55RzNkT3dVQTg4ZWp5Zz09Cj1ScVU1Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Joel Granados <j.granados@samsung.com>

IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
all Page Request Queue (PRQ) functions that handle prq events to a new
file in drivers/iommu/intel/prq.c. The page_req_des struct is made
available in drivers/iommu/intel/iommu.h.

No functional changes are intended. This is a preparation patch to
enable the use of IO page faults outside the SVM and nested use cases.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  18 +--
 drivers/iommu/intel/iommu.h  |  40 +++++-
 drivers/iommu/intel/prq.c    | 290 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c    | 308 -------------------------------------------
 5 files changed, 331 insertions(+), 327 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index c8beb0281559..d3bb0798092d 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..4ca284d53a6b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1487,12 +1487,10 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
-			intel_svm_finish_prq(iommu);
+			intel_finish_prq(iommu);
 	}
-#endif
 }
 
 /*
@@ -2480,19 +2478,18 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
 			 */
 			up_write(&dmar_global_lock);
-			ret = intel_svm_enable_prq(iommu);
+			ret = intel_enable_prq(iommu);
 			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
-#endif
+
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
@@ -2922,13 +2919,12 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
-		ret = intel_svm_enable_prq(iommu);
+		ret = intel_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
 	}
-#endif
+
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
 		goto disable_iommu;
@@ -4669,9 +4665,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
-#ifdef CONFIG_INTEL_IOMMU_SVM
-	.page_response		= intel_svm_page_response,
-#endif
+	.page_response		= intel_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..b3d98e706ed8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -694,6 +694,35 @@ struct iommu_pmu {
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
 #define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
 
+/* Page request queue descriptor */
+struct page_req_dsc {
+	union {
+		struct {
+			u64 type:8;
+			u64 pasid_present:1;
+			u64 rsvd:7;
+			u64 rid:16;
+			u64 pasid:20;
+			u64 exe_req:1;
+			u64 pm_req:1;
+			u64 rsvd2:10;
+		};
+		u64 qw_0;
+	};
+	union {
+		struct {
+			u64 rd_req:1;
+			u64 wr_req:1;
+			u64 lpig:1;
+			u64 prg_index:9;
+			u64 addr:52;
+		};
+		u64 qw_1;
+	};
+	u64 qw_2;
+	u64 qw_3;
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -719,12 +748,10 @@ struct intel_iommu {
 
 	struct iommu_flush flush;
 #endif
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	unsigned long prq_seq_number;
 	struct completion prq_complete;
-#endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	/* Synchronization between fault report and iommu device release. */
@@ -1156,12 +1183,13 @@ void intel_context_flush_present(struct device_domain_info *info,
 				 struct context_entry *context,
 				 bool affect_domains);
 
+int intel_enable_prq(struct intel_iommu *iommu);
+int intel_finish_prq(struct intel_iommu *iommu);
+void intel_page_response(struct device *dev, struct iopf_fault *evt,
+			struct iommu_page_response *msg);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
-int intel_svm_enable_prq(struct intel_iommu *iommu);
-int intel_svm_finish_prq(struct intel_iommu *iommu);
-void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
-			     struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
new file mode 100644
index 000000000000..2814373e95d8
--- /dev/null
+++ b/drivers/iommu/intel/prq.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2015 Intel Corporation.
+ *
+ * Authors: David Woodhouse <dwmw2@infradead.org>
+ */
+
+#include <linux/pci.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+#include "trace.h"
+
+static bool is_canonical_address(u64 addr)
+{
+	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
+	long saddr = (long) addr;
+
+	return (((saddr << shift) >> shift) == saddr);
+}
+
+static void handle_bad_prq_event(struct intel_iommu *iommu,
+				 struct page_req_dsc *req, int result)
+{
+	struct qi_desc desc = { };
+
+	pr_err("%s: Invalid page request: %08llx %08llx\n",
+	       iommu->name, ((unsigned long long *)req)[0],
+	       ((unsigned long long *)req)[1]);
+
+	if (!req->lpig)
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_PERM_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_PERM_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_PERM_EXEC;
+	if (req->pm_req)
+		prot |= IOMMU_FAULT_PERM_PRIV;
+
+	return prot;
+}
+
+static void intel_prq_report(struct intel_iommu *iommu, struct device *dev,
+				 struct page_req_dsc *desc)
+{
+	struct iopf_fault event = { };
+
+	/* Fill in event data for device specific processing */
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
+	event.fault.prm.pasid = desc->pasid;
+	event.fault.prm.grpid = desc->prg_index;
+	event.fault.prm.perm = prq_to_iommu_prot(desc);
+
+	if (desc->lpig)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (desc->pasid_present) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+	}
+
+	iommu_report_device_fault(dev, &event);
+}
+
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu = d;
+	struct page_req_dsc *req;
+	int head, tail, handled;
+	struct device *dev;
+	u64 address;
+
+	/*
+	 * Clear PPR bit before reading head/tail registers, to ensure that
+	 * we get a new interrupt if needed.
+	 */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = (head != tail);
+	while (head != tail) {
+		req = &iommu->prq[head / sizeof(*req)];
+		address = (u64)req->addr << VTD_PAGE_SHIFT;
+
+		if (unlikely(!req->pasid_present)) {
+			pr_err("IOMMU: %s: Page request without PASID\n",
+			       iommu->name);
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
+		}
+
+		if (unlikely(!is_canonical_address(address))) {
+			pr_err("IOMMU: %s: Address is not canonical\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
+			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->exe_req && req->rd_req)) {
+			pr_err("IOMMU: %s: Execution request not supported\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		/* Drop Stop Marker message. No need for a response. */
+		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
+			goto prq_advance;
+
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		mutex_lock(&iommu->iopf_lock);
+		dev = device_rbtree_find(iommu, req->rid);
+		if (!dev) {
+			mutex_unlock(&iommu->iopf_lock);
+			goto bad_req;
+		}
+
+		intel_prq_report(iommu, dev, req);
+		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
+				 req->qw_2, req->qw_3,
+				 iommu->prq_seq_number++);
+		mutex_unlock(&iommu->iopf_lock);
+prq_advance:
+		head = (head + sizeof(*req)) & PRQ_RING_MASK;
+	}
+
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+
+	/*
+	 * Clear the page request overflow bit and wake up all threads that
+	 * are waiting for the completion of this handling.
+	 */
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
+				    iommu->name);
+		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+		if (head == tail) {
+			iopf_queue_discard_partial(iommu->iopf_queue);
+			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
+					    iommu->name);
+		}
+	}
+
+	if (!completion_done(&iommu->prq_complete))
+		complete(&iommu->prq_complete);
+
+	return IRQ_RETVAL(handled);
+}
+
+int intel_enable_prq(struct intel_iommu *iommu)
+{
+	struct iopf_queue *iopfq;
+	int irq, ret;
+
+	iommu->prq = iommu_alloc_pages_node(iommu->node, GFP_KERNEL, PRQ_ORDER);
+	if (!iommu->prq) {
+		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
+			iommu->name);
+		return -ENOMEM;
+	}
+
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
+	if (irq <= 0) {
+		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
+		       iommu->name);
+		ret = -EINVAL;
+		goto free_prq;
+	}
+	iommu->pr_irq = irq;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "dmar%d-iopfq", iommu->seq_id);
+	iopfq = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iopfq) {
+		pr_err("IOMMU: %s: Failed to allocate iopf queue\n", iommu->name);
+		ret = -ENOMEM;
+		goto free_hwirq;
+	}
+	iommu->iopf_queue = iopfq;
+
+	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
+
+	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
+				   iommu->prq_name, iommu);
+	if (ret) {
+		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
+		       iommu->name);
+		goto free_iopfq;
+	}
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
+
+	init_completion(&iommu->prq_complete);
+
+	return 0;
+
+free_iopfq:
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+free_hwirq:
+	dmar_free_hwirq(irq);
+	iommu->pr_irq = 0;
+free_prq:
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
+	iommu->prq = NULL;
+
+	return ret;
+}
+
+int intel_finish_prq(struct intel_iommu *iommu)
+{
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
+
+	if (iommu->pr_irq) {
+		free_irq(iommu->pr_irq, iommu);
+		dmar_free_hwirq(iommu->pr_irq);
+		iommu->pr_irq = 0;
+	}
+
+	if (iommu->iopf_queue) {
+		iopf_queue_free(iommu->iopf_queue);
+		iommu->iopf_queue = NULL;
+	}
+
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
+	iommu->prq = NULL;
+
+	return 0;
+}
+
+void intel_page_response(struct device *dev, struct iopf_fault *evt,
+			 struct iommu_page_response *msg)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	u8 bus = info->bus, devfn = info->devfn;
+	struct iommu_fault_page_request *prm;
+	struct qi_desc desc;
+	bool pasid_present;
+	bool last_page;
+	u16 sid;
+
+	prm = &evt->fault.prm;
+	sid = PCI_DEVID(bus, devfn);
+	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+
+	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
+			QI_PGRP_PASID_P(pasid_present) |
+			QI_PGRP_RESP_CODE(msg->code) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..c50c68df1fb2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -25,92 +25,6 @@
 #include "../iommu-pages.h"
 #include "trace.h"
 
-static irqreturn_t prq_event_thread(int irq, void *d);
-
-int intel_svm_enable_prq(struct intel_iommu *iommu)
-{
-	struct iopf_queue *iopfq;
-	int irq, ret;
-
-	iommu->prq = iommu_alloc_pages_node(iommu->node, GFP_KERNEL, PRQ_ORDER);
-	if (!iommu->prq) {
-		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
-			iommu->name);
-		return -ENOMEM;
-	}
-
-	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
-	if (irq <= 0) {
-		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
-		       iommu->name);
-		ret = -EINVAL;
-		goto free_prq;
-	}
-	iommu->pr_irq = irq;
-
-	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
-		 "dmar%d-iopfq", iommu->seq_id);
-	iopfq = iopf_queue_alloc(iommu->iopfq_name);
-	if (!iopfq) {
-		pr_err("IOMMU: %s: Failed to allocate iopf queue\n", iommu->name);
-		ret = -ENOMEM;
-		goto free_hwirq;
-	}
-	iommu->iopf_queue = iopfq;
-
-	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
-
-	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
-				   iommu->prq_name, iommu);
-	if (ret) {
-		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
-		       iommu->name);
-		goto free_iopfq;
-	}
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
-
-	init_completion(&iommu->prq_complete);
-
-	return 0;
-
-free_iopfq:
-	iopf_queue_free(iommu->iopf_queue);
-	iommu->iopf_queue = NULL;
-free_hwirq:
-	dmar_free_hwirq(irq);
-	iommu->pr_irq = 0;
-free_prq:
-	iommu_free_pages(iommu->prq, PRQ_ORDER);
-	iommu->prq = NULL;
-
-	return ret;
-}
-
-int intel_svm_finish_prq(struct intel_iommu *iommu)
-{
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
-
-	if (iommu->pr_irq) {
-		free_irq(iommu->pr_irq, iommu);
-		dmar_free_hwirq(iommu->pr_irq);
-		iommu->pr_irq = 0;
-	}
-
-	if (iommu->iopf_queue) {
-		iopf_queue_free(iommu->iopf_queue);
-		iommu->iopf_queue = NULL;
-	}
-
-	iommu_free_pages(iommu->prq, PRQ_ORDER);
-	iommu->prq = NULL;
-
-	return 0;
-}
-
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -237,43 +151,6 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-/* Page request queue descriptor */
-struct page_req_dsc {
-	union {
-		struct {
-			u64 type:8;
-			u64 pasid_present:1;
-			u64 rsvd:7;
-			u64 rid:16;
-			u64 pasid:20;
-			u64 exe_req:1;
-			u64 pm_req:1;
-			u64 rsvd2:10;
-		};
-		u64 qw_0;
-	};
-	union {
-		struct {
-			u64 rd_req:1;
-			u64 wr_req:1;
-			u64 lpig:1;
-			u64 prg_index:9;
-			u64 addr:52;
-		};
-		u64 qw_1;
-	};
-	u64 qw_2;
-	u64 qw_3;
-};
-
-static bool is_canonical_address(u64 addr)
-{
-	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
-	long saddr = (long) addr;
-
-	return (((saddr << shift) >> shift) == saddr);
-}
-
 /**
  * intel_drain_pasid_prq - Drain page requests and responses for a pasid
  * @dev: target device
@@ -363,191 +240,6 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 	}
 }
 
-static int prq_to_iommu_prot(struct page_req_dsc *req)
-{
-	int prot = 0;
-
-	if (req->rd_req)
-		prot |= IOMMU_FAULT_PERM_READ;
-	if (req->wr_req)
-		prot |= IOMMU_FAULT_PERM_WRITE;
-	if (req->exe_req)
-		prot |= IOMMU_FAULT_PERM_EXEC;
-	if (req->pm_req)
-		prot |= IOMMU_FAULT_PERM_PRIV;
-
-	return prot;
-}
-
-static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
-				 struct page_req_dsc *desc)
-{
-	struct iopf_fault event = { };
-
-	/* Fill in event data for device specific processing */
-	event.fault.type = IOMMU_FAULT_PAGE_REQ;
-	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
-	event.fault.prm.pasid = desc->pasid;
-	event.fault.prm.grpid = desc->prg_index;
-	event.fault.prm.perm = prq_to_iommu_prot(desc);
-
-	if (desc->lpig)
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
-	if (desc->pasid_present) {
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
-	}
-
-	iommu_report_device_fault(dev, &event);
-}
-
-static void handle_bad_prq_event(struct intel_iommu *iommu,
-				 struct page_req_dsc *req, int result)
-{
-	struct qi_desc desc = { };
-
-	pr_err("%s: Invalid page request: %08llx %08llx\n",
-	       iommu->name, ((unsigned long long *)req)[0],
-	       ((unsigned long long *)req)[1]);
-
-	if (!req->lpig)
-		return;
-
-	desc.qw0 = QI_PGRP_PASID(req->pasid) |
-			QI_PGRP_DID(req->rid) |
-			QI_PGRP_PASID_P(req->pasid_present) |
-			QI_PGRP_RESP_CODE(result) |
-			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
-			QI_PGRP_LPIG(req->lpig);
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
-static irqreturn_t prq_event_thread(int irq, void *d)
-{
-	struct intel_iommu *iommu = d;
-	struct page_req_dsc *req;
-	int head, tail, handled;
-	struct device *dev;
-	u64 address;
-
-	/*
-	 * Clear PPR bit before reading head/tail registers, to ensure that
-	 * we get a new interrupt if needed.
-	 */
-	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
-
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	handled = (head != tail);
-	while (head != tail) {
-		req = &iommu->prq[head / sizeof(*req)];
-		address = (u64)req->addr << VTD_PAGE_SHIFT;
-
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
-		if (unlikely(!is_canonical_address(address))) {
-			pr_err("IOMMU: %s: Address is not canonical\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
-			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		if (unlikely(req->exe_req && req->rd_req)) {
-			pr_err("IOMMU: %s: Execution request not supported\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		/* Drop Stop Marker message. No need for a response. */
-		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
-			goto prq_advance;
-
-		/*
-		 * If prq is to be handled outside iommu driver via receiver of
-		 * the fault notifiers, we skip the page response here.
-		 */
-		mutex_lock(&iommu->iopf_lock);
-		dev = device_rbtree_find(iommu, req->rid);
-		if (!dev) {
-			mutex_unlock(&iommu->iopf_lock);
-			goto bad_req;
-		}
-
-		intel_svm_prq_report(iommu, dev, req);
-		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
-				 req->qw_2, req->qw_3,
-				 iommu->prq_seq_number++);
-		mutex_unlock(&iommu->iopf_lock);
-prq_advance:
-		head = (head + sizeof(*req)) & PRQ_RING_MASK;
-	}
-
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
-
-	/*
-	 * Clear the page request overflow bit and wake up all threads that
-	 * are waiting for the completion of this handling.
-	 */
-	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
-		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
-				    iommu->name);
-		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-		if (head == tail) {
-			iopf_queue_discard_partial(iommu->iopf_queue);
-			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
-			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
-					    iommu->name);
-		}
-	}
-
-	if (!completion_done(&iommu->prq_complete))
-		complete(&iommu->prq_complete);
-
-	return IRQ_RETVAL(handled);
-}
-
-void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
-			     struct iommu_page_response *msg)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-	u8 bus = info->bus, devfn = info->devfn;
-	struct iommu_fault_page_request *prm;
-	struct qi_desc desc;
-	bool pasid_present;
-	bool last_page;
-	u16 sid;
-
-	prm = &evt->fault.prm;
-	sid = PCI_DEVID(bus, devfn);
-	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
-
-	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
-			QI_PGRP_PASID_P(pasid_present) |
-			QI_PGRP_RESP_CODE(msg->code) |
-			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);

-- 
2.45.2


