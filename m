Return-Path: <linux-kernel+bounces-206767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D1900D74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FF4B23655
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE715532C;
	Fri,  7 Jun 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/sL6crf"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEC1552EB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795222; cv=none; b=Vzv3H/XHrbXJU9penaf+PlkV0fo+C2geGFY3GMhT2Vl/ypsMdvFcXxmpu00V6zvX+VvfS0DizDf0ApU+HLJIOgivvMJRsi3i21X2pbpguQYD38FKVl/hlgV43v+Ou4mRGQDciA1BDiKKlvvwbEgp9KaY0Cj2Ov+XKx6ohUnizzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795222; c=relaxed/simple;
	bh=OVouCRM6nB+n+IGS369sgrfCoLfxqz0onk80BI9oFUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdWN+2RKjmS38qwyUFvS2hLKj5Nz75/QgjFhyf+hTbQxn0cJbK91FPbgxYJisyo4Y/42LcbZUokTexINJfryyWvn0EpZD1/0G+aK4TlJ8N7ZZtOdWDxq4k08G/MHtNjMHGHg7iaiaBAW7PhwKyelcHKFgVPaAoOXMeFdJWK2W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/sL6crf; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4e7eadf3668so1018567e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717795219; x=1718400019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxAZp3z7L49A+lTnMeWo5nLFYKkCmQWqY4FG8Fg0hV8=;
        b=g/sL6crfA4SyV6gUUSvqAdNERd/YjpPT5mB1UA9CvBC+nqq/hkWi2jLAhr97ZWbfWi
         CPReJqHztjCYM8ZIKxn6QIdEBUUMaHr24qkeShiixFdzsFfrLOZjhHR0q7GNZmY06qwv
         BpW22etjuLDtxmwreBG38rtSkuk/m+6aTGuWgQtMSVfmXt52CSDonB1Ue1lKj1fhj6wS
         fj/GFNaRct+AOhf4Zk2LFeDam9pY668UgykWDr7qMEARYpyfjmWQZEim7MxBNZbj95nG
         B/Onbsc6wvqurg0pNzAzwJXdKLZOrNzz52rPxGdJItqxjgcKB2nt9kOVP4q+8cCMSbG1
         +Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717795219; x=1718400019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxAZp3z7L49A+lTnMeWo5nLFYKkCmQWqY4FG8Fg0hV8=;
        b=XYOD26U35VMSPfj64NkiASMBB2/4T5813+vm4Zyr3SXjQFqJSJT+m8FlZulmrZKUbj
         9DDLhF5VbKrXjNOBXPl1/FPbn9K2wNzt2uYBPpmEwcK9KMmHzYQc8T0dayUJUTJrK55t
         WkwRoQ0hNKgMgf+sGB1fK6xoP1SLJKEIJc/rczZuZSjWNQislARvUoSvzhmhC9gMjl1n
         sQiS81gm2a6j0syrmjm/1KcM6s5cWDaMpDOqVs2xDGZAbOe9EplaNfYXCQ9M6sm8gfPY
         rY/AnIXEHLwrYcSMGKi24Le41D7dagBmxIpxDNbKFUueRhqkR2DySk3QOjQZ8czcX171
         Rgaw==
X-Forwarded-Encrypted: i=1; AJvYcCVq0YAnn9tO91fnx7ps06y++MltiQ2BMbVcGVDF9AF+e3iQWsyL/UYv0vuvSIpW8QG6YR0N2jUAVUPLZd79hcv+tW3FtQ30X69UaJz9
X-Gm-Message-State: AOJu0YwDO263pEDbJb52wFs6w6GHqyuUxPFgoGCjwjnDOgu4plLZ0tmW
	EbPKwe+2mzXwigFQRneb6wAzqJsZuJoMwI3Rx/9jozzh1iPxSVIDHBhfC4l6KGK1mBrDrotsi6u
	1uIchIZd4P2zpw/fhtsiFyJnQ88k=
X-Google-Smtp-Source: AGHT+IHwApfbDXy/9uEmymJpWJutBc9OUMURYbKnanvYLEGkriqI0tU51VRp6KnRGmRS+myCt6MsDRH+vVcH5VYRYHk=
X-Received: by 2002:a05:6122:dd:b0:4ea:edac:3ae4 with SMTP id
 71dfb90a1353d-4eb56260c92mr4190990e0c.9.1717795219055; Fri, 07 Jun 2024
 14:20:19 -0700 (PDT)
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
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com>
 <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com> <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
In-Reply-To: <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Jun 2024 09:20:07 +1200
Message-ID: <CAGsJ_4ywmVbO+nrbcxz9YMdzi_y5qSUG3Cg=3oz3kNpQ6gg6iA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: Yosry Ahmed <yosryahmed@google.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 5:43=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Jun 7, 2024 at 12:11=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 06.06.24 23:53, Barry Song wrote:
> > > On Fri, Jun 7, 2024 at 9:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >>
> > >> On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > >>>
> > >>> On Fri, Jun 7, 2024 at 9:17=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> > >>>>
> > >>>> On 06.06.24 22:31, Yosry Ahmed wrote:
> > >>>>> On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@r=
edhat.com> wrote:
> > >>>>>>
> > >>>>>> On 06.06.24 20:48, Yosry Ahmed wrote:
> > >>>>>>> With ongoing work to support large folio swapin, it is importan=
t to make
> > >>>>>>> sure we do not pass large folios to zswap_load() without implem=
enting
> > >>>>>>> proper support.
> > >>>>>>>
> > >>>>>>> For example, if a swapin fault observes that contiguous PTEs ar=
e
> > >>>>>>> pointing to contiguous swap entries and tries to swap them in a=
s a large
> > >>>>>>> folio, swap_read_folio() will pass in a large folio to zswap_lo=
ad(), but
> > >>>>>>> zswap_load() will only effectively load the first page in the f=
olio. If
> > >>>>>>> the first page is not in zswap, the folio will be read from dis=
k, even
> > >>>>>>> though other pages may be in zswap.
> > >>>>>>>
> > >>>>>>> In both cases, this will lead to silent data corruption.
> > >>>>>>>
> > >>>>>>> Proper large folio swapin support needs to go into zswap before=
 zswap
> > >>>>>>> can be enabled in a system that supports large folio swapin.
> > >>>>>>>
> > >>>>>>> Looking at callers of swap_read_folio(), it seems like they are=
 either
> > >>>>>>> allocated from __read_swap_cache_async() or do_swap_page() in t=
he
> > >>>>>>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios,=
 so we
> > >>>>>>> are fine for now.
> > >>>>>>>
> > >>>>>>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect c=
hanges in
> > >>>>>>> the order of those allocations without proper handling of zswap=
.
> > >>>>>>>
> > >>>>>>> Alternatively, swap_read_folio() (or its callers) can be update=
d to have
> > >>>>>>> a fallback mechanism that splits large folios or reads subpages
> > >>>>>>> separately. Similar logic may be needed anyway in case part of =
a large
> > >>>>>>> folio is already in the swapcache and the rest of it is swapped=
 out.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >>>>>>> ---
> > >>>>>>>
> > >>>>>>> Sorry for the long CC list, I just found myself repeatedly look=
ing at
> > >>>>>>> new series that add swap support for mTHPs / large folios, maki=
ng sure
> > >>>>>>> they do not break with zswap or make incorrect assumptions. Thi=
s debug
> > >>>>>>> check should give us some peace of mind. Hopefully this patch w=
ill also
> > >>>>>>> raise awareness among people who are working on this.
> > >>>>>>>
> > >>>>>>> ---
> > >>>>>>>     mm/zswap.c | 3 +++
> > >>>>>>>     1 file changed, 3 insertions(+)
> > >>>>>>>
> > >>>>>>> diff --git a/mm/zswap.c b/mm/zswap.c
> > >>>>>>> index b9b35ef86d9be..6007252429bb2 100644
> > >>>>>>> --- a/mm/zswap.c
> > >>>>>>> +++ b/mm/zswap.c
> > >>>>>>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> > >>>>>>>         if (!entry)
> > >>>>>>>                 return false;
> > >>>>>>>
> > >>>>>>> +     /* Zswap loads do not handle large folio swapins correctl=
y yet */
> > >>>>>>> +     VM_BUG_ON(folio_test_large(folio));
> > >>>>>>> +
> > >>>>>>
> > >>>>>> There is no way we could have a WARN_ON_ONCE() and recover, righ=
t?
> > >>>>>
> > >>>>> Not without making more fundamental changes to the surrounding sw=
ap
> > >>>>> code. Currently zswap_load() returns either true (folio was loade=
d
> > >>>>> from zswap) or false (folio is not in zswap).
> > >>>>>
> > >>>>> To handle this correctly zswap_load() would need to tell
> > >>>>> swap_read_folio() which subpages are in zswap and have been loade=
d,
> > >>>>> and then swap_read_folio() would need to read the remaining subpa=
ges
> > >>>>> from disk. This of course assumes that the caller of swap_read_fo=
lio()
> > >>>>> made sure that the entire folio is swapped out and protected agai=
nst
> > >>>>> races with other swapins.
> > >>>>>
> > >>>>> Also, because swap_read_folio() cannot split the folio itself, ot=
her
> > >>>>> swap_read_folio_*() functions that are called from it should be
> > >>>>> updated to handle swapping in tail subpages, which may be questio=
nable
> > >>>>> in its own right.
> > >>>>>
> > >>>>> An alternative would be that zswap_load() (or a separate interfac=
e)
> > >>>>> could tell swap_read_folio() that the folio is partially in zswap=
,
> > >>>>> then we can just bail and tell the caller that it cannot read the
> > >>>>> large folio and that it should be split.
> > >>>>>
> > >>>>> There may be other options as well, but the bottom line is that i=
t is
> > >>>>> possible, but probably not something that we want to do right now=
.
> > >>>>>
> > >>>>> A stronger protection method would be to introduce a config optio=
n or
> > >>>>> boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> > >>>>> depend on it being disabled, or have zswap check it at boot and r=
efuse
> > >>>>> to be enabled if it is on.
> > >>>>
> > >>>> Right, sounds like the VM_BUG_ON() really is not that easily avoid=
able.
> > >>>>
> > >>>> I was wondering, if we could WARN_ON_ONCE and make the swap code d=
etect
> > >>>> this like a read-error from disk.
> > >>>>
> > >>>> I think do_swap_page() detects that by checking if the folio is no=
t
> > >>>> uptodate:
> > >>>>
> > >>>> if (unlikely(!folio_test_uptodate(folio))) {
> > >>>>          ret =3D VM_FAULT_SIGBUS;
> > >>>>          goto out_nomap;
> > >>>> }
> > >>>>
> > >>>> So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to =
the
> > >>>> system (but the app would crash either way, there is no way around=
 it).
> > >>>>
> > >>>
> > >>> I'd rather fallback to small folios swapin instead crashing apps ti=
ll we fix
> > >>> the large folio swapin in zswap :-)
> > >>
> > >> I think David is referring to catching the buggy cases that do not
> > >> properly fallback to small folios with zswap, not as an alternative =
to
> > >> the fallback. This is at least what I had in mind with the patch.
> > >
> > > Cool. Thanks for the clarification. I'm fine with keeping the fallbac=
k,
> > > whether it's the current VM_BUG_ON or David's recommended
> > > SIGBUS.
> > >
> > > Currently, mainline doesn't support large folios swap-in, so I see
> > > your patch as a helpful warning for those attempting large folio
> > > swap-in to avoid making mistakes like loading large folios from
> > > zswap.
> > >
> > > In fact, I spent a week trying to figure out why my app was crashing
> > > before I added 'if (zswap_is_enabled()) goto fallback'. If your patch
> > > had come earlier, it would have saved me that week of work :-)
> > >
> > > To me, a direct crash seems like a more straightforward way to
> > > prompt people to fallback when attempting large folio swap-ins.
> > > So, I am slightly in favor of your current patch.
> >
> > BUG_ON and friends are frowned-upon, in particular in scenarios where w=
e
> > can recover or that are so unexpected that they can be found during
> > early testing.
> >
> > I have no strong opinion on this one, but likely a VM_WARN_ON would als=
o
> > be sufficient to find such issues early during testing. No need to cras=
h
> > the machine.
>
> I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but after
> some digging I found your patches to checkpatch and Linus clearly
> stating that it isn't.
>
> How about something like the following (untested), it is the minimal
> recovery we can do but should work for a lot of cases, and does
> nothing beyond a warning if we can swapin the large folio from disk:
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index f1a9cfab6e748..8f441dd8e109f 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
> swap_iocb **plug)
>         delayacct_swapin_start();
>
>         if (zswap_load(folio)) {
> -               folio_mark_uptodate(folio);
>                 folio_unlock(folio);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
>                 swap_read_folio_fs(folio, plug);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6007252429bb2..cc04db6bb217e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> +       /*
> +        * Large folios should not be swapped in while zswap is being use=
d, as
> +        * they are not properly handled.
> +        *
> +        * If any of the subpages are in zswap, reading from disk would r=
esult
> +        * in data corruption, so return true without marking the folio u=
ptodate
> +        * so that an IO error is emitted (e.g. do_swap_page() will sigfa=
ult).
> +        *
> +        * Otherwise, return false and read the folio from disk.
> +        */
> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
> +               if (xa_find(tree, &offset, offset +
> folio_nr_pages(folio) - 1, 0))
> +                       return true;
> +               return false;
> +       }
> +
>         /*
>          * When reading into the swapcache, invalidate our entry. The
>          * swapcache can be the authoritative owner of the page and
> @@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
>                 zswap_entry_free(entry);
>                 folio_mark_dirty(folio);
>         }
> -
> +       folio_mark_uptodate(folio);
>         return true;
>  }
>
> One problem is that even if zswap was never enabled, the warning will
> be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
> static key if zswap was "ever" enabled.
>
> Barry, I suspect your is_zswap_enabled() check is deficient for
> similar reasons, zswap could have been enabled before then became
> disabled.

I don't understand this. if zswap was enabled before but is disabled when
I am loading data, will I get corrupted data before zswap was once enabled?
If not, it seems nothing important.

Thanks
Barry

