Return-Path: <linux-kernel+bounces-528033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5BA412AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666A33A254F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40B1624C1;
	Mon, 24 Feb 2025 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke7MIECh"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EA156C5E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361002; cv=none; b=IA5filX+WOW80t91sy+pnV8TjRSxKuyqm93wTqaBHgJIc7Ux65BgIkfMmpy6rEcTuWgN/KpLb9wY+mG2dc5ZwO81krYvtfeUVjCR9iHFSC5hX/KfJEH6uZOTsGnFqUZkkxvoRXVxeesU+Xa3afnwlJQxKv+unRSsqSgMqV69yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361002; c=relaxed/simple;
	bh=TeWR9KLXTBmIKTfyhxrXWzdWVKnSHoMtCIlpTT/p9uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bczhI8cSi5oHZ5CGXktoePotY3fTbSZSZKjjdl95Si2ApvTdiN6PkE0YKRjZXBBIFbcdY4zoeVjYpU8JM+j+kcJM/F5TLsF7hhmoMeNa1bMCNpvGOsFNtsAQbipJA7c6E8/KUPJ1pO7EZaucc7v8zbfhZ5zC+ihL+s9aM3Vu+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke7MIECh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472098e6e75so380761cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740360999; x=1740965799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z0iilXXeFUJb8Y16LfAkZ2RuptL+aVBKvKCYUlU6uU=;
        b=Ke7MIECh1ikOMI+K4DiQjL8lL9Mlc8KaKGGvEy5lfjtQnoITHPQVrdkuA4wOgve1aF
         4rvRdrKQw43t4kuXeNtXPRyotBIXjCUZtxKMS1bx9zgukraBJLad5faAzVRY/sZprYbY
         vEXXBEGnVWtXPV9cJMIxl2EHh6Jw1nelHbvrzq1z7JLZ2wgO5/eWJcJOJrE0BaSWXUcv
         4eq49pMAQhCxt++Zv9t+Q1zEwQVttFjc0DyJqlh/arex/v7PIDbkIwo7PlbOJH1hResH
         ktmG6zUFz9Od4dXb0rMf9L7H4o7zd2P+vOMXH1GqPszcL/e3xyohVexyFmPEh3b5OiVu
         jq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360999; x=1740965799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z0iilXXeFUJb8Y16LfAkZ2RuptL+aVBKvKCYUlU6uU=;
        b=uvKg+U68vvQUkyBkr3y28psHZjhYeUldQsRI3dpGr1qR/KjQEdaDK4E1cRokzOtmHu
         J0FUPIUjY+UDbIj197HwiHC6tcxNExVvybegcpfVLytnPg5VHX77D4681NNdQsgyb0Sl
         HnwL5i7GB78flni/k34Nb7lqaArdwHLjmd6VU3RxbilW3xeaDhQjSgQZzNuPk8ATER9h
         Rwz/rdF6zayRZ36+e/SZNiq5sre3PIGD163Y+IjeiP1T9ngGedIU/ipka0Fnm2bVKw/i
         BOKSzu9IrUGf0KgkTisTh79glDHWUGHj+DP2/yvBeaMY45NPvJvYTsGGoKbCoz+GSuls
         Mirg==
X-Forwarded-Encrypted: i=1; AJvYcCUOtxqttbOXks1v6sPTIo2JVXYYDlccR2HR2RCaK1OOSvOqyY019PqeQaBqB812rWn1F1Hprhbmajzb/CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqFvO0MOcqMmYPErZ4NVfAmpK/LzQX5Ppq2m4oTQmOvxREsEc
	2EtN9n2l2UNoGpdsN+2nKNQalJ4cLvjlbNBG7lVvpN2FzcGzmwCSrtaYsx3tdHi5Om4bFQ4dx2Q
	RwdD1dJTHq5l3yykh7t5IgOmIeXhBKJUqcbPq
X-Gm-Gg: ASbGncuCsCJnmn6qGo7Vg7h/TSdOhhGcPyLrERqVySoCsaYAGZRRG3TViQn2MxAHDnv
	Hu27ktCD3jJRmUi2JliOk4eBxeH2RmbdGgoyaJWG/m3C40QnQBL9QKOTykf+3mTpcAMtRGpJugP
	D6AFRvTmU=
X-Google-Smtp-Source: AGHT+IHPYPjlFDSqGO+p0LMHymECdrDlqiQmBYt//urxRVRmELCUI4EioUeoj+QXByhoEOFDN8rmoDb6uqKX7u7x3vg=
X-Received: by 2002:a05:622a:3cd:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47234b4f60amr4398531cf.1.1740360998584; Sun, 23 Feb 2025
 17:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd> <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
In-Reply-To: <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 23 Feb 2025 17:36:27 -0800
X-Gm-Features: AWEUYZmlUqp1pDA_wMiYyR9GBcFZPosDdJv_JqLSwV5RNu8wPZMrLyH-r3FhCWM
Message-ID: <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 8:44=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sat, Feb 22, 2025 at 4:19=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> > > - Cheaper fast paths. For allocations, instead of local double cmpxch=
g,
> > >   after Patch 5 it's preempt_disable() and no atomic operations. Same=
 for
> > >   freeing, which is normally a local double cmpxchg only for a short
> > >   term allocations (so the same slab is still active on the same cpu =
when
> > >   freeing the object) and a more costly locked double cmpxchg otherwi=
se.
> > >   The downside is the lack of NUMA locality guarantees for the alloca=
ted
> > >   objects.
> >
> > Is that really cheaper than a local non locked double cmpxchg?
>
> Don't know about this particular part but testing sheaves with maple
> node cache and stress testing mmap/munmap syscalls shows performance
> benefits as long as there is some delay to let kfree_rcu() do its job.
> I'm still gathering results and will most likely post them tomorrow.

Here are the promised test results:

First I ran an Android app cycle test comparing the baseline against sheave=
s
used for maple tree nodes (as this patchset implements). I registered about
3% improvement in app launch times, indicating improvement in mmap syscall
performance.
Next I ran an mmap stress test which maps 5 1-page readable file-backed
areas, faults them in and finally unmaps them, timing mmap syscalls.
Repeats that 200000 cycles and reports the total time. Average of 10 such
runs is used as the final result.
3 configurations were tested:

1. Sheaves used for maple tree nodes only (this patchset).

2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conversion [=
1].
This patchset avoids allocating additional vm_lock structure on each mmap
syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.

3. Sheaves used for maple tree nodes and for vm_area_struct cache with vm_l=
ock
to vm_refcnt conversion [1]. For the vm_area_struct cache I had to replace
TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache.

The values represent the total time it took to perform mmap syscalls, less =
is
better.

(1)                  baseline       control
Little core       7.58327       6.614939 (-12.77%)
Medium core  2.125315     1.428702 (-32.78%)
Big core          0.514673     0.422948 (-17.82%)

(2)                  baseline      control
Little core       7.58327       5.141478 (-32.20%)
Medium core  2.125315     0.427692 (-79.88%)
Big core          0.514673    0.046642 (-90.94%)

(3)                   baseline      control
Little core        7.58327      4.779624 (-36.97%)
Medium core   2.125315    0.450368 (-78.81%)
Big core           0.514673    0.037776 (-92.66%)

Results in (3) vs (2) indicate that using sheaves for vm_area_struct
yields slightly better averages and I noticed that this was mostly due
to sheaves results missing occasional spikes that worsened
TYPESAFE_BY_RCU averages (the results seemed more stable with
sheaves).

[1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/

>
> >
> > Especially if you now have to use pushf/popf...
> >
> > > - kfree_rcu() batching and recycling. kfree_rcu() will put objects to=
 a
> > >   separate percpu sheaf and only submit the whole sheaf to call_rcu()
> > >   when full. After the grace period, the sheaf can be used for
> > >   allocations, which is more efficient than freeing and reallocating
> > >   individual slab objects (even with the batching done by kfree_rcu()
> > >   implementation itself). In case only some cpus are allowed to handl=
e rcu
> > >   callbacks, the sheaf can still be made available to other cpus on t=
he
> > >   same node via the shared barn. The maple_node cache uses kfree_rcu(=
) and
> > >   thus can benefit from this.
> >
> > Have you looked at fs/bcachefs/rcu_pending.c?

