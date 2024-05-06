Return-Path: <linux-kernel+bounces-170384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702B8BD619
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E43B20EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD315B103;
	Mon,  6 May 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIYsBsJX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4256B76
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026693; cv=none; b=bdtr/c6g4OGo5Uk4UsBMuZaGwnYyatMODIOeEsrq5+yBrxUxvihIWhwYqfJApJwjtklz5N/C5ICbeOLURD8YBbKnMRPxM8cPbagLY1pDGP0FIsEiXZ06jdU3CDjAwYT7J8pBDg5TcYlMZqo5IEMuUnE2dR0tDJyeGHc9qfVbY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026693; c=relaxed/simple;
	bh=ybmPn8EY6+glfdzBVvw7ahtPjU9ai3JL0nZaaSw7Drk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W+9VgV0uYOYWr0Pv/I+I8+JDNLmfMWqCb1w++8pqLPuYvpKavYY0xq5By/FhF/6IDJ139ssl6CKMV34B8QE6rGqWbD4pYyORN+0gySDrV8htAlIF/PdOZwvPDOpXMqonPeeIw73KkVc6DCjRJVA95Cr9jgvIOquENiF0LviI7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIYsBsJX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61df903af62so47775377b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715026690; x=1715631490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwFOhdOI6jYmDLMArB0z5zEnwyrO6RqamuYEZi4wtk=;
        b=aIYsBsJXLobrkZ6c7BbCqHOTWL0d4LOTTjrmhXmvqqszMuIJH5LH1i8uJ/weJ1H+47
         6GHmLBeoqNXaX1OWpLL4SpDl8UhXXfZhShAwqqTMffLu1Zxtuly279WGCePmFJTIsKPM
         DKZF4whetrToXQivM0zFVDdFHl9BS93CNenC6q5ZIxCOb4c3tFVJyCfWaTLckNbSTxj4
         CSJYgbpgxhIdrFG/ylQMUNmmDmm2Xr7vaI3IxngmuiZifuD5fsBIE32QW9hRtKiMqBht
         xTC+c4yqtBqN0NL0ZeoZLvO15PGejwMYd3Y5f5rRbTSrr4z1HQRv4ShL58NGXz0eBBm4
         DcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026690; x=1715631490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwFOhdOI6jYmDLMArB0z5zEnwyrO6RqamuYEZi4wtk=;
        b=X9gpO7ijepWZto19eZoVt6WLW0J0JQ/xcIjD5OSt6ZWw3K2f+9GQW/Kh8Gf/5nZw4C
         X5J1M2meV1kjjYBBwUH/p8EkwFHb4JKn5vmgNOpwpwdqpuPFc9BNhBnSeQoIdlB7L1/s
         N7JeSX1+f0gOK9LeBDRJLUTO4QUijmvZ4jyK6mdlI/PnnSHa4o/rB/FQF4uYOL61s8Ec
         Zg3qKojlbb5HxZPuX630w36KAbIsZYjb076nBGbdCUfVh+cQOnnapWVuXsdg7mexpnD3
         i97M2No1SbAI2CKcTdy/9SuTiuGK1p16BN5q2x1wfIQtb0KMl7udTlGJ90mAFlNbyQ4E
         szlw==
X-Forwarded-Encrypted: i=1; AJvYcCW2AyLkFqzWfOZHk48+piQ86so29vj65rkKK+Uabt06dBJtW5DQpU9DaSn76+DIHfUoG1M+eDk3p5WxoRZCU7IEPiyjIZkB3pLWJVMm
X-Gm-Message-State: AOJu0Yz3PeTxfpM16MUi0b8fz4w+m28wFb0EKzDdnNq8sZs+lyvArfwL
	GXjNuDounAhLE69Q+vw4+X5r3eB2S5B5h9IWE2grsnhuvXVdyRIMzQ+feY1glbSvOG/n2jt7YjL
	x4F9npz4SOoIyxLbcCQ==
X-Google-Smtp-Source: AGHT+IEvo342+Ng4YHDFjSk7GY34DyRjOBC+Ie5rEhFeaPOsQIdlHqK+1ZKnNgaFopd7uYTbNveJFBD4HB2z1C9/
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4f05:0:b0:61b:e75b:4806 with SMTP
 id d5-20020a814f05000000b0061be75b4806mr3029323ywb.1.1715026690581; Mon, 06
 May 2024 13:18:10 -0700 (PDT)
Date: Mon, 6 May 2024 20:18:08 +0000
In-Reply-To: <d99b6375-cbae-41f1-9221-f1dd25aab150@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506192924.271999-1-yosryahmed@google.com> <d99b6375-cbae-41f1-9221-f1dd25aab150@redhat.com>
Message-ID: <Zjk7AJGUsjR7TOBr@google.com>
Subject: Re: [PATCH v2] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
From: Yosry Ahmed <yosryahmed@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 06, 2024 at 09:50:10PM +0200, David Hildenbrand wrote:
> On 06.05.24 21:29, Yosry Ahmed wrote:
> > Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
> > although some of those fields are not exposed anywhere. Commit
> > 14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
> > changed this such that we only maintain the stats we actually expose
> > per-memcg via a translation table.
> > 
> > Additionally, commit 514462bbe927b ("memcg: warn for unexpected events
> > and stats") added a warning if a per-memcg stat update is attempted for
> > a stat that is not in the translation table. The warning started firing
> > for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. These
> > stats are not maintained per-memcg, and hence are not in the translation
> > table.
> > 
> > Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> > NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which updates
> > the global per-node stats only.
> > 
> > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
> > Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >   mm/rmap.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 12be4241474ab..ed7f820369864 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
> >   		struct page *page, int nr_pages, struct vm_area_struct *vma,
> >   		enum rmap_level level)
> >   {
> > +	pg_data_t *pgdat = folio_pgdat(folio);
> >   	int nr, nr_pmdmapped = 0;
> >   	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> >   	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
> >   	if (nr_pmdmapped)
> > -		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
> > +		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
> >   			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
> >   	if (nr)
> >   		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> > @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
> >   		enum rmap_level level)
> >   {
> >   	atomic_t *mapped = &folio->_nr_pages_mapped;
> > +	pg_data_t *pgdat = folio_pgdat(folio);
> >   	int last, nr = 0, nr_pmdmapped = 0;
> >   	bool partially_mapped = false;
> >   	enum node_stat_item idx;
> > @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
> >   	}
> >   	if (nr_pmdmapped) {
> > +		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
> >   		if (folio_test_anon(folio))
> > -			idx = NR_ANON_THPS;
> > -		else if (folio_test_swapbacked(folio))
> > -			idx = NR_SHMEM_PMDMAPPED;
> > +			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
> >   		else
> > -			idx = NR_FILE_PMDMAPPED;
> > -		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
> > +			__mod_node_page_state(pgdat,
> 
> folio_pgdat(folio) should fit here easily. :)
> 
> But I would actually suggest something like the following in mm/rmap.c

I am not a big fan of this. Not because I don't like the abstraction,
but because I think it doesn't go all the way. It abstracts a very
certain case: updating nr_pmdmapped for file folios.

I think if we opt for abstracting the stats updates in mm/rmap.c, we
should go all the way with something like the following (probably split
as two patches: refactoring then bug fix). WDYT about the below?

diff --git a/mm/rmap.c b/mm/rmap.c
index 12be4241474ab..70d6f6309da01 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1269,6 +1269,28 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 		       page);
 }
 
+static void __foio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
+{
+	int idx;
+
+	if (nr) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, nr);
+	}
+	if (nr_pmdmapped) {
+		if (folio_test_anon(folio)) {
+			idx = NR_ANON_THPS;
+			__lruvec_stat_mod_folio(folio, idx, nr_pmdmapped);
+		} else {
+			/* NR_*_PMDMAPPED are not maintained per-memcg */
+			idx = folio_test_swapbacked(folio) ?
+				NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED;
+			__mod_node_page_state(folio_pgdat(folio), idx,
+					      nr_pmdmapped);
+		}
+	}
+}
+
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags, enum rmap_level level)
@@ -1276,10 +1298,6 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 	int i, nr, nr_pmdmapped = 0;
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
-	if (nr_pmdmapped)
-		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
-	if (nr)
-		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
 	if (unlikely(!folio_test_anon(folio))) {
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1297,6 +1315,8 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		__page_check_anon_rmap(folio, page, vma, address);
 	}
 
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
+
 	if (flags & RMAP_EXCLUSIVE) {
 		switch (level) {
 		case RMAP_LEVEL_PTE:
@@ -1393,6 +1413,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address)
 {
 	int nr = folio_nr_pages(folio);
+	int nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
@@ -1425,10 +1446,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		atomic_set(&folio->_large_mapcount, 0);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		SetPageAnonExclusive(&folio->page);
-		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
+		nr_pmdmapped = nr;
 	}
 
-	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,
@@ -1440,11 +1461,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
-	if (nr_pmdmapped)
-		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
-			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-	if (nr)
-		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
 	if (!folio_test_large(folio))
@@ -1539,19 +1556,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	}
 
-	if (nr_pmdmapped) {
-		if (folio_test_anon(folio))
-			idx = NR_ANON_THPS;
-		else if (folio_test_swapbacked(folio))
-			idx = NR_SHMEM_PMDMAPPED;
-		else
-			idx = NR_FILE_PMDMAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
-	}
 	if (nr) {
-		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr);
-
 		/*
 		 * Queue anon large folio for deferred split if at least one
 		 * page of the folio is unmapped and at least one page
@@ -1563,6 +1568,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		    list_empty(&folio->_deferred_list))
 			deferred_split_folio(folio);
 	}
+	__foio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully

> 
> static void __folio_mod_node_file_state(folio, int nr_pages)
> {
> 	enum node_stat_item idx = NR_FILE_PMDMAPPED;
> 
> 	if (folio_test_swapbacked(folio))
> 		idx = NR_SHMEM_PMDMAPPED;
> 
> 	__mod_node_page_state(folio_pgdat(folio), idx, nr_pages);
> }
> 
> And then simply calling here
> 
> __folio_mod_node_file_state(folio, -nr_pmdmapped);
> 
> And likewise in __folio_add_file_rmap()
> 
> 
> ... will be cleaner.
> 
> In any case
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

