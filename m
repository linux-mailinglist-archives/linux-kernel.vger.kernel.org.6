Return-Path: <linux-kernel+bounces-182602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F055B8C8D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170C21C2339E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97214037D;
	Fri, 17 May 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyEOmq4F"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018651426E
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976132; cv=none; b=hwmdwiviR4J+OXx6eKzG2c63WCrur2FPGcaZXb4WQckW7f2UwC0fi61fBAPDNngOSSpQdw6eOgDv4/5J0k/UgBGVJNFDgG/WQhhDPKKAk7dPiq5arrDfIAf+MyiI3m/wm9ixB377i8yE0hFHpfbRGaTlLgf8LsEkGSkWHevHsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976132; c=relaxed/simple;
	bh=DcLykhJMcIDe6aDsyWYaRV67CNAtmB+1qJjDiOrFBUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0XBCchr+kHEDh6OCI/q6W8ZMfir3w5EJNUTPxjvuPDEJcan9+GAab2zoL1G1yTectp4tg2OXuW95rOwGHHO1X/1ko1D7qGCfVo93hN7E8qptmS9mwgffjXNYFpKiyxLXg/eZSOH+NqAEc0+QJPHGsPJXmNGNu4R7YRQtfqGHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eyEOmq4F; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8d989e4so72791485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715976129; x=1716580929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI1RNJPjqCg8PPMHmPp0pCN9b95JX+day8N+NzvHcvM=;
        b=eyEOmq4FAvAUa7h96fDWUq7x68Hexe25ClCHqUMbqLO5syHafQ5kolGBdNEdPMpUaQ
         seE0n5Q0Wh/0EjEF9Cz1zIOJ10KF2JRtnX4RTW3Fk9Y16s+bnKdHz4irNlHvMw1HPoGz
         1Dv5gWDi0S2JIb9Eu/8QgbgXkv8jNJfsY+zW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715976129; x=1716580929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI1RNJPjqCg8PPMHmPp0pCN9b95JX+day8N+NzvHcvM=;
        b=soaIt0h/G14qYo/GQsEIFFXOgdBgp4y9q4LpjM5W//AKAD16348yl4Q0Dto7cgNCB1
         XGNbFPG7dWPd0In5IgwUtoOBwlNshZQMFuBl6DKUTp2EQ0hdab9gOJow+OR54xHcLiot
         rK8k0CrIZOkSRtDwXOu7eP6luBl+K5ZG/QxRLeMnjaVkL7sPBWBrEGdo6imFPbWxBvkl
         aBTOFSXKXICt4rdub92LVxOUfXxd8/bAR/r/3KU9DwjTgSRKJCxZbSDMgDrjfnwxn2n1
         LIwsbsIM8G+cAo5GaPgblbB3BDmvIwK4RAuxM+q+9Pax0LsTRk+Rz7xNcMiUu6g80Isw
         iwQw==
X-Forwarded-Encrypted: i=1; AJvYcCVQDXiQVbM5qgnfCw0owQfy6L89Al5e37OqIkg1d/I1QLDk9iygi9jtmcyfjetTxsyOzOpc4TmtvJ6wYu1HC3emNSGJdnpFJMSIKYbX
X-Gm-Message-State: AOJu0YxiL89C3HUBIraPggfw9EWIjynAwTMg6tLb56fBd+8oYeC/Z0aH
	r14l+q6nhbjsmkdqjdrOq3PuxwzSHxDmCVzlhaoAiIgyruBqoE2SOkgSjqZEArGJbMwDyRsH+2o
	=
X-Google-Smtp-Source: AGHT+IEWH4p6fuMMLnK6na1ZWmPf9/wwRZOAN0awgVU7knFxD5r+emzTIj6C0AA3aIaZu4JKdICizA==
X-Received: by 2002:a05:620a:4481:b0:792:ec90:b1f9 with SMTP id af79cd13be357-792ec90b5d2mr1393475285a.73.1715976129012;
        Fri, 17 May 2024 13:02:09 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf33b16dsm931839785a.127.2024.05.17.13.02.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 13:02:07 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so97251cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:02:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeXQ1EUllA69L0Mn5nW8paNyqVcZRq0JkuCnaHABq6wk8E6LD8s/gjRhk/zT7Sgr27tocYV5IJSTKABVBiyo8NlZvYRyVimMI7it4i
X-Received: by 2002:a05:622a:488e:b0:43d:fd4c:2ec7 with SMTP id
 d75a77b69052e-43f796ee600mr579861cf.8.1715976126793; Fri, 17 May 2024
 13:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240412135513.GA28004@willie-the-truck>
In-Reply-To: <20240412135513.GA28004@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 May 2024 13:01:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
Message-ID: <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 6:55=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> I'm doing some inbox Spring cleaning!

No worries. I got your reply while I was on a bunch of business travel
and finally cleared stuff out enough to take a look again. ;-)


> On Thu, Dec 07, 2023 at 05:02:56PM -0800, Douglas Anderson wrote:
> > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > disabled, I found that the stack crawls printed to the serial console
> > ended up as a jumbled mess. After rebooting, the pstore-based console
> > looked fine though. Also, enabling kgdb to trap the panic made the
> > console look fine and avoided the mess.
> >
> > After a bit of tracking down, I came to the conclusion that this was
> > what was happening:
> > 1. The panic path was stopping all other CPUs with
> >    panic_other_cpus_shutdown().
> > 2. At least one of those other CPUs was in the middle of printing to
> >    the serial console and holding the console port's lock, which is
> >    grabbed with "irqsave". ...but since we were stopping with an NMI
> >    we didn't care about the "irqsave" and interrupted anyway.
> > 3. Since we stopped the CPU while it was holding the lock it would
> >    never release it.
> > 4. All future calls to output to the console would end up failing to
> >    get the lock in qcom_geni_serial_console_write(). This isn't
> >    _totally_ unexpected at panic time but it's a code path that's not
> >    well tested, hard to get right, and apparently doesn't work
> >    terribly well on the Qualcomm geni serial driver.
> >
> > It would probably be a reasonable idea to try to make the Qualcomm
> > geni serial driver work better, but also it's nice not to get into
> > this situation in the first place.
> >
> > Taking a page from what x86 appears to do in native_stop_other_cpus(),
> > let's do this:
> > 1. First, we'll try to stop other CPUs with a normal IPI and wait a
> >    second. This gives them a chance to leave critical sections.
> > 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
> >    lower timeout since there's no good reason for a CPU not to react
> >    quickly to a NMI.
> >
> > This works well and avoids the corrupted console and (presumably)
> > could help avoid other similar issues.
> >
> > In order to do this, we need to do a little re-organization of our
> > IPIs since we don't have any more free IDs. We'll do what was
> > suggested in previous conversations and combine "stop" and "crash
> > stop". That frees up an IPI so now we can have a "stop" and "stop
> > NMI".
> >
> > In order to do this we also need a slight change in the way we keep
> > track of which CPUs still need to be stopped. We need to know
> > specifically which CPUs haven't stopped yet when we fall back to NMI
> > but in the "crash stop" case the "cpu_online_mask" isn't updated as
> > CPUs go down. This is why that code path had an atomic of the number
> > of CPUs left. We'll solve this by making the cpumask into a
> > global. This has a potential memory implication--with NR_CPUs =3D 4096
> > this is 4096/8 =3D 512 bytes of globals. On the upside in that same cas=
e
> > we take 512 bytes off the stack which could potentially have made the
> > stop code less reliable. It can be noted that the NMI backtrace code
> > (lib/nmi_backtrace.c) uses the same approach and that use also
> > confirms that updating the mask is safe from NMI.
>
> Updating the global masks without any synchronisation feels broken though=
:
>
> > @@ -1085,77 +1080,75 @@ void smp_send_stop(void)
> >  {
> >       unsigned long timeout;
> >
> > -     if (num_other_online_cpus()) {
> > -             cpumask_t mask;
> > +     /*
> > +      * If this cpu is the only one alive at this point in time, onlin=
e or
> > +      * not, there are no stop messages to be sent around, so just bac=
k out.
> > +      */
> > +     if (num_other_online_cpus() =3D=3D 0)
> > +             goto skip_ipi;
> >
> > -             cpumask_copy(&mask, cpu_online_mask);
> > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > +     cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
> > +     cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));
>
> I don't see what prevents multiple CPUs getting in here concurrently and
> tripping over the masks. x86 seems to avoid that with an atomic
> 'stopping_cpu' variable in native_stop_other_cpus(). Do we need something
> similar?

Good point. nmi_trigger_cpumask_backtrace(), which my code was based
on, has a test_and_set() for this and that seems simpler than the
atomic_try_cmpxchg() from the x86 code.

If we run into that case, what do you think we should do? I guess x86
just does a "return", though it feels like at least a warning should
be printed since we're not doing what the function asked us to do.
When we return there will be other CPUs running.

In theory, we could try to help the other processor along? I don't
know how much complexity to handle here and I could imagine that
testing some of the corner cases would be extremely hard. I could
imagine that this might work but maybe it's too complex?

--

void smp_send_stop(void)
{
    unsigned long timeout;
    static unsigned long stop_in_progress;

    /*
     * If this cpu is the only one alive at this point in time, online or
     * not, there are no stop messages to be sent around, so just back out.
     */
    if (num_other_online_cpus() =3D=3D 0)
        goto skip_ipi;

    /*
     * If another is already trying to stop and we're here then either the
     * other CPU hasn't sent us the IPI yet or we have interrupts disabled.
     * Let's help the other CPU by stopping ourselves.
     */
    if (test_and_set_bit(0, &stop_in_progress)) {
        /* Wait until the other inits stop_mask */
        while (!test_bit(1, &stop_in_progress)) {
            cpu_relax();
            smp_rmb();
        }
        do_handle_IPI(IPI_CPU_STOP);
    }

    cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
    cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));

    /* Indicate that we've initted stop_mask */
    set_bit(1, &stop_in_progress);
    smp_wmb();
    ...
    ...

--

Opinions?


> Apart from that, I'm fine with the gist of the patch.

Great. Ironically as I reviewed this patch with fresh eyes and looking
at the things you brought up, I also found a few issues, I'll respond
to my post myself so I have context to respond to.

One other question: what did you think about Daniel's suggestion to go
straight to NMI for crash_stop? I don't feel like I have enough
experience with crash_stop to have intuition here, but it feels like
trying IRQ first is still better in that case, but I'm happy to go
either way.

-Doug

