Return-Path: <linux-kernel+bounces-316662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C296D27A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3DF1F26E24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33C194AF3;
	Thu,  5 Sep 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFOEzmd7"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32E194C9D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526187; cv=none; b=h0F38L6morQ4h13SGzvmy3ykJbKcXYI5ZXid8jZt+aSN3wRBjP0aLRUE5LfoG/05UqlEGpXvNWpQzj4SZA4TyvqQbeVUgRlWJl7uw9reNL/j6/yQTUZe9mtAtMy4E0M0t4YYqiUNc9rnAJtpRSORP14vq4ckchfk/1uzGc6RTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526187; c=relaxed/simple;
	bh=W1qaW9dSXwJ2r5ZU7qPmEDz4s2B+i7vK54q5HQaTKoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF3T99BBw/FJqjsu0L4Pz+/6hXLss4iOrpg34AeXS2BpBdw8xrowM0Rs3bb1LvjxoGPLBNv5vX0BbUg9BVXc6SkXUbsuLx6vHMKZt236MP09X3cKxtNiPT9aFCfDF1Vx7qbPgd9XB6iy2doVp+/LkZVDa10FnzVPe0UQsMZyXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFOEzmd7; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fcefbd6bc4so187492e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725526184; x=1726130984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydZrq1jmYcJ3iT5KVQR2uEItSEJAIa0sqI78Zxb7F4o=;
        b=fFOEzmd7+GIZPw/DvroxHtdMKllujbp3M6twirhc7wlBszUgCXEMV5dqWtZjnyTb69
         DA1Ssvq8PpTAe7Dmcc6fjAyRpbG3ivNw/EHIAslMi5R87wof7zpfWTWB2uQ3Ca2ujkDU
         KBrv555w2nlZTd7ZeTlV+Wn0LFRU/57m6i4XDLZ3ZJVkG26/1G4vcNnCUjpnzdN6biYM
         lFq8ExxOO/nFeLLAELnFS/QYsEe1aEbvt1yypyLkjlEtkWWLpLbI1J+zcYwp8qIrL/Ux
         9CCwQBuUNuiuWFtB1Lf+mhbcjs9j1D1rOeDmXy6VlfSUjzMHmPiTMjukNmBc+8mT+rT2
         pZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526184; x=1726130984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydZrq1jmYcJ3iT5KVQR2uEItSEJAIa0sqI78Zxb7F4o=;
        b=Vbnm/bupiMaAqaMmOPaTiT6j8/VtP2ay6KfnFGl8g8KJEedU/1VWFHlhEJPyhl6Iyg
         0fMM98DwgPgNHnV6eRRkpLJexdpn1yxUinP3cI4vd8T4zkpxGgv/BDxoNkB3JVxWFp/N
         TyX0t29uVymZIv9ON5F4i2FsmhQ8rObzcnZowBXIvFMJbgCiMiWk9VodvH0pIG0p6K5N
         lrpqKe1gNAXanpjV20ZzwaUKZUDdHGYRCe2hUobYq1W+mkebcZNwvdaig2GhCq5hxUkI
         zFZ7t4D7XH95kCuc0lE/mltNhZtQsuIfzsCkXMkcEpJuGXPDzIxfOQ4QCkwu8a6Ba447
         qohw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhS0mn5AgYsWpXChZfEr72kC/QcMB11z2ulbx46mIc5tmkqRoPe1raexVA7QTWFsss9eHjsdhqRjRxIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/gJWwr4zV0nWraFxuNPp2tmtfwFk6TeSRq4J6ExZcvV+17E0
	LV9xAion+9IzudIJu4wJy9LHIOtcT8MChR3fF8UJCoIYxQoU5oH8LPb281/jhFng2Iy0v0OeY8u
	CuCuTkVDL6/1R6+3VuQAxa0V2QZ4=
X-Google-Smtp-Source: AGHT+IESNubA1dBtNKwBaV0JG3mhnHocLUPe4ld26wzHID0WHJi/mIUJKopiztf/4SpPMVyPen7jmWn785b8VHIqMWY=
X-Received: by 2002:a05:6122:1797:b0:4f5:261a:bdc4 with SMTP id
 71dfb90a1353d-5009b00151amr19662728e0c.2.1725526183853; Thu, 05 Sep 2024
 01:49:43 -0700 (PDT)
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
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com> <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 20:49:31 +1200
Message-ID: <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Sep 5, 2024 at 12:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > [..]
> > > > > I understand the point of doing this to unblock the synchronous l=
arge
> > > > > folio swapin support work, but at some point we're gonna have to
> > > > > actually handle the cases where a large folio being swapped in is
> > > > > partially in the swap cache, zswap, the zeromap, etc.
> > > > >
> > > > > All these cases will need similar-ish handling, and I suspect we =
won't
> > > > > just skip swapping in large folios in all these cases.
> > > >
> > > > I agree that this is definitely the goal. `swap_read_folio()` shoul=
d be a
> > > > dependable API that always returns reliable data, regardless of whe=
ther
> > > > `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-i=
n shouldn't
> > > > be held back. Significant efforts are underway to support large fol=
ios in
> > > > `zswap`, and progress is being made. Not to mention we've already a=
llowed
> > > > `zeromap` to proceed, even though it doesn't support large folios.
> > > >
> > > > It's genuinely unfair to let the lack of mTHP support in `zeromap` =
and
> > > > `zswap` hold swap-in hostage.
> > >
> >
> > Hi Yosry,
> >
> > > Well, two points here:
> > >
> > > 1. I did not say that we should block the synchronous mTHP swapin wor=
k
> > > for this :) I said the next item on the TODO list for mTHP swapin
> > > support should be handling these cases.
> >
> > Thanks for your clarification!
> >
> > >
> > > 2. I think two things are getting conflated here. Zswap needs to
> > > support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What is
> > > truly, and is outside the scope of zswap/zeromap, is being able to
> > > support hybrid mTHP swapin.
> > >
> > > When swapping in an mTHP, the swapped entries can be on disk, in the
> > > swapcache, in zswap, or in the zeromap. Even if all these things
> > > support mTHPs individually, we essentially need support to form an
> > > mTHP from swap entries in different backends. That's what I meant.
> > > Actually if we have that, we may not really need mTHP swapin support
> > > in zswap, because we can just form the large folio in the swap layer
> > > from multiple zswap entries.
> > >
> >
> > After further consideration, I've actually started to disagree with the=
 idea
> > of supporting hybrid swapin (forming an mTHP from swap entries in diffe=
rent
> > backends). My reasoning is as follows:
>
> I do not have any data about this, so you could very well be right
> here. Handling hybrid swapin could be simply falling back to the
> smallest order we can swapin from a single backend. We can at least
> start with this, and collect data about how many mTHP swapins fallback
> due to hybrid backends. This way we only take the complexity if
> needed.
>
> I did imagine though that it's possible for two virtually contiguous
> folios to be swapped out to contiguous swap entries and end up in
> different media (e.g. if only one of them is zero-filled). I am not
> sure how rare it would be in practice.
>
> >
> > 1. The scenario where an mTHP is partially zeromap, partially zswap, et=
c.,
> > would be an extremely rare case, as long as we're swapping out the mTHP=
 as
> > a whole and all the modules are handling it accordingly. It's highly
> > unlikely to form this mix of zeromap, zswap, and swapcache unless the
> > contiguous VMA virtual address happens to get some small folios with
> > aligned and contiguous swap slots. Even then, they would need to be
> > partially zeromap and partially non-zeromap, zswap, etc.
>
> As I mentioned, we can start simple and collect data for this. If it's
> rare and we don't need to handle it, that's good.
>
> >
> > As you mentioned, zeromap handles mTHP as a whole during swapping
> > out, marking all subpages of the entire mTHP as zeromap rather than jus=
t
> > a subset of them.
> >
> > And swap-in can also entirely map a swapcache which is a large folio ba=
sed
> > on our previous patchset which has been in mainline:
> > "mm: swap: entirely map large folios found in swapcache"
> > https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.com/
> >
> > It seems the only thing we're missing is zswap support for mTHP.
>
> It is still possible for two virtually contiguous folios to be swapped
> out to contiguous swap entries. It is also possible that a large folio
> is swapped out as a whole, then only a part of it is swapped in later
> due to memory pressure. If that part is later reclaimed again and gets
> added to the swapcache, we can run into the hybrid swapin situation.
> There may be other scenarios as well, I did not think this through.
>
> >
> > 2. Implementing hybrid swap-in would be extremely tricky and could disr=
upt
> > several software layers. I can share some pseudo code below:
>
> Yeah it definitely would be complex, so we need proper justification for =
it.
>
> >
> > swap_read_folio()
> > {
> >        if (zeromap_full)
> >                folio_read_from_zeromap()
> >        else if (zswap_map_full)
> >               folio_read_from_zswap()
> >        else {
> >               folio_read_from_swapfile()
> >               if (zeromap_partial)
> >                        folio_read_from_zeromap_fixup()  /* fill zero
> > for partially zeromap subpages */
> >               if (zwap_partial)
> >                        folio_read_from_zswap_fixup()  /* zswap_load
> > for partially zswap-mapped subpages */
> >
> >                folio_mark_uptodate()
> >                folio_unlock()
> > }
> >
> > We'd also need to modify folio_read_from_swapfile() to skip
> > folio_mark_uptodate()
> > and folio_unlock() after completing the BIO. This approach seems to
> > entirely disrupt
> > the software layers.
> >
> > This could also lead to unnecessary IO operations for subpages that
> > require fixup.
> > Since such cases are quite rare, I believe the added complexity isn't w=
orth it.
> >
> > My point is that we should simply check that all PTEs have consistent z=
eromap,
> > zswap, and swapcache statuses before proceeding, otherwise fall back to=
 the next
> > lower order if needed. This approach improves performance and avoids co=
mplex
> > corner cases.
>
> Agree that we should start with that, although we should probably
> fallback to the largest order we can swapin from a single backend,
> rather than the next lower order.
>
> >
> > So once zswap mTHP is there, I would also expect an API similar to
> > swap_zeromap_entries_check()
> > for example:
> > zswap_entries_check(entry, nr) which can return if we are having
> > full, non, and partial zswap to replace the existing
> > zswap_never_enabled().
>
> I think a better API would be similar to what Usama had. Basically
> take in (entry, nr) and return how much of it is in zswap starting at
> entry, so that we can decide the swapin order.
>
> Maybe we can adjust your proposed swap_zeromap_entries_check() as well
> to do that? Basically return the number of swap entries in the zeromap
> starting at 'entry'. If 'entry' itself is not in the zeromap we return
> 0 naturally. That would be a small adjustment/fix over what Usama had,
> but implementing it with bitmap operations like you did would be
> better.

I assume you means the below

/*
 * Return the number of contiguous zeromap entries started from entry
 */
static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, in=
t nr)
{
        struct swap_info_struct *sis =3D swp_swap_info(entry);
        unsigned long start =3D swp_offset(entry);
        unsigned long end =3D start + nr;
        unsigned long idx;

        idx =3D find_next_bit(sis->zeromap, end, start);
        if (idx !=3D start)
                return 0;

        return find_next_zero_bit(sis->zeromap, end, start) - idx;
}

If yes, I really like this idea.

It seems much better than using an enum, which would require adding a new
data structure :-) Additionally, returning the number allows callers
to fall back
to the largest possible order, rather than trying next lower orders
sequentially.

Hi Usama,
what is your take on this?

>
> >
> > Though I am not sure how cheap zswap can implement it,
> > swap_zeromap_entries_check()
> > could be two simple bit operations:
> >
> > +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t
> > entry, int nr)
> > +{
> > +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> > +       unsigned long start =3D swp_offset(entry);
> > +       unsigned long end =3D start + nr;
> > +
> > +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> > +               return SWAP_ZEROMAP_NON;
> > +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> > +               return SWAP_ZEROMAP_FULL;
> > +
> > +       return SWAP_ZEROMAP_PARTIAL;
> > +}
> >
> > 3. swapcache is different from zeromap and zswap. Swapcache indicates
> > that the memory
> > is still available and should be re-mapped rather than allocating a
> > new folio. Our previous
> > patchset has implemented a full re-map of an mTHP in do_swap_page() as =
mentioned
> > in 1.
> >
> > For the same reason as point 1, partial swapcache is a rare edge case.
> > Not re-mapping it
> > and instead allocating a new folio would add significant complexity.
> >
> > > >
> > > > Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeroma=
p`, we
> > > > permit almost all mTHP swap-ins, except for those rare situations w=
here
> > > > small folios that were swapped out happen to have contiguous and al=
igned
> > > > swap slots.
> > > >
> > > > swapcache is another quite different story, since our user scenario=
s begin from
> > > > the simplest sync io on mobile phones, we don't quite care about sw=
apcache.
> > >
> > > Right. The reason I bring this up is as I mentioned above, there is a
> > > common problem of forming large folios from different sources, which
> > > includes the swap cache. The fact that synchronous swapin does not us=
e
> > > the swapcache was a happy coincidence for you, as you can add support
> > > mTHP swapins without handling this case yet ;)
> >
> > As I mentioned above, I'd really rather filter out those corner cases
> > than support
> > them, not just for the current situation to unlock swap-in series :-)
>
> If they are indeed corner cases, then I definitely agree.

Thanks
Barry

