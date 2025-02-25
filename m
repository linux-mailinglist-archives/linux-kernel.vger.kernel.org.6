Return-Path: <linux-kernel+bounces-530844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE8A4393C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7B440930
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3892641F7;
	Tue, 25 Feb 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8c5xQo+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F91267AE3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474749; cv=none; b=R/Z+Y6ZIoysbwXYTiXfjZpsn8wuN3SOIOF504tg+dNpvGoVKCFgmsfHUPeVVRTX3CbDpExzmI8Ui2D5D9UCCnUcbH9HaLR7G5NWlO2ZPwgZpj1Hjd1D08kJK63+w/1EhoNW1rH25OCmZp98eM0fftgOzxOxJrzeNWFqVKDTggD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474749; c=relaxed/simple;
	bh=saJTl/rz3FTdOuD5O23ARIj2rQwZ67tsnr8yfGUlzms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggOI9+JQOWnCdANsGOAZxIFOVkjqplJdUkf5hEbAvaYwysO6Q0VwQ7nvD8c/hqmW8Uz9i9Ffss2QBDZ0iWXe5mrn9LH9VdkIQvSMZzdLNbtBS4irrie2VdLjEsry2zWbUItbX3UHvyoiNO+QosNc7qqgl9N8X3XTX/1bSK9RQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8c5xQo+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z5VuTg2iBpv9gBvZBLI09HpYczzDcEyyIN0W2/1zW3A=; b=R8c5xQo+IfMd93MKLHLN8EPwbk
	O4boUmPxSq0oWdFMzeUgrHdF6IIUrA+2bVb8LJ7KdD2UpwPe16fhH2s3u8YoRf+U4AlPlHNMxoVYr
	WC7dB6bqkSpFe1mqB5Whi/QkOT/iBpq7qKZbHpVAC3ebiLSXUMa7d/RNink/Riooir0Jw4UbZjZuo
	5UH5TfhYEyAQNqQwB7wRDUr0/qQlfwLjNtEYD4qf0Dmmf46bJnFkm2fIcqNdrzN+GT2vYQIiryYWh
	VrwjzjWqBJ0X4pLp8sZsn3cGnLFkhLiJnIwyIGIXhjDOtyXjD6ruYLRxCccXbHjdg5cMAJSj5rU5y
	hrainxEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqz8-00000003KEU-28DH;
	Tue, 25 Feb 2025 09:12:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D584A30072F; Tue, 25 Feb 2025 10:12:13 +0100 (CET)
Date: Tue, 25 Feb 2025 10:12:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v4 09/10] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250225091213.GI11590@noisy.programming.kicks-ass.net>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.820402212@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124200.820402212@infradead.org>

On Mon, Feb 24, 2025 at 01:37:12PM +0100, Peter Zijlstra wrote:
> While WAIT_FOR_ENDBR is specified to be a full speculation stop; it
> has been shown that some implementations are 'leaky' to such an extend
> that speculation can escape even the FineIBT preamble.
> 
> To deal with this, add additional hardening to the FineIBT preamble.
> 
> Notably, using a new LLVM feature:
> 
>   https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb6a200153eee245
> 
> which encodes the number of arguments in the kCFI preamble's register.
> 
> Using this register<->arity mapping, have the FineIBT preamble CALL
> into a stub clobbering the relevant argument registers in the
> speculative case.
> 
> (This is where Scott goes and gives more details...)

Scott, could you give a blurb here? Would the below cover things?

The basic setup, for 1 argument, is something like:

__bhi_args_1:
  jne .Lud
  cmovne %r10, %rdi
  ret
  int3

__cfi_foo:
  endbr
  subl $hash, %r10d
  call __bhi_args_1
foo:
  osp nop3
  ...


such that when speculation of an indirect call is maliciously steered
here from a non-matching site, the hash check (__cfi_foo's SUB) will not
match, resulting in !ZF and non-zero R10. Subsequently the __bhi_args
stub will either hit #UD exception, which kills speculation, or when
steered wrong, hit the cmovne, which will then clobber the argument
register RDI with whatever non-zero garbage sits in R10. Making it much
harder to control whatever foo normally does with its input argument.

Additionally, CFI hashes are randomized at boot, making it much harder
still to predict/control the non-zero value.

