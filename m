Return-Path: <linux-kernel+bounces-252171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FDE930F74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E925F1C2111B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07B172BA6;
	Mon, 15 Jul 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx+HK5bS"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B524B5B;
	Mon, 15 Jul 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031619; cv=none; b=XreGhJ6+032OOLurrPWKQtFy5qYHfYMp8kN/azvuka22iA9u0eRjH7HaWvncUWWvpmOKWkmFridXtqCHmhMVyVfRhuw7IdmDpXAsF955hHjB/t4utGQnWQCzyXBZPIwlqJih76J9U8TpM+tM5Z/rmt38ysgYqlpZYK6ZhBX4Ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031619; c=relaxed/simple;
	bh=w32Lnn89aqttGf8i+OlyMuDjy+X6udKgPOF42Cmtux8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qru+ERhWerZN51i0vLu9cPzWChh47+y7YxACR67p6ttUeIsjvgxF2hCgTalzWYDOwpB8ZSR0APh+SES+jJNHxIzptWUbCYKzeWddBdG/8q0xmHU2XmlxQBm+xDByK9n8mtfUjxzAJlIkGOOVisvaE5592bz1AABUV7gWx9ICQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx+HK5bS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03618fc78bso3545449276.2;
        Mon, 15 Jul 2024 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721031617; x=1721636417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w32Lnn89aqttGf8i+OlyMuDjy+X6udKgPOF42Cmtux8=;
        b=Jx+HK5bSLI3iSTGwwn5mNAW+lSbkS/Fuj021hynoOGZ9rGcRZrk2CASMWvcroiYNl9
         kShiDtb2eS3TyKcNMsmNIsx9lX5qsnnhi6s55v1k2Xk05IC1uMRHQ3Tu0Co8XdK1LlY5
         7nBrnuU51lWq5yOFluYddYidKynVMKhUrPAaQ6I83/8qkMd6WVAdHmnEDWcXT9Kx+3zK
         BWrHiR3zkhyKjWAMrFh06bc3y4M6wjKS0Z9CEQR/yIAHJoXuJaBOX83WPbeGE4xIm4kM
         Ro68n/n5FKQL9Chk70TkJ1Ss0Qa9uDXv87k4+eSn5CiCj1iKPxHDJemG4z5k2CCsmC42
         cbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031617; x=1721636417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w32Lnn89aqttGf8i+OlyMuDjy+X6udKgPOF42Cmtux8=;
        b=b7afVlnPO8tYef+jpPtX6PYbGfOInysLDqYPYbY/DJDO2RcB2FZobtHjDwUweihFAK
         zf+btdw0tx6YCT/IDi+O0ygOnnq46A1yI2kbe1ZzqvwhBLnwlfXkiMxXu/0CtZdfWCJB
         BQrkLPxSD86sYrzQ5jhXc3spDwirisbFsR6xNz9EqUM+tu9ZAcbePUBBnNNGFuB55vqZ
         C/otJ3pz9yhkh22mUFvMlDigNxYwCKZw+9LDylToiHftpfO3yC4nIoQl4rVFd9vFhAyK
         anCMLXb7mTNg17BY+l9PK4kHwJRDF/5hYIJSA/8DzxLcTDvbxcaWni9uueivo8DGpZJy
         IR0A==
X-Forwarded-Encrypted: i=1; AJvYcCWxZV5BaLSJASLNf9u+0owaACXQRTw5kMgAsHI6uBcYjhXhCfxfk3gM9R7eo2Mc8DAsHJldGsig/jv944WeLjyG+3EBsYO8YaN4sIUG3afHoa4DZPAq4N/Z4S99cAWCrHXgEgAkRIBo
X-Gm-Message-State: AOJu0YwxsGhyKqlSu3xq6kXXwAy4x/H9wFO5lsYsjg2x2bXZObJO/B32
	X5nEyf8jfue7Hc5uWDmGac3QRifupfBMw0a6ZBYRL8L433CpqTczA3PVmrH1hcfKWsQHdvnXf7Z
	7sq/E8mS6/ONEUACmtW/0GXDaqhI=
X-Google-Smtp-Source: AGHT+IHqF0bzN3oaeHLdU3o7OVMKaBGJVKKiVAcQw8uaPEHiVkAtxgzLjYUDhiSGbPFDUHm2O/xsWwoFjm8CO/6yiXw=
X-Received: by 2002:a05:6902:50d:b0:e03:580a:da43 with SMTP id
 3f1490d57ef6-e041b05cac1mr20842473276.22.1721031616930; Mon, 15 Jul 2024
 01:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com> <CAKEwX=MFdjryQRDm9b-Oxquhw954HUipCCpABSLwH9mrV4D3WA@mail.gmail.com>
In-Reply-To: <CAKEwX=MFdjryQRDm9b-Oxquhw954HUipCCpABSLwH9mrV4D3WA@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Mon, 15 Jul 2024 17:20:06 +0900
Message-ID: <CAPpoddfNfrGjhHzQ4KURv2y_z-iyY8cTzG+7d2ooQFU5NcU80w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8813=E6=97=A5(=E5=9C=9F) 8:02 Nhat Pham <nphamcs@gmail=
.com>:

> >
> > I agree this does not follow LRU, but I think the LRU priority
> > inversion is unavoidable once the pool limit is hit.
> > The accept_thr_percent should be lowered to reduce the probability of
> > LRU inversion if it matters. (it is why I implemented proactive
> > shrinker.)
>
> And yet, in your own benchmark it fails to prevent that, no? I think
> you lower it all the way down to 50%.
>
> >
> > When the writeback throughput is slower than memory usage grows,
> > zswap_store() will have to reject pages sooner or later.
> > If we evict the oldest stored pages synchronously before rejecting a
> > new page (rotating pool to keep LRU), it will affect latency depending
> > how much writeback is required to store the new page. If the oldest
> > pages were compressed well, we would have to evict too many pages to
> > store a warmer page, which blocks the reclaim progress. Fragmentation
> > in the zspool may also increase the required writeback amount.
> > We cannot accomplish both maintaining LRU priority and maintaining
> > pageout latency.
>
> Hmm yeah, I guess this is fair. Looks like there is not a lot of
> choice, if you want to maintain decent pageout latency...
>
> I could suggest that you have a budgeted zswap writeback on zswap
> store - i.e if the pool is full, then try to zswap writeback until we
> have enough space or if the budget is reached. But that feels like
> even more engineering - the IO priority approach might even be easier
> at that point LOL.
>
> Oh well, global shrinker delay it is :)
>
> >
> > Additionally, zswap_writeback_entry() is slower than direct pageout. I
> > assume this is because shrinker performs 4KB IO synchronously. I am
> > seeing shrinking throughput is limited by disk IOPS * 4KB while much
> > higher throughput can be achieved by disabling zswap. direct pageout
> > can be faster than zswap writeback, possibly because of bio
> > optimization or sequential allocation of swap.
>
> Hah, this is interesting!
>
> I wonder though, if the solution here is to perform some sort of
> batching for zswap writeback.
>
> BTW, what is the type of the storage device you are using for swap? Is
> it SSD or HDD etc?
>

It was tested on an Azure VM with SSD-backed storage. The total IOPS
was capped at 4K IOPS by the VM host. The max throughput of the global
shrinker was around 16 MB/s. Proactive shrinking cannot prevent
pool_limit_hit since memory allocation can be on the order of GB/s.
(The benchmark script allocates 2 GB sequentially, which was
compressed to 1.3 GB, while the zswap pool was limited to 200 MB.)


> >
> >
> > > Have you experimented with synchronous reclaim in the case the pool i=
s
> > > full? All the way to the acceptance threshold is too aggressive of
> > > course - you might need to find something in between :)
> > >
> >
> > I don't get what the expected situation is.
> > The benchmark of patch 6 is performing synchronous reclaim in the case
> > the pool is full, since bulk memory allocation (write to mmapped
> > space) is much faster than writeback throughput. The zswap pool is
> > filled instantly at the beginning of benchmark runs. The
> > accept_thr_percent is not significant for the benchmark, I think.
>
> No. I meant synchronous reclaim as in triggering zswap writeback
> within the zswap store path, to make space for the incoming new zswap
> pages. But you already addressed it above :)
>
>
> >
> >
> > >
> > > I wonder if this contention would show up in PSI metrics
> > > (/proc/pressure/io, or the cgroup variants if you use them ). Maybe
> > > correlate reclaim counters (pgscan, zswpout, pswpout, zswpwb etc.)
> > > with IO pressure to show the pattern, i.e the contention problem was
> > > there before, and is now resolved? :)
> >
> > Unfortunately, I could not find a reliable metric other than elapsed
> > time. It seems PSI does not distinguish stalls for rejected pageout
> > from stalls for shrinker writeback.
> > For counters, this issue affects latency but does not increase the
> > number of pagein/out. Is there any better way to observe the origin of
> > contention?
> >
> > Thanks.

