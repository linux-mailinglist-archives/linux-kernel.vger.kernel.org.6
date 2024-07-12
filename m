Return-Path: <linux-kernel+bounces-251220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B49930248
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686E41F23432
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB4130486;
	Fri, 12 Jul 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWl7dUUs"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F51BC3C;
	Fri, 12 Jul 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720825362; cv=none; b=gFgGL7G2U3Tu4Zr9qmeI1pg0fw9stQ8qZPi19STU3+KQSl2C3YBgxd+UoHFOJSWm8/CVZV0+HLFnWT4CNTNMSwXPuRpGzPYPXMfm8q9rnHd6IuVXBzTk6qVfEc//egdGixfdxEeyecfcsKX08/CXA0XOGuFUEBkhcr2JxzxAkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720825362; c=relaxed/simple;
	bh=R87N7Gh7XUizx7Z1+TJNWFt1ny5hyy/xtNYvrq4QkCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ9rpE7Qw+EBoZheuZq0YqLYsK1Vg7M8LhxAtptcHgsfVmfsOLBUuVBbKVmIRDprfHk9fmY+tiPvpiOagkTxpHy4E42bELFHF/UlRKE9Wm4+OrhXMhe++1614X027Bjxdam0ue2BMGVOhFidAvEVZ2gwaIxSEG4DB6IWDzJ5+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWl7dUUs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5ecafbf88so12362406d6.3;
        Fri, 12 Jul 2024 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720825359; x=1721430159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJGaZblzwmJYZ+hIO/WBo5zQB6Wjp1o6IoOSbordWiU=;
        b=ZWl7dUUs/TDzNDt4hbo9C7xmcNbYUEDwwAQDZdJfHVQdnK1W8fc1UkBHXDICXTurbm
         6R4WhJFruYl97NkIbVdVp7Jhg7iG+6uwMZx3ck+YOlpCDPRVYAH3nKgMABctCbh/Rk+m
         KoocRTEn11LAFqiXqEoKEDq/9oBvwWCIYxMHx8rK6ypwDeXkVfl0J4/DZ/J0Qm9+rDib
         GlxilnLcraPtGrLyijlqWZYFfjWCUhs0sl+f1QOgV3ODP1dRWXN9yNuzvwbO0h1mGi4r
         QTFZ65zuASWgOA1VxeuMsi3U72DUj2fbLujwR3Cv+5drG0d0jm/TnpqiXwrWNqxyyilI
         MDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720825359; x=1721430159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJGaZblzwmJYZ+hIO/WBo5zQB6Wjp1o6IoOSbordWiU=;
        b=gFAmlhJ0qPETK6mfOb/1OG0KD7+i01rVD2I5sxZUz38jEMLILt9OTTQ8yXPnasonrG
         9kDTk6Ob2ZWQc/x8aLs8CNRBAazxTbgiwrUM5NsMTnnzvELkzHcJM1wAQ2GNM313Z2rh
         IPXnMg3rKQWOWZqUWMCN9ov9RCy394Co8MscIwgY2c6SudKqRUeUO+ODiqt6oF9b1yEF
         qs0akhXd2KdGe/LOtEQDRdQX1+afrOgwJD9g6WBJ9G9uGHghVyIvPovOZIhIFkCtMl15
         OtQOprylggKJz+32b9CSihL6jcKu7keyCxnHszc2bOFahiXyjT9uFxkeHyITx4c7bg6w
         RakA==
X-Forwarded-Encrypted: i=1; AJvYcCWkKaNIRmNzvz52CtUg+5Ieap75mOnsh6+CIqpQj3ofP9pZWFUNf7XOmzmEQzbTs8zW0dfNrFKGJGNF9KC1xaoc8DoUHbeOUVM4tg/l7RqEjSM3egBi6RpHC0vV7DtwVuK2HiCac9r7
X-Gm-Message-State: AOJu0Yy6Mukb2KRxBLqZUj078IEvUFb7Gd2STna32c7W+y4sU/fNp1Tp
	/X0ZSU6tSj3aHGvggI1zqqsrWktDCyYbCpeOTbtPmxSBs1t1mJdC+EoOAutYhADWfk2A/6KkbXM
	mbOTDLyFj18QsmbIsbThwGU1hbcy+qQ==
X-Google-Smtp-Source: AGHT+IGM/qvRuhFSgMKJltrgTEGOD3Cl0bznZEGGmwukrLJp0k6aQJUOKLkl6cIk0pebPaezVfYeX8z1llyEySJnusQ=
X-Received: by 2002:a05:6214:250a:b0:6b5:413a:3f96 with SMTP id
 6a1803df08f44-6b61bc7ec67mr165235596d6.10.1720825359376; Fri, 12 Jul 2024
 16:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com> <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
In-Reply-To: <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 12 Jul 2024 16:02:27 -0700
Message-ID: <CAKEwX=MFdjryQRDm9b-Oxquhw954HUipCCpABSLwH9mrV4D3WA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:27=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 9:53 Nhat Pham <nphamcs@gmai=
l.com>:
>
> > > post-patch, 6.10-rc4 with patch 1 to 5
> >
> > You mean 1 to 6? There are 6 patches, no?
>
> oops. with patches 1 to 6.
>
> >
> > Just out of pure curiosity, could you include the stats from patch 1-3 =
only?
> >
>
> I will rerun the bench in v3. I assume this bench does not reflect
> patches 4 to 6, as delta pool_limit_hit=3D0 means no rejection from
> zswap.
>
> > Ah this is interesting. Did you actually see improvement in your real
> > deployment (i.e not the benchmark) with patch 4-6 in?
> >
>
> As replied in patch 6, memory consuming tasks like `apt upgrade` for inst=
ance.
>
> > >
> > > Intended scenario for memory reclaim:
> > > 1. zswap pool < accept_threshold as the initial state. This is achiev=
ed
> > >    by patch 3, proactive shrinking.
> > > 2. Active processes start allocating pages. Pageout is buffered by zs=
wap
> > >    without IO.
> > > 3. zswap reaches shrink_start_threshold. zswap continues to buffer
> > >    incoming pages and starts writeback immediately in the background.
> > > 4. zswap reaches max pool size. zswap interrupts the global shrinker =
and
> > >    starts rejecting pages. Write IO for the rejected page will consum=
e
> > >    all IO resources.
> >
> > This sounds like the proactive shrinker is still not aggressive
> > enough, and/or there are some sort of misspecifications of the zswap
> > setting... Correct me if I'm wrong, but the new proactive global
> > shrinker begins 1% after the acceptance threshold, and shrinks down to
> > acceptance threshold, right? How are we still hitting the pool
> > limit...
> >
>
> Proactive shrinking should not be aggressive. With patches 4 and 6, I
> modified the global shrinker to be less aggressive against pagein/out.
> Shrinking proactively cannot avoid hitting the pool limit when memory
> pressure grows faster.
>
> > My concern is that we are knowingly (and perhaps unnecessarily)
> > creating an LRU inversion here - preferring swapping out the rejected
> > pages over the colder pages in the zswap pool. Shouldn't it be the
> > other way around? For instance, can we spiral into the following
> > scenario:
> >
> > 1. zswap pool becomes full.
> > 2. Memory is still tight, so anonymous memory will be reclaimed. zswap
> > keeps rejecting incoming pages, and putting a hold on the global
> > shrinker.
> > 3. The pages that are swapped out are warmer than the ones stored in
> > the zswap pool, so they will be more likely to be swapped in (which,
> > IIUC, will also further delay the global shrinker).
> >
> > and the cycle keeps going on and on?
>
> I agree this does not follow LRU, but I think the LRU priority
> inversion is unavoidable once the pool limit is hit.
> The accept_thr_percent should be lowered to reduce the probability of
> LRU inversion if it matters. (it is why I implemented proactive
> shrinker.)

And yet, in your own benchmark it fails to prevent that, no? I think
you lower it all the way down to 50%.

>
> When the writeback throughput is slower than memory usage grows,
> zswap_store() will have to reject pages sooner or later.
> If we evict the oldest stored pages synchronously before rejecting a
> new page (rotating pool to keep LRU), it will affect latency depending
> how much writeback is required to store the new page. If the oldest
> pages were compressed well, we would have to evict too many pages to
> store a warmer page, which blocks the reclaim progress. Fragmentation
> in the zspool may also increase the required writeback amount.
> We cannot accomplish both maintaining LRU priority and maintaining
> pageout latency.

Hmm yeah, I guess this is fair. Looks like there is not a lot of
choice, if you want to maintain decent pageout latency...

I could suggest that you have a budgeted zswap writeback on zswap
store - i.e if the pool is full, then try to zswap writeback until we
have enough space or if the budget is reached. But that feels like
even more engineering - the IO priority approach might even be easier
at that point LOL.

Oh well, global shrinker delay it is :)

>
> Additionally, zswap_writeback_entry() is slower than direct pageout. I
> assume this is because shrinker performs 4KB IO synchronously. I am
> seeing shrinking throughput is limited by disk IOPS * 4KB while much
> higher throughput can be achieved by disabling zswap. direct pageout
> can be faster than zswap writeback, possibly because of bio
> optimization or sequential allocation of swap.

Hah, this is interesting!

I wonder though, if the solution here is to perform some sort of
batching for zswap writeback.

BTW, what is the type of the storage device you are using for swap? Is
it SSD or HDD etc?

>
>
> > Have you experimented with synchronous reclaim in the case the pool is
> > full? All the way to the acceptance threshold is too aggressive of
> > course - you might need to find something in between :)
> >
>
> I don't get what the expected situation is.
> The benchmark of patch 6 is performing synchronous reclaim in the case
> the pool is full, since bulk memory allocation (write to mmapped
> space) is much faster than writeback throughput. The zswap pool is
> filled instantly at the beginning of benchmark runs. The
> accept_thr_percent is not significant for the benchmark, I think.

No. I meant synchronous reclaim as in triggering zswap writeback
within the zswap store path, to make space for the incoming new zswap
pages. But you already addressed it above :)


>
>
> >
> > I wonder if this contention would show up in PSI metrics
> > (/proc/pressure/io, or the cgroup variants if you use them ). Maybe
> > correlate reclaim counters (pgscan, zswpout, pswpout, zswpwb etc.)
> > with IO pressure to show the pattern, i.e the contention problem was
> > there before, and is now resolved? :)
>
> Unfortunately, I could not find a reliable metric other than elapsed
> time. It seems PSI does not distinguish stalls for rejected pageout
> from stalls for shrinker writeback.
> For counters, this issue affects latency but does not increase the
> number of pagein/out. Is there any better way to observe the origin of
> contention?
>
> Thanks.

