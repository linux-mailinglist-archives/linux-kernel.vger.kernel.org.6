Return-Path: <linux-kernel+bounces-195049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6A8D46D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B7728228D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50114C584;
	Thu, 30 May 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZ26U17"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118217753
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056956; cv=none; b=ss5flSubWWGQo++JxDXxfjJQp+2yGBgr5/rJx8+7mzhR6gdH3YQd5N5qVrQbCHEDYad1mfQXfpdmt8/ZtNAaXD55BcozaFlLpnQUIOiy7bLGxVE4AoFbY9EK/oc6cO24pyUMsZZzLsPR87GobbcdVGSJjCX3tyKlbJ8aBu53Fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056956; c=relaxed/simple;
	bh=R/6+LIm49u8oTIwIKRyzFjXZG4HUwTDHPLWkBzXDelo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQmgi0FsSSa7Lj5YF6pnqZCaeqoKTCGS9yHinTearROAaHw7wzmBc4E3ax520CfnXLMICOp3ZWc2k1lmEBe3hDE1Yvz7G0Fj9eyNgiM104sCbjOTmQoyFNt7xGlRWob9t0uBoMQ/nlofYnTIrlqdh8Myt2Qih0a1HeJdpILyxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZ26U17; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a0809c805so6688957b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717056954; x=1717661754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k20/mggq32MX0XT5cSqtsxqcJ+lwttdw4RIhMsw0RBg=;
        b=RgZ26U17jWa2sN5I0bOLewkXd305iNTW/U0lwcOT/FbvLEFne0px3CE4ByU7jaO9rH
         vVM9Kzh1eBfG31xDr0dq2r7JKLcrUJNIEMgWmbrdU5FHuRNObUKDt8eDcpmnsjLNnJ3j
         Lm2dZ4rRLbz0fqig3Fakqdtc/P6XG7KFMjuyBSCCwsswEbNh5WGHCtz8Rsx29YQbaVGq
         cQ+eWaTZdPA3m4tsV+tMfkPSqnKLESGD0Siba9Gm7ZL/v9FcC9Yt443UjGY9I/fwKAGD
         9kywt8P0JBlXiTxZTOIh1pW6kv5pMQMmgjFYnRZ5IA5jo5SnkkiezfZnvXeXFi/aZMo2
         w+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056954; x=1717661754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k20/mggq32MX0XT5cSqtsxqcJ+lwttdw4RIhMsw0RBg=;
        b=WB2/j/OFYa+ClyJEDiJLyUNr7ACPeFllUp9Klzp7AVnsfhGjqm1ID8rS0cAMf0Je67
         vw6cXkndqAHxi5U7+vpE0EVU7n0MtNbxlmTJF+MrsvqA1VaXzXPvE2i54R5RTYreLEfX
         37K6cyDSfuj3jk+vLwhtG2Xh27xBQZdx5nrtSOrqVUgppPN9UDqh3rYtT8lglyPJ6rJH
         KPT/RKWgLZYdjssnDm2Cvk9co3WlTT5ewYEA+BnZOnQvxTpcRXTWSs9eN6seH4eh/bQI
         gA6No2eHoCsg4aKXdaUDLRooBsGzO7rZBn0MXfMlqIGX/Otz78LvTtYDI5d7TZlXEqRd
         xiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2p1U5kiU1Xfbu40belgUCCm+Ny0nmA+e7M1PMxQMsLyhpShxc4vHz/Atv2FQzVXedTH23mfcTIcnqkkmEfZlvwKfHh16tuSYxic4X
X-Gm-Message-State: AOJu0YyH/eMffoR8fGdxJH7vaeVMb+EjpG+Md5hlhFIKkeQKEvSQqjhs
	JY7bVLq+SkV53MGi8u0R43bQWvnlesgPAH5jm3enDpE7RsK/ydf8kXumZD94tL2n05GNqDgsDul
	RbmPa0GSlhilYO+6LhHHPpyt0RKMlPYpaNWwXiw==
X-Google-Smtp-Source: AGHT+IFONaJRLFLyyUuBmDyblLsckMpdUUsrv4sxy/G30tTT+g+cVd3FIJtEM2RvUpHMWBlC+lY7cA5GEvsw+laVk1I=
X-Received: by 2002:a81:80c2:0:b0:61b:e871:9115 with SMTP id
 00721157ae682-62c6bc3e020mr10625537b3.17.1717056953560; Thu, 30 May 2024
 01:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-2-ulf.hansson@linaro.org> <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
In-Reply-To: <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 May 2024 10:15:13 +0200
Message-ID: <CAPDyKFq0V9ke30zYAGzS1aU0yq49DdfDkfYzxkLBZuaVGsyGDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains
 on PREEMPT_RT
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 21:56, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>
>
> On 5/27/2024 7:25 AM, Ulf Hansson wrote:
> > To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
> > during s2idle on a PREEMPT_RT based configuration, we can't use the regular
> > spinlock, as they are turned into sleepable locks on PREEMPT_RT.
> >
> > To address this problem, let's convert into using the raw spinlock, but
> > only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
> > this way, the lock can still be acquired/released in atomic context, which
> > is needed in the idle-path for PREEMPT_RT.
> >
> > Do note that the genpd power-on/off notifiers may also be fired during
> > s2idle, but these are already prepared for PREEMPT_RT as they are based on
> > the raw notifiers. However, consumers of them may need to adopt accordingly
> > to work properly on PREEMPT_RT.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - None.
> >
> > ---
> >  drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h |  5 ++++-
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 623d15b68707..072e6bdb6ee6 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >       .unlock = genpd_unlock_spin,
> >  };
> >
> > +static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> > +     genpd->raw_lock_flags = flags;
> > +}
> > +
> > +static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
> > +                                     int depth)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
> > +     genpd->raw_lock_flags = flags;
> > +}
> > +
> > +static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
> > +     __acquires(&genpd->raw_slock)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> > +     genpd->raw_lock_flags = flags;
> > +     return 0;
> > +}
> > +
> > +static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
> > +     __releases(&genpd->raw_slock)
> > +{
> > +     raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
> > +}
> > +
> > +static const struct genpd_lock_ops genpd_raw_spin_ops = {
> > +     .lock = genpd_lock_raw_spin,
> > +     .lock_nested = genpd_lock_nested_raw_spin,
> > +     .lock_interruptible = genpd_lock_interruptible_raw_spin,
> > +     .unlock = genpd_unlock_raw_spin,
> > +};
> > +
> >  #define genpd_lock(p)                        p->lock_ops->lock(p)
> >  #define genpd_lock_nested(p, d)              p->lock_ops->lock_nested(p, d)
> >  #define genpd_lock_interruptible(p)  p->lock_ops->lock_interruptible(p)
> > @@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
> >
> >  static void genpd_lock_init(struct generic_pm_domain *genpd)
> >  {
> > -     if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> > +     if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
> > +             raw_spin_lock_init(&genpd->raw_slock);
> > +             genpd->lock_ops = &genpd_raw_spin_ops;
> > +     } else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
>
> Hi Ulf, though you are targeting only CPU domains for now, I wonder if
> FLAG_IRQ_SAFE will be a better choice?  The description of the flag says
> it is safe for atomic context which won't be the case for PREEMPT_RT?

You have a point!

However, we also need to limit the use of raw spinlocks, from
PREEMPT_RT point of view. In other words, just because a genpd
provider is capable of executing its callbacks in atomic context,
doesn't always mean that it should use raw spinlocks too.

[...]

Kind regards
Uffe

