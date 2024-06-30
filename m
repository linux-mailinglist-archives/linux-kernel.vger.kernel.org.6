Return-Path: <linux-kernel+bounces-235268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568491D296
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD83281554
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C4A154439;
	Sun, 30 Jun 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q7n/hots"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACE282F1
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763520; cv=none; b=pvoQa7NqmU2EygMJSoQeSQsr93LNVWx9x2s25Qu6cqkXg1fgLRxrmlvv+Do5YJcKQzRb21ReTpDsyrBFdOMPY/YqVuvlN0bkO/h5lWC+zJOgTSDeMYryP8o5lBYH1QG/VQiNu6vT7buBfbfd/Ey5RtHRfn4gKUiac/52VjsbI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763520; c=relaxed/simple;
	bh=xjdQ+cdMGH2qXasqvLWfOtjSEaUALthrzfnLKyK58nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqvfnFtlPJmOkzkJJ8ZSbwJQDvGucmkMlcXNNvmtQcCwFU0gJiPtfqt5o7JE2letIILElQ7Xn5T3sH+1vFbX9b+MoqDDd2F8FdYXcXcn/pw/Jk+jMrY/oW47zXP4C1h2o8lyip5r1xFOy/jwlAk30mYLAlcj3PZ4wuthgLF/0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q7n/hots; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C793940E0192;
	Sun, 30 Jun 2024 16:05:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SMPHyb_7aKpl; Sun, 30 Jun 2024 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719763506; bh=aTHgiCyZojVnq+qG73dB6B+ySI2Fdppus79oUpTpxiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7n/hotsxHfL28caHK7XDtDYHs95L+L0ja0hg8Lml9tl0qghQ9QYbsKzWUlh7Mrvp
	 rn9HjnW8KhLO8QMrQyCGvIraSsCioxQJjtmD/0dsstrcw7k5b2S2d5NoyDg7++psui
	 gIgRGdpUQiHpRIw0nWTP60feeUMJIOeag6mzTj6Jb9gvYfCoFg4nVdSN7mFdq9j5d5
	 jYH2BC7odiKwywSSTP8LIT7qYC6SOFPWvHj0/SeLuiBIDOTWpB4IuDPAl6trBgQJ4Q
	 3h7gV7LYtmZ/je0hmedKopdh4ATO+UmaLoDHOHkdrY590KMeq0E4dD0bU0TpAqxnIo
	 GUjU10EXVifWBxcYQpwpxn9cbI5HJnRnI9J2frZYVk+ASZzwg2VesU9pUnV5TFHV4y
	 fQH+XY+ImqU54sam8KEgTlokxMnTmgtd6s1WuiKDTCRpVATc0CzmzkkanOhusq5hEe
	 HgIgfXCu22ExkDhYUcnnXeXFQNqyCUa3tUdy8OYlNhU1TZD/QyJPjKbLTS5SkYlB/H
	 NJfLr8iIJzurdfTe5nauSoBntSJ5466fSkr6IjhCFg2Ia4sD94QRyLZbYj5g8Md7ak
	 UeIxRf4gvjs/nshltiNraP3JwvqfhI2XsImWo0PMO0EidLQfyN0yLDucMc43xb/i9c
	 YBU0D8ZzsgvfhNwQFe+SfZLw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4CF240E021B;
	Sun, 30 Jun 2024 16:04:54 +0000 (UTC)
Date: Sun, 30 Jun 2024 18:04:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin3.li@intel.com>, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, peterz@infradead.org,
	brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Message-ID: <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <20230112072032.35626-6-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230112072032.35626-6-xin3.li@intel.com>

On Wed, Jan 11, 2023 at 11:20:32PM -0800, Xin Li wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> The LKGS instruction atomically loads a segment descriptor into the
> %gs descriptor registers, *except* that %gs.base is unchanged, and the
> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
> what we want this function to do.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
> 
> Changes since v5:
> * Remove reviewers' SOBs (Borislav Petkov).
> 
> Changes since v4:
> * Clear the LKGS feature from Xen PV guests (Juergen Gross).
> 
> Changes since v3:
> * We want less ASM not more, thus keep local_irq_{save,restore}() inside
>   native_load_gs_index() (Thomas Gleixner).
> * For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
>   native_lkgs (Thomas Gleixner).
> 
> Changes since v2:
> * Mark DI as input and output (+D) as in v1, since the exception handler
>   modifies it (Brian Gerst).
> 
> Changes since v1:
> * Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
>   section (Peter Zijlstra).
> * Add a comment that states the LKGS_DI macro will be replaced with "lkgs %di"
>   once the binutils support the LKGS instruction (Peter Zijlstra).
> ---
>  arch/x86/include/asm/gsseg.h | 33 +++++++++++++++++++++++++++++----
>  arch/x86/kernel/cpu/common.c |  1 +
>  arch/x86/xen/enlighten_pv.c  |  1 +
>  3 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
> index d15577c39e8d..ab6a595cea70 100644
> --- a/arch/x86/include/asm/gsseg.h
> +++ b/arch/x86/include/asm/gsseg.h
> @@ -14,17 +14,42 @@
>  
>  extern asmlinkage void asm_load_gs_index(u16 selector);
>  
> +/* Replace with "lkgs %di" once binutils support LKGS instruction */
> +#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)

Right, so this is %di only and not %edi.

FRED spec says:

"LKGS takes a single 16-bit operand (in a register or memory) and uses it to
load a descriptor from the GDT or an LDT."

However, latest objdump (GNU objdump (GNU Binutils) 2.42.50.20240630) says

ffffffff81026dfb:       f2 0f 00 f7             lkgs   %edi

objdump needs fixing, I'd say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

