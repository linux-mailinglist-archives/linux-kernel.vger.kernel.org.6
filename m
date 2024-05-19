Return-Path: <linux-kernel+bounces-183122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415858C94F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648F91C20E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CC48CC7;
	Sun, 19 May 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdxkVkkA"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91A8BEA
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128027; cv=none; b=lCwIIZt2OzElHOOwYGD54YNEsHmkArYin4PLCOzvuFTu30e6a0kOQk4niHdBG5PPnQip0YdNzONoyF/k8NaO0IzQTMcHgE6B2RJpNbwlRtPlVdaiZlKIlHIg95T1m23I+E2wOW66KkkUlAhPtCU8D4Qt0nC514jASTrEHQbwNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128027; c=relaxed/simple;
	bh=9t6jwH3FrP0vS5iN/jNE2kGzhEUu2R/PkRBXRDaNa84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thAS2V2UuMqFb2pnqmCnw3yIsIFgDsMUFLM8VzuHKiJzqaKYg3wVIRR09afXfUY9WD0KhQmq03BkW5wX1XEocUDIVZKis8vLnpiK5+G79W487H/U10GfiTtfWHYW1OIQsPI5cagwjc4PteLTagDFPvq7VSYZVMM96lMMxKqzKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdxkVkkA; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2baa24c2bso866272eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716128025; x=1716732825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHrw/x5NVoGqtuVQNcrErFWhfjb0N0uwlSFD9+cPjas=;
        b=kdxkVkkAO7l4/FGF6xVfPmCMXXL17pUhHJ8RzmfEwnTRdidaPJ89605aM+Pmjjle+A
         k1YGPiQ0SFikdtXoZdz2n1pHioqpgnV9bQymUAl56jzTy2WDuC6pbu7XgoTNolcs1zFK
         80nl02CHcHR1oI3dSIeTVX671HKTEe75+8bNTZiI7EjWXJNTB9+ooW7pohDRUz6xV5pC
         5N6vioOvS6ySc5SUjmDhFuRegrMSFgNVzPY1ppTggQYh6xrd7Xxpyn8dLUrG93WIHEXO
         daNCi56JJ7b1CX6AkTdMTtnU7O8L2DlcB4hH00rlW9sSMKJhCwPljx8lrjsqpc+uNE4e
         2Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716128025; x=1716732825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHrw/x5NVoGqtuVQNcrErFWhfjb0N0uwlSFD9+cPjas=;
        b=jSRXfBP/niB6Zl6muI9jyj2sI1SVtdx7qiQwa4/FzqBQCf3c62tW1o162RPa64cYdj
         twI2PYSZaa/5kZw8f0iFpmzgIXvYptZpJsuzWgHSDS9otAXFASqJUa8qyyKqWpo13kV0
         B4SWkbKb2uNGKJUMAofDJjiYiENcmJ2/M0pEtkORH6HpDZtdiOHO/oRhAEkdp7N/n9QA
         FcjSK2n3Amz/C49XPA8OM2Rp9sj6zwltxxvKffhVCcL7iReK1Z4pbzpgGoaBOsnBSWHZ
         rILRupvb0pOnBzrFO0ih1ydn4xObHNoJt2REvuNOP+AwCCxRyMoiq87nBFvep4eS/cx5
         eUxg==
X-Forwarded-Encrypted: i=1; AJvYcCW5uW06W6JjcDxYwhMrAEHzqvwRqqlBd59PUC3N8qcbdg/MeWcprnFH5eeTy4vY0QgyMm8+e+B40LqZs9IN7Wdk2uxVQdQbEUybVPtl
X-Gm-Message-State: AOJu0YzVUmhrlREP6iq/Fz1ZGdp8nAuJYdTwoT3wr71g61RJQSYIDwx8
	Jb9IAsVPkdwfFIaYMe6zIJc96/X6JJlqzzryweRfm6sFtrfvN4oPDfT6t8JX
X-Google-Smtp-Source: AGHT+IFEmSZ/a8PpAbsS7AI+i8TGHMbB4LmiK3qZj++q80foFK5Zl7fz92u6Q03LAk63OkdLP/9agA==
X-Received: by 2002:a05:6359:4c9f:b0:186:3beb:90e0 with SMTP id e5c5f4694b2df-193bb64d4d4mr2667711355d.18.1716128024862;
        Sun, 19 May 2024 07:13:44 -0700 (PDT)
Received: from snowbird ([2600:4041:54fc:a302:414c:9ba6:5d92:63bc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56a57afsm135905681cf.73.2024.05.19.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 07:13:43 -0700 (PDT)
Date: Sun, 19 May 2024 07:13:40 -0700
From: Dennis Zhou <dennisszhou@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>,
	"zhangpeng (AS)" <zhangpeng362@huawei.com>,
	Rongwei Wang <rongwei.wrw@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dennisszhou@gmail.com, shakeelb@google.com, jack@suse.cz,
	surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz,
	vbabka@suse.cz, yuzhao@google.com, yu.ma@intel.com,
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
Message-ID: <ZkoJFBfz7P3xuCrx@snowbird>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
 <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
 <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>
 <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>

Hi Mateusz and Kairui,

On Thu, May 16, 2024 at 05:14:06PM +0200, Mateusz Guzik wrote:
> On Thu, May 16, 2024 at 07:50:52PM +0800, Kairui Song wrote:
> > > > On 2024/4/18 22:20, Peng Zhang wrote:
> > > >> From: ZhangPeng <zhangpeng362@huawei.com>
> > > >>
> > > >> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> > > >> percpu_counter"), the rss_stats have converted into percpu_counter,
> > > >> which convert the error margin from (nr_threads * 64) to approximately
> > > >> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> > > >> performance regression on fork/exec/shell. Even after commit
> > > >> 14ef95be6f55
> > > >> ("kernel/fork: group allocation/free of per-cpu counters for mm
> > > >> struct"),
> > > >> the performance of fork/exec/shell is still poor compared to previous
> > > >> kernel versions.
> > > >>
> > > >> To mitigate performance regression, we delay the allocation of percpu
> > > >> memory for rss_stats. Therefore, we convert mm's rss stats to use
> > > >> percpu_counter atomic mode. For single-thread processes, rss_stat is in
> > > >> atomic mode, which reduces the memory consumption and performance
> > > >> regression caused by using percpu. For multiple-thread processes,
> > > >> rss_stat is switched to the percpu mode to reduce the error margin.
> > > >> We convert rss_stats from atomic mode to percpu mode only when the
> > > >> second thread is created.
> > 
> > I've a patch series that is earlier than commit f1a7941243c1 ("mm:
> > convert mm's rss stats into
> > percpu_counter"):
> > 
> > https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/
> > 

I hadn't seen this series as my inbox filters on percpu, but not
per-cpu. I can take a closer look this week.

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

To clarify my stance, I'm not against the API of switching a
percpu_counter to percpu mode. We do it for percpu_refcount. I think the
implementation here was fragile. Secondly, Kent did implement
lazy_percpu_counters. We likely should see how that can be leveraged and
how we can reconcile the 2 APIs.

> The state prior to the counters moving to per-cpu was not that great to
> begin with, with quite a few serialization points. As far as allocating
> stuff goes one example is mm_alloc_cid, with the following:
> 	mm->pcpu_cid = alloc_percpu(struct mm_cid);
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
> 
> On that note in check_mm there is this loop:
>         for (i = 0; i < NR_MM_COUNTERS; i++) {
>                 long x = percpu_counter_sum(&mm->rss_stat[i]);
> 
> This avoidably walks all cpus 4 times with a preemption and lock trip
> for each round. Instead one can observe all modifications are supposed
> to have already stopped and that this is allocated in a banch. A
> routine, say percpu_counter_sum_many_unsafe, could do one iteration
> without any locks or interrupt play and return an array. This should be
> markedly faster and I perhaps will hack it up.

I'm a little worried about the correctness in the cpu_hotplug case, idk
if it's warranted.

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
> 
> (believe it or not this is not the actual long rant I have in mind)
> 
> I can't commit to work on the Real Solution though.
> 
> In the meantime I can submit percpu_counter_sum_many_unsafe as described
> above if Denis likes the idea.

To be honest, I'm a little out of my depth here. I haven't spent a lot
of time in the mm code paths to really know when and how we're
accounting RSS and other stats. Given that, I think we should align on
the approach we want to take because in some way it sounds like percpu
RSS might not be the final evolution here for this and other stats.

I think lets hold off on percpu_counter_sum_many_unsafe() initially and
if that's the way we have to go so be it. I'm going to respin a
cpu_hotplug related series that might change some of the correctness
here and have that ready for the v6.11 merge window.

Thanks,
Dennis

