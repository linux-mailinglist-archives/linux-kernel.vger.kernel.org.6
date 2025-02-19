Return-Path: <linux-kernel+bounces-522204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A16A3C761
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599ED3BAE11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A521481B;
	Wed, 19 Feb 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDIROf3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279751FA267
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989418; cv=none; b=eqsu/ecv71DP1+oZZxHdh92HSH0EJVQv/i6/u9t5dgAKs9mXKCBUknbPQyJxe9+/kuU4+/DLHEy6fY8S9rGJvJGScA1h7IF6wtvKT3hArg1JalXu2SuFHCYi3VADcbF0ZTi3WKlwIClKaal0NeTx+BfiR6QTU5IAbm0iXJyTBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989418; c=relaxed/simple;
	bh=mEGt7WDWrinT6c9r8+Ftc6ZedRfW9XkXNXg2znesnzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otHFHmaTpsOkJcLBJGVTPhfo5F9ZYmeuuHMuJ5GwFb8km/k0gqtlXLUztcBxWxRI47BGkhLTLDSdWQb1krUCANQfPwyfu6MEfTtaSsXesXXMgPQOcbegbO1AvXjz8ZAOvODAY54jSALh5NsUPNIk0JKXJ8jGkAXZeNkqXK/fMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDIROf3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF279C4CED1;
	Wed, 19 Feb 2025 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989418;
	bh=mEGt7WDWrinT6c9r8+Ftc6ZedRfW9XkXNXg2znesnzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDIROf3/LJEbfsOVhWjAAVryPgiM89JOh5zT4v3keHWkble37HxS8dpPrCWhLo/zk
	 XzOq5dAAWhEWRazHHFkRsWgL4HFXYRRKUqpbvfcIO76lFsyuFvfivweRNfC5DrW6VP
	 3Y6mAZEeLsUHzFHfWods9yF5E/Ntfx+9Py+sXmDNnPZZrhE6l2gs9VHXUSxg/XSzGB
	 4HtYAaAkMnJ6Eb+ExY7yYLMSVz1w4NYG/JiFryH0U5EtfH7DVM58mube1FZeX0tigx
	 2envJbo4m3bVsQsw8BfaQsWsEAHOCgqV67f2uPNc2EaxhQd7BBuR72WMF5xQ6pxKAm
	 ziAuvAnOEnZUw==
Date: Wed, 19 Feb 2025 10:23:34 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
Message-ID: <202502191023.4E0BE00CC7@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.791951626@infradead.org>
 <202502190959.C414304@keescook>
 <20250219181833.GD23004@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219181833.GD23004@noisy.programming.kicks-ass.net>

On Wed, Feb 19, 2025 at 07:18:33PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2025 at 10:01:15AM -0800, Kees Cook wrote:
> > On Wed, Feb 19, 2025 at 05:21:12PM +0100, Peter Zijlstra wrote:
> > > Scott notes that non-taken branches are faster. Abuse overlapping code
> > > that traps instead of explicit UD2 instructions.
> > 
> > Some kind of commenting is needed in here to explicitly call out the
> > embedded EA in the "subl" instruction. There is a tiny hint of it in the
> > disassembly dump of fineibt_preamble_start, but it's very subtle for
> > someone trying to understand this fresh.
> 
> Ah, but you found my clue :-)
> 
> How's this?
> 
> ---
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1080,6 +1080,9 @@ early_param("cfi", cfi_parse_cmdline);
>   *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
>   *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
>   *  d:   0f 1f 00                nopl   (%rax)
> + *
> + * Note that the JNE target is the 0xEA byte inside the SUB, this decodes as
> + * (bad) on x86_64 and raises #UD.
>   */
>  asm(	".pushsection .rodata				\n"
>  	"fineibt_preamble_start:			\n"

Better! Thank you. :)

-- 
Kees Cook

