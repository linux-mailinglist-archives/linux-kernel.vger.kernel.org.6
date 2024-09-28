Return-Path: <linux-kernel+bounces-342299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29C988D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D161C2117A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3813AF9;
	Sat, 28 Sep 2024 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPAsBZPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E9FC11
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727485656; cv=none; b=CpRIETcnpdk9H947CYArD7/7RX3/NqvvWxeMKTnnPRsAQ9SeVZE3QNA9fK85SFaJYwlSjrlmtMc7nL6hQTeUgjX9qLY5/7gf+94AdNZ85y1+tuBn5xWuow/PV6d6XfVWJzwi03GBUDZxscSspCYBBlSrQb2NXwSDagClzgR9ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727485656; c=relaxed/simple;
	bh=tUDgcQT7zC/Fpvoc+1nqde+yyKWOS1VWx2sGxkJr8uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv/R4g5j2FjlaIF9fJUKHdAJSG0XTUkRf400AmD/uKsanvdB/Y96y3zKcd4t/XKRnydMdrPVSlvC3GpcwoP1jzY3SBLnkXGGXk1FYl2sMfteEbaoi50nIL0PUvJLPy575TKqYbq0ConAHzlVMbkBjMyFm/gRNyN5dqZ8/U1C8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPAsBZPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DB6C4CEC4;
	Sat, 28 Sep 2024 01:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727485655;
	bh=tUDgcQT7zC/Fpvoc+1nqde+yyKWOS1VWx2sGxkJr8uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPAsBZPjBfEm2OjHeHIvOC/69CTy0dY9C4/OyE6r7wyJDbzZ9j897ubWsI8GgIC0V
	 YcZQAtEgBcLygn9eRB5HGp/a9h7PP6fgGHYWpzfHvxAE8NiVpA46e4rKEc2dzXwoQ3
	 lm0/CLud2QeCz2tDzcgYUXY2IwyV9BR8BdjkTAmITqUHrIkdXpLNxxvCVc/RKdfRsc
	 7lOhXodQEG3EdAvRRrMImYYTtR4EW9Q69Hv6GAxIdRY+fQuY2nBLTySpiOZAfNWhwu
	 LMxXjgPAVtR4EZ9xHnq8shKSMR8ALaotR+dkcSK9fRkcyA5/MoCC4QxR/FLs33ujFC
	 CxSKzymuaYeEw==
Date: Fri, 27 Sep 2024 18:07:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
Message-ID: <20240928010733.dxds5myhn7efgrh2@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.283644921@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194925.283644921@infradead.org>

On Fri, Sep 27, 2024 at 09:49:05PM +0200, Peter Zijlstra wrote:
> +static void *translate_call_dest(void *dest, bool call)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
> +		if (!call)
> +			return dest;

A tail call is considered a call by virtue of the function name.  Change
the "call" arg to "tail" to make it clearer.

> +++ b/scripts/Makefile.lib
> @@ -269,6 +269,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HA
>  objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
>  objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --direct-call
>  objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
> +objtool-args-$(CONFIG_X86_KERNEL_IBT_PLUS)		+= --direct-call

Only add '--direct-call' once:

objtool-args-$(or $(CONFIG_MITIGATION_CALL_DEPTH_TRACKING),$(CONFIG_X86_KERNEL_IBT_PLUS)) += --direct-call

>  objtool-args-$(CONFIG_FINEIBT)				+= --cfi
>  objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
>  ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1455,7 +1455,7 @@ static void annotate_call_site(struct ob
>  		return;
>  	}
>  
> -	if (!insn->sec->init && !insn->_call_dest->embedded_insn) {
> +	if (!insn->_call_dest->embedded_insn) {

Why did we have the 'init' check to start with?  Presumably init memory
gets freed after the call dest patching so this is not a problem?

-- 
Josh

