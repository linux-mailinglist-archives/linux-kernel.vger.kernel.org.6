Return-Path: <linux-kernel+bounces-181718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDF8C8030
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396D1282055
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE310A25;
	Fri, 17 May 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gihMkjok"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFD10A09
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916618; cv=none; b=isnheUgNwLUF/iw7Nyple9qspH0BYMnwo2KL4Sc+Lohd5rUArI/hkuOLJH7aq5xq7NE1c0HoXo+dDKq2VKApdAw4t3TMcocMBtKmeGkotpZykXvfODIrmfh0WIMy5Nd32M7R78sM+omvF0wSlrDhCs7UeJQLIjljD7OjlClKSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916618; c=relaxed/simple;
	bh=Xm9gOqUBaf688SaRu8s+Kakp+APap5QeqRhDKUwrOlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ldoq+ngyZfaVYnH2Uy+faAw7UdUBibQSTxt1BSWKM4DhuA3vqLclu87DRgCcCvqYHX4Y0cVbK3Wi8ngDYfKqi442K0z85oV1TMlAXbDdFQgT+rg2rGIP4ba0FnC7uph+KP3iUX1/W43dRt6Q4IVUy7NgnqRSO0fXZVgkyugyugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gihMkjok; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e2b468ea12so13067111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715916615; x=1716521415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cz7/vI1LH0f2WLQEBvwGZZcGzYd1g9y6LcZk4JclSo=;
        b=gihMkjokOXP8g7kbB2+83rv7ejT94BnJHEnaTuJ0xVs9HfVPXE1ES1HJgIaTfVHKZr
         AFltd+/UT0cFu6bcJap1NsEP1DjDs+/cAT45AYONbwAMa7QcHk26/hJIPpBZHwppf7Cr
         Un95dDeWpn6VwpU6SGLnH06hNzlsfHqD4ywoKvOHOq5XSSRxbNJ0BqR/LnkNwxAYjyn5
         96HO8nRLP7DgqpwgfwyKztWkvNSZ7KBeKo0CL8HND+Qevleo+bkoLMKqBxKkikz3EVvj
         2Kv7EOA4vzSFphqy683LnAXmilUlH8aVsuqPdsVfC5cBQUookz+v8gAkN8s6INQdXql4
         olXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916615; x=1716521415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cz7/vI1LH0f2WLQEBvwGZZcGzYd1g9y6LcZk4JclSo=;
        b=gHY9Wr4Ps/xRr3tbZ5FCRSvT+2jfVQSxF2KE6Woe9m8SAiMGd38oVhDPoQCWH5R+dj
         yr+URi8inrZgQeEOakfp3/Hqoy2ee2bYzJc8zmxO/KfOD0I7L7LEKMlfJKd1KWhLNP9d
         s0LoSokPOR9B8RYg5JAJHbwvpeaLLM0f3coPpKUuoRn7P13oQvJ08l/mX7l9XVzx72Bq
         aEZ1fF9Qkdks+I3f1KmgEtGnfGFze9NYm83g3swp6gdn4fVMBMJDArwGfSb9ViGPOqIS
         p7NDWZt3m56zdk13eNTeb7Hi+48Ubd0B5jfUX5hKUYcITxCdxtb4adnjlajZIa+ciI0B
         lkpg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dAHhZ103KY+9dyGwfHvgWHVlQ2oG1IWQR3PO7fHy3sY8UPkMCjPEvYJqfH9+hUpqOkdkaSorl3WZv1Ws6fiEPAu8KG4fd0qnJil0
X-Gm-Message-State: AOJu0YzaBm7Yg4L2UneZ0WsbJJQKxbNs0/DECN/3l7AlsoMcJ0Q11S3w
	lHGM+e1z4MW+QMKz3yYDeqIMiOrkceD4KjijLD21akacr2I/nT1KElI7Th8Nu/7teNKjSOA+4eC
	WUyKfBf+0xGSvcJU2bNWcMpuYcoo=
X-Google-Smtp-Source: AGHT+IHxdGRowkhI8JyVI/R/U+n2YMZLnVoEbowchZjFVvm0PTMlqKjRrbJSZNvULmQ438LX58zIBcV/whp7Xh2hA08=
X-Received: by 2002:a2e:3518:0:b0:2e5:67a8:10fc with SMTP id
 38308e7fff4ca-2e567a811e0mr56894041fa.9.1715916614622; Thu, 16 May 2024
 20:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com> <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com> <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>
 <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>
In-Reply-To: <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 17 May 2024 11:29:57 +0800
Message-ID: <CAMgjq7DgE6NZPR8Sf2nq3vpVG8ZoC03e8aXi-QKbiievi3BB_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, Rongwei Wang <rongwei.wrw@gmail.com>, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	dennisszhou@gmail.com, shakeelb@google.com, jack@suse.cz, 
	Suren Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev, mhocko@suse.cz, 
	vbabka@suse.cz, Yu Zhao <yuzhao@google.com>, yu.ma@intel.com, 
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mateusz Guzik <mjguzik@gmail.com> =E4=BA=8E 2024=E5=B9=B45=E6=9C=8816=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 16, 2024 at 07:50:52PM +0800, Kairui Song wrote:
> > > > On 2024/4/18 22:20, Peng Zhang wrote:
> > > >> From: ZhangPeng <zhangpeng362@huawei.com>
> > > >>
> > > >> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> > > >> percpu_counter"), the rss_stats have converted into percpu_counter=
,
> > > >> which convert the error margin from (nr_threads * 64) to approxima=
tely
> > > >> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() cau=
ses a
> > > >> performance regression on fork/exec/shell. Even after commit
> > > >> 14ef95be6f55
> > > >> ("kernel/fork: group allocation/free of per-cpu counters for mm
> > > >> struct"),
> > > >> the performance of fork/exec/shell is still poor compared to previ=
ous
> > > >> kernel versions.
> > > >>
> > > >> To mitigate performance regression, we delay the allocation of per=
cpu
> > > >> memory for rss_stats. Therefore, we convert mm's rss stats to use
> > > >> percpu_counter atomic mode. For single-thread processes, rss_stat =
is in
> > > >> atomic mode, which reduces the memory consumption and performance
> > > >> regression caused by using percpu. For multiple-thread processes,
> > > >> rss_stat is switched to the percpu mode to reduce the error margin=
.
> > > >> We convert rss_stats from atomic mode to percpu mode only when the
> > > >> second thread is created.
> >
> > I've a patch series that is earlier than commit f1a7941243c1 ("mm:
> > convert mm's rss stats into
> > percpu_counter"):
> >
> > https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com=
/
> >
> > Instead of a per-mm-per-cpu cache, it used only one global per-cpu
> > cache, and flush it on schedule. Or, if the arch supports, flush and
> > fetch it use mm bitmap as an optimization (like tlb shootdown).
> >
>
> I just spotted this thread.
>
> I have a rather long rant to write about the entire ordeal, but don't
> have the time at the moment. I do have time to make some remarks though.
>
> Rolling with a centralized counter and only distributing per-cpu upon
> creation of a thread is something which was discussed last time and
> which I was considering doing. Then life got it in the way and in the
> meantime I managed to conclude it's a questionable idea anyway.
>
> The state prior to the counters moving to per-cpu was not that great to
> begin with, with quite a few serialization points. As far as allocating
> stuff goes one example is mm_alloc_cid, with the following:
>         mm->pcpu_cid =3D alloc_percpu(struct mm_cid);
>
> Converting the code to avoid per-cpu rss counters in the common case or
> the above patchset only damage-control the state back to what it was,
> don't do anything to push things further.
>
> Another note is that unfortunately userspace is increasingly
> multithreaded for no good reason, see the Rust ecosystem as an example.
>
> All that to say is that the multithreaded case is what has to get
> faster, as a side effect possibly obsoleting both approaches proposed
> above. I concede if there is nobody wiling to commit to doing the work
> in the foreseeable future then indeed a damage-controlling solution
> should land.

Hi, Mateusz,

Which patch are you referencing? My series didn't need any allocations
on thread creation or destruction. Also RSS update is extremely
lightweight (pretty much just read GS and do a few ADD/INC, that's
all), performance is better than all even with micro benchmarks. RSS
read only collects info from CPUs that may contain real updates.

I understand you may not have time to go through my series... but I
think I should add some details here.

> On that note in check_mm there is this loop:
>         for (i =3D 0; i < NR_MM_COUNTERS; i++) {
>                 long x =3D percpu_counter_sum(&mm->rss_stat[i]);
>
> This avoidably walks all cpus 4 times with a preemption and lock trip
> for each round. Instead one can observe all modifications are supposed
> to have already stopped and that this is allocated in a banch. A
> routine, say percpu_counter_sum_many_unsafe, could do one iteration
> without any locks or interrupt play and return an array. This should be
> markedly faster and I perhaps will hack it up.

Which is similar to the RSS read in my earlier series... It is based
on the assumption that updates are likely stopped so just read the
counter "unsafely" with a double (and fast) check to ensure no race.

And even more, when coupled with mm shootdown
(CONFIG_ARCH_PCP_RSS_USE_CPUMASK), it doesn't need to collect RSS info
on thread exit at all.

>
> A part of The Real Solution(tm) would make counter allocations scale
> (including mcid, not just rss) or dodge them (while maintaining the
> per-cpu distribution, see below for one idea), but that boils down to
> balancing scalability versus total memory usage. It is trivial to just
> slap together a per-cpu cache of these allocations and have the problem
> go away for benchmarking purposes, while being probably being too memory
> hungry for actual usage.
>
> I was pondering an allocator with caches per some number of cores (say 4
> or 8). Microbenchmarks aside I suspect real workloads would not suffer
> from contention at this kind of granularity. This would trivially reduce
> memory usage compared to per-cpu caching. I suspect things like
> mm_struct, task_struct, task stacks and similar would be fine with it.
>
> Suppose mm_struct is allocated from a more coarse grained allocator than
> per-cpu. Total number of cached objects would be lower than it is now.
> That would also mean these allocated but not currently used mms could
> hold on to other stuff, for example per-cpu rss and mcid counters. Then
> should someone fork or exit, alloc/free_percpu would be avoided for most
> cases. This would scale better and be faster single-threaded than the
> current state.

And what is the issue with using only one CPU cache, and flush on mm
switch? No more alloc after boot, and the total (and fixed) memory
usage is just about a few unsigned long per CPU, which should be even
lower that the old RSS cache solution (4 unsigned long per task). And
it scaled very well with many kinds of microbench or workload I've
tested.

Unless the workload keeps doing something like "alloc one page then
switch to another mm", I think the performance will be horrible
already due to cache invalidations and many switch_*()s, RSS isn't
really a concern there.

>
> (believe it or not this is not the actual long rant I have in mind)
>
> I can't commit to work on the Real Solution though.
>
> In the meantime I can submit percpu_counter_sum_many_unsafe as described
> above if Denis likes the idea.

