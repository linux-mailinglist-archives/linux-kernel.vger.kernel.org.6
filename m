Return-Path: <linux-kernel+bounces-275820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CF948AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B8D285D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44816A38B;
	Tue,  6 Aug 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY21f8/m"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D042AA0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930760; cv=none; b=bVRpQnSvkcn10okKYyjFar/w8GBGu3mW55gpTc82ee5XRYShQ/tCyqx0RsPN7XoYC/P9in2CVCeJUz5CyzNt47ClUSK69RQX4vTmpm8B+cBd4XxWZwoueRyZXrnTOzBO8ykpIXE2Ot4CtoA4JUWDIODd/ZxtAVJ7UYfhTEMu9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930760; c=relaxed/simple;
	bh=W46sfGkCg5TXW/tPmGtmJVEaIloexs8eViRXYEkMuDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKick7as61ZlbNU/jcTml4F+BfXMdcJPjuU7vNpShmtWelULOY+TgCu3awhg0mgF52M7Jsos+WsnNsKvjaQtJ7lnF31WW21UQYNBtgFDNeXMpjp3L35EiLf7aiA/Tr+s3hEco6vhM2TQ89Te+UEkVW1n6mPFvyNHbIxgM0GWqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY21f8/m; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4928b5531caso91300137.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722930757; x=1723535557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+BMV7JIbQUusmGWs3G2FWkoSXMZXCoYjDo6gEhMjvs=;
        b=WY21f8/mnEw4O4DalerAqS1E+W3JOgHD1g2vKrsOOeZonQ04zk1YwEChchqJsfki6K
         BhUlRsTAq7fzjciaF9avmT90rETHAIsDEqOLDdpJNdYQhENJkHHiOJk749vHR7pTzRAE
         A19nPk3D0ugC7aigxpS/7o3NvSrkay2T34xBoh5yeQ79Si7gMdC7dSV1Dhu9RgTqQWha
         oop0a9NDvy+jn1v6V/qTjXUC9/4Rg++b4YaUP88+QWReMDZGmORFjym9PxCwlyn71vZh
         bsNFEuxdIyVcG2X433T3gS8I9spjcnzMv9sLVNiX/epDBOQQyVQbRY+wpVZ9ns2BT8DJ
         dKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722930757; x=1723535557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+BMV7JIbQUusmGWs3G2FWkoSXMZXCoYjDo6gEhMjvs=;
        b=vryMt8fp8RMc6iqy1AcNgM9FfYnUXUOw3UvJKIBdCnUkwJpZxjATosm2gic8L+48UU
         FK9klgJL+5WF3CWnN9mIu6ic4mFIHjTTCMUSIY0gngTWz6t+3U9xM3eVmJUgbnG437g9
         0nsHoHucU38sk/0/cvoQdhTRQwF5pUYkKvkdROoZxKqiUxFxlfpKtbApUgGriFG6lgNk
         NJsrPMAxJx6qAV2022VgOoPEKkzriHczSZZZrmcyg+r7gxZyS1nvQv4IKGAgVgU+akun
         LWiyFbd0P9iAAkXQrfMxoV+Quk+aqwgxpbgass9zBLR2NF2sLZ4gLV2SnOj/+fVLDd3+
         XrqA==
X-Forwarded-Encrypted: i=1; AJvYcCUTAYO8HZT2blzf8K7c+dajCIl17Ee0fXAfiuiWyQMnbKVcgQ1upAhiFsgzaPDnRqgbELJbH3yjW5KZW2SpLNM/p+Rn5IF5pdcJ7CER
X-Gm-Message-State: AOJu0Yy22kFgslN81E5P256HHmHYtmLWlliEcRd2SRsTiKHC/icZRUkN
	MUb1hI2zMD0xHeCs4VZixjtxLitYuhpQjq5BnFlwfUSW8CtNRT8Ol2BpzJtb7TL7InMGme9n3BI
	LIZsHOWyxWNi3+0q4EiKcte949TY=
X-Google-Smtp-Source: AGHT+IE+FyQeHN/+z0uQcUpNIQhULv9TGeWwJ7SiTpn4s9xqXvxUyqjCBlfUZ6u5aT4IjIp9oaGnyrx4+SFxRBuWQdI=
X-Received: by 2002:a05:6102:304a:b0:493:e1ba:123b with SMTP id
 ada2fe7eead31-4945be42978mr17412048137.16.1722930757383; Tue, 06 Aug 2024
 00:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805160754.1081-1-justinjiang@vivo.com> <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
 <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com> <CAGsJ_4zNd5oCG1vpWRJxOQgPRvyO3AbjGM5nt9SxGjm=YTcrdg@mail.gmail.com>
 <dee6bf7c-ae73-435b-a6d5-ae966dfec048@vivo.com>
In-Reply-To: <dee6bf7c-ae73-435b-a6d5-ae966dfec048@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Aug 2024 14:48:26 +0800
Message-ID: <CAGsJ_4zC10LK+r9ugutiu3ys1HcrpRMzD-m8YYJ1ALbo-Fdyow@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 3:41=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/8/6 10:07, Barry Song =E5=86=99=E9=81=93:
> > On Tue, Aug 6, 2024 at 2:01=E2=80=AFPM zhiguojiang <justinjiang@vivo.co=
m> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/8/6 6:09, Barry Song =E5=86=99=E9=81=93:
> >>> On Tue, Aug 6, 2024 at 4:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo=
.com> wrote:
> >>>> Support mTHP's attempt to free swap entries as a whole, which can av=
oid
> >>>> frequent swap_info locking for every individual entry in
> >>>> swapcache_free_entries(). When the swap_map count values correspondi=
ng
> >>>> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
> >>>> entries will be freed directly by skippping percpu swp_slots caches.
> >>>>
> >>> No, this isn't quite good. Please review the work done by Chris and K=
airui[1];
> >>> they have handled it better. On a different note, I have a patch that=
 can
> >>> handle zap_pte_range() for swap entries in batches[2][3].
> >> I'm glad to see your optimized submission about batch freeing swap
> >> entries for
> >> zap_pte_range(), sorry, I didn't see it before. My this patch can be
> >> ignored.
> > no worries, please help test and review the formal patch I sent:
> > https://lore.kernel.org/linux-mm/20240806012409.61962-1-21cnbao@gmail.c=
om/
> I believe it's ok and valuable.  Looking forward to being merged soon.

Zhiguo, you are absolutely breaking lkml in another thread.
https://lore.kernel.org/linux-mm/b2ea5b52-311d-4c6c-a59d-9982b8723738@vivo.=
com/

Allow me to address your question from that thread here:

> +       /* cross into another cluster */
> +       if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> +               return false;
> My understand of mTHP swap entries alloced by by cluster_alloc_swap()
> is that they belong to the same cluster in the same swapinfo , so
> theoretically it will not appear for
> (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)?
> Can you help confirm?

zap_pte_range() could have no concept of folios (mTHP) as folios could have
gone. you could have the case:

folio1:  last 16 slots of cluster1
folio2:  first 16 slots of cluster2.

folio1 and folio2 are within the same PMD and virtually contiguous
before they are unmapped.

when both folio1 and folio2 have been released and all 32 PTEs are swap
entries, zap_pte_range() 's

nr =3D swap_pte_batch(pte, max_nr, ptent);

nr will be 32.  "mTHP swap entries alloced by by cluster_alloc_swap() belon=
g
to the same cluster" is correct, but when you zap_pte_range(), your mTHPs
could have been freed. swap_pte_batch() just returns the number of swap
entries. These 32 entries are crossing the boundary of one cluster.

> >
> > Please note that I didn't use a bitmap to avoid a large stack, and
> > there is a real possibility of the below can occur, your patch can
> > crash if the below is true:
> > nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER
> >
> > Additionally, I quickly skip the case where
> > swap_count(data_race(si->swap_map[start_offset]) !=3D 1) to avoid regre=
ssions
> > in cases that can't be batched.
> >
> >> Thanks
> >> Zhiguo
> >>
> >>> [1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9=
c148b9297@kernel.org/
> >>> [2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@g=
mail.com/
> >>> [3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2=
qY2AgSxMwTQCj3-8YWw@mail.gmail.com/
> >>>
> >>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >>>> ---
> >>>>    mm/swapfile.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 61 insertions(+)
> >>>>
> >>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>>> index ea023fc25d08..829fb4cfb6ec
> >>>> --- a/mm/swapfile.c
> >>>> +++ b/mm/swapfile.c
> >>>> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap=
_info_struct *p, swp_entry_t entry,
> >>>>           swap_range_free(p, offset, nr_pages);
> >>>>    }
> >>>>
> >>>> +/*
> >>>> + * Free the contiguous swap entries as a whole, caller have to
> >>>> + * ensure all entries belong to the same folio.
> >>>> + */
> >>>> +static void swap_entry_range_check_and_free(struct swap_info_struct=
 *p,
> >>>> +                                 swp_entry_t entry, int nr, bool *a=
ny_only_cache)
> >>>> +{
> >>>> +       const unsigned long start_offset =3D swp_offset(entry);
> >>>> +       const unsigned long end_offset =3D start_offset + nr;
> >>>> +       unsigned long offset;
> >>>> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) =3D { 0 };
> >>>> +       struct swap_cluster_info *ci;
> >>>> +       int i =3D 0, nr_setbits =3D 0;
> >>>> +       unsigned char count;
> >>>> +
> >>>> +       /*
> >>>> +        * Free and check swap_map count values corresponding to all=
 contiguous
> >>>> +        * entries in the whole folio range.
> >>>> +        */
> >>>> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
> >>>> +       ci =3D lock_cluster_or_swap_info(p, start_offset);
> >>>> +       for (offset =3D start_offset; offset < end_offset; offset++,=
 i++) {
> >>>> +               if (data_race(p->swap_map[offset])) {
> >>>> +                       count =3D __swap_entry_free_locked(p, offset=
, 1);
> >>>> +                       if (!count) {
> >>>> +                               bitmap_set(to_free, i, 1);
> >>>> +                               nr_setbits++;
> >>>> +                       } else if (count =3D=3D SWAP_HAS_CACHE) {
> >>>> +                               *any_only_cache =3D true;
> >>>> +                       }
> >>>> +               } else {
> >>>> +                       WARN_ON_ONCE(1);
> >>>> +               }
> >>>> +       }
> >>>> +       unlock_cluster_or_swap_info(p, ci);
> >>>> +
> >>>> +       /*
> >>>> +        * If the swap_map count values corresponding to all contigu=
ous entries are
> >>>> +        * all zero excluding SWAP_HAS_CACHE, the entries will be fr=
eed directly by
> >>>> +        * skippping percpu swp_slots caches, which can avoid freque=
nt swap_info
> >>>> +        * locking for every individual entry.
> >>>> +        */
> >>>> +       if (nr > 1 && nr_setbits =3D=3D nr) {
> >>>> +               spin_lock(&p->lock);
> >>>> +               swap_entry_range_free(p, entry, nr);
> >>>> +               spin_unlock(&p->lock);
> >>>> +       } else {
> >>>> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
> >>>> +                       free_swap_slot(swp_entry(p->type, start_offs=
et + i));
> >>>> +       }
> >>>> +}
> >>>> +
> >>>>    static void cluster_swap_free_nr(struct swap_info_struct *sis,
> >>>>                   unsigned long offset, int nr_pages,
> >>>>                   unsigned char usage)
> >>>> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry=
, int nr)
> >>>>           if (WARN_ON(end_offset > si->max))
> >>>>                   goto out;
> >>>>
> >>>> +       /*
> >>>> +        * Try to free all contiguous entries about mTHP as a whole.
> >>>> +        */
> >>>> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
> >>>> +               swap_entry_range_check_and_free(si, entry, nr, &any_=
only_cache);
> >>>> +               goto free_cache;
> >>>> +       }
> >>>> +
> >>>>           /*
> >>>>            * First free all entries in the range.
> >>>>            */
> >>>> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry,=
 int nr)
> >>>>                   }
> >>>>           }
> >>>>
> >>>> +free_cache:
> >>>>           /*
> >>>>            * Short-circuit the below loop if none of the entries had=
 their
> >>>>            * reference drop to zero.
> >>>> --
> >>>> 2.39.0
> >>>>
Thanks
 Barry

