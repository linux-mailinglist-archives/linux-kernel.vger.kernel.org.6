Return-Path: <linux-kernel+bounces-248339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F992DBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ACF1C236FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF62149E0E;
	Wed, 10 Jul 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNtUg6xm"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C827219F9;
	Wed, 10 Jul 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650428; cv=none; b=uHw/UV5aLzwSfnkRFUdk1yf9017t9c1oEiEicAKWyUY4zJd7MKBuJl5VgiqHjG9pJqDRBY8exkY/otCJB7trB3sjyUbU2Qlh4qhZn4jCKwQLMrvudRMdZIWoXzb57pY/Xp3d4GX30NKgquA+v76zS0ohEvYRbyUiQkD4JPceuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650428; c=relaxed/simple;
	bh=G1+nNhIsGUQHbss19tlUCSGwPVzvI+a7IrCT1i0Lyqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cdx1Uz43u5NLdXVHVCaOwhgSbRlSY/mBL7Y7LSnGQEVAuzs1HwgDCt+Mr8Bn2aFhmMOvzsLd0u2aiw6mDoKTPK9pmfrkdCVWdsfLWXLYk9qnVlYK8LLBhfK5F9WdsRauFU5hlkGZJ9rJpk5iVaYfub3xzxYN7DdMrCDMgMmcF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNtUg6xm; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03a9f7c6a6so228046276.3;
        Wed, 10 Jul 2024 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720650426; x=1721255226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Cc2aQVQ5C4YUCt2A1KuP8JFLG/zHl92A4qTb1v1cg=;
        b=kNtUg6xmzEvX9mqenkyG0qUg1YYcIJtJmm/lVuoqvZLJurbQylljZeqC0xOZhKeBKB
         DL2CUvAN3VfeZFLBDngmC4xYTiII1a2uD60Yrxows4LkfrvGrcofWVg0XK/ZaO8JJZLB
         /ds/adsLkMLpZX3FC6Xr0Ok3qdfhZEjdt0S7WqdqoNrorVJgg7GXg0tSFsN4qsA7Iapc
         Gu59/9gNSQlyFoNyJoHuKt/gsiigwD5xolxDEWM4uZsLh3v6KZt6HJ0Im/EvIjFp2kzT
         S7BtmhCAJyfK3PTAZN7RHMjnpOSV9tcCP+s0rTTU3oiVqPgqFxBZVlR5EmxZCG74KrQ7
         WJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720650426; x=1721255226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Cc2aQVQ5C4YUCt2A1KuP8JFLG/zHl92A4qTb1v1cg=;
        b=XclFOzzOZASXhaToJPVDH29jYQN86LWi/x6CU5qhnUqZxHB/g+z79wJuQafl84UVyj
         N/NT9U3ase/hRo66W4WTWcwrt1CHfaJUEcjhqSww8DoEp/AHaae+a0e/DwHSBAtjGadM
         pt6Nf8BlkE4zpoHEprDY/s+9ObDSbeKArhIB9jKNjbKSb8EVarQPL3ne54Y22oaQse5u
         xNYNXJxumcxPvrfD/CJtHCDeF/gVJEzBz7mcpBbHt6Ilbms8Ps0WQMraTyK7fe1mnzJ3
         zWc50phUaGEbJFf/Wj7Cs+MnSRT9DeGRf9VMqqVUh6TRep1iIcHaG9rhC2TK4RU5d553
         kKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUY/hk/KnkndEfcGflZI3bvgs0thn5PjkIGNnkN3eovjLtRK2Ylyyp6oYKqjtNdF4uZ2F6LuT7ocPvcv09KSbsCmgHm1RABEdVvglTID+Nr0iFm0e/q2o4Yiw2MlibLL+ZsUhBmG68
X-Gm-Message-State: AOJu0YwvableGWw8JAXi8fJnEqJE6DAHudQkj8ASgP9FU1rIvuns1r8n
	GLF036PDyWXYfomKeah1LR9BtpKNbfvG/oILQpwtu27YN0CzpKrg+aMCFfCvuUsIGJOO3tbEFyT
	5QGkrEiPYOsWSPV5BXNs7TG8m6/E=
X-Google-Smtp-Source: AGHT+IE3MSNblNyjPTWlXtNx8ItMNm10tT48kqwkStoBU3USdjc5JBVU9DQ4bDKUP4uy6AFDnPXlKLFcfHrwVbPwkz4=
X-Received: by 2002:a25:8387:0:b0:dfb:bf0:59db with SMTP id
 3f1490d57ef6-e041b120cdamr7581879276.41.1720650426328; Wed, 10 Jul 2024
 15:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
In-Reply-To: <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 11 Jul 2024 07:26:55 +0900
Message-ID: <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 9:53 Nhat Pham <nphamcs@gmail.=
com>:

> > post-patch, 6.10-rc4 with patch 1 to 5
>
> You mean 1 to 6? There are 6 patches, no?

oops. with patches 1 to 6.

>
> Just out of pure curiosity, could you include the stats from patch 1-3 on=
ly?
>

I will rerun the bench in v3. I assume this bench does not reflect
patches 4 to 6, as delta pool_limit_hit=3D0 means no rejection from
zswap.

> Ah this is interesting. Did you actually see improvement in your real
> deployment (i.e not the benchmark) with patch 4-6 in?
>

As replied in patch 6, memory consuming tasks like `apt upgrade` for instan=
ce.

> >
> > Intended scenario for memory reclaim:
> > 1. zswap pool < accept_threshold as the initial state. This is achieved
> >    by patch 3, proactive shrinking.
> > 2. Active processes start allocating pages. Pageout is buffered by zswa=
p
> >    without IO.
> > 3. zswap reaches shrink_start_threshold. zswap continues to buffer
> >    incoming pages and starts writeback immediately in the background.
> > 4. zswap reaches max pool size. zswap interrupts the global shrinker an=
d
> >    starts rejecting pages. Write IO for the rejected page will consume
> >    all IO resources.
>
> This sounds like the proactive shrinker is still not aggressive
> enough, and/or there are some sort of misspecifications of the zswap
> setting... Correct me if I'm wrong, but the new proactive global
> shrinker begins 1% after the acceptance threshold, and shrinks down to
> acceptance threshold, right? How are we still hitting the pool
> limit...
>

Proactive shrinking should not be aggressive. With patches 4 and 6, I
modified the global shrinker to be less aggressive against pagein/out.
Shrinking proactively cannot avoid hitting the pool limit when memory
pressure grows faster.

> My concern is that we are knowingly (and perhaps unnecessarily)
> creating an LRU inversion here - preferring swapping out the rejected
> pages over the colder pages in the zswap pool. Shouldn't it be the
> other way around? For instance, can we spiral into the following
> scenario:
>
> 1. zswap pool becomes full.
> 2. Memory is still tight, so anonymous memory will be reclaimed. zswap
> keeps rejecting incoming pages, and putting a hold on the global
> shrinker.
> 3. The pages that are swapped out are warmer than the ones stored in
> the zswap pool, so they will be more likely to be swapped in (which,
> IIUC, will also further delay the global shrinker).
>
> and the cycle keeps going on and on?

I agree this does not follow LRU, but I think the LRU priority
inversion is unavoidable once the pool limit is hit.
The accept_thr_percent should be lowered to reduce the probability of
LRU inversion if it matters. (it is why I implemented proactive
shrinker.)

When the writeback throughput is slower than memory usage grows,
zswap_store() will have to reject pages sooner or later.
If we evict the oldest stored pages synchronously before rejecting a
new page (rotating pool to keep LRU), it will affect latency depending
how much writeback is required to store the new page. If the oldest
pages were compressed well, we would have to evict too many pages to
store a warmer page, which blocks the reclaim progress. Fragmentation
in the zspool may also increase the required writeback amount.
We cannot accomplish both maintaining LRU priority and maintaining
pageout latency.

Additionally, zswap_writeback_entry() is slower than direct pageout. I
assume this is because shrinker performs 4KB IO synchronously. I am
seeing shrinking throughput is limited by disk IOPS * 4KB while much
higher throughput can be achieved by disabling zswap. direct pageout
can be faster than zswap writeback, possibly because of bio
optimization or sequential allocation of swap.


> Have you experimented with synchronous reclaim in the case the pool is
> full? All the way to the acceptance threshold is too aggressive of
> course - you might need to find something in between :)
>

I don't get what the expected situation is.
The benchmark of patch 6 is performing synchronous reclaim in the case
the pool is full, since bulk memory allocation (write to mmapped
space) is much faster than writeback throughput. The zswap pool is
filled instantly at the beginning of benchmark runs. The
accept_thr_percent is not significant for the benchmark, I think.


>
> I wonder if this contention would show up in PSI metrics
> (/proc/pressure/io, or the cgroup variants if you use them ). Maybe
> correlate reclaim counters (pgscan, zswpout, pswpout, zswpwb etc.)
> with IO pressure to show the pattern, i.e the contention problem was
> there before, and is now resolved? :)

Unfortunately, I could not find a reliable metric other than elapsed
time. It seems PSI does not distinguish stalls for rejected pageout
from stalls for shrinker writeback.
For counters, this issue affects latency but does not increase the
number of pagein/out. Is there any better way to observe the origin of
contention?

Thanks.

