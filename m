Return-Path: <linux-kernel+bounces-433866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCF9E5E24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF53316C21F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665B22579A;
	Thu,  5 Dec 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpR0qJXd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7EtO0shr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577A21C199
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422679; cv=none; b=CKzxhwAhy2PCfspALD17ZgH4QfEUBXi09U8NkEidmqgKyQ7hzaJr44chc/MYTRL4qHzbsOTCFdGaqDqvXiSTcmjYnoinFFVNx2xicELHI+/eKjDXAK0zrqDyGwqW76NPGxVIVo3S3Q18PQpsVFC1XI5mLeksrtvfPBTD++ZgoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422679; c=relaxed/simple;
	bh=Sbz1HdnWrG52mn7fk/0C4b7W6Hgys09QDVvlLZc3OK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfLY6iLQ3rOuUpfLfzz1L9KhkYbp5JE97ES4EL6RBCw3NU9onv63Ngdnajo5MVL7N73DbaOxwtx5jkB7aCdcLE4GcRHfXhtWv1ctUITQ2gXavpdbIRkwUuU9kKPFnniRHm8zpQpwVzHCBrXizpwQkgdre0YP7ev/u93wHSG0TQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpR0qJXd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7EtO0shr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733422676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe9HmKVw+cCN0/uJAO9hlVMWTEHr4VX4xPDeEyVzNc=;
	b=bpR0qJXdfzFbRg58jngBW4yjAk9bGyV9NrHvf/JBq+AFZdD9adK5DZhvjKyFIVySdgPHPu
	yIhdQHGNpRju91MCozgBzLf1npOKLgajpgGGBRTyQB4Bigm8pYaQheksnVIsD4oR3CUhaf
	WE1kvJ00mkDPDyQ9p+KERKjIAStp4nBtY+8vhS0gxJ9o2HQZXAuMOdMiHEiNBomEGWbJe6
	5iB23wefb+Fiqz8lpgx5cllPeE8TsVSOjxvr3cpT+Ov7aeS+9hZR/dB1vhxMG8KLo46lI1
	knPBgnAmSbU+XMbvg34ROoXv+EqL1lpJkASrLCeJxZqRbdJufpw2McckolDMXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733422676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe9HmKVw+cCN0/uJAO9hlVMWTEHr4VX4xPDeEyVzNc=;
	b=7EtO0shrfMHJMF23jRgSahPmuaRkzNrNRhI6a4T9prQ1zEmNZxeFDi+NgRPjzH+XtoGo+/
	Ka8pWQQABwFlhnDg==
To: Waiman Long <llong@redhat.com>, Waiman Long <llong@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
In-Reply-To: <1166fd72-8a4a-489f-9de5-7c06b70b0ad4@redhat.com>
References: <20241203150732.182065-1-longman@redhat.com>
 <87h67jsif0.ffs@tglx> <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com>
 <87zflbqqar.ffs@tglx> <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
 <9765a61a-e832-4491-af02-97b8736411ef@redhat.com> <87r06mqnnv.ffs@tglx>
 <1166fd72-8a4a-489f-9de5-7c06b70b0ad4@redhat.com>
Date: Thu, 05 Dec 2024 19:17:55 +0100
Message-ID: <87ikryq9ik.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05 2024 at 08:22, Waiman Long wrote:
> On 12/5/24 8:12 AM, Thomas Gleixner wrote:
>>> Actually, crash_nmi_callback() can return in the case of the crashing
>>> CPUs, though all the other CPUs will not return once called. So I
>>> believe the current form is correct. I will update the comment to
>>> reflect that.
>> Why would you continue servicing the NMI on a CPU which just crashed?
>
> According to crash_nmi_callback(),
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't do anything if =
this handler is invoked on crashing cpu.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, system wil=
l completely hang. Crashing cpu can get
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * an NMI if system was =
initially booted with nmi_watchdog=20
> parameter.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu =3D=3D crashing_cpu)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return NMI_HANDLED;
>
> The crashing CPU still has work to do after shutting down other CPUs. It=
=20
> can't wait there forever without completing other crashing actions. The=20
> only thing I can see we can do is to return immediately without=20
> servicing other less important nmi handlers in the list.

I understand that, but in case that the crashed CPU receives an NMI and
sees that the emergency handler is set, shouldn't it stop the NMI
processing instead of trying to go through perf and what not when the
system is already in a fragile state. i.e.:

       if (emergemcy_handler) {
          emergency_handler();
          return;
       }

Thanks,

        tglx

