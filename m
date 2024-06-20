Return-Path: <linux-kernel+bounces-223379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C4911207
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A14B24F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0F1B4C4D;
	Thu, 20 Jun 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROAhPUPs"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CA1B47C1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911399; cv=none; b=Anz/yVgbZ6OX5X0VTZaCMN340Ny4foHpftlPDSZcJAXjIyOOJWmWtPzYqr2I9zTAmZlmdCZJqr+nEXkdOf7CI6LjhvwuGqUZcANid+LXFDriaAC0hK4bX9fznHSnO4fFUdVDUT3sao8KSeFHWynWgZrhYmHLfv33h8z21paYfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911399; c=relaxed/simple;
	bh=zLut+0prhCT1eBX6fZQYJKsvC08Ub2wLq769lqa1Tuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkYEHnJiMI/t7RMp5f7RQoAuDDpLB9+7bjPkNHG/MCgd8DWXzYv6CAOInU88ZhwcshGjqdShA2b1eSytuzD2FXSHP8vjZxY3DJ297U20Nq0ddhJqd6tGi7HSRAxONPRvkMcZfv8kYANKxL6MFzd4GH40tntaYqMd+C3gUHrpud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ROAhPUPs; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8d0a00a35so1175660a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718911396; x=1719516196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYAaAnJ1daXZl8jVKFDZh/xHsalBVy1PvK86SNFCWgs=;
        b=ROAhPUPsdpTWHdK3W76iEeO1YT6v8fBFnL6rI40y6J8pbBgXrl0dovOTqg3+jd4q+c
         zAn5zimXqSeEX8U1MZiTdxGk2Mo6t7T6tsiailYQWXqriH1oZTrJrKa9hwcC1KxDOAuo
         agwESniOktjT9niNdi0GG42+GvBzm1/6v9ibw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911396; x=1719516196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYAaAnJ1daXZl8jVKFDZh/xHsalBVy1PvK86SNFCWgs=;
        b=ahfjcWfnyx9j8SYMXTm//YO4Rfe5gvvk+w/yBnYv4o9e/BgTLx6mhmj+UW7IZW6xrC
         OrrdGyMmcrdM9jtLkKmFJalPLSEa9yqmBkkfZjOAcj+kh5fiye81IIhAo1MCjvZmRELW
         N7NPRq+rQssJHBIwmYE+71R/ttnDGM9kSHuwCVKWlFZsK667Uo8P7f6d0JmqHFQ6DxmT
         HyhgMKwY2vQ8+W/AAYnio7RfOgNkcRbd2cop63c8gJjT51JTbLEpFEr7b8fc33ye6Eb4
         hDDX77wzT5isKwj4nB6eGZPq+UoGygEa2LAB/E6uEXRm/8znY9Ls919qS/H9RmHT1iLo
         I1QA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Sg+jkgTWF8YV4T01q9Hs5jszqFlP2C8jR8kgzjH6/KXg/6JZLeD6pBG8EFtDh36DPK9p5T/SZ/DZC+yNTXUJC2YbPo3rp0s2UeAP
X-Gm-Message-State: AOJu0Yy4p7Ssf71Jz+iS7w8UU9w9Us+8OltPZGmqbn7xRuzrJZdKftw2
	2j6SDm5hebOGfNdvzH058A08qXCd2jdGYYT26l1aERxzHWnkzX2aFIYOZM1Jwxwxz0RnBTUETzF
	nTl6m0fXrJzp5o49KpIFqkzzCcM4J4KMRsfqE
X-Google-Smtp-Source: AGHT+IHcbWYR47B38NPGgHxYbRwJtcb+NG4ZK01XKPwR6tbI8P1qMqsw0Vf7HNi48bXLyZYd1RO8UMYaX0ztezPQBOA=
X-Received: by 2002:a05:6870:5b9b:b0:25b:3e23:e5ef with SMTP id
 586e51a60fabf-25c949060ecmr7353840fac.3.1718911396491; Thu, 20 Jun 2024
 12:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606224035.3238985-3-aruna.ramakrishna@oracle.com>
 <20240610213934.3378947-1-jeffxu@chromium.org> <2DB720B0-0921-4912-8C5F-F0EDDF77845D@oracle.com>
 <CABi2SkVZA0-7_PPbvycaojr0qBPVn7DPW1F1CpNTZwT_Hi0xiQ@mail.gmail.com> <90B0A18A-DB23-45DC-8491-0CC293FB6264@oracle.com>
In-Reply-To: <90B0A18A-DB23-45DC-8491-0CC293FB6264@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 20 Jun 2024 12:23:05 -0700
Message-ID: <CABi2SkWxNkP2O7ipkP67WKz0-LV33e5brReevTTtba6oKUfHRw@mail.gmail.com>
Subject: Re: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
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

Hi Aruna

On Mon, Jun 17, 2024 at 9:43=E2=80=AFAM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Jun 11, 2024, at 3:13=E2=80=AFPM, Jeff Xu <jeffxu@chromium.org> wrot=
e:
> >
> > On Tue, Jun 11, 2024 at 7:05=E2=80=AFAM Aruna Ramakrishna
> > <aruna.ramakrishna@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jun 10, 2024, at 2:39=E2=80=AFPM, jeffxu@chromium.org wrote:
> >>>
> >>> The orig_pkru & init_pkru_value is quite difficult to understand.
> >>>
> >>> case 1> init_pkru: 00 (allow all)
> >>> orig_pkru all cases  =3D> allow all
> >>>
> >>> case 2> init_pkru: 01 (disable all)
> >>> Orig_pkru:
> >>> allow all 00 =3D> 00 allow all.
> >>> disable all 01 =3D> 01 disable all.
> >>> disable write 10 =3D> 00 allow all <--- *** odd ***
> >>> disable all 11 =3D> 01 disable all
> >>>
> >>> case 3> init pkru: 10 (disable write)
> >>> allow all 00 =3D> 00 allow all.
> >>> disable all 01 =3D> 00 (allow all) <----*** odd ***
> >>> disable write 10 =3D> 10 allow all
> >>> disable all 11 =3D> 10 disable write <--- *** odd ***
> >>>
> >>> case 4> init pkru: 11 (disable all)
> >>> orig_pkru all cases =3D> unchanged.
> >>>
> >>> set PKRU(0) seems to be better, easy to understand.
> >>>
> >>
> >> I=E2=80=99m not sure I follow.
> >>
> >> The default init_pkru is 0x55555554 (enable only pkey 0). Let=E2=80=99=
s assume the application
> >> sets up PKRU =3D 0x55555545 (i.e. enable only pkey 2). We want to set =
up the PKRU
> >> to enable both pkey 0 and pkey 2, before the XSAVE, so that both the c=
urrent stack as
> >> well as the alternate signal stack are writable.
> >>
> >> So with
> >> write_pkru(orig_pkru & pkru_get_init_value());
> >>
> >> It changes PKRU to 0x55555544 - enabling both pkey 0 and pkey 2.
> >>
> > Consider below examples:
> >
> > 1>
> > The default init_pkru is 0x55555554 (pkey 0 has all access, 1-15 disabl=
e all)
> > and thread has PKRU of 0xaaaaaaa8 (pkey 0 has all access, 1-15 disable =
write)
> > init_pkru & curr_pkru will have 0x0
> > If altstack is protected by pkey 1, your code will change PKRU to 0,
> > so the kernel is able to read/write to altstack.
> >
> > 2>
> > However  when the thread's PKRU disable all access to 1-15:
> > The default init_pkru is 0x55555554 (pkey 0 has all access, 1-15 disabl=
e all)
> > and thread has PKRU of 0x5555554 (pkey 0 has all access, 1-15 disable a=
ll)
> > init_pkru & curr_pkru will have 0x55555554
> > If altstack is protected by pkey 1, kernel doesn't change PKRU, so
> > still not able
> > to access altstack.
> >
> > 3> This algorithm is stranger if inti_pkru is configured differently:
> > The init_pkru is 0xaaaaaaa8 (pkey 0 has all access, and 1-15 disables w=
rite.)
> > and thread has PKRU of 0x55555554 (pkey 0 has all access, 1-15 disable =
all)
> > init_pkru & curr_pkru will have 0x0 (0-15 has all access).
> >
> > Overall I think this is a confusing algorithm to decide the new PKRU to=
 use.
>
> I understand your point. But the patch makes the assumption that the siga=
ltstack is
> accessible with init_pkru, which is not the case in these 3 examples. I=
=E2=80=99m not saying
> that assumption is right - just that, that=E2=80=99s the use case which w=
e=E2=80=99re trying to fix here.
>
Consider below case:
1> let init_pkur be 0x55555554(disable all for key 1-15, allow access to pk=
ey 0
2> let the current pkur 0xcccccc1 (disable write for key  0 and 2-15,
allow access to pkey 1)
The new pkru will be 0x0. It gives  access to all pkeys, IIUC,
your scenario just needs to enable all access to pkey 0, right ?

I give this example to show the algorithm is difficult for dev to
reasable about.

> But you=E2=80=99re saying that the altstack could be using any pkey, and =
handle_signal()
> does not know which one it is, so it should just enable all pkeys - is th=
at right?
>
Yes, along that line of thinking.

Since the kernel (handle_signal) now needs to modify PKRU to have access to
sigaltstack, which is a behavior change, and altstack can be protected
by any PKEYs,
setting the PKRU to zero is the simplest solution.

I agree with Thomos that this will open up more access, we could let
applications
explicitly ask this by setting a new ss_flag when calling sigaltstack() cal=
l.
e.g.
stack_t altstack;
altstack.ss_sp =3D ptr;
altstack.ss_flags =3D 0;
altstack.ss_flags |=3D SS_PKEYALTSTACK;  <----
int ret =3D sigaltstack(&altstack, NULL);


> Thomas,
> Can you please review/comment?
>
> >
> >> After the XSAVE, it calls update_pkru_in_sigframe(), which overwrites =
this (new)
> >> PKRU saved on the sigframe with orig_pkru, which is 0x55555545 in this=
 example.
> >>
> >> Setting PKRU to 0 would be simpler, it would enable all pkeys - 0 thro=
ugh 15 - which,
> >> as Thomas pointed out, seems unnecessary. The application needs the pk=
ey it
> >> enabled for access to its own stack, and we need to enable pkey 0 unde=
r the hood
> >> to enable access to the alternate signal stack.
> >>
> >
> > I think you are referring to Thomas's comments in V3, copy here for
> > ease of response:
> >
> >> User space resumes with the default PKRU value and the first thing use=
r
> >> space does when entering the signal handler is to push stuff on the
> >> signal stack.
> > ...
> >> If user space protects the task stack or the sigalt stack with a key
> >> which is not in init_pkru_value then it does not matter at all whether
> >> it dies in handle_signal() or later when returning to user space, no?
> >
> > The userspace could register a custom handler (written in assembly) to
> > change PKRU and allow access to the stack, this could be written in suc=
h
> > that it is before pushing stuff to the stack. So all it requires is
> > that the kernel
> > doesn't SIGSEGV when preparing the signal frame in sigaltstack, this is
> > where PKRU=3D0 inside the kernel  path helps.
> >
> > Even today, without patch, one can already do following:
> > 1> use PKEY 1 to protect sigaltstack
> > 3> let the thread have all access to PKEY 1
> > 3> send a signal to the thread, kernel will save PKRU to the altstack c=
orrectly.
> > 4> kernel set init_pkur before hands over control to userspace
> > 5> userspace set PKRU to allow access to PKEY 1 as the first thing to d=
o.
> > 6> on sig_return, threads have PKRU restored correctly from the value
> > in sigframe.
> >
>
> In this example above, pkey 1 grants access to the altstack, which is ena=
bled
> through out this flow. I think perhaps this use case is more interesting:
>
> 1. Use pkey 1 to protect sigaltstack.
> 2. Use pkey 2 to protect thread=E2=80=99s stack.
> 3. Disable all but pkey 2 (=3D orig_pkru).
> 4. Send a signal to the thread (kernel patch needed; we'd have to enable =
all
> pkeys in handle_signal() - i.e. pkru =3D 0).
> 5. Kernel sets pkru=3Dinit_pkru before handing over control to userspace =
(i.e.
> only pkey 0 is enabled).
> 6. Signal handler should enable pkey 1 as the first thing.
> 7. On sigreturn, orig_pkru is restored correctly.
>
> I=E2=80=99m not sure if (6) will work or if it=E2=80=99ll crash with a SI=
GSEGV - I haven=E2=80=99t tested
> this flow.
>
User space can write assembly code to change PKRU before the rest of the ca=
lling
conversation, e.g. push local to stack.
Try below code:

/*
 * change PKRU before calling the inner.
 *  disclaim: not expect in ASM, so this code might have bug
*/
void asm_handler(int signum, siginfo_t *si, void *vucontext);
__asm__(
".global asm_handle\n"
"asm_handler:\n"
" mov %rdx, %r8\n"
" xor %eax, %eax\n"
" xor %ecx, %ecx\n"
" xor %edx, %edx\n"
" wrpkru\n"
" mov %r8, %rdx\n"
" call inner\n"
" ret\n"
);

void inner(int signum, siginfo_t *si, void *ptr)
{
...
}


struct sigaction sa;
 ...
sa.sa_sigaction =3D asm_handler;
sa.sa_flags =3D SA_ONSTACK | SA_SIGINFO;
ret =3D sigaction(SIGUSR1, &sa, NULL);

Thanks
-Jeff

> Thanks,
> Aruna
>

