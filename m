Return-Path: <linux-kernel+bounces-382620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758B9B1125
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABFE1C21490
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBED1D2B03;
	Fri, 25 Oct 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6MdqoTg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC9217F20
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890092; cv=none; b=EiT77+cQM08GjPGDSNnWQNj7zh1Tp/A0bsgWa5ThkUGD4cvnYe8+s/5kDsYRDSohVm33ytHdYh+/BWzMkGS8ZRA84YDdWFCiqjz9c3Hr90s5u2clUHEm9EVHvBGF5HkjAtsPQja92eJ41ND9IOeZnG32P0/J7AslVsEo/o1vUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890092; c=relaxed/simple;
	bh=ZlFgBoPAajZcHs31owN7WGajSj7S/++DTg1zZbBQon4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3K2fwx5+qBSQWNG1CIqhjAZWeEQn9E78HSwif+Gaw1CBOhRFTsewI4Dq5l441NqV4PnvnWvId0/FuSmmRDyu3B2026h5aEUsXaR7Tug+07qe2O3XHn+FlQAuChV2pPCYGRkQkgUDhos+SJW2yJTU18ECDrFnsgpIfiyQy4+Y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6MdqoTg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3110b964so20911241fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729890088; x=1730494888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD0JhbfvcwzIEaD0u4DhwMnDsIiXcDoHEtWtQKf+Hag=;
        b=b6MdqoTgG6I+qSLzhvsuOHUwrxdmnC1scjsHhz6T18eqOeZSMYQ0P2qej7mKj6vkWl
         KIs9apWnGiao+Piosl+9tMZvbiMXjuLB4VkYEZXHqnv/uqx7CNc+mJ+6Ox7y6UZUtCw5
         SyBoAPPYd1XSjtPOBlDV5493RwRkqCvDS8BJQWzEicWwLXELOhtptSTStJMYmVDLHue8
         IkwA+7qJzqFA4OVYwtpa43ATmjXm8Hel1BCmyvgmFrN2G/cQN4MV3t+FnIZTOqM5RbuJ
         iaRptScaNayNmAWIkFpMRPFq3IIJdPYHGZVoXUqqFcwLpwP09q+IMMqEa33NJn2pueBN
         x9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890088; x=1730494888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD0JhbfvcwzIEaD0u4DhwMnDsIiXcDoHEtWtQKf+Hag=;
        b=gfKIGtv0KrQKVQw5WonWHEixZrQBV1Svqt0dKDaQV2aF44v2zJ1GX0WUKmNEVh1XIr
         WVoawbNJWQDqrUQ2Fle2o+eiwhW88tG35GVUCV1J3hjRVPcKgaWagNa16WinpPV2lKrD
         k8ecIR+HtvSrptHz8q6+DLGpxxlBv/ADPf1+Zxy27lpKSf2P4FbRaSItB3sOSJQhBXI9
         NFnqWkkpwPc0U8DqcmbkAQe2MitseehQe6CjxJz6G35Aa8Fg9a1S2QCh2XfCVOwRaWly
         0Vo/jiYQuG3q6pjsmcIuJ3SI3T1MmVoAhlKks4ooXFpRfQKA4sKwNSBO309bbFjywZgN
         AU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXTwkrbAeod/Clgi5MG1/5w19d+CNbVRZ1rAd3dG1a/D1ZO6SHED6ohZzE3CJkd0zN/uJShiU7sSsUybIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gCXkST4jo0YXbQ2JbvMZDl3ABs/JXv5arnHDxDXAqmBpJVAW
	FlGKEYfJne2xd6VLLJtccZn9SJyjWixAymdzmD7HiRUcHeM+BokYuOlr3lHl0E44KKQmeReGA9L
	nNCaoHppDR8JMiBxVqqf8FBlSXVo=
X-Google-Smtp-Source: AGHT+IFKObRmPLm8N9D3yNebc7C78VkFn3hueiAYPI1hVK1ArQsjkZAKMtO/rNXuumgfMTj3ECXzR1oiQU6GSwfalpA=
X-Received: by 2002:a2e:be1a:0:b0:2fa:c9ad:3d36 with SMTP id
 38308e7fff4ca-2fcbdf620femr3748511fa.7.1729890088222; Fri, 25 Oct 2024
 14:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007083345.47215-1-ubizjak@gmail.com> <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
 <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com> <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
In-Reply-To: <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 25 Oct 2024 23:01:20 +0200
Message-ID: <CAFULd4a5+er=7xk+oXOtOsJVUqg86ZWxxvX7jdtOEBcMX60fKg@mail.gmail.com>
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 7:13=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 24, 2024 9:20:01 AM PDT, Uros Bizjak <ubizjak@gmail.com> wrote=
:
> >On Thu, Oct 24, 2024 at 5:21=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >>
> >> On 10/7/24 01:33, Uros Bizjak wrote:
> >> > Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref=
)
> >> > to use optimized implementation and ease register pressure around
> >> > the primitive for targets that implement optimized variant.
> >>
> >> Ease register pressure at the end of a syscall?
> >>
> >> I'll accept that we're doing this just as a matter of hygiene.  But it=
's
> >> a stretch to say there are any performance concerns whatsoever at the
> >> end of the ioperm() syscall.
> >>
> >> So what is the real reason for this patch?
> >
> >Please see code dumps for i386, a target that implements atomic64_inc_re=
turn():
> >
> > 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
> > 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
> >            1b1: R_386_32    .bss
> > 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
> > 1b8:    31 d2                    xor    %edx,%edx
> > 1ba:    b8 01 00 00 00           mov    $0x1,%eax
> > 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
> >            1c0: R_386_PC32    atomic64_add_return_cx8
> > 1c4:    89 03                    mov    %eax,(%ebx)
> > 1c6:    89 53 04                 mov    %edx,0x4(%ebx)
> >
> >vs. improved:
> >
> > 1a9:    8d 04 95 04 00 00 00     lea    0x4(,%edx,4),%eax
> > 1b0:    be 00 00 00 00           mov    $0x0,%esi
> >            1b1: R_386_32    .bss
> > 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
> > 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
> >            1b9: R_386_PC32    atomic64_inc_return_cx8
> > 1bd:    89 03                    mov    %eax,(%ebx)
> > 1bf:    89 53 04                 mov    %edx,0x4(%ebx)
> >
> >There is no need to initialize %eax/%edx register pair before the
> >"call" to atomic64_inc_return() function. The "call" is not an ABI
> >function call, but an asm volatile (which BTW lacks
> >ASM_CALL_CONSTRAINT), so there is no ABI guarantees which register is
> >call-preserved and which call-clobbered.
> >
> >Oh, this is the "return" variant -  the function indeed returns the
> >new value in %eax/%edx pair, so the difference is only in the
> >redundant register initialization. I can reword the commit message for
> >this case to mention that an initialization of register pair is spared
> >before the call.
> >
> >Uros.
> >
>
> What does ASM_CALL_CONSTRAINT actually do *in the kernel*, *for x86*? The=
re isn't a redzone in the kernel, and there *can't* be, because asynchronou=
s events can clobber data below the stack pointer at any time.

The reason for ASM_CALL_CONSTRAINT is explained in arch/x86/include/asm/asm=
.h:

--q--
/*
 * This output constraint should be used for any inline asm which has a "ca=
ll"
 * instruction.  Otherwise the asm may be inserted before the frame pointer
 * gets set up by the containing function.  If you forget to do this, objto=
ol
 * may print a "call without frame pointer save/setup" warning.
 */
register unsigned long current_stack_pointer asm(_ASM_SP);
#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
--/q--

__alternative_atomic64() macro always uses CALL instruction and one of
alternatives in __arch_{,try_}cmpxchg64_emu() uses CALL as well, so
according to the above comment, they all qualify for
ASM_CALL_CONSTRAINT. This constraint is added to the mentioned macros
in the proposed series [1].

[1] https://lore.kernel.org/lkml/20241024180612.162045-1-ubizjak@gmail.com/

Uros.

