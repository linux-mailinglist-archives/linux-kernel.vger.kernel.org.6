Return-Path: <linux-kernel+bounces-576218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F32A70C77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC931892384
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728CA269CE0;
	Tue, 25 Mar 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWQ+/g03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8F267AFA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939776; cv=none; b=qiHiBUc1PyKUSxDslczVSQ23ykPRWxQtaEmcSGjvTt4Tnh03ZPhIF0aTL8O761M5+Cud0iDc+V6C/FEGukK2BaLI0WsQ0C7PIf7qEFJgtcYryUhFjyR5DZygfQPJf0L6SioFpCAy3Xqx3ehQoxWBeKZDKiGywuavw7EhrYPsJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939776; c=relaxed/simple;
	bh=7br8AaG8QRt+Y7p9nY+NCHBZBDh/3nwaBmqYeH6jESg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lfvyz+aS6DeSmm1yNvR7riT3lWZoOLggF3TPNyxKNZ4UoRnPuiT/QSLWWjTW8EJ5DONs4/RZFgjpvVNLARGzAIeJ0CGoXK+79P+klbESexjKx4ZIticXyde7/dAlqESvlgqL+trcmKfUX9+7rBx/dyhvW9BFfK/AFb4YVci5BFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWQ+/g03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122CC4CEE9;
	Tue, 25 Mar 2025 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939776;
	bh=7br8AaG8QRt+Y7p9nY+NCHBZBDh/3nwaBmqYeH6jESg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWQ+/g03fQn+hRaIRoCKXD6+Y8eThKxyhvkCl04fLOcAOacLNTjWG6ijtdClMdz6B
	 1GhL1SGMUbJWMjCEZzl0STLWPhNMPSv4TSaCzQ7a/lx6bpifNQBmHV5/Er6fHJSdMV
	 IKao2UZiJxq/t38PW7bNq54SSHz8GXme4Qs0lvH1mxY5hFCsU5sJIu5C25QT7We6jA
	 ubMwu47ACZalGYIgDrWj4XAdrowbtLBxSEUuyj5d+3oug9hKm1jOJzV5cBLZ2nmmlI
	 JRlTld60yDzpua++leJ6Nsrl+Vvddp1bBP9NpmtB2eBNXU59lQRxh9BYHTAhtt8/0K
	 USMN/5hyH6Ljg==
Date: Tue, 25 Mar 2025 22:56:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip 2/2] x86/hweight: Use POPCNT when available with
 X86_NATIVE_CPU option
Message-ID: <Z-Mme_OxuhYfxgzO@gmail.com>
References: <20250325164854.199420-1-ubizjak@gmail.com>
 <20250325164854.199420-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325164854.199420-2-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Emit naked POPCNT instruction when available with X86_NATIVE_CPU
> option. The compiler is not bound by ABI when emitting the instruction
> without the fallback call to __sw_hweight{32,64}() library function
> and has much more freedom to allocate input and output operands,
> including memory input operand.
> 
> The code size of x86_64 defconfig (with X86_NATIVE_CPU option)
> shrinks by 599 bytes:
> 
>   add/remove: 0/0 grow/shrink: 45/197 up/down: 843/-1442 (-599)
>   Total: Before=22710531, After=22709932, chg -0.00%
> 
> The asm changes from e.g.:
> 
> 	   3bf9c:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi
> 	   3bfa3:	e8 00 00 00 00       	call   3bfa8 <...>
> 	   3bfa8:	90                   	nop
> 	   3bfa9:	90                   	nop
> 
> with:
> 
> 	     34b:	31 c0                	xor    %eax,%eax
> 	     34d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
> 
> in the .altinstr_replacement section
> 
> to:
> 
> 	   3bfdc:	31 c0                	xor    %eax,%eax
> 	   3bfde:	f3 48 0f b8 05 00 00 	popcnt 0x0(%rip),%rax
> 	   3bfe5:	00 00
> 
> where there is no need for an entry in the .altinstr_replacement
> section, shrinking all text sections by 9476 bytes:
> 
> 	    text           data     bss      dec            hex filename
> 	27267068        4643047  814852 32724967        1f357e7 vmlinux-old.o
> 	27257592        4643047  814852 32715491        1f332e3 vmlinux-new.o

> +#ifdef __POPCNT__
> +	asm_inline (ASM_FORCE_CLR "popcntl %[val], %[cnt]"
> +		    : [cnt] "=&r" (res)
> +		    : [val] ASM_INPUT_RM (w));
> +#else
>  	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
>  				"call __sw_hweight32",
>  				ASM_CLR "popcntl %[val], %[cnt]",
>  				X86_FEATURE_POPCNT)
>  			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
>  			 : [val] REG_IN (w));

So a better optimization I think would be to declare and implement 
__sw_hweight32 with a different, less intrusive function call ABI that 
mirrors that of the instruction in essence, so that we optimize for the 
overwhelmingly common case of having the POPCNT instruction.

Thanks,

	Ingo

