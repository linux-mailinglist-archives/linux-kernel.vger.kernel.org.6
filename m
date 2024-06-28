Return-Path: <linux-kernel+bounces-233888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9891BEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB191F219EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C315885D;
	Fri, 28 Jun 2024 12:40:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670E156967
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578445; cv=none; b=H1q4o6vTgczpArMF/Xqv43Frl/qFB8OjPh8h70asXPHN+aO5EX6+jKTcLj00H23NyM6kEBMaEebqlh/bXx9fMM71kmUgvHCikfB+mlym7majzyLQgqZnxyCwkt77hf3hP463E8EEPpzcI5mmLpskd1nW5jGI8mhE2PzqLGCcwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578445; c=relaxed/simple;
	bh=k+tHhvsXLqC0pkWc1z2zD5HL9oEtyeNTJH18mQOk0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejYrpfa+jjt4jAw7WczUwo7Wo+mCAAJ8fLyaDi2nZc34/mRL+GGbl8XDmrorhfaUqrk0FUmhxLf3AVXurixmSMEamhseJJ/Gadg4PcZmAaWOk08lHN+Bi8gqHa2GRFQcnEjNdWvAldPfJuZ8pv3Oyn44zVTUYgKlKgEIr6K9eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E85C116B1;
	Fri, 28 Jun 2024 12:40:44 +0000 (UTC)
Date: Fri, 28 Jun 2024 08:41:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 will@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
Message-ID: <20240628084137.3338ab75@gandalf.local.home>
In-Reply-To: <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com>
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
	<86pls2isal.wl-maz@kernel.org>
	<20240627101207.0bbbead0@rorschach.local.home>
	<CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jun 2024 18:21:25 +0800
richard clark <richard.xnu.clark@gmail.com> wrote:

> Hi Steven,
>=20
> On Thu, Jun 27, 2024 at 10:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > On Thu, 27 Jun 2024 11:38:58 +0100
> > Marc Zyngier <maz@kernel.org> wrote:
> > =20
> > > You may want to enable stack trace recording and find out for yourself
> > > where these ipi_raise() calls are coming from. =20
> >
> > Try trace-cmd:
> >
> >   # trace-cmd start -e ipi_raise -R 'stacktrace if reason=3D=3D"Functio=
n call interrupts"'
> >   # taskset -c 0 insmod /kmods/ipi_test.ko
> >   # trace-cmd stop
> >   # trace-cmd show
> > =20
> I found that the 'stacktrace' seems like a stick bit. Run the above
> '# trace-cmd start -e ipi_raise -R 'stacktrace if reason=3D=3D"Function
> call interrupts"' ... command sequence, then
> # trace-cmd start -e ipi -f 'reason=3D=3D"Function call interrupts"' -v -e
> ipi_exit; taskset -c 0 insmod /kmods/ipi_lat.ko; trace-cmd stop;
> trace-cmd show; trace-cmd clear;
> The output is:
>=20
>           insmod-1746    [000] dn.h1..   928.400039: ipi_raise:
> target_mask=3D00000000,000000ffe (Function call interrupts)
>           insmod-1746    [000] dn.h2..   928.400042: <stack trace>
>  =3D> trace_event_raw_event_ipi_raise
>  =3D> smp_cross_call
>  =3D> arch_send_call_function_single_ipi
>  =3D> send_call_function_single_ipi =20
> ...
> Actually, the behavior hoped like this(no stacktrace):
>=20
>           insmod-1677    [000] ....1..   473.474846: ipi_raise:
> target_mask=3D00000000,00000ffe (Function call interrupts)
>           <idle>-0       [002] d..h1..   473.474848: ipi_entry:
> (Function call interrupts)
>           <idle>-0       [003] d..h1..   473.474849: ipi_entry:
> (Function call interrupts)
>           ...
>           insmod-1677    [000] ....1..   473.474859: ipi_raise:
> target_mask=3D00000000,00000ffe (Function call interrupts)
>           <idle>-0       [001] d..h1..   473.474861: ipi_entry:
> (Function call interrupts) magic=3D0x55aa55aa
>           ...
>=20
> I tried to add '# trace-cmd stack --stop/reset' before the above
> command, but it did not work. Any help to disable the 'stacktrace' in
> this scenario?

 trace-cmd reset

will put everything back. But yeah, I need to fix it so that it's easier to
reset triggers.

-- Steve

