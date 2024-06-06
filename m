Return-Path: <linux-kernel+bounces-205019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88D8FF63A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63312286B69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F4E7345B;
	Thu,  6 Jun 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN9IPpMN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432851BDEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707686; cv=none; b=OTeHZWZd1CC9KZLG//AFOKXPrP25EP53ZA41ciVg6OYqBBlj4gmq0I/PQt819zf4Pn6OORw/31Yyw/8muX+rZEKxymo9YZbKsvEYEtEN2N+Ww6XLhqO+613fe/EVYctnHGxdWeKw51oDY9RscCZu4Ffbhd3aGnnzYrSMoMlU9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707686; c=relaxed/simple;
	bh=8Vji1lCbzspm42giSEF1L0HSvZw0yQLLo97LrQOoxAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzUt941bCunTz6+NoU8I8LN22U0QzTPo24t1CiuPMA++s3jGGwarkOmDnzr+QNge2HA5Ye2SpwAYtecYoKl1BD+YGHo6y9vE2aMEb8h6W8k45PJMISIjCGVOQenlYu8sSByt9Ok6I2s06dP2qqi33uVEZuKJqlEeqizv8sg3TX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vN9IPpMN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso4200788a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717707684; x=1718312484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MCVKBr1jnnAYBk5fqftqx4NlGxQg/1shx+hU00krnQ=;
        b=vN9IPpMNzJzXiDhRlydNDXt6ZBgu1PDbMPXuyyHbXqRPEs4SB0MfMfSK1ChruCZh7J
         FWxLhHZ+uGwzTBZ0gCFMUaZzY3WzPZ4R4f2Hn/R0cTChJOUyaIOqTJiADldCjzj52SXt
         8z6w93KyDmMBJQT9pLAn/qNpXncfUYu4aUJhKO4PN3z1pqtO4TwIepRdiR0z7BxX8RkF
         PwAIE+dJWh7CY0zSoilTGF4hf4ajGrEnjZ4r0NhFrtdTWXMzd+Wke1ACCWdvD2MeD37a
         oCZcoEvb5+m/0aFhUiB7CPy9sv7K6pjD2ciRx893wv52gTQVPQ/9I0cUSPZJjI4OJcLO
         4Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707684; x=1718312484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MCVKBr1jnnAYBk5fqftqx4NlGxQg/1shx+hU00krnQ=;
        b=rzbFz8oGGDvSa65bIDyJYfzTbc/Pe0fJ+Xm31UjFlJ6XBptbL/9Wc6tJs/fabZgAMA
         omBofwmjk8+z4XQ0AAtXQbIS1e3uY/JC0gY7Ncx/nYNR2kjycULXA6qZFzb6HtcIVrRe
         2m5bLL+UwrSaTGYlEk8bFr2TWxgRurjecsC5nq2jRZyVd9eSZIz3gteigipV8ujynnW4
         b+tZHZg4Jt0f5iT7F+zrxg/xu/OXHA69tMk5bM4f437kqBHkkxtIA1gJO3186VUWKq81
         EyVIoXrNqVc/dZlsUohOqek15J20Um35IM1yvXI3Gj2OIUDxlutecPcMKLfKXfP51niP
         i83A==
X-Forwarded-Encrypted: i=1; AJvYcCUXT76eJ2CMUM1oXez5jqxOgENxiiTIr3Q6sEkVCp5K5jQmkQYDnrJBie0h5zHgDHhcsboUg4EHjlj6sezvrHl5jyhhewak6axEiuxZ
X-Gm-Message-State: AOJu0Yzd2AwTSmkJBNujqA3DfvMnbc0Vs19uN/j/2/dcqdY+Sh5fU/9E
	vS/r+xS0uzKMEalg8ZMt+wu1pGmv4updu6UcmIpuGqBXtT/4SyljmWD6XoOUQRuwRvcrm9go98r
	rc5YiVtUUe3IQVU8qwRRvtyxzE2tBwdGXcJQz
X-Google-Smtp-Source: AGHT+IEcMkK6qWB80Jcu7kkIF7UKhpOkQSMkPqnzpZA2KliAZwI4wS4nyFrPjsvdSqEqs3aWy90YHQtEaQgZprni41o=
X-Received: by 2002:a17:906:48d0:b0:a6c:7337:b19a with SMTP id
 a640c23a62f3a-a6cbc6ca00cmr67012166b.29.1717707683316; Thu, 06 Jun 2024
 14:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <CAGsJ_4zTJgOgkXE=4a=w=ZsuC4WuwoBNHf0v0BwP7tatkkJZqA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zTJgOgkXE=4a=w=ZsuC4WuwoBNHf0v0BwP7tatkkJZqA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 14:00:47 -0700
Message-ID: <CAJD7tkZru-hD4300-KHPrBFM3km3osXtaQf6AauUKhwALzXn3g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 1:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Fri, Jun 7, 2024 at 8:32=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> > >
> > > On 06.06.24 20:48, Yosry Ahmed wrote:
> > > > With ongoing work to support large folio swapin, it is important to=
 make
> > > > sure we do not pass large folios to zswap_load() without implementi=
ng
> > > > proper support.
> > > >
> > > > For example, if a swapin fault observes that contiguous PTEs are
> > > > pointing to contiguous swap entries and tries to swap them in as a =
large
> > > > folio, swap_read_folio() will pass in a large folio to zswap_load()=
, but
> > > > zswap_load() will only effectively load the first page in the folio=
. If
> > > > the first page is not in zswap, the folio will be read from disk, e=
ven
> > > > though other pages may be in zswap.
> > > >
> > > > In both cases, this will lead to silent data corruption.
> > > >
> > > > Proper large folio swapin support needs to go into zswap before zsw=
ap
> > > > can be enabled in a system that supports large folio swapin.
> > > >
> > > > Looking at callers of swap_read_folio(), it seems like they are eit=
her
> > > > allocated from __read_swap_cache_async() or do_swap_page() in the
> > > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so =
we
> > > > are fine for now.
> > > >
> > > > Add a VM_BUG_ON() in zswap_load() to make sure that we detect chang=
es in
> > > > the order of those allocations without proper handling of zswap.
> > > >
> > > > Alternatively, swap_read_folio() (or its callers) can be updated to=
 have
> > > > a fallback mechanism that splits large folios or reads subpages
> > > > separately. Similar logic may be needed anyway in case part of a la=
rge
> > > > folio is already in the swapcache and the rest of it is swapped out=
.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Barry Song <baohua@kernel.org>

Thanks!

>
> this has been observed by me[1], that's why you can find the below
> code in my swapin patch

Thanks for the pointer. I suppose if we add more generic swapin
support we'll have to add a similar check in
__read_swap_cache_async(), unless we are planning to reuse
alloc_swap_folio() there.

It would be nice if we can have a global check for this rather than
add it to all different swapin paths (although I suspect there are
only two allocations paths right now). We can always disable zswap if
mTHP swapin is enabled, or always disable mTHP swapin if zswap is
enabled. At least until proper support is added.

>
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +      ...
> +      /*
> +      * a large folio being swapped-in could be partially in
> +      * zswap and partially in swap devices, zswap doesn't
> +      * support large folios yet, we might get corrupted
> +      * zero-filled data by reading all subpages from swap
> +      * devices while some of them are actually in zswap
> +      */
> +      if (is_zswap_enabled())
> +           goto fallback;
>
> [1] https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmai=
l.com/

