Return-Path: <linux-kernel+bounces-377162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE649ABAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72295285350
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F221C2BD;
	Wed, 23 Oct 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pm7fWzL6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6782C7E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644381; cv=none; b=Bs5NkyZ2lXslsiWNi9kBZbUoEvVUQoj+tMr0MHouKteXAOHZ+jEjQA3m1gYgzib03snpOWP6KaovF1Yz5ZIn7Ik8FWNvtkBrKU5LJN/fBIKzclJgJmbaVD6zlnvowrmQ0C+JC18K5cTlrgHf6K96AwsZB24gV3GQz4V0RAa07l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644381; c=relaxed/simple;
	bh=AwFPasjpqb3XFrQ+EU3pKzTQisB3kEoJsciOeoRSIrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9V8VsSXAdgWXqSATcJisxRK/DZO2YCpCW4aeeyQLnM0QWq78gg9EvtONRllBfj0JJ1TWa4ek6XqMwQ6J2wcei7ta/bolVniTxyOtgGNaA2qBytWPsGtOTdUZwx261D7eGSNgXmsLabPApcPRhhB8zL3HWWURDStgIfB4abz9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pm7fWzL6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so719696166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729644377; x=1730249177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DA7hqLuD0SjigMcr5CX7c/N2Gt0IuASV0oXAPrAxSYE=;
        b=pm7fWzL6vO1NI4DfvTYAjk8E3RrvEcP0fDskncZBHMod6T7IB8aeJlpWyOi/dfl9y+
         lPCwiiqPsH29vhQKZuxTlXHNNyihF93P+5BmefVqomypCa4Y+blUd0MGEKrvgThgyuWd
         00PmnuzDwsT8qYIzlcb0kP4Ox5TrZ0u9s4xGQbct5tz7UJADrEkW5H/OKFZGNcsx86R/
         vlsiiGSldZ1jCVRU71Yf5Qw5V8z+PvxELRmRNsFhzF6Fb6xPzC3AhQrPYKH0D0grgEi1
         vtA22XkQqFuEdPiZzMyyvaNpu6zeBfXF2VWbqsL2xemSgl5onrwunI1kGeAhn/bDT1T3
         KHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644377; x=1730249177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DA7hqLuD0SjigMcr5CX7c/N2Gt0IuASV0oXAPrAxSYE=;
        b=QI+xAhJb/Xp+oHTetu9M4yM6d7cNjIVgu5G7rDuTDwFLWrZU9+HnQyQoT+cjxpLFSV
         KiuDQHUW1TovBzSnL3SzI7X/nPPEvRDTAftXnKR9JnLedAmQkuU6Z7QuTc2kwfuiIVeD
         PCHQGBit/kA44MvUCBuckprTzt5LZr03sllQUPCPBgqjlJwWRbzEKyBZQK2/hmhK9794
         +ZJZ/l7C2yvpGUY0tPy3jsQZKIdD+x7UIvKVlUHrJ+iSD2v1toCe0IUvVEe58YN4e3ZB
         yWYWbLkYI0XNBoLaFMwKit5JRaLfIFfZlOo9/CrdJrfI8QRhJ3ZcHbhyQO9hzAH/avnR
         ukqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx7PYyLOzLWFIKRArUzaWXPq0Z425o11I5K4R+9XIYMrF05aWvzh43s/BoeOLLm1usrd6W3lCFXo/Ku+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6EDgP/QrFLmmrISBkRZkkz/xj6jCwYIl0qakJx6kso9TjJsR
	Y8tz8qcaRmc2RKRYQ1cAu30tjht0OElA9c79ZUTIIryUmFgkKhAbVlbZviVVEXtyOQvIehOphqz
	9X/rRIpDuvCnGtj0QzSkA7qEZj1szr2dMIvmr
X-Google-Smtp-Source: AGHT+IGoIXJSAkpe8fqP9IrcYJDa0aJQe1g/26o/fr+1FgSNM3uCwl32CQGzeahCvVbb7An+pP6mrWo8wwZaJmOUvUU=
X-Received: by 2002:a17:907:3fa6:b0:a99:c0be:a8ac with SMTP id
 a640c23a62f3a-a9abf8b233amr58602066b.37.1729644377238; Tue, 22 Oct 2024
 17:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-2-usamaarif642@gmail.com> <CAJD7tkYEe10Xw-8azM-80pHv6YjvosZDHTdZfYttAuD5u1+s8A@mail.gmail.com>
 <07e6018b-bc6f-4e1e-9bc3-07a4b5a384fc@gmail.com>
In-Reply-To: <07e6018b-bc6f-4e1e-9bc3-07a4b5a384fc@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:45:41 -0700
Message-ID: <CAJD7tkaD0m7ciiy6Nj7CZb2_26Dv4T=2cRW7h728vLxczOVkYg@mail.gmail.com>
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> >> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
> >>         return ret;
> >>  }
> >>
> >> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
> >> +{
> >> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[type];
> >
> > I am not sure I understand what we are looking for here. When does
> > this return false? Aren't the zswap trees always allocated during
> > swapon?
> >
>
> Hi Yosry,
>
> Thanks for the review!
>
> It becomes useful in patch 3 when trying to determine if a large folio can be allocated.
>
> For e.g. if the swap entry is the last entry of the last tree, and 1M folios are enabled
> (nr_pages = 256), then the while loop in zswap_present_test will try to access a tree
> that doesn't exist from the 2nd 4K page onwards if we dont have this check in
> zswap_present_test.

Doesn't swap_pte_batch() make sure that the range of swap entries
passed here all corresponds to existing swap entries, and those
entries should always have a corresponding zswap tree? How can the
passed in range contain an entry that is not in any zswap tree?

I feel like I am missing something.

>
> >> +}
> >> +
> >> +/* Returns true if the entire folio is in zswap */
> >
> > There isn't really a folio at this point, maybe "Returns true if the
> > entire range is in zswap"?
>
> Will change, Thanks!
>
> >
> > Also, this is racy because an exclusive load, invalidation, or
> > writeback can cause an entry to be removed from zswap. Under what
> > conditions is this safe? The caller can probably guarantee we don't
> > race against invalidation, but can we guarantee that concurrent
> > exclusive loads or writebacks don't happen?
> >
> > If the answer is yes, this needs to be properly documented.
>
> swapcache_prepare should stop things from becoming racy.
>
> lets say trying to swapin a mTHP of size 32 pages:
> - T1 is doing do_swap_page, T2 is doing zswap_writeback.
> - T1 - Check if the entire 32 pages is in zswap, swapcache_prepare(entry, nr_pages) in do_swap_page is not yet called.
> - T2 - zswap_writeback_entry starts and lets say writes page 2 to swap. it calls __read_swap_cache_async -> swapcache_prepare increments swap_map count, writes page to swap.

Can the folio be dropped from the swapcache at this point (e.g. by
reclaim)? If yes, it seems like swapcache_prepare() can succeed and
try to read it from zswap.

> - T1 - swapcache_prepare is then called and fails and then there will be a pagefault again for it.
>
> I will try and document this better.

We need to establish the rules for zswap_present_test() to not be
racy, document them at the definition, establish the safety of racy
callers (i.e. can_swapin_thp()), and document them at the call sites.

>
> >
> >> +bool zswap_present_test(swp_entry_t swp, int nr_pages)
> >> +{
> >> +       pgoff_t offset = swp_offset(swp), tree_max_idx;
> >> +       int max_idx = 0, i = 0, tree_offset = 0;
> >> +       unsigned int type = swp_type(swp);
> >> +       struct zswap_entry *entry = NULL;
> >> +       struct xarray *tree;
> >> +
> >> +       while (i < nr_pages) {
> >> +               tree_offset = offset + i;
> >> +               /* Check if the tree exists. */
> >> +               if (!swp_offset_in_zswap(type, tree_offset))
> >> +                       return false;
> >> +
> >> +               tree = swap_zswap_tree(swp_entry(type, tree_offset));
> >> +               XA_STATE(xas, tree, tree_offset);
> >
> > Please do not mix declarations with code.
> >
> >> +
> >> +               tree_max_idx = tree_offset % SWAP_ADDRESS_SPACE_PAGES ?
> >> +                       ALIGN(tree_offset, SWAP_ADDRESS_SPACE_PAGES) :
> >> +                       ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES);
> >
> > Does this work if we always use ALIGN(tree_offset + 1,
> > SWAP_ADDRESS_SPACE_PAGES)?
>
> Yes, I think max_idx = min(offset + nr_pages, ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES)) - 1;
> will work. I will test it out, Thanks!

Might need to split it over two lines.

