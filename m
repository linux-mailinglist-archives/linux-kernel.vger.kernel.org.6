Return-Path: <linux-kernel+bounces-523383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE828A3D5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C217D915
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930F1EF0BA;
	Thu, 20 Feb 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzDDrVi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D291D7984
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045921; cv=none; b=kgt9lOObprUeWmwJU/Qef2ouRfoXbIIyYgKotBGb1elxILfgU+mG3tf+8j1KJMDAooYgl2w1sMjELUQ36WFfzar9ludoLdPHPKwlO5Dht3aH6tY1sJ9Bj6Ji4JmKW4/N0GCaoo6KUJPbXnrC8231TAk4tA3rhgmyCrRJxOMcnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045921; c=relaxed/simple;
	bh=CE+V32MY4vBJ5kjiVOFSL8fOB5wliORbUOlFMhOdpMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqHB41U68a2TbPh8MiXKtmq/3fClNcJoSOU6Psnmo65mmWfqk7eBF9OjvO/P8wfSZiP++blC++t5RlGYd9Q1d08Z20Rlkc5NCIyx7H5KPwMT12So1CoIPxxPkNqHB34n0TCvB9wvXqUlrInbpv5rF9C27WbRmk4rj9MLuNR8USU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzDDrVi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F7C4CED1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740045921;
	bh=CE+V32MY4vBJ5kjiVOFSL8fOB5wliORbUOlFMhOdpMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LzDDrVi/orjG73ipwuDG99Ayvomkqs5AuodPTC9yIJ1D3zD50aW4+5Ht91eG1PegP
	 J3nzesbDBKt3wceRWCZIA1aQyBF+Y9y2/3BM7bArCx69o9H4BTtTz8bgCjfaAfXj/r
	 RKcGgUNCsPK25P5GejN0wQJfkPnXUj2A+UcjA8UFUFvx3Tmjj9yuwLMD3On8iJjwdX
	 4SgPkJ3ubi6JcNMDvPZr2OLtsQfQ1y2X7L/3H2KIc2xHn4QrTgCSiUxBfsR2Zi8LVp
	 x1EEqWES1jBws5kOsksSeGh6YGxKsbAmbnEER/APyIxqr2m1/VXPOjgzZ91sAx8Mma
	 yQ4RmoMH8innw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so827289e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4BJmDLQo+kPuc7skQNFiLkMw3u7b59ITSIc3XD055JfRf/y6cKW4NcAGv72eNFWKGoXbkQWq3c8L/0O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzjChKmj591Hw4fXffmqOa4u78RZYWa69vHqoI1fGZTYzjdxr
	y6RAkAL/gL+FhP9okSxJZ6jjDt8oAB5Dfyi0S6MCLi6vqBEwzzZ1UQaIENuuIZ5TJJTFugCypGV
	lXPKGt0RHCZ8A2zEzdA1ow0PHLgw=
X-Google-Smtp-Source: AGHT+IFAn+LlTzJofno+coIG80u6XAPwYUKiygJgn60nT5ODAyPZMo57R8B0bxq16tr1bCSWs/hpzh6/XJJ9/4tU1W4=
X-Received: by 2002:a05:6512:3055:b0:545:2e90:8dd7 with SMTP id
 2adb3069b0e04-5452fe72fcbmr6938167e87.45.1740045918974; Thu, 20 Feb 2025
 02:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
In-Reply-To: <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 11:05:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
X-Gm-Features: AWEUYZlDte4lKIC3KelG7lF3Ol82Em8MP-u5OatJryYDCS94Q_HXdecjy2kkFB0
Message-ID: <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uros,

On Thu, 20 Feb 2025 at 10:51, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Wed, Feb 19, 2025 at 2:18=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > > Thank you for doing this series - it all looks pretty good from m=
y
> > > > > side and I've applied it experimentally to tip:x86/asm. I fixed u=
p
> > > > > the trivial details other reviewers and me noticed.
> > > > >
> > > > > Note that the merge is tentative, it might still need a rebase if
> > > > > some fundamental problem comes up - but let's see how testing goe=
s
> > > > > in -next.
> > > >
> > > > I wonder if there would be any benefit if stack canary is put into
> > > > struct pcpu_hot?
> > >
> > > It should definitely be one of the hottest data structures on x86, so
> > > moving it there makes sense even if it cannot be measured explicitly.
> > >
> >
> > It would have to be done with linker tricks, since you can't make the
> > compiler use a struct member directly.
>
> Something like the attached patch?
>

Interesting take. I'd have tried to put the canary at offset 0x0, and
simply use pcpu_hot as the guard symbol.


> It boots and runs without problems.
>
> However, when building the kernel, I get "Absolute relocations
> present" warning with thousands of locations:
>
>   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
> WARNING: Absolute relocations present
> Offset     Info     Type     Sym.Value Sym.Name
> ffffffff81200826 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
> ffffffff81201493 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
> ffffffff81201714 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
> ffffffff81201d66 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
> ...
> ffffffff834e2a13 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
> ffffffff834e2a6a 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> __ref_stack_chk_guard
>
>   RSTRIP  vmlinux
>
> which I don't understand. Looking at the first one:
>
> ffffffff8120081d <force_ibs_eilvt_setup.cold>:
> ffffffff8120081d:    48 8b 44 24 08           mov    0x8(%rsp),%rax
> ffffffff81200822:    65 48 2b 05 f6 ed 30     sub
> %gs:0x230edf6(%rip),%rax        # ffffffff8350f620
> <__ref_stack_chk_guard>
> ffffffff81200829:    02
>
> I don't think this is absolute relocation, see (%rip).
>

The warning is about the type of __ref_stack_chk_guard, not about the
type of the relocation.

$ nm vmlinux |grep \\s__ref_sta
ffffffff8350c620 A __ref_stack_chk_guard

Without your patch:

$ nm vmlinux |grep \\s__ref_sta
ffffffff834fba10 D __ref_stack_chk_guard

