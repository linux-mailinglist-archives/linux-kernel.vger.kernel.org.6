Return-Path: <linux-kernel+bounces-218433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E853E90BFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF51D1C210BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E09199E9C;
	Mon, 17 Jun 2024 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+TR5HkT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B94199E80
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666936; cv=none; b=R3scqaFnnV1Zi80uZlFjXnhcxUa1ZmP0Q/I0Qgo8e3mMTYVO4kLD3yODxUJVVpSRwzUwb6eOudtsf8197Sd8LZGoySCWcpZV6mS4ehQZLuId3AXsOiNHg9fnwSR0nS3tVtNb6O075oolwyEcEnFdXDBt6Ffj3geor+TWFY3Hlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666936; c=relaxed/simple;
	bh=/j//LN7tYdATyYatMOpxy80uiLNxtsvGRZR1fKxIRtA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BRMOYp+Tc6A10nrt3tGFY7sbBtjNdkkzYdeJUZsD6Zw7H3nYfAFdTwxMI3zPg5lNhqEidc3IZtL6kQMNUIkGl8yToPxKjlCw6g52y/+zXyxsHrDRXNRp8W6RFL9wOgvOOsi6ygSL25EfJFzIIzz2Vl94eu2RnyYWIqNRTHQkIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+TR5HkT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-632843cff4fso32991347b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718666932; x=1719271732; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAB39G3/EEy29AwXsRYdDzEcSOFINWe7KYOlv3bA8Os=;
        b=u+TR5HkTxoHzfu8h2hESttbw7bEGGXNQltx2p20begyrpzIlEwO0/kAm+iNMdExBjq
         5q7o9nkPiJbIpRUrzBBROXmuVoCzYvnGdLpgjU4EPqff8qNU66ed0LrnL3AdMxNZBAGh
         rNljFTpgMyOA7mZuhdWNXooN3dQgu8LpNtSmXCMEwMwq+fZisTw9HtpK687DRF6jIUCb
         GfAz+4ByfD+0DAI0DdtyqvmFgJsVXpTjelsm3VzpL2A6lFdJwjjd8Y0nT7EI+/5lLwKc
         G0lPYh6vIWfBvquSZ4RcOgJQMI2pvidoNQTaDo/Qcj2XEYiojf2M57dnE7TUKOUycM3O
         pvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666932; x=1719271732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAB39G3/EEy29AwXsRYdDzEcSOFINWe7KYOlv3bA8Os=;
        b=sX4K/S6HUvby1na1jdeagR8UPHFmGKWcs2wVopVSXUtq79c9fpUpSL4Diomnobhk9t
         OCDjaXpBbH3hd1Ss5VzQsCHGNH+nTS97BwZEndIPOGiOcNx3ghO5kPRI+Q9Vzm519wwc
         z2qWx9ik2ZEJdd0HPdk8kW0yONQDjoEFL4vaeRCsF5sRpZLCYtZpVqtKZ3YAsu1LdOv1
         1qxOP3xUYeNYqouwhA5vajpNqRj/HBdEymj5HamrEvu+LK6ocvj8vq76DCiwpSIkQM1H
         Fejx6MRCXnCDXccZXWauxn3j+vgp1PxQ0PxG5TGGdDZEj7u1j84p+4diPbo9RqA+91gX
         Bpjg==
X-Forwarded-Encrypted: i=1; AJvYcCW3UIM7WsMwpaStbNFnaWKvvB1DcA+kcQphCYtHIkHhvWTAdSzS2KRzY5LzcvpDsmgLXmYI2LHneEiukkxP51qbiCgPQCGzf6CJ5AQA
X-Gm-Message-State: AOJu0Yyh8ttqPsd21Wag403zSMMs45uF+ge7JvZRae3SNEQDnQ4vcXWY
	QbM9uFFJgmFRYgYDlF7XoVLggcW0kpn/66gadkt7+DsNvvE6j6uaSGQgGo55Ww==
X-Google-Smtp-Source: AGHT+IEVhqpFFYTb+8knJrW1OLetMn73OD3PiJAx+bHYk+bqCr2VJvW63nSHseMRk9KggRjygPCKGA==
X-Received: by 2002:a0d:d6c7:0:b0:62a:2a7d:b512 with SMTP id 00721157ae682-6322206f588mr112744437b3.10.1718666931694;
        Mon, 17 Jun 2024 16:28:51 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63118e9917asm15870257b3.60.2024.06.17.16.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:28:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:28:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: kernel test robot <oliver.sang@intel.com>
cc: Zi Yan <ziy@nvidia.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
    linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
    SeongJae Park <sj@kernel.org>, Yang Shi <shy828301@gmail.com>, 
    Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [mm/migrate]  7262f208ca:
 kernel_BUG_at_mm/migrate.c
In-Reply-To: <202406171436.a30c129-oliver.sang@intel.com>
Message-ID: <8a3aa391-d3f1-200f-fa5a-82352b1cc161@google.com>
References: <202406171436.a30c129-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Jun 2024, kernel test robot wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_mm/migrate.c" on:
> 
> commit: 7262f208ca681385d133844be8a58d9b4ca185f7 ("mm/migrate: split source folio if it is on deferred split list")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      32f88d65f01bf6f45476d7edbe675e44fb9e1d58]
> [test failed on linux-next/master 234cb065ad82915ff8d06ce01e01c3e640b674d2]
> 
> in testcase: vm-scalability
> version: vm-scalability-x86_64-6f4ef16-0_20240303
> with following parameters:
> 
> 	runtime: 300s
> 	size: 8T
> 	test: anon-cow-seq
> 	cpufreq_governor: performance
> 
> 
> 
> compiler: gcc-13
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406171436.a30c129-oliver.sang@intel.com
> 
> 
> [   84.214952][ T6581] ------------[ cut here ]------------
> [   84.219158][ T1289] 781916337 bytes / 1533701 usecs = 497874 KB/s
> [   84.219928][ T6581] kernel BUG at mm/migrate.c:2634!
> [   84.225273][ T1289]
> [   84.226742][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
> [   84.231379][ T6581] invalid opcode: 0000 [#1] SMP NOPTI
> [   84.236360][ T1289]
> [   84.238534][ T6581] CPU: 15 PID: 6581 Comm: usemem Tainted: G S                 6.9.0-rc4-00136-g7262f208ca68 #1
> [   84.238538][ T6581] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
> [   84.246187][ T1289] 781916337 bytes / 1533701 usecs = 497874 KB/s
> [ 84.249854][ T6581] RIP: 0010:migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
> [   84.252050][ T1289]
> [ 84.262214][ T6581] Code: a0 b4 1b 83 e8 a8 23 f6 ff 48 89 df e8 a0 3f f5 ff 45 31 e4 8b 44 24 1c 85 c0 75 10 48 8b 44 24 20 48 39 e8 0f 84 27 fe ff ff <0f> 0b 41 89 c5 65 4c 01 2d ba 1d bf 7e 48 8b 3b 48 c1 ef 36 e8 2e
> All code
> ========
>    0:	a0 b4 1b 83 e8 a8 23 	movabs 0xfff623a8e8831bb4,%al
>    7:	f6 ff 
>    9:	48 89 df             	mov    %rbx,%rdi
>    c:	e8 a0 3f f5 ff       	callq  0xfffffffffff53fb1
>   11:	45 31 e4             	xor    %r12d,%r12d
>   14:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
>   18:	85 c0                	test   %eax,%eax
>   1a:	75 10                	jne    0x2c
>   1c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
>   21:	48 39 e8             	cmp    %rbp,%rax
>   24:	0f 84 27 fe ff ff    	je     0xfffffffffffffe51
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	41 89 c5             	mov    %eax,%r13d
>   2f:	65 4c 01 2d ba 1d bf 	add    %r13,%gs:0x7ebf1dba(%rip)        # 0x7ebf1df1
>   36:	7e 
>   37:	48 8b 3b             	mov    (%rbx),%rdi
>   3a:	48 c1 ef 36          	shr    $0x36,%rdi
>   3e:	e8                   	.byte 0xe8
>   3f:	2e                   	cs
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	41 89 c5             	mov    %eax,%r13d
>    5:	65 4c 01 2d ba 1d bf 	add    %r13,%gs:0x7ebf1dba(%rip)        # 0x7ebf1dc7
>    c:	7e 
>    d:	48 8b 3b             	mov    (%rbx),%rdi
>   10:	48 c1 ef 36          	shr    $0x36,%rdi
>   14:	e8                   	.byte 0xe8
>   15:	2e                   	cs
> [   84.262217][ T6581] RSP: 0000:ffffc9002080fd08 EFLAGS: 00010206
> [   84.262221][ T6581] RAX: ffffea01487467c8 RBX: ffffea0148740000 RCX: 0000000000000000
> [   84.262223][ T6581] RDX: 000000000000027f RSI: 00000000000001ff RDI: 0000000000000001
> [   84.262225][ T6581] RBP: ffffc9002080fd28 R08: 0000000000000000 R09: 0000000000000001
> [   84.262226][ T6581] R10: 000000000000080c R11: 0000000000000000 R12: 0000000000000001
> [   84.274946][ T1289] 781916337 bytes / 1533699 usecs = 497874 KB/s
> [   84.279439][ T6581] R13: 00000000000001ff R14: 0000000000000200 R15: ffff88907ffd5000
> [   84.279441][ T6581] FS:  00007f1b11213740(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
> [   84.285537][ T1289]
> [   84.287725][ T6581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   84.287728][ T6581] CR2: 00007f1b0fe00000 CR3: 0000005f54c9e003 CR4: 00000000007706f0
> [   84.287730][ T6581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   84.287731][ T6581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   84.308684][ T1289] 781916337 bytes / 1533744 usecs = 497860 KB/s
> [   84.313094][ T6581] PKRU: 55555554
> [   84.313097][ T6581] Call Trace:
> [   84.313100][ T6581]  <TASK>
> [   84.320929][ T1289]
> [ 84.328756][ T6581] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
> [   84.337626][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
> [ 84.344414][ T6581] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
> [   84.350509][ T1289]
> [ 84.358331][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
> [   84.368158][ T1289] 781916337 bytes / 1533806 usecs = 497840 KB/s
> [ 84.369304][ T6581] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
> [ 84.369306][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
> [   84.375745][ T1289]
> [ 84.383566][ T6581] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
> [   84.392383][ T1289] 781916337 bytes / 1537066 usecs = 496784 KB/s
> [ 84.399219][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
> [ 84.399222][ T6581] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [   84.405314][ T1289]
> [ 84.408718][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2634 (discriminator 1)) 
> [ 84.408721][ T6581] ? migrate_misplaced_folio (mm/migrate.c:2630 (discriminator 2)) 
> [   84.412861][ T1289] 781916337 bytes / 1533702 usecs = 497873 KB/s
> [ 84.414661][ T6581] do_huge_pmd_numa_page (mm/huge_memory.c:1759) 
> [   84.416855][ T1289]
> [ 84.420436][ T6581] __handle_mm_fault (mm/memory.c:5429) 
> [   84.427485][ T1289] 781916337 bytes / 1545381 usecs = 494111 KB/s
> [ 84.430542][ T6581] handle_mm_fault (mm/memory.c:5608) 
> [   84.432735][ T1289]
> [ 84.438220][ T6581] do_user_addr_fault (arch/x86/mm/fault.c:1364) 
> [   84.445291][ T1289] 781916337 bytes / 1545380 usecs = 494111 KB/s
> [ 84.448765][ T6581] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1514 arch/x86/mm/fault.c:1564) 
> [   84.454252][ T1289]
> [ 84.456445][ T6581] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
> [   84.456448][ T6581] RIP: 0033:0x561f6c00dad4
> [   84.461953][ T1289] 781916337 bytes / 1545382 usecs = 494110 KB/s
> [ 84.467077][ T6581] Code: 01 00 00 00 e8 0d f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 fc f8 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 23 01 00 00
> All code
> ========
>    0:	01 00                	add    %eax,(%rax)
>    2:	00 00                	add    %al,(%rax)
>    4:	e8 0d f9 ff ff       	callq  0xfffffffffffff916
>    9:	89 c7                	mov    %eax,%edi
>    b:	e8 6c ff ff ff       	callq  0xffffffffffffff7c
>   10:	bf 00 00 00 00       	mov    $0x0,%edi
>   15:	e8 fc f8 ff ff       	callq  0xfffffffffffff916
>   1a:	85 d2                	test   %edx,%edx
>   1c:	74 08                	je     0x26
>   1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>   22:	48 8b 00             	mov    (%rax),%rax
>   25:	c3                   	retq   
>   26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>   2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
>   2d:	b8 00 00 00 00       	mov    $0x0,%eax
>   32:	c3                   	retq   
>   33:	41 54                	push   %r12
>   35:	55                   	push   %rbp
>   36:	53                   	push   %rbx
>   37:	48 85 ff             	test   %rdi,%rdi
>   3a:	0f 84 23 01 00 00    	je     0x163
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 89 30             	mov    %rsi,(%rax)
>    3:	b8 00 00 00 00       	mov    $0x0,%eax
>    8:	c3                   	retq   
>    9:	41 54                	push   %r12
>    b:	55                   	push   %rbp
>    c:	53                   	push   %rbx
>    d:	48 85 ff             	test   %rdi,%rdi
>   10:	0f 84 23 01 00 00    	je     0x139
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240617/202406171436.a30c129-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

7262f208ca68:mm/migrate.c line 2634 is BUG_ON(!list_empty(&migratepages)):
in a different caller of migrate_pages() than the VM_BUG_ON I hit, but
8e279f970b5c ("mm/migrate: fix kernel BUG at mm/compaction.c:2761!"),
which went into Linus's tree today, is very likely to fix it.

Hugh

