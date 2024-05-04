Return-Path: <linux-kernel+bounces-168524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9FD8BB98C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E32837AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A0613D;
	Sat,  4 May 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7JQzUgM"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1A28FD
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714802400; cv=none; b=j6ciU1ziXXNRESIhl6uc9HycbcRsLhAQEUttGa1EjCLczRJIO55tKyQAWiA/F2VaqwmYU+cWPyT1nLY6VsTlV5hmSQKhmKaQZfLlvTHfJX7r0Z1NLB9gMPTqGJAyF/NVdnpdSr9rB3iUXAn4WNIjXeSPi4Pv+1q51J8qzLSWa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714802400; c=relaxed/simple;
	bh=SbdFdjFhFvN8AoQXproeaoaxltpuBUXf+3bSRn6+OTw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/I+vSJ7jjHMRI4kyMB8hkUmL7lqeqYMHwEswL41V7//mbXaAQ6gIBpZjBmPfVjASd5gcxetcBsYWSewpjeaLpVziIEMNLJ1aO9vQ9Zo7+2tgqKyxIkCLsy/ZfjQOk1RkpTBEmMShl7g1R5553czJ1L+433uF4wWRlh4bkMKlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m7JQzUgM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b782287f9so1985176d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 22:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714802398; x=1715407198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYUKHOIz20Zaag+mB5ITJHJPax3IqS8+eKF7gGGn3i0=;
        b=m7JQzUgM1ZFtbtEGMDQAOA3kpJCURIjKG2nwIdPM6cuesQdNf+GG3AURh9PtNkWhmb
         sIP5qa7J423aKlZ+0chV3WSeg9vLIeThtD6l8A4chhTbt9dlOiMn7M8XW0shyaI33um4
         HrN6PMAiGuiIUDQrSFq7j8+n2ZEP7YGikcPyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714802398; x=1715407198;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYUKHOIz20Zaag+mB5ITJHJPax3IqS8+eKF7gGGn3i0=;
        b=JDdEDUllEwne26DbRKSzqs3LsPlwqGI9W4Zpz9qd+3pvxc3bCRpXToQwG+Px6KrpHk
         XvAYzypkDPQoqF7Ekr8aMuNRuBcYfeaFOFQXmHklyGAJfkoJ23pIjugAaqLyIC4RDykC
         aDV2W40sNOFb9GZp0gQlzzJaDqFk4xyHxrd/NkbUdkbKsafSiC53ungZh4sYl9g/ld1C
         3qFPUv+cAenfbHU5DsMXR3bS5LEqKXdRVnmgCSYns3UiGNmzyfEq1AxbgDSfAZMxbqIe
         yrF+eCpr/s91LoMNTCvhzlDlltExwpD1ivW3EL3ISlYbR0QbGq88XXoh1lBosLRlmLj2
         ZgvQ==
X-Gm-Message-State: AOJu0YwDJGnfD6wLjlKk9fppGNHyIUO/egsbgYHomZ02kDwJdtPxWLx9
	T41Vud7g2iFznC/bz4WwuQp7qYsO3IT1riyONLkIEqo/r7AVa7IbyjqenLeo1hB1S82UQPbCRG5
	bzI+kS0LtXJCHz0gUnZZVvtbUg/0i4zePXF8z
X-Google-Smtp-Source: AGHT+IFEvJdEhqjcviHSeTAGad+OdbhyV42PVCQRaUqM/rrkNHW2Qc3Zb94UjVibUGq+t/PlmzgKTqG5arIN0OFcXT4=
X-Received: by 2002:a05:6214:b6c:b0:6a0:5baa:1103 with SMTP id
 ey12-20020a0562140b6c00b006a05baa1103mr5520659qvb.39.1714802398361; Fri, 03
 May 2024 22:59:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 May 2024 22:59:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <267391c1-948c-9f75-69e6-b5b49d34a7fe@quicinc.com>
References: <20240502233017.419365-1-swboyd@chromium.org> <267391c1-948c-9f75-69e6-b5b49d34a7fe@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 3 May 2024 22:59:57 -0700
Message-ID: <CAE-0n50Wy0ZEmPfxyacBnwUMNvFgiZ5RXdR-fy+JEjFkNg8=Rg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Mark
 validate_timer_rate() init
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Mukesh Ojha <quic_mojha@quicinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Mukesh Ojha (2024-05-03 04:27:52)
>
>
> On 5/3/2024 5:00 AM, Stephen Boyd wrote:
> > Add the __init marking to validate_timer_rate() so that it gets
> > discarded after init.
> >
> >    $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
> >    add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-8 (-8)
> >    Function                                     old     new   delta
> >    arch_timer_register                         1724    1716      -8
>
> Have not used this tool bloat-o-meter
> Just a question, why is it showing arch_timer_register is shrunk ?

Hmm good question. There shouldn't be any difference if it gets inlined.

It's an allmodconfig build. It looks like that causes noise in the build so it
isn't stable. :( I diffed the objdump and the function is missing this ror and
nop instruction. But then I built it again, and it became more different. If I
build an allnoconfig it has zero difference.

Before:

  ffff800083021ed4:       974ba12d        bl      ffff80008030a388
<free_percpu_irq>
  ffff800083021ed8:       93d3f273        ror     x19, x19, #60
  ffff800083021edc:       d503201f        nop
  ffff800083021ee0:       d29858e0        mov     x0, #0xc2c7
           // #49863
  ffff800083021ee4:       910102b6        add     x22, x21, #0x40
  ffff800083021ee8:       f2aeea20        movk    x0, #0x7751, lsl #16
  ffff800083021eec:       f2ce7680        movk    x0, #0x73b4, lsl #32
  ffff800083021ef0:       f2f09e20        movk    x0, #0x84f1, lsl #48
  ffff800083021ef4:       ca000273        eor     x19, x19, x0
  ffff800083021ef8:       97527f02        bl      ffff8000804c1b00
<__sanitizer_cov_trace_pc>

After:

  ffff800083021ed4:       974ba12d        bl      ffff80008030a388
<free_percpu_irq>
  ffff800083021ed8:       d29f9f00        mov     x0, #0xfcf8
           // #64760
  ffff800083021edc:       910102b6        add     x22, x21, #0x40
  ffff800083021ee0:       f2b03940        movk    x0, #0x81ca, lsl #16
  ffff800083021ee4:       f2d5e700        movk    x0, #0xaf38, lsl #32
  ffff800083021ee8:       f2ee1340        movk    x0, #0x709a, lsl #48
  ffff800083021eec:       ca000273        eor     x19, x19, x0
  ffff800083021ef0:       97527f04        bl      ffff8000804c1b00
<__sanitizer_cov_trace_pc>

Maybe kcov is making things different?

