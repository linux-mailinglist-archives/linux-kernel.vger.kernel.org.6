Return-Path: <linux-kernel+bounces-232386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547891A802
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A4DB2542C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA85194081;
	Thu, 27 Jun 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq/osnw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C91591F0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495438; cv=none; b=l7zBXMg2mFhUdrdHUcd0wFQHuX9uL90XzEN9/zgqgEkkU+vEVaPThVaonP3AsDXLJ+6OgQJfp9sJUPBBPmsW8OK8WEwNs2YwxuNMW0Z+uGq368lRQ1dbAldKmf7wDsQuolLqCiykd4aUJjnS1OqFkGUe4Os1AK538jy/twW40eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495438; c=relaxed/simple;
	bh=eFVpLZmrDXn+hk4HD/Ninb4BntVG08s7b1uv9uw7LhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdzBgwe9IX2RJpMMFNJ2CeeVOQyjcX0HpbIJ72cmb2qNSIfF036xeVj3ysG+hXBuJ9cXi1zf0pD35GUcCUwUju4xDO1oTfUp3Wwsvt8jUARxtEj5n4Aw9SBv0i5vpi+Tc3LU+Egfyho4OUvUrQ622V3+O/gdrfj2JsEiVaw6PUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq/osnw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C88C32786;
	Thu, 27 Jun 2024 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719495437;
	bh=eFVpLZmrDXn+hk4HD/Ninb4BntVG08s7b1uv9uw7LhI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tq/osnw4j3hEAq7ktA8UoF96AEawyNG07mpVUA+nf9a0lVpgvoghhxfV+HUcDoRwV
	 0PyYFFGMl2gSYgjJ1qaF32qqawW4XMLgRWCj69SA3+VXRtYloP8WOLVxjwlJxUIKVK
	 7E9AbHlTB0V6Naq4gtBQ7NCkY4r/w3Q3E1snCO7a7g8NSNIYRIbBpP5QKNVxnbZSDy
	 E32Hzkqa1pBvg12gXiZ4aBS4+5tIhgpdOAHL06P7VeopeEc1tlj9sjKaoO798EJ7XK
	 URQLN9sxgiSkSMLDPmyigLMmWJkHr3DaXkwrmclvGWSl/nT76znxK6O7QuzIyHe7ii
	 vXHD94sFVSxaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90BDFCE08DF; Thu, 27 Jun 2024 06:37:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 06:37:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v6 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <a4b42472-6187-4bee-977c-c43f7b578042@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1719381528.git.jpoimboe@kernel.org>
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
 <20240627072634.GAZn0UKqtwqwQhWr4q@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627072634.GAZn0UKqtwqwQhWr4q@fat_crate.local>

On Thu, Jun 27, 2024 at 09:26:34AM +0200, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 11:02:00PM -0700, Josh Poimboeuf wrote:
> > The direct-call syscall dispatch function doesn't know that the exit()
> > and exit_group() syscall handlers don't return, so the call sites aren't
> > optimized accordingly.
> > 
> > Fix that by marking the exit syscall declarations __noreturn.
> > 
> > Fixes the following warnings:
> > 
> >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > 
> > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> 
> This here talks about
> 
> 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> 
> being the culprit.
> 
> But Fixes points to something unrelated...?
> 
> In any case, I won't send this to Linus now as urgent material unless someone
> presents a reasonable argument for it...

Its being in -next now and going into the upcoming merge window works
just fine for me, thank you!

							Thanx, Paul

