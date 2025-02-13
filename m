Return-Path: <linux-kernel+bounces-513963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5EFA350CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3134D3A79A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA124BBFE;
	Thu, 13 Feb 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GES4zMiX"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CA206F15
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484036; cv=none; b=rkT/Z8exNyGBC96S4iIEi18r9uoGC4nM02KhFUXmyO7MlQxLSu2gP11H2vFAoV7qCT/1aoj0Q/OgxYO1Hvw/43okJBkMaKNAxIa1uJLRbUa2xa5mDX+zTPu7ocLKeSd7SIFasufTUbpyMQ9Iqb62+New3yomQOCNNhwOqMKXVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484036; c=relaxed/simple;
	bh=lcyYjfx42aCFHp9AMZfpob+6CrOC2rLJVDEySyY3isk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mqv/X9hVQfWhRvOaWjjZ3DaoviA9DVtkgZ5XagxzbI39C2DAqF2hVWiWCH042wYSW6ECE8Hak7tjGXgcUcVDvgXWDojp79Ii5Eq9YjZNVvRImh4/b+JZJIoMbJ4T/vm4E0Ne0Ekx/1v9zwaRkBORJbLt5h9Af/awEbX+IzN1Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GES4zMiX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3d8c0a2edso37756b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739484033; x=1740088833; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVDdJuGJBV06FhLssYXV1tVqu4QAOw03JY046Cqka88=;
        b=GES4zMiXIj60NrFdKFjsEhdZPfBC+83i2Bivh2TnrTZ2XyY2B82+vJRuqYfRYl9LKt
         jDSmCUIDMVisUvOvxgtlXzOTI7rEwItmlyEp23PrMIAWWJ/tN9ke6INGTFCKdu4MjM+j
         1b8z+chut1ohE907gguTe9BujG5dUJptPyM+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484033; x=1740088833;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVDdJuGJBV06FhLssYXV1tVqu4QAOw03JY046Cqka88=;
        b=gIVPZBxipGHadIN9F/wnUGBa/OUyc1cTZLMn/fIAp5clFleitGwAIhfRmaU2GyJx+F
         NUsi3tvR08aA8BVHtb05tUAmvRnIzsbM00z66LJNIje3b9xzHteUU5mTYkLJb1MjhYig
         U5WDae+MpJYmkT4HLxem3tOOu+YVB8dyklKiw0BJId3Eq6FPH3LTJYZ6oj5RL+ERCYBe
         XnpdK45SKA8PjoK3tAz16RyoCw/LU25+94b5X8yfLjv4go7ojzA/QRaU5DCiqrUi7Pg0
         R/k3T/HGXoIvy1vADxVm1g1+/zAxtvpZ0Z2sd/9STKL68hTYxuCmkhixrWvTodgI1B4m
         CUMw==
X-Forwarded-Encrypted: i=1; AJvYcCX9H/qeW/3b0CpMXpTk3xbBFiPCBQF46PtQj2x0C2JayhxQx4l45sFzskMRy8XEB5Tdt5VAS5w9cA4fAVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMghNLVXHblkrtrjf+YosdmkwQuhluRtziKlUrr82xND/FVzh
	wipfFmkwkx9vZ31vMUML72DT+L40wFcbnBgE+oQQiirQXVudJTTafKaw7jkNp0/C1ti5ZRn6S0l
	Ob17XJqo4mKKPNvyylDIAeZd04xPbG0CnKnlz
X-Gm-Gg: ASbGncsd+qSRBXe9SmHjJ8/ZQywlFNS/0Wd1TII01ap7KrZ9zXP5m9d/dEhQO58sZIL
	T3D+DwsDX+SknXdbbMG3goQ5orRyG8Y3h1OH+89mFafARv5XJfK7hh75Dp7LGplAb6L4W/gljNM
	ng2F2Hr7zAwiJDFFkpeMXePhzdiGkYsg==
X-Google-Smtp-Source: AGHT+IFZ89lyjLhjthMWsh+Xv4yhuWhXx7WGtpO3v2Lf/Ol2MmQBmeBdIvJLJQo6cKuEv712+t/jVH0mS+/lu/S260g=
X-Received: by 2002:a05:6808:1b1f:b0:3eb:9107:ee76 with SMTP id
 5614622812f47-3f3e1a4eee0mr102943b6e.7.1739484033654; Thu, 13 Feb 2025
 14:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook> <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
In-Reply-To: <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 14:00:22 -0800
X-Gm-Features: AWEUYZlJg0Av8eErqyHIPSk3VZi3rcP5H9jYN8zDMf2Bq0g8eCVrgdxuS5QpM8M
Message-ID: <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:54=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:

> > > >
> > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part o=
f
> > > > the build. This is intentional. Any 32-bit code trying to use the
> > > > sealing function or the VM_SEALED flag will immediately fail
> > > > compilation. This makes it easier to identify incorrect usage.
> > >
> > > So you are against using the #define because the VM_SYSTEM_SEAL will =
be
> > > defined, even though it will be VM_NONE?  This is no worse than a
> > > function that returns 0, and it aligns better with what we have today=
 in
> > > that it can be put in the list of other flags.
> >
> > When I was reading through all of this and considering the history of
> > its development goals, it strikes me that a function is easier for the
> > future if/when this can be made a boot-time setting.
> >
>
> Reworking this change to function as a boot-time parameter, or whatever,
> would not be a significant amount of work, if/when the time comes.
> Since we don't know what the future holds, it it unnecessary to engineer
> in a potential change for a future version when the change is easy
> enough to make later and keep the code cleaner now.
>
Sure, I will put the function in mm.h for this patch. We can find a
proper place when it is time to implement the boot-time parameter
change.

The call stack for sealing system mapping is something like below:

install_special_mapping (mm/mmap.c)
map_vdso (arch/x86/entry/vdso/vma.c)
load_elf_binary (fs/binfmt_elf.c)
load_misc_binary (fs/binfmt_misc.c)
bprm_execve (fs/exec.c)
do_execveat_common
__x64_sys_execve
do_syscall_64

IMO, there's a clear divide between the API implementer and the API user.
mm and mm.h are the providers, offering the core mm functionality
through APIs/data structures like install_special_mapping().

The exe layer (bprm_execve, map_vdso, etc)  is the consumer of the
install_special_mapping.
The logic related to checking if sealing system mapping is enabled
belongs to the exe layer.

>
> > If mm maintainers prefer a #define for now, that's fine of course. The
> > value of VM_SYSTEM_SEAL can be VM_NONE on 32-bit.
>
> Thanks.  I think having a flag with VM_NONE on 32-bit is just as sane as
> a "flags |=3D system_seal()" call that unconditionally returns 0 on
> 32-bit.
>
Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c,

#ifdef CONFIG_64BIT
[ilog2(VM_SEALED)] =3D "sl",
#endif

If #ifdef CONFIG_64BIT is missing, it won't be detected during compile time=
.

Setting VM_SEALED to VM_NONE could simplify the coding in some cases
(get/set case), but it might make other cases error prone.

I would prefer to not have VM_SEALED for 32 bit.


-Jeff

