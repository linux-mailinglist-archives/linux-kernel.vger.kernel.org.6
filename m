Return-Path: <linux-kernel+bounces-448857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91E9F4679
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0601C16E74A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA81DE3AA;
	Tue, 17 Dec 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRbvok7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175831DD87D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425359; cv=none; b=RxB6Bt1PlgyTKLzceviAg4GlGZp3TJWL53bGU7cW/VUlhlMvvxahFcltYTXql/1QmHjik/vL4moobSXQfwhAIA6lFoB6pvKor+4CmvfOyB0HJ2hK6mTzvxY/4X50WQ0aUZfTmrNbpP527ZPhrpTtd0cuGprbDiWp+fjYGwspYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425359; c=relaxed/simple;
	bh=EErrP47AKhS8f7AjLXgBxHV+WLf76MKb91A85DuCJKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCXrkw3lLwKy4eZUKWBwbJqQ61gRIxrpUzyTn6dAKFfWqBELgW1ijR+sPjlocx4bI92YaSz645Scb4VyFIPcrXNkHjsU3ZeQI4vRR6huT9Gu35rJWnLcXhUUgpeX5IrO+MQiZTB9NN1u+HURgDuES8LELsMDpMzYJ6pwy6urEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRbvok7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D59C4CEE6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425357;
	bh=EErrP47AKhS8f7AjLXgBxHV+WLf76MKb91A85DuCJKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fRbvok7ySXjY/TJUtvxiwAW5Du3n4qSs8LjFfMzbcaK+91jsrT8vl+Au8vM36KrK5
	 KAatRxwRWkN9qQKo03zyrunjAncvP2K7dx8bGgInLEXX/Ptp69nrEnUK5L7TJH7QYU
	 HcQIFdgQnSHg2wxSv5jYJ/cFEYHg6Ae++6hWlGo3WeKWakSOkVgzlwkkOTv9aJT4pR
	 PM/T1XqO1jbetJXTShwm89ooNXjsn12zX3tAJWXLqxeUmnLn5czEB4sDpwmSi+7/Ae
	 +KR0Y4MdIYktuZpgdTfpoAOP9AYDS9SJXUyea6TcpZFHhz1VV/5iIBJ7d/Wfczgnpa
	 4d35zz5Rbk80A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30033e07ef3so56489021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZpSkaYZ27S+hFnt93/q/fcuScFp8r+M8MChJXAspWc/euR7sYDnONxZIhRbH3Pwc44lK31lnosZtSs6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEdou1mPlDHjIrNkdLsH8H+BEi+YeQiBKNbQ67S2Ag4v35nL5
	wfRcD2xuTTbq3O/b4M3x8EMGghkXJwcQfsQq1LtgLWwNefSYW8iKQktbcsMNMnytwRNhLvhmuXd
	z3WfGykR8goENlgg2siEc80OhoA8=
X-Google-Smtp-Source: AGHT+IFnAnJtxYtjTtahPb7C+dKFRSW0ndAI5UXpgRjmr+JoD9B+dlO+0+pXgTe1pqCX7ONfgosejeansQpwgUUl6PU=
X-Received: by 2002:a05:651c:508:b0:2ff:df01:2b4c with SMTP id
 38308e7fff4ca-304442d51ecmr8228111fa.4.1734425355877; Tue, 17 Dec 2024
 00:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
In-Reply-To: <20241216233704.3208607-10-dwmw2@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 09:49:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
Message-ID: <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
Subject: Re: [PATCH 9/9] x86/kexec: Use typedef for relocate_kernel_fn
 function prototype
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
> Both i386 and x86_64 now copy the relocate_kernel function into the control
> page and execute it from there, using an open-coded function pointer.
>
> Use a typedef for it instead.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
>  arch/x86/kernel/machine_kexec_32.c |  7 +------
>  arch/x86/kernel/machine_kexec_64.c |  6 +-----
>  3 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 48e4f44f794f..8ad187462b68 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
>  }
>
>  #ifdef CONFIG_X86_32
> -asmlinkage unsigned long
> -relocate_kernel(unsigned long indirection_page,
> -               unsigned long control_page,
> -               unsigned long start_address,
> -               unsigned int has_pae,
> -               unsigned int preserve_context);
> +typedef asmlinkage unsigned long
> +relocate_kernel_fn(unsigned long indirection_page,
> +                  unsigned long control_page,
> +                  unsigned long start_address,
> +                  unsigned int has_pae,
> +                  unsigned int preserve_context);

linkage is not part of the type. 'asmlinkage' is #define'd to the
empty string today, so it doesn't matter, but better to omit it here.

>  #else
> -unsigned long
> -relocate_kernel(unsigned long indirection_page,
> -               unsigned long pa_control_page,
> -               unsigned long start_address,
> -               unsigned int preserve_context,
> -               unsigned int host_mem_enc_active);
> +typedef unsigned long
> +relocate_kernel_fn(unsigned long indirection_page,
> +                  unsigned long pa_control_page,
> +                  unsigned long start_address,
> +                  unsigned int preserve_context,
> +                  unsigned int host_mem_enc_active);
>  #endif
> -
> +extern relocate_kernel_fn relocate_kernel;
>  #define ARCH_HAS_KIMAGE_ARCH
>
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 1b373d79cedc..80265162aeff 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -160,15 +160,10 @@ void machine_kexec_cleanup(struct kimage *image)
>   */
>  void machine_kexec(struct kimage *image)
>  {
> +       relocate_kernel_fn *relocate_kernel_ptr;
>         unsigned long page_list[PAGES_NR];
>         void *control_page;
>         int save_ftrace_enabled;
> -       asmlinkage unsigned long
> -               (*relocate_kernel_ptr)(unsigned long indirection_page,
> -                                      unsigned long control_page,
> -                                      unsigned long start_address,
> -                                      unsigned int has_pae,
> -                                      unsigned int preserve_context);
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (image->preserve_context)
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1440f792a86d..dd75a51463a2 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -344,12 +344,8 @@ void machine_kexec_cleanup(struct kimage *image)
>   */
>  void __nocfi machine_kexec(struct kimage *image)
>  {
> -       unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
> -                                            unsigned long pa_control_page,
> -                                            unsigned long start_address,
> -                                            unsigned int preserve_context,
> -                                            unsigned int host_mem_enc_active);
>         unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
> +       relocate_kernel_fn *relocate_kernel_ptr;
>         unsigned int host_mem_enc_active;
>         int save_ftrace_enabled;
>         void *control_page;
> --
> 2.47.0
>

