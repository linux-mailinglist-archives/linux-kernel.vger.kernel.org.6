Return-Path: <linux-kernel+bounces-371991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FB9A4301
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BE8286CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7F2022D7;
	Fri, 18 Oct 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgeeZh71"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9035165EFC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266915; cv=none; b=ausp52waYSy8EhmgeZalSgIgSEUjbZOd4NorVee8l2AEprne+GMcaqRGqH9xbAgW1ukn5oejnM8kJkGiOQyzwNRd2HsFL6K7vBkn2K/R4ZfZoiBapF6DqAfubd9atWM1dOZf+BkAo3ecXS1VRLUm68Y+pHTBrQtTsmbPzOFuIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266915; c=relaxed/simple;
	bh=htHCVl3dLq19V8wPIxFnR3ZwPaftOj2Ne5i0C7AnREY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDeGvjLf+9C5E02tEvQ7IEPeMnVWP07Kmta5exFcimBVOpBTCDbkDD7pNuCUxuR9b4B+HP4CQIvg9BWzhHoSGSv5IBh54CQSMj5tg7SZB5/AcbOtoqm7FrsA7b5iTkw1RcWEZlcIj1LdRpfN7w9rnFHuc9L/tO0XpnhIiFr4vjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgeeZh71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F2C4CEC3;
	Fri, 18 Oct 2024 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729266915;
	bh=htHCVl3dLq19V8wPIxFnR3ZwPaftOj2Ne5i0C7AnREY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgeeZh71kHHVa+cdIml4FAaHnIyZWEzgZRfuxPxxCs+RFgod+LNwbqICcNdi7yKjG
	 QG1DB6W5hM6ZVIvhWravyOF6IJevy+fGh8ntBge476UHqWIqXRDvOPzREa0THkkj74
	 Tc1xt0ykVx00t7JDcJObK37GMAXrH6vxy6QQB7M6CLaveixPdN5FuLclDcwS9RLUYG
	 ZPlR65HSH+C7UTrMN/lgWv8zpB2FXtMTM+LdBKsUJyWILobAbQNZoc3LeDI8+RljKY
	 oT1t72OoDDbv7tLUqEuj/7Vqg8AltGdVRJc2brKLDUmuMc0dPgOcJR5Gtplahxz4FA
	 QTr93f8rHUetg==
Date: Fri, 18 Oct 2024 08:55:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/6] x86/uaccess: Rearrange putuser.S
Message-ID: <20241018155513.zaufdhi7p5mrz2bp@treble>
References: <cover.1729201904.git.jpoimboe@kernel.org>
 <7818233ecd726628a3eb9cbb5ed0ba831e69af4b.1729201904.git.jpoimboe@kernel.org>
 <srdcfvwgmm4aiyny5ex24puhi7u4rohy2sjb2htrzqhr7igekx@bh3c22loauzb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <srdcfvwgmm4aiyny5ex24puhi7u4rohy2sjb2htrzqhr7igekx@bh3c22loauzb>

On Fri, Oct 18, 2024 at 11:51:06AM +0300, Kirill A . Shutemov wrote:
> On Thu, Oct 17, 2024 at 02:55:22PM -0700, Josh Poimboeuf wrote:
> >  SYM_FUNC_START(__put_user_2)
> >  	check_range size=2
> >  	ASM_STAC
> > -3:	movw %ax,(%_ASM_CX)
> > +2:	movw %ax,(%_ASM_CX)
> >  	xor %ecx,%ecx
> >  	ASM_CLAC
> >  	RET
> >  SYM_FUNC_END(__put_user_2)
> >  EXPORT_SYMBOL(__put_user_2)
> 
> This patch provides an opportunity to give these labels more meaningful
> names, so that future rearrangements do not require as much boilerplate.

Yeah, I can add a patch like Linus' patch to getuser.S which
encapsulates it all in a macro:

.macro UACCESS op src dst
1:	\op \src,\dst
	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
.endm

	.text
SYM_FUNC_START(__get_user_1)
	check_range size=1
	ASM_STAC
	UACCESS movzbl (%_ASM_AX),%edx
	xor %eax,%eax
	ASM_CLAC
	RET
SYM_FUNC_END(__get_user_1)
EXPORT_SYMBOL(__get_user_1)

-- 
Josh

