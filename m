Return-Path: <linux-kernel+bounces-555789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF62A5BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B09616CE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3223313E;
	Tue, 11 Mar 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY2/avYr"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986B23099C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686775; cv=none; b=Ir27iI/WcqpFul6Wr2Z+Ye4IknclJmpvC/5z983txopv58RWfvXrjSh381nkV7dpK8ARYdiSLQKugEIC/6FoFhpLmk/szXJ17fRZMFYz514IngOKrootVhorSuNcBp8tDG5CyPCb9eQXTsA5bwnGTCcws+uijFvIivYXkzqz8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686775; c=relaxed/simple;
	bh=PzvnExVeclZawhturdwgP1KyBRl1xCU168Nte/naPwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGHSdcSA/2MpLIkXUhLwes3s9XdOmYH9fbzi2ExUf0zpZt7A+L0/wvUbru8w+qrfqmAg4yj+btFVf1+2FsZ3DIgZDFjC4AkBFDs50Ac/lMcLBV/kOyRki8mHcgQ+Bkke/2drgXsceU5Ep7/eP13AnyHNXfGFAUugGHiLGP8xmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY2/avYr; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766cb762b6so23891471cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741686772; x=1742291572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3URO7f/7RxwhBQJDiiHyGw5v1BW+aVP/nBg49VhnAzo=;
        b=jY2/avYrV2+mGZ0uXEedestytmhf70IRp43v9lKbtHEu8t9BzRpm81LbuBg+YGsswr
         mcC50oVNCh1mWYnQoZG8PAERlOXfotLmaS4gzyoz6WcSjKmiw35uyA5J+SpXV9JAb6Qx
         kDRcIOkRRPmQpyDO1l734j/QF488l2fTzfiUaT2TeuMSLUYxFgxHsR4MNF6pu4ybBScf
         wCRtmk2utrp6OSoiGorqEeLntgkGTUpSjgGohCWFLITBLU6KDTOKnGOUc2VFnkcGLGmO
         W1bn8fGiXUObzPnpcWBBXRqKBIXwNRGPpj6ZVwV7D2MkVSsGCcoKBwnovWU4p0jmw5vV
         JeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686772; x=1742291572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3URO7f/7RxwhBQJDiiHyGw5v1BW+aVP/nBg49VhnAzo=;
        b=PmSnsbTXIknUsL1c9VXMvrmL4PN/IvnGj2shJCkxwL4IDSILUzSLOWpRelUdgsvjrQ
         ZcnSv8iGfhURu18NXeDESHAFnEXK7kHLCLSFXZ6iiTqnB62306ivZQWn+xpB6cuszJFZ
         aD4yFf1lK7bcRxDGcP+zaZD6nh5Pw6I+TmBjDAgsEVnD36D92DnJq7XMTZLlaM6HA4wW
         mMuSmANjnBhDzUyCJdUL0CHFc0MHNxrXaAvz2TL+d4EOE5WfBoQMzAxE5bLi3gPZmoby
         i2SqjneJpEXtqefv7d7jQI8PEZXEUJvMlfsn9mI7mqRwdVrmfq964vwyYWocMRsrx29H
         a9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWdDHDcM4sZIG2ld0fCpZVluo5YnAmH/dkhlZFEhdDCvVJoodWvkXr5ZNaaHUiYoDVB1MmB6fwSgFRKLUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZNBaWOhNJWKnvHK3O7UCl/6qw/CqJF+OLMEgN+BlTtbdmJKu
	gpFMvEwhc1/xExXzhJ4doU9GRxJBw9y1qzPd6lsMJmu2LGoxKSFyNcZhtwE6/sfmnblgGopf4kn
	dnGBVXteq6KEhunvMk+/aZmTrDhnh0/R/VtfP
X-Gm-Gg: ASbGncuXOk/lsw3jh2KcEFAwcZL9GnvpG6F6div9HrgImSffYYOk4kb7J/mGEI83fAD
	ih0j7aOMhx7rBpG2aAllrQYaB6zcVbXPhcdeM6MSdONOY4L61TcKxTn25gn6mjmehqaLyH64mMy
	4lGxCVdFhvY1Zrf2y7NrVlhHGyp9dVJf9mBwubDvC/ZX2UjzLHvEVzPNc=
X-Google-Smtp-Source: AGHT+IGvkIV7kvsc8sRS2vRdLXLUngDVLR8DR1HhCv157Dg0/gmJMroFmtbmkC938Jg8g6kyBu5GXlldCdH3TAPj8kA=
X-Received: by 2002:a05:622a:438b:b0:474:e1bd:98bf with SMTP id
 d75a77b69052e-47699cc4a03mr31370311cf.0.1741686772316; Tue, 11 Mar 2025
 02:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx> <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx> <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx> <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
 <878qpg4o4t.ffs@tglx>
In-Reply-To: <878qpg4o4t.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Tue, 11 Mar 2025 17:52:41 +0800
X-Gm-Features: AQ5f1Jp7DLsnDP8MQzv4y4td2mrUyuPizgf041_oeGz1yu8HrJHsJfpTaDIVqdk
Message-ID: <CAK7fddBSJk61h2t73Ly9gxNX22cGAF46kAP+A2T5BU8VKENceQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant <achant@google.com>, 
	Brian Norris <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Running some basic tests with this patch (
https://tglx.de/~tglx/patches.tar ) applied on my device, at first
glance, the affinity feature is working.

I didn't run stress test to test the stability, and the Kernel version
we used is a bit old, so I only applied change in this 2 patches

-> Subject: genirq: Add interrupt redirection infrastructure
-> Subject: PCI: dwc: Enable MSI affinity support

And adding if check on irq_chip_redirect_set_affinity() and
irq_set_redirect_target() to avoid cpumask_first() return nr_cpu_ids

int irq_chip_redirect_set_affinity(struct irq_data *data, const struct
cpumask *dest, bool force) {
     ....
     ....
     if (target >=3D nr_cpu_ids)
          target =3D smp_processor_id();
     irq_data_update_effective_affinity(data, cpumask_of(target));
}

static void irq_set_redirect_target(struct irq_desc *desc)
{
    const struct cpumask *m =3D
irq_data_get_effective_affinity_mask(&desc->irq_data);
    unsigned int cpu =3D cpumask_first(m);

    if (cpu >=3D nr_cpu_ids)
       cpu =3D smp_processor_id();

    WRITE_ONCE(desc->redirect.target_cpu, cpu);
}

May I ask, would this patch be officially added to the 6.14 kernel ?

Thanks

On Sat, Mar 8, 2025 at 3:49=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Fri, Mar 07 2025 at 19:10, Tsai Sung-Fu wrote:
> > Thanks for your detailed explanation and feedback, I am a bit confused =
about the
> > #4 you mentioned here ->
> >
> >>     4) Affinity of the demultiplex interrupt
> >
> > Are you saying there is a chance to queue this demultiplexing IRQ event
> > to the current running CPU ?
>
> The demultiplexing interrupt (currently a chained handler, which is
> hidden from /proc/irq/) stays at the affinity which the kernel decided
> to assign to it at startup. That means it can't be steered to a
> particual CPU and nobody knows to which CPU it is affine. You can only
> guess it from /proc/interrupts by observing where the associated
> demultiplex interrupts are affine to.
>
> So ideally you want to be able to affine the demultiplexing interrupt
> too. That requires to switch it to a regular interrupt for
> simplicity. We could expose those hidden chained handlers affinity too,
> but that needs some surgery vs. locking etc.
>
> > And that's really an approach worth to try, I will work on it.
>
> I've played with this on top of variant of Marc's changes to use MSI
> parent interrupts for such controllers too:
>
>   https://lore.kernel.org/all/20241204124549.607054-1-maz@kernel.org/
>
> A completely untested and largely uncompiled preview is here:
>
>      https://tglx.de/~tglx/patches.tar
>
> The MSI parent parts are in flux. Marc will look at them in the next
> weeks, but I picked them up because it simplifies the whole business a
> lot. If you find bugs in that series, you can keep them :)
>
> Thanks,
>
>         tglx

