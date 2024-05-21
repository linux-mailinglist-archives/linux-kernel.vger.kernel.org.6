Return-Path: <linux-kernel+bounces-184485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE98CA74B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90261F20CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74E2AE6A;
	Tue, 21 May 2024 04:19:45 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC5210E4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265185; cv=none; b=FlsK/RsXkojF1ea6aNRDqV6vXuuuUGLU6TnAldzaNmZD/fCsMHrazJOxh9OZebYSs7co4kvquZy0IGDDRSYMRTlQFz2iRoQFUfqj+OD05yadM+YnDtPuVI2EZqO1fDH4w7VRibGmjmuPM0xICl/V0Xv8qu9i+ljrqjrb9jARIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265185; c=relaxed/simple;
	bh=wHGpajsp44Eo59yaaiNykvn9+Z14paSnNHjvL+KibaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSwOccj+Q3E1yg2Yb72eQ9M0aZtpndrGGTeGz5D/HjBj7r9Yxf2XgNECJ8j7tfepg38AcIFY2ImeKPiZeWZwv1jIoBT/LSzTYD4OnLv29w9FDr0bKrzYmn2u+zhx97JNaycdZ+VjMRTxOlugipjeImW1A2JET4OJjNRrQE2dJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-5f-664c20d383ef
Date: Tue, 21 May 2024 13:19:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jbohac@suse.cz,
	dyoung@redhat.com, kernel_team@skhynix.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving
 memory using boot_params
Message-ID: <20240521041926.GA1806@system.software.com>
References: <20240423102320.GA47818@system.software.com>
 <20240424010313.25264-1-byungchul@sk.com>
 <20240426044018.GA24557@system.software.com>
 <B5CC9695-EFBF-405E-B5D2-69B2B6BC00FD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B5CC9695-EFBF-405E-B5D2-69B2B6BC00FD@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnoe5lBZ80gx9TbCw+b/jHZvFiQzuj
	RcPEBhaLaRvFLW4c3MxmcXnXHDaLSwcWMFls3jSV2eLHhsesDpwe31v7WDw2repk83h37hy7
	x7yTgR7v911l8ziz4Ai7x+dNch4nWr6wBnBEcdmkpOZklqUW6dslcGVsP/aKteCCfsWzazNY
	GhgvqHYxcnJICJhIzLo2gxXG3nT4KROIzSKgKrHqZBMziM0moC5x48ZPMFtEQEVi+s9PQDVc
	HMwChxklLix9x9LFyMEhLJAmMXMmB0gNr4C5xOcT01lAaoQEjjFK7PrxjAUiIShxcuYTMJtZ
	QEvixr+XTCC9zALSEsv/gfVyCthKfJl/E2yXqICyxIFtx8F2SQhcZpNYtXYfE8ShkhIHV9xg
	mcAoMAvJ2FlIxs5CGLuAkXkVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmAsLKv9E72D8dOF4EOM
	AhyMSjy8FibeaUKsiWXFlbmHGCU4mJVEeDdt8UwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0
	rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwOggVnT14If/nnlRsowrBB/ednZmPai178CKmzr+HBys
	E47snhx2eu3pbZZCl9IK9spWcJ2aJRdoxPSt4ZmetnGN8mvFFQVlt2/KvXunF+ntk/spRDXr
	m/+UNYLzdftnF7z4+XrNFa7OB13ivMsqtzkfy1i5feq+ruSUCN7Tz5a0MGfNua3MuUqJpTgj
	0VCLuag4EQAvxmDPgQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrHtZwSfN4PMPfYvPG/6xWbzY0M5o
	0TCxgcVi2kZxixsHN7NZHJ57ktXi8q45bBaXDixgsti8aSqzxY8Nj1kduDy+t/axeGxa1cnm
	8e7cOXaPeScDPd7vu8rmsfjFByaPMwuOsHt83iTncaLlC2sAZxSXTUpqTmZZapG+XQJXxvZj
	r1gLLuhXPLs2g6WB8YJqFyMnh4SAicSmw0+ZQGwWAVWJVSebmEFsNgF1iRs3foLZIgIqEtN/
	fgKq4eJgFjjMKHFh6TuWLkYODmGBNImZMzlAangFzCU+n5jOAlIjJHCMUWLXj2csEAlBiZMz
	n4DZzAJaEjf+vWQC6WUWkJZY/g+sl1PAVuLL/Jtgu0QFlCUObDvONIGRdxaS7llIumchdC9g
	ZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGNjLav9M3MH45bL7IUYBDkYlHl4Ndp80IdbE
	suLK3EOMEhzMSiK8m7Z4pgnxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1I
	LYLJMnFwSjUwdvsuapYPvrn6TeGLvA2hdw+5Hlqr2anRxbf4zbeaqz8vs2s7G56bZ7jgYaJ2
	2YQ8o/yKFumJB2YceO0y/du3Io6aOfcv9DytrLx9uZq7bJ6p3QLvnW5OH24fLnII+qNU0HWg
	YNa5q0oZDzUfWCS2LnJIsyzPzFn8dD7v8X1XOFN/WkznmPgmV4mlOCPRUIu5qDgRAKdqdA9o
	AgAA
X-CFilter-Loop: Reflected

On Fri, Apr 26, 2024 at 09:52:30AM -0700, H. Peter Anvin wrote:
> On April 25, 2024 9:40:18 PM PDT, Byungchul Park <byungchul@sk.com> wrote:
> >On Wed, Apr 24, 2024 at 10:03:13AM +0900, Byungchul Park wrote:
> >> I might miss something.  Please lemme know if I go wrong.  Thanks.
> >
> >I started to work on it since I wanted to limit memory boundary using
> >'mem=' boot command but it doesn't work.  However, while looking around
> >the code in more detail, I found the issue is about which one should
> >have higher priority between:
> >
> >   1. boot command limiting memory boundary e.g. 'mem=',
> >   2. setup data of memory map from bootloader, boot_params.
> >
> >Based on the current code, setup data from bootloader has higher
> >priority than boot command so the setup data can overwrite the user
> >defined limit specified in boot command.  Is it inteded?
> >
> >   If yes, I should stop posting.
> >   If not, I will keep posting with the following - v3.
> >
> >	Byungchul
> >
> >---
> >
> >diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >index 6f1b379e3b38..3bc593235b76 100644
> >--- a/arch/x86/kernel/e820.c
> >+++ b/arch/x86/kernel/e820.c
> >@@ -879,6 +879,7 @@ static void __init early_panic(char *msg)
> > }
> > 
> > static int userdef __initdata;
> >+static u64 userdef_mem_limit;
> > 
> > /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
> > static int __init parse_memopt(char *p)
> >@@ -905,7 +906,10 @@ static int __init parse_memopt(char *p)
> > 	if (mem_size == 0)
> > 		return -EINVAL;
> > 
> >-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
> >+	if (userdef_mem_limit)
> >+		userdef_mem_limit = min(userdef_mem_limit, mem_size);
> >+	else
> >+		userdef_mem_limit = mem_size;
> > 
> > #ifdef CONFIG_MEMORY_HOTPLUG
> > 	max_mem_size = mem_size;
> >@@ -966,7 +970,10 @@ static int __init parse_memmap_one(char *p)
> > 		else
> > 			e820__range_remove(start_at, mem_size, 0, 0);
> > 	} else {
> >-		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
> >+		if (userdef_mem_limit)
> >+			userdef_mem_limit = min(userdef_mem_limit, mem_size);
> >+		else
> >+			userdef_mem_limit = mem_size;
> > 	}
> > 
> > 	return *p == '\0' ? 0 : -EINVAL;
> >@@ -1050,6 +1057,11 @@ void __init e820__reserve_setup_data(void)
> > void __init e820__finish_early_params(void)
> > {
> > 	if (userdef) {
> >+		if (userdef_mem_limit)
> >+			e820__range_remove(userdef_mem_limit,
> >+					ULLONG_MAX - userdef_mem_limit,
> >+					E820_TYPE_RAM, 1);
> >+
> > 		if (e820__update_table(e820_table) < 0)
> > 			early_panic("Invalid user supplied memory map");
> > 
> >---
> >> 	Byungchul
> >> 
> >> Changes from v1
> >> 	1. before - handle boot_mem_limit assuming the default is U64_MAX.
> >> 	   after  - handle boot_mem_limit assuming the default is 0.
> >> 
> >> --->8---
> >> >From e8bf247d6024b35af5300914dcff9135df9c1d66 Mon Sep 17 00:00:00 2001
> >> From: Byungchul Park <byungchul@sk.com>
> >> Date: Wed, 24 Apr 2024 09:55:25 +0900
> >> Subject: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving memory using boot_params
> >> 
> >> When a user specifies 'mem=' boot command, it's expected to limit the
> >> maximum address of usable memory for the kernel no matter what the
> >> memory map source is.  However, 'mem=' boot command doesn't work since
> >> it doesn't respect it when reserving memory using boot_params.
> >> 
> >> Applied the restriction when reserving memory using boot_params.  While
> >> at it, renamed mem_size to a more specific name, boot_mem_limit.
> >> 
> >> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> ---
> >>  arch/x86/kernel/e820.c | 15 +++++++++------
> >>  1 file changed, 9 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >> index 6f1b379e3b38..e3f716128caf 100644
> >> --- a/arch/x86/kernel/e820.c
> >> +++ b/arch/x86/kernel/e820.c
> >> @@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
> >>  
> >>  static int userdef __initdata;
> >>  
> >> +static u64 boot_mem_limit;
> >> +
> >>  /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
> >>  static int __init parse_memopt(char *p)
> >>  {
> >> -	u64 mem_size;
> >> -
> >>  	if (!p)
> >>  		return -EINVAL;
> >>  
> >> @@ -899,16 +899,16 @@ static int __init parse_memopt(char *p)
> >>  	}
> >>  
> >>  	userdef = 1;
> >> -	mem_size = memparse(p, &p);
> >> +	boot_mem_limit = memparse(p, &p);
> >>  
> >>  	/* Don't remove all memory when getting "mem={invalid}" parameter: */
> >> -	if (mem_size == 0)
> >> +	if (boot_mem_limit == 0)
> >>  		return -EINVAL;
> >>  
> >> -	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
> >> +	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit, E820_TYPE_RAM, 1);
> >>  
> >>  #ifdef CONFIG_MEMORY_HOTPLUG
> >> -	max_mem_size = mem_size;
> >> +	max_mem_size = boot_mem_limit;
> >>  #endif
> >>  
> >>  	return 0;
> >> @@ -1036,6 +1036,9 @@ void __init e820__reserve_setup_data(void)
> >>  		early_memunmap(data, len);
> >>  	}
> >>  
> >> +	if (boot_mem_limit)
> >> +		e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
> >> +				E820_TYPE_RESERVED_KERN, 1);
> >>  	e820__update_table(e820_table);
> >>  
> >>  	pr_info("extended physical RAM map:\n");
> >> -- 
> >> 2.17.1
> 
> mem= typically should cap the usable memory at that address. At one
> point in history we also allowed it to add memory at the top, but

Ah.. I just needed to cap for a test.

> modern systems have too complex memory maps; the memmap= option can be
> used for that, however.

Even with memmap=, I still cannot cap the usable memory.  However, with
a tricky way like by adding a dummy reserve memory, I could manage to
make it.

So.. Is the following approach not acceptable then?

   https://lore.kernel.org/lkml/20240510074714.73177-1-byungchul@sk.com/

	Byungchul

