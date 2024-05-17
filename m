Return-Path: <linux-kernel+bounces-182501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C358C8C14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF4D1F22FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854113DDB7;
	Fri, 17 May 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzvy+dBO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1091FC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969346; cv=none; b=krQ2XUzOiWTyLW0BoWtA8/78RjXVobI04k4SrQJ9uikEHFoxiEJ2ZEpRHxyxGaQNqssuEAbcmG1vWD7R4eHasKEfJ/6gUtcPbV0vRl7dPs1qdQzt6HFlbXbcvVyKmfwOxAJx5mQDNgwh9Z6uZqak1Wd/UKL/8cKmdPk0uLUrKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969346; c=relaxed/simple;
	bh=gulGbYudQ3z+/C1aFN9r6ZE3YxntsPUKe40MP8WYjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfxJEyfoabsbw18COzAL6kixqy6ciXrPoDFfkhV9gfJ08A6mUN9YMyuMUvgLqW21diIpbBA3wrQ9eEF3WII7YscX78S2+gv0QkFJ3XIhhgkuJ/ZSD+PFPIc6eM+bM58zdqYoYlsLrxY0QzEp9EbuMsLV9e6MoC0rFamCpFcyRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzvy+dBO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso3505375e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715969343; x=1716574143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S70wmijJISH2XDqb7ht0G5vJ2xhskQ6j76ewB6PF6cM=;
        b=kzvy+dBO9Z0vvkMC/4wW893Bs0YcB8/j6Ny5CHEONfYpwnGdVg9RxftNZNni4/kvOW
         OzlpBAZAtp2lmn4f0jZbvh+wpLuit7LzKDhlkLhvbbEfALxVoEjNMVXUmi5eofDWfVip
         4d8oHpTXWCDkapSVBdzaaziB/4MJBj3EGCt3zG8/cp8+h1P/2EZZmIIA0aBdYoU5Q1V+
         k+SztTUsFEO9DXzOFOx4LXdlfJSyRYacK1cBa6ZqmmnIVHURbZQajPN7LBzGMCKsCaFo
         adUco34c/CftygZtOlgXWP+edchGOow9c6IJY7R19Wlr+ZTGOin2lU6H+rxN/12pSiyD
         6Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715969343; x=1716574143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S70wmijJISH2XDqb7ht0G5vJ2xhskQ6j76ewB6PF6cM=;
        b=u/crV5gCIjCIu9AABcheO2vFl9rKWLALnfILNagIRllehfvN9yKd62mu8HjGWebcYA
         cbNj73uwqcxe5mODAGHia2/9lW8Dwg3uyDMRFN7VhEFcKvd0u0m7fBbRXJXde1s/DBuk
         Trn1kBwRuKectJar7HzVBx3sY7WyBD14jqFUWtkRQvfqkyAsAnboEurUm5iuIFTif0R2
         6Ux84uf+W5RlwUxKfPKei/PqB6HJUo+Vp4DLZihXXQhWZiBb46K4jKw0lN9uCZj1EQi8
         hHoXME2mUNHp6bM1BLGzkzUSoRa6tuzoRntkxo58itFYEpsOUz5gMA7ZN1gjADQQCoas
         5tkA==
X-Forwarded-Encrypted: i=1; AJvYcCXKCq+CeK/nypxijjOIY50eEdRSzqf7St2yJdMog/Zeu8I+tOTYp4SPjTVhxCjiIgohxW9hIe6/hNnXwEw1JtHTVaxsKTTey/wOtVAr
X-Gm-Message-State: AOJu0YzNuxqjMoYT3D5pafwGA2tPUKp3cel16X4scYIwhypIbAFrFDGY
	CF1Z52ooJo+18kHQ8w1pJViTh5OeahtNHX4rv/fzTFZmU/DICX0s
X-Google-Smtp-Source: AGHT+IFnD/UIZ3ZG6RwuktTru2jpJebDU5Tcq74B7wHAksRTTMhHs0ay3Vr/shKBJaNwde29s5OOAQ==
X-Received: by 2002:a05:600c:314e:b0:41b:4443:9e10 with SMTP id 5b1f17b1804b1-41feac63467mr151572635e9.29.1715969343368;
        Fri, 17 May 2024 11:09:03 -0700 (PDT)
Received: from f (cst-prg-73-12.cust.vodafone.cz. [46.135.73.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f881110f9sm350488635e9.37.2024.05.17.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 11:09:02 -0700 (PDT)
Date: Fri, 17 May 2024 20:08:41 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, 
	Rongwei Wang <rongwei.wrw@gmail.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, dennisszhou@gmail.com, shakeelb@google.com, jack@suse.cz, 
	Suren Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev, mhocko@suse.cz, vbabka@suse.cz, 
	Yu Zhao <yuzhao@google.com>, yu.ma@intel.com, wangkefeng.wang@huawei.com, 
	sunnanyong@huawei.com
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
Message-ID: <iwlpzi4qnpqri6wegibnsvth4yfdszksfvfyiei3qb3a4serbv@zrw3zsp55zoh>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
 <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
 <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>
 <5nv3r7qilsye5jgqcjrrbiry6on7wtjmce6twqbxg6nmvczue3@ikc22ggphg3h>
 <CAMgjq7DgE6NZPR8Sf2nq3vpVG8ZoC03e8aXi-QKbiievi3BB_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DgE6NZPR8Sf2nq3vpVG8ZoC03e8aXi-QKbiievi3BB_g@mail.gmail.com>

On Fri, May 17, 2024 at 11:29:57AM +0800, Kairui Song wrote:
> Mateusz Guzik <mjguzik@gmail.com> 于 2024年5月16日周四 23:14写道：
> > A part of The Real Solution(tm) would make counter allocations scale
> > (including mcid, not just rss) or dodge them (while maintaining the
> > per-cpu distribution, see below for one idea), but that boils down to
> > balancing scalability versus total memory usage. It is trivial to just
> > slap together a per-cpu cache of these allocations and have the problem
> > go away for benchmarking purposes, while being probably being too memory
> > hungry for actual usage.
> >
> > I was pondering an allocator with caches per some number of cores (say 4
> > or 8). Microbenchmarks aside I suspect real workloads would not suffer
> > from contention at this kind of granularity. This would trivially reduce
> > memory usage compared to per-cpu caching. I suspect things like
> > mm_struct, task_struct, task stacks and similar would be fine with it.
> >
> > Suppose mm_struct is allocated from a more coarse grained allocator than
> > per-cpu. Total number of cached objects would be lower than it is now.
> > That would also mean these allocated but not currently used mms could
> > hold on to other stuff, for example per-cpu rss and mcid counters. Then
> > should someone fork or exit, alloc/free_percpu would be avoided for most
> > cases. This would scale better and be faster single-threaded than the
> > current state.
> 
> And what is the issue with using only one CPU cache, and flush on mm
> switch? No more alloc after boot, and the total (and fixed) memory
> usage is just about a few unsigned long per CPU, which should be even
> lower that the old RSS cache solution (4 unsigned long per task). And
> it scaled very well with many kinds of microbench or workload I've
> tested.
> 
> Unless the workload keeps doing something like "alloc one page then
> switch to another mm", I think the performance will be horrible
> already due to cache invalidations and many switch_*()s, RSS isn't
> really a concern there.
> 

I only skimmed through your patchset. I do think it has a legitimate
approach, but personally I would not do it like that due to the extra
work on context switches. However, I have 0 say about this, so you will
need to prod the mm overlords to get this moving forward.

Maybe I was not clear enough in my opening e-mail, so I'm going to
reiterate some bits: there are scalability problems in execve even with
your patchset or the one which uses atomics.  One of them concerns
another bit which allocates per-cpu memory (the mcid thing).

I note that sorting it out would possibly also take care of the rss
problem, outlining an example approach above.

