Return-Path: <linux-kernel+bounces-229789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D791742F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11A31C227A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9C17F37F;
	Tue, 25 Jun 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhL7dmli"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66E17E44D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354136; cv=none; b=ACck7ZobYZf1GtJfyPfdHGJCEa2eLTUOF2Wlt7gbCcVd41gicOrianwvsEMfxApi/JyaI1+VM/GhiZ4drrWWy4XLFvhGmuAS1UUNZahTE+2CQXrUK1029md1OyUzdlhsDPtaoMueL6y8feH2Kg1v6oqsXowLDC0PKcELa7dtezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354136; c=relaxed/simple;
	bh=CT+sk2Ytt9MGpByyhaQ7wR0eTG6aV5txV6U0a2SQdQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3wyXy6Tw3wGKSEhKfriL+d9PkEXaVXIPx8Hde3HejhTTcKfmXFsNt5ZAPjOn+1TQnIrr9zK6+BVCnkgrLwaicxqN55bQtBgbahOWGeQDTCulHA3cTDQ8kMTbA6Ncrz/J7R8jPp2s7aYeSi3Rzadi772XUIVdIkVC8Wg5IQSdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhL7dmli; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so13495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719354133; x=1719958933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRw32GwIVEPX+VKGt7keuELHgLE2OAFARiZsfNjEDuM=;
        b=YhL7dmliA9bsLxRYtPUyPr/R9gx73OjgzP9SxhY5EpKGpZ/iKor9erdy6rkyUrn8j4
         KgCKR3/rpXghyNMIRuePtILgrz5JgUafgJtGTU9KeJkpteSILeZ9NBNa/bd6r0d8HVP9
         Ewh+wo8QgOJcn57NJYMraEC2DQHk1ZOx3QUkzHIn6/ulloKz4EaKTp22ReyiLeKPGNU3
         zEtinonvtF7RLpbGsylAZ8YQNR1OaDi90SpiYLtRTmUToD3mbfYZqo6NSkP4gCPVmB9V
         ZScQ18/EjN9kcs3I8vu1mv6Nn0ibPWQ3SPt3Vlrizw2uXeMNY4NzV70Di69rPUavH38U
         PS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719354133; x=1719958933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRw32GwIVEPX+VKGt7keuELHgLE2OAFARiZsfNjEDuM=;
        b=QeArJ8rWbYwfX1ZzUWIeWC1NItr7pLpz/c595KxDX3LckH4Y4qpQrTVr1K7c/ss5Rk
         /j+qqvZcfnKDgh+e/+l2iT0/hzyr5VzLB0V/gkhJIThOr8YmgBLG8I4zK0yDyBOGQ+Ds
         uhZvNeDw6WUVIYrcN+VO/GauahqH6Mk/EAX+CJZq16OMXaxoUov0XrUtlOnn4u4QgPT1
         v9Hzqbx5wcX/gm71+gjZNvj4Q38zR6btg2Oj6iVl+/2c05aYfFy2Ml8r30PlTJze5avW
         IK/zKJOCHQsK+VNhQE8kHxjyFxLG2gqIp2Mz4CHmSzt6Nr3IkTowqC8gquXmSoa+p+o1
         VAkA==
X-Forwarded-Encrypted: i=1; AJvYcCVMlpOQM6afmtHcjjQalBYeOtJCclcphQF4TE8/pU4sjQew0ef1xENreucUgtttSKWbFZR3PID44LF+xfueY9C5W29xXnUjg9eskN8n
X-Gm-Message-State: AOJu0Ywq0q8byugNF4M9fLVEnp384UWLbbdk4ENdOfyhYJ4HNToa/10g
	SLEz99xeIi+ebiZyAEhCTcPXQ308nLb+6yXxAtUGgrA+TdSkPaRIHMQlQl7CgkiAhtd+LTdJwiL
	91K7dQ6OPkevzJUp9Pg+OzTrxNEI9gpV8GQs=
X-Google-Smtp-Source: AGHT+IF0XX6TI9w/czvpBi7HzAI1d8YJKNGlvcJv6XfswT2Wl99IeE6v4pHQbFEkTmScbB2O/MYGYLKXqh0Ft2bqS7Q=
X-Received: by 2002:a05:600c:6792:b0:424:8b0c:156a with SMTP id
 5b1f17b1804b1-424e5a8f63amr147125e9.2.1719354133301; Tue, 25 Jun 2024
 15:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzic4sgv.ffs@tglx> <ea7c5eda8180904a6caf476c56973a06bd4b5e78.camel@infradead.org>
In-Reply-To: <ea7c5eda8180904a6caf476c56973a06bd4b5e78.camel@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 25 Jun 2024 15:22:00 -0700
Message-ID: <CANDhNCpi_MyGWH2jZcSRB4RU28Ga08Cqm8cyY_6wkZhNMJsNSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptp: Add vDSO-style vmclock support
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Hilber <peter.hilber@opensynergy.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev, 
	"Luu, Ryan" <rluu@amazon.com>, "Christopher S. Hall" <christopher.s.hall@intel.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 2:48=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> On Tue, 2024-06-25 at 23:34 +0200, Thomas Gleixner wrote:
> > On Tue, Jun 25 2024 at 20:01, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > The vmclock "device" provides a shared memory region with precision c=
lock
> > > information. By using shared memory, it is safe across Live Migration=
.
> > >
> > > Like the KVM PTP clock, this can convert TSC-based cross timestamps i=
nto
> > > KVM clock values. Unlike the KVM PTP clock, it does so only when such=
 is
> > > actually helpful.
> > >
> > > The memory region of the device is also exposed to userspace so it ca=
n be
> > > read or memory mapped by application which need reliable notification=
 of
> > > clock disruptions.
> >
> > There is effort underway to expose PTP clocks to user space via VDSO.
>
> Ooh, interesting. Got a reference to that please?
>
> >  Can we please not expose an ad hoc interface for that?
>
> Absolutely. I'm explicitly trying to intercept the virtio-rtc
> specification here, to *avoid* having to do anything ad hoc.
>
> Note that this is a "vDSO-style" interface from hypervisor to guest via
> a shared memory region, not necessarily an actual vDSO.
>
> But yes, it *is* intended to be exposed to userspace, so that userspace
> can know the *accurate* time without a system call, and know that it
> hasn't been perturbed by live migration.

Yea, I was going to raise a concern that just defining an mmaped
structure means it has to trust the guest logic is as expected. It's
good that it's versioned! :)

I'd fret a bit about exposing this to userland. It feels very similar
to the old powerpc systemcfg implementation that similarly mapped just
kernel data out to userland and was difficult to maintain as changes
were made. Would including a code page like a proper vdso make sense
to make this more flexible of an UABI to maintain?

thanks
-john

