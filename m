Return-Path: <linux-kernel+bounces-423713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1939DABC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BB28216F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E8201012;
	Wed, 27 Nov 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H6A/gRNn"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3D200BA0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724928; cv=none; b=j7RbEMFua7FqrSKFfgimPJtaIXPaTfRW6i6x4sSq2Bk+sfasimkCrocDQb7w3jKXMhVxVKgTR3AEO6XnGacu3mF2DH6+elHI9b4qHSEQdcAn4YK21bU6KmWyUssQ1Bu1iY6PNGXdhIdSnzjnN3mfUF84a5OHMZmLR5Rao5osuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724928; c=relaxed/simple;
	bh=09oWr2CEAWWbVHzonkFNu6O/nfXC7MQTkP+NgsRnT8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O98KbUzxHeoTy+vjhjZMEJ615zWEcvlV2s0B4z5ltoj5tIofcwT7ljQ4gh9REujxY4wdg6jpu58twjD57qPNysojxqNZ5kib4K/yUWelooxd+D15eMXadKUyl+3hXzTlS9YqRAcpFTN0/gIDWtKMt5q1+eyx3TTd7zao/Rt8Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H6A/gRNn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b670de79e6so175079985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732724925; x=1733329725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YVRetr6ViR4L1BBUGXRQMyVoFD2gs0Ovt3TmolcbLM=;
        b=H6A/gRNnXwtiX/HoGKkQvw8VtCz2/IKeIlF/EJrCPGBCw78fUyubHNRUar9ZCq0a69
         HCyrJwos+nZkztl0IFjZh1lQ2ZksoMbyk7BjE6RAzM42lE0N3B/OkvcgRr9VB6QZWZaU
         nj8PtugtkRDmsAJI07sScI3+RYEoKM67XSU6yNIuaUGA/jx3xVgfjjxfzvjVBKb7cji7
         vollIWF5DDTY8afjajav89QTYEbdysAZ0xXd7+UJeTvNk0M5r98Nst6OwP3Yto51H4ZN
         33c9XrZ1qdDWrMz75ByHBXjO8ZRUsmAXe9Ob9IWpIW8qym4kZh3ivbM1RG7FtGJ5kY/B
         N5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724925; x=1733329725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YVRetr6ViR4L1BBUGXRQMyVoFD2gs0Ovt3TmolcbLM=;
        b=bw2i7Z2pE7OlXpK529E1YDV2j2iKtkGFCpZNi/Hg6IUmBKs0mFzPjheSwF7Rg62lDc
         n4NAqE8RhIDmnmqwb0RcRs4Ualr12aR3713Fq9aIycn4OndavYLS8LXJW753yoatFt+L
         mhXHUjCjRrm/8pqUlXkrbM17TmhLcPIoJvSg+xpRnYyQHuSIqaiuCWmgihebljzljPG4
         KgZoIJmxpRoHdprdZ8nWQsZPyFIb4eV8qAX+41u1z2aJeOsrbRxDNbdURR7rjU3wGMed
         us7ufm4X0QMlehnooHZOJtgbmuuXwTrZ1mDCooIEz35fsn8X1PGRtjmwG2jLRGnNrHI3
         PMjw==
X-Gm-Message-State: AOJu0YysfD00MHrCyOoTLqGlN7qeLhhAYSzFtHFcrcJAhbtP7k6fPER6
	WAJDpb0/9PEULMJ9uChrloxpLrDM2+oCGPCCOUWYpEDgZGhhJysWj0VYc1u7bcs=
X-Gm-Gg: ASbGnctpT0gyfpvNic/Iuity7u+6eLfvZ+9Ut/F3PK8r7+jnz10flEjCaByc6I/LxEe
	bDNOBwxIhOOnauPePvy2tXgId6wruLAOP2b5vsiNfZbyYKC6ng3y5dFQvyN+/XpRs5Tr03CUf9m
	yyx5lpOUM78KlvWWn8Z19Haq814Ry+j9FG06jA2/XJTaMoG6NQvbPbOcGBPgPN+ovrmgB6GT9It
	QY4s+f8IcDfpddIC7anfdendXLMp37l9dBu0FXoMPac4lpphXgcGVxdduR38yDZfrmDIIXz99m1
	NOe8PFV1AN8z1DO3qH2GCY6JtnlrYHBkkKs=
X-Google-Smtp-Source: AGHT+IE7MyR6097VIWfq3+is83/Yc33iicre1dSbm4nHjYBDTL/wY941BZN4EnUeI4leGNLYuU1nKQ==
X-Received: by 2002:a05:620a:2915:b0:7b3:51a5:556 with SMTP id af79cd13be357-7b67c292a7cmr475141385a.22.1732724925502;
        Wed, 27 Nov 2024 08:28:45 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466871721c2sm45002921cf.17.2024.11.27.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:45 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	feng.tang@intel.com,
	kbusch@meta.com
Subject: [PATCH 2/4] memory: allow non-fault migration in numa_migrate_check path
Date: Wed, 27 Nov 2024 03:21:59 -0500
Message-ID: <20241127082201.1276-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127082201.1276-1-gourry@gourry.net>
References: <20241127082201.1276-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

numa_migrate_check and mpol_misplaced presume callers are in the
fault path with accessed to a VMA.  To enable migrations from page
cache, re-using the same logic to handle migration prep is preferable.

Mildly refactor numa_migrate_check and mpol_misplaced so that they may
be called with (vmf = NULL) from non-faulting paths.

Also move from numa balancing defines inside the appropriate ifdef.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory.c    | 28 ++++++++++++++++------------
 mm/mempolicy.c | 25 +++++++++++++++++--------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..a373b6ad0b34 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5471,7 +5471,20 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
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
@@ -5484,12 +5497,6 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
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
@@ -5499,17 +5506,14 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	else
 		*last_cpupid = folio_last_cpupid(folio);
 
-	/* Record the current PID acceesing VMA */
-	vma_set_access_pid_bit(vma);
-
-	count_vm_numa_event(NUMA_HINT_FAULTS);
 #ifdef CONFIG_NUMA_BALANCING
+	count_vm_numa_event(NUMA_HINT_FAULTS);
 	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
-#endif
 	if (folio_nid(folio) == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
 	}
+#endif
 
 	return mpol_misplaced(folio, vmf, addr);
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bb37cd1a51d8..eb6c97bccea3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2727,12 +2727,16 @@ static void sp_free(struct sp_node *n)
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
@@ -2744,7 +2748,6 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
-	struct vm_area_struct *vma = vmf->vma;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
@@ -2754,18 +2757,24 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
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


