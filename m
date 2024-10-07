Return-Path: <linux-kernel+bounces-353955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA899351A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825C61F248B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B601DD869;
	Mon,  7 Oct 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFibT2tB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0F192D6F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322427; cv=none; b=Ej/YR4qgi6FCgpAepJ+qA9moMzYFwPp65bCCUJdQBv4jVkHcNJOzfmTHd5VzTClL8djfWQStex7EPO0sGbOT4nMOyFHzWM4rd6H6I555Kv3EcbWvLErlGCIFabv85O9zsaQEE0xWU7Kk0tk/4CaQ2d1BXBZaM8yxHlLY2lUzAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322427; c=relaxed/simple;
	bh=TL76K3MAxgxIog+R6DJ2JsN+PA32O6sLwnDRgvH1QXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIYcMtmm82Gs7yVgX+xMWW/NYgnhov3cwo1M+/Tb2eROVrcGot1QIaFw9e/KkE3U+58iXqijJFf/IcTZc5njNd5/lUnNK10Xr6RDoeHSExpG/S39x+jXjLJ8e6EHBn4zg/nAtewcecoVgH7gAyj6P9+7Eh56EXLd5Hs5KMVBdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFibT2tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108CCC4CEC6;
	Mon,  7 Oct 2024 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728322427;
	bh=TL76K3MAxgxIog+R6DJ2JsN+PA32O6sLwnDRgvH1QXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFibT2tBrVv7Pd9/ISnTk5O4wSr5I6LcICvFLiAOLCv8Tc7tEGaCnl1tGifxj+4yl
	 Zw7hLc+ECo62mac5spUGnw3rkiZoM3QX8tF4Dtax/K+qh+PlvYXel6UrsSPZY16IPs
	 1rpiXoXQTC8hMTjLtCAwOiApmHIMrSX4WrSJqsxV7fzK0tMZqH5CBqHzkuiM46S2Ha
	 HxLwUZwXOf9NF66HJweeOgzodhhczldamCJLV1XqKC3axyUwXaZK1d80zkA4GXGNKc
	 v/cSe7dhSJXCt6jgJ0p7svxMkIVKIGFn6sMcVUDkCTg3T7QwA4irKbbcTwzZSQ/ev/
	 1TaMYzYjrIukg==
Date: Mon, 7 Oct 2024 10:33:45 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bp@alien8.de, david.kaplan@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241007173345.yokak3mlnqpsuxty@treble>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007083844.119369498@infradead.org>

On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> Replace the funny __warn_thunk thing with a more regular
> WARN_ON_ONCE(), and simplify the ifdeffery.
> 
> Notably this avoids RET from having recursive RETs (once from the
> thunk and once from the C function) -- recursive RET makes my head
> hurt for no good reason.

This could use an explanation for why the ifdefs can be removed and why
the alternative can be removed.

> +#define WARN_ONCE							\
> +	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;			\
> +	ASM_BUGTABLE_FLAGS(1b, 0, 0, BUGFLAG_WARNING | BUGFLAG_ONCE) ;	\
> +	REACHABLE

Can we not use __FILE__ and __LINE__ here?  Also why not put this in
asm/bug.h?

>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> -    defined(CONFIG_MITIGATION_SRSO) || \
> -    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
> -	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
> -		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> -#else
> +
> +#ifdef CONFIG_X86_64
> +	WARN_ONCE
> +#endif

Isn't this return thunk used before apply_returns()?  How does that not
trigger the warning?

-- 
Josh

