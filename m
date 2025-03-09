Return-Path: <linux-kernel+bounces-553100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13B2A583D1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90C23A9D79
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3C1B0411;
	Sun,  9 Mar 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHlPGVIR"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6942B9A4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741520204; cv=none; b=RzGNI91jY/9UcsoJLFoEyRY91XkAFNxr3+UgT6L6y/tb/wTF11EVKQpTH+26h7YQ0jBcF/051YbSNYNG1ckEdgsCuCg4vgqKvSOz1UWlqPnFUvuMIxamlpLoypxt+TJ9pbNQiPURoIyTZzknfdRvmMqnKPWMhmk5jNWoTHqrecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741520204; c=relaxed/simple;
	bh=vzoBOry61iQHIztimHhCz4wnuOq9GcoQJ0JTUfGsGIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbxYxPkYA8KpOp1BIWTmrZrufa0uXNELZxpO30YdGEwYxx8D/MeUa+CpSecyB440p5VgmYyJOyatnPje8jiOVQD3H5GNpsVMAGv3w3emcD13yqbrMl3M5RpkanV9au+aXUVNpXTiuk6PQ285ywrVjMGqupQ+OajI+O2c1R94yUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHlPGVIR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e41e18137bso22862286d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741520202; x=1742125002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a161bk7fNRzS2BH1BQSETx7mHbFCGZ6TGnzwioWVeM=;
        b=MHlPGVIRuIZVNW3oaF7J3SBkGi34gHUIgXntR4VTuO/MKYXUTMLG9xaipXEbbGpeuY
         Q+P+RXmpjOvCYkhYLMgXUUhfaopCh6sCocYXwFe0HidgeqhV4LONU7M9zkhmN7XZqaTi
         N0gTNkPitB/vA5jek8QUGm6QxZRFj46T23d2xRtkWhkb9NHO3oxNtfD5bgJndUvN/TVo
         86y4Muy7GMbIBrbQbqrM+Wqez0BpKSK2wBxmGjnGn06BIuZRTs/nvw62IAIZcOsKRriL
         B7zUqm1ixMhwioDy27VQ3OTK2zo8lzQw12gC12+8hYDrYm0o/uWrxtr4Sju55ZF1nX06
         6+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741520202; x=1742125002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a161bk7fNRzS2BH1BQSETx7mHbFCGZ6TGnzwioWVeM=;
        b=Hhadq0wyju7E4GbQQzBBTMzN+A1cWFX9EJwZ0KLGtTIYVQLXNjdQXMabKelmnpi6H8
         tNjmTni0VBI38YW9H8UzV7dXelE1bQvSBOz6clkPnXlVuCu6+vSiQzm+wPcl8BRl+T3a
         6EtU4qoEGuZNvZu7DLlOMqWYbyD8kLE+UKtkfVBnyO1A4nsBt6QHw6KZMywCdEXBcvq7
         CoZfox13clzl7ANsx9XRYxPDsofzOwdJPwA7e4oIWa8PYfnD+1d+mYvCMt1f6zBoXtx5
         jpQf0JY0rguC4KPg+LVWiCAPNzpgqcxBgFlUs7R7v/7CWuIAG7SkwA7l6uMP3c/UrLU2
         mSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfjxRScaejJlkvNTpQdBskpajtOi++LVhNXuMm/2PMR1XLKupuIVf2yDLExgSh38AdzVrn8kJtmb9rqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp32ZScqNje4T4uBSxzWCG7qLLwxbV5hmL53FOR8HvLeTPISTY
	RjNAntQTGBf9hALkay3EnDMgSoZ5aW+SSY95aZhcfLKb8W7USYsggD/wnw96wt8Ao8aM1AtjRID
	Uv4AYrD+ffeNdTzJQNkFyyhO6xO0=
X-Gm-Gg: ASbGncvGfDxi/Rbrshk8NEu9QOvHsdHI3bkumsIzQg6s4ycGLTfpwtH/ZxdbyazPvD6
	Ehoa1EJXKCzq/RWcpYlO4AlVMG15Vkxw6Ql0WCOir7kkEIy3DJQut/azTG3h/LAeH2MuKj1B+kB
	+Nx+mvUI3/J69SWlYMZxCq/jUrsfg=
X-Google-Smtp-Source: AGHT+IGvbRQ8MS07Ogxb7SEFwlPv9437lh5kEBC/VJnAquLYsy+9V+4d/utrdinZhbdwoXr7/IYHTdxhiIbgiBCj55s=
X-Received: by 2002:a05:6214:dcf:b0:6e8:eee6:8518 with SMTP id
 6a1803df08f44-6e9006049aamr156248146d6.19.1741520201777; Sun, 09 Mar 2025
 04:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop> <87plir32as.ffs@tglx>
In-Reply-To: <87plir32as.ffs@tglx>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Mar 2025 19:36:05 +0800
X-Gm-Features: AQ5f1Joz5qKEagUlUblBmAY47Yv_3oeGk7YC2Z4_6_8dMsbR4hOfoDvmkDborgs
Message-ID: <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource: Defer marking clocksources unstable to kthread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, jstultz@google.com, 
	sboyd@kernel.org, christian@heusel.eu, kernel-team@meta.com, 
	Peter Zijlstra <peterz@infradead.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 12:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Mar 06 2025 at 08:06, Paul E. McKenney wrote:
> > The clocksource watchdog marks clocksources unstable from within a time=
r
> > handler.  On x86, this marking involves an on_each_cpu_cond_mask(),
> > which in turn invokes smp_call_function_many_cond(), which may not be
> > invoked from a timer handler.  Doing so results in:
> >
> > WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+=
0x46b/0x4c0
> >
> > Fix this by deferring the marking to the clocksource watchdog kthread.
> > Note that marking unstable is already deferred, so deferring it a bit
> > more should be just fine.
>
> While this can be done, that's papering over the underlying problem,
> which was introduced with:
>
>   8722903cbb8f ("sched: Define sched_clock_irqtime as static key")
>
> That added the static key switch, which is causing the problem. And
> "fixing" this in the clocksource watchdog is incomplete because the same
> problem exists during CPU hotplug when the TSC synchronization declares
> the TSC unstable. It's the exactly same problem as was fixed via:
>
>  6577e42a3e16 ("sched/clock: Fix up clear_sched_clock_stable()")
>
> So as this got introduced in the 6.14 merge window, the proper fix is to
> revert commit 8722903cbb8f and send it back to the drawing board. It was
> clearly never tested with the various possibilities which invoke
> mark_tsc*_unstable().

Hello Thomas,

It has been reverted by the following commit
b9f2b29b9494 ("sched: Don't define sched_clock_irqtime as static key")

https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3Db9f2b29b94943b08157e3dfc970baabc7944dbc3

--=20
Regards
Yafang

