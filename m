Return-Path: <linux-kernel+bounces-210611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A390463E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06501F25335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA95153505;
	Tue, 11 Jun 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yp3FdIU2"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDFBA34
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141190; cv=none; b=rViMGFPcusKr//5mG0eV0K4zhcnpIXYbpOL6UIUavqX1aR/QuqGKhiIHilhI8a+iyjVr9tBiPwAVkklKi2k9XZKYxnGUklrE940NFFwL4LZoZyD4ulA3QIDIk66fSi/2mjWINOxfbPo8dGx3p0+iTydKlijN5TMh22unu+qAue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141190; c=relaxed/simple;
	bh=1leaG4GYghB3a0TXOJxDjGkFsbtKBLyEiETYWUX8I38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLwWe3pylHWpWW+2ikSvBamowPO07vONChmn4gidfPdbFqjHevBqBEYpwnGDKEG/hbZbq/YrFnXJ7JAF8iVVhwfk8VBVjg2WGVn+WP/DINmLZeapkQVjLPhD3qvrgxbLsvBU8EzcbkSBZea8W+XStXiiV3YowxctPYZOJmsriIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yp3FdIU2; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3cabac56b38so3665353b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718141188; x=1718745988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dbiR3+hMg0ChK7V/LufBGR4PDxTSZDUHbLGBPK1KKA=;
        b=Yp3FdIU2JhpDs1O2N9KXOzGmYz6VIfC8LAFX6X73GLdHOvJ/92zaIpGi6nt6KReHpx
         2EQ+n/uHL/vqRtVUqz5CLIHzETrRoN462aN/qGuJK5HouFfEodvvcYEa3q7TyUnabRe0
         X3CxclcV/eNVhuapRZ09ibvBvAdtFaevhTqpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718141188; x=1718745988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dbiR3+hMg0ChK7V/LufBGR4PDxTSZDUHbLGBPK1KKA=;
        b=sncEwV8/Nt6yvLHHIAPptkmDMvlfCVAF/ndCEqattRlo/J9Xs61LFjgu0wFzIT9pIF
         I5m4d9bAh4lxnxbtlyRr4hm68eg2hYXlJ+EOe0keHLCFWI4Ito4YjPQdxi5aM28jexX7
         I2cy8W9Ddfkubg2ixDVfZT7Pkgj6LlJ/EynDmgZR9eBHMvHzvWuyTc2Z7xQtheda6/Vv
         7Z06PKCb4HOdoRcOk62RUEv8VI+3VoCuSBCpNwk3L4j6/Z+ipl5wFsBpKI7iM7kW4+/w
         KgXGP7b8pdWD1Ez7po7G0q1o/AZA1lBPOU/O+gdVY8Qwka5pHrSwGyfovq7LPkIcVLxS
         9CPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX06QEkM+p1EFuT/bdTAcGAOSSy4v5jK+bfM3lGaZzqzVt9lJnFqsPdQrE/MsO0+eRrldISG8+9zS3Yi95Jebdo3Yn9o9zeExS8uilw
X-Gm-Message-State: AOJu0Yx22wNlg3++3/ZgMZ3uFoTAFjT2hlxvv3E8fYunVztTGHgnru3j
	rGy7qCATSH/X7Sazm7dqQRDXWMwFBe2v5kqbZmtaFcxI5CYMaKfw/vB9uHprl7I5VCWL7K7P0HT
	8eT6HlTDwrC75OaoVALzBxroXsZ0aVkMbPJJj
X-Google-Smtp-Source: AGHT+IGzvhsNgtueq4JY/qt/Qvc6qPSkzaNWH/Ir86djGRAGPx22948RzbqPWNewywTfI0LPb4BwAg8KCwPnvJS3/Us=
X-Received: by 2002:a05:6870:1218:b0:251:8d0:1c76 with SMTP id
 586e51a60fabf-25514c94490mr46045fac.29.1718141187609; Tue, 11 Jun 2024
 14:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606224035.3238985-2-aruna.ramakrishna@oracle.com>
 <20240610213122.3377462-1-jeffxu@chromium.org> <2BA1926A-8720-4B85-8D15-557CB9A8464E@oracle.com>
In-Reply-To: <2BA1926A-8720-4B85-8D15-557CB9A8464E@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Jun 2024 14:26:15 -0700
Message-ID: <CABi2SkUwx=aooM3FnYsOXmNmWz3RNkAJ4TA7C6FWdgsMaBjTag@mail.gmail.com>
Subject: Re: Re [PATCH v5 1/5] x86/pkeys: Add PKRU as a parameter in signal
 handling functions
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Keith Lucas <keith.lucas@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	Andrew Brownsword <andrew.brownsword@oracle.com>, 
	Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>, 
	"jeffxu@google.com" <jeffxu@google.com>, "jannh@google.com" <jannh@google.com>, 
	"keescook@chromium.org" <keescook@chromium.org>, "sroettger@google.com" <sroettger@google.com>, 
	"jorgelo@chromium.org" <jorgelo@chromium.org>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:56=E2=80=AFAM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Jun 10, 2024, at 2:31=E2=80=AFPM, jeffxu@chromium.org wrote:
> >
> > On Thu, Jun 06, 2024 at 10:40:31PM +0000, Aruna Ramakrishna wrote:
> >
> >> diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm=
/sighandling.h
> >> index e770c4fc47f4..de458354a3ea 100644
> >> --- a/arch/x86/include/asm/sighandling.h
> >> +++ b/arch/x86/include/asm/sighandling.h
> >> @@ -17,11 +17,11 @@ void signal_fault(struct pt_regs *regs, void __use=
r *frame, char *where);
> >>
> >> void __user *
> >> get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_=
size,
> >> -     void __user **fpstate);
> >> +     void __user **fpstate, u32 pkru);
> >>
> >> -int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
> >> -int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> >> -int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> >> -int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> >> +int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 =
pkru);
> >> +int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u=
32 pkru);
> >> +int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u3=
2 pkru);
> >> +int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u3=
2 pkru);
> >
> > Does ia32 support PKEY ? I thought it is X64 only.
> > It might be possible to not to change any of ia32 code.
>
> From the Intel manual, it did not seem that pkey support was x64 only.
>
https://docs.kernel.org/core-api/protection-keys.html#memory-protection-key=
s

"The feature is only available in 64-bit mode, even though there is
theoretically space in the PAE PTEs."

> >
> >
> >>
> >> #endif /* _ASM_X86_SIGHANDLING_H */
> >> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal=
.c
> >> index 247f2225aa9f..2b3b9e140dd4 100644
> >> --- a/arch/x86/kernel/fpu/signal.c
> >> +++ b/arch/x86/kernel/fpu/signal.c
> >> @@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user =
*buf, int ia32_frame,
> >> return !err;
> >> }
> >>
> >> -static inline int copy_fpregs_to_sigframe(struct xregs_state __user *=
buf)
> >> +static inline int copy_fpregs_to_sigframe(struct xregs_state __user *=
buf, u32 pkru)
> >> {
> >> if (use_xsave())
> >> return xsave_to_user_sigframe(buf);
> >> @@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct x=
regs_state __user *buf)
> >>  * For [f]xsave state, update the SW reserved fields in the [f]xsave f=
rame
> >>  * indicating the absence/presence of the extended state to the user.
> >>  */
> >> -bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, =
int size)
> >> +bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, =
int size, u32 pkru)
> >> {
> >> struct task_struct *tsk =3D current;
> >> struct fpstate *fpstate =3D tsk->thread.fpu.fpstate;
> >> @@ -228,7 +228,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, vo=
id __user *buf_fx, int size)
> >> fpregs_restore_userregs();
> >>
> >> pagefault_disable();
> >> - ret =3D copy_fpregs_to_sigframe(buf_fx);
> >> + ret =3D copy_fpregs_to_sigframe(buf_fx, pkru);
> >> pagefault_enable();
> >> fpregs_unlock();
> >>
> >> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> >> index 31b6f5dddfc2..94b894437327 100644
> >> --- a/arch/x86/kernel/signal.c
> >> +++ b/arch/x86/kernel/signal.c
> >> @@ -74,7 +74,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
> >>  */
> >> void __user *
> >> get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_=
size,
> >> -     void __user **fpstate)
> >> +     void __user **fpstate, u32 pkru)
> >> {
> >> struct k_sigaction *ka =3D &ksig->ka;
> >> int ia32_frame =3D is_ia32_frame(ksig);
> >> @@ -139,7 +139,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs =
*regs, size_t frame_size,
> >> }
> >>
> >> /* save i387 and extended state */
> >> - if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_=
size))
> >> + if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_=
size, pkru))
> >
> > You might find that we only need to update PKRU right before copy_fpsta=
te_to_sigframe,
> > so no need to pass pkru all the way from top.
> >
>
> The PKRU is updated in copy_fpregs_to_sigframe(), right after xsave_to_us=
er_sigframe().
> But the code that decides or cares about what pkru is written to the sigf=
rame is handle_signal(), so
> it seemed cleaner to do those checks there and pass in pkru as a paramete=
r down the stack.
>
IIUC,  the kernel need the read/write access from
get_sigframe (arch/x86/kernel/signal.c),  it is possible to have the
PKRU check/update PKRU inside get_sigframe, and there is no need to
pass orig_pkru from handle_signal().

Thanks
-Jeff

