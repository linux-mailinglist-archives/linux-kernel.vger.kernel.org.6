Return-Path: <linux-kernel+bounces-532233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E980A44A65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E206A1890B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B882175D48;
	Tue, 25 Feb 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyorD1kL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7C189F57
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508290; cv=none; b=aUEO+BCF2SWNFCS5yVOgEjq68CgMxQDbtY4ZALw6JuTfn060oRO5jSxwrPYVJwpqM4BDldC7Hf4xRaW1DA6EwvcJgNp3Vz5ndQVrJpVqOfZWJL2yTm2YSeeMF/55hwHcU8700h0yNbRBJa69jL4hKKZWZLR2lLJMCFH3ARXGEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508290; c=relaxed/simple;
	bh=WIvGeSNx0cISssd95er/+ewyGY+cb/tUe6OCtmrY5+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct7JP1vFOdU3IzQmDmNcQzipAi5BAxn0U37yjI+7Ahwa+O8ITyakEv0NbYQ1uTND2Frw/GeSjhDP7mMAVXGAi1pNkyD5h2Y1zzsYKunmIp+5/pa3LcVPYvUc1J910SXgOefLuN0jHzGVYPur4ALTqE6116skK9TSeTVfLO/JboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyorD1kL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24A2C4CEDD;
	Tue, 25 Feb 2025 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508290;
	bh=WIvGeSNx0cISssd95er/+ewyGY+cb/tUe6OCtmrY5+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyorD1kLF/ahGRc3zZgKS6b0Qm1G58NZ1rbwxjUkNOysDlalCbjfPyJtajeOfOsNL
	 ohkwoF7pxpmBuqYTIl+YPW2RR9hijiCtxV1crbn7TqDWCObOitMSoJbDi9NbDGjsWz
	 bO19NX88OmmC7zPTHSdUEAHvLHdjMwZAXOkTGJDDFn67Z/M1zyXHxuensm+yaMjRYn
	 8juU+zpp1YAm8kPqfRb3s/X2l5JGpx8373LJMxrCe0LezLacgj6xRRLS8NOuBpt3GF
	 GkFJScTdDpsrMIjhsL3LmnuDQOjVxqKNvjaNYwlPrVWdzlIPsfXeFajaOp/TsePxKq
	 bYzUvEi2X2H6g==
Date: Tue, 25 Feb 2025 10:31:26 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 08/10] x86: BHI stubs
Message-ID: <202502251031.90B499810@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.717378681@infradead.org>
 <202502241100.9B62173958@keescook>
 <20250225085212.GG11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225085212.GG11590@noisy.programming.kicks-ass.net>

On Tue, Feb 25, 2025 at 09:52:12AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 24, 2025 at 11:01:02AM -0800, Kees Cook wrote:
> 
> > On Mon, Feb 24, 2025 at 01:37:11PM +0100, Peter Zijlstra wrote:
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Did this commit log go missing?
> 
> Nah, it never had one.
> 
> How does this sound?
> 
> ---
> 
> Add an array of code thunks, to be called from the FineIBT preamble,
> clobbering the first 'n' argument registers for speculative execution.
> 
> Notably the 0th entry will clobber no argument registers and will never
> be used, it exists so the array can be naturally indexed, while the 7th
> entry will clobber all the 6 argument registers and also RSP in order to
> mess up stack based arguments.
> 

Yes, this reads well. Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>


-- 
Kees Cook

