Return-Path: <linux-kernel+bounces-215529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F078290942E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646A51F22779
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CED1862AE;
	Fri, 14 Jun 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT/JiCZR"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4C137905;
	Fri, 14 Jun 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718404508; cv=none; b=Y6l27sMBvN/vHTxVh1GSXyJ0wFY6BV3mQK7kIj/JFhTgUSE8Lu5d+ZjRlervQyFC/6RhShRCMq3ed+QLbn9NJHsqIwnRdiVTJOQUrlDuexU3WcXJgGcapCbGqVCCUGdEw+LdX6TD5FkrdVc4c4F69RbRM1hLFT+4kq8+NjY9R0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718404508; c=relaxed/simple;
	bh=E0I7vnsNiEgJ3h6oEt+1hD/h/hGcMM12yiRg06OyFvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TniWweus8iurXPh5XxLhSP0APyiLa+vbv+4X1Dg8Z0Fu5Sp3FYNVEMmqghpNO+tyerc4nBivI7jKVRzOUzRNR3XwM5dehx0/7RS77VAbJbiRR9sUCn72Jf/KC391I7c47/1IFtT90fK3qh/OWZ7gUpFhKxNdOasnL7DAX1Zh3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT/JiCZR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b09072c9d9so21280826d6.1;
        Fri, 14 Jun 2024 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718404505; x=1719009305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0I7vnsNiEgJ3h6oEt+1hD/h/hGcMM12yiRg06OyFvY=;
        b=JT/JiCZR6GyM5Qj+eLQtyJReGcM/Qeoih1RBybLQXAeNFjnWd7ZmaiXe5hLbjj1vec
         37xZQyFUNyX8kVD6bYX2DIItfBwhA/RSF+oqfSdTskxU0whyZQ5+TX11AztLoVAt7rtC
         Mb7eN77h34JrpDTdBWeTLtdAkCnGh3NhOhH2oAjvIKpF1MITw5n82nJ5yKHy5A109e4K
         3mbbEWXQIZE1QpVCSMEYqxowZYVb+YRc5A9Mv+V2dhWr4IRW0Cb5NVRghmLiiRX4c0zG
         TF5TuN1A4Ts49SA1KrRxG01ZLi2qEhjVldT+KTwlecTc5G1rDF08rYODtUncxWNwpmuw
         eVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718404505; x=1719009305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0I7vnsNiEgJ3h6oEt+1hD/h/hGcMM12yiRg06OyFvY=;
        b=m8FhFDMVYwN6nwZAj1INMYVqEdfJEldyL2UBFxcj+ILt28V4G6Oe/K3E12/6yPyw1e
         m2lIQfiR903nDLm5rSnP20mVZBtcv4TgobmaSgE6bEZ+eWLc7Sp6Me3BSgHr7ZDcgSh8
         sL5yptb47t1ExVy6kBx4s9IuA/P5haM6guExrXNcpA5PoP41KeNaxUfHlotidlX5MOgh
         e5/glNkxrQiGJ9uUisF8cMappfXxWR2iEfUAxF+JQh1iZ1OoIsDMTKS1GyRCsCXqKxmc
         p4MGb2gNwwuDHKNEXjCFlx6ixOVWdlLT25jI/YukVa6y+T4wRExtkr54FEcYCPAdldwp
         m5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVq56lLSv7/pH/tQCUlm5NqJ76i3sPYjoPvt5IISOz3piFCdC7Y87Oa8T2sYUr0YPLrEJO81VSebDwVLkgsfZu3lbQHH+GZ0pCg1jazuZhCj5TA1o1918dgx4oa21h348NsjYWoUqgh
X-Gm-Message-State: AOJu0YzZTTIlth9gf5Cm1UkfRcdQLUpLYcErBz2xI9HNWkmG4DQ5anAM
	/c2bdunUL+VEjFgqaH/JvBnO9OUT/RK6RGIm+QfzFEpD8n4gU11mci1Om4a1J3B4GOpQ0gjwyuM
	coJ7cIYOa/h8MvAbFUE5YM8xF74A=
X-Google-Smtp-Source: AGHT+IFHhWMz4bQc3O+IUtEZZ51wsvrPFXXryj9Yt8+5ij9PiDJPELvtZ5+wvOScKiEgqSJEtU7THcVmVIv2Tc6V2s0=
X-Received: by 2002:a0c:b711:0:b0:6af:3d00:bbfd with SMTP id
 6a1803df08f44-6b2af2fe509mr75117616d6.27.1718404505192; Fri, 14 Jun 2024
 15:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
 <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
In-Reply-To: <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 14 Jun 2024 15:34:54 -0700
Message-ID: <CAKEwX=NxBzd4Ev2z8j+J=TMUiVJwa-c8aHiwzMWG+FngGt6mUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:09=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B46=E6=9C=8814=E6=97=A5(=E9=87=91) 0:22 Nhat Pham <nphamcs@gma=
il.com>:
> >
> > Taking a step back from the correctness conversation, could you
> > include in the changelog of the patches and cover letter a realistic
> > scenario, along with user space-visible metrics that show (ideally all
> > 4, but at least some of the following):
> >
> > 1. A user problem (that affects performance, or usability, etc.) is hap=
pening.
> >
> > 2. The root cause is what we are trying to fix (for e.g in patch 1, we
> > are skipping over memcgs unnecessarily in the global shrinker loop).
> >
> > 3. The fix alleviates the root cause in b)
> >
> > 4. The userspace-visible problem goes away or is less serious.
> >
>
> Thank you for your suggestions.
> For quick response before submitting v2,
>
> 1.
> The visible issue is that pageout/in operations from active processes
> are slow when zswap is near its max pool size. This is particularly
> significant on small memory systems, where total swap usage exceeds
> what zswap can store. This means that old pages occupy most of the
> zswap pool space, and recent pages use swap disk directly.

Makes sense. You could probably check pswpin stats etc. to verify
this, or maybe some sort of tracing to measure performance impact?

>
> 2.
> This issue is caused by zswap keeping the pool size near 100%. Since
> the shrinker fails to shrink the pool to accept_thr_percent and zswap
> rejects incoming pages, rejection occurs more frequently than it
> should. The rejected pages are directly written to disk while zswap
> protects old pages from eviction, leading to slow pageout/in
> performance for recent pages on the swap disk.

Yeah this makes sense. The hysteresis heuristic is broken.

>
> 3.
> If the pool size were shrunk proactively, rejection by pool limit hits
> would be less likely. New incoming pages could be accepted as the pool
> gains some space in advance, while older pages are written back in the
> background. zswap would then be filled with recent pages, as expected
> in the LRU logic.
>
> Patch 1 and 2 make the shrinker reduce the pool to accept_thr_percent.
> Patch 3 makes zswap_store trigger the shrinker before reaching the max
> pool size. With this series, zswap will prepare some space to reduce
> the probability of problematic pool_limit_hit situation, thus reducing
> slow reclaim and the page priority inversion against LRU.

Makes sense, but do include numbers to back up your claims if you have them=
!

>
> 4.
> Once proactive shrinking reduces the pool size, pageouts complete
> instantly as long as the space prepared by shrinking can store the
> direct reclaim. If an admin sees a large pool_limit_hit, lowering
> accept_threshold_percent will improve active process performance.
>

This makes sense from a glance. Thank you for writing all of this, and
please include actual numbers from a benchmark to show these in your
v2, if you have them :)

> Regarding the production workload, I believe we are facing different situ=
ations.
>
> My intended workload is low-activity services distributed on small
> system like t2.nano, with 0.5G to 1G of RAM. There are a significant
> number of pool_limit_hits and the zswap pool usage sometimes stays
> near 100% filled by background service processes.
>
> When I evaluated zswap and zramswap, zswap performed well. I suppose
> this was because of its LRU. Once old pages occupied zramswap, there
> was no way to move pages from zramswap to the swap disk. zswap could
> adapt to this situation by writing back old pages in LRU order. We
> could benefit from compressed swap storing recent pages and also
> utilize overcommit backed by a large swap on disk.
>
> I think if a system has never seen a pool limit hit, there is no need
> to manage the costly LRU. In such cases, I will try zramswap.
>
> I am developing these patches by testing with artificially allocating
> large memory to fill the zswap pool (emulating background services),
> and then invoking another allocation to trigger direct reclaim
> (emulating short-live active process).
> On real devices, seeing much less pool_limit_hit by lower
> accept_thr_percent=3D50 and higher max_pool_percent=3D25.
> Note that before patch 3, zswap_store() did not count some of the
> rejection as pool_limit_hit properly (underestimated). we cannot
> compare the counter directly.

Sounds good! Did you see performance improvement from lowering
pool_limit_hit etc.?

>
> I will try to create a more reproducible realistic benchmark, but it
> might not be realistic for your workload.

Your approach is not interfering with our workload - we don't
encounter the global shrinker in production ever. That does not mean I
will not consider your code though - this is everyone's kernel, not
just Meta's kernel :)

What I was concerned with was if there were any real workloads at all
that benefit from it - as long as there are (which there seem to be
based on your description), and the approach does not hurt other
cases, I'm happy to review it for merging :)

And as I have stated before, I personally believe the global shrinker
needs to change. I just do not have the means to verify that any
ideas/improvement actually work in a realistic scenario (since our
production system does not encounter global shrinker). Thank you for
picking up the work!

