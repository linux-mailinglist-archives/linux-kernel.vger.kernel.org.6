Return-Path: <linux-kernel+bounces-275565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9A94874A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55551C21ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC212B94;
	Tue,  6 Aug 2024 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QITqXE9x"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF0B65C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910076; cv=none; b=TX1HSCIKRji5QKK9xLww1PzdYC3f/YV1i7Dm+RWV/rBz8R1dHHTD8BYwSCuEcgsTK4t+0jvRpZcNcpvaOGmnclfIOzF3AEa6mJotzNH3tq6hC7wLkQLU/O5DsW9DkIbZVxK6Aabn79wPodr+UYBLGv20eCM8A6f6lzxohG0DAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910076; c=relaxed/simple;
	bh=y8Sq//XPZsqkc+3bL4CNmIbqRRVQ6S+IG9hm/vcGnKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SV6/42rGqVDk887HmB3cXIzTljcjbiWQhFTCSMRjL3bN+ikuDBFf9oR07UwOzHuHe0ncK3t+9XVoQhacB+cdGtoKRZQXRsxMJTTwn25aKsWnPFwCl1cxSjIa4Cy3fa5uk1EKWZICIi+VKpZNv3eylFMcU2TXdbmrnDsq2dhqNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QITqXE9x; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso6407e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722910073; x=1723514873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LARZc07LADq71T7/7gjiP1ItyFSC8ak4cgcFWtYqKus=;
        b=QITqXE9xP2iygSUu41JJoALK/cLjX4+PRIz9LWf0F2M3flq2QOpKwj9QZCOrdhfPQf
         /YUMsg2SU323AUng4RNjgY35nwXJfI2BAEdEJOwcjdt1u57GnCKK+YhgFiv7XCBpn/8u
         eCsrP7tqYSlghb0fyKaOxRPOwGg27Cl18srB7T1eqVQmq6sferyCHL4Zx+63L3lbxdJ7
         COjKzqj2MWJbfKgozeggzV8g3g5yvpPgYzBVK4PMFffOAil+L9HjPgQmo1j1MNy0aRse
         13zhoZmi5toZ/jsMOyM/m87gPqZuW+mAmw8Py+SgmUOtABFeMI9XJzGusRib9hsGOhpl
         u6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910073; x=1723514873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LARZc07LADq71T7/7gjiP1ItyFSC8ak4cgcFWtYqKus=;
        b=wIbDYWPN/n99OvXSgsCkPHzuqIZpXxHOVH8sZ/qk3fQ+bVRh266HgRaMWPw6+LZmSj
         9rpj5Qt1B9X0P0jhEgKquI5KDQ87uRceAyiDVKfGkpxmLDWKDkQDlvGDnslYk0/tQynR
         5AChDIlTYxqyPu4Hqzrs4fD9Oh6V8QEGs1IcWbuLPKDhBNxin3dr7WQrZbiZp/Xob4Fe
         yC0opmOrdvP1rX0k/krBDw35j/CwnSwt/lFhjb7RwF53tEgvPt3LwKw4BVtaF/TfX4Lp
         xraHrEsb+qXerEesFWDxV+KbXH5QEO3KBOrk+MN5oUvPuHLtcLFRIp9rjE7dCDGD8mrU
         aUhw==
X-Forwarded-Encrypted: i=1; AJvYcCW4CPk5+KMzmPblV7di0RpJliHCvieIEwc+m5Ju6AFpPC5WHa54KM+3tKKPl6k1k7n7J+fz+DU8sxpcNC96+so1ca1ULzpidpTb8GCe
X-Gm-Message-State: AOJu0YxydOt08fbszWOVWC5lUOew5WbNbEds9yxOjAt2RtDAEBdRwL15
	45H0Tx9Sk/6XVcJoNqAqeFc8395JgTv2TiCN8b13jHPdbdnUVr7/rnc7YJIHh9fV+PF72i/sBap
	DEQsfBxtRgvv9i/Xj98nNmf/MSfjAJi72
X-Google-Smtp-Source: AGHT+IFIyuATzo+ZeR3WGkUmX/hHU0lijXzN/fAJpO+nJAsrUt8SRJ56SRpxK6Zd9IuzPU8zdX28oW29AZ2TIS4xnvs=
X-Received: by 2002:a05:6122:1ac2:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-4f8a000231fmr16129793e0c.10.1722910073240; Mon, 05 Aug 2024
 19:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805160754.1081-1-justinjiang@vivo.com> <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
 <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com>
In-Reply-To: <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Aug 2024 14:07:42 +1200
Message-ID: <CAGsJ_4zNd5oCG1vpWRJxOQgPRvyO3AbjGM5nt9SxGjm=YTcrdg@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 2:01=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/8/6 6:09, Barry Song =E5=86=99=E9=81=93:
> > On Tue, Aug 6, 2024 at 4:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.c=
om> wrote:
> >> Support mTHP's attempt to free swap entries as a whole, which can avoi=
d
> >> frequent swap_info locking for every individual entry in
> >> swapcache_free_entries(). When the swap_map count values corresponding
> >> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
> >> entries will be freed directly by skippping percpu swp_slots caches.
> >>
> > No, this isn't quite good. Please review the work done by Chris and Kai=
rui[1];
> > they have handled it better. On a different note, I have a patch that c=
an
> > handle zap_pte_range() for swap entries in batches[2][3].
> I'm glad to see your optimized submission about batch freeing swap
> entries for
> zap_pte_range(), sorry, I didn't see it before. My this patch can be
> ignored.

no worries, please help test and review the formal patch I sent:
https://lore.kernel.org/linux-mm/20240806012409.61962-1-21cnbao@gmail.com/

Please note that I didn't use a bitmap to avoid a large stack, and
there is a real possibility of the below can occur, your patch can
crash if the below is true:
nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER

Additionally, I quickly skip the case where
swap_count(data_race(si->swap_map[start_offset]) !=3D 1) to avoid regressio=
ns
in cases that can't be batched.

>
> Thanks
> Zhiguo
>
> >
> > [1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9c1=
48b9297@kernel.org/
> > [2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@gma=
il.com/
> > [3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY=
2AgSxMwTQCj3-8YWw@mail.gmail.com/
> >
> >> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >> ---
> >>   mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 61 insertions(+)
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index ea023fc25d08..829fb4cfb6ec
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_i=
nfo_struct *p, swp_entry_t entry,
> >>          swap_range_free(p, offset, nr_pages);
> >>   }
> >>
> >> +/*
> >> + * Free the contiguous swap entries as a whole, caller have to
> >> + * ensure all entries belong to the same folio.
> >> + */
> >> +static void swap_entry_range_check_and_free(struct swap_info_struct *=
p,
> >> +                                 swp_entry_t entry, int nr, bool *any=
_only_cache)
> >> +{
> >> +       const unsigned long start_offset =3D swp_offset(entry);
> >> +       const unsigned long end_offset =3D start_offset + nr;
> >> +       unsigned long offset;
> >> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) =3D { 0 };
> >> +       struct swap_cluster_info *ci;
> >> +       int i =3D 0, nr_setbits =3D 0;
> >> +       unsigned char count;
> >> +
> >> +       /*
> >> +        * Free and check swap_map count values corresponding to all c=
ontiguous
> >> +        * entries in the whole folio range.
> >> +        */
> >> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
> >> +       ci =3D lock_cluster_or_swap_info(p, start_offset);
> >> +       for (offset =3D start_offset; offset < end_offset; offset++, i=
++) {
> >> +               if (data_race(p->swap_map[offset])) {
> >> +                       count =3D __swap_entry_free_locked(p, offset, =
1);
> >> +                       if (!count) {
> >> +                               bitmap_set(to_free, i, 1);
> >> +                               nr_setbits++;
> >> +                       } else if (count =3D=3D SWAP_HAS_CACHE) {
> >> +                               *any_only_cache =3D true;
> >> +                       }
> >> +               } else {
> >> +                       WARN_ON_ONCE(1);
> >> +               }
> >> +       }
> >> +       unlock_cluster_or_swap_info(p, ci);
> >> +
> >> +       /*
> >> +        * If the swap_map count values corresponding to all contiguou=
s entries are
> >> +        * all zero excluding SWAP_HAS_CACHE, the entries will be free=
d directly by
> >> +        * skippping percpu swp_slots caches, which can avoid frequent=
 swap_info
> >> +        * locking for every individual entry.
> >> +        */
> >> +       if (nr > 1 && nr_setbits =3D=3D nr) {
> >> +               spin_lock(&p->lock);
> >> +               swap_entry_range_free(p, entry, nr);
> >> +               spin_unlock(&p->lock);
> >> +       } else {
> >> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
> >> +                       free_swap_slot(swp_entry(p->type, start_offset=
 + i));
> >> +       }
> >> +}
> >> +
> >>   static void cluster_swap_free_nr(struct swap_info_struct *sis,
> >>                  unsigned long offset, int nr_pages,
> >>                  unsigned char usage)
> >> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, =
int nr)
> >>          if (WARN_ON(end_offset > si->max))
> >>                  goto out;
> >>
> >> +       /*
> >> +        * Try to free all contiguous entries about mTHP as a whole.
> >> +        */
> >> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
> >> +               swap_entry_range_check_and_free(si, entry, nr, &any_on=
ly_cache);
> >> +               goto free_cache;
> >> +       }
> >> +
> >>          /*
> >>           * First free all entries in the range.
> >>           */
> >> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, i=
nt nr)
> >>                  }
> >>          }
> >>
> >> +free_cache:
> >>          /*
> >>           * Short-circuit the below loop if none of the entries had th=
eir
> >>           * reference drop to zero.
> >> --
> >> 2.39.0
> >>
Thanks
Barry

