Return-Path: <linux-kernel+bounces-341425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A7987FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0711C23164
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611CA17ADE7;
	Fri, 27 Sep 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3GSv5P/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A128475
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424115; cv=none; b=QD/OMq5YEqllfiaH0oLPLc1ljUrSt6dWjjnONUXEj05aIiTC7vLMV1QLupMBb61dZy8cF0lYMjlRbC1ftrqArfiZty4tEXaf2rNygKKLD8Qt5QogIrWpTI7y7BA93VJ7e7hQvi6X/OG7liDGGVeOIaa4TRyaFcHhyX8+uurXXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424115; c=relaxed/simple;
	bh=bAiUwYJ/Yx1ucy+uKiljXXWCLKHLqRUsJizRfstrbhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro/G5/Y9IX7tstnzpln/jWDCaWie22UdgrePrFw+EAuOocKk27rfiFkV7hgU4A7JeVuRvPj6xhu/85owLapYUIZZLC6C0IvYPRRtriMg0n5gzFNI9IYenD7jWO7UNgJcp76d22ur8jxg4n2voq4ELRTW0LbZTJY8JMltOWt6NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3GSv5P/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-535dc4ec181so2008353e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727424112; x=1728028912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAiUwYJ/Yx1ucy+uKiljXXWCLKHLqRUsJizRfstrbhM=;
        b=E3GSv5P/8M2vG5TrlaVkk+/mUeqcYwbvN+p15EI1+dY3rf7t9N6qokNd8hCqxftXIf
         1O4/M3clZUhjhd6ZryL3alvyqWaPSDmBQIpRurkkjNvowSUrio4qXff7GzxdjIEJSSJX
         7Xtt90B+Q3zLJ1yoUYwfWpqy6SK0pooCIhSSg6KL+obfGXKjiHzE3JeFjTdTrtvGNwyP
         btCq2d4LrSt2EUAVO5XeN/CYUgXCnItLEya18eNzMTxC1JKaiDxPmpRd66ujgVpVVc+N
         ElVTamtiWjpJrdrUbaPw/2yOMTlQAcTUR6o6MqJWdd40f49iEM1FP/piBSWFpCLdQJGm
         OXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727424112; x=1728028912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAiUwYJ/Yx1ucy+uKiljXXWCLKHLqRUsJizRfstrbhM=;
        b=YmKHoJLWlO+9CrTeKMwpjNijUP7bsNRpft8ZMfhqqXA3QGxYwEO5dh2oXGpVQsxZAp
         c5m8lCRRpcFEXEU+353gwJv6W5Pe674l/jy3n8bSV6j9nHLemWZZvxJCcvYo1rK3jm18
         U+5DDWISsmv2cW2qUJ/FehtWjGRuElDLQH+IgoT/IeDEmyla51GF6n2dqaJ1WfNYSx41
         nDo5oaGrMotW1lbX8RamQBgKUhxoYBnxRIBw3hlUMM5Jy4gY/odIHLjMyQ2iUs4nJzVW
         QyW2rfIMyTFbrqjTi2uyvL3Myle2oq/cAtfpWcjDp+2wTBmJOu+aGtKUR7jPv48Scgcn
         olaw==
X-Forwarded-Encrypted: i=1; AJvYcCUyHNlhlvEb3+5gulRI44yjN1AgJlz/pzNo+hf+kIgH13w+qE+C/tt3PRSLU2R4X+rV87n8i/1eAzwfbBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e41i1gJl99EhwTc7tMipNsuoyBkOAsr9deU0RQgj8IaYtu69
	vbSxDLoE+mCwr4fytGTkzCTMfFjM+XO6nKfZAv3kC2K696j9fs+C54SdIcEue8qX/WdACrApGEZ
	+oQ1lvFBy26VOqK7DKnjGtWov+5s=
X-Google-Smtp-Source: AGHT+IF3gTDoOAl8ED/kCjlLGzYhGVYfSJYOR9PbRAbCJBbw5yEqvqufsOyphpMrXh0wEm0uJHyf/q1fzh4469MYZAA=
X-Received: by 2002:a05:6512:3f07:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-5389fc7fefemr1288020e87.45.1727424109957; Fri, 27 Sep 2024
 01:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <CAB=+i9TJcnFhwef+efw8yBynZ28M2tWiYvuYS0aVoD4yt_+0Zw@mail.gmail.com>
 <cb3b4858-00a8-459f-a195-7f9092f0da8e@suse.cz> <CA+kNDJKDFvA6bamTZ8tHTR+NRaV7NbK8sEQREyhwEOsTnroJjw@mail.gmail.com>
In-Reply-To: <CA+kNDJKDFvA6bamTZ8tHTR+NRaV7NbK8sEQREyhwEOsTnroJjw@mail.gmail.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Fri, 27 Sep 2024 17:01:37 +0900
Message-ID: <CAB=+i9Qz6xpMzV6pOwbdbAC-DBwXvBmUi7Zvjjvi3Yrhf4xX0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce panic function when slub leaks
To: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Fangzheng Zhang <fangzheng.zhang@unisoc.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:28=E2=80=AFPM zhang fangzheng
<fangzheng.zhang1003@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 8:30=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 9/25/24 15:18, Hyeonggon Yoo wrote:
> > > On Wed, Sep 25, 2024 at 12:23=E2=80=AFPM Fangzheng Zhang
> > > <fangzheng.zhang@unisoc.com> wrote:
> > >>
> > >> Hi all,
> > >
> > > Hi Fangzheng,
> > >
> > >> A method to detect slub leaks by monitoring its usage in real time
> > >> on the page allocation path of the slub. When the slub occupancy
> > >> exceeds the user-set value, it is considered that the slub is leakin=
g
> > >> at this time
> > >
> > > I'm not sure why this should be a kernel feature. Why not write a use=
r
> > > script that parses
> > > MemTotal: and Slab: part of /proc/meminfo file and generates a log
> > > entry or an alarm?
> >
> > Yes very much agreed. It seems rather arbitrary. Why slab, why not any =
other
> > kernel-specific counter in /proc/meminfo? Why include NR_SLAB_RECLAIMAB=
LE_B
> > when that's used by caches with shrinkers?
>
> Ok, this is because the current consideration is to specifically
> track the memory usage of the slab module.
> In the stability test, ie, monkey test,
> the anr or reboot problem occurs, there is a high probability
> that the slab occupancy is high when it comes to memory analysis.
> In addition to directly monitoring leaks in the allocation path, it is
> also convenient to record the allocation stack information
> when an exception occurs.

[+Cc Memory Allocation Profiling maintainers]

For recording allocation information, I think CONFIG_MEM_ALLOC_PROFILING [1=
] [2]
may be used to track allocation sites that contribute to memory leaks,
instead of making the kernel panic or printing WARNING?

.....Or with higher overhead, slub_debug=3DU [3] if it is not meant to
be run on production.

[1] https://docs.kernel.org/mm/allocation-profiling.html
[2] https://lwn.net/Articles/974380
[3] https://docs.kernel.org/mm/slub.html#debugfs-files-for-slub

Best,
Hyeonggon

> > A userspace solution should be straightforward and universal - easily
> > configurable for different scenarios.
> >
> > >> and a panic operation will be triggered immediately.
> > >
> > > I don't think it would be a good idea to panic unnecessarily.
> > > IMO it is not proper to panic when the kernel can still run.
> >
> > Yes these days it's practically impossible to add a BUG_ON() for more
> > serious conditions than this.
> >
> > Please don't post new versions addressing specific implementation detai=
ls
> > until this fundamental issue is addressed.
> >
> > Thanks,
> > Vlastimil
> >
> > > Any thoughts?
> > >
> > > Thanks,
> > > Hyeonggon
> >

