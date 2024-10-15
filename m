Return-Path: <linux-kernel+bounces-365635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67D99E546
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12251C2280E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D41E282B;
	Tue, 15 Oct 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7gj6EDM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343B1D8DE2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990768; cv=none; b=e7GINFrV5XVL9FSTtVEy988cDQSb8qCcQ4lsBB1f/g+2WIE6MsGQXNZKadXavIcWlENdQGbubaEY/6L5fjixbVo2DYoniTmvVHbRfXef9xIzEDpIwKnlx+ShqQ10V9TeKwajv1jGr1F59YmwCeyHHgH3/5v4+VPkxCMm/253ufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990768; c=relaxed/simple;
	bh=oQpPnSHqHaLiYYYFF2UyAiPCc7Z8Zr4iy8BfXMocRog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcJnyLNyNLz5QJDHWQH3GjU0d+ujBbNy6fpDOCVC8KyD7wFYmayuRNyNpIDTjjrGpMuZWJt0B2NmWIg2/NMOANvz7B19pjQ1OTbOjxPHJR7nw7MyomCJO9KxDVAgGqRTnGXeOZ2fxWU895frO/FTsbfAl1w7fOOaoImRplro+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7gj6EDM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728990765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FHbFI2SXndzro2xjf3G5uBQtpAQZ1sA34BP2wLkHiAs=;
	b=A7gj6EDMCk8SxNqBHa66ZH4X+5eBIfkYbtAw44QuAU+LNF/1TJBLqg/w7KHauh/V0dUzi3
	qS8nVB4uYv5dnMFQKkS1rLUefFRmR1DQCbvr3aoJ2dTCKWVHeWEIG/U4wPsLqAJCk1sjmm
	ro2DUr6mQUHIV4NVZSBd55SxVOxPbFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-KqxHEe-KOGCPKqDu-MxQYw-1; Tue,
 15 Oct 2024 07:12:42 -0400
X-MC-Unique: KqxHEe-KOGCPKqDu-MxQYw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD22B194511A;
	Tue, 15 Oct 2024 11:12:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 230863000198;
	Tue, 15 Oct 2024 11:12:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf() without present check
Date: Tue, 15 Oct 2024 13:12:36 +0200
Message-ID: <20241015111236.1290921-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check on
some architectures. We really should check for
pmd_present()/pud_present() first.

This should explain the report we got on ppc64 (which has
CONFIG_PGTABLE_HAS_HUGE_LEAVES set in the config) that triggered:
	VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));

Likely we had a PMD migration entry for which pmd_leaf() did not
trigger. We raced with restoring the PMD migration entry, and suddenly
saw a pmd_leaf(). In this case, pte_offset_map_lock() saved us from more
trouble, because it rechecks the PMD value, but we would not have processed
the migration entry -- which is not too bad because the only user of
FW_MIGRATION is KSM for unsharing, and KSM only applies to small folios.

Further, we shouldn't re-read the PMD/PUD value for our warning, the
primary purpose of the VM_WARN_ON_ONCE() is to find spurious use of
pmd_leaf()/pud_leaf() without CONFIG_PGTABLE_HAS_HUGE_LEAVES.

As a side note, we are currently not implementing FW_MIGRATION support
for PUD migration entries, which likely should exist due to hugetlb. Add
a TODO so this won't fall through the cracks if more FW_MIGRATION users
get added.

Fixes: aa39ca6940f1 ("mm/pagewalk: introduce folio_walk_start() + folio_walk_end()")
Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/670d3248.050a0220.3e960.0064.GAE@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/pagewalk.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 461ea3bbd8d9..5f9f01532e67 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -744,7 +744,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 	pud = pudp_get(pudp);
 	if (pud_none(pud))
 		goto not_found;
-	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pud_leaf(pud)) {
+	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) &&
+	    (!pud_present(pud) || pud_leaf(pud))) {
 		ptl = pud_lock(vma->vm_mm, pudp);
 		pud = pudp_get(pudp);
 
@@ -753,6 +754,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
+		/*
+		 * TODO: FW_MIGRATION support for PUD migration entries
+		 * once there are relevant users.
+		 */
 		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
@@ -769,12 +774,13 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 	}
 
 pmd_table:
-	VM_WARN_ON_ONCE(pud_leaf(*pudp));
+	VM_WARN_ON_ONCE(!pud_present(pud) || pud_leaf(pud));
 	pmdp = pmd_offset(pudp, addr);
 	pmd = pmdp_get_lockless(pmdp);
 	if (pmd_none(pmd))
 		goto not_found;
-	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) && pmd_leaf(pmd)) {
+	if (IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES) &&
+	    (!pmd_present(pmd) || pmd_leaf(pmd))) {
 		ptl = pmd_lock(vma->vm_mm, pmdp);
 		pmd = pmdp_get(pmdp);
 
@@ -786,7 +792,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		if (pmd_none(pmd)) {
 			spin_unlock(ptl);
 			goto not_found;
-		} else if (!pmd_leaf(pmd)) {
+		} else if (pmd_present(pmd) && !pmd_leaf(pmd)) {
 			spin_unlock(ptl);
 			goto pte_table;
 		} else if (pmd_present(pmd)) {
@@ -812,7 +818,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 	}
 
 pte_table:
-	VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));
+	VM_WARN_ON_ONCE(!pmd_present(pmd) || pmd_leaf(pmd));
 	ptep = pte_offset_map_lock(vma->vm_mm, pmdp, addr, &ptl);
 	if (!ptep)
 		goto not_found;
-- 
2.46.1


