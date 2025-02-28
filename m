Return-Path: <linux-kernel+bounces-539255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23EA4A27E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956163ABA91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99951F872C;
	Fri, 28 Feb 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfZu3Nwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38B27700D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769936; cv=none; b=IkVDeaio+JqTuBOW8YnNevgxLcAeymDZNpcbCqhmgyvOmUehuKQMewQjUaywJAiR+e78jOQodGxXUMfqE93y2NOoVyQUQRWPNmngoBkfEssSupn7dn24dv02Ez2eo4qTqnFI06aC5AOL3rA/2XxPrIFrLHZKNolnr2dc1LJh8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769936; c=relaxed/simple;
	bh=iITgioo0bXGoBpOxnxrA/BK4kUHWY3owGtU+fUQuBes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ6bMhcTdhas6tLbfvVJ5N6kZzaYPUEHCFsDpIk7jmu08TKAulisjhEes/S8pr0ubEfpYVdslRLA29AbN/2sWu9gthZfHg+2wE+WeYg7329I4Q0kYQXSOoQkmS/HYo8WWbmeEkbnbi/GbUcynSK7T7fa1smJt6lqHU3q9J3F8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfZu3Nwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26260C4CED6;
	Fri, 28 Feb 2025 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769935;
	bh=iITgioo0bXGoBpOxnxrA/BK4kUHWY3owGtU+fUQuBes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfZu3Nwt/bZ0+su5VZApjjp/hHWsYSIaKAqRrgVPUHtekT5ThanAsTDhqT8wgWdRl
	 tNMHl26LB+OYuwvQbEKWIS0EDmaPYLsP05BIna6FfCUT6SEeOizYFb8DJgY9b4DaR4
	 1/6v5JsScxU2zS4eJfD3WqziKSddXN7F4wVn1RDdf4V0XWpFwhberF1L7HokftB45l
	 iBWItWDkvM/XxuKUiZGAwHWjbnMj6mLUgRn6YErf9Bnc5zui40QIBe9EoJOzgiHDTJ
	 gMNAFIkMtu2ycgF4Wsz2LuY1Qhw4yJLtn+N+Sn84IQOaG+r2k2R5eGvbu35skj60mC
	 INLHSpWN3b+VA==
Date: Fri, 28 Feb 2025 11:12:13 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: patryk.wlazlyn@linux.intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [BUG objtool,x86] Missing __noreturn annotation in
 acpi_processor_ffh_play_dead()
Message-ID: <20250228191213.7drb265s7jrrjf7b@jpoimboe>
References: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>

On Fri, Feb 28, 2025 at 11:00:07AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> My recent -next testing hits this objtool complaint:
> 
> vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation
> 
> My attempts to silence this by adding the suggested __noreturn annotations
> didn't help, and often got me compiler warnings about __noreturn functions
> actually returning.  So I bisected, which converges on this innocent-looking
> commit:
> 
> a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
> 
> Several runs verified that this really is the commit that objtool is
> complaining about.  Unfortunately, this commit does not revert cleanly.
> 
> This is from builds using clang version 19.1.5 (CentOS 19.1.5-2.el9).
> 
> Help?

I can take a look.  Is it LLVM defconfig?  Otherwise can you send the
.config?

-- 
Josh

