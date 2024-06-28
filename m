Return-Path: <linux-kernel+bounces-233201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469991B43F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A2AB2338D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED8567F;
	Fri, 28 Jun 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+4teiZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE403FD4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535502; cv=none; b=QpnueTu9NPdeTrHoA7o7UHXYkfwECxO4WjmkgDDKz64b27cqxkplOH28XTvD1Cnh+cfVN2sD5BVX1cIK/Kdqnovc8mG05/v6qQKfwChpHAfxKzbuEgACbI2E+yc6AkHfkiO8cGaZGmUtueILlbAfSjRX3zMlRCQy9ZXs/1gbI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535502; c=relaxed/simple;
	bh=fcncxrsLHsjWo/sKRoldIbpT08LmOZAKwgwqzcEd0/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFH7mxo7S2KJmldpk28pJAFxFcLTeiX6yjJpIea1xIn9f2yVIBqCZmBf3Vsa1GLMDzeFCyhzBgK1QlE+MZZD82JyssPww1XKRZeKgM0ABcKxpG4FVI0c5rR+U3ViigBsUHWykW/fNS0nQplFsVrOuLAXUCTLwbRAdgbMLmpDVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+4teiZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE12C2BBFC;
	Fri, 28 Jun 2024 00:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719535502;
	bh=fcncxrsLHsjWo/sKRoldIbpT08LmOZAKwgwqzcEd0/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+4teiZJPrq0XxX8cJI6EBcm1AYkGMC0zT33yrK+XMC4Y0Qc1n4VybB2bALn2YWHE
	 1LzDRGQHUFZrG/xDs4MZwzCEeoDD8cNcoAW+lAurQVUAwQ/2/5Dwosa5KIsdleYK9h
	 Mh6py1UBKPi0ykLo8a+BaJsl18W5MLIuNTyiL5xUmlrUotqHrqVmfICe46kaYJtorS
	 SxCsljPgS+1io7aDPELb7O4oa2p2DptALubLm1ZP9sDvfFBdUBIVmikaPh3rCDq8T9
	 MpGbjxU1nPlh2HlD+XUpqeCZOiTOzyNddCmzg+u8JFMK0RsD6Ap7LupyLy/IyNi/6y
	 3Dusd8dAhYrjw==
Date: Thu, 27 Jun 2024 17:44:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
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
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240628004459.ik6a5l6sgdp66v5n@treble>
References: <cover.1719381528.git.jpoimboe@kernel.org>
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
 <20240627072634.GAZn0UKqtwqwQhWr4q@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Ah yeah, it should be

Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")

-- 
Josh

