Return-Path: <linux-kernel+bounces-287909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C193C952E21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B69928256F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44017BEAA;
	Thu, 15 Aug 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="h8OP95W9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BC176ABF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724066; cv=none; b=UPVr4vm0SeqokuJJRT6KnUqv/R/KlO5m8x0PHf6fBl/UYomuqnkLywj7B2fd14K3s8FXMfn+f49HZMNouEbP6XNtbfYQO0NmksNFfY//j7KV3hS/LlzHDXshX7Tq4jUKUcpLQdpIUcVFDB0/KxUB4wA2q/SqKbjWRhkybVpOzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724066; c=relaxed/simple;
	bh=GG0N/jyIyq/cnQ+RqrxQTGZhv2Rv84ATA6wlRYDHdU0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt6UDhACXvL5U7XtRZt2AgxHMGHYKiP3iWSzsKGjkrNsAN9tqK9yJ5Sa2zVZ+z6pqzNJusJXJLnXhZhP8Cefce24eN2Q6LhuSH2+Hqa2NaNGwxtHbAOXfe1ZJ58dT1kqPhSKKu9pAIrhdtHvnoT62pKO1QQWI6EOGlqMg2h2zfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=h8OP95W9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 779A03F322
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723724056;
	bh=5LJz5tYO6GlR7aAMJQnBhMkGyX+mgcBglIlt5FhiOes=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=h8OP95W9VQuYvUI6BrY5kmurChbFvkU6pK1JJgm49D57ZlcTzdIyPj6z70zyYhpo0
	 gweAQNgYErpVUTDj0sQeX/pdzol4M2+2HgkyX3+rFdZdlNkU+lvj84+w7+T9aEFuef
	 ROsKXmJuWD1IYpLdjI2C88W/7pLBVpNYrLpuGbhK3iXvaHuwvD78/7urNUwpsLwmLJ
	 OscAg/hy5IZLm6kKrpaDmw5VD2kuXDkHXZ0avNjicvQ8ExsLOmjFTQ9eDiLtpULX/g
	 zn2VDi6HD2pS4yq7G52o9z3IgwO4f5aqaN0cdsew+HXusfseIqY9cpfIf2Fp2oDhk4
	 EQXxLuGgGp87A==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d9a712bcso365773485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723724055; x=1724328855;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LJz5tYO6GlR7aAMJQnBhMkGyX+mgcBglIlt5FhiOes=;
        b=skM1BS3k9LDvZ09NeNoUJK45g0ngF6ftXOtF91enA40mN2g6RDRTN89C9tf0LDLVQF
         j7AYcrA434cL3vp8TM53X68GbL8IUPQW/ED6sgOzKb4NcMRHMIGFB/Z3lBStXGqF2Tmg
         8UV34SGVLOTm80hcX0umlLAjS43G3QI3xe3GdPFuebe/lqj1J+MCNTGL+MNEadt0OkMR
         WuMXWqn+kuIzx4DHF3Ibe2J0Gc6Zy3lgj6Dt4s2pv3MAZ7hpy1Y6OzdLGlq1bcg0YaZx
         vn06469BmX/X7BVAdRcvFNy+uZdwM8B158hVc3ciPx5Z8W9bcpzIF2A4glMNsWfjqUNd
         ZH6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9GA6NxEKni4UYTtZ1JwQ/A/Mlx+asOxcWOddmtcl9/g9YeO/8SUlH1hRmFWWzC0HpgCghIqVOyv+vE5byD7aT+ojJ76GS4Mwkg4Ti
X-Gm-Message-State: AOJu0YyF+lSP9iyyY1SeFC9STopwzPpkHi/OuMGjeolTzmI+9avKWuDN
	pXM4FylQQGZftkLh2KbNf4dVDWLPCpieVwoYdAAVwBqKZC2iUODb1ddjdbEzDBp/Xs6HMYaRkNC
	a6Vtah2/jyrbflOdHqxGbVRZZeCyPnrLjlMKw+bZb8KAoe/65Rp8jfj9oYe60ccY3K0T6XKamTl
	QUR+kG4RBjqe1x1+mJ7ydBLTNDMCWc+CGnRuOnRbIDRs4nwq2rJNba
X-Received: by 2002:ac8:6905:0:b0:453:5b3f:2a39 with SMTP id d75a77b69052e-45367845732mr58163881cf.1.1723724055299;
        Thu, 15 Aug 2024 05:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXFFrqF7jEACs/vjXZynr3mlRXA4KoVr/szdxXifNlUQpmZ78stjsP7LYQ+pbSsvCJWHNB94E8LTSJkPZ+6U=
X-Received: by 2002:ac8:6905:0:b0:453:5b3f:2a39 with SMTP id
 d75a77b69052e-45367845732mr58163351cf.1.1723724054897; Thu, 15 Aug 2024
 05:14:14 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 05:14:14 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 05:14:14 -0700
Message-ID: <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Emil Renner Berthing wrote:
> Thomas Gleixner wrote:
> > On Thu, Aug 15 2024 at 03:29, Emil Renner Berthing wrote:
> > > Thomas Gleixner wrote:
> > > Thanks for looking at this! Unfortunately the above patch isn't enough to fix
> > > the issue:
> > >
> > > https://termbin.com/7sgc
> > >
> > > It still hangs after the "[    0.176451] cpuidle: using governor teo" message
> > > until the watchdog reboots the systems.
> >
> > So what's puzzling is that there is a timer installed early on:
> >
> > [    0.000000] clocksource: riscv_clocksource: ....
> >
> > That same init function installs the per cpu riscv clockevent, so there
> > should be a timer available.
> >
> > The deffered probing of the PLIC driver delays obviously the probing of
> > the sun4i timer, but that should not matter when another timer is
> > available. So the sun4i driver might be a red herring.
> >
> > Can you please add "ignore_loglevel initcall_debug" to the command line
> > and provide the output of a booting and a failing kernel?
>
> 6.11-rc3 + these reverts:  https://termbin.com/q6wk
> 6.11-rc3 + Samuel's patch: https://termbin.com/7cgs

I think this confirms what Charlie found here:
https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/

>
> > And on the booting kernel please provide the output from:
> >
> > # cat /sys/devices/system/clockevents/clockevent0/current_device
> > # cat /sys/devices/system/clockevents/broadcast/current_device
> > # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
>
> On both a 6.8.6 kernel and 6.11-rc3 + reverts I get:
>
>   # cat /sys/devices/system/clockevents/clockevent0/current_device
>   sun4i_tick
>   # cat /sys/devices/system/clockevents/broadcast/current_device
>   riscv_timer_clockevent
>   # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
>   riscv_clocksource
>
> /Emil
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

