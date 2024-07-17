Return-Path: <linux-kernel+bounces-255516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CE9341AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A941F23FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C5182A79;
	Wed, 17 Jul 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2qh7xUW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9B184F;
	Wed, 17 Jul 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238576; cv=none; b=ePuaI7PiZbM4k8SOWRmYVIl3iECcCYrVf1flToeDZ0SboVePEfkBqXKKHiH9qV1+KejmmCxQoAEKouRB37pBkHDzl5CBrsWkgkDoirF90e1LmpKSWO62wHygM10dfQwOZqyUXS1OPeox1Lb52nrFwyhOJKZidTqzLLmEMw0yyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238576; c=relaxed/simple;
	bh=r7IStd/KRzefG9mLooWDUvkj+uQ4fDVlUMU9FjL0Lp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPY1e7dnCKYGBj+1o1T6uzKMj1lqU4gkMIt4xhdfPTiw0Qex8uV1208rM7yRiWZKm+drBqCAkRQ7BncR8hYrn5GFhMTP20X8556MDcQX9rrSiZdmDg5AuQ67ZT1Auy19fPMuB+/WuoaQ9aX+dhDG9s8IsMgfKlCdAPOLxlAyHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2qh7xUW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e057c4885b3so36686276.3;
        Wed, 17 Jul 2024 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238574; x=1721843374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7IStd/KRzefG9mLooWDUvkj+uQ4fDVlUMU9FjL0Lp4=;
        b=K2qh7xUWN15dujhAB03TSZa2UE+ppFZ/pPw0j6CM7jxaR+rG7U4kmCpGzBmey4KOzN
         ocnHxlXquBd4gniMr5PZ/ej8uoPxbc/UEV2auqhP+WMJCTcFU+F0WN2fWZVaFQEOL0Nr
         DZ35wbKrCdUZNk/5jjhJljJB/3DrlJXUZyZaW7IxutFn6+5iGtbmapcKlhgo8L9dthiI
         x6n+XQRNzAFWujEdXEfFKZgB3o92W0gE+XTbti2obZwUEgVANipX4IVkoLI2P4dCR1QY
         GpB2KR8b+ZPRV8wG+pfkyv7bZaz2L4MEGGcr0K2ieZBQe8TGClI43TL7cGc3lEDVPb0K
         ba1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238574; x=1721843374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7IStd/KRzefG9mLooWDUvkj+uQ4fDVlUMU9FjL0Lp4=;
        b=W7b8y/X4dGJh6oh2ikEtkhDVp3p3QKSBbalyM6yL8K1YzYC1ZOXNsQXkZmEXgBDXto
         7cwWIrQycFUjFI+6kt+DLTyrVSpbu87g8O2LRmGC0svyGrmxQnr5/lLmq3BiAVwqZc3m
         pKO85EtMnVDTzSVP/SOazVXBqQP37ut/zCPMH4VM3sl0oZTRFz0aOXJvY7U5vKroB6c7
         fVmAPLyBjSvyoTGNPQy3pU5AFjsGcEpM/i6QdN81s9HEQ7LSvRcE6T7GFCiEKSH+7BQy
         /6JATtSz9NTEevo9U6D9Y932Q8EDWhFjXAMl3EPI62Ml8T/pIlTCc+cau2q0d0+UM+6x
         oovg==
X-Forwarded-Encrypted: i=1; AJvYcCW1W7k37Z6mivJVJs2fR0Qw0Rz72fSRs9IxZwl5xa8jFdOZko6wc06ix+8rRN2fZUqPYl7W7TS0USkz/ogYQ7hsiCE/+tp453ZmR/1YbWL7S8r8kjg34GKNRYV5Sd+j/LZn2j96Hd40
X-Gm-Message-State: AOJu0YwZCGqr3coXTZCeNDHC1je2fdwPNADbbuRffTpl7rQHo/pNVOHS
	y2bZ0mhUyzH/BflPu1yuxWoux80pc1K1rDeC6VhZqwxFlMckxb5V9sqqfoR66TG+nRfP1RdVKx6
	Rdwkzs+oK0JBOkgM28dLydnrKoRE=
X-Google-Smtp-Source: AGHT+IF+3ePAZRTQ0ohZAzihaoPtnFNUgFOaTbtH6oWBWeBWki6l7XK/0hMSS5HAUgxBHEs1QsMxJa5K0L510VXoWjo=
X-Received: by 2002:a05:6902:1004:b0:e05:f40e:440c with SMTP id
 3f1490d57ef6-e05febc0a76mr187623276.44.1721238573561; Wed, 17 Jul 2024
 10:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com> <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com>
In-Reply-To: <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jul 2024 10:49:22 -0700
Message-ID: <CAKEwX=OPDkwnSno-8r9AsOpmzkZ90SzeX02xz0eDTqbL2_QL2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 7:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> >
> > > My concern is that we are knowingly (and perhaps unnecessarily)
> > > creating an LRU inversion here - preferring swapping out the rejected
> > > pages over the colder pages in the zswap pool. Shouldn't it be the
> > > other way around? For instance, can we spiral into the following
> > > scenario:
> > >
> > > 1. zswap pool becomes full.
> > > 2. Memory is still tight, so anonymous memory will be reclaimed. zswa=
p
> > > keeps rejecting incoming pages, and putting a hold on the global
> > > shrinker.
> > > 3. The pages that are swapped out are warmer than the ones stored in
> > > the zswap pool, so they will be more likely to be swapped in (which,
> > > IIUC, will also further delay the global shrinker).
> > >
> > > and the cycle keeps going on and on?
> >
> > I agree this does not follow LRU, but I think the LRU priority
> > inversion is unavoidable once the pool limit is hit.
> > The accept_thr_percent should be lowered to reduce the probability of
> > LRU inversion if it matters. (it is why I implemented proactive
> > shrinker.)
>
> Why?
>
> Let's take a step back. You are suggesting that we throttle zswap
> writeback to allow reclaim to swapout warmer pages to swap device. As
> Nhat said, we are proliferating LRU inversion instead of fixing it.
>
> I think I had a similar discussion with Johannes about this before,
> and we discussed that if zswap becomes full, we should instead
> throttle reclaim and allow zswap writeback to proceed (i.e. the
> opposite of what this series is doing). This would be similar to how
> we throttle reclaim today to wait for dirty pages to be written back.
>

I completely agree with this analysis and proposal - it's somewhat
similar to what I have in mind, but more fleshed out :)

> This should reduce/fix the LRU inversion instead of proliferating it,
> and it should reduce the total amout of IO as colder pages should go
> to disk while warmer pages go to zswap. I am wondering if we can reuse
> the reclaim_throttle() mechanism here.
>
> One concern I have is that we will also throttle file pages if we use
> reclaim_throttle(), since I don't see per-type throttling there. This
> could be fine, since we similarly throttle zswap reclaim if there are
> too many dirty file pages. I am not super familiar with reclaim
> throttling, so maybe I missed something obvious or there is a better
> way, but I believe that from a high level this should be the right way
> to go.

I don't think we have any infrastructure for anon-only throttling in
vmscan logic, but it sounds trivial to implement if necessary :)

>
> I actually think if we do this properly, and throttle reclaim when
> zswap becomes full, we may be able to drop the acceptance hysteresis
> and rely on the throttling mechanism to make sure we stop reclaim
> until we free up enough space in zswap to avoid consistently hitting
> the limit, but this could be a future extension.

Agree - this hysteresis heuristics needs to die.

IMHO, I think we should still have the proactive global shrinking
action that Takero is proposing in patch 3. The throttling is nice,
but it'd be even nicer if we can get ahead of that :)

>
> Johannes, any thoughts here?
>
> Anyway, since patches 1-2 are independent of the rest of the series,
> feel free to send them separately, and we can continue the discussion
> on the best way forward for the rest of the series.

+1.

