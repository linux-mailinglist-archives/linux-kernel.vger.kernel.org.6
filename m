Return-Path: <linux-kernel+bounces-205103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59D8FF716
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B432282B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897CE13C67B;
	Thu,  6 Jun 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWd5H9kV"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25557173C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710847; cv=none; b=hiNVZR3ivJRxsrHOlXL+g3kLFqXpwX/+42YAkM5aaVx36ZiLwMLsfqm6fZ6PdgRzcOUTwznIPq2yLsBgrJlYKDD6UVaqnnIeqmi/m+lPy61XP8Qo4k7ehrLzCGPa0eKflhbLusqBJNDtcwJOZqn9de/rJcZxOClzGS3qRZZIJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710847; c=relaxed/simple;
	bh=SDgLioTrPnTG+OoVEXK9jVzfyt2UTiZS8xeTVzOLNI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q69NcvvSNqgX+X+YHXFhKhZjDwFwBoMHVfm1IbqXeiZUuH1PFV1azig/Z2XtmIz43PPC12mgVGDIFgFhuf15GQNfUAyt1JpYhaOnk9rybkzIPMTd07gxmiEURcCF5A65KkyrpQFTDOaPIYJDjgyByTKQv1TlmqYHhY2ykTpYPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWd5H9kV; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4eb1a5c26a5so452464e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717710844; x=1718315644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II39ZY5jweWWSGgsfFhanVbwdOXHJBCd7qN4MOjB7/8=;
        b=DWd5H9kVZJ6qwNcTjY6L8ww20wsWht4bor4UoeJjlf249rGwyjQ7ttnxdyj9/lEBSL
         k3LAfPyyh9Q8XZmatdAJ9hY5pei+DFUbchFZcx1pmUaqnE/DjnXDjicvZi53WGetuMBe
         wKxG5dr5LXRtk67q4HPd1aN8NqbSR4aW2XsRCYoF8Ov28GEi0dA7CkFH90O2Qfj0bvQt
         Xk5dt2MPW0d0XnMMBD4/elLDnwP0I+wuxLL0ufh9FD0GNj9wLKxkuh3dEIDqRY55QDXR
         FNfkyBTFSD9Oh3HyAI5jBrDMPmoHcoIgtDjycOv7tPV+HkiMAL+4dN+19Iygu66IHzi2
         gwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710844; x=1718315644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II39ZY5jweWWSGgsfFhanVbwdOXHJBCd7qN4MOjB7/8=;
        b=kSoiRsMUaTDOrApwSJ13YxiSX/zt+Ohz3HEVME6lIt5NphhFokHf8gTGG4RVHLmm1r
         AsOUc9fxTt+ycVOSc7NOAmyPpRif0K/9+9zpPt6pJXP25E5Sicn9by38cBD19NEjUUGu
         3K61nwJJNgkELby4AN+CRAotMeGOHlA3maNaxLpkIgh3RQs35iXEecmwLENjHYN8kxdZ
         CRCek6svtOFxFOTCqpaByi/T2IdG15O8wwye64M2i36g8d3QuRdq/Tg7Yj3kUS7VAeqk
         BSW/oc7LjtE63OnCmJlk6LR0JzaY31le8RZspek/F9Y464SXhCpMKTc7jUO5iU6ZHk9b
         fi5A==
X-Forwarded-Encrypted: i=1; AJvYcCVooTo67z9nIut1y5ApwWM61eshk1c26BUFfNuSslDrhwIpHP2nLQti91KSoTH30l/D6SRpE5JDyqmKTaKyATyJU628HNU3PhwVVNhH
X-Gm-Message-State: AOJu0Yz6Y+gyjL2QsKyBkqm7W4ry5iuJQ2bC29JPHX9+Ez8zvPRN6r9C
	rPPKx5NqHzBabh21AeqF03vbmrpj/ruNxVHBInelknSc81RVmdRWtBlwJlWo9VjGK1Ytf/+1rYZ
	hv4FL4IoeScpEX4E0ngiAcHH9qIG83Zll
X-Google-Smtp-Source: AGHT+IGe+gE0qF0VtKx5PyAKfT45DB4DKutiKwM8AAstt5UAWcjYj08CKwbbaiDu9kSKQ6vp2N9e9d2gM3LVyfJgiHo=
X-Received: by 2002:ac5:cb05:0:b0:4d8:7a5e:392f with SMTP id
 71dfb90a1353d-4eb562b9f79mr914221e0c.12.1717710843623; Thu, 06 Jun 2024
 14:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
In-Reply-To: <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 09:53:52 +1200
Message-ID: <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Fri, Jun 7, 2024 at 9:17=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> > >
> > > On 06.06.24 22:31, Yosry Ahmed wrote:
> > > > On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > > >>
> > > >> On 06.06.24 20:48, Yosry Ahmed wrote:
> > > >>> With ongoing work to support large folio swapin, it is important =
to make
> > > >>> sure we do not pass large folios to zswap_load() without implemen=
ting
> > > >>> proper support.
> > > >>>
> > > >>> For example, if a swapin fault observes that contiguous PTEs are
> > > >>> pointing to contiguous swap entries and tries to swap them in as =
a large
> > > >>> folio, swap_read_folio() will pass in a large folio to zswap_load=
(), but
> > > >>> zswap_load() will only effectively load the first page in the fol=
io. If
> > > >>> the first page is not in zswap, the folio will be read from disk,=
 even
> > > >>> though other pages may be in zswap.
> > > >>>
> > > >>> In both cases, this will lead to silent data corruption.
> > > >>>
> > > >>> Proper large folio swapin support needs to go into zswap before z=
swap
> > > >>> can be enabled in a system that supports large folio swapin.
> > > >>>
> > > >>> Looking at callers of swap_read_folio(), it seems like they are e=
ither
> > > >>> allocated from __read_swap_cache_async() or do_swap_page() in the
> > > >>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, s=
o we
> > > >>> are fine for now.
> > > >>>
> > > >>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect cha=
nges in
> > > >>> the order of those allocations without proper handling of zswap.
> > > >>>
> > > >>> Alternatively, swap_read_folio() (or its callers) can be updated =
to have
> > > >>> a fallback mechanism that splits large folios or reads subpages
> > > >>> separately. Similar logic may be needed anyway in case part of a =
large
> > > >>> folio is already in the swapcache and the rest of it is swapped o=
ut.
> > > >>>
> > > >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > >>> ---
> > > >>>
> > > >>> Sorry for the long CC list, I just found myself repeatedly lookin=
g at
> > > >>> new series that add swap support for mTHPs / large folios, making=
 sure
> > > >>> they do not break with zswap or make incorrect assumptions. This =
debug
> > > >>> check should give us some peace of mind. Hopefully this patch wil=
l also
> > > >>> raise awareness among people who are working on this.
> > > >>>
> > > >>> ---
> > > >>>    mm/zswap.c | 3 +++
> > > >>>    1 file changed, 3 insertions(+)
> > > >>>
> > > >>> diff --git a/mm/zswap.c b/mm/zswap.c
> > > >>> index b9b35ef86d9be..6007252429bb2 100644
> > > >>> --- a/mm/zswap.c
> > > >>> +++ b/mm/zswap.c
> > > >>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> > > >>>        if (!entry)
> > > >>>                return false;
> > > >>>
> > > >>> +     /* Zswap loads do not handle large folio swapins correctly =
yet */
> > > >>> +     VM_BUG_ON(folio_test_large(folio));
> > > >>> +
> > > >>
> > > >> There is no way we could have a WARN_ON_ONCE() and recover, right?
> > > >
> > > > Not without making more fundamental changes to the surrounding swap
> > > > code. Currently zswap_load() returns either true (folio was loaded
> > > > from zswap) or false (folio is not in zswap).
> > > >
> > > > To handle this correctly zswap_load() would need to tell
> > > > swap_read_folio() which subpages are in zswap and have been loaded,
> > > > and then swap_read_folio() would need to read the remaining subpage=
s
> > > > from disk. This of course assumes that the caller of swap_read_foli=
o()
> > > > made sure that the entire folio is swapped out and protected agains=
t
> > > > races with other swapins.
> > > >
> > > > Also, because swap_read_folio() cannot split the folio itself, othe=
r
> > > > swap_read_folio_*() functions that are called from it should be
> > > > updated to handle swapping in tail subpages, which may be questiona=
ble
> > > > in its own right.
> > > >
> > > > An alternative would be that zswap_load() (or a separate interface)
> > > > could tell swap_read_folio() that the folio is partially in zswap,
> > > > then we can just bail and tell the caller that it cannot read the
> > > > large folio and that it should be split.
> > > >
> > > > There may be other options as well, but the bottom line is that it =
is
> > > > possible, but probably not something that we want to do right now.
> > > >
> > > > A stronger protection method would be to introduce a config option =
or
> > > > boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> > > > depend on it being disabled, or have zswap check it at boot and ref=
use
> > > > to be enabled if it is on.
> > >
> > > Right, sounds like the VM_BUG_ON() really is not that easily avoidabl=
e.
> > >
> > > I was wondering, if we could WARN_ON_ONCE and make the swap code dete=
ct
> > > this like a read-error from disk.
> > >
> > > I think do_swap_page() detects that by checking if the folio is not
> > > uptodate:
> > >
> > > if (unlikely(!folio_test_uptodate(folio))) {
> > >         ret =3D VM_FAULT_SIGBUS;
> > >         goto out_nomap;
> > > }
> > >
> > > So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to the
> > > system (but the app would crash either way, there is no way around it=
).
> > >
> >
> > I'd rather fallback to small folios swapin instead crashing apps till w=
e fix
> > the large folio swapin in zswap :-)
>
> I think David is referring to catching the buggy cases that do not
> properly fallback to small folios with zswap, not as an alternative to
> the fallback. This is at least what I had in mind with the patch.

Cool. Thanks for the clarification. I'm fine with keeping the fallback,
whether it's the current VM_BUG_ON or David's recommended
SIGBUS.

Currently, mainline doesn't support large folios swap-in, so I see
your patch as a helpful warning for those attempting large folio
swap-in to avoid making mistakes like loading large folios from
zswap.

In fact, I spent a week trying to figure out why my app was crashing
before I added 'if (zswap_is_enabled()) goto fallback'. If your patch
had come earlier, it would have saved me that week of work :-)

To me, a direct crash seems like a more straightforward way to
prompt people to fallback when attempting large folio swap-ins.
So, I am slightly in favor of your current patch.

Thanks
Barry

