Return-Path: <linux-kernel+bounces-547686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4697A50C63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF644170F63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E5255230;
	Wed,  5 Mar 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiAnOYwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5B253F00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206011; cv=none; b=UX1x2tf/uvF9N59a1a53bFocWXbiVIQ+s0xg9DpZnpOzBuP672/P0n49KD1vjmJjQ2JK8XRHqepuWmdwBpJuH59Xd1BLBnCwQMoN/+jhQvFKOjR+xJV5VklmxUtJjBrcgMz929upsCsGHZFx4Pic8ODdGJDlfnEvdXwuIN3yzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206011; c=relaxed/simple;
	bh=aC6mYjF1pzNre2z77OkTbk87cUUG2fkKoOGVTg8Y0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAxZSUNJihVx7xbg8QPL5OPSYkw7VG18Rsk1JVpID6BFBohm6izsd3HeKtRv4YvTF7vIQKYFp+XDa4DayakxTJFar5FK/QHrB9yiYugEkB360MM3OUHC+41F0BNQj8vxejU7dekoaYBqh7PIuOLQE+ymSMnUYpDvKwSzQ9VPvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiAnOYwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8198EC4CED1;
	Wed,  5 Mar 2025 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206009;
	bh=aC6mYjF1pzNre2z77OkTbk87cUUG2fkKoOGVTg8Y0yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiAnOYwvWeZ5QAiif8mTmeJoI6D9cwgfVPqPHFOa3zFlxXO6fzcOZ0rXnC08PmIEj
	 TrEkA7hm0+0TqrkD0EuJQnG1mtrEyEcSU321f70z7iHW4pLE1f8yTCk8HI+5/7Pr7a
	 WIUSH4YbgOMz7KKYLx3m8xL8MIWQLs8nlBtCSv466QdHhjJ+xExxp2UOqaqT9TIPnH
	 UJ9SnE64yqas8YXeu44RNzpmMD9NFB3QDGasqIdiTmdf4QQRJcuC+6WhFaFSvj4J2x
	 UMUYFRFcoZjnvfXS12eQmZJOrp2jgxkBG+V8wPrdLcGlTtCivSurHyoyn9T5KtLFrR
	 JwI+ltvuosm5A==
Date: Wed, 5 Mar 2025 21:20:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8ix9YQEIdyAopCw@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <Z8isNxBxC9pcG4KL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8isNxBxC9pcG4KL@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> > On Sat, Mar 1, 2025 at 1:38 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Sat, Mar 01, 2025 at 10:05:56AM +0100, Uros Bizjak wrote:
> > > > OTOH, -Os, where different code size/performance heuristics are used, now
> > > > performs better w.r.t code size.
> > >
> > > Did anything change since:
> > >
> > > 281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
> > > 3a55fb0d9fe8 ("Tell the world we gave up on pushing CC_OPTIMIZE_FOR_SIZE")
> > >
> > > wrt -Os?
> > >
> > > Because if not, we still don't love -Os and you can drop the -Os argument.
> > 
> > The -Os argument was to show the effect of the patch when the compiler
> > is instructed to take care of the overall size. Giving the compiler
> > -O2 and then looking at the overall size of the produced binary is
> > just wrong.
> > 
> > > And without any perf data showing any improvement, this patch does nothing but
> > > enlarge -O2 size...
> > 
> > Even to my surprise, the patch has some noticeable effects on the
> > performance, please see the attachment in [1] for LMBench data or [2]
> > for some excerpts from the data. So, I think the patch has potential
> > to improve the performance.
> > 
> > [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/CAFULd4ZsSKwJ4Dz3cCAgaVsa4ypbb0e2savO-3_Ltbs=1wzgKQ@mail.gmail.com/
> 
> If you are measuring micro-costs, please make sure you pin the 
> workload to a single CPU (via 'taskset' for example) and run 'perf 
> stat --null --repeat 5' or so to measure the run-over-run noise of 
> the benchmark.

And if the benchmark is context-switching heavy, you'll want to use 
'perf stat -a' option to not have PMU context switching costs, and the 
-C option to only measure on the pinned CPU.


For example, to measure pipe handling overhead, the naive measurement is:

 starship:~> perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 6.939 [sec]

       6.939128 usecs/op
         144110 ops/sec
 starship:~> perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 6.879 [sec]

       6.879282 usecs/op
         145364 ops/sec

See how the run-to-run noise is 0.9%?

If we measure it naively with perf stat, we get:

 starship:~> perf stat perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 11.870 [sec]

      11.870403 usecs/op
          84243 ops/sec

 Performance counter stats for 'perf bench sched pipe':

         10,722.04 msec task-clock                       #    0.903 CPUs utilized             
         2,000,093      context-switches                 #  186.540 K/sec                     
               499      cpu-migrations                   #   46.540 /sec                      
             1,482      page-faults                      #  138.220 /sec                      
    27,853,380,218      cycles                           #    2.598 GHz                       
    18,434,409,889      stalled-cycles-frontend          #   66.18% frontend cycles idle      
    24,277,227,239      instructions                     #    0.87  insn per cycle            
                                                  #    0.76  stalled cycles per insn   
     5,001,727,980      branches                         #  466.490 M/sec                     
       572,756,283      branch-misses                    #   11.45% of all branches           

      11.875458968 seconds time elapsed

       0.271152000 seconds user
      11.272766000 seconds sys

See how the usecs/op increased by +70% due to PMU switching overhead?

With --null we can reduce the PMU switching overhead by only measuring 
elapsed time:

 starship:~> perf stat --null perf bench sched pipe
 # Running 'sched/pipe' benchmark:
 # Executed 1000000 pipe operations between two processes

     Total time: 6.916 [sec]

       6.916700 usecs/op
         144577 ops/sec

  Performance counter stats for 'perf bench sched pipe':

       6.921547909 seconds time elapsed

       0.341734000 seconds user
       6.215287000 seconds sys

But noise is still high:

 starship:~> perf stat --null --repeat 5 perf bench sched pipe
       6.854731 usecs/op
       7.082047 usecs/op
       7.087193 usecs/op
       6.934439 usecs/op
       7.056695 usecs/op
 ...
 Performance counter stats for 'perf bench sched pipe' (5 runs):

            7.0093 +- 0.0463 seconds time elapsed  ( +-  0.66% )

Likely due to the tasks migrating semi-randomly among cores.

We can pin them down to a single CPU (CPU2 in this case) via taskset:

 starship:~> taskset 4 perf stat --null --repeat 5 perf bench sched pipe
       5.575906 usecs/op
       5.637112 usecs/op
       5.532060 usecs/op
       5.703270 usecs/op
       5.506517 usecs/op
 
 Performance counter stats for 'perf bench sched pipe' (5 runs):

            5.5929 +- 0.0359 seconds time elapsed  ( +-  0.64% )

Note how performance increased by ~25%, due to lack of migration, but 
noise is still a bit high.

A good way to reduce noise is to measure instructions only:

 starship:~> taskset 0x4 perf stat -e instructions --repeat 5 perf bench sched pipe
       6.962279 usecs/op
       6.917374 usecs/op
       6.928672 usecs/op
       6.939555 usecs/op
       6.942980 usecs/op

 Performance counter stats for 'perf bench sched pipe' (5 runs):

    32,561,773,780      instructions                                                            ( +-  0.27% )

           6.93977 +- 0.00735 seconds time elapsed  ( +-  0.11% )

'Number of instructions executed' is an imperfect proxy for overhead. 
(Not every instruction has the same overhead - but for compiler code 
generation it's a useful proxy in most cases.)

But the best measurement is to avoid the PMU switching overhead via the 
'-a' option, and limiting the measurement to the saturated CPU#2:

 starship:~> taskset 0x4 perf stat -a -C 2 -e instructions --repeat 5 perf bench sched pipe
       5.808068 usecs/op
       5.843716 usecs/op
       5.826543 usecs/op
       5.801616 usecs/op
       5.793129 usecs/op

 Performance counter stats for 'system wide' (5 runs):

    32,244,691,275      instructions                                                            ( +-  0.21% )

           5.81624 +- 0.00912 seconds time elapsed  ( +-  0.16% )

Note how this measurement provides the highest performance for the 
workload, almost as good as --null.

 - Beware the difference in CPU mask parameters between taskset and perf 
   stat. (I tried to convince the perf tooling people to integrate 
   CPU-pinning into perf stat, but I digress.)

 - Beware of cpufreq considerations: changing CPU frequencies will skew 
   your workload's performance by a lot more than the 0.1% kind of 
   noise we are trying to gun for. Setting your CPU governor to 
   'performance' will eliminate some (but not all) cpufreq artifacts.

 - On modern systems there's also boot-to-boot variance of key data 
   structure alignment and cache access patterns, that can sometimes 
   rise beyond the noise of the measurement. These can send you on a 
   wild goose chase ...

Finally, you can use something like 'nice -n -10' to increase the 
priority of your benchmark and reduce the impact of other workloads 
running on your system.

Anyway, I think noise levels of around 0.1%-0.2% are about the best you 
can expect in context-switch heavy workloads. (A bit better in 
CPU-bound workloads with low context switching.)

Thanks,

	Ingo

