Return-Path: <linux-kernel+bounces-448948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A687E9F477E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCF6161A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064B21DDA35;
	Tue, 17 Dec 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="demC7ZDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57640EEB2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427774; cv=none; b=B6iVMLMwXRm8bO94Zpdel0RN3VfdEkukUXmIfTMogUZQBdS2P07tM7J/3Kajwg9dG7ltB7D/fI0Csr2ZUU/NRv5mOvigibYXBDvtxXI/SEhkWR73FZnMRqQzH7Q4zYaHQlnMP2caoSnoB5P2hY7nrY4LP6lY7Ww7X+32ij/zUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427774; c=relaxed/simple;
	bh=/JXGSjeuFwORUWi/GcIJoWS9cDLwv2BhC9G+AZ7MvpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utOSqp/SEesVqiV4+dgBDR+A13b3QXD34EsMb0nKlqIgNkDZheGaHfzCFbD8UUVzaqlWjCf8HjeYxAUfPJlS8R1CGW42RaWAseTraey/T0C1+rBZNkfZn/xQd7iDSmwo2vB16BcdlE6E5TJHIQOBbKoPfDXhi8wFiknZk5LaddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=demC7ZDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE492C4CEE1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734427774;
	bh=/JXGSjeuFwORUWi/GcIJoWS9cDLwv2BhC9G+AZ7MvpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=demC7ZDJn15wSuIoAGNY8DtLEbT1B2vJvIQ+CV/+RhcnwptyTnMQMjUVNxNf181ZP
	 Tmyf5SOfmkUfnAJNFdRXSgYB2Q6BJUpQMwe4fKA0QeRrp6zcVqJGm4MUzk5AcgGE3Q
	 t181E/v0H65/JHYXS4BJbzwm6Ry/6VSGdVtR4auUUu3teRxVhCoy9MO9H57W+F4ZXw
	 h5/lz510keOOk1UaWV1rcTF3Agr6n+pFHqj6M+yKSF3wrwgHF06rkOjbbmZtKZTZeZ
	 WB5mu4XONbSgUO/CMK2FY6r2TAZwR7VibH0ujkZK4UNq4PX5q8o3L2SsoBbXHkanvq
	 E5BzMNSM+fC2g==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30229d5b21cso45107101fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWakIIaYrux87Y2ifxoKHsxAtZ1H/ebSF4oQc6PLkgJlq0+Ye+z2P5qSTRX0Yy6OSJqWU8VhbhQr3L2zlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rlwEuKWjGvdw193iwtjGq3eYTzcQPdgcPAUh26XAHp3lSNJt
	dpgOnVM1NWlSKITWMDCnXto/MUUImfE9vo2TXDOJEc7dTw7aEi3XLEm64vlmBhOxrxK9cUHoDrE
	nv/9VbJBLThPxNab9Vr8YJJvTvDc=
X-Google-Smtp-Source: AGHT+IGOH5xXs/+jrxW1Uzgqvgm0yh2wLN2TclacuxMVFx8bCIsWqUKBZFrn5vEMXVVRDkoO62PL6n0VVePgSX65jPA=
X-Received: by 2002:a05:6512:158e:b0:53e:3740:4a86 with SMTP id
 2adb3069b0e04-5409055551emr5018316e87.18.1734427772258; Tue, 17 Dec 2024
 01:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
 <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com> <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org>
In-Reply-To: <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 10:29:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
Message-ID: <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 10:21, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 09:49:04 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> >>
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> Both i386 and x86_64 now copy the relocate_kernel function into the co=
ntrol
> >> page and execute it from there, using an open-coded function pointer.
> >>
> >> Use a typedef for it instead.
> >>
> >> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >> ---
> >>  arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
> >>  arch/x86/kernel/machine_kexec_32.c |  7 +------
> >>  arch/x86/kernel/machine_kexec_64.c |  6 +-----
> >>  3 files changed, 15 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec=
.h
> >> index 48e4f44f794f..8ad187462b68 100644
> >> --- a/arch/x86/include/asm/kexec.h
> >> +++ b/arch/x86/include/asm/kexec.h
> >> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_re=
gs *newregs,
> >>  }
> >>
> >>  #ifdef CONFIG_X86_32
> >> -asmlinkage unsigned long
> >> -relocate_kernel(unsigned long indirection_page,
> >> -               unsigned long control_page,
> >> -               unsigned long start_address,
> >> -               unsigned int has_pae,
> >> -               unsigned int preserve_context);
> >> +typedef asmlinkage unsigned long
> >> +relocate_kernel_fn(unsigned long indirection_page,
> >> +                  unsigned long control_page,
> >> +                  unsigned long start_address,
> >> +                  unsigned int has_pae,
> >> +                  unsigned int preserve_context);
> >
> >linkage is not part of the type. 'asmlinkage' is #define'd to the
> >empty string today, so it doesn't matter, but better to omit it here.
>
> This is the i386 version. I thought ut was something like regparm(3) ther=
e?
>
> And... WTF? How is the calling convention not part of the fundamental typ=
e of the function? If I have a pointer to such a function, using this typed=
ef to ensure we all share the same prototype, are you telling me all the us=
ers of the typedef have to remember to tag that part on for themselves?

No. I am talking about linkage not the calling convention.

Look at how __efiapi is used in the kernel if you would like to
understand the difference.

