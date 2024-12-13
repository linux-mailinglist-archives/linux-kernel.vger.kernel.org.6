Return-Path: <linux-kernel+bounces-445139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D89F9F11E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8CB1888FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC71A8F85;
	Fri, 13 Dec 2024 16:17:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD81E22FD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106672; cv=none; b=IlBXTx/CErk2aMF3bSqAbAjnHC0kjkCXZhaFUHhgTwLgvuSVL83YqzTO/L3jl0BcyHiOMOtLAooH/4r8gZWOSR2mphx6tmokaA2jbZGR4PDKhLPU7EydC7Tq2g/oW9IbIGQ4IOHASXq9yWgxuGNUwQmXH2Pz4MnHG3ccOwQmxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106672; c=relaxed/simple;
	bh=YRLWJdwpo7GhSh6+RHZMxOIAS+Ci3PE6RGWPHE6yGAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlRSItAf62w1OoIa4EgJDW+XhzTSv0Lcc5XDEMUKxfx10mtdJPUo3y2iVFiFV5JKPVKW2NWKk869rI39gLfgKkOXQM4nrwRrd4Wf/4Hda7jOy9mX9vK5Uau4VtCh7t/mvg9BU3RxJmw0UndWYDGeUjNo9g4Zzs23hHRW4f631X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D3C4CED0;
	Fri, 13 Dec 2024 16:17:50 +0000 (UTC)
Date: Fri, 13 Dec 2024 16:17:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <Z1xeLCKoSWyn2sko@arm.com>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
 <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>
 <Z1ht7X2LRw34pMJK@J2N7QTR9R3>
 <6d839dfb-0a85-44c5-90cc-2b2426353a5f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d839dfb-0a85-44c5-90cc-2b2426353a5f@sirena.org.uk>

On Tue, Dec 10, 2024 at 04:52:49PM +0000, Mark Brown wrote:
> On Tue, Dec 10, 2024 at 04:35:57PM +0000, Mark Rutland wrote:
> > On Tue, Dec 10, 2024 at 03:44:29PM +0000, Mark Brown wrote:
> > > The spuriousness is arguable, from my point of view it's spurious in
> > > that we don't have the type of the system register we're writing to.
> 
> > All that I'm asking for here is a trivial rewording; make the title say
> > something like:
> 
> Yes, I had already removed the references to spurious and false positive
> locally and changed the unsigned long cast to a __force u64 cast.

I still have a slight preference for treating a sysreg value as an
integer and cast it to pointer when needed rather than using __force.

> > > With map_shadow_stack() it's a bit of an issue with letting users
> > > specify a size but yeah, we could do better there.
> 
> > I don't follow. The only place where size interacts with cap_ptr is when
> > we initialize cap_ptr, and there we're adding size to an integer type:
> 
> > 	cap_ptr = (unsigned long __user *)(addr + size -
> > 					   (cap_offset * sizeof(unsigned long)));
> 
> Ugh, addr is also not a pointer which I'd not noticed but still.

'addr' should stay as long in map_shadow_stack(). This matches mmap(),
mremap(), brk() etc. as they handle address space layout manipulation
(these functions also do not accept tagged pointers). map_shadow_stack()
does write a cap to memory but its primary functionality is not user
buffer access but rather memory layout management.

-- 
Catalin

