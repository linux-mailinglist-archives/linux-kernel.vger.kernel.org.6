Return-Path: <linux-kernel+bounces-244570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426892A627
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C4D1F224BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE54143C74;
	Mon,  8 Jul 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1+VH4OM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F938143C4D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453973; cv=none; b=quCm2SOPqrwPUl2mhcD0xHFIfcDZeBw+B38X1u5aCpDUm+lHykAh5CAM9R/cLL8nT/H5B2BZxxzG7kHCTrzuC7wEkVcY9sCZ33EMAXldlOero9Mq5PcVYhSlUqV53es8zQEp4EHoMbUO4Htdw5mhtNw0Xp9P2KBK0z38F8MGFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453973; c=relaxed/simple;
	bh=NMh3AswnynqysGRdS7KUcNIvzNl/UUdriDXWj4foioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPCXysMm2F8oPgYPXYcodEiKwaB60kH239WjlG+3oX+JhXLRmOaXTcjTxSzutR6dCD25nGOpr9nbQJVuvUekicbB4pyFtYwWm48iheMSyHU2aM79LBoKIBpkbGZKRVapkmk2G0FOp0rynwz1bzC3uJlchHDJl9oQYROWCwZT2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1+VH4OM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720453970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2Sg9CEez3gjaYBTMUNi2YCXwhQIdNlwaBOWlbCwoa8=;
	b=e1+VH4OMVO6nFwQT7S9KUWQMCeiO2Iso6PAIi2lsIv9lhvXV9/9cfZw9qDA73Jd+Ldv86c
	gTNiiqSJv38gmumDF0c99pmQesZ3TleQANifufHaKzuS3QzANZo8V4GaQ3atSzf7QImh+s
	yXyAuQvoJ7N/BbZ5bqFpHhTtXsSIvdE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-lmypUTy0MJ24umpqrIFY3g-1; Mon, 08 Jul 2024 11:52:48 -0400
X-MC-Unique: lmypUTy0MJ24umpqrIFY3g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-447dfad3387so7321451cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453967; x=1721058767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2Sg9CEez3gjaYBTMUNi2YCXwhQIdNlwaBOWlbCwoa8=;
        b=Q9FcfHr+EB4BhwO3vy7VxsgOuTqIDFi75pyuw0MVyvF8S6XaZDojSkOS+5lsPbmy7o
         Lg+szWZOEKjULnq/DuCNjbMmETAzQP50UTJVtgbvPXxwtlClLoBGviplFak+Lp2RKx2l
         jRRu6m4FCFmr6H1StQejIyM24x7YWl5IiQA3KK5/C9X4P2Ykk6jHauu53a1RpQzyFaVJ
         dTWEKuXZAfgK/283mY0wMcqq9Xa+5F1dp5QBxefvXsqfQBM+lbHC+XKNIM1l12wyDqWp
         apa2aYeg6pAQJmkFUMMNRtsOuJYwHA3mehCUDsKPWwlYOxn1Q+gv+q/VM1B9UNER34KM
         qWqg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbY+7oWInyC2HLZqAnp08a2xGmEOsEAgpM5DX3YmnoL97iBwqm36QaVKEgYXeZ/rJQTXQOAtJ0RWL7Jyn4R5BmdeJQUXcHqh2jI7n
X-Gm-Message-State: AOJu0Yw9k13UTCHuvZhdoLZzr+idrMlDy5Oql4MZ6FXBgPATl0sUuUPg
	iDEKThYiV5twyTdPVlI7PCU9y+xDiQYu6xdQ4WwW+l4qZxGAytstGzB1CCWT3lYZGcW5fiRcy7p
	Da3j9w1YLBZvpb/lhsIYBEDYcfUQGidOmIRbLgF82ZnwvUrF6FimU4JXggfy7+w==
X-Received: by 2002:a05:620a:1672:b0:79f:b3c:8fc3 with SMTP id af79cd13be357-79f18e74aa6mr22270185a.6.1720453967581;
        Mon, 08 Jul 2024 08:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyZ9rFiyVy3FxagC7QeMggWqoGK9K/UirLGruKJgLNuoV6vF78PyN78d3WeFBTK0cnPnn78g==
X-Received: by 2002:a05:620a:1672:b0:79f:b3c:8fc3 with SMTP id af79cd13be357-79f18e74aa6mr22267885a.6.1720453967244;
        Mon, 08 Jul 2024 08:52:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac12sm3761085a.61.2024.07.08.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:52:46 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:52:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Huang Ying <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at
 mm/compaction.c:2761!
Message-ID: <ZowLTDJG_i2ILmx7@x1n>
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>

On Tue, Jun 11, 2024 at 10:06:20PM -0700, Hugh Dickins wrote:
> I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();
> and if DEBUG_VM were off, then pages would be lost on a local list.
> 
> Our convention is that if migrate_pages() reports complete success (0),
> then the migratepages list will be empty; but if it reports an error or
> some pages remaining, then its caller must putback_movable_pages().
> 
> There's a new case in which migrate_pages() has been reporting complete
> success, but returning with pages left on the migratepages list: when
> migrate_pages_batch() successfully split a folio on the deferred list,
> but then the "Failure isn't counted" call does not dispose of them all.
> 
> Since that block is expecting the large folio to have been counted as 1
> failure already, and since the return code is later adjusted to success
> whenever the returned list is found empty, the simple way to fix this
> safely is to count splitting the deferred folio as "a failure".
> 
> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> A hotfix to 6.10-rc, not needed for stable.
> 
>  mm/migrate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head *from,
>  
>  			/*
>  			 * The rare folio on the deferred split list should
> -			 * be split now. It should not count as a failure.
> +			 * be split now. It should not count as a failure:
> +			 * but increment nr_failed because, without doing so,
> +			 * migrate_pages() may report success with (split but
> +			 * unmigrated) pages still on its fromlist; whereas it
> +			 * always reports success when its fromlist is empty.
> +			 *
>  			 * Only check it without removing it from the list.
>  			 * Since the folio can be on deferred_split_scan()
>  			 * local list and removing it can cause the local list
> @@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head *from,
>  			if (nr_pages > 2 &&
>  			   !list_empty(&folio->_deferred_list)) {
>  				if (try_split_folio(folio, split_folios) == 0) {
> +					nr_failed++;
>  					stats->nr_thp_split += is_thp;
>  					stats->nr_split++;
>  					continue;
> -- 
> 2.35.3
> 
> 

We probably hit the same issue in our testbeds, but in the other
migrate_misplaced_folio() path, which contains the BUG_ON() rather than
VM_BUG_ON().  Looks like this patch can also fix that.

When looking at that, I wonder whether we overlooked one more spot where we
mostly always use putback_movable_pages() for migrate failures, but didn't
in migrate_misplaced_folio().  I feel like it was overlooked but want to
check with all of you here, as I do think the folio can already be split
when reaching here too. So I wonder whether below would make sense as a fix
from that POV.

===8<===
diff --git a/mm/migrate.c b/mm/migrate.c
index e10d2445fbd8..20da2595527a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
        nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
                                     NULL, node, MIGRATE_ASYNC,
                                     MR_NUMA_MISPLACED, &nr_succeeded);
-       if (nr_remaining) {
-               if (!list_empty(&migratepages)) {
-                       list_del(&folio->lru);
-                       node_stat_mod_folio(folio, NR_ISOLATED_ANON +
-                                       folio_is_file_lru(folio), -nr_pages);
-                       folio_putback_lru(folio);
-               }
-       }
+       if (nr_remaining && !list_empty(&migratepages))
+               putback_movable_pages(&migratepages);
        if (nr_succeeded) {
                count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
                if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
===8<===

Thanks,

-- 
Peter Xu


