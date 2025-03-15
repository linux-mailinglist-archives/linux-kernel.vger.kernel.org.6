Return-Path: <linux-kernel+bounces-562306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F497A62282
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF97A97EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF8383;
	Sat, 15 Mar 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmqtxevp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC589184
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997137; cv=none; b=JhgX2ZCiJsapzETgFH8VZ8yRmwjG5vjb1o5hWttjGhyf5oHnXivl5dHjEMA1g82wuEeMggFgYbhQsH9PYad/5Zfprl3RRy8Er7yG/Lzc4E3h+LjW7pqpwZMqI+cW/70PtBw4ev3H5cTeufvZbDFpawhTPXIPL4DX89tmhAlaHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997137; c=relaxed/simple;
	bh=M/snCJZcOTzV0RZogI1SxmL2NWqUOAdHzcd3g7E6NN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC7fGloVCSsg5upkIji2bSPI5hL8vPrX5aoLaxzorKKJF0U2cf8P6bobnHqNfJGVrkAx/G0VLoSRfb3CwwhHKBNjB59de2mRfo8LyGVLvgVhGI+cctKAEbqoLE0IPa8tEmQQDgP/9ltZLoCfKD5Kch4++jpCl6dIlwKBgxGaoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmqtxevp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA9C4CEE3;
	Sat, 15 Mar 2025 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741997137;
	bh=M/snCJZcOTzV0RZogI1SxmL2NWqUOAdHzcd3g7E6NN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qmqtxevp4xo6njHI43QoCbEc5bUWxfqZTr1zrHnuO8XRC2I+qeNPj9MdAjAyhcvHe
	 9e1MRlK1c5rkM1LhfpkUWNt6ouNqFd1RyawqBB+KhXdBIDgxI64l+uXMdv79cEJO1M
	 TE/FZOm3Vkqsw7S6+SVPQ2CqpN3T81nFqjXthvPbkHe80fIOCdUx48XVaq9xXCv1eL
	 zPkPNscALE/hvki/SfODm9JTgofrx40uBNwUiFnAwIWrj5BAtefB+qPNqyUsJ9mfTt
	 AvNy3xrmfDXoA/M+g9Nf/WW87jTojXOXONF8f1yiRZPMgNCpCoRU0rb1Pi31Ok2LES
	 DbPq7rVdIkj6Q==
Date: Fri, 14 Mar 2025 17:05:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>

On Fri, Mar 14, 2025 at 01:49:48PM -1000, Linus Torvalds wrote:
> So all of these patches look like good cleanups to me, but I do wonder
> if we should
> 
>  (a) not use some naming *quite* as generic as 'ARG()'
> 
>  (b) make the asms use ARG_OUT/ARG_IN/ARG_CLOBBER() to clarify
> 
> because that ARG(), ARG(), ARGC() pattern looks odd to me.
> 
> Maybe it's just me.
> 
> Regardless, I do think the series looks like a nice improvement even
> in the current form, even if that particular repeated pattern feels
> strange.

So originally I had ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER, but I ended up
going with ARG() due to its nice vertical alignment and conciseness:


	__asm_call(qual,						\
		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
			    "cmpxchg8b " __percpu_arg([var]),		\
			    X86_FEATURE_CX8),				\
		ARG([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
		    "+d" (old__.high)),					\
		ARG("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
		ARG("memory"));						\


Though ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER isn't so bad either:

	__asm_call(qual,						\
		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
			    "cmpxchg8b " __percpu_arg([var]),		\
			    X86_FEATURE_CX8),				\
		ASM_OUTPUT([var] "+m" (__my_cpu_var(_var)),		\
			   "+a" (old__.low), "+d" (old__.high)),	\
		ASM_INPUT("b" (new__.low), "c" (new__.high),		\
			  "S" (&(_var))),				\
		ASM_CLOBBER("memory"));					\


That has the nice benefit of being more self-documenting, albeit more
verbose and less vertically aligned.

So I could go either way, really.

-- 
Josh

