Return-Path: <linux-kernel+bounces-254585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC49334F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43BB1F23039
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C615A8;
	Wed, 17 Jul 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bqksX25A"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01BED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179215; cv=none; b=HWJKOlArmx6h7pNlMa8YKMMWNGJER8IQmfDWunw7kONm3E6eVIMNucrxES95PyJgYKpwM+wSO1bw0yW9dbfP055DcRBXiTsnkFEoLp+/09sOjQBsIUhz1nsJmlItd2t8b/AOid2xl1V9shrwhC4V1UKNLU03fWunMmeBWISi7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179215; c=relaxed/simple;
	bh=4VgwmtM8frgS8sVFioP0nQSmF3YtWOPOYXh3fIIRvGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhmeswMSS9voY56GxXIE2p7fW+7EuMHl4W15U6+s8MDVdPeDuyOVCD/YH6XXtA3aw1tbVUVF6gR2u9tfpXPdiLQjTZsMd3pAg1ZNgV3SWaLxSS9634aBFpK6SNccRoHwLJIC8IPgPx5H90wXmD7v0OeCmNV8P5xCVBNvMMoLsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bqksX25A; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b9794dad09so217857eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721179213; x=1721784013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nWt97Wp1ilQQ7306SFKA4eqa96SFpHMWiUAQ0dXXdU=;
        b=bqksX25A681XbLBuc7FT/K/UB8OHrZoMc6nkXzgXcND6rcAwBhHysxIoXFnE9qyF1/
         bk82GglHOjCiAGPFrJd33RiJJgdWy4mU3oLpPZFD5n6ITE11BHv8J37Skr8AgBhMUtkh
         Y/nt1/acoGojQ+KrtqzpFzNEGOU/audqbANj+PFzlIuqPIb4tVhtKAwm2OR2G0shtrnc
         3m3luSTmflAGtAPRKCwj8uSLJxJaFgLgy6E85TUlliMngB7zvlcnizx2qQPNdzrllXOg
         dKBfEH9CXTcct7L6pt7/NmZPzKTRkt1px5BJNPf4B7XtPLDfn8qcbFbKm9MWBtz2SLeR
         bqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179213; x=1721784013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nWt97Wp1ilQQ7306SFKA4eqa96SFpHMWiUAQ0dXXdU=;
        b=frtNt7/E2b9qj6id45LqLttyG3UFtuAyLvsiMJfegftrqsmnrWBG1Jm7usQpIx/Trv
         ML5w0hY8fsmn2ogCVIHYg8gZzJ/lMUKjgL/T6A8M24RwF/oFrGs4s6OdjML2k/Wx2kK2
         E3lMlmRh6tSOkL/951o8Y7tbMVlkGFZcMiVsvFe9uDm7VoA2LlvfcwhfeDb5f/IMfLUK
         k41UZst3QyaESRN6y6QDLWFtDk1IZP4InBELEBuz5Bxd6a4spuRAnReKvMe34VE07c5l
         FCh3gzt/eapxXnPaYNOSxOSJbCGds3HPy+yuX7fhC+Q4/E4TlJZ6GLw+7J9kewgXfuE3
         A9tw==
X-Forwarded-Encrypted: i=1; AJvYcCXEZvOPqdjVOzlBn8dSGIIcN1jDJbSQ7NKV+m2tSWtKHl7tnYE3xDqMUPuTjgvmDumpV+PCT20orGBT9OOWr6UVEjOhDpGsR775sgqr
X-Gm-Message-State: AOJu0YxEur6M2D2gR4UT5nXDLBdIzrgpTsZ+AK+z7DpVtUiH3xMP3y+l
	N8qFxnpDZCo0DFU0A53vgR1wMevwERtAvxAOflXtfODpQvP9TAOFpQ9vbs4dXNoB3WH+UEwtWu7
	hMnTsHcNUSEO/R8B8dQtJPcNIooVqvL3plHv4vg==
X-Google-Smtp-Source: AGHT+IEdqlnLhH1SU4NcfSupxzMGDotYQmQJspVQzJ54YXo8sjG+54XN8uSiJk9j88aDuSknwc/Vf7SWxf/zLjPIw60=
X-Received: by 2002:a05:6820:198a:b0:5c4:2c2a:2358 with SMTP id
 006d021491bc7-5d41c9e3c87mr404796eaf.6.1721179213034; Tue, 16 Jul 2024
 18:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716090521.1752166-1-nick.hu@sifive.com> <CAAhSdy1pjg=etzNNu-E+-VDmU5gLkS2jYhdO29pPN23OQ5=NiA@mail.gmail.com>
In-Reply-To: <CAAhSdy1pjg=etzNNu-E+-VDmU5gLkS2jYhdO29pPN23OQ5=NiA@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Wed, 17 Jul 2024 09:20:01 +0800
Message-ID: <CAKddAkB7r59sazmksi491Ubn0A-2C=Qhg=00thOSN=ZWzoVqjQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable the IPI before workqueue_online_cpu()
To: Anup Patel <anup@brainfault.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, peterz@infradead.org, samuel.holland@sifive.com, 
	tj@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

On Tue, Jul 16, 2024 at 6:51=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Jul 16, 2024 at 2:35=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Sometimes the hotplug cpu stalls at the arch_cpu_idle() for a while aft=
er
> > workqueue_online_cpu(). When cpu stalls at the idle loop, the reschedul=
e
> > IPI is pending. However the enable bit is not enabled yet so the cpu st=
alls
> > at WFI until watchdog timeout. Therefore enable the IPI before the
> > workqueue_online_cpu() to fix the issue.
> >
> > Fixes: 63c5484e7495 ("workqueue: Add multiple affinity scopes and inter=
face to select them")
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  arch/riscv/kernel/sbi-ipi.c | 2 +-
> >  include/linux/cpuhotplug.h  | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> > index 1026e22955cc..e05e68de8871 100644
> > --- a/arch/riscv/kernel/sbi-ipi.c
> > +++ b/arch/riscv/kernel/sbi-ipi.c
> > @@ -71,7 +71,7 @@ void __init sbi_ipi_init(void)
> >          * the masking/unmasking of virtual IPIs is done
> >          * via generic IPI-Mux
> >          */
> > -       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +       cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SWINT_STARTING,
> >                           "irqchip/sbi-ipi:starting",
> >                           sbi_ipi_starting_cpu, NULL);
> >
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 7a5785f405b6..57dcf1229b27 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -147,6 +147,7 @@ enum cpuhp_state {
> >         CPUHP_AP_IRQ_LOONGARCH_STARTING,
> >         CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> >         CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
> > +       CPUHP_AP_IRQ_RISCV_SWINT_STARTING,
>
> This is a misleading name.
>
> I suggest s/_RISCV_SWINT_/_RISCV_SBI_IPI_/ .
>
Good point.
I'll update it in the next version.
Thank you for the feedback.

> >        CPUHP_AP_ARM_MVEBU_COHERENCY,
> >         CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
> >         CPUHP_AP_PERF_X86_STARTING,
> > --
> > 2.34.1
> >
>
> Regards,
> Anup

Regards,
Nick

