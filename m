Return-Path: <linux-kernel+bounces-513753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DBA34E38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2467188F302
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57081245AEE;
	Thu, 13 Feb 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mq+RTet6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1115252D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473930; cv=none; b=mk9edY68J9234qjwG8XLEchhZcqZPoVUe6MKsjq9H+vT1T44ASQ6SZb1azMnOJOBiO6b2OLhoBLDqbAuoAcuiVPTm51GArT7Nf26lLJm0AVLilbh8vhRf5NOa9h3RAz+rZPpShQ3g7O+akcaxabfnRGKKy3v9CLnzaYOMkCFmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473930; c=relaxed/simple;
	bh=tFXChyy2aIVz87TWhlcQ32Qg0b9npNLH5N3AWS9beaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDqYF6PTKZcLUNQw0i6UhNYjnKqvI1ZjJG5s7Owz9OLWh7w/giu7o9JKbC966NpoJFcL8lw/ePM3HRQKMFAb+I89SkSckaOliP8m8wr1fQBncpOaiUD7ket6UyDR3TYMS0hwWal2vBri91BrET/gjf3qGLkYGgnWel2qGJpkN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mq+RTet6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f8c280472so16355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739473928; x=1740078728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cwd2gT/+gwI2pOFC0CCqYFBggcE/G9NEWwpVM9ksFis=;
        b=Mq+RTet6qc5vdIYvMLfHcX9QJoi/JOXIPujqd9PAE7TMRgeOrI8gjvrbCiwkH6NzTH
         Ijj+NB711lJvmcwr51KghHxghjZLfmbFPhDOTcPGWpWfBDSMJeo5YkC6KHXowWUiujYD
         IKZ6z9CzkXh5FBnta0noQiycFIKaEG1ihk4OXRiu5IlXvpd6Ix9457YpnefXL0AurK3o
         84m9Tluecs/PRXqpk6jke7VQdjvaNm2g3U6PHia8Lb3sLvL6y/1Lt4JwSfpZ6FkE8uQr
         cysyXUAL+94gYCDlwMcrHSH5hRshV4vBemH95mGj2/R6xD2t5W5eTVJjelNAxj9FHseX
         rJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739473928; x=1740078728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwd2gT/+gwI2pOFC0CCqYFBggcE/G9NEWwpVM9ksFis=;
        b=WM0XdBp0Icfl52scB97GtDbLLTpyQOJk62+zgN2hqew+RjF3utpwVzIfvYpvVU+GGF
         tcS0AZhL5lgvgHbjIUnCeMFoenJ+hh8n4xxCf+GukRPj28k7aVrnBsAJT3QZgsE6YTWx
         LPGjbKJFq5czr3AWmKRbPuyfIAErEB5j5IQCVjGASl+0LUpltkXAFgnUKDKVl2WqnSzL
         j1x2ebkXtZKel61oZ411BkcCWFwE18eZbI4PfVxfpinAs3svLsG6EcK1wxXSTeRh5ny9
         CQTwB2+nUE63sv/K9rv7rdG3dfoh/jdhuDmZ9fdYWSHZkMPqDDd1lP2KtWNXYnIJW0N3
         WT/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZAITvM2qpFtSztR5b6GMqBXdEvB+PthcpUJ/SN1b48KOMJZ4J5WVt886fxOhos5F4b9sMkhtheCVBEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz306FuJIf3Pp3Qb0lzZErz1JDXlD/kfoXpyhJj1BDchZHaJiL6
	r2z2CAs8osFTBWz7y1ZJXw2YY7dpBPheTw8gAsKvGiVp2VztVGRKDEHpPkLL8Q==
X-Gm-Gg: ASbGncsPETu7Tg3Qxnq8vuMDrz32SRubmMb6hmfqiO3KhhT7OtJZgJpEADfqpcCuIvW
	pYt6HePVzIXeyVNSgsrvhIViBbtZT3+5uoD8DmQ8jL/PfjxccS7UbURk6omDRkvP3qROHRw15Qr
	K70UV/JASeoPPZKehIqnZcM9GIoCyxmTlRgO33blyKhdXDbjn3SEk/WiUQ6t1ECg0NwF20i/rrb
	153X0o8ya0j2p14T4oflXP3TJYJwAsBj4qvoM8NojulvVFETYJMnlH++zoQRzaDZbxSCK2ifBcP
	FWoNyBwwrJHhH5ZBnGtCWhW3LYofhvhss+ZXnb4GGBev3u6BkTm43ctsi/u+GA==
X-Google-Smtp-Source: AGHT+IHrsZ4UVK7TjUb87Wo3L12Bzh7xYYTf6joGDlKINTRazH3aKs4Etmksdp0M7DGP4yRC/RrrHA==
X-Received: by 2002:a17:902:d54e:b0:212:26e:1b46 with SMTP id d9443c01a7336-220ed011226mr65255ad.23.1739473928100;
        Thu, 13 Feb 2025 11:12:08 -0800 (PST)
Received: from google.com (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732427622a7sm1625671b3a.155.2025.02.13.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:12:07 -0800 (PST)
Date: Thu, 13 Feb 2025 19:12:02 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 00/11] x86/ibt: FineIBT-BHI
Message-ID: <20250213191202.GA3105334@google.com>
References: <20250207121529.222723073@infradead.org>
 <CABCJKudA8aUf=SDsVOOsWX_Cq6LAcioOjgtpv+uq+WGwJbxFPA@mail.gmail.com>
 <20250213104802.GE28068@noisy.programming.kicks-ass.net>
 <20250213114547.GB30841@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213114547.GB30841@noisy.programming.kicks-ass.net>

On Thu, Feb 13, 2025 at 12:45:47PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2025 at 11:48:02AM +0100, Peter Zijlstra wrote:
> 
> > > One thing I realized is that CONFIG_CFI_PERMISSIVE doesn't actually do
> > > anything when FineIBT is used since we lose track of CFI trap
> > > locations. I'm not sure if that's worth fixing, but perhaps we could
> > > disable FineIBT when permissive mode is enabled to avoid confusion?
> > 
> > Hmm, yeah, that's one thing I keep forgetting about. Let me try and fix
> > it and see how ugly it gets before offering an opinion :-)
> 
> Completely untested and on top of this series minus the last two patches
> -- basically what I just pushed into:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core
> 
> WDYT?
> 
> ---
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index e285933506e9..1fec1e445a25 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1410,6 +1410,36 @@ static void poison_cfi(void *addr)
>  	}
>  }
>  
> +bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
> +{
> +	/*
> +	 * FineIBT preamble:
> +	 *
> +	 *  __cfi_foo:
> +	 *     endbr64
> +	 *     subl $0x12345678, %r10d
> +	 *     jz   1f
> +	 *     ud2
> +	 *  1: nop
> +	 *  foo:
> +	 *
> +	 * regs->ip points to the UD2 instruction.
> +	 */
> +	unsigned long addr = regs->ip - (4+7+2);
> +	u32 hash;
> +
> +	if (!is_endbr((void *)addr)) {
> +Efault:
> +		return false;
> +	}
> +
> +	*target = addr + fineibt_preamble_size;
> +
> +	__get_kernel_nofault(&hash, *(u32 *)(addr + fineibt_preamble_hash), u32, Efault);

You have an extra * here, should be just (u32 *).

> +	*type = (u32)regs->r10 + hash;
> +	return true;
> +}
> +
>  #else
>  
>  static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
> @@ -1421,6 +1451,11 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
>  static void poison_cfi(void *addr) { }
>  #endif
>  
> +bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
> +{
> +	return false;
> +}
> +
>  #endif
>  
>  void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
> diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
> index e6bf78fac146..4c682076c656 100644
> --- a/arch/x86/kernel/cfi.c
> +++ b/arch/x86/kernel/cfi.c
> @@ -61,6 +61,8 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
>  	return true;
>  }
>  
> +extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
> +
>  /*
>   * Checks if a ud2 trap is because of a CFI failure, and handles the trap
>   * if needed. Returns a bug_trap_type value similarly to report_bug.
> @@ -70,11 +72,25 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
>  	unsigned long target;
>  	u32 type;
>  
> -	if (!is_cfi_trap(regs->ip))
> -		return BUG_TRAP_TYPE_NONE;
> +	switch (cfi_mode) {
> +	case CFI_KCFI:
> +		if (!is_cfi_trap(regs->ip))
> +			return BUG_TRAP_TYPE_NONE;
> +
> +		if (!decode_cfi_insn(regs, &target, &type))
> +			return report_cfi_failure_noaddr(regs, regs->ip);
> +
> +		break;
>  
> -	if (!decode_cfi_insn(regs, &target, &type))
> -		return report_cfi_failure_noaddr(regs, regs->ip);
> +	case CFI_FINEIBT:
> +		if (!decode_fineibt_insn(regs, &target, &type))
> +			return BUG_TRAP_TYPE_NONE;
> +
> +		break;
> +
> +	default:
> +		return BUG_TRAP_TYPE_NONE;
> +	}
>  
>  	return report_cfi_failure(regs, regs->ip, &target, type);
>  }

Otherwise, LGTM.

One minor issue is that since the trap is in the preamble, we don't
get caller information in the warning message:

[   19.080184] CFI failure at __cfi_lkdtm_increment_int+0xd/0x10
(target: lkdtm_increment_int+0x0/0x20; expected type: 0x7e0c52a5)

But this is followed by a call trace, so it's not really necessary
either. With the __get_kernel_nofault argument fixed:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

