Return-Path: <linux-kernel+bounces-368826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC39A154B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB21F25AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F911D3573;
	Wed, 16 Oct 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVPyu/u2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCA1D31A5;
	Wed, 16 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115643; cv=none; b=XvhCbKOF46GorYE0FWBJdX8OxHI8wMtyrolLex2Uva5Bpb7SlU1EK9sKJS13KI8HYUoivz9x4jxUd2tlXgojfrDJFgjn6JgzJrOqbKvY39ujv0empTeskLAS5m1Ogy8PL9dzhDzdrcvNLcy+ZpZGUzs5TkowJFOK0vustySFtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115643; c=relaxed/simple;
	bh=m+aILuSTQuuIvz+4xgsIPY5lFYR6pkyUgYclTIHsst0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtAV/jCmIX79svnH9PZxYHoxvYgX7XgbjPZSmBbISAR70POrk5LpMTp6jRiqXO81Wd0+ATD/AHimhLPjp3GGB1HznniVIInSKCIMP2vZr3ZBf9z5RUuvTzY4c/2M/xEbx9aZSV5bc9rnssLpXv7HA6uOSKHAgmMQC9nA/LcnYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVPyu/u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE03C4CEC5;
	Wed, 16 Oct 2024 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729115643;
	bh=m+aILuSTQuuIvz+4xgsIPY5lFYR6pkyUgYclTIHsst0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVPyu/u298rQiQTrf8v/DSFN+3cJy8mG6vWNDugyfFRfy8bwSKWUda7GHma7Watar
	 3Jb/2jnv75iXyxSi2Vz3j5u7OC7nXI77S2VOMX3F2tXYaeUpAh5e2Iisb0LCnv0fjs
	 gkI5Fq9s8Mjn7yR7szA7SpllJsOpMbIYHet/HxPPsqTf75cgwxsSm/D8ptvXzIbboj
	 Hw5wBrp2wSw188ResfPQyh2rONJyPMrfVOR/r5JPH7DKi9R9EEdbz88BxodF/9hOU3
	 o0Li7pS2J3c/VtAORVwQnB1UWyMu5VCdaxWOiBqwVLDcBsfChpDn5UJI1XfnGur9Io
	 szDkh+23H+22g==
Date: Wed, 16 Oct 2024 14:54:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	will@kernel.org, catalin.marinas@arm.com,
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64/crc32: Implement 4-way interleave using
 PMULL
Message-ID: <20241016215401.GC1742@sol.localdomain>
References: <20241016192640.406255-4-ardb+git@google.com>
 <20241016192640.406255-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016192640.406255-6-ardb+git@google.com>

On Wed, Oct 16, 2024 at 09:26:43PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Now that kernel mode NEON no longer disables preemption, using FP/SIMD
> in library code which is not obviously part of the crypto subsystem is
> no longer problematic, as it will no longer incur unexpected latencies.
> 
> So accelerate the CRC-32 library code on arm64 to use a 4-way
> interleave, using PMULL instructions to implement the folding.
> 
> On Apple M2, this results in a speedup of 2 - 2.8x when using input
> sizes of 1k - 8k. For smaller sizes, the overhead of preserving and
> restoring the FP/SIMD register file may not be worth it, so 1k is used
> as a threshold for choosing this code path.
> 
> The coefficient tables were generated using code provided by Eric. [0]
> 
> [0] https://github.com/ebiggers/libdeflate/blob/master/scripts/gen_crc32_multipliers.c
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/lib/Makefile     |   2 +-
>  arch/arm64/lib/crc32-4way.S | 242 ++++++++++++++++++++
>  arch/arm64/lib/crc32-glue.c |  48 ++++
>  3 files changed, 291 insertions(+), 1 deletion(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

> +	/* Process up to 64 blocks of 64 bytes at a time */
> +.La\@:	mov	x3, #64
> +	cmp	len, #64
> +	csel	x3, x3, len, hi		// x3 := max(len, 64)

The comment should say min(len, 64), not max(len, 64).

- Eric

