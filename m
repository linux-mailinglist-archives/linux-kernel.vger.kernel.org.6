Return-Path: <linux-kernel+bounces-522193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE95A3C742
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E65C3AD3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55BB1FDE27;
	Wed, 19 Feb 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW2akTXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2E1494DF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989229; cv=none; b=kAdYmk54/Yl2qczLUNIXRxXv2EgA3hZ1YNLlOLcA2Y5oT9gJlhMYB4iTilAc1Rpi9QmgvQy61Pw3Bmvy05VJToT+a5ZX2rjEMPGoSw3dF1pp1LJHJCXck0dMlejloZjRL8a9Fqv51+goH39qQA33bIK9S0yuAFdDuRnpqjSUlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989229; c=relaxed/simple;
	bh=DCjk6dDVCRMWeL58L3QZn9z12drE+ckbb/rbzxaBZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeaSGwIXybQevoUxak0uniRNAKkalhJmPX4xrMMbOWfSjvqL0bzyVy3sZEB2wjIAG8gNqjsR7AiFmfARLlUC2x3TnuqSp9+Vun0zPwj+HbFvwZQc/9mGa4JYG8kg52hHzkKoTMuw20hRUfaosLftkGoSQKrF5x5mBP/9BDzet94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW2akTXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD170C4CED1;
	Wed, 19 Feb 2025 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989228;
	bh=DCjk6dDVCRMWeL58L3QZn9z12drE+ckbb/rbzxaBZj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uW2akTXoAwcO/+ojDy+ryGkKmLSXP+Wht5ZN3QW3CStdi5nU/nhCDlOMYz+B63/ip
	 WuQKPyKWCITWZ7cQvkWibNk9bk0Ou3F6FH2z4L6rr4GJfThxHj/oMpH5egD0O3El8p
	 pTiNFklhcJIvutAgWXyA4xggT8p7Gzg02etNsbWsbEaoHDI3N2yvN0zK3dXsF6Kv2L
	 wj0AyHVtZ3tmX2yAhWfHyRgHV00VktvtOuPGzpXMse/BWeilM+bhjlb985prfll/tX
	 66H8LeJ/7nvLF5hz1YlG9hrhbbQL4icWgM2BRjRyUR2DbuJRrWGSnfWT4bOI/Tw5A+
	 +Q86/S+1FozYA==
Date: Wed, 19 Feb 2025 10:20:25 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <202502191013.72E4EFFF0@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.928125334@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.928125334@infradead.org>

On Wed, Feb 19, 2025 at 05:21:13PM +0100, Peter Zijlstra wrote:
> Because overlapping code sequences are all the rage.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <kees@kernel.org>

Semi-pointless stream of consciousness below...

> ---
>  arch/x86/include/asm/bug.h |    2 ++
>  arch/x86/kernel/traps.c    |   30 +++++++++++++++++++++++++-----
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -17,6 +17,7 @@
>   * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
>   */
>  #define INSN_ASOP		0x67
> +#define INSN_LOCK		0xf0
>  #define OPCODE_ESCAPE		0x0f
>  #define SECOND_BYTE_OPCODE_UD1	0xb9
>  #define SECOND_BYTE_OPCODE_UD2	0x0b
> @@ -26,6 +27,7 @@
>  #define BUG_UD1			0xfffd
>  #define BUG_UD1_UBSAN		0xfffc
>  #define BUG_EA			0xffea
> +#define BUG_LOCK		0xfff0
>  
>  #ifdef CONFIG_GENERIC_BUG
>  
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(uns
>   * If it's a UD1, further decode to determine its use:
>   *
>   * FineIBT:      ea                      (bad)
> + * FineIBT:      0f 75 f9                lock jne . - 6
>   * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
>   * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
>   * static_call:  0f b9 cc                ud1    %esp,%ecx
> @@ -106,6 +107,7 @@ __always_inline int is_valid_bugaddr(uns
>  __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
>  {
>  	unsigned long start = addr;
> +	bool lock = false;
>  	u8 v;
>  
>  	if (addr < TASK_SIZE_MAX)
> @@ -114,12 +116,29 @@ __always_inline int decode_bug(unsigned
>  	v = *(u8 *)(addr++);
>  	if (v == INSN_ASOP)
>  		v = *(u8 *)(addr++);
> -	if (v == 0xea) {
> +
> +	if (v == INSN_LOCK) {
> +		lock = true;
> +		v = *(u8 *)(addr++);
> +	}
> +
> +	switch (v) {
> +	case 0x70 ... 0x7f: /* Jcc.d8 */
> +		addr += 1; /* d8 */
> +		*len = addr - start;
> +		WARN_ON_ONCE(!lock);
> +		return BUG_LOCK;
> +
> +	case 0xea:
>  		*len = addr - start;
>  		return BUG_EA;
> -	}
> -	if (v != OPCODE_ESCAPE)
> +
> +	case OPCODE_ESCAPE:
> +		break;
> +
> +	default:
>  		return BUG_NONE;
> +	}
>  
>  	v = *(u8 *)(addr++);
>  	if (v == SECOND_BYTE_OPCODE_UD2) {
> @@ -315,7 +334,8 @@ static noinstr bool handle_bug(struct pt
>  
>  	switch (ud_type) {
>  	case BUG_EA:
> -		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +	case BUG_LOCK:
> +		if (handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
>  			if (regs->ip == addr)
>  				regs->ip += ud_len;
>  			handled = true;
> @@ -324,7 +344,7 @@ static noinstr bool handle_bug(struct pt
>  
>  	case BUG_UD2:
>  		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +		    handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
>  			if (regs->ip == addr)
>  				regs->ip += ud_len;
>  			handled = true;

I realize these are misplaced chunks, but passing ud_type into the
handler feels like a layering violation to me. I struggled with this
when making recommendations for the UBSAN handler too, so I'm not sure
I have any better idea. It feels like there should be a way to separate
this logic more cleanly. The handlers are all doing very similar things:

1- find the address where a bad thing happened
2- report about it
3- whether to continue execution
4- where to continue execution

The variability happens with 1 and 4, where it depends on the instruction
sequences. Meh, I dunno. I can't see anything cleaner, so passing down
ud_type does seem best.

-- 
Kees Cook

