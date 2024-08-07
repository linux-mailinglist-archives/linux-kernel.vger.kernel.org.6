Return-Path: <linux-kernel+bounces-277680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D3694A4AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0121C2122A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214081D1755;
	Wed,  7 Aug 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PszgX3jk"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FB1D1738
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024120; cv=none; b=NMPsdE1u9Wu+wYvLSZDTMEaJvL3lku4ZrUvncvI0MQrEdAD01K+7cZ2kKEMtyhZCwBbFyWVZB7OoZcJSr7En8WjeYcsl00x5fwu9igbr5oPMGXBYQ4UO1nayTXntOI+B2nbFDFhSnUeWElN9tWMvfMV+PcQhXvUdEKsZ2p3Z1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024120; c=relaxed/simple;
	bh=oS9PlaTG2KJJXcpNsxPJAEIHjUqMGdeFoGGoR1XQEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7kEGpsoJwEACHInxEW6u31pCYmC9MtBk4T4utgnIRn4MriPCIOV1dvy5DF12LtFxxsGLOalkwWppA3QWT4ho5TA61la3tKxrhq4SZnUCAAtrsMcw0YN8vLi4ud21aSoQRcRs11ZwJ7F12G5OmRHzgEEdX2FB3kwABa+Tw4LD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PszgX3jk; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f8b5e4c631so655860e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024117; x=1723628917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQZMOSwX7KEJDubp4fDjRX7jlDArEA2WNg5TRM2M4RY=;
        b=PszgX3jk4BQmsoyNbOKhjd2kucq6TVptnhKz9dyW4+0NY7QweSUvsMWD1UhBX1pIZ3
         MThqjQDsnneLXEqsSyfm3FpXJof8Q8M2mdkE0l4qEYaFPmZZGUzfiqmdj1Mc6/C4diWP
         Flz/79MKdDbeNXFwFs+rZYI6Nn5hohWeCLDN86H5p2JDMmIf4vmylz8PNPo0OA2q/o6h
         +gJhJfPQA8e6Kq7VgsjwEq1VxyeZ4e69D+bnR2/e2kn4Z6hyAz2FlU7ZjVbvwWTa+BuM
         yRt2BJmmYLKZ/euyoBGjQ+rmOqmy2ZpkOSTt4ZbQO5hfNNGS+8psO7bElBl48j9Q0sWh
         GiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024117; x=1723628917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQZMOSwX7KEJDubp4fDjRX7jlDArEA2WNg5TRM2M4RY=;
        b=mZKEbdCqtwkBjVe/XQvRJPkG3VeyDrhTObH3Pm8uo3aHsCOi3Jzyh/4dFe8oxUfmfz
         6+ywVaEtD80UO2WiMXiJ5QR25+PtyJrbdQ5cgjeZ+EWLSsvpz3KAHaizG8vDOnXRgilG
         Gqx2aGegXEL/EFKUvAZin69GRKALOMMoHslg4svQlTiemKT6vApyZZf43xv5a8Cbs4Bn
         yQg3NZrpbdJ0ipXS4ECDiZJS1a9HN81CW7OLZfoJZx8Z/L5/c4bO7saoIId69jyb0mD/
         T/Afh5yPJ6qx+fvRh+ogvzTU4cx77U1YxqZFiKN4IdIZzlAjV5bTtmnxI9A48rr/dpKS
         4tHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIySOv+9mp/ibxZhzf9hzZEw+y33LhEFgTmw2/JXjP1I5INQ0A5iZ/u1bVYLhDDKceC76Nz+mSSifNJpOfDtYZm9C8Ok9Ilg+QZ/dR
X-Gm-Message-State: AOJu0YzCpiDildtDa3lh9+eSm9ZxZGW02vu9BJDpHQACwZ9Vht01e5Hg
	PJ9rEQ0rDN+hyeMaMBaGMGFGxILgSl3xLH3mRcsb2Zbg3CcGXqc/yMrTl5K6HHcpHZhT1yM1LH4
	d0AHFd/lSywtucnnzJQPK0LKtCWI=
X-Google-Smtp-Source: AGHT+IEQCV41iJa5cSGW16p8f8MY33Y3k5hKMIGhD7WtuSdaGah+PLqXFDZZGOzLQs4a9PIdgkhtv/tSIROcvabHC8A=
X-Received: by 2002:a05:6122:2090:b0:4f6:ae65:1e10 with SMTP id
 71dfb90a1353d-4f89ff60bb5mr22999801e0c.4.1723024117528; Wed, 07 Aug 2024
 02:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807082508.358322-1-21cnbao@gmail.com> <20240807082508.358322-3-21cnbao@gmail.com>
 <e50abade-c44e-41d4-b7bf-b9d54920e2a4@redhat.com>
In-Reply-To: <e50abade-c44e-41d4-b7bf-b9d54920e2a4@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 21:48:24 +1200
Message-ID: <CAGsJ_4zFfnwc1kstNO53gdeUzzon5_tamDcC-mTUUS_PQEjF0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: attempt to batch free swap entries for zap_pte_range()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, justinjiang@vivo.com, 
	chrisl@kernel.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:29=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> >   mm/swapfile.c | 78 +++++++++++++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 67 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 35cb58373493..25c3f98fa8d5 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_str=
uct *si,
> >       return true;
> >   }
> >
> > +static bool swap_is_last_map(struct swap_info_struct *si,
> > +                           unsigned long offset, int nr_pages,
> > +                           bool *has_cache)
>
> Please use double tabs for indenting parameters on 2nd line on
> new/changed code:
>
>                 unsigned long offset, int nr_pages, bool *has_cache)
>
> Results in less churn when renaming functions and we can frequently
> avoid some lines.

ack.

>
> > +{
> > +     unsigned char *map =3D si->swap_map + offset;
> > +     unsigned char *map_end =3D map + nr_pages;
> > +     bool cached =3D false;
> > +
> > +     do {
> > +             if ((*map & ~SWAP_HAS_CACHE) !=3D 1)
> > +                     return false;
> > +             if (*map & SWAP_HAS_CACHE)
> > +                     cached =3D true;
> > +     } while (++map < map_end);
> > +
> > +     *has_cache =3D cached;
> > +     return true;
> > +}
> > +
> >   /*
> >    * returns number of pages in the folio that backs the swap entry. If=
 positive,
> >    * the folio was reclaimed. If negative, the folio was not reclaimed.=
 If 0, no
> > @@ -1469,6 +1488,53 @@ static unsigned char __swap_entry_free(struct sw=
ap_info_struct *si,
> >       return usage;
> >   }
> >
> > +static bool __swap_entries_free(struct swap_info_struct *si,
> > +                             swp_entry_t entry, int nr)
>
> Dito.

ack.

>
> > +{
> > +     unsigned long offset =3D swp_offset(entry);
> > +     unsigned int type =3D swp_type(entry);
> > +     struct swap_cluster_info *ci;
> > +     bool has_cache =3D false;
> > +     unsigned char count;
> > +     bool can_batch;
> > +     int i;
> > +
> > +     if (nr <=3D 1 || swap_count(data_race(si->swap_map[offset])) !=3D=
 1)
> > +             goto fallback;
> > +     /* cross into another cluster */
> > +     if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> > +             goto fallback;
> > +
> > +     ci =3D lock_cluster_or_swap_info(si, offset);
> > +     can_batch =3D swap_is_last_map(si, offset, nr, &has_cache);
> > +     if (can_batch) {
> > +             for (i =3D 0; i < nr; i++)
> > +                     WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CAC=
HE);
> > +     }
> > +     unlock_cluster_or_swap_info(si, ci);
> > +
> > +     if (!can_batch)
> > +             goto fallback;
>
> I'd avoid "can_batch" and just do:
>
> ci =3D lock_cluster_or_swap_info(si, offset);
> if (!swap_is_last_map(si, offset, nr, &has_cache)) {
>         unlock_cluster_or_swap_info(si, ci);
>         goto fallback;
> }
> for (i =3D 0; i < nr; i++)
>         WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
> unlock_cluster_or_swap_info(si, ci);

ack.

>
> > +     if (!has_cache) {
> > +             spin_lock(&si->lock);
>
> I'm no expert on that code, but we might drop the cluster lock the take
> the swap_info lock and then retake the cluster lock. I assume there are
> no races we are worrying about here, right?

I suppose so. Even the original single-entry code follows the same pattern:

static unsigned char __swap_entry_free(struct swap_info_struct *p,
       swp_entry_t entry)
{
         struct swap_cluster_info *ci;
         unsigned long offset =3D swp_offset(entry);
         unsigned char usage;

         ci =3D lock_cluster_or_swap_info(p, offset);
         usage =3D __swap_entry_free_locked(p, offset, 1);
         unlock_cluster_or_swap_info(p, ci);
         if (!usage)
                  free_swap_slot(entry);

         return usage;
}

I assume that once we mark them as SWAP_HAS_CACHE, no one else
will touch them except ourselves.

>
> > +             swap_entry_range_free(si, entry, nr);
> > +             spin_unlock(&si->lock);
> > +     }
> > +     return has_cache;
> > +
> > +fallback:
> > +     for (i =3D 0; i  < nr; i++) {
>
> One space too much before the "<".

ack.

>
> > +             if (data_race(si->swap_map[offset + i])) {
> > +                     count =3D __swap_entry_free(si, swp_entry(type, o=
ffset + i));
> > +                     if (count =3D=3D SWAP_HAS_CACHE)
> > +                             has_cache =3D true;
> > +             } else {
> > +                     WARN_ON_ONCE(1);
> > +             }
> > +     }
> > +     return has_cache;
> > +}
> > +
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

