Return-Path: <linux-kernel+bounces-382276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266949B0BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8782F1F2996D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983920BB2D;
	Fri, 25 Oct 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRADOcL6"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E0206501
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877502; cv=none; b=JhlNv1DkHtBNiXgg3y7IpaAXAG9m/PRJqIyVXpUIhEKos6JrNTM+cry8edFC7TVO1WRo/2P846Mcic88kG0wWj1GCONMc5Csdb/fh2SPFWpNdy/1620yi9P1y/i98mR9SuJLJbrircyEBDZuFJFfl0gN0RplbG9O9d2fLm4fL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877502; c=relaxed/simple;
	bh=b0TQKcGybC/mzwFu0tTFTmoOEbCC1R+7DyEdYrzQn0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOEjzxNL6XjBQqK2aL5u0HBRgDML9BdQKT1s2Rt+no3kFi+YCLlOcSNGKJh9nmyEaz7J+OBGlkpeC7TT81nnC9N+zwqwxBCn/NbNWM5LVpZIr9ssEo1tyIKRFOgRAuHVJ0rsU55R/7QboheT/AifFhJYGvn0rz5mPD7VEgF0P2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRADOcL6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71817c40110so1212531a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729877499; x=1730482299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nFesq6fPuvktjrVX6D6kJiVuG2UTKxs3GcGzAOL5j0=;
        b=nRADOcL6/iYEi4psFDhWL14Wit1kypwfaDybJULDdxsPqaLXutwHQRQvSKz+TEdaQM
         /xikFhCGQtu8qyV9LnIEz5798/NOwnVqE39l5UVV59SzCj404XJ9yRrXp/OhKFaSlRvV
         aNVlK/iNFq0HzIPC95yFLfy1xa064KsKHmUGT3LfSiJfOKK/7zypZQ0uQICnxNLdDqog
         uSLuJQ2GXMokMn1A7ARfL4+AQx5AfBvxbWHZz6vNf/yv2cnSSpoNDDzdC0YyzsJv1ZGx
         DFCQEEHwxqlMLgOZZ/jkW3w4CJVQn0KRMNLqmujF9I+avcUiYsAVL4mtcsK18lw5qc3n
         XVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877499; x=1730482299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nFesq6fPuvktjrVX6D6kJiVuG2UTKxs3GcGzAOL5j0=;
        b=SzI9M/xAYtgE2g2u4Apcirv5kYPpFkR0JMbL1TFOfG8Jl1IpX9nGQ4PH/3HW5HQhaq
         WOcdcjiKxs+irC9f8Pk3wwHzI6drg7GetGBXZ5oQhckTllLHjQp0eZghqlLBMMVY+rFk
         zWha4DeFRgKmiBiYngIE2R/unnZUbvkUGEwXuuPOq9zV/LoKm5G5Pd2WMsY5soJFfgIr
         SH3T5O8gCPBhiRZ6ddmC3eX+vcfCtmfmJc0HHr1VNP+7JLlUVg/U8zwN1FfCTW3BNzre
         8lz+7U98PW/7CzFVfdSzp36YG0kxgmy53qGxWSRPVpjL2crXFnWYKqgxKGjhwpVe+2LT
         JRug==
X-Forwarded-Encrypted: i=1; AJvYcCX9WLotZGHAZdAjxv73F7aEmsr2dLFZGwvSU/RW+YhoVL8IDIgHQ4ke3c8QsLqHDbAynlg2ZQX6V3yLlC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTDfVezyxb+k7o58HqXDUokg+T9Vd6q4d57gULRMAJzkzTwip
	gb/5mHmot8SBlG2lUKv+vLa38eCpDN2qmxaNebAZ22W1WE6hVEXVjVYH+HinBdneYkMQZlP6G65
	5PYSFYfcFM1ry4cJbgLSbePbkk7aj/W4Z+F6k
X-Google-Smtp-Source: AGHT+IF4WiLhU1Gd/JNblfLAXfS7pNVnnQCGhJ6THzrAm3Qyvdxiau/k0EXOnmxa65gTsETP/x7JeKI91bH/3f56v+M=
X-Received: by 2002:a05:6830:2814:b0:718:18d6:a464 with SMTP id
 46e09a7af769-71867f11dfemr438530a34.5.1729877498557; Fri, 25 Oct 2024
 10:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com> <20241021042218.746659-4-yuzhao@google.com>
 <86a5ew41tp.wl-maz@kernel.org> <CAOUHufanq2_nbNiU_=mCgWufoSGDOS3EpAz+4xB5kB=PV2ECVA@mail.gmail.com>
 <86h6902m7y.wl-maz@kernel.org>
In-Reply-To: <86h6902m7y.wl-maz@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 25 Oct 2024 11:31:01 -0600
Message-ID: <CAOUHufbEadyAn0WVdJqYKkUjvMfGXXiLjaApjhaHKg93P8Rymg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] irqchip/gic-v3: support SGI broadcast
To: Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Muchun Song <muchun.song@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Fri, 25 Oct 2024 06:07:45 +0100,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > Hi Marc,
> >
> > On Tue, Oct 22, 2024 at 9:03=E2=80=AFAM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On Mon, 21 Oct 2024 05:22:15 +0100,
> > > Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > @@ -1407,6 +1418,13 @@ static void gic_ipi_send_mask(struct irq_dat=
a *d, const struct cpumask *mask)
> > > >        */
> > > >       dsb(ishst);
> > > >
> > > > +     cpumask_copy(&broadcast, cpu_present_mask);
> > >
> > > Why cpu_present_mask? I'd expect that cpu_online_mask should be the
> > > correct mask to use -- we don't IPI offline CPUs, in general.
> >
> > This is exactly because "we don't IPI offline CPUs, in general",
> > assuming "we" means the kernel, not GIC.
> >
> > My interpretation of what the GIC spec says ("0b1: Interrupts routed
> > to all PEs in the system, excluding self") is that it broadcasts IPIs t=
o
> > "cpu_present_mask" (minus the local one). So if the kernel uses
> > "cpu_online_mask" here, GIC would send IPIs to offline CPUs
> > (cpu_present_mask ^ cpu_online_mask), which I don't know whether it's
> > a defined behavior.

Thanks for clarifying.

> Offline CPUs are not known to the kernel.

I assume it wouldn't matter to firmware either, correct? IOW, we
wouldn't cause firmware any trouble by letting GIC send IPIs to
(cpu_present_mask ^ cpu_online_mask), assuming those two masks can be
different on arm64 when hotplug is enabled?

> Most likely, they are either
> powered off, or spending quality time in Secure or Realm mode. Either
> way, this is none of our business.
>
> Your approach would make also the kernel perform pretty inconsistently
> depending on whether CPUs are offline and not.
>
> >
> > But if you actually meant GIC doesn't IPI offline CPUs, then yes, here
> > the kernel should use "cpu_online_mask".
> >
> > > > +     cpumask_clear_cpu(smp_processor_id(), &broadcast);
> > > > +     if (cpumask_equal(&broadcast, mask)) {
> > > > +             gic_broadcast_sgi(d->hwirq);
> > > > +             goto done;
> > > > +     }
> > >
> > > So the (valid) case where you would IPI *everyone* is not handled as =
a
> > > fast path? That seems a missed opportunity.
> >
> > You are right: it should handle that case.
> >
> > > This also seem an like expensive way to do it. How about something
> > > like:
> > >
> > >         int mcnt =3D cpumask_weight(mask);
> > >         int ocnt =3D cpumask_weight(cpu_online_mask);
> > >         if (mcnt =3D=3D ocnt)  {
> > >                 /* Broadcast to all CPUs including self */
> >
> > Does the comment mean the following two steps?
> > 1. Broadcasting to everyone else.
> > 2. Sending to self.
>
> Correct.
>
> > My understanding of the "Interrupt Routing Mode" is that it can't
> > broadcast to all CPUs including self, and therefore we need the above
> > two steps, which still can be a lot faster. Is my understanding
> > correct?
>
> Yes.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

