Return-Path: <linux-kernel+bounces-440342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 836479EBBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E7E1889323
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3058239789;
	Tue, 10 Dec 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bO0QsdyT"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99B238758
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866698; cv=none; b=geVu8QGdoEJdJEqFkz4yUrlXf4tiNHV2AocMW42ZWqtIqHbV/Hrv2Qb0XIIfC5BDgsjrnkt+4FL1iEQScnYT89OX9IJVSYcDvAlCOyDz9AgZMgexsaBg6s1wBrQVfBYixnA9xnVytkBKXS0X6fzmzfGZCBA2+qR6z3YgEfVIm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866698; c=relaxed/simple;
	bh=g1DsUKkKE5QxoofU8cGp0UwxnURYT/y1aUuxGbuiN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVZw2nlQNnzN0mFt7ulWuy1pYVQgnUyg5HwjnbAmZAWRDeGlNyqTEi3jJZrv1Dai83uPyMfYPplJLU8yoZgKwwTpzTxe6ElqmeLUSHonZCApxgXH3IMy3yTTJBO4DT5DpZ9+Z5pGxkrrwslZ4FguewA3dtEyqi882+QrT3VbCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bO0QsdyT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46741855f9bso31076961cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866695; x=1734471495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD13RBY30Rrvkd04V+Adk5FJ3Ta4BXdJd5R/HBJ/aEU=;
        b=bO0QsdyTYyC12fQsU3XL9PAvenHlcaRvNktzEEF82wptUPS7c7HguPE9uR0cPrrfWd
         cmEgt2PdS93C1qteQAoNRxT5d8++ooQrJDi6rtXUs9QWAwcAOzsCspBOYCmlQBd53SYs
         P5v/zRsmE0cNo0923Cfkr8tpAVNJ9F6pbeNiLcj7Ibl4WUpUU6BJz/cbPiBsEa8W2iFW
         m/7+xtbgyTVK5S3m1iQZy8Zlyi/b9+cn3JrKJBB3mhxI/mk3jcHPn1+BTvvycLBLMagz
         nOVQfvNS2nQ9X3ntoPegfJmJQ0a9EmrGC4oZDirigNB7vrAmWXH8LO8N7m4DGT72XqDI
         nmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866695; x=1734471495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD13RBY30Rrvkd04V+Adk5FJ3Ta4BXdJd5R/HBJ/aEU=;
        b=QPi1o3GSkdpELI/pPyVnOacNDzzf5hTYDezR+ttPPDIlKYAQUbtDXh6zrXc07ALFPn
         0x7od1AM33cV2DXDcP2Nm6jNbG6q+rQX2HepRdBluUr4EX688zE6DKEPV2tqQ7y9NA10
         LEsLAPPVV73XwypwaUNuH/69ediW+wni6ahL9IciTymb34h1/3R8GqncRXAOFNpudNki
         LeMUeL0/XtfBwKNFfGlYLU0X5CAMLS9NrtnWcdEDC6XklloXq2yY7TWF85ITUJrZnU4t
         haMr5WD2IikRqgP/QW50JSYaXUPWFFYKvSd5CyvpR835Pg032MeM/7JQrLClFVSANkQ7
         PH+A==
X-Gm-Message-State: AOJu0Yz6hmCwSxItrNTLGuD63qNbPKUGYWoxZvEpxraO5uY50wR/iuzx
	FkRotzlThdq+MPJ9vpcjfLsV1bCzoftoPjy0wLLo5uf9dxOcTabPzpMC+ZD8AnM=
X-Gm-Gg: ASbGncuS6CfoEqQqxGPJmPh4sFtYHWDZ/+Ho5S5Px0SqZ1mCbehgy/72pRf7D3NadZW
	5V0+es5WgI0l6Bpyp6XVrWm6zz4CTRFoqEBgXAi9sXYtdIS9lTyWCmTy/U19nZnCAcY5PRdBagi
	q+Zr6lgwRWamPzAy6RVsiM6SwKjsDomC9JCUBE3NfvtfbPWVlz+gROtZEFZPCLt/aVxYxrDbNxX
	nBujaA14B7w5JkTxAT6w7d5HqeiDcGwICAKbuGgDvixNCOFmAT16/k+x/sldKCNuuhu3+ZEUVAo
	zAsueyTpajW9BiVcBLDR6UMUdj1Ew7z+Ss+ukCc=
X-Google-Smtp-Source: AGHT+IFsnNfg3615eI3lmfgEmFA2vm6QMKjB1yR8PQ1ci2ihqRLidFlxPlnZADQfcm/FjEoxGxlntQ==
X-Received: by 2002:a05:622a:15c8:b0:466:77d0:5941 with SMTP id d75a77b69052e-4678929f162mr8994041cf.10.1733866695082;
        Tue, 10 Dec 2024 13:38:15 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com
Subject: [RFC v2 PATCH 3/5] memory: allow non-fault migration in numa_migrate_check path
Date: Tue, 10 Dec 2024 16:37:42 -0500
Message-ID: <20241210213744.2968-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210213744.2968-1-gourry@gourry.net>
References: <20241210213744.2968-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

numa_migrate_check and mpol_misplaced presume callers are in the
fault path with access to a VMA.  To enable migrations from page
cache, re-using the same logic to handle migration prep is preferable.

Mildly refactor numa_migrate_check and mpol_misplaced so that they may
be called with (vmf = NULL) from non-faulting paths.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory.c    | 24 ++++++++++++++----------
 mm/mempolicy.c | 25 +++++++++++++++++--------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6ad7616918c4..af7ba56a4e1e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5542,7 +5542,20 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int *flags,
 		      bool writable, int *last_cpupid)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	if (vmf) {
+		struct vm_area_struct *vma = vmf->vma;
+		const vm_flags_t vmflags = vma->vm_flags;
+
+		/*
+		 * Flag if the folio is shared between multiple address spaces.
+		 * This used later when determining whether to group tasks.
+		 */
+		if (folio_likely_mapped_shared(folio))
+			*flags |= vmflags & VM_SHARED ? TNF_SHARED : 0;
+
+		/* Record the current PID acceesing VMA */
+		vma_set_access_pid_bit(vma);
+	}
 
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
@@ -5555,12 +5568,6 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	if (!writable)
 		*flags |= TNF_NO_GROUP;
 
-	/*
-	 * Flag if the folio is shared between multiple address spaces. This
-	 * is later used when determining whether to group tasks together
-	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
-		*flags |= TNF_SHARED;
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
@@ -5570,9 +5577,6 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	else
 		*last_cpupid = folio_last_cpupid(folio);
 
-	/* Record the current PID acceesing VMA */
-	vma_set_access_pid_bit(vma);
-
 #ifdef CONFIG_NUMA_BALANCING
 	count_vm_numa_event(NUMA_HINT_FAULTS);
 	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 88eef9776bb0..77a123fa71b0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2746,12 +2746,16 @@ static void sp_free(struct sp_node *n)
  * mpol_misplaced - check whether current folio node is valid in policy
  *
  * @folio: folio to be checked
- * @vmf: structure describing the fault
+ * @vmf: structure describing the fault (NULL if called outside fault path)
  * @addr: virtual address in @vma for shared policy lookup and interleave policy
+ *	  Ignored if vmf is NULL.
  *
  * Lookup current policy node id for vma,addr and "compare to" folio's
- * node id.  Policy determination "mimics" alloc_page_vma().
- * Called from fault path where we know the vma and faulting address.
+ * node id - or task's policy node id if vmf is NULL.  Policy determination
+ * "mimics" alloc_page_vma().
+ *
+ * vmf must be non-NULL if called from fault path where we know the vma and
+ * faulting address. The PTL must be held by caller if vmf is not NULL.
  *
  * Return: NUMA_NO_NODE if the page is in a node that is valid for this
  * policy, or a suitable node ID to allocate a replacement folio from.
@@ -2763,7 +2767,6 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
-	struct vm_area_struct *vma = vmf->vma;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
@@ -2773,18 +2776,24 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	 * Make sure ptl is held so that we don't preempt and we
 	 * have a stable smp processor id
 	 */
-	lockdep_assert_held(vmf->ptl);
-	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
+	if (vmf) {
+		lockdep_assert_held(vmf->ptl);
+		pol = get_vma_policy(vmf->vma, addr, folio_order(folio), &ilx);
+	} else {
+		pol = get_task_policy(current);
+	}
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
 
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
-		polnid = interleave_nid(pol, ilx);
+		polnid = vmf ? interleave_nid(pol, ilx) :
+			       interleave_nodes(pol);
 		break;
 
 	case MPOL_WEIGHTED_INTERLEAVE:
-		polnid = weighted_interleave_nid(pol, ilx);
+		polnid = vmf ? weighted_interleave_nid(pol, ilx) :
+			       weighted_interleave_nodes(pol);
 		break;
 
 	case MPOL_PREFERRED:
-- 
2.43.0


