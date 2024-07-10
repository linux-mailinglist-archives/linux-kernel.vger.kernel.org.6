Return-Path: <linux-kernel+bounces-248250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A497292DAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC71C2119F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14FC12D1F1;
	Wed, 10 Jul 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGQ5he8o"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5A8120F;
	Wed, 10 Jul 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646483; cv=none; b=Opgcno9RxczLnj/ek33/4BUbVTlwJBcxp5P7wYTxIH0Mi7Yy5G8v9Az1V3QLWBHltlrS/Fr+NxuGBq4R6GyumcWLJUuqHD/viND1k7Z9FEn14mwtUqe2NB7Ocozv8OOWs4VyB7QDE0HdaGipimhG5CzcshxgLoB7PyDmD7dgYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646483; c=relaxed/simple;
	bh=zRuM6d9U739C8YtmXCDkI9vP6Yy6wL+ZAZ8jYMcFhT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5gyWnFemzagcfYDJLHg365S7WJ+DY/q08sVS0+J53evLUb6isrD8gK1ej7fobicNYIDDFMlzJ/BP/5AMKgC0UWEMtCWby91y0UO2tuH0AKe2PSRADKKfDhnPrTJQ/IYv+xXqe2pWincNbLQ+O/dfvmGbI6Vc8SCXZeFPQaPfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGQ5he8o; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03caab48a2so208096276.1;
        Wed, 10 Jul 2024 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646480; x=1721251280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWwzDBJy8f277WXqXl6R3RMuPRUwh+qJXOSNVB7ffMc=;
        b=WGQ5he8oQ8efhXYYMCgpG4JQUQZEbmp1ia/G1TPlXpNiNz0dVtxJuwWMt6vC9ah0OW
         bGSyRipbnTJeWpzCUtzEI4rlyZXfaLNEVGnJiV6oMkXjYl2mZ7V5hoe/ClkN7bmcAnvU
         /YwE53IbjZ8ZtQ1Cm7N2o5HDs98+NwSOOycVox9MQynTolLPEde1aEymTnab2uugYcMS
         lNK2sk9cyxAd55UY634xganeYRGMoTLAHQphhJYRu6/wsZLP3ZGN55azwzcoaJOcCvKi
         LyaDMC39xg7cyJ6xT29HqsTCQm+6J6S7jwJgKgBoneDW5eSrX2BzjEJkjUalevu80fNb
         mWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646480; x=1721251280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWwzDBJy8f277WXqXl6R3RMuPRUwh+qJXOSNVB7ffMc=;
        b=cbDAEDgL4ujzSFvyvRdtIPTnjhWQif5+LmJ2P3w/uVurJkcQdI95mhcKq3yXEHQheL
         OjqiepFEGuUkgeZ/2cDcCLfygSElHIZpCVR867YBPwxmQXKsg7zjGzFKcJX8HdhdBLOP
         GmkDcVh+qbt9rhoO4tt94wNqT/X5UeXbn7iCliJMkhviwQuPCSOJzTmdaDv4YYcB7/7h
         QUgi1J8h0MzM3khacBk31fQWJLqnwX1Hf3M5M89IiXqu7UQYU6u2PVGQykWK/8CwqFOm
         59VhKyFkUwklVktrtAi2JoxS3XsZamDOfC4yqXXOkIRlpBTl8s2UPJtDeYhWXuNHCUdy
         arAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEcPNRAFaQzweLl0hbQ+QG2Oi/qLngPLYGIu2ayW0/5io8NTqrIi72Ryuog+JqaSjvzHzF5UmO/d0NEfFklUwcdqGPZQs6mV9LG+RAJP5OAvWJFJZ1yseGBIHVArrVR8frYMwP+/RT
X-Gm-Message-State: AOJu0YyHHtH0J7aSOd4hj2/R29+/9AA6smJUGwfd7yGS+5zDWZsCeX2z
	gx5W1hw4bwZOkCRuB3jW5UimOBoVbKpi1eZ31IIQEOaz7lAVKCNMYv4xJ5kkJaH6Wssc19mXDGz
	ZwOr+sh/p0obAULVhB6jXIO7FFGs=
X-Google-Smtp-Source: AGHT+IH6bYgfsoNbVGtdjaiR7EunA/HaBDZYQjDSrczVs0R6MHfQSww7S19jaEyCiiHD4LMGaazU7obguZVGu0/l9pM=
X-Received: by 2002:a25:7d02:0:b0:e03:5b97:cbec with SMTP id
 3f1490d57ef6-e0577fb65e5mr780329276.10.1720646480390; Wed, 10 Jul 2024
 14:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-7-flintglass@gmail.com> <CAKEwX=NJjDL3aW3hXioxh=yASSsHbDBWubV9cE2RiH+tSXpscw@mail.gmail.com>
In-Reply-To: <CAKEwX=NJjDL3aW3hXioxh=yASSsHbDBWubV9cE2RiH+tSXpscw@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 11 Jul 2024 06:21:09 +0900
Message-ID: <CAPpoddfpU1rN5ST49vBBJ_=MHKehQQrwsz_hwBd6xyzi4-uQkQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while
 pagein/out IO
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 4:17 Nhat Pham <nphamcs@gmail.=
com>:

>
> Do you see this problem actually manifesting in real life? Does not
> sound infeasible to me, but I wonder how likely this is the case.
>
> Do you have any userspace-visible metrics, or any tracing logs etc.
> that proves that it actually happens?
>
> This might also affect the dynamic shrinker as well FWIW.
>

Although it is rare, on a small VM with 0.5GB RAM, performing `apt
upgrade` for ubuntu kernel update degrades system responsiveness.
Since kernel upgrade is memory consuming for zstd compressed
initramfs, there is heavy memory pressure like the benchmark.

Unfortunately I could not get evidence that clearly indicates the
contention. Perhaps IO latency can be a metric?
While allocating large memory, perf showed that __swap_writepage() was
consuming time and was called mostly from kswapd and some fraction
from user faults of python script and from shrink_worker. CPU was
mostly idling even in a single CPU system, so lock contention and
compression should not be the reason. I believe these behaviors
suggest contention on writeback IO.
As shown in the benchmark,  reducing shrinker writeback by patches 3
to 6 reduced elapsed time, which also indicates IO contention.

> > +/*
> > + * To avoid IO contention between pagein/out and global shrinker write=
back,
> > + * track the last jiffies of pagein/out and delay the writeback.
> > + * Default to 500msec in alignment with mq-deadline read timeout.
>
> If there is a future version, could you include the reason why you
> select 500msec in the patch's changelog as well?
>

The 500ms can be any value longer than the average interval of each
pageout/in and is not significant for behavior. If subsequent pageout
rejection occurs while the shrinker is sleeping, writeback will be
delayed again by 500ms from the last timestamp update. If pageout
occurs at a 1ms interval on average, the minimal delay should be 1+ms.

I chose 500ms from the mq-deadline scheduler that tries to perform
read IO in a 500ms timeframe by default (bfq for HDD uses a shorter
timeout).
When the shrinker performs writeback IO with a 500ms delay from the
last pagein, the write IO will be of lower priority than the read IO
waiting in the queue, as the pagein read becomes the highest priority
by the deadline. This logic emulates low-priority write IO by
voluntarily delaying IO.


>
> Hmmm is there a reason why we do not just do:
>
> zswap_shrinker_delay_start =3D jiffies;
>
> or, more unnecessarily:
>
> unsigned long now =3D jiffies;
>
> zswap_shrinker_delay_start =3D now;
>
> IOW, why the branching here? Does not seem necessary to me, but
> perhaps there is a correctness/compiler reason I'm not seeing?
>
> In fact, if it's the first version, then we could manually inline it.
>

That was to avoid invalidating the CPU cache of the shared variable
unnecessarily. Removing the branch and manually inlining it for v3.


> Additionally/alternatively, I wonder if it is more convenient to do it
> at the mm/page_io.c zswap callsites, i.e whenever zswap_store() and
> zswap_load() returns false, then delay the shrinker before proceeding
> with the IO steps.
>

Should we expose the timestamp variable? It is only used in zswap
internally, and the timestamp is not required when zswap is disabled.

> >         do {
> > +               /*
> > +                * delay shrinking to allow the last rejected page comp=
letes
> > +                * its writeback
> > +                */
> > +               sleepuntil =3D delay + READ_ONCE(zswap_shrinker_delay_s=
tart);
>
> I assume we do not care about racy access here right? Same goes for
> updates - I don't see any locks protecting these operations (but I
> could be missing something).
>

Right. Do we need atomic or spinlock for safety?
 I think the bare store/load of unsigned long is sufficient here. The
possible deviation by concurrent updates is mostly +/-1 jiffy. Sleep
does not need ms accuracy.

Ah, I found a mistake here. v2 missed continue statement in the loop.
The delay should be extended if zswap_store() rejects another page. In
v2, one writeback was allowed per 500ms, which was not my intended
behavior.
The corrected logic for v3 should be:

               if (time_before(now, sleepuntil) &&
                               time_before(sleepuntil, now + delay + 1)) {
                       fsleep(jiffies_to_usecs(sleepuntil - now));
                       /* check if subsequent pageout/in extended delay */
                       continue;
               }


2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 9:57 Nhat Pham <nphamcs@gmail.=
com>:
>
> Hmm what about this scenario: when we disable zswap writeback on a
> cgroup, if zswap_store() fails, we are delaying the global shrinker
> for no gain essentially. There is no subsequent IO. I don't think we
> are currently handling this, right?
>
> >
> > The same logic applies to zswap_load(). When zswap cannot find requeste=
d
> > page from pool and read IO is performed, shrinker should be interrupted=
.
> >
>
> Yet another (less concerning IMHO) scenario is when a cgroup disables
> zswap by setting zswap.max =3D 0 (for instance, if the sysadmin knows
> that this cgroup's data are really cold, and/or that the workload is
> latency-tolerant, and do not want it to take up valuable memory
> resources of other cgroups). Every time this cgroup reclaims memory,
> it would disable the global shrinker (including the new proactive
> behavior) for other cgroup, correct? And, when they do need to swap
> in, it would further delay the global shrinker. Would this break of
> isolation be a problem?
>
> There are other concerns I raised in the cover letter's response as
> well - please take a look :)

I haven't considered these cases much, but I suppose the global
shrinker should be delayed in both cases as well. In general, any
pagein/out should be prefered over shrinker writeback throughput.

When zswap writeback was disabled for a memcg
(memcg.zswap.writeback=3D0), I suppose disabling/delaying writeback is
harmless.
If the rejection incurs no IO, there is no more memory pressure and
shrinking is not urgent. We can postpone the shrinker writeback. If
the rejection incurs IO (i.e. mm choose another page from a memcg with
writeback enabled), again we should delay the shrinker.

For pageout from latency-tolerant memcg (zswap.max=3D0), I think pageout
latency may affect other memcgs.
For example, when a latency-sensitive workload tries to allocate
memory, mm might choose to swap out pages from zswap-disabled memcg.
The slow direct pageout may indirectly delay allocation of the
latency-sensitive workload. IOW, we cannot determine which workload
would be blocked by a slow pageout based on which memcg owns the page.
In this case, it would be better to delay shrinker writeback even if
the owner is latency tolerant memcg.
Also for pagein, we cannot determine how urgent the pagein is.

Delaying shrinker on any pagein/out diminishes proactive shrinking
progress, but that is still better than the existing shrinker that
cannot shrink.

