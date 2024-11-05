Return-Path: <linux-kernel+bounces-396279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 256879BCAAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DB1B21A92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419961D2B17;
	Tue,  5 Nov 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bJh4qlmL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AC1D27AF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803229; cv=none; b=Z6VL8uFXVA1Cd7ka5a5y3PNCIx6sAUepu5R11m66XgdXzOp5s13uh3/YIwsnO9+Yenf9JPFg8ZoNdIcEjqbNRMIXV5k+chH84Z7yNmFZkm1nrnDw6QTm/Ol9V+JOLmRHnGPeL3dtWSN5DgsoKsbvhAs80YMOsecTpDAaneto/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803229; c=relaxed/simple;
	bh=lPVvusvKe75N4H8WC79obt8DA6iLji14EOgIcIUKPZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAtDN8gpbpFMHRqVOcsMP732RVr0Es/V2DsdWScMfrV+PJV1QhqGa9WjNzhTt5TkR2v5bdaEd/ByQffWsmYbOwu3h+VB783lc9aGIYNueMMrdNfG1MfyUQJpedCjpP7o4HRr4CeYU9f1rCCzJ6ypxKRhCUNMeeVyp9X1NFtBa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bJh4qlmL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t3NDHAEOvBkB05lX8OeacuHHWaOcStiYW+e4UMOvUlM=; b=bJh4qlmLR1mo5ftmOnCjDCwYLF
	2hPKn/FuRwkrr9FJNpd1AHgzLGmlofM4gUfskSFZraFEZtFBHO6DfqVjtGmr2A6C+2oIydqW2Wq2G
	MOOYasntQzgrygSO8WgY2EPlP+tRAB0cF+g/9RkoCSlcbNLa4h089fnsYtKHw+j1WrpawSnlMIo3h
	yfSMNZV+WxLwb+PFHELENsOfd3eXyGVe6zhuiWOXNA7pj11oul1Qk2Kuhw6wZqahhdNDn0qQvdLDT
	7plslLUrVF84Qa1/3/FKcI59Ht9wxJcuY69mHseak4uZctX2Sa2OXFPNsh/EPg6ztMj0KFbMoFJ1L
	R6lI8Tlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Gyy-0000000Bj09-3t63;
	Tue, 05 Nov 2024 10:40:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15BD0300324; Tue,  5 Nov 2024 11:40:20 +0100 (CET)
Date: Tue, 5 Nov 2024 11:40:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
Message-ID: <20241105104020.GC10375@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.283644921@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927194925.283644921@infradead.org>

On Fri, Sep 27, 2024 at 09:49:05PM +0200, Peter Zijlstra wrote:

> +#ifdef CONFIG_X86_KERNEL_IBT_PLUS
> +__init_or_module void apply_direct_call_offset(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	/*
> +	 * incompatible with call depth tracking
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
> +		return;
> +
> +	for (s = start; s < end; s++) {
> +		void *dest, *addr = (void *)s + *s;
> +		struct insn insn;
> +		int ret;
> +
> +		ret = insn_decode_kernel(&insn, addr);
> +		if (WARN_ON_ONCE(ret < 0))
> +			continue;
> +
> +		dest = addr + insn.length + insn.immediate.value;
> +		if (!is_endbr(dest))
> +			continue;
> +
> +		switch (insn.opcode.bytes[0]) {
> +		case CALL_INSN_OPCODE:
> +		case JMP32_INSN_OPCODE:
> +			apply_reloc(4, addr+1, 4);
> +			continue;
> +
> +		case JMP8_INSN_OPCODE:
> +		case 0x70 ... 0x7f: /* Jcc.d8 */
> +			apply_reloc(1, addr+1, 4);
> +			continue;

*sigh*... I have a clang-19 build (thanks 0day) that uses a jmp.d8 +0x7e
as a tail-call, guess how well it goes adding 4 to that :-(

Luckily the next instruction is a giant (alignment) NOP, so I *could* go
fix that up, but perhaps this is pushing things too far ...

> +
> +		case 0x0f:
> +			switch (insn.opcode.bytes[1]) {
> +			case 0x80 ... 0x8f:
> +				apply_reloc(4, addr+2, 4);
> +				continue;
> +
> +			default:
> +				break;
> +			}
> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +		printk("at: %pS, instruction: %*ph\n", addr, insn.length, addr);
> +		BUG();
> +	}
> +}
> +#else
> +__init_or_module void apply_direct_call_offset(s32 *start, s32 *end) { }
> +#endif

