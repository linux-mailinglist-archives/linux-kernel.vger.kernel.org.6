Return-Path: <linux-kernel+bounces-448849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628439F466E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8CE16BBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CFF1D63D9;
	Tue, 17 Dec 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azXC3+u2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917215E5C2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425270; cv=none; b=crpMNMI5GM2tgZO+063VGeRdGMBLjhcG1uTagdDtCtncdmteQ43CuACN9pmcAes8VIeFdI2eZDfz4zvKUuUDNVtjnU41BytWKAO69fOFtDiSHUr1nl2DYzxxhR+WfCshsMtwP35tRMOwoLi3kITN0bfQKCklxLKFMSJ5InItpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425270; c=relaxed/simple;
	bh=Sdc+++6gPgnnOYqx/g7c38oTFPeiaCCYx369j2QdBFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg5Z7z4ANwf3KuUE8YxNQ7fo5QmiTIZdYmmLoIJi6XA7WWL8Z+De+jM7PxPdQoAibSBVdtxXql/enV+7rhHsmW/kuc2pIlrNKRZvpg9YuOAu2M3icZoxgYNJnFirbKUZTC8PQiCNHkIEDlKdyXtFsH++Nun2tOI/6SsCCHguSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azXC3+u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B00DC4CEEF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425270;
	bh=Sdc+++6gPgnnOYqx/g7c38oTFPeiaCCYx369j2QdBFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azXC3+u2f5NvdkscRjFTXQnMMGPWPEtHDih1eG5N5aj/newj4vElyBIFgXG0X0rjw
	 3S+kFzCqHXxDV/1FGMxrjFiDX2YAXRNcadFs6GODbbcxo+cIt3nmX7Te0o1br7YyBi
	 AUts4OwKIm/9nGQOQYbcC5wJmHES3iTzJ4FEOHhkY0s8GU95HuiCjiBpSln3/bIEn6
	 gvmcP06oempOucqpWKfZRLGqoBTxKh+9jYHgow6XTpH6nJRT4vFoYoMjWYlR6Sy+35
	 xU2R9cnuP6PCHi57WsrGscYqWGspzYkYPwzalZAWJHV9Eq7jUsYiq+zfRrZGNJNjdQ
	 1dGTGkvXdK6tw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3002c324e7eso56942681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:47:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmAj1hPrkr5DQOmSw2mPlvzCoaMhdZ9hfA7pDojWoQNtfrga3uSVocgApDXS4KJpsDVElzlW0H3qo5uHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/OK2joaPoCTah19YfAMZauhL6ZCpeeXJJn5PV1gQJXQl1GjM
	c07D5EVx+4hshBbE5uMRlbEGWc7bornN5JzdoO1c31eHqTDakDISqpUak13oQ5bg3h7JwrEIWWO
	DGop3wZW8JvMyf2doS+fXsM6e4lE=
X-Google-Smtp-Source: AGHT+IH5eLSLKUNPUxwrLLug55kMDEvGO8iTkt7KKa2ptm7n109+n2f50khrbdJ3Mnh6LumZiUhvLgKXYRn1UmcY7B4=
X-Received: by 2002:a05:651c:1545:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-3025454ffadmr56056541fa.18.1734425267978; Tue, 17 Dec 2024
 00:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
In-Reply-To: <20241216233704.3208607-9-dwmw2@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 09:47:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
Message-ID: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at
 the start of the page
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, 
	Tao Liu <ltao@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> A few places in the kexec control code page make the assumption that the
> first instruction of relocate_kernel is at the very start of the page.
>
> To allow for Clang CFI information to be added to relocate_kernel(), as
> well as the general principle of removing unwarranted assumptions, fix
> them to use the external __relocate_kernel_start symbol that the linker
> adds. This means using a separate addq and subq for calculating offsets,
> as the assembler can no longer calculate the delta directly for itself
> and relocations aren't that versatile.
>

You can still avoid the absolute relocations though, ...

> Turn the jump from relocate_kernel() to identity_mapped() into a real
> indirect 'jmp *%rsi' too, while touching it. There was no real reason
> for it to be a push+ret in the first place, and adding Clang CFI info
> will also give objtool enough visibility to start complaining 'return
> with modified stack frame' about it.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 1996cea909ff..d74798d78263 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -95,11 +95,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>         lea     PAGE_SIZE(%rsi), %rsp
>
>         /* jump to identity mapped page */
> -       addq    $(identity_mapped - relocate_kernel), %rsi
> -       pushq   %rsi
> -       ANNOTATE_UNRET_SAFE
> -       ret
> -       int3
> +       addq    $identity_mapped, %rsi
> +       subq    $__relocate_kernel_start, %rsi

... if you turn this into

0:     addq    $identity_mapped - 0b, %rsi
       subq    $__relocate_kernel_start - 0b, %rsi


> +       ANNOTATE_RETPOLINE_SAFE
> +       jmp     *%rsi
>  SYM_CODE_END(relocate_kernel)
>
>  SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> @@ -219,16 +218,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>
>         /* get the re-entry point of the peer system */
>         popq    %rbp
> -       leaq    relocate_kernel(%rip), %r8
>         movq    kexec_pa_swap_page(%rip), %r10
>         movq    pa_backup_pages_map(%rip), %rdi
>         movq    kexec_pa_table_page(%rip), %rax
>         movq    %rax, %cr3
> +
> +       /* Find start (and end) of this physical mapping of control page */
> +       leaq    (%rip), %r8
> +       ANNOTATE_NOENDBR
> +       andq    $PAGE_MASK, %r8
>         lea     PAGE_SIZE(%r8), %rsp
>         movq    $1, %r11        /* Ensure preserve_context flag is set */
>         call    swap_pages
>         movq    kexec_va_control_page(%rip), %rax
> -       addq    $(virtual_mapped - relocate_kernel), %rax
> +       addq    $virtual_mapped, %rax
> +       subq    $__relocate_kernel_start, %rax
>         pushq   %rax
>         ANNOTATE_UNRET_SAFE
>         ret
> --
> 2.47.0
>

