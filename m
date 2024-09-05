Return-Path: <linux-kernel+bounces-316861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9196D64D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13821F23489
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9115198E81;
	Thu,  5 Sep 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioKRFiEQ"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01735155730
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532938; cv=none; b=kwHOIC3bb0xegI3Y123uW+ELVFZpbM47eqpqaRzCAaLGpOhiZVXK2WMfK1JyMhnrTe2OVTqN6jWVON6yXQ0AxWKgeBmAj+lgLmi66J+wj7pW/muGD0bQ89FigSmg/YU7LhaO1/mEs4QjH0GHcgcHDCgUlXbVzXbv9G4PxIt+ujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532938; c=relaxed/simple;
	bh=8UC/dQVKZXktNDuw/iiaVFs5ho/J8A+nQ8kOL52yOAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G15VXNssCK7VSfWDKQZ8yh/o54I6HPhINeOVJ2hKcBDxbkonmN9bRUqX9//C5ZU6GH8dtGP5LXZ5kb1nPWHWqrixxexkiMV4WXZDnp0jw7aX4elH7duGdE8bxuABlkgkTYVmcY+xS5w1cBqQuYgu4UW/o2NyK6XmHaXRGzl65Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioKRFiEQ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846c588fa52so178672241.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725532936; x=1726137736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxtb4aB/vMwtX//+yIrmVx2E+pKuYt+yk5iWYPlWftA=;
        b=ioKRFiEQvPl3fzyM8Y66ysaiI3zTCHU+SkVGSHMnJD2GygbWAMouZDkDHukXMlqm29
         CvUGpC24Ww+ri6kKNZwpefvphiUEa8aB0KYXrafgZNSualhUnLCAUrWLtP1zFvH3YW3r
         fu4/HSrBqeAoPo6zzR1+pGxLUBcBeBrSLRtfKMVeNh2mqZilKd6oSv94/NUN6McChzNi
         VhoYYlE5/W82v1h9mdEjZQ4vScd3CKpn+b5TFtJN4BJ+Bxpbg9P6d5Qm0N80RW/39iY1
         V09x2x3aIJGrrALFNB5YI5P+Y+6Flg5JGAk0l3V6miNlwiElhco5XnW8hh7FGSpPhbvy
         ioPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532936; x=1726137736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxtb4aB/vMwtX//+yIrmVx2E+pKuYt+yk5iWYPlWftA=;
        b=AdQETwh6vluMqPyeVgdsvZvIPVOcfDes6gWlwl9Lc9YXQmT9rk5cZamywVxM5x2otv
         2RWaT6DJoctUcRjqRRGkr/QTfJQwgBMlzz5HU/R/9uWfW5IFQ7xKR09y1jDXnpQrnENP
         YUSIYiatwH6/U3iQldjktUMbHSZYEc+nHhsRIe7BSueHJwk+Hopcb/ddrOvVDRppwDMC
         8Kr8eyPPLWwDkogJWXLwbaVdvDXoGsY20dP1KK7I2V3StTAXPP29GfVgk8ZhwUTA4hf9
         8MxQ3FhyeUNWRDJM38OU4pip8AIn5VeImhN0UmwSPskmXZ7rTHUJfDucN7otjWoEPySu
         IHxg==
X-Forwarded-Encrypted: i=1; AJvYcCWKY36/QbHCcguLBnMykeDTE7gZWJPJzrQi+DotbQ8iYIPm0ECgV7I4z47Twi36wYcOWDEuIi4g4FgpSQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRgm3qYEKUgNRwmG2+llQh/+O3y4SPOhwNalG3VkgkMF/HGQQ
	kh70IejGwTwcABm5DBKgurdfx7TESsMtkyuLnLrMe4ACM/Uh2c9ld1ByX91XmtEPabo/TC2XiA0
	xi3vcaC4XZHBl85yqbR3OUAjTEoE=
X-Google-Smtp-Source: AGHT+IFJcZgaTG1WGVJOAyzKzan2cpe4vqj225xtLQ3JDyHR07wofDr26ua60JB7Xj24dAF2yZt7FojabBmZZ/okaI0=
X-Received: by 2002:a05:6102:e0e:b0:492:9c55:aec5 with SMTP id
 ada2fe7eead31-49bad2b2086mr10261663137.15.1725532935747; Thu, 05 Sep 2024
 03:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com> <ccbe7ec4-1a27-40d7-88dd-b2299e96a558@gmail.com>
In-Reply-To: <ccbe7ec4-1a27-40d7-88dd-b2299e96a558@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 22:42:03 +1200
Message-ID: <CAGsJ_4yVB4wcqp5cDpnj6XSuqtb4G=DRiMBssbhpTcVSwaQd6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:37=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 05/09/2024 11:10, Barry Song wrote:
> > On Thu, Sep 5, 2024 at 8:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >>
> >> On Thu, Sep 5, 2024 at 7:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >>>
> >>> On Thu, Sep 5, 2024 at 12:03=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> >>>>
> >>>> On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> >>>>>
> >>>>> [..]
> >>>>>>> I understand the point of doing this to unblock the synchronous l=
arge
> >>>>>>> folio swapin support work, but at some point we're gonna have to
> >>>>>>> actually handle the cases where a large folio being swapped in is
> >>>>>>> partially in the swap cache, zswap, the zeromap, etc.
> >>>>>>>
> >>>>>>> All these cases will need similar-ish handling, and I suspect we =
won't
> >>>>>>> just skip swapping in large folios in all these cases.
> >>>>>>
> >>>>>> I agree that this is definitely the goal. `swap_read_folio()` shou=
ld be a
> >>>>>> dependable API that always returns reliable data, regardless of wh=
ether
> >>>>>> `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-=
in shouldn't
> >>>>>> be held back. Significant efforts are underway to support large fo=
lios in
> >>>>>> `zswap`, and progress is being made. Not to mention we've already =
allowed
> >>>>>> `zeromap` to proceed, even though it doesn't support large folios.
> >>>>>>
> >>>>>> It's genuinely unfair to let the lack of mTHP support in `zeromap`=
 and
> >>>>>> `zswap` hold swap-in hostage.
> >>>>>
> >>>>
> >>>> Hi Yosry,
> >>>>
> >>>>> Well, two points here:
> >>>>>
> >>>>> 1. I did not say that we should block the synchronous mTHP swapin w=
ork
> >>>>> for this :) I said the next item on the TODO list for mTHP swapin
> >>>>> support should be handling these cases.
> >>>>
> >>>> Thanks for your clarification!
> >>>>
> >>>>>
> >>>>> 2. I think two things are getting conflated here. Zswap needs to
> >>>>> support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What i=
s
> >>>>> truly, and is outside the scope of zswap/zeromap, is being able to
> >>>>> support hybrid mTHP swapin.
> >>>>>
> >>>>> When swapping in an mTHP, the swapped entries can be on disk, in th=
e
> >>>>> swapcache, in zswap, or in the zeromap. Even if all these things
> >>>>> support mTHPs individually, we essentially need support to form an
> >>>>> mTHP from swap entries in different backends. That's what I meant.
> >>>>> Actually if we have that, we may not really need mTHP swapin suppor=
t
> >>>>> in zswap, because we can just form the large folio in the swap laye=
r
> >>>>> from multiple zswap entries.
> >>>>>
> >>>>
> >>>> After further consideration, I've actually started to disagree with =
the idea
> >>>> of supporting hybrid swapin (forming an mTHP from swap entries in di=
fferent
> >>>> backends). My reasoning is as follows:
> >>>
> >>> I do not have any data about this, so you could very well be right
> >>> here. Handling hybrid swapin could be simply falling back to the
> >>> smallest order we can swapin from a single backend. We can at least
> >>> start with this, and collect data about how many mTHP swapins fallbac=
k
> >>> due to hybrid backends. This way we only take the complexity if
> >>> needed.
> >>>
> >>> I did imagine though that it's possible for two virtually contiguous
> >>> folios to be swapped out to contiguous swap entries and end up in
> >>> different media (e.g. if only one of them is zero-filled). I am not
> >>> sure how rare it would be in practice.
> >>>
> >>>>
> >>>> 1. The scenario where an mTHP is partially zeromap, partially zswap,=
 etc.,
> >>>> would be an extremely rare case, as long as we're swapping out the m=
THP as
> >>>> a whole and all the modules are handling it accordingly. It's highly
> >>>> unlikely to form this mix of zeromap, zswap, and swapcache unless th=
e
> >>>> contiguous VMA virtual address happens to get some small folios with
> >>>> aligned and contiguous swap slots. Even then, they would need to be
> >>>> partially zeromap and partially non-zeromap, zswap, etc.
> >>>
> >>> As I mentioned, we can start simple and collect data for this. If it'=
s
> >>> rare and we don't need to handle it, that's good.
> >>>
> >>>>
> >>>> As you mentioned, zeromap handles mTHP as a whole during swapping
> >>>> out, marking all subpages of the entire mTHP as zeromap rather than =
just
> >>>> a subset of them.
> >>>>
> >>>> And swap-in can also entirely map a swapcache which is a large folio=
 based
> >>>> on our previous patchset which has been in mainline:
> >>>> "mm: swap: entirely map large folios found in swapcache"
> >>>> https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.co=
m/
> >>>>
> >>>> It seems the only thing we're missing is zswap support for mTHP.
> >>>
> >>> It is still possible for two virtually contiguous folios to be swappe=
d
> >>> out to contiguous swap entries. It is also possible that a large foli=
o
> >>> is swapped out as a whole, then only a part of it is swapped in later
> >>> due to memory pressure. If that part is later reclaimed again and get=
s
> >>> added to the swapcache, we can run into the hybrid swapin situation.
> >>> There may be other scenarios as well, I did not think this through.
> >>>
> >>>>
> >>>> 2. Implementing hybrid swap-in would be extremely tricky and could d=
isrupt
> >>>> several software layers. I can share some pseudo code below:
> >>>
> >>> Yeah it definitely would be complex, so we need proper justification =
for it.
> >>>
> >>>>
> >>>> swap_read_folio()
> >>>> {
> >>>>        if (zeromap_full)
> >>>>                folio_read_from_zeromap()
> >>>>        else if (zswap_map_full)
> >>>>               folio_read_from_zswap()
> >>>>        else {
> >>>>               folio_read_from_swapfile()
> >>>>               if (zeromap_partial)
> >>>>                        folio_read_from_zeromap_fixup()  /* fill zero
> >>>> for partially zeromap subpages */
> >>>>               if (zwap_partial)
> >>>>                        folio_read_from_zswap_fixup()  /* zswap_load
> >>>> for partially zswap-mapped subpages */
> >>>>
> >>>>                folio_mark_uptodate()
> >>>>                folio_unlock()
> >>>> }
> >>>>
> >>>> We'd also need to modify folio_read_from_swapfile() to skip
> >>>> folio_mark_uptodate()
> >>>> and folio_unlock() after completing the BIO. This approach seems to
> >>>> entirely disrupt
> >>>> the software layers.
> >>>>
> >>>> This could also lead to unnecessary IO operations for subpages that
> >>>> require fixup.
> >>>> Since such cases are quite rare, I believe the added complexity isn'=
t worth it.
> >>>>
> >>>> My point is that we should simply check that all PTEs have consisten=
t zeromap,
> >>>> zswap, and swapcache statuses before proceeding, otherwise fall back=
 to the next
> >>>> lower order if needed. This approach improves performance and avoids=
 complex
> >>>> corner cases.
> >>>
> >>> Agree that we should start with that, although we should probably
> >>> fallback to the largest order we can swapin from a single backend,
> >>> rather than the next lower order.
> >>>
> >>>>
> >>>> So once zswap mTHP is there, I would also expect an API similar to
> >>>> swap_zeromap_entries_check()
> >>>> for example:
> >>>> zswap_entries_check(entry, nr) which can return if we are having
> >>>> full, non, and partial zswap to replace the existing
> >>>> zswap_never_enabled().
> >>>
> >>> I think a better API would be similar to what Usama had. Basically
> >>> take in (entry, nr) and return how much of it is in zswap starting at
> >>> entry, so that we can decide the swapin order.
> >>>
> >>> Maybe we can adjust your proposed swap_zeromap_entries_check() as wel=
l
> >>> to do that? Basically return the number of swap entries in the zeroma=
p
> >>> starting at 'entry'. If 'entry' itself is not in the zeromap we retur=
n
> >>> 0 naturally. That would be a small adjustment/fix over what Usama had=
,
> >>> but implementing it with bitmap operations like you did would be
> >>> better.
> >>
> >> I assume you means the below
> >>
> >> /*
> >>  * Return the number of contiguous zeromap entries started from entry
> >>  */
> >> static inline unsigned int swap_zeromap_entries_count(swp_entry_t entr=
y, int nr)
> >> {
> >>         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >>         unsigned long start =3D swp_offset(entry);
> >>         unsigned long end =3D start + nr;
> >>         unsigned long idx;
> >>
> >>         idx =3D find_next_bit(sis->zeromap, end, start);
> >>         if (idx !=3D start)
> >>                 return 0;
> >>
> >>         return find_next_zero_bit(sis->zeromap, end, start) - idx;
> >> }
> >>
> >> If yes, I really like this idea.
> >>
> >> It seems much better than using an enum, which would require adding a =
new
> >> data structure :-) Additionally, returning the number allows callers
> >> to fall back
> >> to the largest possible order, rather than trying next lower orders
> >> sequentially.
> >
> > No, returning 0 after only checking first entry would still reintroduce
> > the current bug, where the start entry is zeromap but other entries
> > might not be. We need another value to indicate whether the entries
> > are consistent if we want to avoid the enum:
> >
> > /*
> >  * Return the number of contiguous zeromap entries started from entry;
> >  * If all entries have consistent zeromap, *consistent will be true;
> >  * otherwise, false;
> >  */
> > static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry=
,
> >                 int nr, bool *consistent)
> > {
> >         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >         unsigned long start =3D swp_offset(entry);
> >         unsigned long end =3D start + nr;
> >         unsigned long s_idx, c_idx;
> >
> >         s_idx =3D find_next_bit(sis->zeromap, end, start);
>
> In all of the implementations you sent, you are using find_next_bit(..,en=
d, start), but
> I believe it should be find_next_bit(..,nr, start)?

I guess no, the tricky thing is that size means the size from the first bit=
 of
bitmap but not from the "start" bit?

>
> TBH, I liked the enum implementation you had in https://lore.kernel.org/a=
ll/20240905002926.1055-1-21cnbao@gmail.com/
> Its the easiest to review and understand, and least likely to introduce a=
ny bugs.
> But it could be a personal preference.
> The likelihood of having contiguous zeromap entries *that* is less than n=
r is very low right?
> If so we could go with the enum implementation?

what about the bool impementation i sent in the last email, it seems the
simplest code.

>
>
> >         if (s_idx =3D=3D end) {
> >                 *consistent =3D true;
> >                 return 0;
> >         }
> >
> >         c_idx =3D find_next_zero_bit(sis->zeromap, end, start);
> >         if (c_idx =3D=3D end) {
> >                 *consistent =3D true;
> >                 return nr;
> >         }
> >
> >         *consistent =3D false;
> >         if (s_idx =3D=3D start)
> >                 return 0;
> >         return c_idx - s_idx;
> > }
> >
> > I can actually switch the places of the "consistent" and returned
> > number if that looks
> > better.
> >
> >>
> >> Hi Usama,
> >> what is your take on this?
> >>
> >>>
> >>>>
> >>>> Though I am not sure how cheap zswap can implement it,
> >>>> swap_zeromap_entries_check()
> >>>> could be two simple bit operations:
> >>>>
> >>>> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t
> >>>> entry, int nr)
> >>>> +{
> >>>> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> >>>> +       unsigned long start =3D swp_offset(entry);
> >>>> +       unsigned long end =3D start + nr;
> >>>> +
> >>>> +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> >>>> +               return SWAP_ZEROMAP_NON;
> >>>> +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> >>>> +               return SWAP_ZEROMAP_FULL;
> >>>> +
> >>>> +       return SWAP_ZEROMAP_PARTIAL;
> >>>> +}
> >>>>
> >>>> 3. swapcache is different from zeromap and zswap. Swapcache indicate=
s
> >>>> that the memory
> >>>> is still available and should be re-mapped rather than allocating a
> >>>> new folio. Our previous
> >>>> patchset has implemented a full re-map of an mTHP in do_swap_page() =
as mentioned
> >>>> in 1.
> >>>>
> >>>> For the same reason as point 1, partial swapcache is a rare edge cas=
e.
> >>>> Not re-mapping it
> >>>> and instead allocating a new folio would add significant complexity.
> >>>>
> >>>>>>
> >>>>>> Nonetheless, `zeromap` and `zswap` are distinct cases. With `zerom=
ap`, we
> >>>>>> permit almost all mTHP swap-ins, except for those rare situations =
where
> >>>>>> small folios that were swapped out happen to have contiguous and a=
ligned
> >>>>>> swap slots.
> >>>>>>
> >>>>>> swapcache is another quite different story, since our user scenari=
os begin from
> >>>>>> the simplest sync io on mobile phones, we don't quite care about s=
wapcache.
> >>>>>
> >>>>> Right. The reason I bring this up is as I mentioned above, there is=
 a
> >>>>> common problem of forming large folios from different sources, whic=
h
> >>>>> includes the swap cache. The fact that synchronous swapin does not =
use
> >>>>> the swapcache was a happy coincidence for you, as you can add suppo=
rt
> >>>>> mTHP swapins without handling this case yet ;)
> >>>>
> >>>> As I mentioned above, I'd really rather filter out those corner case=
s
> >>>> than support
> >>>> them, not just for the current situation to unlock swap-in series :-=
)
> >>>
> >>> If they are indeed corner cases, then I definitely agree.
> >>

Thanks
Barry

