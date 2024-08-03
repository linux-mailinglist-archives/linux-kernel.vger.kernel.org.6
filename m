Return-Path: <linux-kernel+bounces-278664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AF94B34A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30EB283B71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D01155CAF;
	Wed,  7 Aug 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WKmZTY4k"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142E1552F5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071523; cv=none; b=jVnwpNlBN378q6v1dEXtjA6SqOUYM9eEteeQgMYU4gmIQ/vYNWdh55wYtywdX2lGs2jNgUwRvtOKMeI/aYRVLMORbC7hQDrUJcsLQ90GRcb95kOHr1hFE/WgoRElC4HNp/09gu4Ktsg4Pwc5FjzmkOUxJoWQxEVONetsQn45+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071523; c=relaxed/simple;
	bh=JXuF/AUNV55eySyafE/MsTxi+gk8RZaCii1ThT5rnlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzQh1HQ6SUznRmmeNo1jB2cSpf3d+KFhc6duZoOeNUOKIK0FTz7abifUrKoy1jv2MQ4CTU4mjZjDIp6l4UWUmgesGcIOQu1b4acjoGBteSQcahGLd+L0bfsZGWxdG/7YVrjtorRizrq/qyX4alRDFhHUbfVOoreINyGlIqkJhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WKmZTY4k; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b78c980981so2275566d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723071520; x=1723676320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/7er4oz/4902b2ijGv9reJfVXMZ4xWqxFGlkwKTX4E=;
        b=WKmZTY4kM87LfluZxYbbpv9jSkA1fYR3WQNGhwINwEwH3yoXYUVQ/uzQTZrzntJ6Wj
         PI7llZcsfEzCLSS9dcIfiZ0xnBa7jxpTLRIWrb9+62MbLCacixemyojiNWgc6PWMUJZe
         F6/k+CWfZHfzgkXled5gvwQ3vU6f/3rkgcsmwi9Nb46hvGQzFNminQrjMATUcY8ug3IV
         0LVafkeq4K/AEm95WawZOQ+02vBX5ChcHkFIpS2RQvD8v1mia275ubJr/Uim4ySurkoV
         s+ZZwiaaRdfkNC+4o9qyRodgn5H05Rw0OoRcH/Y820qg22urAKSDU59IeoqWfX2Jm9Hc
         CAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071520; x=1723676320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/7er4oz/4902b2ijGv9reJfVXMZ4xWqxFGlkwKTX4E=;
        b=rPktNn8WL27iDNjpK7oUYQahf4JFzer2P8ZMbUIv0YFK8gmEMgWNbUXHj9YlJT3sIi
         5RiRp909D6OM71tSxj/r/eT6TVUe5XtteOi3li9IEZ8uxKdCTJOCY4sxgzBs7SSkhw4D
         FS6MvR+ECDIJgG7+YSsgJdbS4pfM/7uNjrtOcE6y7m6Fg0yDY2QydAGs4t60Z0PolHU5
         YH6jUA5M6e5wwi9FHuHSTRU+CtXKWCfjhaH3Q3CVgE5yRrZuNqMNHcqCdxzjsQM+2TUA
         JSv9MdUl5ImVBrv631eBBFo17ux1WWIZfBSyOAY9ByqseMT7QFhoONQd9aWKer/wjyaU
         fKcQ==
X-Gm-Message-State: AOJu0YzOWvTEp9V2ePRtrFmCcVHKeRfy6Tg9Ex/BmEUO591YqPBFKau6
	xEbgKZZwcQk/DtuAQUMG6NGd+L7qnNmJhWsaN29lBAA4DAbfgFRn8p443fQa21M=
X-Google-Smtp-Source: AGHT+IGFCy2UHYgt4IIneWbe6R0Qmijoz2vCe9+ULRLqYf4jz2jZaZqML+9wKCYl3E8e9BtQP0+9yw==
X-Received: by 2002:a05:6214:5f0d:b0:6bb:b9fe:cd15 with SMTP id 6a1803df08f44-6bd6bd7e51dmr1695066d6.40.1723071519924;
        Wed, 07 Aug 2024 15:58:39 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b82cbsm59997096d6.61.2024.08.07.15.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:58:39 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	nehagholkar@meta.com,
	abhishekd@meta.com
Subject: [PATCH 2/3] memory: allow non-fault migration in numa_migrate_prep path
Date: Sat,  3 Aug 2024 05:47:14 -0400
Message-ID: <20240803094715.23900-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803094715.23900-1-gourry@gourry.net>
References: <20240803094715.23900-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

numa_migrate_prep and mpol_misplaced presume callers are in the
fault path.  To enable migrations from the pagecache, re-using
the same logic to handle migration prep would be preferable.

Mildly refactor numa_migrate_prep and mpol_misplaced so that it
may be called with (vmf=NULL) from non-faulting paths.

Count non-fault events as page-cache numa hints instead of
fault hints.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/vm_event_item.h |  1 +
 mm/memory.c                   | 19 ++++++++++---------
 mm/mempolicy.c                | 25 +++++++++++++++++--------
 mm/vmstat.c                   |  1 +
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..b917bcfffe6d 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -62,6 +62,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HUGE_PTE_UPDATES,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
+		NUMA_HINT_PAGE_CACHE,
 		NUMA_PAGE_MIGRATE,
 #endif
 #ifdef CONFIG_MIGRATION
diff --git a/mm/memory.c b/mm/memory.c
index 1d97bdfd0ed6..8b664b08915c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5205,15 +5205,16 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 		      unsigned long addr, int page_nid, int *flags)
 {
-	struct vm_area_struct *vma = vmf->vma;
-
-	/* Record the current PID acceesing VMA */
-	vma_set_access_pid_bit(vma);
-
-	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid == numa_node_id()) {
-		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
-		*flags |= TNF_FAULT_LOCAL;
+	/* If accessed in fault path, record the current PID acceesing VMA */
+	if (vmf) {
+		vma_set_access_pid_bit(vmf->vma);
+		count_vm_numa_event(NUMA_HINT_FAULTS);
+		if (page_nid == numa_node_id()) {
+			count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+			*flags |= TNF_FAULT_LOCAL;
+		}
+	} else {
+		count_vm_numa_event(NUMA_HINT_PAGE_CACHE);
 	}
 
 	return mpol_misplaced(folio, vmf, addr);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..0f654aff477a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2726,12 +2726,16 @@ static void sp_free(struct sp_node *n)
  * mpol_misplaced - check whether current folio node is valid in policy
  *
  * @folio: folio to be checked
- * @vmf: structure describing the fault
+ * @vmf: structure describing the fault (NULL if called outside fault path)
  * @addr: virtual address in @vma for shared policy lookup and interleave policy
+ *        Ignored if vmf is NULL.
  *
  * Lookup current policy node id for vma,addr and "compare to" folio's
- * node id.  Policy determination "mimics" alloc_page_vma().
- * Called from fault path where we know the vma and faulting address.
+ * node id - or task's policy node id if vmf is NULL.  Policy determination
+ * "mimics" alloc_page_vma()
+ *
+ * vmf must be non-NULL if called from fault path where we know the vma and
+ * faulting address. The PTL must be held by caller if vmf is not NULL.
  *
  * Return: NUMA_NO_NODE if the page is in a node that is valid for this
  * policy, or a suitable node ID to allocate a replacement folio from.
@@ -2743,7 +2747,6 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
-	struct vm_area_struct *vma = vmf->vma;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = numa_node_id();
 	int polnid = NUMA_NO_NODE;
@@ -2753,18 +2756,24 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	 * Make sure ptl is held so that we don't preempt and we
 	 * have a stable smp processor id
 	 */
-	lockdep_assert_held(vmf->ptl);
-	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
+	if (vmf) {
+		lockdep_assert_held(vmf->ptl);
+		pol = get_vma_policy(vmf->vma, addr, folio_order(folio), &ilx);
+	} else
+		pol = get_task_policy(current);
+
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
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 04a1cb6cc636..5a02e6ff043d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1316,6 +1316,7 @@ const char * const vmstat_text[] = {
 	"numa_huge_pte_updates",
 	"numa_hint_faults",
 	"numa_hint_faults_local",
+	"numa_hint_page_cache",
 	"numa_pages_migrated",
 #endif
 #ifdef CONFIG_MIGRATION
-- 
2.43.0


