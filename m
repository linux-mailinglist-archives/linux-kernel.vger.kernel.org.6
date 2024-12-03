Return-Path: <linux-kernel+bounces-429182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC479E1B28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65908B272DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6C1E1A32;
	Tue,  3 Dec 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkn0129V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0F1E00A6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219275; cv=none; b=lzzuv+1TplL3MZ4jPmIEpJ4GJf/ll9kIOt9qXW6pDGWWKo/wRwuymx//gmrzCJVpGxO4GdKLNunnJgbBDPiRrMcpzHe1qdYiVBN3w4WKJSbWOnChQ+DiTItKJdVFcKQqtPZm3q7PVIu8+gpNKAqdawYQLqJfnhoFtoidtFhX8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219275; c=relaxed/simple;
	bh=BE95e1zGPFXvVOiSFQar6b+X36e2g4Vn8nTd7MPy5DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5so+hhxp2Hmsq+i4VM/a2wmhRFNKZy8BBMF53S1vLBENC4lcqEBXMr5vtwpo4YLOw3s8FrdckIKah+HBmTAoSJ3d14vry6b5hZ/Vfp9xqhQ5Lvcd3wGgcbgzhgxgHJ2C4KdpCQjiKQMP0/xBg6iB7XNpDpDrPMVgcuP2EqltfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gkn0129V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fQppTuvH7gihnzA0jS0S7Nrs9VtQXSbfqTsq5GHr48=;
	b=Gkn0129VODbU39zjK+uz4tHao4A3+YIIjrQ0ziVuwXxhJTaWKb3PGOcY4D/wQNBNdzV7ox
	Nw5xoRezhkMjXxCi9zl4tynRsg5CVZ0BugF8zoj61F5p2Ca3a+9AvVqzBVlgK4QZLzErO6
	ovdzj/pSdUxuqS1EkbE1ZjSjbzdesFI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-LT-lDAZQPm6aqPv1ACtzFA-1; Tue, 03 Dec 2024 04:47:51 -0500
X-MC-Unique: LT-lDAZQPm6aqPv1ACtzFA-1
X-Mimecast-MFC-AGG-ID: LT-lDAZQPm6aqPv1ACtzFA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so29955525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219270; x=1733824070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fQppTuvH7gihnzA0jS0S7Nrs9VtQXSbfqTsq5GHr48=;
        b=gWjvrfSST875HpI88+OCZSGdfuvWoPSZTwDXEqv2c73HJQK0Uxyg45LzYdrTUFvgZs
         diEDf9cd5RM/M145TNFpUVNTZQ/HK0O1WYhcVfiLZ881PWxp0hm8wRKwCDF2kAAEb2Yl
         qRE8E8t7SqeB3IB+qinMxup8JD55r0kQNgDUrk6VJh0jnBmpcXx+WU8Jmp9IeeGP0UOi
         q8KLNl5KpoXawwVM7YGcZyUUe8jgiVwg7bAbhhorXWWpz3ahFGnitNT0V/Mvpc07/b07
         3PHf8CB7v6WZLIy5bcfsKh5vnAeBkgZjsPw3zcZQPVCzmDET8T4IwAwzWaNUcQdP12r6
         27CQ==
X-Gm-Message-State: AOJu0YxtbsTVqIf0djchNB8SxWf+USY7mhTHxtRUSUyEgqOplY9IcS/9
	0OKUnzk4wtAzAXoo8z0fxTVUGjUY7lOrMRYZNpFyTxmTouYOsJ8T5tQU4IQkWVDeJszsUd0hj03
	pxT/cLdznY6AGage9d0LkNGwnDXQ5vZ+1myV5XOVMkmKZzQXzAKvY+piQRZ8mgSIy7vniUJfCiO
	h3iLkSHGgmbe0Tc2FZYPrv3vCZeZ7CF9kq7TsWPizndZcR
X-Gm-Gg: ASbGnct1KomCZK3NHIt/vVOzcOt+s2YuAwWoMmKwF3Km/Jm89Gmue1378ngiKTas74n
	gVFERlV7nNWDrDiljwNs7gdxhnIwYwS3kRvcRKfDciQYk/NHWZhgdCjVlaWXGuYtFb9nGzJbMAw
	7AjwtWByF39sTjh7POztoVs/luWoulZns3xUfXByoC5OOgsl/rdXwFxL17jGEgY+B0dEa97LSYR
	pUew9AeYf+VBV0uoHP4kUVxcZrnfOH1nGPcpZtcYsV1SBwQEEPCXUsIbgzQno3yHy77z/Msryi3
	z+0L0bNfykW3WliiJMVdRiieczC2sVLhatw=
X-Received: by 2002:a05:600c:4fc9:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434d09bf4b7mr16320915e9.13.1733219270433;
        Tue, 03 Dec 2024 01:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGScK9nYDBCgbazhX5KZLpi1/ltXaWURuwLWZA1yYPBlDObPA+UiToZ3Fi0RuyRTQ0aGN5NvQ==
X-Received: by 2002:a05:600c:4fc9:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434d09bf4b7mr16320445e9.13.1733219269891;
        Tue, 03 Dec 2024 01:47:49 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434b0dbe2e7sm183147395e9.11.2024.12.03.01.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:48 -0800 (PST)
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
Subject: [PATCH RESEND v2 5/6] mm/page_alloc: forward the gfp flags from alloc_contig_range() to post_alloc_hook()
Date: Tue,  3 Dec 2024 10:47:31 +0100
Message-ID: <20241203094732.200195-6-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203094732.200195-1-david@redhat.com>
References: <20241203094732.200195-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the __GFP_COMP case, we already pass the gfp_flags to
prep_new_page()->post_alloc_hook(). However, in the !__GFP_COMP case, we
essentially pass only hardcoded __GFP_MOVABLE to post_alloc_hook(),
preventing some action modifiers from being effective..

Let's pass our now properly adjusted gfp flags there as well.

This way, we can now support __GFP_ZERO for alloc_contig_*().

As a side effect, we now also support __GFP_SKIP_ZERO and__GFP_ZEROTAGS;
but we'll keep the more special stuff (KASAN, NOLOCKDEP) disabled for
now.

It's worth noting that with __GFP_ZERO, we might unnecessarily zero pages
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


