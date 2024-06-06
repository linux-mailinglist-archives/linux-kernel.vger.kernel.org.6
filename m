Return-Path: <linux-kernel+bounces-205091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900838FF6F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2660C287AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568073459;
	Thu,  6 Jun 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPnfxV3F"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87754C622
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709813; cv=none; b=bzroq6D/tXUOAyMc/AKNa2PjNLipaNZSDkOXJAhQxeBRFnZkujDCPxWiJEAl1D0630JlIWZ2Iu0hmFXtxbpj04q/FCxPa73HDLgLbGuH09L7muGe7Deym7powup6iynkZ1fN3XRJ3Gb62BV2yqs2C6ZkJ8twj7JrpyQKBhC+oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709813; c=relaxed/simple;
	bh=aelL7xI6/IzEA66yF0Joah/XxduN3Naqi1e1omjigpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8nKGTR0p5ZTwu8/dQarPD2QtzJhLvBhyPHe8Wucg9/UybxqK4G1hTEOhC+zUjAh1jJxLiYNoaE+8lfcswalmzjGP1QmRepI9Ld9OAFSCDCMsgjXZ4jBU2+e0+jBFmhDj3P5They0hHEIECR1gBAcRJpZY60Y91DLIg/UJ+yUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPnfxV3F; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so1833843a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717709810; x=1718314610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7okuVesSYZb7WHBSF+efeY8peMB/zeL/21SpdnOh+c=;
        b=IPnfxV3FzvLeFAax+WIyDqR4Xx+PczWNQheaOWgSEkmFutvugfMAKuokYMpzgURs6L
         oESXgv662iam787873kjaWVKdmQiqlRe+iSQCFSMANeJx6io+5Iehm6QsM5QHgJAGY/D
         O4tiLbYU8jluUPBZe4cQJgQDOYchP4Dep+qpcsafCt29xit7+U4llk7A0NKfwy/Ga13D
         aHV+8SUtsLqjyWFzTFoga7YUzmsSomgLPBdB/0OwgGZhRxMEz3G5RtNo7mTUTJGdcYuK
         eb1b4CreHl1TCBIvvy6CSWJf+urfI6etcdgQRHweqYYv8ljdbvFJzzN0tm3EDQOujI4o
         0hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709810; x=1718314610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7okuVesSYZb7WHBSF+efeY8peMB/zeL/21SpdnOh+c=;
        b=Ugbxp4qQM3TnQYVqEgTeD2XoZDzdDp3tS7l02z32GSw3qXYN4HBoD6c03yB1YucVe2
         c/aoDwSiiH5uO+uZV3/ABwz8wmJhofXTCOsb4VWzPm2Tgomr81qaPYo1G/1foaMPo0av
         oxELuM0umTkPlQ61DbyjU6lZ5aGBFosqnbD0gsRRXv/4R4njmcmijwYOIGokH6eB7gwo
         lBkRR0q8aTbVp7MV1QbRG81cMRUyD4Na0kgi5Ybi8EI8CDLoTIbEZq8Ndx/JfZMEGl1A
         HqElv4gpPdlEP8uPOUhwgZ4et3FyNAXqopAgWEwfQGc8wZYgKS2usQra863Y9oWGbcrV
         9Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCV+fvoduJkyVgoZJLq2v1qKnE5ryWRlermi+6Log0qEtZQPol8XjSpoqtxLyKDvE6fZYKSqb6PM+RhoMiFg3jf7VcpNPijJ0rq1NyJI
X-Gm-Message-State: AOJu0YxhOhtp5OdIV1NGJwfDHx8/J4Yc9MYnHLXuunD/6x8kchz3Rw4D
	0i0OABbgg9oSAKos6aHb+PwqgdQ+oCo0ZhdpTFuv0TeywaNYf9qeBIpoNtr7ThmtrnBMGdCl0VV
	CMnoUwCX+L166u/Ii+lL8Efl2teFfrf31G/Tc
X-Google-Smtp-Source: AGHT+IGZj/4GXD7GiIJana92FHJ0J/tDsdOuEKhEec46bZrlEctZgIPf7ftpUYb9TGioUvxkmYESJvqCoHpFT2mhiy8=
X-Received: by 2002:a17:906:56ca:b0:a59:9b75:b90 with SMTP id
 a640c23a62f3a-a6cd561214emr59619266b.2.1717709809697; Thu, 06 Jun 2024
 14:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com>
In-Reply-To: <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 14:36:13 -0700
Message-ID: <CAJD7tkbBRchzHmyVTHVrXb15gmHvi-sjNViSNNhEKvkeG9JiZw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:17=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.06.24 22:31, Yosry Ahmed wrote:
> > On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 06.06.24 20:48, Yosry Ahmed wrote:
> >>> With ongoing work to support large folio swapin, it is important to m=
ake
> >>> sure we do not pass large folios to zswap_load() without implementing
> >>> proper support.
> >>>
> >>> For example, if a swapin fault observes that contiguous PTEs are
> >>> pointing to contiguous swap entries and tries to swap them in as a la=
rge
> >>> folio, swap_read_folio() will pass in a large folio to zswap_load(), =
but
> >>> zswap_load() will only effectively load the first page in the folio. =
If
> >>> the first page is not in zswap, the folio will be read from disk, eve=
n
> >>> though other pages may be in zswap.
> >>>
> >>> In both cases, this will lead to silent data corruption.
> >>>
> >>> Proper large folio swapin support needs to go into zswap before zswap
> >>> can be enabled in a system that supports large folio swapin.
> >>>
> >>> Looking at callers of swap_read_folio(), it seems like they are eithe=
r
> >>> allocated from __read_swap_cache_async() or do_swap_page() in the
> >>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
> >>> are fine for now.
> >>>
> >>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes=
 in
> >>> the order of those allocations without proper handling of zswap.
> >>>
> >>> Alternatively, swap_read_folio() (or its callers) can be updated to h=
ave
> >>> a fallback mechanism that splits large folios or reads subpages
> >>> separately. Similar logic may be needed anyway in case part of a larg=
e
> >>> folio is already in the swapcache and the rest of it is swapped out.
> >>>
> >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>> ---
> >>>
> >>> Sorry for the long CC list, I just found myself repeatedly looking at
> >>> new series that add swap support for mTHPs / large folios, making sur=
e
> >>> they do not break with zswap or make incorrect assumptions. This debu=
g
> >>> check should give us some peace of mind. Hopefully this patch will al=
so
> >>> raise awareness among people who are working on this.
> >>>
> >>> ---
> >>>    mm/zswap.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/mm/zswap.c b/mm/zswap.c
> >>> index b9b35ef86d9be..6007252429bb2 100644
> >>> --- a/mm/zswap.c
> >>> +++ b/mm/zswap.c
> >>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> >>>        if (!entry)
> >>>                return false;
> >>>
> >>> +     /* Zswap loads do not handle large folio swapins correctly yet =
*/
> >>> +     VM_BUG_ON(folio_test_large(folio));
> >>> +
> >>
> >> There is no way we could have a WARN_ON_ONCE() and recover, right?
> >
> > Not without making more fundamental changes to the surrounding swap
> > code. Currently zswap_load() returns either true (folio was loaded
> > from zswap) or false (folio is not in zswap).
> >
> > To handle this correctly zswap_load() would need to tell
> > swap_read_folio() which subpages are in zswap and have been loaded,
> > and then swap_read_folio() would need to read the remaining subpages
> > from disk. This of course assumes that the caller of swap_read_folio()
> > made sure that the entire folio is swapped out and protected against
> > races with other swapins.
> >
> > Also, because swap_read_folio() cannot split the folio itself, other
> > swap_read_folio_*() functions that are called from it should be
> > updated to handle swapping in tail subpages, which may be questionable
> > in its own right.
> >
> > An alternative would be that zswap_load() (or a separate interface)
> > could tell swap_read_folio() that the folio is partially in zswap,
> > then we can just bail and tell the caller that it cannot read the
> > large folio and that it should be split.
> >
> > There may be other options as well, but the bottom line is that it is
> > possible, but probably not something that we want to do right now.
> >
> > A stronger protection method would be to introduce a config option or
> > boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> > depend on it being disabled, or have zswap check it at boot and refuse
> > to be enabled if it is on.
>
> Right, sounds like the VM_BUG_ON() really is not that easily avoidable.
>
> I was wondering, if we could WARN_ON_ONCE and make the swap code detect
> this like a read-error from disk.
>
> I think do_swap_page() detects that by checking if the folio is not
> uptodate:
>
> if (unlikely(!folio_test_uptodate(folio))) {
>         ret =3D VM_FAULT_SIGBUS;
>         goto out_nomap;
> }
>
> So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to the
> system (but the app would crash either way, there is no way around it).

It seems like most paths will handle this correctly just if the folio
is not uptodate. do_swap_page() seems like it will work correctly
whether

swapin_readahead() and the direct call to swap_read_folio() in
do_swap_page() should work correctly in this case. The shmem swapin
path seems like it will return -EIO, which in the fault path will also
sigbus, and in the file read/write path I assume will be handled
correctly.

However, looking at the swapoff paths, it seems like we don't really
check uptodate. For example, shmem_unuse_swap_entries() will just
throw -EIO away. Maybe it is handled on a higher level by the fact
that the number of swap entries will not drop to zero so swapoff will
not complete? :)

Anyway, I believe it may be possible to just not set uptodate, but I
am not very sure how reliable it will be. It may be better than
nothing anyway, I guess?

