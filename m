Return-Path: <linux-kernel+bounces-237725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F598923D51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F580287253
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39A15D5B3;
	Tue,  2 Jul 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSEA7mx3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED982488
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922248; cv=none; b=nLIC6k+RT3Y8LDVzzfz2H17pd6ewNd+tnW32F8y6Z+u9jnUTFxCLyBkHt+UBQkEH2mjX4Qj4MTV7EjNROfhcz5G5F/zYSeEVcGsJbmktE285vrn5WV+8von/Psh8bvp9pQZjYmiYVn34GYOUjAjJSBvOQzv5ZJP7EB0q7vA408Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922248; c=relaxed/simple;
	bh=gpK30j0oArLlSHuV1v073xL7Hp4AUdKdX3WFBeUhCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJu0Mcc6h9QKdnb4efgPbQ2453T8wMJFpG8nZLMlO/6gNkIsoSea5IgJty4u3VIwGfdj0pFdtNTPgMlQ+Tbw2whFjNO2W+iegMXTxAaUrqxy5qRYi8RJVOMe7cfyxycoeY3HwXMLtNiVTNwIrD3VSYKnLXKGbyC/0yqfoKBddp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSEA7mx3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e829086f3so4137903e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719922244; x=1720527044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sk6SMKIZBTYojww5UQdhWUDCeIGJGhWzuYoweujQiDs=;
        b=jSEA7mx3Box3qiydtmIEgRqZ4mp0EaHDaY68F1QuvaC/MHGGnAtA6s5I+LIkqIKzhf
         IMeKQMSemU76BVROZWI4dYJ0JoJtECjypcPsYWXh5sI8WcGvP0EuosjpvJ6xTUwr48Ov
         KNrkeFZ7/4DjBnaCGY1mHRgxoeLuWg3R5wmgoI6FJX/hwWuoN4UBiIIACwfxGB1Xbn3i
         ykK7hgpHd6sZwGsoqrmyiQCLL4lEUfcq7Z48ywm00aucK2CNchVtzmJxUrIkncsbMbGy
         MG5W7hfHJt65a6g4SJmCVg+7TEMwxSDvnsH4uhCAHcEkdiWdWhVcbeQjpFv7wKG281DX
         ImJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922244; x=1720527044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk6SMKIZBTYojww5UQdhWUDCeIGJGhWzuYoweujQiDs=;
        b=oATbtcgvVQoNg7KgQhWK/Q9vWZNYBNvG8vu27opYgYX1WWyDqtDdQAHz2j8+Y5H+VX
         L9Nc9TLoZpzyXKVllWcqogNcPYCnYmOy3fuBulecAo0iJ21VPmmqWb2rJBP9j1GsZ4NF
         4pc29vtnJgIAijFutGsoJgIlCWGrVUgYU3DCQ9NT1+j38Hp7QkyZttnFqbFP57ASOF3v
         5hylXqsLUNl8Q3gBqWk5KDtBZRaWWhoLggP+owfUR7jTrbRWmz0yUx0UImh6tkZVHLHC
         cvnhb6ZpfEJToq4jCUB4XKSJaFzAmPeDThjsP7J1UVUIpafnaFSrytZ0ssi2VZVtT1YY
         t0nw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhTCpX2bwRJm6928KLWK0q/98wc3FDSxuJIwGVAJ4exDpegzNDFk6QoDS9ZkNJSFExTwOt+9L8v0vkrJm++xXR7bme9V5QIS+M2cW
X-Gm-Message-State: AOJu0YyhQG/dUEO4t/THp+OYbIn0/CBOY7lbAG9XF6VkppPWxUn5ZLmX
	LLtZ/eSDoFJmzOchvDw1nwUD4vFJNY4RciaGGdrB8RjGSpNr83iW
X-Google-Smtp-Source: AGHT+IG3CUeIVlUj6G6XOYwWOB9zYD1ECertR6Cc6YlVYqDuUpOjWexXWXWOsQdSdWR3c2Z8V2Varg==
X-Received: by 2002:a2e:a889:0:b0:2eb:dd0b:b9ec with SMTP id 38308e7fff4ca-2ee5e3a30e0mr66331721fa.20.1719922244116;
        Tue, 02 Jul 2024 05:10:44 -0700 (PDT)
Received: from f (cst-prg-31-46.cust.vodafone.cz. [46.135.31.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324feb7sm5628623a12.37.2024.07.02.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:10:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:10:32 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	linux-kernel@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [lockref]  d042dae6ad:  unixbench.throughput
 -33.7% regression
Message-ID: <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
References: <202406270912.633e6c61-oliver.sang@intel.com>
 <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>

On Tue, Jul 02, 2024 at 09:19:10AM +0200, Mateusz Guzik wrote:
> On Thu, Jun 27, 2024 at 10:41:35AM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -33.7% regression of unixbench.throughput on:
> > 
> > 
> > commit: d042dae6ad74df8a00ee8a3c6b77b53bc9e32f64 ("lockref: speculatively spin waiting for the lock to be released")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> [..]
> > | testcase: change | stress-ng: stress-ng.getdent.ops_per_sec -56.5% regression                                |
> [..]
> > | testcase: change | stress-ng: stress-ng.handle.ops_per_sec -60.2% regression                                 |
> > | test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
> [..]
> 
> Both good and bad news is that this particular patch should be dropped
> (but struct dentry reordering should stay). There is some gnarly stuff
> here, please read the entire thing, even though it may seem rambly at
> times.
> 
> To recap there can be a microbenchmark setting with continuous get/put
> traffic where only sporadically someone takes the lock. The constant
> traffic paired with immediate fallback to locking makes the primitives
> degrade to locked operation until benchmark is concluded.  This is the
> problem the patch tried to address as with dentry reordering I found
> myself running into the degraded state by accident a lot. There was
> worry lkp machinery would do too, disfiguring their results.
> 
> However, another microbenchmark setting can be mixing explicit spinlock
> acquire with lockref get/put. With high enough worker count the lock can
> be continuously held, making any spinning waiting for it to be released
> actively detrimental to performance. This is what the lkp folks ran
> into.
> 
> So I got a 2 socket * 48 cores * 2 threads machine to play with.
> 
> Both unixbench and stress-ng --getdent testcases are heavily mixed with
> read-write locking and mutexes, while stress-ng --handle is all about
> spinlocks and 1/3rd of it is lockref thus I only benchmarked the last
> one.
> 
> At a *low* scale of 24 workers at my usual test box performance improves
> immensely (from ~165k ops/s to ~620k ops/s) as locking is avoided plenty
> of times.
> 
> At 192 workers on the big box stock kernel achieves ~134k ops/s, while
> spinwait drops it to ~42k. As an experiment I added a dedicated waiting
> loop with configurable spin count. Doing merely one spin drops the rate
> to ~124k ops/s.
> 
> I figured I'm going to write the smallest patch which avoids locked-only
> degradation and call it a day -- for example it is possible to check if
> the lock is contested thanks to the arch_spin_is_contended macro.
> 
> Then the loop could be:
> 	if (lockref_locked(old)) {
> 		if (locked_contested(old))
> 			break;
> 		cpu_relax();
> 		old.lock_count = READ_ONCE(lockref->lock_count);
> 		continue;
> 	}
> 
> 
> Note how this avoids any additional accesses to the cacheline if the
> lock is under traffic. While this would avoid degrading in certain
> trivial cases, it very much can still result in lockref get/put being in
> the picture *and* only taking locks, so I'm not particularly happy with
> it.
> 
> This is where I found that going to 60 workers issuing open or stat on
> the same dentry *also* permanently degrades, for example:
> 
> # ./stat2_processes -t 60
> testcase:Same file stat
> warmup
> min:11293 max:25058 total:1164504
> min:10706 max:12977 total:679839
> min:10303 max:12222 total:643437
> min:8722 max:9846 total:542022
> min:8514 max:9554 total:529731
> min:8349 max:9296 total:519381
> measurement
> min:8203 max:9079 total:510768
> min:8122 max:8913 total:504069
> 
> According to perf top it's all contention on the spinlock and it is the
> lockref routines taking it. So something sneaks in a lock/unlock cycle
> and there is enough traffic that the default 100 spins with the patch
> are not sufficient to wait it out. With the configurable spin count I
> found this can stay lockless if I make it wait 1000 spins. Getting the
> spin count "wrong" further reduces performance -- for example with 700
> spin limit it was not enough to wait out the lock holders and throughput
> went down to ~269k due to time wasted spinning, merely a little more
> than half of the degraded state above.
> 
> That is to say messing with lockref itself is probably best avoided as
> getting a win depends on being at the right (low) scale or getting
> "lucky".
> 
> My worry about locked-only degradation showing up was not justified in
> that for the scales used by lkp folks it already occures.
> 
> All in all the thing to do is to find out who takes the spin lock and if
> it can be avoided. Perhaps this can be further split so that only spots
> depending on the refcount take the d_lock (for example in the --handle
> test the lock is taken to iterate the alias list -- it would not mind
> refs going up or down).
> 
> It may be (and I'm really just handwaving here) dentries should move
> away from lockref altogether in favor of storing flags in the refcount.
> Even if both get/put would still have to cmpxchg they would never have
> to concern itself with locking of any sort, except when the dentry is
> going down. And probably the unref side could merely lock xadd into it.
> I recognize this would convert some regular ops in other parts of the
> kernel into atomics and it may be undesirable. Something to ponder
> nonetheless.
> 
> At the end of the day:
> 1. this patch should be dropped, I don't think there is a good
> replacement either
> 2. the real fix would do something about the dentry lock itself or its
> consumers (maybe the lock is taken way more than it should?)

Well there is also the option of going full RCU in the fast path, which
I mentioned last time around lockref.

This would be applicable at least for stat, fstatx, readlink and access
syscalls.

It would not help the above bench though, but then again I don't think
it is doing anything realistic.

I'm going to poke around it when I find the time.

Maybe ditching lockref would be a good idea regardless if the above pans
out.

