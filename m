Return-Path: <linux-kernel+bounces-316541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE9D96D0E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69C1285695
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B1193428;
	Thu,  5 Sep 2024 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4n2/RKkV"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A84BE4A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522942; cv=none; b=TBCzbDfm3rQqgFVl5MTGjMlXhNr7uaRddQjk5kCfO6DwLhzfeQ+ciVGejI5xcQgiQc4VNnWE2Kbx6AEIAm/roRX7HiPHB8WwC/4kD2KTFG4KXtpQ4T0jKH2UwyRVgC3zSubYngoCk6JYUgwEngL6VesbOjRqpb0qmxaPWAEhfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522942; c=relaxed/simple;
	bh=nfd6NnUMNKn2S94lNqSxILqEGHyZrLVbjXbu/Hl8arQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTjtvIIeatKP03wmoUnWMTytHgzL/k+ZdibTNTde+gaF7MJRkAjkaCwpCDL0gDlUsfloW5O03O091rmOLNcvNtv4T3IlcmLSWqBy0OKImqTasfSZgjeMQLpjUqo9+ELpNaL6nGD6c66/lna63xo7m8Sb59EvNJhsK9rx25dpvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4n2/RKkV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so574878a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725522939; x=1726127739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQj7w9KgAzV4sviOPUObnL6qYVOdZSO5rlSQykT8m4Y=;
        b=4n2/RKkVUSLi2go/qDnAEKgQZKkKlMT/ZUDmuJyE3kOhOo67iTQd+1n0NleKCITiUZ
         gNi608e3oSWWYQNGwMDhfKhtKMmeJw+rIvRCeN6m+ZTc4ntOL7lpQx8uKj699jRO8Z/K
         mSj0csRBWz+9qNajSDg+us+h7WCKMRBaKD0g/SzaiE9+b/j1LWO3lH9mVg4KrJ8+DQTP
         D52LedWBIf2AAp6PeGOItW+J3GXvpUGZ6unSuaW8Hr2iy/49v5xO0Dy2p8kyvdDnuy4p
         evf7lHhBvn1o7pSpJHPudTXloVq2BCqefctjo6/N5vkqZUbu7MccEyxO9Uq8urvTKgT6
         n4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522939; x=1726127739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQj7w9KgAzV4sviOPUObnL6qYVOdZSO5rlSQykT8m4Y=;
        b=rmM/rjf/Bnu51eSmMezcwd9ownAHy7oKrTd9j5836UxYd6Qm6k7gyU3eoHcNaG8bLY
         hB4gnjCN61wpl0uGk8oYiNAvohMo0ohIaqoRLv9kR5ha8lOld9rR9ehrYo7ob4vEM6eH
         R6rgsQgJojdrUyh+UNZYTBe7dIEbRyt+AaYSmcnd//LGQbNBYIhirWjvZoWPjaruzI7C
         /DyEZMxYX7fIFMB32FTBOTTT2wcE5H0+F7Xs1v9ou8vT0ng4maLf2v8s++6PM1H8rLr2
         u/8JdaJUcdSJVs6ZK7rMTSY9QvPnCOY7JllDN4o4SLIo97paj7BxL1nR7502E5QmRe0g
         p16w==
X-Forwarded-Encrypted: i=1; AJvYcCU2WqUQZfPvckgUyC17lvmsTPst/2I4tQ7+m5LBdqWzrOeoRXJtFwDodT9l9STtjRBcpFYDUv0vIIeoeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwySi6vqiL0yF131CR7fnvfPdyJRqv4qFZUS+oc69/jwV05YW6
	tsxnAzf62tnN0xQWiJLW159QQANrkOyMZ+cngc7BCnOXh8h3s4nYd7cqAXR9GgqaDwDu5yWrtgE
	Pk2lzH3louFtLEsd4L4Cm0ryNJ9/YJEwpPfQe
X-Google-Smtp-Source: AGHT+IEREgWlr9bVpEAUDx0lX3+PNQ9dKVxj29Lr87pLUFQnqELlg2mBrInMe1ZAgel9oznbRWZgz1nuRiGabgBWvPE=
X-Received: by 2002:a17:907:efe2:b0:a86:a178:42de with SMTP id
 a640c23a62f3a-a8a3f532680mr429647066b.54.1725522938767; Thu, 05 Sep 2024
 00:55:38 -0700 (PDT)
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
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com> <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 00:55:02 -0700
Message-ID: <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > [..]
> > > > I understand the point of doing this to unblock the synchronous lar=
ge
> > > > folio swapin support work, but at some point we're gonna have to
> > > > actually handle the cases where a large folio being swapped in is
> > > > partially in the swap cache, zswap, the zeromap, etc.
> > > >
> > > > All these cases will need similar-ish handling, and I suspect we wo=
n't
> > > > just skip swapping in large folios in all these cases.
> > >
> > > I agree that this is definitely the goal. `swap_read_folio()` should =
be a
> > > dependable API that always returns reliable data, regardless of wheth=
er
> > > `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-in =
shouldn't
> > > be held back. Significant efforts are underway to support large folio=
s in
> > > `zswap`, and progress is being made. Not to mention we've already all=
owed
> > > `zeromap` to proceed, even though it doesn't support large folios.
> > >
> > > It's genuinely unfair to let the lack of mTHP support in `zeromap` an=
d
> > > `zswap` hold swap-in hostage.
> >
>
> Hi Yosry,
>
> > Well, two points here:
> >
> > 1. I did not say that we should block the synchronous mTHP swapin work
> > for this :) I said the next item on the TODO list for mTHP swapin
> > support should be handling these cases.
>
> Thanks for your clarification!
>
> >
> > 2. I think two things are getting conflated here. Zswap needs to
> > support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What is
> > truly, and is outside the scope of zswap/zeromap, is being able to
> > support hybrid mTHP swapin.
> >
> > When swapping in an mTHP, the swapped entries can be on disk, in the
> > swapcache, in zswap, or in the zeromap. Even if all these things
> > support mTHPs individually, we essentially need support to form an
> > mTHP from swap entries in different backends. That's what I meant.
> > Actually if we have that, we may not really need mTHP swapin support
> > in zswap, because we can just form the large folio in the swap layer
> > from multiple zswap entries.
> >
>
> After further consideration, I've actually started to disagree with the i=
dea
> of supporting hybrid swapin (forming an mTHP from swap entries in differe=
nt
> backends). My reasoning is as follows:

I do not have any data about this, so you could very well be right
here. Handling hybrid swapin could be simply falling back to the
smallest order we can swapin from a single backend. We can at least
start with this, and collect data about how many mTHP swapins fallback
due to hybrid backends. This way we only take the complexity if
needed.

I did imagine though that it's possible for two virtually contiguous
folios to be swapped out to contiguous swap entries and end up in
different media (e.g. if only one of them is zero-filled). I am not
sure how rare it would be in practice.

>
> 1. The scenario where an mTHP is partially zeromap, partially zswap, etc.=
,
> would be an extremely rare case, as long as we're swapping out the mTHP a=
s
> a whole and all the modules are handling it accordingly. It's highly
> unlikely to form this mix of zeromap, zswap, and swapcache unless the
> contiguous VMA virtual address happens to get some small folios with
> aligned and contiguous swap slots. Even then, they would need to be
> partially zeromap and partially non-zeromap, zswap, etc.

As I mentioned, we can start simple and collect data for this. If it's
rare and we don't need to handle it, that's good.

>
> As you mentioned, zeromap handles mTHP as a whole during swapping
> out, marking all subpages of the entire mTHP as zeromap rather than just
> a subset of them.
>
> And swap-in can also entirely map a swapcache which is a large folio base=
d
> on our previous patchset which has been in mainline:
> "mm: swap: entirely map large folios found in swapcache"
> https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.com/
>
> It seems the only thing we're missing is zswap support for mTHP.

It is still possible for two virtually contiguous folios to be swapped
out to contiguous swap entries. It is also possible that a large folio
is swapped out as a whole, then only a part of it is swapped in later
due to memory pressure. If that part is later reclaimed again and gets
added to the swapcache, we can run into the hybrid swapin situation.
There may be other scenarios as well, I did not think this through.

>
> 2. Implementing hybrid swap-in would be extremely tricky and could disrup=
t
> several software layers. I can share some pseudo code below:

Yeah it definitely would be complex, so we need proper justification for it=
.

>
> swap_read_folio()
> {
>        if (zeromap_full)
>                folio_read_from_zeromap()
>        else if (zswap_map_full)
>               folio_read_from_zswap()
>        else {
>               folio_read_from_swapfile()
>               if (zeromap_partial)
>                        folio_read_from_zeromap_fixup()  /* fill zero
> for partially zeromap subpages */
>               if (zwap_partial)
>                        folio_read_from_zswap_fixup()  /* zswap_load
> for partially zswap-mapped subpages */
>
>                folio_mark_uptodate()
>                folio_unlock()
> }
>
> We'd also need to modify folio_read_from_swapfile() to skip
> folio_mark_uptodate()
> and folio_unlock() after completing the BIO. This approach seems to
> entirely disrupt
> the software layers.
>
> This could also lead to unnecessary IO operations for subpages that
> require fixup.
> Since such cases are quite rare, I believe the added complexity isn't wor=
th it.
>
> My point is that we should simply check that all PTEs have consistent zer=
omap,
> zswap, and swapcache statuses before proceeding, otherwise fall back to t=
he next
> lower order if needed. This approach improves performance and avoids comp=
lex
> corner cases.

Agree that we should start with that, although we should probably
fallback to the largest order we can swapin from a single backend,
rather than the next lower order.

>
> So once zswap mTHP is there, I would also expect an API similar to
> swap_zeromap_entries_check()
> for example:
> zswap_entries_check(entry, nr) which can return if we are having
> full, non, and partial zswap to replace the existing
> zswap_never_enabled().

I think a better API would be similar to what Usama had. Basically
take in (entry, nr) and return how much of it is in zswap starting at
entry, so that we can decide the swapin order.

Maybe we can adjust your proposed swap_zeromap_entries_check() as well
to do that? Basically return the number of swap entries in the zeromap
starting at 'entry'. If 'entry' itself is not in the zeromap we return
0 naturally. That would be a small adjustment/fix over what Usama had,
but implementing it with bitmap operations like you did would be
better.

>
> Though I am not sure how cheap zswap can implement it,
> swap_zeromap_entries_check()
> could be two simple bit operations:
>
> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t
> entry, int nr)
> +{
> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> +       unsigned long start =3D swp_offset(entry);
> +       unsigned long end =3D start + nr;
> +
> +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> +               return SWAP_ZEROMAP_NON;
> +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> +               return SWAP_ZEROMAP_FULL;
> +
> +       return SWAP_ZEROMAP_PARTIAL;
> +}
>
> 3. swapcache is different from zeromap and zswap. Swapcache indicates
> that the memory
> is still available and should be re-mapped rather than allocating a
> new folio. Our previous
> patchset has implemented a full re-map of an mTHP in do_swap_page() as me=
ntioned
> in 1.
>
> For the same reason as point 1, partial swapcache is a rare edge case.
> Not re-mapping it
> and instead allocating a new folio would add significant complexity.
>
> > >
> > > Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeromap`=
, we
> > > permit almost all mTHP swap-ins, except for those rare situations whe=
re
> > > small folios that were swapped out happen to have contiguous and alig=
ned
> > > swap slots.
> > >
> > > swapcache is another quite different story, since our user scenarios =
begin from
> > > the simplest sync io on mobile phones, we don't quite care about swap=
cache.
> >
> > Right. The reason I bring this up is as I mentioned above, there is a
> > common problem of forming large folios from different sources, which
> > includes the swap cache. The fact that synchronous swapin does not use
> > the swapcache was a happy coincidence for you, as you can add support
> > mTHP swapins without handling this case yet ;)
>
> As I mentioned above, I'd really rather filter out those corner cases
> than support
> them, not just for the current situation to unlock swap-in series :-)

If they are indeed corner cases, then I definitely agree.

