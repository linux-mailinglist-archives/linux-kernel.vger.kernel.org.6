Return-Path: <linux-kernel+bounces-383824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FA9B2096
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E4A281DC4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0418452C;
	Sun, 27 Oct 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1kC6X2fp"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B44184523
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062342; cv=none; b=oLErW9LCngE3DT0mb5zWGL442kuEkiyOOg1lx+TkWmy9hgl5/lK+7E67cwaNz4fuxGPMz2ZPvaBVhU/ZMGImk9B8EifbIDuVaoz6Z5nG0AD50tHZmVAt1kqPBi9JbPKGf1eDWQKEhs39OZ3B7/kW/7IDnOvcB0cxs6tW7sWkLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062342; c=relaxed/simple;
	bh=N0DqaZmpk0rEOuzCN40mdzN7BdQa9w98Srl8UsV7hRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMGm0eHdOHOgr8h7kOsfNhChvIpcVeeugK4c7KLOBQrefdhTrGAomC7acWj1RfLHrfk/mLZvba9KFugDjy4FQqT6mNzbbHM3iPp1GCN2aLE32nPQlHQMVKYEzflbwTI1z1oVV9Kl+6fNgPYzad3vmdN6iSH1zfiw69qxC+8vc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1kC6X2fp; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a47cdaf158so1230842137.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730062339; x=1730667139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEP1aXwx4Opc5UBPmeJH/5/ytNpBnKvXGednu8gjFqE=;
        b=1kC6X2fpjiE3KGvhMjWRFTJ6XUy80dBo4LABgjMOfa1d6PLpOxh1AE166vSSoqvDQr
         xpA4cDM6XFZebSKQkU+LX8OTouXzL6pYG27pqXnxHT9dXgZ0s32reuyLPG7s8NrjMgvc
         EYzIdnhMKXWB+3ndz/QLd1a554Yj1XQtTaUAlTQlQqfSHapuTMNCz9+s1p3E3nhi0T4r
         KcHy8SdOrugqScADDtNZk3bmN40w+/3fFBxbU5IVz29enuJaciF4neT5ETzQixQjTgY3
         dzhZe6M4fDBFnGmINUDVwRq0AyCRlYLbHYL/tavbA1HgtQy6LDDmXEqwDZgxlE2PqGuP
         4Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730062339; x=1730667139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEP1aXwx4Opc5UBPmeJH/5/ytNpBnKvXGednu8gjFqE=;
        b=Jcn1A6sPiir6PBA0pv9ITMrtyp+kA57WZFJX/00qfn24uZXHl+4W6ypV/XsT8aHwUu
         7roAOGsEE/HCcKw3xvd1M18DY8UX/uKHi4EF52XAB6K7smPlN+oXYa/5fb5DqvMTJDB+
         nL8bOXaf1D/gHrOCQ1vwqpEjhYc29odkn4GYLNQzemwN2Y2NvRwF+UJ62eBNRZqpVY//
         WhHqmH251ZEp2XMCeCeMjodvRzl7OYhd1MmIPUxkapRmlUkRfJK3XlVJq7bFyLnrhWeE
         l4lCV0jQ3jFQkBiEzb/ssC22sHa6BcFM4ltESyIdbXk1iGbFXoHtCrygnnMDQ3zUT64E
         Benw==
X-Forwarded-Encrypted: i=1; AJvYcCX46C5LenO+5VU74yRad8jH/8uMQznVjI8Ablh2faQxu8czbdF+9HaLXiGLrD5299XqXJJkyA6EbR+KOcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+29KSrQM9hIpo9zJF3bN1nk8jJU49r9bfEMqKiiQzokIHnZv9
	kzlzoZDJt7fbjUYAqeKf6WkdSUTYhj1uNHxiR14zMFX9W/6bWbTSdpmTbXYCtWoLc5wIHMab+A1
	aOINuZfY9DpjhszYSbM58MuyJiVvq5zkCro1P
X-Google-Smtp-Source: AGHT+IET90x0oUx9agpRnmE/iqRubOv9iCKU3Om1nVjpljKzJxZlCuH6iPVL7k9m2OXVXjAB/kD+AUOPM+Sdm67QaUM=
X-Received: by 2002:a05:6102:dcf:b0:4a3:e1de:4fd8 with SMTP id
 ada2fe7eead31-4a8cfd6d8b3mr4094664137.26.1730062339318; Sun, 27 Oct 2024
 13:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
 <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com> <8459b884-5877-41bd-a882-546e046b9dad@suse.cz>
In-Reply-To: <8459b884-5877-41bd-a882-546e046b9dad@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 27 Oct 2024 14:51:42 -0600
Message-ID: <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Matt Fleming <mfleming@cloudflare.com>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 2:36=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/27/24 21:17, Yu Zhao wrote:
> > On Sun, Oct 27, 2024 at 1:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/26/24 05:36, Yu Zhao wrote:
> >> > OOM kills due to vastly overestimated free highatomic reserves were
> >> > observed:
> >> >
> >> >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE),=
 order=3D0 ...
> >> >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB h=
igh:1068392kB reserved_highatomic:1073152KB ...
> >> >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (=
ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M)=
 0*2048kB 0*4096kB =3D 1477408kB
> >> >
> >> > The second line above shows that the OOM kill was due to the followi=
ng
> >> > condition:
> >> >
> >> >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB < =
min (410416kB)
> >> >
> >> > And the third line shows there were no free pages in any
> >> > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> >> > 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> >> > usable free memory by over 1GB, which resulted in the unnecessary OO=
M
> >> > kill above.
> >> >
> >> > The comments in __zone_watermark_unusable_free() warns about the
> >> > potential risk, i.e.,
> >> >
> >> >   If the caller does not have rights to reserves below the min
> >> >   watermark then subtract the high-atomic reserves. This will
> >> >   over-estimate the size of the atomic reserve but it avoids a searc=
h.
> >> >
> >> > However, it is possible to keep track of free pages in reserved
> >> > highatomic pageblocks with a new per-zone counter nr_free_highatomic
> >> > protected by the zone lock, to avoid a search when calculating the
> >>
> >> It's only possible to track this reliably since the "mm: page_alloc:
> >> freelist migratetype hygiene" patchset was merged, which explains why
> >> nr_reserved_highatomic was used until now, even if it's imprecise.
> >
> > I just refreshed my memory by quickly going through the discussion
> > around that series and didn't find anything that helps me understand
> > the above. More pointers please?
>
> For example:
>
> - a page is on pcplist in MIGRATE_MOVABLE list
> - we reserve its pageblock as highatomic, which does nothing to the page =
on
> the pcplist
> - page above is flushed from pcplist to zone freelist, but it remembers i=
t
> was MIGRATE_MOVABLE, merges with another buddy/buddies from the
> now-highatomic list, the resulting order-X page ends up on the movable
> freelist despite being in highatomic pageblock. The counter of free
> highatomic is now wrong wrt the freelist reality

This is the part I don't follow: how is it wrong w.r.t. the freelist
reality? The new nr_free_highatomic should reflect how many pages are
exactly on free_list[MIGRATE_HIGHATOMIC], because it's updated
accordingly.

(My current understanding is that, in this case, the reservation
itself is messed up, i.e., under-reserved.)

> The series has addressed various scenarios like that, where page can end =
up
> on the wrong freelist.

