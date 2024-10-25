Return-Path: <linux-kernel+bounces-381013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F269AF916
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D38B21ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591F18D626;
	Fri, 25 Oct 2024 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgCbSu0m"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CD22B641
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832906; cv=none; b=Y8KbKp9VgfzYy7uiq/Spj9wjc2m5KYT7LGVumvjkudlbVkFTKVjs2z1AsTHwA2lcBKC9TuDOW5l6aMcGoQZju1ez/kLfROesn3thoV4Uo913roqav1MP84Rp3k0zyY50ACJrOHes9kaF5zOasJJwf810cHLoKRr3JL9BGedSjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832906; c=relaxed/simple;
	bh=mPDnpBu/qqwMsnK2bfZ85Us5LBys/P+Z1F0gtRjDH6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hve56r4pTBUMX7Vww9BjNM8srSqJk3j+XMzWKbKDiZOnOhw0zRi7CQyUOch50wiM05i7+/Muai9nk/yxWujQR5NiGbmwE1fm7/eMNnPNlibGPC1kpl4OJ+Bo/Gpaf0x99gPz1bui2e/Hz5v3C36SMv2DmlpTPmC6MJb1CiNhv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgCbSu0m; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a46d36c044so889438137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729832903; x=1730437703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfGHBHIoxV5kA8YjaOaHcL5pnxUwdfqiiPu15uVoLw0=;
        b=AgCbSu0mMEV5SF72CtZx/zZ/MpieJZTwpcmNG0dka9kSlm24lEOei8xogFKQoNGtAF
         wpjBTPP3/C//JPSjCV7YPhVdNe1gca4+Mn/qaerPzxPtrKmx2H0dRFw/EbGozDNeV+vK
         6fVdnrf1925+8tAtJ+cZI/2N6g+tJi/WDw+H8F6fYz7hAweAk2It0WRyASOblcYiVCcz
         c1D52XueOSBPknp8NqskuoUpspJlvByljqRX+U6u7aLYY+j7D8Uga+VgqQK16HmYfKVP
         FvA80nwbrIib4voGrdAF3D23MuTFMttLFzl0JXwzB0lyWyCVuexGSoVob4h8trfUwC0q
         RX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832903; x=1730437703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfGHBHIoxV5kA8YjaOaHcL5pnxUwdfqiiPu15uVoLw0=;
        b=m4/UpK9MWCT6PIl/tFVFsv1ctdrSk7VtjkBVXLsBlkyAN1aQWl6cXIWzLz/JP+usIR
         jAsg8Y6bVyJCDhWWlF2dEmiY+swGKGEX3LPhEcB15KSEhm396n62Cp3uuR8wGL1XXRZ4
         Mx/Vcg+3rTfzUkSN3rM2eXYh0PmKSmxaw9sgv0oayXVg7lCyoiNoO7w4mMRQ3teHa3AU
         NBfw949XO3wLn1nSJxxeTibMroHdtDvV0a6WfaDliX6ifVYkOvjCsIX0aUziIHve2V5V
         TRpUKe0N18LfpjIET9HDPZEvC3xPHo9V+A80qN85hKA0KzApFVZjvO5CCLzT+UzPHM4G
         Fg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9l9STfVt9LPaQbvO2b9BZuhFHBX9kps7yoaG2WFoHg1sV9VVgGHfuEkXeg7sH95sps7YlTFZjAHsd8KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6UCMtgRSF4R/A2j+F3T2AR6sUoakRYvRfhsIVoo4A6Y2lX9b
	cMfwqQY/7GD0i8vLS80O7YpXnn2NU4iS+Tpn3kLM1J6AY2d9kwXlsz+3O2UciLcdjzIze30Yran
	A+pG2EBifd66Se0CkykhUxRh4a33aeMYT60/3
X-Google-Smtp-Source: AGHT+IHUDYUoU8LFUbZ4k2PKGpA+ThkXB1QD3CSnJUZbltuRAF2DUtPp005MRVWQoU3kazWygDbzQCvItjMIBV7xf3M=
X-Received: by 2002:a05:6102:418a:b0:4a4:72f0:7937 with SMTP id
 ada2fe7eead31-4a870d306d7mr3512838137.8.1729832902928; Thu, 24 Oct 2024
 22:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com> <20241021042218.746659-4-yuzhao@google.com>
 <86a5ew41tp.wl-maz@kernel.org>
In-Reply-To: <86a5ew41tp.wl-maz@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 24 Oct 2024 23:07:45 -0600
Message-ID: <CAOUHufanq2_nbNiU_=mCgWufoSGDOS3EpAz+4xB5kB=PV2ECVA@mail.gmail.com>
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

Hi Marc,

On Tue, Oct 22, 2024 at 9:03=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 21 Oct 2024 05:22:15 +0100,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > GIC v3 and later support SGI broadcast, i.e., the mode that routes
> > interrupts to all PEs in the system excluding the local CPU.
> >
> > Supporting this mode can avoid looping through all the remote CPUs
> > when broadcasting SGIs, especially for systems with 200+ CPUs. The
> > performance improvement can be measured with the rest of this series
> > booted with "hugetlb_free_vmemmap=3Don irqchip.gicv3_pseudo_nmi=3D1":
> >
> >   cd /sys/kernel/mm/hugepages/
> >   echo 600 >hugepages-1048576kB/nr_hugepages
> >   echo 2048kB >hugepages-1048576kB/demote_size
> >   perf record -g -- bash -c "echo 600 >hugepages-1048576kB/demote"
> >
> >          gic_ipi_send_mask()  bash sys time
> > Before:  38.14%               0m10.513s
> > After:    0.20%               0m5.132s
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.=
c
> > index ce87205e3e82..42c39385e1b9 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1394,9 +1394,20 @@ static void gic_send_sgi(u64 cluster_id, u16 tli=
st, unsigned int irq)
> >       gic_write_sgi1r(val);
> >  }
> >
> > +static void gic_broadcast_sgi(unsigned int irq)
> > +{
> > +     u64 val;
> > +
> > +     val =3D BIT(ICC_SGI1R_IRQ_ROUTING_MODE_BIT) | (irq << ICC_SGI1R_S=
GI_ID_SHIFT);
>
> As picked up by the test bot, please fix the 32bit build.

Will do.

> > +
> > +     pr_devel("CPU %d: broadcasting SGI %u\n", smp_processor_id(), irq=
);
> > +     gic_write_sgi1r(val);
> > +}
> > +
> >  static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask=
 *mask)
> >  {
> >       int cpu;
> > +     cpumask_t broadcast;
> >
> >       if (WARN_ON(d->hwirq >=3D 16))
> >               return;
> > @@ -1407,6 +1418,13 @@ static void gic_ipi_send_mask(struct irq_data *d=
, const struct cpumask *mask)
> >        */
> >       dsb(ishst);
> >
> > +     cpumask_copy(&broadcast, cpu_present_mask);
>
> Why cpu_present_mask? I'd expect that cpu_online_mask should be the
> correct mask to use -- we don't IPI offline CPUs, in general.

This is exactly because "we don't IPI offline CPUs, in general",
assuming "we" means the kernel, not GIC.

My interpretation of what the GIC spec says ("0b1: Interrupts routed
to all PEs in the system, excluding self") is that it broadcasts IPIs to
"cpu_present_mask" (minus the local one). So if the kernel uses
"cpu_online_mask" here, GIC would send IPIs to offline CPUs
(cpu_present_mask ^ cpu_online_mask), which I don't know whether it's
a defined behavior.

But if you actually meant GIC doesn't IPI offline CPUs, then yes, here
the kernel should use "cpu_online_mask".

> > +     cpumask_clear_cpu(smp_processor_id(), &broadcast);
> > +     if (cpumask_equal(&broadcast, mask)) {
> > +             gic_broadcast_sgi(d->hwirq);
> > +             goto done;
> > +     }
>
> So the (valid) case where you would IPI *everyone* is not handled as a
> fast path? That seems a missed opportunity.

You are right: it should handle that case.

> This also seem an like expensive way to do it. How about something
> like:
>
>         int mcnt =3D cpumask_weight(mask);
>         int ocnt =3D cpumask_weight(cpu_online_mask);
>         if (mcnt =3D=3D ocnt)  {
>                 /* Broadcast to all CPUs including self */

Does the comment mean the following two steps?
1. Broadcasting to everyone else.
2. Sending to self.

My understanding of the "Interrupt Routing Mode" is that it can't
broadcast to all CPUs including self, and therefore we need the above
two steps, which still can be a lot faster. Is my understanding
correct?

>         } else if (mcnt =3D=3D (ocnt - 1) &&
>                    !cpumask_test_cpu(smp_processor_id(), mask)) {
>                 /* Broadcast to all but self */
>         }
>
> which avoids the copy+update_full compare.

Thank you.

