Return-Path: <linux-kernel+bounces-316474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1696D012
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F192B25214
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACE193089;
	Thu,  5 Sep 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erQbufUP"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71418BC2D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519837; cv=none; b=FtkSzRxRzC7/mraOog0LiwRo3LJLwzGEV6zAGeu0DLNrUu5zJGG6kGEMRXAaIAobpWBgUcmi73MaiciAGbNbCqtIdMPipzomfDwRn8AZBgPkht4K7lFdjRXQ4XAhag92NAw6qWJqUW6hBrR+4AWKXxfhjHZzleSUIRD17K1QYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519837; c=relaxed/simple;
	bh=Cd7XNmlW9MqqhP5qrtViYw8o2PrVf6BaKi7OzsrYujA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYOugKEBxOc3rkV6hfFhVp7LpRedOJkmEksZzTtMgOta64aN9U4TmQzdnEwZGnMzcguanBu0Zz6laTEOtXu/52cWW9fi5iW1ij9AjFD1uAyBreGXbsZYDsPTJcSa7r+QEi+YKvh1K56QlN2THumCc1G0Rr0LMhFxyFfUcEP5dV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erQbufUP; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4fcefbd6bc4so155278e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519834; x=1726124634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER2L0+4siAxGA0mjEF/2tgr84COLH8G/X1oBsGURNq4=;
        b=erQbufUPk1Rw4qS64I+Qygy4yCCB3KyPvFkJQ4Rwn1KqGQJ2WW4C2jLExAtagTSaAI
         S0JqeUw1NVZEbMs9KtynNZSeg51+7v1ammmRlZmeD8Pc5hOel+K7/vKlJJPdoVXer3OW
         g1Rx1IyueAhmyxdhSgHwdLruDwsFlsg+mkyZlaiRGO6FOB1KCFDNjEvXvZOXlllDvZpp
         igoozsir/Tyuuxv99JfnAI6jA22oLHjjMpG2hX+Z+F+02hpi4vxaylms9vDyQBpODFhG
         NODO1qopSi+IhbFMccAK5VSZd9nTew/C3CIWMSDBfwXtKHTwEWzP0465TLO8OS8niqdI
         dYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519834; x=1726124634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER2L0+4siAxGA0mjEF/2tgr84COLH8G/X1oBsGURNq4=;
        b=kMqYVRf91HtL9VIDkOucRz4edBJ58NYGYr2IuvDYV7jQcvkdXJsz99l04d6QPvfJIx
         RaZBzu15oBF5kpb+AyD93yDWa4Fsm19Zcr664gNRuchFyrQ37B3n5xfGRbeCqEcSpmg0
         sIRw6KxXF7bWBJruRDfYE5vW4LvKyTkTj6pzvgLmqOOEsyqG3oA31qrhDz+6Va+avkY6
         g68QjPWxQyMs/hGkAZBewmy9sxV4ao0HhUqeYJ0nbNOwH1aLgG8s7szc8GGuUzseMfp3
         hnx47GRANcxpWWC5LFLCSB9oSirBSV+8GSSqmxMgcNUfan3E7oL+Lx4t7eZ5wn4Td2Ek
         JuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuA/f941bFR/xOY6yQsK9VCLn3YoaExGWdgIFc3SuxkUXxxn1jpky9hnN4gxCqhrQN3HfDiZOL1o3B7U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKVUnG0qgdvDbxzG2+3W+1NDy1JxYHbrQbxcbYtcTRXsexat+
	OW5d9taazkfN4cCAmk+a3LjCEV1A71BQLGCptYogKkAQA/eFsNN7UmVti1yHvadxpF8MOwp+lDZ
	xGH9ri2L30zpAyPVjn9LhkxAjCQg=
X-Google-Smtp-Source: AGHT+IF1ZSvi5OD6Vd1LoKxHOJRg5Vlz1rUm1VAolvT5eKOZLMFg5nbKgw6aWPOezt7qpOYbnciRnVzXId8dKhPTXCQ=
X-Received: by 2002:a05:6122:3296:b0:4f6:b610:61bf with SMTP id
 71dfb90a1353d-5009b0827f9mr20454612e0c.8.1725519834280; Thu, 05 Sep 2024
 00:03:54 -0700 (PDT)
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
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com> <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
In-Reply-To: <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 19:03:42 +1200
Message-ID: <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > > I understand the point of doing this to unblock the synchronous large
> > > folio swapin support work, but at some point we're gonna have to
> > > actually handle the cases where a large folio being swapped in is
> > > partially in the swap cache, zswap, the zeromap, etc.
> > >
> > > All these cases will need similar-ish handling, and I suspect we won'=
t
> > > just skip swapping in large folios in all these cases.
> >
> > I agree that this is definitely the goal. `swap_read_folio()` should be=
 a
> > dependable API that always returns reliable data, regardless of whether
> > `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-in sh=
ouldn't
> > be held back. Significant efforts are underway to support large folios =
in
> > `zswap`, and progress is being made. Not to mention we've already allow=
ed
> > `zeromap` to proceed, even though it doesn't support large folios.
> >
> > It's genuinely unfair to let the lack of mTHP support in `zeromap` and
> > `zswap` hold swap-in hostage.
>

Hi Yosry,

> Well, two points here:
>
> 1. I did not say that we should block the synchronous mTHP swapin work
> for this :) I said the next item on the TODO list for mTHP swapin
> support should be handling these cases.

Thanks for your clarification!

>
> 2. I think two things are getting conflated here. Zswap needs to
> support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What is
> truly, and is outside the scope of zswap/zeromap, is being able to
> support hybrid mTHP swapin.
>
> When swapping in an mTHP, the swapped entries can be on disk, in the
> swapcache, in zswap, or in the zeromap. Even if all these things
> support mTHPs individually, we essentially need support to form an
> mTHP from swap entries in different backends. That's what I meant.
> Actually if we have that, we may not really need mTHP swapin support
> in zswap, because we can just form the large folio in the swap layer
> from multiple zswap entries.
>

After further consideration, I've actually started to disagree with the ide=
a
of supporting hybrid swapin (forming an mTHP from swap entries in different
backends). My reasoning is as follows:

1. The scenario where an mTHP is partially zeromap, partially zswap, etc.,
would be an extremely rare case, as long as we're swapping out the mTHP as
a whole and all the modules are handling it accordingly. It's highly
unlikely to form this mix of zeromap, zswap, and swapcache unless the
contiguous VMA virtual address happens to get some small folios with
aligned and contiguous swap slots. Even then, they would need to be
partially zeromap and partially non-zeromap, zswap, etc.

As you mentioned, zeromap handles mTHP as a whole during swapping
out, marking all subpages of the entire mTHP as zeromap rather than just
a subset of them.

And swap-in can also entirely map a swapcache which is a large folio based
on our previous patchset which has been in mainline:
"mm: swap: entirely map large folios found in swapcache"
https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.com/

It seems the only thing we're missing is zswap support for mTHP.

2. Implementing hybrid swap-in would be extremely tricky and could disrupt
several software layers. I can share some pseudo code below:

swap_read_folio()
{
       if (zeromap_full)
               folio_read_from_zeromap()
       else if (zswap_map_full)
              folio_read_from_zswap()
       else {
              folio_read_from_swapfile()
              if (zeromap_partial)
                       folio_read_from_zeromap_fixup()  /* fill zero
for partially zeromap subpages */
              if (zwap_partial)
                       folio_read_from_zswap_fixup()  /* zswap_load
for partially zswap-mapped subpages */

               folio_mark_uptodate()
               folio_unlock()
}

We'd also need to modify folio_read_from_swapfile() to skip
folio_mark_uptodate()
and folio_unlock() after completing the BIO. This approach seems to
entirely disrupt
the software layers.

This could also lead to unnecessary IO operations for subpages that
require fixup.
Since such cases are quite rare, I believe the added complexity isn't worth=
 it.

My point is that we should simply check that all PTEs have consistent zerom=
ap,
zswap, and swapcache statuses before proceeding, otherwise fall back to the=
 next
lower order if needed. This approach improves performance and avoids comple=
x
corner cases.

So once zswap mTHP is there, I would also expect an API similar to
swap_zeromap_entries_check()
for example:
zswap_entries_check(entry, nr) which can return if we are having
full, non, and partial zswap to replace the existing
zswap_never_enabled().

Though I am not sure how cheap zswap can implement it,
swap_zeromap_entries_check()
could be two simple bit operations:

+static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t
entry, int nr)
+{
+       struct swap_info_struct *sis =3D swp_swap_info(entry);
+       unsigned long start =3D swp_offset(entry);
+       unsigned long end =3D start + nr;
+
+       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
+               return SWAP_ZEROMAP_NON;
+       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
+               return SWAP_ZEROMAP_FULL;
+
+       return SWAP_ZEROMAP_PARTIAL;
+}

3. swapcache is different from zeromap and zswap. Swapcache indicates
that the memory
is still available and should be re-mapped rather than allocating a
new folio. Our previous
patchset has implemented a full re-map of an mTHP in do_swap_page() as ment=
ioned
in 1.

For the same reason as point 1, partial swapcache is a rare edge case.
Not re-mapping it
and instead allocating a new folio would add significant complexity.

> >
> > Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeromap`, =
we
> > permit almost all mTHP swap-ins, except for those rare situations where
> > small folios that were swapped out happen to have contiguous and aligne=
d
> > swap slots.
> >
> > swapcache is another quite different story, since our user scenarios be=
gin from
> > the simplest sync io on mobile phones, we don't quite care about swapca=
che.
>
> Right. The reason I bring this up is as I mentioned above, there is a
> common problem of forming large folios from different sources, which
> includes the swap cache. The fact that synchronous swapin does not use
> the swapcache was a happy coincidence for you, as you can add support
> mTHP swapins without handling this case yet ;)

As I mentioned above, I'd really rather filter out those corner cases
than support
them, not just for the current situation to unlock swap-in series :-)

Thanks
Barry

