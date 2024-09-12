Return-Path: <linux-kernel+bounces-326136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11DD976389
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4DC28360D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749DE18E052;
	Thu, 12 Sep 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="NALpd13s"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365ED18E367
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127662; cv=none; b=JrPqgGvwBRQLySEweo9t34qVQ3+14MihIwi875umg4gkhAnfO33dfQguEzRatyjQdwgKaP5sFgWbZUM7uvmQT7vOzW9yCvkYWtdGna8Fa0UltQbcRZUOyghSbu0selgmL7CVI98JEfap2lbcbaaaZpFWoZ5HrUrlT0TZ3Dl5ZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127662; c=relaxed/simple;
	bh=AkS9o1mzi8Q+pcXht/mtnYrxRcMGJnj7+Lcvl6idrLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wl+9TIUAcvq6mcRClvcD9kt98jil8q7A7/5e2LpykcoHKO0ecEhUt0/c1Rt+J/YX3S2PKg1J+lROEMT0sh5G0rYBM72cP1b6TOzMOL8V0xAznf5iycM0ISfW7DhrXhNFCQBlKb2V3vJrjDw0xNbN0ggMCwgLFRgnYBX2/I/L1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=NALpd13s; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 6CE5C5F910;
	Thu, 12 Sep 2024 10:47:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hlePcT2HfSw0-7x6aZtJL;
	Thu, 12 Sep 2024 10:47:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726127264; bh=AkS9o1mzi8Q+pcXht/mtnYrxRcMGJnj7+Lcvl6idrLo=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=NALpd13s354dAGPoSAQcz888gO54sy7gbyildAvb5sejmolOeCZ7JBqCRx6+lx7BH
	 Abb/xnj/R+NUi84YI6b9oDCUscB4d+DXRIiDlWmWmoDCpJKjvq4Sd9wEKcE+UqmWUm
	 mG8Tz6epkElAaPWMKXKeFcL+L31b6+Fib0IKqEJ0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <93d6379423ab2cdaee66ba8f7d37d3ed85157479.camel@maquefel.me>
Subject: Re: [PATCH v12 02/38] ARM: ep93xx: add regmap aux_dev
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Linus Walleij
 <linus.walleij@linaro.org>,  Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 10:47:44 +0300
In-Reply-To: <080600661d43e4c39ea4b20b05e3e141.sboyd@kernel.org>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
	 <20240909-ep93xx-v12-2-e86ab2423d4b@maquefel.me>
	 <080600661d43e4c39ea4b20b05e3e141.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Stephen !

On Wed, 2024-09-11 at 15:46 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2024-09-09 01:10:27)
> > diff --git a/include/linux/soc/cirrus/ep93xx.h
> > b/include/linux/soc/cirrus/ep93xx.h
> > index 56fbe2dc59b1..a27447971302 100644
> > --- a/include/linux/soc/cirrus/ep93xx.h
> > +++ b/include/linux/soc/cirrus/ep93xx.h
> > @@ -3,6 +3,18 @@
> > =C2=A0#define _SOC_EP93XX_H
> > =C2=A0
> > =C2=A0struct platform_device;
> > +struct regmap;
> > +struct spinlock_t;
> > +
> > +enum ep93xx_soc_model {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EP93XX_9301_SOC,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EP93XX_9307_SOC,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EP93XX_9312_SOC,
> > +};
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/container_of.h>
> > =C2=A0
> > =C2=A0#define EP93XX_CHIP_REV_D0=C2=A0=C2=A0=C2=A0=C2=A0 3
> > =C2=A0#define EP93XX_CHIP_REV_D1=C2=A0=C2=A0=C2=A0=C2=A0 4
> > @@ -10,6 +22,20 @@ struct platform_device;
> > =C2=A0#define EP93XX_CHIP_REV_E1=C2=A0=C2=A0=C2=A0=C2=A0 6
> > =C2=A0#define EP93XX_CHIP_REV_E2=C2=A0=C2=A0=C2=A0=C2=A0 7
> > =C2=A0
> > +struct ep93xx_regmap_adev {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct auxiliary_device adev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *map;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *base;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t *lock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*write)(struct regmap *map,=
 spinlock_t *lock,
> > unsigned int reg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*update_bits)(struct regmap=
 *map, spinlock_t *lock,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 unsigned int reg, unsigned int mask,
> > unsigned int val);
> > +};
>=20
> Why can't the single 'struct regmap' be passed as the auxiliary
> device's
> platform_data? The lock could be put into the regmap locking routines
> and the write/update_bits would be standard regmap API calls. Doing
> that
> would make the auxiliary device driver simpler because it wouldn't
> depend on this struct.
>=20
> The device name could encode the SoC number as well so the auxiliary
> device driver could match different names and do different things.

Unfortunately ep93xx sw locked register are trickier than they appear
at first glance:

```
+ * Logic safeguards are included to condition the control signals for
+ * power connection to the matrix to prevent part damage. In addition,
a
+ * software lock register is included that must be written with 0xAA
+ * before each register write to change the values of the four switch
+ * matrix control registers.
```

- only a few registers are sw locked, so we are not using lock's
everywhere only when it is really needed
- lock is cleared on any write to this register, so we must ensure we
are performing 2 write operations, first writing 0xaa, second the
protected register itself under a single lock
- luckily we can read without clearing the lock

That's why we have such a funny ep93xx_regmap_update_bits() with forced
update_bits.

It was discussed in detail a five iteration ago or so with Andy
Shevchenko, when he was reviewing clk and pinctrl (and thank you once
again Andy).


