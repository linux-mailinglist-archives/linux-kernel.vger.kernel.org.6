Return-Path: <linux-kernel+bounces-513767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621CA34E73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155B616BF71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9924A06A;
	Thu, 13 Feb 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hmFSY/V"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75510156237
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474654; cv=none; b=RfEZhUI1wwla5RUwgus6jW6bgFJW0ebGZjl+/KYM6c9mjW28uPOWudzH5vrAqzCpXHs43MmI2VY28knkfirU+q10ZSN/I45/4c9HlNs4rz7SvYym0dNXsIyEmA4G7qHz1jI2trpKSQqHbeiop+fLliIDna5Y7YA+JfXMOhIgvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474654; c=relaxed/simple;
	bh=OXfwl5pm6fsT+D3ye4FMNi5X66v7vV6OhCLBmzkOt2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUquI79MjobEPP3I7wV4L6ISOS0iZdXqEJALUKjBJ4XthOkGUFgLcwqKgYMn1gF+F5jSJ9/61ilfFJFz6kTcOcBig3Ys/79R24yhsjXLXAcIQE5+31VnvqqN+/DEeLI0ZQu30H3T49/6z/rn5s88DtWqrtgvO+Db0PmxOc3noHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hmFSY/V; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5debc731ed5so1192a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739474651; x=1740079451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9hfk310hpC0OcZw2W9H07lECBi97Cqb9jL3NKrXgy4=;
        b=0hmFSY/V8ynXzcWEQzdaU2RR0Q1liKCNpFkjuwWoi6x6kEYI44UykJHT4bRM+YOc9Y
         fyBAE6a5+dX+GoBco8UwaCS40gV2b8FGsuCMGKydFxp8oGOWOcY2PcWeRXlHQLtG5V+2
         e4JMBc0r8kAZqDjoBnN0K2uWx9aTmwoflce9rJfW7oetzBcKyo1I5UzuAalYLrG4ltSP
         /uDNiQwFIJ48Xc7TWklvapjHlii7UhK9nEgFGbEwHt09TTZCBkE2uH7ivaAWYWUIRPD2
         3+bnh97ST5x3CJj8sd/TeLgVfFtoVjvj70phzq2C71LP2g9pGFQrcNmZqXqwDBBgGXUZ
         XGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474651; x=1740079451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9hfk310hpC0OcZw2W9H07lECBi97Cqb9jL3NKrXgy4=;
        b=iqK+xHMdiGxmFH18TVGCWZeycAyKJCyN4CE+HoGhf2pGW9NeMTKl8i4Bwyo2+yQ/C2
         Elx1HOtg7aPeWGZtZ+qoVe2NRF6WzSswAPA2sf71dFic8OauLSAqXQvFZZ15qWAWM900
         XOf006xFUlz03X3LV7onnMGh8WrHtarc9OQwf4Ouu1GO6WrTQwzV43GLC0LNhmDvSnEF
         za6TKE8UrbuTLikS/dNrqJbD3Txgo4wHxeBswPTMgdLgBsIMdop7HTEeg+fqcO+2jG95
         CXV1CMjnu/+3FpVbppx/w69hXfd8WIcfNbgQ0JIr/enHaneBZ5wzO9kQVfHPa3WB2y1z
         2azg==
X-Forwarded-Encrypted: i=1; AJvYcCUzun57dSAHvrqrhV5d/vquJ4Qgb3PtwHo00yaf1k1Knq8mUcjAKlXnlv0NH7gjHAQzJo21wOl6rugUf+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytx6v8DDabFpSQAOmF+A4s0BCUPB6/S+No5nvHRRPaey+8FeoL
	2zd9dgWNVWa4sumyEittJO3VsPTZWNMoAUpM/oQITRvSFuFmQYn2Wc5C+E+Q+TZLLu9+9Yu/3Ko
	bM7IQfRoW24jpFUol1We1afdyaaDxHP2xqi2j
X-Gm-Gg: ASbGncsBtLVB8ng9itlJEQ3I1rSdfTeM0CdHGQdvhcoFCu+f0pVbsiwVROXukjVNcZ+
	BJS8yuRiqDkE+f9yva0HxD7LaZvtcuzh/OKkyRhtW6bmaU+FZhzqkYBmcypyikQ8PUHcuax3mmy
	FMpds0D5j5uuVMNlZRZxNpFcMq
X-Google-Smtp-Source: AGHT+IH5z3eW2IsumZCkKHV5y6ZCOhJCEoe5ygOgaXRLr+aUtmO/YNHIcjGSSskjIwZUj0jp7aVdMljU56fMa/nVNqM=
X-Received: by 2002:a50:cc9d:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5dedd22ca53mr5762a12.1.1739474650173; Thu, 13 Feb 2025 11:24:10
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NwR4w/28Z7XUa@ubun> <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
In-Reply-To: <Z62N6cGmaN+OZfoY@ubun>
From: Jann Horn <jannh@google.com>
Date: Thu, 13 Feb 2025 20:23:34 +0100
X-Gm-Features: AWEUYZk85Gvs1xt5XoPVpD_Z1-wxEq4DVq2DnmezM0J-mRKw8DvqRHc40O50geE
Message-ID: <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>
Cc: Andy Lutomirski <luto@kernel.org>, linux-hardening@vger.kernel.org, kees@kernel.org, 
	joao@overdrivepizza.com, samitolvanen@google.com, 
	kernel list <linux-kernel@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:15=E2=80=AFAM Jennifer Miller <jmill@asu.edu> wro=
te:
> On Wed, Feb 12, 2025 at 11:29:02PM +0100, Jann Horn wrote:
> > +Andy Lutomirski (X86 entry code maintainer)
> >
> > On Wed, Feb 12, 2025 at 10:08=E2=80=AFPM Jennifer Miller <jmill@asu.edu=
> wrote:
> > > As part of a recently accepted paper we demonstrated that syscall
> > > entrypoints can be misused on x86-64 systems to generically bypass
> > > FineIBT/KERNEL_IBT from forwards-edge control flow hijacking. We
> > > communicated this finding to s@k.o before submitting the paper and we=
re
> > > encouraged to bring the issue to hardening after the paper was accept=
ed to
> > > have a discussion on how to address the issue.
> > >
> > > The bypass takes advantage of the architectural requirement of entryp=
oints
> > > to begin with the endbr64 instruction and the ability to control GS_B=
ASE
> > > from userspace via wrgsbase, from to the FSGSBASE extension, in order=
 to
> > > perform a stack pivot to a ROP-chain.
> >
> > Oh, fun, that's a gnarly quirk.
>
> yeag :)
>
> > Since the kernel, as far as I understand, uses FineIBT without
> > backwards control flow protection (in other words, I think we assume
> > that the kernel stack is trusted?), could we build a cheaper
> > check on that basis somehow? For example, maybe we could do something l=
ike:
> >
> > ```
> > endbr64
> > test rsp, rsp
> > js slowpath
> > swapgs
> > ```
> >
> > So we'd have the fast normal case where RSP points to userspace
> > (meaning we can't be coming from the kernel unless our stack has
> > already been pivoted, in which case forward edge protection alone
> > can't help anymore), and the slow case where RSP points to kernel
> > memory - in that case we'd then have to do some slower checks to
> > figure out whether weird userspace is making a syscall with RSP
> > pointing to the kernel, or whether we're coming from hijacked kernel
> > control flow.
>
> I've been tinkering this idea a bit and came with something.
>
> In short, we could have the slowpath branch as you suggested, in the
> slowpath permit the stack switch and preserving of the registers on the
> stack, but then do a sanity check according to the __per_cpu_offset array
> and decide from there whether we should continue executing the entrypoint
> or die/attempt to recover.

One ugly option to avoid the register spilling might be to say
"userspace is not allowed to execute a SYSCALL instruction while RSP
is a kernel address, and if userspace does it anyway, the kernel can
kill the process". Then the slowpath could immediately start using the
GPRs without having to worry about where to save their old values, and
it could read the correct gsbase with the GET_PERCPU_BASE macro. It
would be an ABI change, but one that is probably fairly unlikely to
actually break stuff? But it would require a bit of extra kernel code
on the slowpath, which is kinda annoying...

> Here is some napkin asm for this I wrote for the 64-bit syscall entrypoin=
t,
> I think more or less the same could be done for the other entrypoints.
>
> ```
>     endbr64
>     test rsp, rsp
>     js slowpath
>
>     swapgs
>     ~~fastpath continues~~
>
> ; path taken when rsp was a kernel address
> ; we have no choice really but to switch to the stack from the untrusted
> ; gsbase but after doing so we have to be careful about what we put on th=
e
> ; stack
> slowpath:
>     swapgs
>
> ; swap stacks as normal
>     mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+2=
0>
>     mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24=
>
>
>     ~~normal push and clear GPRs sequence here~~
>
> ; we entered with an rsp in the kernel address range.
> ; we already did swapgs but we don't know if we can trust our gsbase yet.
> ; we should be able to trust the ro_after_init __per_cpu_offset array
> ; though.
>
> ; check that gsbase is the expected value for our current cpu
>     rdtscp
>     mov rax, QWORD PTR [8*ecx-0x7d7be460] <__per_cpu_offset>
>
>     rdgsbase rbx
>
>     cmp rbx, rax
>     je fastpath_after_regs_preserved
>
>     wrgsbase rax
>
> ; if we reach here we are being exploited and should explode or attempt
> ; to recover
> ```
>
> The unfortunate part is that it would still result in the register state
> being dumped on top of some attacker controlled address, so if the error
> path is recoverable someone could still use entrypoints to convert contro=
l
> flow hijacking into memory corruption via register dump. So it would kill
> the ability to get ROP but it would still be possible to dump regs over
> modprobe_path, core_pattern, etc.

It is annoying that we (as far as I know) don't have a nice clear
security model for what exactly CFI in the kernel is supposed to
achieve - though I guess that's partly because in its current version,
it only happens to protect against cases where an attacker gets a
function pointer overwrite, but not the probably more common cases
where the attacker (also?) gets an object pointer overwrite...

> Does this seem feasible and any better than the alternative of overwritin=
g
> and restoring KERNEL_GS_BASE?

The syscall entry point is a hot path; my main reason for suggesting
the RSP check is that I'm worried about the performance impact of the
gsbase-overwriting approach, but I don't actually have numbers on
that. I figure a test + conditional jump is about the cheapest we can
do... Do we know how many cycles wrgsbase takes, and how serializing
is it? Sadly Agner Fog's tables don't seem to list it...

How would we actually do that overwriting and restoring of
KERNEL_GS_BASE? Would we need a scratch register for that?

