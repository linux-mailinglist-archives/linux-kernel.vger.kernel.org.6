Return-Path: <linux-kernel+bounces-568112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8DA68E53
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B977AB70F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E701531E3;
	Wed, 19 Mar 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2ALV9kT"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140B1EF1D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392568; cv=none; b=TH70lNKlKjBoJQOUny5g2JjjhqvoQMuxSUDEZ3KfR5JlcrUFDenpIiqjzA7/vjxtWXaO9iw6AaO4cMthz2QxaHJjz6Bw2IinGNdRA7eQ3HiDSVhWfGf6y/5YMNlAogyIq5WwamwAybSogmIcUUaFVEwHDo4KIAXL2jsCrOMD6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392568; c=relaxed/simple;
	bh=lJXwbIw9/HvIjVc2o4DA5LhHhxFGfigKgWHXOv5SVbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLFGlFGwzobFrpGWJCVpFWhe64Z7LJJ/atYjah4cTYmlBHJa5LGvfmkMz4ji1k/NpWzeutJnNI+Wujh07mgj14OP8Zqas11LWkh/mcq1hFLFZcLb82sb9l0/iK9S0x3jLp5evZ0kPjRv+pAQQcvq0Z2jiv7A/ClkSJAN2CDRL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2ALV9kT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so66433791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742392564; x=1742997364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUrjacr6+Ubsif9XCOT2GD3TlGirwClAqLrpM4LE7ms=;
        b=c2ALV9kTvEZYS6JCCrAJOU3dIncaiozPlFuPCU0pzJIrQH0z2HJKYJalG3vgw5/llm
         2u1Xob/0Ee82AnLX193ak0CGeobV3zT4jIZRxtFBsh5VIqp/4hzoKg+6WXOGa+KL6xqZ
         FqrMaoUksb9C5MZH+HPJ13XhpR9oLzwFTql1WhC3jiy+w++IknIRWcorgRojZsLz7kje
         Q5o6M7Zs/ho6r0Q3g+ruClR5fRwBmChZjA2QMnbVHsE1J3o6IkJ7UHQKpU2kIDlg6zFw
         N7l6SNI+Tolk2jfbq01s5bFdy3VrfdVN767QlcKWDz524WMEWKni4D6Lpfidf2/wVRDG
         8g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742392564; x=1742997364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUrjacr6+Ubsif9XCOT2GD3TlGirwClAqLrpM4LE7ms=;
        b=B4ljWrgDhFHd5StFrBq5PWoiYdHCUo7GZJAtjMqiwodCMZb/yHbm+7JQfdJT490XZA
         1sKghjkaFHIEyZym75GdAcwTngNiR9e2PJAFBiLubWzTfuxDaCaP716yEMvn/M+lqClp
         8KUhsxcyFtWJh+M245Obf1uHsgwJObVTrH8Y227eAbWKZdS7ONXFpBXJqPsbCD82kKH9
         0nkDSD60CDE3twSRtyY+Lcc3nbRdCICGVyAe8jBDDtfXt8UxeVna4bF1ZSMfjD+xm9oI
         UM5X6qPAG0+XetdEQIJE9MJ3mfJ9lDH+JU7d/8Ik5QfUFIKldtsIgXwhDfQEZsCew88L
         x7Jw==
X-Gm-Message-State: AOJu0YyuBiTs8D01yptafFrCDSYjIHaf76vI4lcDIdjRPEYNCE3yMWFJ
	mxZVoO05KjTnvP+I8y3EKl4e4EmL08Bfup9pIvkVvI6r9cw26bhWVijvB8jkEEF+o+8sEL38DuN
	sdz1exfmVvhwDbfNc4F2uUsP6ng==
X-Gm-Gg: ASbGncvM8TXDVvWJWng4ncY6U4hN9RDhwjEmcQ/dni5n9pOfq/PB0b2QPaY3XqztnK5
	Cd5MXOw4QJr3Z4lbB7cQlEr3EWs4OCbpafwFhJKC7fvg6nrDf+WJeKeyEoMb1myVCU3WINm4u6j
	DaXQ1POIkPHLitlFxaY4fWJ8ksW0XUtgWveEufqeGq
X-Google-Smtp-Source: AGHT+IHPy0/3IVxT1RWLBdcM5x5otLZ7y2cySRt1E2MUv9vkfuhiGl3rZlpWUFP1IQ/RLmWbMMIDWOUhZMm3WsRrbkg=
X-Received: by 2002:a2e:be06:0:b0:30c:2e21:9958 with SMTP id
 38308e7fff4ca-30d6a44cb55mr10633101fa.32.1742392563957; Wed, 19 Mar 2025
 06:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318071947.907364-1-xin@zytor.com> <20250318071947.907364-2-xin@zytor.com>
 <CAMzpN2iOGKLN99MC6zgzLumysnR5q-M-jZ3y14cp5TYCW1mQWg@mail.gmail.com> <7b0484d2-3608-4243-b3ae-2b49e2a32331@zytor.com>
In-Reply-To: <7b0484d2-3608-4243-b3ae-2b49e2a32331@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 19 Mar 2025 09:55:51 -0400
X-Gm-Features: AQ5f1JoJ3ChAw_tuSBMHHzqNik6M7SyvgE3FFh0vPaHQ12NwdidiLbvc-RcJXMk
Message-ID: <CAMzpN2jRe1dOpKsAxCOG3RVS_x9yq-1phYuzm9ObdpJYQjb++Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/3] x86/fred: Allow variable-sized event frame
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, 
	mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:47=E2=80=AFAM Xin Li <xin@zytor.com> wrote:
>
> On 3/18/2025 6:53 AM, Brian Gerst wrote:
> >> -#define INIT_THREAD_INFO(tsk)                  \
> >> -{                                              \
> >> -       .flags          =3D 0,                    \
> >> +#define INIT_THREAD_INFO(tsk)                                        =
  \
> >> +{                                                                    =
  \
> >> +       .flags          =3D 0,                                        =
    \
> >> +       .user_pt_regs   =3D (struct pt_regs *)TOP_OF_INIT_STACK - 1,  =
    \
> >
> > Use __top_init_kernel_stack here.
>
> Will do.
>
> >
> >>   }
> >>
> >>   #else /* !__ASSEMBLER__ */
> >> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> >> index 91f6ff618852..58c1cd4ca60a 100644
> >> --- a/arch/x86/kernel/process.c
> >> +++ b/arch/x86/kernel/process.c
> >> @@ -108,6 +108,28 @@ int arch_dup_task_struct(struct task_struct *dst,=
 struct task_struct *src)
> >>          return 0;
> >>   }
> >>
> >> +/*
> >> + * Initialize thread_info.user_pt_regs for IDT event delivery.
> >> + *
> >> + * For IDT user level event delivery, a pt_regs structure is pushed b=
y both
> >> + * hardware and software and always resides at a fixed offset from to=
p of
> >> + * current task kernel stack, thus thread_info.user_pt_regs is a per-=
task
> >> + * constant and NEVER changes after initialization.
> >> + *
> >> + * While for FRED user level event delivery, user_pt_regs is updated =
in
> >> + * fred_entry_from_user() immediately after user level event delivery=
.
> >> + *
> >> + * Note: thread_info.user_pt_regs of the init task is initialized at =
build
> >> + * time.
> >> + */
> >> +void arch_init_user_pt_regs(struct task_struct *tsk)
> >> +{
> >> +       unsigned long top_of_stack =3D (unsigned long)task_stack_page(=
tsk) + THREAD_SIZE;
> >> +
> >> +       top_of_stack -=3D TOP_OF_KERNEL_STACK_PADDING;
> >> +       tsk->thread_info.user_pt_regs =3D (struct pt_regs *)top_of_sta=
ck - 1;
> >> +}
> >
> > Can this be put into arch_dup_task_struct() instead of creating another=
 hook?
>
> I wanted to do it at the beginning but task stack is no longer part of
> the task_struct on x86.  Make sense?

I see that now.  My concern here is that using a weak function makes
all other arches pay the cost of an empty function call.  That's why
many hooks are static linlines or macros, especially if the default is
a no-op.


Brian Gerst

