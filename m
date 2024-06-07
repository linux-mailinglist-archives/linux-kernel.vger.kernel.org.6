Return-Path: <linux-kernel+bounces-206538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E82900B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E99B22864
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C719AD6E;
	Fri,  7 Jun 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBM6VbKw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C615ACB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781103; cv=none; b=Ota3LaRXcwhWvMZxuo9IVyYJbI4q0jEqLlWltzD/9cHDZJlnaAT61DDmw145x5LACTS7i6yPNRDMJDIkoklPwoKZwyXneO1i80B0xv3ZjuYaLPffPR3Fp3qYoLseOy5jfFXMkiSZA6/sGd171CzWu8TqKZbkn6NXC0nTCIED7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781103; c=relaxed/simple;
	bh=kx/7HInJQDABKtXyDpTJDHcemdDalaTc+DLiFdz7WO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhVjPuJ1IZ370pzT47MNgVlZcAbPOFZhmMcmrUQMXT5d7+iJp8GK7OP5TrfACmg9KXiOXK1vS4jrhwG74mWh5ZNWuLd5dSzYoJWcxvFj285dxmcbtCA710WYO7nomO9vIA7aeoNDLiE/WH+TrrkjQ/R1PSRmr9uzgtD2Fh91Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBM6VbKw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6267778b3aso291009766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781100; x=1718385900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZcPHS5nObMkGpNMDkoJlbRs4OmeOKlnWXQEnPNBwVU=;
        b=cBM6VbKw/UqwG2MSyRPeufyjMp1D6AGgKYfyAjx2l8lQszt5ropB6wo0U5Py/n2gcC
         sN8a6/hLzgPKgTEvnkQrnhwy1wFMJX/07dbSsPfDwdNWeD399t6amjhH7raaKPLxA+iN
         4gtzMGfpVeUtzGhlcwAIiOIr1iivTVWFL5wSgULPKGjLVGGoOaliby0HGuD6mQg9Sz/c
         McqZ/teqGaJmqH0kAqq0DxTYH0PgY0WapJ8yJtyqEXUu5FY4MK9iRmFY0QFW+hxlZe3w
         MThpuvNWCiyikEpnqFd0vRdDDz+5OJrkKs6hJ0fmqppWZdOYC2KOX0NG29xa6P2M7qon
         zRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781100; x=1718385900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZcPHS5nObMkGpNMDkoJlbRs4OmeOKlnWXQEnPNBwVU=;
        b=YGG5f1RP8pqLiaWybySflsDpitwA+M5fMVGDf5pEpONM/Mo9ije/u7RbWTVcZacov5
         uqm+vl29hw7OuN+Lkca7hzRvAUYoqXEUuMc5oBJOXZT6LeAf6KoOtykUnNpFow/+bK0M
         xWLAeEilWCbdJS5nhF2+uMGgxA2Tzil04iYXS1Ak6YGL1VO37mNanPCWs7DsDYe2FuiW
         Yio66eoh5cMfXOhf6QcG0PThvQ7ZaAnY64G/w2FTlBjlPW5kqAMnV7C8VWhw6oAPYT8S
         /v0UPNUCrAzjXdMe2M4BlaKyFt3sLa08GlQdmsLi5TsoVcjix/NG/Zzh8ddyCeK06ggk
         afCw==
X-Forwarded-Encrypted: i=1; AJvYcCVPA+PWNhqDxS9HKGaYzD0xKjfelGogCOGhQyoJOp9qBZx4yMcu8gdR8h57s8H//cz6SXq0UAiDLOO5cu+tiaNn4mLVHBK+S+s6Vxj5
X-Gm-Message-State: AOJu0YxQzQYGWvhF3uyWgOhP8uKjIBdifwIpi8Etn5MgH6TKwcFmH7Zy
	rArbD710StaU3ue8XlVz5A4MtdPPYLltM9zgel7qDILp8Owby02xgrYOOJRSAqcvFIr1I7zBp2M
	RN8wD8Kecf4xXgFZ1OQZ/hqmbfsDahxqZWYXSJP0rHzucCg+nmD75
X-Google-Smtp-Source: AGHT+IGvDsfJ5GPj6VC/dEdrnKwbmtX6kibtWaeckQgiOPlyznoRd6nf2wUsVVvhPGsFz5jeluIvbrDrgRFhHjdWym4=
X-Received: by 2002:a17:906:fe49:b0:a68:fdfd:8041 with SMTP id
 a640c23a62f3a-a6cd7a843f0mr302689966b.42.1717781099759; Fri, 07 Jun 2024
 10:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604175340.218175-1-yosryahmed@google.com>
 <ZmI573n9-SoK4dIg@google.com> <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>
 <ZmMx4f1V9lBlctiw@google.com>
In-Reply-To: <ZmMx4f1V9lBlctiw@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 10:24:23 -0700
Message-ID: <CAJD7tkZONYiicmjOm8+VrHDXXDdwT39kWyS2cOKfNqMH5C1b5Q@mail.gmail.com>
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:14=E2=80=AFAM Minchan Kim <minchan@kernel.org> wro=
te:
>
> On Thu, Jun 06, 2024 at 04:03:55PM -0700, Yosry Ahmed wrote:
> > On Thu, Jun 6, 2024 at 3:36=E2=80=AFPM Minchan Kim <minchan@kernel.org>=
 wrote:
> > >
> > > On Tue, Jun 04, 2024 at 05:53:40PM +0000, Yosry Ahmed wrote:
> > > > Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> > > > zpool creates its own 'zs_handle' and 'zspage' slab caches. Current=
ly we
> > > > end up with 32 slab caches of each type.
> > > >
> > > > Since each slab cache holds some free objects, we end up with a lot=
 of
> > > > free objects distributed among the separate zpool caches. Slab cach=
es
> > > > are designed to handle concurrent allocations by using percpu
> > > > structures, so having a single instance of each cache should be eno=
ugh,
> > > > and avoids wasting more memory than needed due to fragmentation.
> > > >
> > > > Additionally, having more slab caches than needed unnecessarily slo=
ws
> > > > down code paths that iterate slab_caches.
> > > >
> > > > In the results reported by Eric in [1], the amount of unused slab m=
emory
> > > > in these caches goes down from 242808 bytes to 29216 bytes (-88%). =
This
> > > > is calculated by (num_objs - active_objs) * objsize for each 'zs_ha=
ndle'
> > > > and 'zspage' cache. Although this patch did not help with the alloc=
ation
> > > > failure reported by Eric with zswap + zsmalloc, I think it is still
> > > > worth merging on its own.
> > > >
> > > > [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/
> > >
> > > I doubt this is the right direction.
> > >
> > > Zsmalloc is used for various purposes, each with different object
> > > lifecycles. For example, swap operations relatively involve short-liv=
ed
> > > objects, while filesystem use cases might have longer-lived objects.
> > > This mix of lifecycles could lead to fragmentation with this approach=
.
> >
> > Even in a swapfile, some objects can be short-lived and some objects
> > can be long-lived, and the line between swap and file systems both
> > becomes blurry with shmem/tmpfs. I don't think having separate caches
>
>
> Many allocators differentiate object lifecycles to minimize
> fragmentation. While this isn't a new concept, you argue it's irrelevant
> without a clearcut use case.
>
> > here is vital, but I am not generally familiar with the file system
> > use cases and I don't have data to prove/disprove it.
>
> The use case I had in mind was build output directories (e.g., Android).
> These consume object files in zram until the next build.
>
> Other potential scenarios involve separate zrams: one for foreground
> apps (short-term) and another for cached apps (long-term). Even
> zswap and zram could have different object lifecycles, as zswap might
> write back more aggressively.
>
> While you see no clear use cases, I disagree with dismissing this
> concept without strong justification.

I was just unaware of these use cases, as I mentioned. I didn't really
know how zram was used with file systems. Thanks for the examples :)

>
> >
> > >
> > > I believe the original problem arose when zsmalloc reduced its lock
> > > granularity from the class level to a global level. And then, Zswap w=
ent
> > > to mitigate the issue with multiple zpools, but it's essentially anot=
her
> > > bandaid on top of the existing problem, IMO.
> >
> > IIRC we reduced the granularity when we added writeback support to
> > zsmalloc, which was relatively recent. I think we have seen lock
> > contention with zsmalloc long before that. We have had a similar patch
> > internally to use multiple zpools in zswap for many years now.
> >
> > +Yu Zhao
> >
> > Yu has more historical context about this, I am hoping he will shed
> > more light about this.
> >
> > >
> > > The correct approach would be to further reduce the zsmalloc lock
> > > granularity.
> >
> > I definitely agree that the correct approach should be to fix the lock
> > contention at the source and drop zswap's usage of multiple zpools.
> > Nonetheless, I think this patch provides value in the meantime. The
> > fragmentation within the slab caches is real with zswap's use case.
> > OTOH, sharing a cache between swap and file system use cases leading
> > to fragmentation within the same slab cache is a less severe problem
> > in my opinion.
> >
> > That being said, I don't feel strongly. If you really don't like this
> > patch I am fine with dropping it.
>
> How about introducing a flag like "bool slab_merge" in zs_create_pool?
> This would allow zswap to unify slabs while others don't.

Yeah this should work. But I'll wait until we have more data and we
know whether we need to keep using multiple zpools for zswap.

I sent this patch because I thought it would be generally useful to
share caches (e.g. if we have zram and zswap on the same system),  but
given that you said it is actually preferable that the caches are
separate, it may not be. I'll wait for more data before sending any
more patches to address this.

Andrew, could you please take this out of mm-unstable?

Thanks!

