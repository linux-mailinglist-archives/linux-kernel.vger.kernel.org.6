Return-Path: <linux-kernel+bounces-173711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC58C0477
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F471C20BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CC130A40;
	Wed,  8 May 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmxB1iPm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298713049B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193048; cv=none; b=df0LfiNG5orQ/S90TWNAIeWDSNc9uaqloeagnM+9yJ2EGSC5U8Ov7MP6F/NnUF4JOVQVd8/pWodeePy168KEC6HG9ZXND3dw0a6DDcbuW6/jECZ7WufcRKhGt8Gazb9w1rk/jmZv/rYIMvirNqCsCiCcVGxd0CfkDpAm6A79abY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193048; c=relaxed/simple;
	bh=REiKTjB5W6PjMHaoXVnysNIszjXK5RKLJJ6FNByQdzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPegWqNLQXanT55rPDX2LviKyZeWoOUnjtTe1FUfxWDA4TugQMwsYid7bCHwtJoOTYUUZg4PhtW/RPnN5PivH7/EXZehm0Rec4nq0HH28ZbcK/6usBFcE8s89L3ybKrNMZxsGaJJurioDZOT6CML2RLMfVHgma90oaYm6x5cFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmxB1iPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=co8YhVpiS2u93sCq2Y2snJ8ldSVnZQFxzC5QqTWtcW8=;
	b=hmxB1iPm3y4hAJLzEzVyEiOcGz4fY+EazfhOKeLFXpt1Pot1qbupVKmxB3Fme86Ag3zSZN
	stkjmkARyoLYKFR9UpYC1WvJH5p6E9tKG21yy76/ekRwFUV5MUTiDsjk3o27O7rMWygZ8J
	z/cIsHelTI2FKC9fBcbsqDjB4N7ZO8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-kc1v_k0JNoCo06US66xzHQ-1; Wed, 08 May 2024 14:30:41 -0400
X-MC-Unique: kc1v_k0JNoCo06US66xzHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D140684B165;
	Wed,  8 May 2024 18:30:33 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC961005B83;
	Wed,  8 May 2024 18:30:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 10/10] s390/hugetlb: convert PG_arch_1 code to work on folio->flags
Date: Wed,  8 May 2024 20:29:55 +0200
Message-ID: <20240508182955.358628-11-david@redhat.com>
In-Reply-To: <20240508182955.358628-1-david@redhat.com>
References: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Let's make it clearer that we are always working on folio flags and
never page flags of tail pages by converting remaining PG_arch_1 users
that modify page->flags to modify folio->flags instead.

No functional change intended, because we would always have worked with
the head page (where page->flags corresponds to folio->flags) and never
with tail pages.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c        | 4 ++--
 arch/s390/mm/hugetlbpage.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 797068dccb73..7319be707a98 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2733,7 +2733,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 {
 	pmd_t *pmd = (pmd_t *)pte;
 	unsigned long start, end;
-	struct page *page = pmd_page(*pmd);
+	struct folio *folio = page_folio(pmd_page(*pmd));
 
 	/*
 	 * The write check makes sure we do not set a key on shared
@@ -2748,7 +2748,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	start = pmd_val(*pmd) & HPAGE_MASK;
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
-	set_bit(PG_arch_1, &page->flags);
+	set_bit(PG_arch_1, &folio->flags);
 	cond_resched();
 	return 0;
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c2e8242bd15d..a32047315f9a 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -121,7 +121,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 
 static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned long size, paddr;
 
 	if (!mm_uses_skeys(mm) ||
@@ -129,16 +129,16 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 		return;
 
 	if ((rste & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
-		page = pud_page(__pud(rste));
+		folio = page_folio(pud_page(__pud(rste)));
 		size = PUD_SIZE;
 		paddr = rste & PUD_MASK;
 	} else {
-		page = pmd_page(__pmd(rste));
+		folio = page_folio(pmd_page(__pmd(rste)));
 		size = PMD_SIZE;
 		paddr = rste & PMD_MASK;
 	}
 
-	if (!test_and_set_bit(PG_arch_1, &page->flags))
+	if (!test_and_set_bit(PG_arch_1, &folio->flags))
 		__storage_key_init_range(paddr, paddr + size - 1);
 }
 
-- 
2.45.0


