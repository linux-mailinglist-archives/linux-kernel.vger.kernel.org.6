Return-Path: <linux-kernel+bounces-521377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3677A3BC76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6966188A131
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD11DED4C;
	Wed, 19 Feb 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh8LXQmh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060741D6DC5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963549; cv=none; b=jDjkL/PVXQObAV8T6X884YR+90BYXd6BhtEw/eVeSjP3ELpdjcOXa3hQEnfNFxyP0QUOeZxrkUDTdO+JSDnd4uyYwoaNuAtbl8YebXdO/O63rTX0lR0aUXiwL2YaiF6FRIAxqDyeLHPlva3Hh+Q0QP1zqXvjANc58Wnezq3PXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963549; c=relaxed/simple;
	bh=05wPe3cw+xRXtP8CeicLMvDEt/WTvI8J+LFEVP/pSqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM9q5anaHzLJGuqKy2c0BkSox1gP4OUXjP/TInu6rswAUZ41rcQaOEfpWw8UGK+R7bwIa9/7t8NRn3N4rFJwte20ztcILjU6vEuEhggQyjUkde5+nGtLH/OeiQzC850W/Y0A/0jnfnoot0iYnoCdWyZjdjrfKTw7BDLn7LxLp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh8LXQmh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3072f8dc069so68982941fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739963545; x=1740568345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iag4w9SsMVvgB6MNxayB0k1msEVHqRD+5sp/2ZHKru8=;
        b=Zh8LXQmh4TDINWTC7pfvFNg4rVCZuodH/KIhbrLefLpBIC/3sDWQWuu3QyKZQcDZgG
         iBkaXMX+XAKobJF13jc5scnobUhp+W1b+BbKmvv5fODuUlM8RvXD6/3RhyLFaosw4cmR
         98BYBif64gZgBNxKORW+niUH/bHEc0XPY8qUFK/MUI8cMuSNmEESUPAVtAxOIYS++N/W
         eKQ3vouDQ8kA36CMa9xwBJS7rPCjbqrCpQMLPszjOnfD/X9CZL4/4K8eq8bTLYXZrt0I
         /sbA0k1KMRwTb3u6HfKBkw4NOeioHKE/CAaFrUsBlJGvJrtNJHJizYz/C0i9pAkH98Em
         xzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963545; x=1740568345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iag4w9SsMVvgB6MNxayB0k1msEVHqRD+5sp/2ZHKru8=;
        b=hjuNgSGxARAiZJgov9jvaK/TY1JeJgYiiG2mWDhZHweJoUKEVylAHhN4abNDTC/GJm
         jm9kiEcVG1/adBs7IFibiKu0aznvDVK1kOp8APwtbaFwDn7tpBcorOGy1Yc+Oy+076Ga
         MhDK9fGF6uVz3ykFgpTlI3IF+N8wxfDN+zPxnWrxFkZD8ZvqPuTY4wK4j8n+iaLWB7tF
         3KP2Z5nbTyNxkxiMBtx6xi3x3w/YwxFfa9HExOzTANeK048MpMnzcLqWy/3lSrioRLK5
         SvnSKLejtoGJwP4oq6AvmOzr6ktmU3CED0mqCCc3Y9TqRMoAH0oczjQefOMlAOaaZGRi
         +QNw==
X-Forwarded-Encrypted: i=1; AJvYcCWIlG3P7KlZlKQaalrxj0bxyNK6cl3ZcegxKKS3bDrHbAf5g2cxtOEmcozdg/TKEYLt1F5ji898UlcWPZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggjSBlOjuaBS+okNCkbc2F66et6przJjG2MR5p6XirbE16PH0
	PLiIuWrhBovQT139kknjswbcraegzptkM4EVw4BD6aTFpC0dDdOdAL5KwcDZqaUO6Y2jrXYahxH
	5/4nkVm1TjIESl7KwFmhUReeBdSc=
X-Gm-Gg: ASbGnctAeNM8jKpcVEtTcjQtr/fCEda/j3JkzBRYkihShPq9Ae1avdcl/2DhT1LSL3l
	s3GDk4jp9qWyXMcW4FNv4ef4IQ8PdekFFwOd78p+k1WbJdYSZi/fAe3ji22jKKooIgl18leyc
X-Google-Smtp-Source: AGHT+IH0M7W3inIpmwrzmpo1KPZa0eSFJAmsoJJ6KicbwA637WWnTGHA1FR3w/7VPFO11Ntz3PAq77RvluLbGSDe/1M=
X-Received: by 2002:a2e:2e09:0:b0:302:3e14:34c8 with SMTP id
 38308e7fff4ca-30a44dd6835mr9248541fa.22.1739963544714; Wed, 19 Feb 2025
 03:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv> <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
 <Z7W4p0p/Qkke2LTp@MiWiFi-R3L-srv>
In-Reply-To: <Z7W4p0p/Qkke2LTp@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 19 Feb 2025 19:12:05 +0800
X-Gm-Features: AWEUYZk4ZIcj-eseUT3AteioMNjoXpnH24ZLVn36iUjQqT2wFSSTwo8M-TPs_t0
Message-ID: <CAMgjq7AixL=Jn_c5jQFWWJt5+gPz0O+1rxtTWhzOmo2ef3dWhQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 6:55=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 02/19/25 at 04:34pm, Kairui Song wrote:
> > On Wed, Feb 19, 2025 at 3:54=E2=80=AFPM Baoquan He <bhe@redhat.com> wro=
te:
> >
> > Hi Baoquan,
> >
> > Thanks for the review!
> >
> > >
> > > On 02/15/25 at 01:57am, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > Current allocation workflow first traverses the plist with a global=
 lock
> > > > held, after choosing a device, it uses the percpu cluster on that s=
wap
> > > > device. This commit moves the percpu cluster variable out of being =
tied
> > > > to individual swap devices, making it a global percpu variable, and=
 will
> > > > be used directly for allocation as a fast path.
> > > >
> > > > The global percpu cluster variable will never point to a HDD device=
, and
> > > > allocation on HDD devices is still globally serialized.
> > > >
> > > > This improves the allocator performance and prepares for removal of=
 the
> > > > slot cache in later commits. There shouldn't be much observable beh=
avior
> > > > change, except one thing: this changes how swap device allocation
> > > > rotation works.
> > > >
> > > > Currently, each allocation will rotate the plist, and because of th=
e
> > > > existence of slot cache (64 entries), swap devices of the same prio=
rity
> > > > are rotated for every 64 entries consumed. And, high order allocati=
ons
> > > > are different, they will bypass the slot cache, and so swap device =
is
> > > > rotated for every 16K, 32K, or up to 2M allocation.
> > > >
> > > > The rotation rule was never clearly defined or documented, it was c=
hanged
> > > > several times without mentioning too.
> > > >
> > > > After this commit, once slot cache is gone in later commits, swap d=
evice
> > > > rotation will happen for every consumed cluster. Ideally non-HDD de=
vices
> > > > will be rotated if 2M space has been consumed for each order, this =
seems
> > >
> > > This breaks the rule where the high priority swap device is always ta=
ken
> > > to allocate as long as there's free space in the device. After this p=
atch,
> > > it will try the percpu cluster firstly which is lower priority even t=
hough
> > > the higher priority device has free space. However, this only happens=
 when
> > > the higher priority device is exhausted, not a generic case. If this =
is
> > > expected, it may need be mentioned in log or doc somewhere at least.
> >
> > Hmm, actually this rule was already broken if you are very strict
> > about it. The current percpu slot cache does a pre-allocation, so the
> > high priority device will be removed from the plist while some CPU's
> > slot cache holding usable entries.
> >
> > If the high priority device is exhausted, some CPU's percpu cluster
> > will point to a low priority device indeed, and keep using it until
> > the percpu cluster is drained. I think this should be
> > OK. The high priority device is already full, so the amount of
> > swapouts falls back to low priority device is only a performance
> > issue, I think it's a tiny change for a rare case.
> >
> > >
> > > > reasonable. HDD devices is rotated for every allocation regardless =
of the
> > > > allocation order, which should be OK and trivial.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  include/linux/swap.h |  11 ++--
> > > >  mm/swapfile.c        | 120 +++++++++++++++++++++++++++------------=
----
> > > >  2 files changed, 79 insertions(+), 52 deletions(-)
> > > ......
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index ae3bd0a862fc..791cd7ed5bdf 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -116,6 +116,18 @@ static atomic_t proc_poll_event =3D ATOMIC_INI=
T(0);
> > > >
> > > ......snip....
> > > >  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entr=
y_order)
> > > >  {
> > > >       int order =3D swap_entry_order(entry_order);
> > > > @@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t =
swp_entries[], int entry_order)
> > > >       int n_ret =3D 0;
> > > >       int node;
> > > >
> > > > +     /* Fast path using percpu cluster */
> > > > +     local_lock(&percpu_swap_cluster.lock);
> > > > +     n_ret =3D swap_alloc_fast(swp_entries,
> > > > +                             SWAP_HAS_CACHE,
> > > > +                             order, n_goal);
> > > > +     if (n_ret =3D=3D n_goal)
> > > > +             goto out;
> > > > +
> > > > +     n_goal =3D min_t(int, n_goal - n_ret, SWAP_BATCH);
> > >
> > > Here, the behaviour is changed too. In old allocation, partial
> > > allocation will jump out to return. In this patch, you try the percpu
> > > cluster firstly, then call scan_swap_map_slots() to try best and will
> > > jump out even though partial allocation succeed. But the allocation f=
rom
> > > scan_swap_map_slots() could happen on different si device, this looks
> > > bizarre. Do you think we need reconsider the design?
> >
> > Right, that's a behavior change, but only temporarily affects slot cach=
e.
> > get_swap_pages will only be called with size > 1 when order =3D=3D 0, a=
nd
> > only by slot cache. (Large order allocation always use size =3D=3D 1,
> > other users only uses order =3D=3D 0 && size =3D=3D 1). So I didn't' no=
tice
> > it, as this series is removing slot cache.
> >
> > The partial side effect would be "returned slots will be from
> > different devices" and "slot_cache may get drained faster as
> > get_swap_pages may return less slots when percpu cluster is drained".
> > Might be a performance issue but seems slight and trivial, slot cache
> > can still work. And the next commit will just remove the slot cache,
> > and the problem will be gone. I think I can add a comment about it
> > here?
>
> By the way, another thing I suddenly think of is the percpu cluster
> becoming glober over all devices. If one order on the stored si of
> percpu cluster is used up, then the whole percpu cluster is drained and
> rewritten. Won't this impact performance compared with the old embedding
> percpu cluster in each si? In log you said "Ideally non-HDD devices
> will be rotated if 2M space has been consumed for each order, this seems
> reasonable.", while in reality it may be very difficult to achieve the
> 'each 2M space has been consumed for each order', but more often happen
> when very few of order's space has been consumed, then rewrite percpu.
> Wonder what I have missed about this point.

Hi Baoquan,

> then the whole percpu cluster is drained and rewritten

Not sure what you mean, SWAP IO doesn't happen in units of clusters,
cluster is only a management unit for slots, so only allocated / freed
slot will be written. Discard is a different thing, and this should
have very little effect on that.

Or you mean the percpu struct array getting updated? It should be even
faster than before, updating a global percpu variable is easier to
calculate the offset at runtime, using GS.

> n reality it may be very difficult to achieve the 'each 2M space has been=
 consumed for each order',

Very true, but notice for order >=3D 1, slot cache never worked before.
And for order =3D=3D 0, it's very likely that a cluster will have more
than 64 slots usable. The test result I posted should be a good
example, and device is very full during the test, and performance is
basically identical to before. My only concern was about the device
rotating, as slot cache never worked for order >=3D 1, so the device
rotates was very frequently. But still seems no one really cared about
it, mthp swapout is a new thing and the previous rotation rule seems
even more confusing than this new idea.

