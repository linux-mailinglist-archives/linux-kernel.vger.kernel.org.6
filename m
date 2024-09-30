Return-Path: <linux-kernel+bounces-344896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610298AF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E496FB232CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEE1865F3;
	Mon, 30 Sep 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BByfuZm8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3515E97
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732809; cv=none; b=aIg3goZqvaAMC4tGxbB15+QDZ3P6PPR/6qYqtmbtOXn6jc0pS5vp+9j8LG8D6LyFO940koEy+rTf8KIS4QpoI3v1SwmvukvMIqCdTcBlry++7dZJ62PVRDdcA2kCEW3ho75lND/LX3df1ZlFLH91F5Hqd0hGb+Enak1BsFCGCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732809; c=relaxed/simple;
	bh=6TAvOvYOh3R/BBTSwNpb8uVIMQYB9IvH+hVRG73cv00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa8zQD2syiu0QHi9+v5BInj4u5GI5QGueXhnTZqseljlEbH4KV3rTT9A0bWnejQ2neLDy+7ULbcKcuKR/Maweb3QgfpCwSbN0VIloaJ77bIY5TqsINxXVr1eMBf1VUY8rdd491d+9P5qX+3nya8vnH6V8At+oDznvz6jnHv2PAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BByfuZm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4207C4CEC7;
	Mon, 30 Sep 2024 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732809;
	bh=6TAvOvYOh3R/BBTSwNpb8uVIMQYB9IvH+hVRG73cv00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BByfuZm8zeXI/Zpu63nxcOQT9grl7qgFlqcSECYy5an+B6kow/coAVrpr2pBdrTuA
	 hSYpg9Ob1dy6SlR3Jk6cSBIXm47/hR3MDjA4oXNGW7W1Ya28KwXVSm0WcDIdkWtuUV
	 7OjS8Nhx33DA2xOfZsvEi8I8SFxfJwQ17e1yLvMWiOs/cZwaWBcYBhdUXaMktIEjCF
	 8PAvh87lMajneIjul0X+LzRHlxINHKY595owTnKTp2eRLrLMfjBaK5+jSEOucffz1m
	 tFg0zsNg+0ir3P4pMKlqeujU44be//Pp5W9m+nOsqVBECbIOCf9Y8HRA8/Wm+5hjLt
	 qPUeV1xKkGgTw==
Date: Mon, 30 Sep 2024 14:46:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20240930214647.eam77ffbyvkx5drk@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930213030.ixbsyzziy6frh62f@treble>

On Mon, Sep 30, 2024 at 02:30:32PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> > +/*
> > + * At the function start, launder function arguments that are a pointer through
> > + * CMOVcc, this will create a write dependency in the speculation flow.
> > + *
> > + * Notably, the CFI preambles calling these will have ZF set and r10 zero.
> > + */
> > +
> > +.pushsection .noinstr.text, "ax"
> > +
> > +	.align 8
> > +SYM_CODE_START(__bhi_args_6c1)
> > +	ANNOTATE_NOENDBR
> > +	.align 8
> > +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
> > +	UNWIND_HINT_FUNC
> > +	cmovne %r10, %rdi
> 
> IIUC, this works because if the "jz" in the CFI preamble mispredicts to
> the __bhi_args_* code, "cmovne" will zero out the speculative value of
> rdi.
> 
> Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?

BTW, this "speculative pointer clearing" feature is broader than just
BHI so I wouldn't call it that.  It's really just a logical extension of
FineIBT IMO.

-- 
Josh

