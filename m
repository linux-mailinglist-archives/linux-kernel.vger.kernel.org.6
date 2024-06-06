Return-Path: <linux-kernel+bounces-205085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C28FF6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25E11F26204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246013DDC5;
	Thu,  6 Jun 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYMqDpkK"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725313D884
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709446; cv=none; b=kA5DkDzRyN/xySjWU85ajPTiLFI+3ZFtA10n5V3oTQELVbyWoFxk5UzXDJenfX2MuligNld6WZERiCgdQNqZHX9mZlvLmSRF//LiEQbjeOvKo/9YkDBcg5t5c2JnAA1fsb7prWQ8OD3hh3XVj6mKKuHVM4/oB9mm5pqU6HPRiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709446; c=relaxed/simple;
	bh=6OX5jbLn5eWzJyYfgZq3Z11UzdVZrtsm1qMNkRxFuGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvAVesyRZ2Cye9CB7cn0dV0jxaGzyNpZ412iqQzriHlhZQcZVhW5srDw/YEklLxgdji1XOgZbNXyrNmupA6M/SvE+afbCIWathJRZzU1u9YDJrxWUOk5uq4iQRcN0CL1F5IcoD/pEOiZ9PKwrYMqkVHBFUOwrn91C24ritE72BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYMqDpkK; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80ad842d3a7so438966241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709443; x=1718314243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dcy8tpFWcvRLoLZii3SRyMdBoRRi8/R0gDiOrgpUeI=;
        b=kYMqDpkKM9KLRgAp9XNDMjvFV2H6DGW4CaAjl5IJ6kZyvBFMb7kol1+fuRyDK7lC10
         BIU/HbxRJUMUGMk6qq1qFSZl7JUOh8Mj5u5l6Fqwce/MHzGmrVDgK2ExIfkVfJO7WftQ
         f1kTsdFmGeMARI+Mmnm8MuksJJdEFvx1gJ8nAaQ7jvhUF1K9hPcw5t5iS3btrbO30rAi
         GRheshR0uCLEA7u10uVOI9uV0cfH6F5v5Y13781XmCbqSXcXi7DC7bCxXUXaBsBZF/Ka
         pk9mneS/NgYgx6W/ww7FbwXwyhY2pcW3RURc5gsg4inBp+yBJY9un8UCS6UxL3OFXTvE
         B0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709443; x=1718314243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dcy8tpFWcvRLoLZii3SRyMdBoRRi8/R0gDiOrgpUeI=;
        b=ow3v1Ah9colG70Xu7XWvEWPNlU6/zEnsTu1n0g36l3ky1O1j2sBPLjrHZa76eNk5UR
         OD0p71PAvdZzYlKszYJ1vOGU4ZSw2bVI2+B9GTbtWr2h9KOXFohFTWc2nCO95KmXEQPK
         3jEOyBdBOFe6u79gYBnAiBXYqGliE0r1cE2WlhvrJkTBMsYhxwp5I3wKK1/gkaDALA/N
         SJpsIB/dWn6EOkKe5ssSc2ilSi900k6PISi8UJRCUi0CSzFhuu4x8t4jHRK3qnALcPeI
         RVuviB2qeJeRX36JticnJ6q7oI8ovYfe08kVAK8JySj2/P31c6LJue18CpLU6mgW4nEv
         6IQw==
X-Forwarded-Encrypted: i=1; AJvYcCWr4AVsuWtD2qOLc0/siovVAuNVhX52eB537S2D9TJfFvPj4arViNRNJJxxuwT+vQrHVTJAggiK2MXGA0gvCY38Q5FaDHwzvgSF9qNh
X-Gm-Message-State: AOJu0Yz+OU8kPFYVRO6UaeMClxNQjugh4Rdk/K/+aq/X6y7mfYOUHppl
	CjcJgujusBmlcg3T90pe5wQZ1AVDy+bpAJF1kSD086c1HPW+uPSa8LBWxpiPPjRCgchQqc8P/V1
	9tfNiPwdF25Jta1BrbacR5iFHVCo=
X-Google-Smtp-Source: AGHT+IG4PaBA65BT5QX3MFC0AYUK0+sOcbkTAIJSiPdPkj1KsbpbjbQrUFT6MGHg0PeF1/oTxw3FXsmSKQPOisZpvyQ=
X-Received: by 2002:a67:f744:0:b0:47b:cd96:6d3d with SMTP id
 ada2fe7eead31-48c27568ae3mr589121137.3.1717709443083; Thu, 06 Jun 2024
 14:30:43 -0700 (PDT)
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
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 09:30:31 +1200
Message-ID: <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: David Hildenbrand <david@redhat.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:17=E2=80=AFAM David Hildenbrand <david@redhat.com>=
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
>

I'd rather fallback to small folios swapin instead crashing apps till we fi=
x
the large folio swapin in zswap :-)

+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+      ...
+
+      if (is_zswap_enabled())
+           goto fallback;

> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

