Return-Path: <linux-kernel+bounces-525820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792DA3F5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DC2188DFB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939420C494;
	Fri, 21 Feb 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsTqjkz"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C8207A20
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144310; cv=none; b=dHmxcNg6N63VHnhan55CwRqzLq06nUCw6OJlxVbO+2J8Iq7KTfmr8CCXvBy7Hvk0H3UuDbrr49xrNVo2jiMLp2lco6kZfgBx9cdpwdANhY5kU06YZqUp0skGBR65AKUHy7zss9QOKXUwiGVxBS+jXNJGNlwpJ9tF7v9SrC4L9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144310; c=relaxed/simple;
	bh=s3uQedWJ9hNwpwdHGBu702KF7R3erllmHgS2SjS5uFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDFjoBFxXi8os+Nb1VAclOCi5cdm8oLWteBqeuH/TSlSIWeq1RfZSka23xijeEsyNdBBIj43CiGwKA439X3j+iRJJVatpDNpafu9YAz4ztjo3w8ICH9pFhgAGk1iYbKZ6be9ES8/iTEqbb41bvtXZOeWBZomeZY6KDqItyqwT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsTqjkz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2f240156so20412901fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740144306; x=1740749106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw9xOFK3Adgpjzj/6TSWZoZPWXcf388uvi5bjrziOWc=;
        b=ZzsTqjkzHZtRErN1yne4e4OlK+/GeRppvC2m8hctmdLOsI3Dd2cmeOTWjyneZ2xe/A
         GVQEVL7oV+L6jHRjsGwlo0acaVlIra8vs36lZqKE71QpdgrMF2d9hOxPKfI7ibPws3Na
         MQSmvzcnhsyfZai6OPh/KWOHSzahNdftTBM66kGhKOs2lqRqL3IX6XZSbUqiMok+xWfe
         k9hd0jjZKxONOpeRt5HcPFJoHEBBpdNcWN3HtYJTdeIgrGU1xRLDSWnX0rFVLDrW8J2a
         wFm8Uk6EHdvawuSIkbl1xJZqP1FBZyLP5IyEWy2G6I1W8mIk1iZVwqGoneqOxtFIKD7n
         hzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144306; x=1740749106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw9xOFK3Adgpjzj/6TSWZoZPWXcf388uvi5bjrziOWc=;
        b=eY+JCAfRdC9LRsqL1pO4VVrx3cGitCQoLr/UgGaCSyb/5atroaaNdLkGVmqJu3CjCH
         SGQHiZkAg4ZNAJfCnNyqd2l0Eg630/uZCJCF979/q5j6wX9K+27ezCF0vdPL3UBAwxgD
         2yTA2Dq2QfeToAnDY8/Xz8i0tsKIDKJF3eFpXHvLHVe5KnXODqiqN7Zj2t7nsJiRJgjI
         AeWZLYRCcnelOCeXeBf+dgRFLymRS+hJwDk6IA5iGoiQskuroAmoiXqvYC3SY9JNv8IO
         xX9SxHjUQxgDN0cRWUlVRoPIrEUAs8q9gJhMavmI64V4VU3Xe3O+8/vpkj6MYN4pJ+pb
         dqTA==
X-Forwarded-Encrypted: i=1; AJvYcCVXzIfUm/b4n4otMHBluvaiJyC/PQTOaEzyuhBFTJx7T5BwqahK52MXvk/PANZl/K21OLYqgnwFz7q8dTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymhKmgBv1gU4RSVJ13YRaeGbBSO7ZaU1tE1z6JQ18EN5eqqFzN
	sPMFzfOmagF7RbI/dX3oZ0mUULcIEQNaMsjgRnPAAbLzeC5jhH8XHOG4T+RY1xSgVgqS73i/o7C
	FByXVnkv9SGfEmwgM0XB9n8o52rg=
X-Gm-Gg: ASbGncv+ii7/fAIouAI3cqG40jiAfeSSIGYJtpzIo+OhlwYIEpUuGATYDWtb7Rrvehl
	aTxiOYLt+T3tpZPk7gCdqv2N4kdsup0/Xeo+5icpsOs6aIrDiYIsk4oKrnA5GgNIoRuLXK68mqS
	UKIrfyBxs=
X-Google-Smtp-Source: AGHT+IGtMd/vf1l0wjnepq+YFDOzkrYMay37UQB3x0M3VIXguZwubEb+MbL3UksehLd3qnsOVyiQRN/ukb/v1mvliaE=
X-Received: by 2002:a2e:80d3:0:b0:302:4a61:8b85 with SMTP id
 38308e7fff4ca-30a599951ebmr10840881fa.37.1740144306255; Fri, 21 Feb 2025
 05:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
In-Reply-To: <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Feb 2025 14:24:54 +0100
X-Gm-Features: AWEUYZkzHlHI0zkc1U82ULpehW_nNh1QiJYjFqBqd3qJBFNoGuVmWF9y_HFMTHM
Message-ID: <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Brian Gerst <brgerst@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 1:54=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Thu, Feb 20, 2025 at 3:04=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > Move stack canary from __stack_chk_guard to struct pcpu_hot and
> > alias __stack_chk_guard to point to the new location in the
> > linker script.
> >
> > __stack_chk_guard is one of the hottest data structures on x86, so
> > moving it there makes sense even if its benefit cannot be measured
> > explicitly.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/current.h | 13 +++++++++++++
> >  arch/x86/kernel/cpu/common.c   |  1 -
> >  arch/x86/kernel/vmlinux.lds.S  |  2 ++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curr=
ent.h
> > index bf5953883ec3..e4ff1d15b465 100644
> > --- a/arch/x86/include/asm/current.h
> > +++ b/arch/x86/include/asm/current.h
> > @@ -15,6 +15,9 @@ struct task_struct;
> >  struct pcpu_hot {
> >         union {
> >                 struct {
> > +#ifdef CONFIG_STACKPROTECTOR
> > +                       unsigned long           stack_canary;
> > +#endif
> >                         struct task_struct      *current_task;
> >                         int                     preempt_count;
> >                         int                     cpu_number;
> > @@ -35,6 +38,16 @@ struct pcpu_hot {
> >  };
> >  static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> >
> > +/*
> > + * stack_canary should be at the beginning of struct pcpu_hot to avoid=
:
> > + *
> > + * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard
>
> This should be R_X86_64_PC32 relocations.

This is what the build system reports if any offset (including 0) is added =
to

PROVIDE(__stack_chk_guard =3D pcpu_hot);

It is not a warning, but an error that fails the build.

As was discussed in the previous thread, the above is required to
handle !SMP case, where mstack-protector-guard=3Dglobal (used by !SMP
builds) ignores the
-mstack-protector-guard-symbol option and always uses __stack_chk_guard.

Uros.

