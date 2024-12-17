Return-Path: <linux-kernel+bounces-448944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0519F4771
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ADF16F261
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2811DED7C;
	Tue, 17 Dec 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pynkI9iy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212A1DE8B9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427570; cv=none; b=aAw3G2M2hWsBxy/SmV97cZVyc7ULk8nywIJ3IdaZ8CeOwM8wOhDQot7E0gwZzZlqaI8SeISY6t1rZVH/zW4t88wPLbGqKDsOgCds2YoZW64XwueWHKNuliVbc6OZOfVfBLq6zbOk1n5mAyYoeZu3eWh4OXf/Dji7mDFIX4eocHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427570; c=relaxed/simple;
	bh=hKswbEz7JLeoG28GBCgAedfWMWOBDtGpXbc8u/HHjmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU3P8jInPVgj+OPlkWODg56KJS4xTW8Nz1Tsmbv4drlB8furmiGilD2ghh+i1T2eexLCY9I6K7kPreobh5TyK1ty0ZPPfLssk5b/RATtY62uNwGFxqppZzvTeeK5aBWOSmTkitsxREX8LOxM3jGdQ00e1oofWpoQtsoGxMMrFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pynkI9iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7006C4CEEF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734427569;
	bh=hKswbEz7JLeoG28GBCgAedfWMWOBDtGpXbc8u/HHjmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pynkI9iynxvlvConQ/LuLtEUolJVp+hs+KxeHhg3Km+tXwbEEyTGaT4IlhuPrQu9B
	 X0TF+Fi3DD3IOy5DOIs6tXVY6i6S73DWFccUdg9m2uojo/besO1dGspGAkFDvxt44Q
	 qlQ9mCnvpggFjeP0VqAFe1v785BEyv9Bunc8Ywy0tIe1XSU4rgSyGg+nrcGHGjFW/Q
	 1nr1LPw0OWFKbgNBLtOLWtn9kee80FrEck8E51TOI//fhFfGQDjQ8jplvvoeGTK9y2
	 y5f6mn9QA7RBMxIOrhO39FYHU3+m/Eszf1ijQ6den1z8z24NuOU6RGDKhoBzTWH2TG
	 O8h1obyjnfDXg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-303489e8775so28960051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:26:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv5RDj98MB1h1QMCAYg3nEgDfr78c9/tSc+IodNMjEsG0XR4uFThNaFyr+uQm6m2GF6STxCeSPYn/HOQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVBAzl/KcU5o6VzUk0T8A5FpEqPJCjEUTIa6t9oJI85Hjnup3
	2NlVQbHgXWHwWdjMNHgu/7HXJqFgewSJlHc/QOHQ3awDLNOdFMZa7kMie1iMrsBjz8K5IHLfvVq
	NbLj6Q7H/8rrb3WRRnEuJ+adeSTY=
X-Google-Smtp-Source: AGHT+IFOqeeegh7YGEN2Cczxvmja0BUcnOwexSzSaJ6JZOxd8rnph2QoXJWaeSHjouivuwLQJdaBHcf90soMs+eA3bY=
X-Received: by 2002:a05:651c:1508:b0:302:210d:3b5a with SMTP id
 38308e7fff4ca-302545b8eadmr56445501fa.39.1734427567726; Tue, 17 Dec 2024
 01:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
 <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com> <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
In-Reply-To: <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 10:25:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
Message-ID: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
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

On Tue, 17 Dec 2024 at 10:17, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrote:
> >>
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> A few places in the kexec control code page make the assumption that the
> >> first instruction of relocate_kernel is at the very start of the page.
> >>
> >> To allow for Clang CFI information to be added to relocate_kernel(), as
> >> well as the general principle of removing unwarranted assumptions, fix
> >> them to use the external __relocate_kernel_start symbol that the linker
> >> adds. This means using a separate addq and subq for calculating offsets,
> >> as the assembler can no longer calculate the delta directly for itself
> >> and relocations aren't that versatile.
> >>
> >
> >You can still avoid the absolute relocations though, ...
> ...
> >> +       addq    $identity_mapped, %rsi
> >> +       subq    $__relocate_kernel_start, %rsi
> >
> >... if you turn this into
> >
> >0:     addq    $identity_mapped - 0b, %rsi
> >       subq    $__relocate_kernel_start - 0b, %rsi
>
> Is there any benefit to doing so? Are absolute relocations problematic?

Every absolute relocation produces an entry in the relocation table
that needs to be applied at every boot when KASLR is in effect. Beyond
that, it doesn't matter.

I've looked into PIC codegen/PIE linking for the core kernel, which is
why this caught my eye. If that effort ever advances, I'll need to
revisit this code as well and apply the change I suggested.

