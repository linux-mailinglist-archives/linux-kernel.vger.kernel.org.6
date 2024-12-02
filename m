Return-Path: <linux-kernel+bounces-427558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB79E02C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C54169CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DF20899E;
	Mon,  2 Dec 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8JuK9t+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B31FF7AD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144334; cv=none; b=s+mheSs75UpJCI7eaRiR2Be3/5ZEL6ZC6KS0nRi1HpoCBWMH/PqHFTZdVu7nk83GkdKDRv0OB8qcugaLfsaKRaXOmtUdazf7jhcNjfG7mT3PAT2jf3tL7p6oXfdZzx6fsz0XR1Mja/Arm6ZDiT9g1hZTZGee/HtLPH5OK+IlsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144334; c=relaxed/simple;
	bh=mY0uQvqj3w6aRHfh17h6ieQ/XBDaLu0Zxfk6AWTaqvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw8bH17uGCPxMgnk6qQ7OkG0X/y3RBRDHYmMWVzeTTr+vhMHQ0Hf7gHWCYsciBgr0upgelJK/FAgrz6uMVqIkU5jFyB4dUYUMRJxHv8Gu/ttVaAECKes9eFM7eFAbAnFf2RpoYIuKVr5dmyIpcExuYFBBrYoDG9ptPkQhvmj5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8JuK9t+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733144332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HP8ABYEm75mn1BmFryMatwFYZ4LLrOWgOCnAtcF7Tc=;
	b=i8JuK9t+VnWmMdKPCdtDlD0jANIjnbTSuJvn1tQNmbFJYVLVnO0VOyIbUjSfrrgf/rj+yd
	wm4VsI0PinYv9iS7tDeRIoKNyELHUpLC6WYiNJJl8vO73F9my7QYBj0bE21s0d/3MMu5+x
	UZTHPSb4IhRgdMteWMrgycS0il3CWJ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-2zDHXoRjPpyrImBN_4zy5g-1; Mon,
 02 Dec 2024 07:58:47 -0500
X-MC-Unique: 2zDHXoRjPpyrImBN_4zy5g-1
X-Mimecast-MFC-AGG-ID: 2zDHXoRjPpyrImBN_4zy5g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3121D1964CCE;
	Mon,  2 Dec 2024 12:58:45 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFAD6195605A;
	Mon,  2 Dec 2024 12:58:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v1 5/6] mm/page_alloc: forward the gfp flags from alloc_contig_range() to post_alloc_hook()
Date: Mon,  2 Dec 2024 13:58:11 +0100
Message-ID: <20241202125812.561028-6-david@redhat.com>
In-Reply-To: <20241202125812.561028-1-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In the __GFP_CONT case, we already pass the gfp_flags to
prep_new_page()->post_alloc_hook(). However, in the !__GFP_CONT case, we
essentially pass only hardcoded __GFP_MOVABLE to post_alloc_hook(),
preventing some action modifiers from being effective..

Let's pass our now properly adjusted gfp flags there as well.

This way, we can now support __GFP_ZERO for alloc_contig_*().

As a side effect, we now also support __GFP_SKIP_ZERO and__GFP_ZEROTAGS;
but we'll keep the more special stuff (KASAN, NOLOCKDEP) disabled for
now.

It's worth nothing that with __GFP_ZERO, we might unnecessarily zero pages
when we have to release part of our range using free_contig_range() again.
This can be optimized in the future, if ever required; the caller we'll
be converting (powernv/memtrace) next won't trigger this.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54594cc4f650..71d70bc0ad79 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6364,7 +6364,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	return (ret < 0) ? ret : 0;
 }
 
-static void split_free_pages(struct list_head *list)
+static void split_free_pages(struct list_head *list, gfp_t gfp_mask)
 {
 	int order;
 
@@ -6375,7 +6375,7 @@ static void split_free_pages(struct list_head *list)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, __GFP_MOVABLE);
+			post_alloc_hook(page, order, gfp_mask);
 			set_page_refcounted(page);
 			if (!order)
 				continue;
@@ -6393,7 +6393,8 @@ static void split_free_pages(struct list_head *list)
 static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 {
 	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
-	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN |
+				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO;
 	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
 	/*
@@ -6541,7 +6542,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	}
 
 	if (!(gfp_mask & __GFP_COMP)) {
-		split_free_pages(cc.freepages);
+		split_free_pages(cc.freepages, gfp_mask);
 
 		/* Free head and tail (if any) */
 		if (start != outer_start)
-- 
2.47.1


