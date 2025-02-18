Return-Path: <linux-kernel+bounces-519522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEDA39DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DDC3BA36C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48826A089;
	Tue, 18 Feb 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWZZTJk7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172526F479;
	Tue, 18 Feb 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885341; cv=none; b=R6NOuO+w2YkuNsWWDT7HZKalE8vinEPaiFLbjawDtQlb90QxMJ7MzI5DoiFph3/D1TvoYIs9R/Z1324bSY/n4f2bhlWPih/TDX5PDvVMqtJqk970b31LmlH12uG4rp/qvqkCdwptomUo/dOy9mmK+/kJmao+6XnOmBm1Juu5D5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885341; c=relaxed/simple;
	bh=iw/SPrbXn98cADc38nK9IqPnmrHPqixHtVWli1zCfVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9NR5q1LHobrIE2mUTy0HX7idXTuwrIGnDyhIWW8SLZNmygNDFGWzRupajm4LPvd5TuDmEOKMrJDdjp3VyGoPDHFlNjNycHKqw79m/rTuTqA6ULscQnaoUAdqGHvk7JtMJVDvShR5cP/BXbhV7tmjalI0i5RqW7dVDVWOf/RTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bWZZTJk7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R/o1iYOuTnHdhQ5dQpONUa+xtnc26ne1K/lxsZiqLlE=; b=bWZZTJk7HG6EUCdOIuwtQ31mF1
	y3H28+JyOq58NxaxEzH+37aZDlVv2j4Zbsz6TJm0ImcqOxrtVka/Hr2QhJSF7n2saSxRmTVOYsunA
	fWv0oRN1aFkicZUgFGE3ssWnQ4ZFqh7FQ9XDS9cJm94kS0rNI/+WNeKx3dAQiHrq7ZwtzL/+eCAXu
	xJmCQ5Fj9eW6GbxBHwop3ReqPZ6Z//V6u9cCx3nS9MO0WTeijNcCzTXYlzuROWt4jI31IwGK8es30
	RC377zVtYk8kRGuAI48MfMPMpTrcEmzbG13qvlEHQ8jdgB9LFy4zAvHKxjLHVhdZgm0jBgpLSCqIP
	+Rd1dU3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkNei-000000030UP-19lA;
	Tue, 18 Feb 2025 13:28:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2341230066A; Tue, 18 Feb 2025 14:28:55 +0100 (CET)
Date: Tue, 18 Feb 2025 14:28:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: ERROR: modpost: "kmsan_handle_dma"
 [drivers/virtio/virtio_ring.ko] undefined!
Message-ID: <20250218132855.GE40464@noisy.programming.kicks-ass.net>
References: <202502150634.qjxwSeJR-lkp@intel.com>
 <20250218114857.oBuLvPYs@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218114857.oBuLvPYs@linutronix.de>

On Tue, Feb 18, 2025 at 12:48:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-15 06:42:36 [+0800], kernel test robot wrote:
> > >> arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefined stack state
> 

> From the assembly it seems to make sense:
> |   110ae:       49 89 e0                mov    %rsp,%r8
> stash for later
> |   110b1:       48 85 db                test   %rbx,%rbx
> |   110b4:       c7 00 00 00 00 00       movl   $0x0,(%rax)
> |   110ba:       45 89 7e 14             mov    %r15d,0x14(%r14)
> |   110be:       0f 85 40 01 00 00       jne    11204 <do_cpuid_func+0x22f4>
> …
> |   11204:       44 8b 74 24 38          mov    0x38(%rsp),%r14d
> |   11209:       44 89 f7                mov    %r14d,%edi
> |   1120c:       4d 89 c7                mov    %r8,%r15
> 
> mov rsp to r15

This, objtool doesn't track this one. It only does:

 mov %rsp, reg

 mov reg, %rsp

I'm not entirely sure how painful it would be to teach objtool about
this case. Horrible code it is :/

> |   1120f:       e8 00 00 00 00          call   11214 <do_cpuid_func+0x2304>
> |                        11210: R_X86_64_PLT32   __msan_chain_origin-0x4
> |   11214:       89 c7                   mov    %eax,%edi
> |   11216:       e8 00 00 00 00          call   1121b <do_cpuid_func+0x230b>
> |                        11217: R_X86_64_PLT32   __msan_warning-0x4
> |   1121b:       44 89 f7                mov    %r14d,%edi
> |   1121e:       e8 00 00 00 00          call   11223 <do_cpuid_func+0x2313>
> |                        1121f: R_X86_64_PLT32   __msan_chain_origin-0x4
> |   11223:       89 c7                   mov    %eax,%edi
> |   11225:       e8 00 00 00 00          call   1122a <do_cpuid_func+0x231a>
> |                        11226: R_X86_64_PLT32   __msan_warning-0x4
> |   1122a:       44 89 f7                mov    %r14d,%edi
> |   1122d:       e8 00 00 00 00          call   11232 <do_cpuid_func+0x2322>
> |                        1122e: R_X86_64_PLT32   __msan_chain_origin-0x4
> |   11232:       89 c7                   mov    %eax,%edi
> |   11234:       e8 00 00 00 00          call   11239 <do_cpuid_func+0x2329>
> |                        11235: R_X86_64_PLT32   __msan_warning-0x4
> |   11239:       44 89 f7                mov    %r14d,%edi
> |   1123c:       e8 00 00 00 00          call   11241 <do_cpuid_func+0x2331>
> |                        1123d: R_X86_64_PLT32   __msan_chain_origin-0x4
> |   11241:       89 c7                   mov    %eax,%edi
> |   11243:       e8 00 00 00 00          call   11248 <do_cpuid_func+0x2338>
> |                        11244: R_X86_64_PLT32   __msan_warning-0x4
> |   11248:       4c 89 ef                mov    %r13,%rdi
> |   1124b:       48 8b 74 24 20          mov    0x20(%rsp),%rsi
> |   11250:       4c 89 e2                mov    %r12,%rdx
> |   11253:       48 8b 4c 24 08          mov    0x8(%rsp),%rcx
> |   11258:       4c 89 fc                mov    %r15,%rsp
> 
> restore rsp. I just don't see how rsp is destroyed but this could be
> related to paravirt's xxl clobbing in__cpuid().
> 
> I miss 1120c in my output. I don't understand how it jumps from 110ae to
> 1124b. It misses the assignments in between but this might not be goal
> here…
> 
> gcc does not cause objtool to produce the warning but then gcc does
> shuffle rsp as much as llvm does.
> 
> Sebastian

