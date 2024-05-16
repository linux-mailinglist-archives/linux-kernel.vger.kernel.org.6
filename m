Return-Path: <linux-kernel+bounces-181218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA88C7919
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F9287F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6414D2BF;
	Thu, 16 May 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcOsNhKp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581314B97C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872471; cv=none; b=j2HxQITG5SlYD6gTY2gxIAPdlP6FdWdPdhov2wtDadBLA2xq859pPF2ON4Vb7GNcgT72kqParZZ0x0ZQ2P4e70LOQwZZRBGil1WubZQ7yFAZD0Y3kGql+qNz3E2LWo6ie6kT1jlwyUW25I5runseSJmZbUxXc/2XHKC4w6lPgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872471; c=relaxed/simple;
	bh=FuE2SXn9fuN5E1glU5FxtdaSGvXvd7GtdLVAMfO9dhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFi46DTpAvuCMHeEiPY2RiQE92f42LiNy+LA2ru+G23b6SnodTUwwgXciP5FSCX5e0u973zC4MMW81RTQgZY3k490JzkuXVP/63tU+rXrm/uVfFZe2M8fzLfQ7lb2SVdrxvHjh1Oqrcj5jC6EiJKZ+V58epjYWQDnw2AgBFb6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcOsNhKp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so2422055a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715872468; x=1716477268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S2eWYwd0RSPH92xJmhlUyx+mVQoKIPweBEeWH6A6Bw=;
        b=ZcOsNhKp7Xt09y8+aoIDReJF/nIhufym7Ud0b06encGNro+xgZV17i0+eZSajhREu5
         xY/7bcDUQKLWe0K9qLJvoGcuQiLt5aNnw5VawCCFRDTSyC9LTEUF9Wy7Hmoa/gd8k2ar
         rNs3ELGy0RR/G6OdqnxNt7usZLS6gIHTTK3y7WPuAvLgXIXQKp/pdEyRmxsBld19hsRa
         e9cJgF07ysEn/oN8oqZcwscT3G+VzzPHH5dVsRsaFIqIHisuJZNBDrhETUg1S6hqm7ui
         PGElLbQObPXP+pKFN4rVcaTm2dkh4mT1l283HDlwpgHqL1k/7i7/vJVY6d/zaph/gHPc
         sGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872468; x=1716477268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S2eWYwd0RSPH92xJmhlUyx+mVQoKIPweBEeWH6A6Bw=;
        b=BzKWZmfIzWUAk9oM4F0aSfledIYNoWJgFhkLnklWEUXQgb5pBj7mqC8ZWgtUHiQlYV
         oFCPPuDaJcsYW0rSybs/LTFAv6GF+ZDX4huqHwU5YADm/NKjVBKAS9rHdvjVFWqWi8X+
         bhp5D+ubp2sS5Wqry8gbno7ZzbwdhCJ+nBOfe/TWW1QbM3iADSWFLYBXw6/XTKrlgLjI
         5G3DX8zQow3ZzgETRDsrSf1eLezZlzWWZadyhq65keREQPPGOEdFIWxVfWi10K3qJVRB
         t/BPiNlwjl/cvL/+su+epr4tAgFWTc8bAqLquysCtSCRG+7N5G7ueIkpMwwKSVq4oaS1
         sDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB/289PHHvPz8rXSzW6dc/yOpj0uTkBbi3x0Ge/mRTVo5wQUIBCR0dGSxUotE/JDVI8hqdIThlZZq8bU41kT6CrFeZqZwERR9EUst9
X-Gm-Message-State: AOJu0YyTI6JX0Hq+A602sgHb2TIXWB/EcB4L7brSNkR1HZtPZV4wX3T1
	EQIiFzvYEWxvKEafMfhYp0tgR0+rCZQKSCNYHasZVgtuhTS7k22u
X-Google-Smtp-Source: AGHT+IFthx2bnGaWcEtherBvVyvy/WIe+XS8j3rbgROOod0/ZXYgaulUNAalWPL4lXTxH+A/lctZwA==
X-Received: by 2002:a50:a6d4:0:b0:56e:3293:3777 with SMTP id 4fb4d7f45d1cf-5734d5c1594mr18621932a12.17.1715872467943;
        Thu, 16 May 2024 08:14:27 -0700 (PDT)
Received: from f (cst-prg-82-229.cust.vodafone.cz. [46.135.82.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c34e5ccsm10599095a12.95.2024.05.16.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:14:27 -0700 (PDT)
Date: Thu, 16 May 2024 17:14:06 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, 
	Rongwei Wang <rongwei.wrw@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, dennisszhou@gmail.com, shakeelb@google.com, jack@suse.cz, 
	surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz, vbabka@suse.cz, 
	yuzhao@google.com, yu.ma@intel.com, wangkefeng.wang@huawei.com, 
	sunnanyong@huawei.com
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
Message-ID: <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
 <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
 <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>

On Thu, May 16, 2024 at 07:50:52PM +0800, Kairui Song wrote:
> > > On 2024/4/18 22:20, Peng Zhang wrote:
> > >> From: ZhangPeng <zhangpeng362@huawei.com>
> > >>
> > >> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> > >> percpu_counter"), the rss_stats have converted into percpu_counter,
> > >> which convert the error margin from (nr_threads * 64) to approximately
> > >> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> > >> performance regression on fork/exec/shell. Even after commit
> > >> 14ef95be6f55
> > >> ("kernel/fork: group allocation/free of per-cpu counters for mm
> > >> struct"),
> > >> the performance of fork/exec/shell is still poor compared to previous
> > >> kernel versions.
> > >>
> > >> To mitigate performance regression, we delay the allocation of percpu
> > >> memory for rss_stats. Therefore, we convert mm's rss stats to use
> > >> percpu_counter atomic mode. For single-thread processes, rss_stat is in
> > >> atomic mode, which reduces the memory consumption and performance
> > >> regression caused by using percpu. For multiple-thread processes,
> > >> rss_stat is switched to the percpu mode to reduce the error margin.
> > >> We convert rss_stats from atomic mode to percpu mode only when the
> > >> second thread is created.
> 
> I've a patch series that is earlier than commit f1a7941243c1 ("mm:
> convert mm's rss stats into
> percpu_counter"):
> 
> https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/
> 
> Instead of a per-mm-per-cpu cache, it used only one global per-cpu
> cache, and flush it on schedule. Or, if the arch supports, flush and
> fetch it use mm bitmap as an optimization (like tlb shootdown).
> 

I just spotted this thread.

I have a rather long rant to write about the entire ordeal, but don't
have the time at the moment. I do have time to make some remarks though.

Rolling with a centralized counter and only distributing per-cpu upon
creation of a thread is something which was discussed last time and
which I was considering doing. Then life got it in the way and in the
meantime I managed to conclude it's a questionable idea anyway.

The state prior to the counters moving to per-cpu was not that great to
begin with, with quite a few serialization points. As far as allocating
stuff goes one example is mm_alloc_cid, with the following:
	mm->pcpu_cid = alloc_percpu(struct mm_cid);

Converting the code to avoid per-cpu rss counters in the common case or
the above patchset only damage-control the state back to what it was,
don't do anything to push things further.

Another note is that unfortunately userspace is increasingly
multithreaded for no good reason, see the Rust ecosystem as an example.

All that to say is that the multithreaded case is what has to get
faster, as a side effect possibly obsoleting both approaches proposed
above. I concede if there is nobody wiling to commit to doing the work
in the foreseeable future then indeed a damage-controlling solution
should land.

On that note in check_mm there is this loop:
        for (i = 0; i < NR_MM_COUNTERS; i++) {
                long x = percpu_counter_sum(&mm->rss_stat[i]);

This avoidably walks all cpus 4 times with a preemption and lock trip
for each round. Instead one can observe all modifications are supposed
to have already stopped and that this is allocated in a banch. A
routine, say percpu_counter_sum_many_unsafe, could do one iteration
without any locks or interrupt play and return an array. This should be
markedly faster and I perhaps will hack it up.

A part of The Real Solution(tm) would make counter allocations scale
(including mcid, not just rss) or dodge them (while maintaining the
per-cpu distribution, see below for one idea), but that boils down to
balancing scalability versus total memory usage. It is trivial to just
slap together a per-cpu cache of these allocations and have the problem
go away for benchmarking purposes, while being probably being too memory
hungry for actual usage.

I was pondering an allocator with caches per some number of cores (say 4
or 8). Microbenchmarks aside I suspect real workloads would not suffer
from contention at this kind of granularity. This would trivially reduce
memory usage compared to per-cpu caching. I suspect things like
mm_struct, task_struct, task stacks and similar would be fine with it.

Suppose mm_struct is allocated from a more coarse grained allocator than
per-cpu. Total number of cached objects would be lower than it is now.
That would also mean these allocated but not currently used mms could
hold on to other stuff, for example per-cpu rss and mcid counters. Then
should someone fork or exit, alloc/free_percpu would be avoided for most
cases. This would scale better and be faster single-threaded than the
current state.

(believe it or not this is not the actual long rant I have in mind)

I can't commit to work on the Real Solution though.

In the meantime I can submit percpu_counter_sum_many_unsafe as described
above if Denis likes the idea.

