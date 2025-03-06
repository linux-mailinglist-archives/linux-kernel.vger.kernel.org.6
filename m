Return-Path: <linux-kernel+bounces-548707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558EA5486F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA7918958D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA4204686;
	Thu,  6 Mar 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="ar576irM"
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3121A76BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258407; cv=none; b=fY7t6I1uZCgV7jGXeh1iB3rjsK4otOpJ6EIz7MRMsqC3qpFJahilMJePajSmc1ziKKcV7nxGLZVioJDLpx9jFdnxaQzYBVmVDuP+rePKUbG5SvW4HHBF28272ovzNRFzzzhrtPz9EvPA/Tv0XTtixL3JDQH7DXodeY2iKsV8kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258407; c=relaxed/simple;
	bh=MQyGl26Whql4FvL52ynnLjyqxmPpjyEauG0LYmwzoVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HF6q1YDojLA2MQVFnuPgr6EMwA2hw8QeHYp9iibCwF8JDqjCU68vCLYrtR/RYBNkiFukVpmZzXJ2wRqR0gdRHLKCUC/SkxIfw7HzvpLMLhNwxJvrm/wpNO9FXw1wIETGPvp8hm/YQ/VVcwkI4/OnG3F7E7oZKKk/6IreVqrHRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=ar576irM; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Received: from localhost (ip-109-42-177-222.web.vodafone.de [109.42.177.222])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 526AqD7U021659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 6 Mar 2025 11:52:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1741258334; bh=MQyGl26Whql4FvL52ynnLjyqxmPpjyEauG0LYmwzoVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ar576irMuzc2sXSuJ1W8FiDS59YIegPWWoHsyA2nKIbxpFW1Nru5QoMZGghvBWFq4
	 +sXkUmQz81H+RVDSHDP8F7y/Nf5SM76khqqBCE6fR8tNN2GixiEcL2XUyM7oW3uh7C
	 YloJIAwxIeUKibq45HT+t/KNtBMcM6vOgqbHj3dY=
From: Dirk Gouders <dirk@gouders.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Dave
 Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus
 Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
In-Reply-To: <Z8ix9YQEIdyAopCw@gmail.com> (Ingo Molnar's message of "Wed, 5
	Mar 2025 21:20:05 +0100")
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
	<c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
	<CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
	<20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
	<CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
	<Z8isNxBxC9pcG4KL@gmail.com> <Z8ix9YQEIdyAopCw@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 06 Mar 2025 11:52:08 +0100
Message-ID: <gh8qpil9d3.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ingo,

my interest comes, because I just started to try to better understand
PCL and am reading the perf manual pages.  Perhaps I should therefore
keep my RO-bit permanent for some more months, but:

> And if the benchmark is context-switching heavy, you'll want to use 
> 'perf stat -a' option to not have PMU context switching costs, and the 

I'm sure you know what you are talking about so I don't doubt the above
is correct but perhaps, the manual page should also clarify -a:

-a::
--all-cpus::
        system-wide collection from all CPUs (default if no target is specified)

In the last example -a is combined with -C 2 which is even more irritating when
you just started with the manual pages.


But the main reason why I thought it might be OK to once toggle my
RO-bit is that I tried your examples and with the first one I have way
higher numbers than yours and I thought that must be, because you just
own the faster machine (as I would have expected):

>  starship:~> perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
>
>      Total time: 6.939 [sec]
>
>        6.939128 usecs/op
>          144110 ops/sec

lena:~> perf bench sched pipe
# Running 'sched/pipe' benchmark:
# Executed 1000000 pipe operations between two processes

     Total time: 11.129 [sec]

      11.129952 usecs/op
          89847 ops/sec

And I expected this to continue throughout the examples.

But -- to keep this short -- with the last example, my numbers are
suddenly significantly lower than yours:

>  starship:~> taskset 0x4 perf stat -a -C 2 -e instructions --repeat 5 perf bench sched pipe
>        5.808068 usecs/op
>        5.843716 usecs/op
>        5.826543 usecs/op
>        5.801616 usecs/op
>        5.793129 usecs/op
>
>  Performance counter stats for 'system wide' (5 runs):
>
>     32,244,691,275      instructions                                                            ( +-  0.21% )
>
>            5.81624 +- 0.00912 seconds time elapsed  ( +-  0.16% )

lena:~> taskset 0x4 perf stat -a -C 2 -e instructions --repeat 5 perf bench sched pipe
       4.204444 usecs/op
       4.169279 usecs/op
       4.186812 usecs/op
       4.217039 usecs/op
       4.208538 usecs/op

 Performance counter stats for 'system wide' (5 runs):

    14,196,762,588      instructions                                                            ( +-  0.04% )

           4.20203 +- 0.00854 seconds time elapsed  ( +-  0.20% )



Of course, I don't want to waste anyones time if this is a so obvious
thing that only newbies don't understand.  So, feel free to just ignore this.

Regards

Dirk

