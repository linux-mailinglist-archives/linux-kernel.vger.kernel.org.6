Return-Path: <linux-kernel+bounces-519885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4088A3A324
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D84188DB16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184F26E169;
	Tue, 18 Feb 2025 16:47:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F226B2BE;
	Tue, 18 Feb 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897246; cv=none; b=RS8gT24vopwCXoSTR9yBJmTEWwoLEaBWLH8p5FqylgwYHWhDTMtUOXNHwuoZZVZONzPp7PiMwO2nS+lBRm4xTmEn/iUfntQwPgYMgE5Ul9MQGNP8NYU6lx+CXIVCyLZOl2rKRCY2oDUoV1B1XPRY6rRntYJFUc9Mjt8XCYThy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897246; c=relaxed/simple;
	bh=oVD0aPVJ0JUxzWxJf3CwW8yIcPV/QlQ3knpGNTg2Fho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExKH8vOOStYYgK7jtQD2YGAp1atPcAoV4mQD4aDYJ8wYRHBeE5XYhX4UiJ9NY4oIeVzkuWuCiOk8GjDlrGB1c8ii9FpA5p4TE15PJ54HEEbf7V0SBpZdtpRLqj1T0q1TTx5j/Sasqq16YM90BBubvBXX4wPERsxM80MLu2IAxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E792AC4CEE2;
	Tue, 18 Feb 2025 16:47:25 +0000 (UTC)
Date: Tue, 18 Feb 2025 08:47:24 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "kmsan_handle_dma"
 [drivers/virtio/virtio_ring.ko] undefined!
Message-ID: <20250218164724.uxcwotv3wgc5y3id@jpoimboe>
References: <202502150634.qjxwSeJR-lkp@intel.com>
 <20250218114857.oBuLvPYs@linutronix.de>
 <20250218132855.GE40464@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218132855.GE40464@noisy.programming.kicks-ass.net>

On Tue, Feb 18, 2025 at 02:28:55PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 12:48:57PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-02-15 06:42:36 [+0800], kernel test robot wrote:
> > > >> arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefined stack state
> > 
> 
> > From the assembly it seems to make sense:
> > |   110ae:       49 89 e0                mov    %rsp,%r8
> > stash for later
> > |   110b1:       48 85 db                test   %rbx,%rbx
> > |   110b4:       c7 00 00 00 00 00       movl   $0x0,(%rax)
> > |   110ba:       45 89 7e 14             mov    %r15d,0x14(%r14)
> > |   110be:       0f 85 40 01 00 00       jne    11204 <do_cpuid_func+0x22f4>
> > …
> > |   11204:       44 8b 74 24 38          mov    0x38(%rsp),%r14d
> > |   11209:       44 89 f7                mov    %r14d,%edi
> > |   1120c:       4d 89 c7                mov    %r8,%r15
> > 
> > mov rsp to r15
> 
> This, objtool doesn't track this one. It only does:
> 
>  mov %rsp, reg
> 
>  mov reg, %rsp
> 
> I'm not entirely sure how painful it would be to teach objtool about
> this case. Horrible code it is :/
> 
> > restore rsp. I just don't see how rsp is destroyed but this could be
> > related to paravirt's xxl clobbing in__cpuid().
> > 
> > I miss 1120c in my output. I don't understand how it jumps from 110ae to
> > 1124b. It misses the assignments in between but this might not be goal
> > here…

FYI, you can add OBJTOOL_ARGS="--backtrace" or OBJTOOL_VERBOSE=1 to the
cmdline to see how objtool got there.  On my build there were some
ALTERNATIVE()s involved which makes it trickier to follow.

There's definitely some weirdness going on, I'm also seeing the .s not
match the .o.  Maybe it's the __msan_*() stuff.  Still looking...

-- 
Josh

