Return-Path: <linux-kernel+bounces-449026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6C9F48AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7130D163C88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60001DFE00;
	Tue, 17 Dec 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGa4MHzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8BEEB2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430483; cv=none; b=QPAzjSRNTbqimTF6aPdc7sumFocIrGZ47NQwQE+zNqlxdNd+m30fJrw9x61b2pnbH2vghX8k+PfkC4B7DV3WmP0AZI75ByNkwqHkHG3z8CXnGa4S4EPmexLnrh8llvqgnDQv1ksP8sJOSpQ2qTqyhoCdtNfknh9a+HGQcjnTN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430483; c=relaxed/simple;
	bh=OPL93mBy2j7SD8UGFpfkOUpq//hWhZVwrtDUwkgko/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6+BcesfN0Ih4GlQ2zn03VxdvOZ4jbv88E8az0DkPZu3E4sns/OFJw2J7o70G8NfoUDW9+0jaOn8Cmcu3mYx1r3WDUPSoU5jep/PCvo9o2jw1gfDhbLMsjNeVcD98tCU+1jWVb6w1EZuajgk5h2vUkCEymdVnxBs3Z5892SBl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGa4MHzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64DEC4CEEB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734430482;
	bh=OPL93mBy2j7SD8UGFpfkOUpq//hWhZVwrtDUwkgko/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGa4MHzRtcdbiDw4dpQqmMzG6yLBp417qR8NvoqFAgzP5rGo42qtQXuEM4/pcojyE
	 Qp/EOk6cxKrvcjraZYoBuerX7hxgFXKenl13X1VED04jfCbvTalj1nr9fS0Ks6+AbY
	 JSgh/cFIQ+ND3ocNHwBu+X5DmDhjKQ2V698aA7wGToaV/yt1YCPx7UmM28vhOpgRaX
	 vNLkpi6H4TcPP5GUac9xyN+6SNzbI4AgoPyeyvr0YHDj9BIdGtal7fnkpf22Kj4MSb
	 NhIBVV+SEJ7tGnNFFgjzz6U4lkYOFiKrdnW8XMfoF/5MzJ7/8SqCToDrQExeZLnp5w
	 u21KYLDE88ALA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3778bffdso5333083e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVn7TY5d+lHE5vCKJgVyBWEAyCMuhoufY4mxSvsAX3UJ5meryp6PsznHaJ8KlrLzsrrUzdWqHVHUdUjYbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw222N4bQ6/qQARolrxfvEIA1XctZP8FP0AXrarx/xIGeoug8FA
	T4GTS3W4YrBwjFNxfaV/sribxWwY/w7RwiuNkQIdzI7fMjzj+h0noGVxJz+BR/Rt1J70WGgeQoC
	1sXr/g2XaQR2JVsBjZF3gbv2ia9g=
X-Google-Smtp-Source: AGHT+IEHEqgshx48LpQkxmt7DQQCnQ/7L59ik4neDe+UpvzdB1r/xaAqQ8ldkgLyB+Oub2u9IimT2ZmItOjdapUo0dc=
X-Received: by 2002:a05:6512:39cc:b0:540:2f59:7561 with SMTP id
 2adb3069b0e04-54099b699d2mr5130581e87.50.1734430480882; Tue, 17 Dec 2024
 02:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
 <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
 <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
 <27388506-9BE8-4540-A444-166C49133295@infradead.org> <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
 <111B7BEE-FDA0-4085-8A97-89EC9DE7A51B@infradead.org>
In-Reply-To: <111B7BEE-FDA0-4085-8A97-89EC9DE7A51B@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 11:14:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEURHzq0vmt-18N81QPACN2_53m2EaAOhb+fTc8ppTGVQ@mail.gmail.com>
Message-ID: <CAMj1kXEURHzq0vmt-18N81QPACN2_53m2EaAOhb+fTc8ppTGVQ@mail.gmail.com>
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

On Tue, 17 Dec 2024 at 11:07, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 10:54:19 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 10:42, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> >> Hm, I am perfectly happy to believe that my memory is failing me, espe=
cially when it comes to specifics of i386 assembler code. But are you also =
telling me that
> >> <https://kernelnewbies.org/FAQ/asmlinkage> is a lie?
> >>
> >
> >It seems wildly out of date, at least.
> >
> >Commit 96a388de5dc53a8b2 from 2007 removed the asmlinkage definition
> >containing regparm(0) from include/asm-i386/linkage.h, and I'm not
> >convinced it was ever sound to conflate linkage with calling
> >convention like that. Today, asmlinkage evaluates to 'extern "C"' when
> >using a C++ compiler, which is also not part of the type.
> >
> >However, I failed to notice that this just moves code around, and only
> >applies to 32-bit in the first place. So I won't waste any more of
> >your time obsessing over this.
>
> Too late :)
>
> You've already made me concerned about what the calling convention *is* f=
or relocate_kernel() on i386. Because if asmlinkage doesn't mean regparm(0)=
 any more and the i386 kernel is still built with -mregparm=3D3, then how d=
oes the asm code (which seems to believe all its arguments are on the stack=
) actually work?
>
> It seems slightly unlikely that kexec on i386 has just been broken since =
2007 but I'm not sure I'd completely rule it out.
>
> So now I guess I have to actually build a 32-bit userspace test case and =
*test* it.
>
> And that means I no longer have any excuse for not doing all the same cle=
anups in the i386 version of the code that I've done for x86_64...
>
> Thanks for that :)
>

Actually, asmlinkage still means regparm(0) on i386, so I'm going to
have to apologise again, for my poor git foo this time.

