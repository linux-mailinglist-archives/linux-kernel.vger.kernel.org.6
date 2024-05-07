Return-Path: <linux-kernel+bounces-171039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924698BDF09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463622863EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6914D71F;
	Tue,  7 May 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="c5AWff30"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160ED8821
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075681; cv=none; b=FhREOX08mMrgkvGfJWBfJYGeHIjgRH4EzFdPv9E1uQr0ixB04fHP9osNPYQJRZ+ZCe2/+UVYwYfrZNuwb7RDjoNHGrFSORGbFyAq23jcTYmc/W/M6RAo/+z+oSccyYomgI1lw/BTv12n1RVBVjow71Htpc+Nc8yUwkG4Jk2bCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075681; c=relaxed/simple;
	bh=CHE1tigzNNkyysRAD+2FS2ODjhBUTibYEbL0fTaTe08=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLGoSgUl0J/Xu0kAiJnrtCc83lntoDzpp+c/XMPEjnvXbUv0o5m7Gf1a7l6jUDyBinyaNCqL1eyYzaipZpuByh2d/5fZksFy0x71vFtCbo4tOUTTJgV1FsLv15JCypv3p+NQJOzJShVk3sT01P+gD3PLJKEnCsRpGF8p3B/sJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=c5AWff30; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5EF183FB60
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715075675;
	bh=XxMfRWpdblXuwoQnBu1WEKFAk7dyHrSQLZjVkp66ZA8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=c5AWff30EIrg9uYJj6eGs7aGBGUZJ+dVbjlpNPRm0GENFsxsp06lHl329ASeG9yVH
	 wjQ3U3gVX9JT+nFnbECaYY3Srv8I4Z5aVIPBGm/bXN8TIFVSFHawq7DRA/5o2JVP7H
	 hfMAQzt3wt4mIG8RWVgEnu/2NeANEOXn7HSG2mw2LOPK8G1TtqwqmnG2Kvuvjsr0ZB
	 9Oz79LpKL85Yv7m9CrpsRHxKqBPwX2ppl5vY8/0scXSP1CTrUGJp1ad31GefQI24VL
	 OvO06YpHzMbnkQPJStYycTkWyc5/oISBLrRdSRiahNf5UhVo7n2GoH9SGgj5vVz8Up
	 1PZcoVJJ4vbkg==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6202c9d143cso62034087b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715075674; x=1715680474;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxMfRWpdblXuwoQnBu1WEKFAk7dyHrSQLZjVkp66ZA8=;
        b=rcC5/1scCpuKJm+UCB0Wu8ZBp7kAiV/l2HuZZmZYf073ZNVNKaid7abuVyuckj2XTb
         +fTqW9Ild1R+hS8nYbVF3XS2Ozffl8KYS8hr9w7mCQp2QjCDF03I/jIZNLzxcix8TSs0
         92s/hNhOawm6G7UfZtBtqnMLTIohshag3aUC2l7zh8GltnYntM3FCivJUgVcNHSExADD
         PNfLqyMa3bvkj2FQ5acA1sxCCI93eWvSeblZp7tJTGUyD7yyQAjpNhfcsG+QCGCYVj7M
         Z0KlC7saox8RStzmRu5eXUWD//YZthg9rgncaTZQydi5sywVcy0BGu3iItosHCSyiNbz
         KEmw==
X-Forwarded-Encrypted: i=1; AJvYcCWyqsF2kGnCq7Hx/BxfA3Qra0eMtwnKlF5U+geECxQuuxuCVtYul7VubiroEa1Pq59hH/NKupMA6cJIOzMpM1+GGaKbKNlDeUJ0WFki
X-Gm-Message-State: AOJu0Yzp/52EZaVCrvwG5zTwFHUT1Dqcs2g3rnvJpBw0zrpIs+Yl6Mov
	MbxUf1UmV0yuC0ScwuhdVafdnB875n8nPnQALDL5plR2B830pBHrurgCVXSuyYYM47dkB/dCL4f
	JVaLGeyOw/MmxNWm5YKY2QfnCmnhCHBORXSFIx/E5HSaUpFTAlQvtpkOluCzVhoXr7XZxFdtAIx
	ZdtuYPQ/ZtYFnCRfBYgLf1YciczpdrH986TuVNXlohlmjlFI2ql5cF
X-Received: by 2002:a05:690c:6f84:b0:61a:b54d:5925 with SMTP id je4-20020a05690c6f8400b0061ab54d5925mr13088703ywb.38.1715075674292;
        Tue, 07 May 2024 02:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw6YUEAS9vk1bIxTyFsZLiot4XTIjgw5Dx5kaVtTIlLPYpm3g7P4Jh2xlEwW/ZGqyJQe5vTOEawAe9GnKxE5w=
X-Received: by 2002:a05:690c:6f84:b0:61a:b54d:5925 with SMTP id
 je4-20020a05690c6f8400b0061ab54d5925mr13088685ywb.38.1715075673819; Tue, 07
 May 2024 02:54:33 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 May 2024 02:54:33 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <NTZPR01MB0986380E0F7930DF653D7807E1E4A@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
 <20240412084543.7243-3-ziv.xu@starfivetech.com> <NTZPR01MB09860632D4BDB31B98E1BD18E11AA@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z8U5ddBg_T34rHYUXQcTLdzhMhbhv3mZxehQL8VLBFtUA@mail.gmail.com> <NTZPR01MB0986380E0F7930DF653D7807E1E4A@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 7 May 2024 02:54:33 -0700
Message-ID: <CAJM55Z9mTeRKxt3gc_c-APn0oUm=oZEkF1wsNxwSkDPCXUTLGA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjEwIDIvM10gY2xvY2tzb3VyY2U6IEFkZA==?=
	=?UTF-8?B?IEpINzExMCB0aW1lciBkcml2ZXI=?=
To: Ziv Xu <ziv.xu@starfivetech.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ziv Xu wrote:
>
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Emil Renner Berthing <emil.renner.berthing=
@canonical.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8830=E6=97=
=A5 18:19
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Ziv Xu <ziv.xu@starfivetech.com>; Daniel L=
ezcano
> > <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>
> > =E6=8A=84=E9=80=81: linux-riscv@lists.infradead.org; devicetree@vger.ke=
rnel.org; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Paul Walmsley
> > <paul.walmsley@sifive.com>; Palmer Dabbelt <palmer@dabbelt.com>; Albert
> > Ou <aou@eecs.berkeley.edu>; Philipp Zabel <p.zabel@pengutronix.de>; Wal=
ker
> > Chen <walker.chen@starfivetech.com>; Xingyu Wu
> > <xingyu.wu@starfivetech.com>; linux-kernel@vger.kernel.org; Conor Doole=
y
> > <conor@kernel.org>
> > =E4=B8=BB=E9=A2=98: Re: =E5=9B=9E=E5=A4=8D: [PATCH v10 2/3] clocksource=
: Add JH7110 timer driver
> >
> > Ziv Xu wrote:
> > >
> > >
> > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Ziv Xu
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8812=E6=
=97=A5 16:46
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Daniel Lezcano <daniel.lezcano@linaro.=
org>; Thomas Gleixner
> > > > <tglx@linutronix.de>; Emil Renner Berthing
> > > > <emil.renner.berthing@canonical.com>; Christophe JAILLET
> > > > <christophe.jaillet@wanadoo.fr>
> > > > =E6=8A=84=E9=80=81: linux-riscv@lists.infradead.org; devicetree@vge=
r.kernel.org; Rob
> > > > Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Paul Walmsley
> > > > <paul.walmsley@sifive.com>; Palmer Dabbelt <palmer@dabbelt.com>;
> > > > Albert Ou <aou@eecs.berkeley.edu>; Philipp Zabel
> > > > <p.zabel@pengutronix.de>; Walker Chen
> > > > <walker.chen@starfivetech.com>; Xingyu Wu
> > > > <xingyu.wu@starfivetech.com>; linux-kernel@vger.kernel.org; Conor
> > > > Dooley <conor@kernel.org>
> > > > =E4=B8=BB=E9=A2=98: [PATCH v10 2/3] clocksource: Add JH7110 timer d=
river
> > > >
> > > > From: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > >
> > > > Add timer driver for the StarFive JH7110 SoC.
> > > >
> > > > This timer has four free-running and independent 32-bit counters.
> > > > Each channel(counter) can trigger an interrupt when timeout even CP=
U
> > > > is sleeping. So this timer is used as global timer and register
> > > > clockevent for each CPU core after riscv-timer registration on the =
StarFive
> > JH7110 SoC.
> > > >
> > > > Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
> > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > ---
> > > >  MAINTAINERS                        |   7 +
> > > >  drivers/clocksource/Kconfig        |  11 +
> > > >  drivers/clocksource/Makefile       |   1 +
> > > >  drivers/clocksource/timer-jh7110.c | 345
> > +++++++++++++++++++++++++++++
> > > >  include/linux/cpuhotplug.h         |   1 +
> > > >  5 files changed, 365 insertions(+)
> > > >  create mode 100644 drivers/clocksource/timer-jh7110.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > 7c121493f43d..ef9b5f5bad9e 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -21043,6 +21043,13 @@ S:	Maintained
> > > >  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yam=
l
> > > >  F:	sound/soc/starfive/jh7110_tdm.c
> > > >
> > > > +STARFIVE JH7110 TIMER DRIVER
> > > > +M:	Samin Guo <samin.guo@starfivetech.com>
> > > > +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > +S:	Supported
> > > > +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.y=
aml
> > > > +F:	drivers/clocksource/timer-jh7110.c
> > > > +
> > > >  STARFIVE JH71X0 CLOCK DRIVERS
> > > >  M:	Emil Renner Berthing <kernel@esmil.dk>
> > > >  M:	Hal Feng <hal.feng@starfivetech.com>
> > > > diff --git a/drivers/clocksource/Kconfig
> > > > b/drivers/clocksource/Kconfig index
> > > > 34faa0320ece..2dc97201dee1 100644
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > > @@ -641,6 +641,17 @@ config RISCV_TIMER
> > > >  	  is accessed via both the SBI and the rdcycle instruction.  This=
 is
> > > >  	  required for all RISC-V systems.
> > > >
> > > > +config STARFIVE_JH7110_TIMER
> > > > +	bool "Timer for the STARFIVE JH7110 SoC"
> > > > +	depends on ARCH_STARFIVE || COMPILE_TEST
> > > > +	select TIMER_OF
> > > > +	select CLKSRC_MMIO
> > > > +	default ARCH_STARFIVE
> > > > +	help
> > > > +	  This enables the timer for StarFive JH7110 SoC. On RISC-V platf=
orm,
> > > > +	  the system has started RISCV_TIMER, but you can also use this
> > timer
> > > > +	  which can provide four channels to do a lot more things on JH71=
10
> > SoC.
> > > > +
> > > >  config CLINT_TIMER
> > > >  	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
> > > >  	depends on GENERIC_SCHED_CLOCK && RISCV diff --git
> > > > a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile index
> > > > 4bb856e4df55..8dc2f0ea2d0f 100644
> > > > --- a/drivers/clocksource/Makefile
> > > > +++ b/drivers/clocksource/Makefile
> > > > @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+=3D
> > ingenic-timer.o
> > > >  obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
> > > >  obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
> > > >  obj-$(CONFIG_RISCV_TIMER)		+=3D timer-riscv.o
> > > > +obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+=3D timer-jh7110.o
> > > >  obj-$(CONFIG_CLINT_TIMER)		+=3D timer-clint.o
> > > >  obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
> > > >  obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
> > > > diff --git a/drivers/clocksource/timer-jh7110.c
> > > > b/drivers/clocksource/timer-jh7110.c
> > > > new file mode 100644
> > > > index 000000000000..dc770507f209
> > > > --- /dev/null
> > > > +++ b/drivers/clocksource/timer-jh7110.c
> > > > @@ -0,0 +1,345 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Starfive JH7110 Timer driver
> > > > + *
> > > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > > + *
> > > > + * This timer has four free-running and independent 32-bit counter=
s
> > > > +and runs in 24MHz
> > > > + * clock on the StarFive JH7110 SoC. Each channel(counter) can
> > > > +trigger an interrupt
> > > > + * when timeout even CPU is sleeping. They support one-shot mode
> > > > +and
> > > > continuous-run mode.
> > > > + *
> > > > + * Each channel is used as a global timer that serves each cpu cor=
e:
> > > > + * JH7110 Timer Channel 0 -- CPU 0
> > > > + * JH7110 Timer Channel 1 -- CPU 1
> > > > + * JH7110 Timer Channel 2 -- CPU 2
> > > > + * JH7110 Timer Channel 3 -- CPU 3
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clockchips.h>
> > > > +#include <linux/cpu.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/reset.h>
> > > > +
> > > > +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
> > > > +#define JH7110_TIMER_CH_LEN		0x40
> > > > +#define JH7110_TIMER_CH_BASE(x)		((x) *
> > JH7110_TIMER_CH_LEN)
> > > > +#define JH7110_TIMER_CH_MAX		4
> > > > +
> > > > +#define JH7110_DELAY_US			0
> > > > +#define JH7110_TIMEOUT_US		10000
> > > > +#define JH7110_CLOCKEVENT_RATING	300
> > > > +#define JH7110_TIMER_MAX_TICKS		0xffffffff
> > > > +#define JH7110_TIMER_MIN_TICKS		0xf
> > > > +
> > > > +#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt
> > Status
> > > > for channel0~4 */
> > > > +#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run,
> > 1-single run
> > > > */
> > > > +#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter
> > */
> > > > +#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable
> > register */
> > > > +#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both
> > reload
> > > > counter */
> > > > +#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
> > > > +#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear
> > > > register */
> > > > +#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer
> > interrupt
> > > > mask register */
> > > > +
> > > > +#define JH7110_TIMER_INT_CLR_ENA	BIT(0)
> > > > +#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
> > > > +
> > > > +#define JH7110_PERCPU_GET_CLKEVT
> > > > 	(&jh7110_timer_info.clkevt[smp_processor_id()])
> > > > +
> > > > +/**
> > > > + * struct jh7110_clkevt - Description of each timer channel
> > > > + * @clk:		Clock of each timer channel
> > > > + * @rst:		Reset of each timer channel
> > > > + * @base:		Virtual address of each timer channel
> > > > + * @irq:                Interrupt number of each timer channel
> > > > + * @timer_enabled:      Enabled flag for each timer channel
> > > > + * @name:		Name of each timer channel
> > > > + */
> > > > +struct jh7110_clkevt {
> > > > +	struct clk		*clk;
> > > > +	struct reset_control	*rst;
> > > > +	void __iomem		*base;
> > > > +	int			irq;
> > > > +	bool			timer_enabled;
> > > > +	char			name[sizeof("jh7110-timer.chX")];
> > > > +};
> > > > +
> > > > +struct jh7110_timer_priv {
> > > > +	struct clk		*pclk;
> > > > +	struct reset_control	*prst;
> > > > +	struct device		*dev;
> > > > +	struct jh7110_clkevt	clkevt[JH7110_TIMER_CH_MAX];
> > > > +};
> > > > +
> > > > +static struct jh7110_timer_priv jh7110_timer_info;
> > > > +
> > > > +/* 0:continuous-run mode, 1:single-run mode */ enum jh7110_timer_m=
ode
> > {
> > > > +	JH7110_TIMER_MODE_CONTIN,
> > > > +	JH7110_TIMER_MODE_SINGLE,
> > > > +};
> > > > +
> > > > +/* Interrupt Mask, 0:Unmask, 1:Mask */ enum jh7110_timer_int_mask =
{
> > > > +	JH7110_TIMER_INT_ENA,
> > > > +	JH7110_TIMER_INT_DIS,
> > > > +};
> > > > +
> > > > +enum jh7110_timer_enable {
> > > > +	JH7110_TIMER_DIS,
> > > > +	JH7110_TIMER_ENA,
> > > > +};
> > > > +
> > > > +/*
> > > > + * BIT(0): Read value represent channel int status.
> > > > + * Write 1 to this bit to clear interrupt. Write 0 has no effects.
> > > > + * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not=
 be written.
> > > > + */
> > > > +static inline int jh7110_timer_int_clear(struct jh7110_clkevt
> > > > +*clkevt) {
> > > > +	u32 value;
> > > > +	int ret;
> > > > +
> > > > +	/* Waiting interrupt can be cleared */
> > > > +	ret =3D readl_poll_timeout_atomic(clkevt->base +
> > > > +JH7110_TIMER_INT_CLR,
> > > > value,
> > > > +					!(value & JH7110_TIMER_INT_CLR_AVA_MASK),
> > > > +					JH7110_DELAY_US, JH7110_TIMEOUT_US);
> > > > +	if (!ret)
> > > > +		writel(JH7110_TIMER_INT_CLR_ENA, clkevt->base +
> > > > +JH7110_TIMER_INT_CLR);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_start(struct jh7110_clkevt *clkevt) {
> > > > +	int ret;
> > > > +
> > > > +	/* Disable and clear interrupt first */
> > > > +	writel(JH7110_TIMER_INT_DIS, clkevt->base +
> > > > JH7110_TIMER_INT_MASK);
> > > > +	ret =3D jh7110_timer_int_clear(clkevt);
> > > > +
> > > > +	writel(JH7110_TIMER_INT_ENA, clkevt->base +
> > > > JH7110_TIMER_INT_MASK);
> > > > +	writel(JH7110_TIMER_ENA, clkevt->base + JH7110_TIMER_ENABLE);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_shutdown(struct clock_event_device *evt) {
> > > > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > > > +
> > > > +	writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
> > > > +	return jh7110_timer_int_clear(clkevt); }
> > > > +
> > > > +/* IRQ handler for the timer */
> > > > +static irqreturn_t jh7110_timer_interrupt(int irq, void *data) {
> > > > +	struct clock_event_device *evt =3D (struct clock_event_device *)d=
ata;
> > > > +	struct jh7110_clkevt *clkevt =3D &jh7110_timer_info.clkevt[0];
> > > > +	u32 reg =3D readl(clkevt->base + JH7110_TIMER_INT_STATUS);
> > > > +	u8 cpu_id =3D smp_processor_id();
> > > > +
> > > > +	/* Check interrupt status and channel(cpu) ID */
> > > > +	if (!(reg & BIT(cpu_id)))
> > > > +		return IRQ_NONE;
> > > > +
> > > > +	clkevt =3D &jh7110_timer_info.clkevt[cpu_id];
> > > > +	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base +
> > > > +JH7110_TIMER_INT_CLR));
> > > > +
> > > > +	if (evt->event_handler)
> > > > +		evt->event_handler(evt);
> > > > +
> > > > +	return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_set_periodic(struct clock_event_device *ev=
t) {
> > > > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > > > +
> > > > +	writel(JH7110_TIMER_MODE_CONTIN, clkevt->base +
> > > > JH7110_TIMER_CTL);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_set_oneshot(struct clock_event_device *evt=
) {
> > > > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > > > +
> > > > +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base +
> > > > JH7110_TIMER_CTL);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_set_next_event(unsigned long next,
> > > > +				       struct clock_event_device *evt) {
> > > > +	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
> > > > +
> > > > +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base +
> > > > JH7110_TIMER_CTL);
> > > > +	writel(next, clkevt->base + JH7110_TIMER_LOAD);
> > > > +
> > > > +	return jh7110_timer_start(clkevt); }
> > > > +
> > > > +static DEFINE_PER_CPU(struct clock_event_device, jh7110_clock_even=
t) =3D
> > {
> > > > +	.features			=3D CLOCK_EVT_FEAT_PERIODIC |
> > > > +					  CLOCK_EVT_FEAT_ONESHOT,
> > > > +	.rating				=3D JH7110_CLOCKEVENT_RATING,
> > > > +	.set_state_shutdown		=3D jh7110_timer_shutdown,
> > > > +	.set_state_periodic		=3D jh7110_timer_set_periodic,
> > > > +	.set_state_oneshot		=3D jh7110_timer_set_oneshot,
> > > > +	.set_state_oneshot_stopped	=3D jh7110_timer_shutdown,
> > > > +	.set_next_event			=3D jh7110_timer_set_next_event,
> > > > +};
> > > > +
> > > > +static int jh7110_timer_dying_cpu(unsigned int cpu) {
> > > > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > > > +
> > > > +	if (!priv->clkevt[cpu].timer_enabled)
> > > > +		return 0;
> > > > +
> > > > +	writel(JH7110_TIMER_DIS, priv->clkevt[cpu].base +
> > > > JH7110_TIMER_ENABLE);
> > > > +	jh7110_timer_int_clear(&priv->clkevt[cpu]);
> > > > +	reset_control_assert(priv->clkevt[cpu].rst);
> > > > +	clk_disable_unprepare(priv->clkevt[cpu].clk);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_starting_cpu(unsigned int cpu) {
> > > > +	struct clock_event_device *evt =3D per_cpu_ptr(&jh7110_clock_even=
t,
> > cpu);
> > > > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > > > +	int err;
> > > > +	u32 rate;
> > > > +
> > > > +	if (cpu >=3D JH7110_TIMER_CH_MAX)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	err =3D clk_prepare_enable(priv->clkevt[cpu].clk);
> > > > +	if (err)
> > > > +		goto err_starting_cpu;
> > > > +
> > > > +	err =3D reset_control_deassert(priv->clkevt[cpu].rst);
> > > > +	if (err)
> > > > +		goto err_soft_reset;
> > > > +
> > > > +	rate =3D clk_get_rate(priv->clkevt[cpu].clk);
> > > > +	evt->cpumask =3D cpumask_of(cpu);
> > > > +	evt->irq =3D priv->clkevt[cpu].irq;
> > > > +
> > > > +	err =3D irq_force_affinity(evt->irq, cpumask_of(cpu));
> > > > +	if (err)
> > > > +		goto err_affinity;
> > > > +
> > > > +	clockevents_config_and_register(evt, rate,
> > JH7110_TIMER_MIN_TICKS,
> > > > +					JH7110_TIMER_MAX_TICKS);
> > > > +
> > > > +	/* Use one-shot mode */
> > > > +	writel(JH7110_TIMER_MODE_SINGLE, (priv->clkevt[cpu].base +
> > > > +JH7110_TIMER_CTL));
> > > > +
> > > > +	priv->clkevt[cpu].timer_enabled =3D true;
> > > > +
> > > > +	err =3D jh7110_timer_start(&priv->clkevt[cpu]);
> > > > +	if (err)
> > > > +		goto err_affinity;
> > > > +	return 0;
> > > > +
> > > > +err_affinity:
> > > > +	reset_control_assert(priv->clkevt[cpu].rst);
> > > > +err_soft_reset:
> > > > +	clk_disable_unprepare(priv->clkevt[cpu].clk);
> > > > +err_starting_cpu:
> > > > +	free_irq(evt->irq, evt);
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static int jh7110_timer_probe(struct platform_device *pdev) {
> > > > +	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
> > > > +	struct clock_event_device *evt;
> > > > +	struct jh7110_clkevt *clkevt;
> > > > +	char name[sizeof("chX")];
> > > > +	int ch;
> > > > +	int ret;
> > > > +	void __iomem *base;
> > > > +
> > > > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> > > > +	if (IS_ERR(base))
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> > > > +				     "failed to map registers\n");
> > > > +
> > > > +	priv->prst =3D devm_reset_control_get_exclusive(&pdev->dev, "apb"=
);
> > > > +	if (IS_ERR(priv->prst))
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->prst),
> > > > +				     "failed to get apb reset\n");
> > > > +
> > > > +	priv->pclk =3D devm_clk_get_enabled(&pdev->dev, "apb");
> > > > +	if (IS_ERR(priv->pclk))
> > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->pclk),
> > > > +				     "failed to get & enable apb clock\n");
> > > > +
> > > > +	ret =3D reset_control_deassert(priv->prst);
> > > > +	if (ret)
> > > > +		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb
> > > > +reset\n");
> > > > +
> > > > +	for (ch =3D 0; ch < JH7110_TIMER_CH_MAX; ch++) {
> > > > +		evt =3D per_cpu_ptr(&jh7110_clock_event, ch);
> > > > +		clkevt =3D &priv->clkevt[ch];
> > > > +		snprintf(name, sizeof(name), "ch%d", ch);
> > > > +
> > > > +		clkevt->base =3D base + JH7110_TIMER_CH_BASE(ch);
> > > > +		/* Ensure timer is disabled */
> > > > +		writel(JH7110_TIMER_DIS, clkevt->base +
> > JH7110_TIMER_ENABLE);
> > > > +		ret =3D jh7110_timer_int_clear(clkevt);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		clkevt->rst =3D devm_reset_control_get_exclusive(&pdev->dev,
> > name);
> > > > +		if (IS_ERR(clkevt->rst))
> > > > +			return PTR_ERR(clkevt->rst);
> > > > +
> > > > +		clkevt->clk =3D devm_clk_get(&pdev->dev, name);
> > > > +		if (IS_ERR(clkevt->clk))
> > > > +			return PTR_ERR(clkevt->clk);
> > > > +
> > > > +		clkevt->irq =3D platform_get_irq(pdev, ch);
> > > > +		if (clkevt->irq < 0)
> > > > +			return clkevt->irq;
> > > > +
> > > > +		snprintf(clkevt->name, sizeof(clkevt->name),
> > "jh7110-timer.ch%d",
> > > > ch);
> > > > +		ret =3D devm_request_irq(&pdev->dev, clkevt->irq,
> > > > jh7110_timer_interrupt,
> > > > +				       IRQF_TIMER | IRQF_IRQPOLL,
> > > > +				       clkevt->name, evt);
> > > > +
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		clkevt->timer_enabled =3D false;
> > > > +	}
> > > > +
> > > > +	return cpuhp_setup_state(CPUHP_AP_JH7110_TIMER_STARTING,
> > > > +				"clockevents/jh7110/timer:starting",
> > > > +				jh7110_timer_starting_cpu,
> > jh7110_timer_dying_cpu); }
> > > > +
> > > > +static const struct of_device_id jh7110_timer_match[] =3D {
> > > > +	{ .compatible =3D "starfive,jh7110-timer", },
> > > > +	{ /* sentinel */ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
> > > > +
> > > > +static struct platform_driver jh7110_timer_driver =3D {
> > > > +	.probe =3D jh7110_timer_probe,
> > > > +	.driver =3D {
> > > > +		.name =3D "jh7110-timer",
> > > > +		.of_match_table =3D jh7110_timer_match,
> > > > +	},
> > > > +};
> > > > +module_platform_driver(jh7110_timer_driver);
> > > > +
> > > > +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> > > > +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
> > > > +MODULE_LICENSE("GPL");
> > > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.=
h
> > > > index 35e78ddb2b37..4a8b487c327e 100644
> > > > --- a/include/linux/cpuhotplug.h
> > > > +++ b/include/linux/cpuhotplug.h
> > > > @@ -175,6 +175,7 @@ enum cpuhp_state {
> > > >  	CPUHP_AP_CSKY_TIMER_STARTING,
> > > >  	CPUHP_AP_TI_GP_TIMER_STARTING,
> > > >  	CPUHP_AP_HYPERV_TIMER_STARTING,
> > > > +	CPUHP_AP_JH7110_TIMER_STARTING,
> > > >  	/* Must be the last timer callback */
> > > >  	CPUHP_AP_DUMMY_TIMER_STARTING,
> > > >  	CPUHP_AP_ARM_XEN_STARTING,
> > > > --
> > > > 2.17.1
> > >
> > > Hi Daniel / Thomas
> > >
> > > I have submitted new version of patch for jh7110 timer driver. Could =
you please
> > help to review and give your comments?
> > > Thanks a lot!
> >
> > Hi Ziv
> >
> > I tried this on 6.9-rc6 on my VF2. It boots, but very slowly and "chopp=
y". That is
> > it repeatedly runs for <1s and then hangs for about 4s.
> >
> > Does this patch work for you?
> >
> > /Emil
>
> Hi, Emil
>
> I tried this on 6.9-rc7 and 6.9-rc7, but it doesn't reproduce the phenome=
non you said.
> The attachment is the log for 6.9-rc6. Could you please share your config=
 file (starfive_visionfive2_defconfig or .config) with me?

Yeah, I just tried again on 6.9-rc7 (+ Conor's riscv-dt-for-next, Minda's P=
CIe
patches and the PWM driver) with this config:

https://sprunge.us/kiXXba

I don't know if it makes a difference but my also board boots via EFI.

/Emil

