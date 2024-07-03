Return-Path: <linux-kernel+bounces-239829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158779265D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B6CB2079A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F20181CEB;
	Wed,  3 Jul 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjC3hL3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6955180A86
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023531; cv=none; b=DGoqTYcGCSdHPImkvS2xHbxqXbzRImEOs4NFfA3ZfdSugYtPHI0/UaMHOio/YZfNaNKlW+4/g/zsYN0OarsE1jBJjFFnVLrnhbqmUvSMerO+8KXTSITj8orazl+rRMeLYzjr/96vFLHXuGqotIZVYvq2EJ428UjAt5PT7XtduF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023531; c=relaxed/simple;
	bh=wDY4dzUjuFNgWvrWu9xz/YezEpR2SIY2gTCh/9kkw7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fISx2Qasup+9/fVAS9Lr2+f31CjTwr1KpLqoKWZ1QuupPqa/YZMR4IszuBE9ICR+7pIO6VIKG1tjgqpOqDJh0ByIYB6j+4zPBtS1tC2dwi74naXjFPa5pTzgYXgZ1K1KSHlLadfQm/u80Rxn7pAvtwlQ1xMc8kkEQw98mdau5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjC3hL3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C8C4AF17
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023531;
	bh=wDY4dzUjuFNgWvrWu9xz/YezEpR2SIY2gTCh/9kkw7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bjC3hL3HGssDk9BZUfPBx7h8XsqbPX4A2RNcUJi9/KKuhBl/2+8SeUuoXifO3mje7
	 HIvZk8z/NNEbZ5fOtGBm0jqmWPn51qsK3UFBp+o8cxIUKZx3gomf6DzRmI3CbOdWUG
	 AicM0Ku6h7wOzR6zQJrHXOs5iahWBaF3T+aGdippWQ72B1mt/JNmZgLJ/uyl9DE+aB
	 pO8Z5UBqOgbvFR6kz2AeZgm0Welq66ff0N+EpU5ZJA4i5jtS/hyz/bT/2KQAwlGdEc
	 r9wLeN/W0D8pyzz8ibpNwPJ1MNRETI72xWn68t4i8vi5WxRGq5AzGnddVIS6p6gfCx
	 CGFZIVWrdudDg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee8911b451so5756471fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlCcOodBsN7RjVnteOFshRuH427cfkJW/Coqd5vfw0fkq4vJbhSPoxBB1r1OB0QvDG5sk4XdY8dSNjbg/A9aO8slDev6gI3WcryxIS
X-Gm-Message-State: AOJu0YyQkBnqUn1cU9OO7v4dnvz8IiB1NbHNmjzf6XNLUx058k3k/M+U
	sEmFYpwkUUncPQc9SDiq4YOEiFjsykvOSIOgccrvX06Wrc7eSc37baWbX6tIce0lL4/JGEaBEYN
	vq/YbRw/K9UvXaYSX5A8Tn5JqTE8=
X-Google-Smtp-Source: AGHT+IGbQWkBsxv/alxBDjjzj7+cn+FOi1M+Hvwzus9EGhPfpAoHhOCTvKhYIeUStBIozycnF22T8PwdtW59EawNXAg=
X-Received: by 2002:a05:651c:b21:b0:2ee:4ab4:f752 with SMTP id
 38308e7fff4ca-2ee5e6cd8d4mr86825091fa.49.1720023529217; Wed, 03 Jul 2024
 09:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520183633.1457687-1-steve.wahl@hpe.com> <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com> <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com> <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com> <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local> <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
In-Reply-To: <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Jul 2024 18:18:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGjHFarKyeT8jyan=pX58CeLisOqSnU_0V+2j04RC00Rg@mail.gmail.com>
Message-ID: <CAMj1kXGjHFarKyeT8jyan=pX58CeLisOqSnU_0V+2j04RC00Rg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>, 
	Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 18:15, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 02, 2024 at 08:32:22PM +0200, Ard Biesheuvel wrote:
> > For kexec on a 64-bit system, I would expect the high-level support
> > code to be capable of simply mapping all of DRAM 1:1, rather than
> > playing these games with #PF handlers and on-demand mapping.
>
> Yeah, apparently we can't do that on SGI, as Steve said.
>
> I like the aspect that the #PF handler won't fire in the first kernel because
> of EFI mapping all RAM. That's good.
>

It won't fire because the code where this handler is being added is
never even called by EFI boot - it decompresses the kernel from the
EFI stub and jumps straight to its entrypoint.


> So we could try to wire in a #PF handler in stage1, see below.
>

Looks fine to me from EFI boot pov, for the reasons given above.

> Steve, I don't have a good idea how to test that. Maybe some of those
> reporters you were talking about, would be willing to...
>
> ---
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index d100284bbef4..a258587c8949 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -32,6 +32,7 @@ void load_stage1_idt(void)
>  {
>         boot_idt_desc.address = (unsigned long)boot_idt;
>
> +       set_idt_entry(X86_TRAP_PF, boot_page_fault);
>
>         if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
>                 set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

