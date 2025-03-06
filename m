Return-Path: <linux-kernel+bounces-548718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D740A54893
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760291726D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A6204F6E;
	Thu,  6 Mar 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL4039pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E99202984
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258766; cv=none; b=c6uuPm0DntKPidYiHMvrgMhd9yJ5wk9mLWjYm2S7qMvcT303ZonC0b36j0TVAGfhCHtYDZtzUjxTLdu+Iuzofu3BpVqcjVVze/F6p8L5GpwSbf1b5MboPy45rJmOBm9VPojCS5gLl+gvvADcS/oaPeNewZ106k4G0vgqYkvadkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258766; c=relaxed/simple;
	bh=oiKIBMvjUFZQtuUGRvuFWZOhGe9vd7B1krTsOAEz9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgtxQT/WNKXMUlt19IUl0+KP2XY7Id9LOWZsgT+3BHZt3Crkh23Cuhjznu4Id86vU/dD2Bp7sBnrDenfFwmemO8VxvGG4juQLQIrdxd4bZrMf9Tx9qAzsUYNVz+owrglyqnPq7Vm5tkUhm3CoQwQX1aKSE/qEkRxuuf2szxeByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL4039pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9629FC4CEE0;
	Thu,  6 Mar 2025 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258766;
	bh=oiKIBMvjUFZQtuUGRvuFWZOhGe9vd7B1krTsOAEz9Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL4039pbPMJisfHedVT/4GA3Kv1NSanOT/j6XHQr9F/eaPcgEcvP2IL4DPnY2qvqt
	 W9aphpmWNqePu4GZPzDJhASWEfQweJAvXYTmKcF8Qzoyuudq9K9iLxqJ7PBKp+uO9r
	 n89ZIbAcToQDN92nsh+nEsZqa+qIvBK97vEbKMBH0DhAc7A0WI7C99tC8b2WQOQhDX
	 Z1GFOURLT9rC4BdzuOnWUGM3SBhWZXhOrkoQd474ceSKg1/GtlalqZNsVEpS6n4G/f
	 aQ81lQb8T77i1U8gO+8Hd7PdpRVtZTYgWkyoDypmrWQiyAPfS3zKXvMPpSymlU3xwR
	 Bz4wWJzxAZ0FA==
Date: Thu, 6 Mar 2025 11:59:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dirk Gouders <dirk@gouders.net>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8mACAi4-kN4uBLz@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <Z8isNxBxC9pcG4KL@gmail.com>
 <Z8ix9YQEIdyAopCw@gmail.com>
 <gh8qpil9d3.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gh8qpil9d3.fsf@gouders.net>


( I've Cc:-ed some perf gents as to the measurement artifacts observed 
  below. Full report quoted below. )

* Dirk Gouders <dirk@gouders.net> wrote:

> Hi Ingo,
> 
> my interest comes, because I just started to try to better understand
> PCL and am reading the perf manual pages.  Perhaps I should therefore
> keep my RO-bit permanent for some more months, but:
> 
> > And if the benchmark is context-switching heavy, you'll want to use 
> > 'perf stat -a' option to not have PMU context switching costs, and the 
> 
> I'm sure you know what you are talking about so I don't doubt the above
> is correct but perhaps, the manual page should also clarify -a:
> 
> -a::
> --all-cpus::
>         system-wide collection from all CPUs (default if no target is specified)
> 
> In the last example -a is combined with -C 2 which is even more irritating when
> you just started with the manual pages.
> 
> 
> But the main reason why I thought it might be OK to once toggle my
> RO-bit is that I tried your examples and with the first one I have way
> higher numbers than yours and I thought that must be, because you just
> own the faster machine (as I would have expected):
> 
> >  starship:~> perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 6.939 [sec]
> >
> >        6.939128 usecs/op
> >          144110 ops/sec
> 
> lena:~> perf bench sched pipe
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 11.129 [sec]
> 
>       11.129952 usecs/op
>           89847 ops/sec
> 
> And I expected this to continue throughout the examples.
> 
> But -- to keep this short -- with the last example, my numbers are
> suddenly significantly lower than yours:
> 
> >  starship:~> taskset 0x4 perf stat -a -C 2 -e instructions --repeat 5 perf bench sched pipe
> >        5.808068 usecs/op
> >        5.843716 usecs/op
> >        5.826543 usecs/op
> >        5.801616 usecs/op
> >        5.793129 usecs/op
> >
> >  Performance counter stats for 'system wide' (5 runs):
> >
> >     32,244,691,275      instructions                                                            ( +-  0.21% )
> >
> >            5.81624 +- 0.00912 seconds time elapsed  ( +-  0.16% )
> 
> lena:~> taskset 0x4 perf stat -a -C 2 -e instructions --repeat 5 perf bench sched pipe
>        4.204444 usecs/op
>        4.169279 usecs/op
>        4.186812 usecs/op
>        4.217039 usecs/op
>        4.208538 usecs/op
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>     14,196,762,588      instructions                                                            ( +-  0.04% )
> 
>            4.20203 +- 0.00854 seconds time elapsed  ( +-  0.20% )
> 
> 
> 
> Of course, I don't want to waste anyones time if this is a so obvious
> thing that only newbies don't understand.  So, feel free to just ignore this.
> 
> Regards
> 
> Dirk

