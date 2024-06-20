Return-Path: <linux-kernel+bounces-223539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B39114A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5B01C21602
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D38248B;
	Thu, 20 Jun 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd/mCZ74"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04679B96
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918988; cv=none; b=DeBgzOj/jxZ7E1e/fQK+swRyYebLfe8REqM5UoZCcGiDIHhpM3g/gGFiOp/v3rwfUUwf7mh/NmqkpWk9wsxX0hP1vsoFZQmfS8tKmnvI5U4EuFpqyzsWwm12lIe/oW7ZO3CL469rtAibN4sHWKbvgvG/DT7lRobc6BQfdUSwmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918988; c=relaxed/simple;
	bh=qTVXqLVCn+Kv8ZXpH+sDy7DBf7Ox/qMQ6vsl50hijTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch1tn4K9ABYvOZGFyvIvsQE3jSLBTRELLvb8lHuvc8Z19uklcoShnBqc/dzeTtcng9sxRs6JXyZuACTLMvz46TLc7N78pEXlfTsh8yc/HfzGkTTc/JHxP5oqeVm9kFPtNiVPO9WM9ZTDQrRjTBX/IJ8cjiVoRu5V0iDIf3BKdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hd/mCZ74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8fADU+tpn7PNLzSRE304F4HQd7gYSTzoHkzIPIJxw=;
	b=Hd/mCZ74gAwfZZ63qX7YTRX7Sakwu3Gojkm/vj3ySECWDODYR69IKc2rCTiZHQjIZX6Fxv
	V1h26p/PeHk68ApyvGrhuQpBqxVCPDBouRXJ7L8JihI6MPLgrOqkuQ2/H5rlVUz8OX6I37
	ILbTUuMTesA6M4wHvc6ZVbaeAuU6acM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-k-WL8-eDOdiUBrpc2x04QQ-1; Thu,
 20 Jun 2024 17:29:42 -0400
X-MC-Unique: k-WL8-eDOdiUBrpc2x04QQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D7F19560B9;
	Thu, 20 Jun 2024 21:29:41 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.54])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AA4E19560AF;
	Thu, 20 Jun 2024 21:29:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/2] mm/migrate: make migrate_misplaced_folio() return 0 on success
Date: Thu, 20 Jun 2024 23:29:34 +0200
Message-ID: <20240620212935.656243-2-david@redhat.com>
In-Reply-To: <20240620212935.656243-1-david@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Let's just return 0 on success, which is less confusing.

... especially because we got it wrong in the migrate.h stub where we
have "return -EAGAIN; /* can't migrate now */" instead of "return 0;".
Likely this wrong return value doesn't currently matter, but it
certainly adds confusion.

We'll add migrate_misplaced_folio_prepare() next, where we want to use
the same "return 0 on success" approach, so let's just clean this up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 5 ++---
 mm/memory.c      | 2 +-
 mm/migrate.c     | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0fffaa58a47a..fc27dabcd8e3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1652,7 +1652,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int nid = NUMA_NO_NODE;
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
-	bool migrated = false, writable = false;
+	bool writable = false;
 	int flags = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -1696,8 +1696,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
-	migrated = migrate_misplaced_folio(folio, vma, target_nid);
-	if (migrated) {
+	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 00728ea95583..118660de5bcc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5354,7 +5354,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ignore_writable = true;
 
 	/* Migrate to the requested node */
-	if (migrate_misplaced_folio(folio, vma, target_nid)) {
+	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index 781979567f64..0307b54879a0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2629,11 +2629,11 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 					    nr_succeeded);
 	}
 	BUG_ON(!list_empty(&migratepages));
-	return isolated;
+	return isolated ? 0 : -EAGAIN;
 
 out:
 	folio_put(folio);
-	return 0;
+	return -EAGAIN;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.45.2


