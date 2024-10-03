Return-Path: <linux-kernel+bounces-348705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEB98EAC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA4A28111D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827F126C12;
	Thu,  3 Oct 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjYs0AXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7E3FB8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941781; cv=none; b=s2PJwkPqjVktaSXGKJhG89beOW+QwII5qaA/3baAsHzgY8JZzve6/aXhrSr/9Qc/yyM+en/GLIAsxSeuxM9yu9nJS8tfQYcFiV4Kv6PhrpGkKykuL9ajfhuOyjbBcKPM8pg7Twc3E9knLlF3TghFKuX4h5t3F2aX62C+yvYl5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941781; c=relaxed/simple;
	bh=yu4joNxxij+x73k0WwKAxvDISM4T5p850fyYwpav++4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCM6JnEXBqxzsU3+7jLY5n1SXZ9LAdjbYTRprMDw4qB9B2Wtou/z4KZuXJssIxIBPWEKm6POoug1EBSsLZoyum6+UPP0kXeTcWVrvKzaJLShdTLh4WkLKp8ezQY7hSgvZJv6D4SnbTD/zIsPgDt/p4wieF3vfdyeAv84Mpz+qkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjYs0AXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9674BC4CECF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941780;
	bh=yu4joNxxij+x73k0WwKAxvDISM4T5p850fyYwpav++4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fjYs0AXRSvWlXr2IjUqQ/1UEpgpem8B9QrJ55pn14FdJ56ZLB3rLwdpOJNQbGF3NM
	 +FCkiVm4KP/Y66Tfv9t7CKOxUYzUf0i100UCLluVlhxMGdyKbGuv2UvQwIKeVQ4zeT
	 LvzYzmHtkogxStHuj7HeKkNTimpZriH2b91nZdjLdun35S9zAMA0QFEA648Y42w5XI
	 Gi8fFi6HfsEbe3UyJcXp5VW+dBNgdleEVfjAjZ0vcGxg1fbHhnkeItuovQEEE5NhIJ
	 A9BDYlI+5LYP473dOyX515wOmtdCYf6hJM7s3mvWs1p0CCdviiBNSrSimfFj+AiKqm
	 f4k30a3YftZkw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539973829e7so614218e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:49:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+5bz/IVonpmQQbuLtBBDTXL02gWi8o/Q81WNhnqSp8ZDsb2pqUYVYUa54ogKv/tk1RbAuP5p+CtmcrPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCX1GNuKzV6GqL24ZNdjnAWYOxDNa/VAvB6hJsahpncWRNUcN
	WT2AkdhgxgwvwUbj1Bli4ltk3iMYJJ3VllqxDnYaXnsGHq9W+HjEONFIToB6SFLNksY/rHDSX8y
	fb2JttN3zBBqncw1MZTUzTw5N5CI=
X-Google-Smtp-Source: AGHT+IEw8Jb3DYde7tTTH0EDL2FHH23Q+KikOyGqs+EeivRg1nzyPqHOZjkWB2etxXHjfVdM727/d04HH16W7zzq0K4=
X-Received: by 2002:a05:6512:10cd:b0:536:568f:c5ed with SMTP id
 2adb3069b0e04-539a06586f7mr3268615e87.1.1727941778877; Thu, 03 Oct 2024
 00:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com> <20240930071513.909462-11-ardb+git@google.com>
 <b2b23136-fd57-4bc8-bb80-604cc4da0920@amd.com>
In-Reply-To: <b2b23136-fd57-4bc8-bb80-604cc4da0920@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 3 Oct 2024 09:49:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_61S92_tUYbn-RMm4xOUe0MUUp3+Mxzc7=9Y9VKxr1w@mail.gmail.com>
Message-ID: <CAMj1kXF_61S92_tUYbn-RMm4xOUe0MUUp3+Mxzc7=9Y9VKxr1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 23:25, Jason Andryuk <jason.andryuk@amd.com> wrote:
>
> On 2024-09-30 03:15, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Xen puts virtual and physical addresses into ELF notes that are treated
> > by the linker as relocatable by default. Doing so is not only pointless,
> > given that the ELF notes are only intended for consumption by Xen before
> > the kernel boots. It is also a KASLR leak, given that the kernel's ELF
> > notes are exposed via the world readable /sys/kernel/notes.
> >
> > So emit these constants in a way that prevents the linker from marking
> > them as relocatable. This involves place-relative relocations (which
> > subtract their own virtual address from the symbol value) and linker
> > provided absolute symbols that add the address of the place to the
> > desired value.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Tested-by: Jason Andryuk <jason.andryuk@amd.com>
>
> The generated values look ok.
>
> > ---
> >   arch/x86/kernel/vmlinux.lds.S | 13 +++++++++++++
> >   arch/x86/platform/pvh/head.S  |  6 +++---
> >   arch/x86/tools/relocs.c       |  1 +
> >   arch/x86/xen/xen-head.S       |  6 ++++--
> >   4 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 6726be89b7a6..2b7c8c14c6fd 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -527,3 +527,16 @@ INIT_PER_CPU(irq_stack_backing_store);
> >   #endif
> >
> >   #endif /* CONFIG_X86_64 */
> > +
> > +#ifdef CONFIG_XEN
> > +#ifdef CONFIG_XEN_PV
> > +xen_elfnote_entry_offset =
> > +     ABSOLUTE(xen_elfnote_entry) + ABSOLUTE(startup_xen);
> > +#endif
> > +xen_elfnote_hypercall_page_offset =
> > +     ABSOLUTE(xen_elfnote_hypercall_page) + ABSOLUTE(hypercall_page);
> > +#endif
> > +#ifdef CONFIG_PVH
> > +xen_elfnote_phys32_entry_offset =
> > +     ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
> > +#endif
>
> It seems to me, these aren't really offsets, but instead an address + value.
>

Indeed. So xen_elfnote_phys32_entry_value would probably be a better name.

> > diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> > index 7ca51a4da217..2b0d887e0872 100644
> > --- a/arch/x86/platform/pvh/head.S
> > +++ b/arch/x86/platform/pvh/head.S
>
> > @@ -300,5 +300,5 @@ SYM_DATA_END(pvh_level2_kernel_pgt)
> >                    .long KERNEL_IMAGE_SIZE - 1)
> >   #endif
> >
> > -     ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
> > -                  _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
> > +     ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .global xen_elfnote_phys32_entry;
> > +             xen_elfnote_phys32_entry: _ASM_PTR xen_elfnote_phys32_entry_offset - .)
>
> So here you have `address + value - address` to put the desired value in
> the elf note?
>

Exactly. The assembler emits a relative relocation, and the linker
resolves it at build time.

