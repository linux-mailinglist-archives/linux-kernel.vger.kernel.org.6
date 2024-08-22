Return-Path: <linux-kernel+bounces-297074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7675495B2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CABB281779
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E205817E003;
	Thu, 22 Aug 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjpoV6J1"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D82033A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321569; cv=none; b=WwWZSxJEJe8OuGxo4tX6cmal1BuJsNDcNRb2bcavpCmLvomHPfDi1orxWt1aj5tRavLYTLxQUUYnxW1kGaJ53YbzoS/sJfsMc2J/cBsHQiQnnzNnHm3CN5qh1aBSfHf6hRhL9Fx8Rxa7ZMhRaO71KjuX/Z+IU15CWvbAvz12cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321569; c=relaxed/simple;
	bh=hTlfQbNMR09tN7o15fuAmWnSYRemssl/EpNTJTa3lys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjj/o6mAIOlwFO828aOKedMshqdxud0juJ+D5JiKaHR9MdMgy/aVihCiDXuqgBVhfvXspS+pPPZ/wP+hXIKsCLJBMBqIO+1kgja0gdYRyZYZKXlpCLq7abS3cqbQWwdwr48jnpRDQRVg/eMme2EhevfDj2sMYAJCfH7/mtaf4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjpoV6J1; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fcefbd6bc4so294435e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724321567; x=1724926367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmLdGfPjTGzFQMk4/RbDajyGMJHiO3CYEilHtnJ6xfY=;
        b=WjpoV6J19PNBt+OzHzwSys0D5wKlJx6nj4PT48/EJgzDvN2uH/yPfxve6GnSxd2ZHZ
         yOVRCFyt//JxgV4lmG704ud6X5B09SrA2rxk9Ne5LNrTgoOuT/n3+7SRFEcs9S73leRz
         Jfm6wnbanSbuLuiKHggZpfilos7TADcfc0ers6tzQBFJryw+TpZbNNBR7+ag6w6k/CV5
         Jo+kbBInN3Er9x5TtAeido6F92LWATpI408yY2CCZ8Wb7bMh9r+qEB/Rg2C9J2PWeD4i
         mawQnqmv2+MVUEycuZ6DODUozl7e8c9zkhwbt8SUzhvEfFlF9VTqnRehbOtzFg2Lvplg
         8Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321567; x=1724926367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmLdGfPjTGzFQMk4/RbDajyGMJHiO3CYEilHtnJ6xfY=;
        b=kP3HH9Jj7xgUVR/njLbL132tpnPDLRRUzDQWzoUR0v9p99V2mgORFRJ9cmvGwYt4Qx
         klEW8RAPEI314hM++yQnRJHp/RZu8FCDacjArzx1hUgDObG1HgsXBxo4lVIhJdgqC5bl
         013gJNKOhbbFHZyiV8BVwmudw7UOFfLf6x78VPdZvxyR6TBV9BtxUY+fadtZ8f+TEwun
         MKhf2AU0vrbTkVTf051P9+/TYl6RkCM1f78u5rLjWvN6778MSzwSfL9nisG3Qiq0Izdq
         EPZacTTViQHesI14jyFNF/FoINzFoom4l0X4cammvtKFzu0W6ovB24CpKekYHcggMbxe
         q30A==
X-Forwarded-Encrypted: i=1; AJvYcCVSmPPMT0vlBAFxcKcdR14HkZCgF3HNXtTL2OwBi0bWdMSQAr0K4aIHILe6nSPsOUSDpJ1+XgFra08InyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdkc0yvJ6UnF9jCLevvJRtiau+E0dLczVRZb9gQqVQzvFWbK5b
	6vkG/CULyCauq2g/lNEF0wL0ir7/Uid1AQSBF5Bs2EyLCkZG8fwnH3aKlwPE9xHPkzMAT+7DIQl
	rlQXIw5wZprTBbKIhKRDbApQ+bf8=
X-Google-Smtp-Source: AGHT+IEDrAQ5iKq70g8o15r9pKALcTZDZE54C4ReJhnkom1WT14GekqrJWsI11Dc2tvFyJcqeb/fR/oG9++UQd8JoQE=
X-Received: by 2002:a05:6122:a05:b0:4f5:2276:136d with SMTP id
 71dfb90a1353d-4fcf1977d47mr6139028e0c.1.1724321567042; Thu, 22 Aug 2024
 03:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <20240811224940.39876-2-21cnbao@gmail.com>
 <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com> <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
 <CAGsJ_4yqf4KNvsg1P47cAz+bniZFVcUWPkdjYTqji91CgnrrfQ@mail.gmail.com>
 <954f80c8-5bc3-44f5-a361-32073cbbd764@redhat.com> <CAGsJ_4wyj7U2z_XnbgEsavEkpkNO8=kVfMesxhtNbcQ=H3dzXw@mail.gmail.com>
 <a7d537df-7899-42fc-b9ef-66733105abbe@redhat.com>
In-Reply-To: <a7d537df-7899-42fc-b9ef-66733105abbe@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 22:12:35 +1200
Message-ID: <CAGsJ_4xjvid+JTbDwJJ9P4PkC2t6SWxyOkLq30-gbicNM6BSLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:01=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 22.08.24 11:21, Barry Song wrote:
> > On Thu, Aug 22, 2024 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 22.08.24 10:44, Barry Song wrote:
> >>> On Thu, Aug 22, 2024 at 12:52=E2=80=AFPM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>>>
> >>>> On Thu, Aug 22, 2024 at 5:34=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 12.08.24 00:49, Barry Song wrote:
> >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> Anon large folios come from three places:
> >>>>>> 1. new allocated large folios in PF, they will call folio_add_new_=
anon_rmap()
> >>>>>> for rmap;
> >>>>>> 2. a large folio is split into multiple lower-order large folios;
> >>>>>> 3. a large folio is migrated to a new large folio.
> >>>>>>
> >>>>>> In all above three counts, we increase nr_anon by 1;
> >>>>>>
> >>>>>> Anon large folios might go either because of be split or be put
> >>>>>> to free, in these cases, we reduce the count by 1.
> >>>>>>
> >>>>>> Folios that have been added to the swap cache but have not yet rec=
eived
> >>>>>> an anon mapping won't be counted. This is consistent with the Anon=
Pages
> >>>>>> statistics in /proc/meminfo.
> >>>>>
> >>>>> Thinking out loud, I wonder if we want to have something like that =
for
> >>>>> any anon folios (including small ones).
> >>>>>
> >>>>> Assume we longterm-pinned an anon folio and unmapped/zapped it. It =
would
> >>>>> be quite interesting to see that these are actually anon pages stil=
l
> >>>>> consuming memory. Same with memory leaks, when an anon folio doesn'=
t get
> >>>>> freed for some reason.
> >>>>>
> >>>>> The whole "AnonPages" counter thingy is just confusing, it only cou=
nts
> >>>>> what's currently mapped ... so we'd want something different.
> >>>>>
> >>>>> But it's okay to start with large folios only, there we have a new
> >>>>> interface without that legacy stuff :)
> >>>>
> >>>> We have two options to do this:
> >>>> 1. add a new separate nr_anon_unmapped interface which
> >>>> counts unmapped anon memory only
> >>>> 2. let the nr_anon count both mapped and unmapped anon
> >>>> folios.
> >>>>
> >>>> I would assume 1 is clearer as right now AnonPages have been
> >>>> there for years. and counting all mapped and unmapped together,
> >>>> we are still lacking an approach to find out anon memory leak
> >>>> problem you mentioned.
> >>>>
> >>>> We are right now comparing nr_anon(including mapped folios only)
> >>>> with AnonPages to get the distribution of different folio sizes in
> >>>> performance profiling.
> >>>>
> >>>> unmapped_nr_anon should be normally always quite small. otherwise,
> >>>> something must be wrong.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>> ---
> >>>>>>     Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> >>>>>>     include/linux/huge_mm.h                    | 15 +++++++++++++-=
-
> >>>>>>     mm/huge_memory.c                           | 13 ++++++++++---
> >>>>>>     mm/migrate.c                               |  4 ++++
> >>>>>>     mm/page_alloc.c                            |  5 ++++-
> >>>>>>     mm/rmap.c                                  |  1 +
> >>>>>>     6 files changed, 37 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Document=
ation/admin-guide/mm/transhuge.rst
> >>>>>> index 058485daf186..9fdfb46e4560 100644
> >>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>>>> @@ -527,6 +527,11 @@ split_deferred
> >>>>>>             it would free up some memory. Pages on split queue are=
 going to
> >>>>>>             be split under memory pressure, if splitting is possib=
le.
> >>>>>>
> >>>>>> +nr_anon
> >>>>>> +       the number of anon huge pages we have in the whole system.
> >>>>>
> >>>>> "transparent ..." otherwise people might confuse it with anon huget=
lb
> >>>>> "huge pages" ... :)
> >>>>>
> >>>>> I briefly tried coming up with a better name than "nr_anon" but fai=
led.
> >>>>>
> >>>>>
> >>>>
> >>>> if we might have unmapped_anon counter later, maybe rename it to
> >>>> nr_anon_mapped? and the new interface we will have in the future
> >>>> might be nr_anon_unmapped?
> >>
> >> We really shouldn't be using the mapped/unmapped terminology here ... =
we
> >> allocated pages and turned them into anonymous folios. At some point w=
e
> >> free them. That's the lifecycle.
> >>
> >>>
> >>> On second thought, this might be incorrect as well. Concepts like 'an=
on',
> >>> 'shmem', and 'file' refer to states after mapping. If an 'anon' has b=
een
> >>> unmapped but is still pinned and not yet freed, it isn't technically =
an
> >>> 'anon' anymore?
> >>
> >> It's just not mapped, and cannot get mapped, anymore. In the memdesc
> >> world, we'd be freeing the "struct anon" or "struct folio" once the la=
st
> >> refcount goes to 0, not once (e.g., temporarily during a failed
> >> migration?) unmapped.
> >>
> >> The important part to me would be: this is memory that was allocated f=
or
> >> anonymous memory, and it's still around for some reason and not gettin=
g
> >> freed. Usually, we would expect anon memory to get freed fairly quickl=
y
> >> once unmapped. Except when there are long-term pinnings or other types
> >> of memory leaks.
> >>
> >> You could happily continue using these anon pages via vmsplice() or
> >> similar, even thought he original page table mapping was torn down.
> >>
> >>>
> >>> On the other hand, implementing nr_anon_unmapped could be extremely
> >>> tricky. I have no idea how to implement it as we are losing those map=
ping
> >>> flags.
> >>
> >> folio_mapcount() can tell you efficiently whether a folio is mapped or
> >> not -- and that information will stay for all eternity as long as we
> >> have any mapcounts :) . It cannot tell "how many" pages of a large fol=
io
> >> are mapped, but at least "is any page of this large folio mapped".
> >
> > Exactly. AnonPages decreases by -1 when removed from the rmap,
> > whereas nr_anon decreases by -1 when an anon folio is freed. So,
> > I would assume nr_anon includes those pinned and unmapped anon
> > folios but AnonPages doesn't.
>
> Right, note how internally it is called "NR_ANON_MAPPED", but we ended
> up calling it "AnonPages". But that's rather a legacy interface we
> cannot change (fix) that easily. At least not without a config option.
>
> At some point it might indeed be interesting to have "nr_anon_mapped",
> here, but that would correspond to "is any part of this large folio
> mapped". For debugging purposes in the future, that might be indeed
> interesting.
>
> "nr_anon": anon allocations (until freed -> +1)
> "nr_anon_mapped": anon allocations that are mapped (any part mapped -> +1=
)
> "nr_anon_partially_mapped": anon allocations that was detected to be
> partially mapped at some point -> +1
>
> If a folio is in the swapcache, I would still want to see that it is an
> anon allocation lurking around in the system. Like we do with pagecache
> pages. *There* we do have the difference between "allocated" and
> "mapped" already.
>
> So likely, calling it "nr_anon" here, and tracking it on an allocation
> level, is good enough for now and future proof.

Right. I plan to send v3 tomorrow to at least unblock Usama's series,
in case he wants to rebase on top of it.

>
> >
> > If there's a significant amount of 'leaked' anon, we should consider
> > having a separate counter for them. For instance, if nr_anon is
> > 100,000 and pinned/unmapped pages account for 50%, then nr_anon
> > alone doesn=E2=80=99t effectively reflect the system's state.
>
> Right, but if you stare at the system you could tell that a significant
> amount of memory is still getting consumed through existing/previous
> anon mappings. Depends on how valuable that distinction really is.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

