Return-Path: <linux-kernel+bounces-217696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA690B3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71274B3BA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB0745C2;
	Mon, 17 Jun 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="RgR4RvD2"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74937347F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633093; cv=none; b=O8AvCENqlY09oKknxI9ZmPr9E3VfasG7soJPokI3cPHpKsvG2AcNkFIn/GQcWcVq7S41exAFrd7p7TtnYgnV316aZdmpb6L5xpWE440vDvy7sHEvRpa3v9oiWDFRb2uagxjSvHO3o7C5qsVvOAnvnTkL4n6Ha878NTejqaIwjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633093; c=relaxed/simple;
	bh=Oas3OL/b/DriXAm/mtEfV6t2J9RXQPvR4MOBk+IH9ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwfiTUjeVrJF6x1VxaF7eQvNxZKfH7A409SLuYi97Pfxw9mdOdcXUB7QSZ46ckyXUGzbbCV7MzADanDgmnJEyTUoqSkR3TD98pFkMUY7mzkknsG4XJXT6t1fAAP7m84pJsK7+why4NhI7lJBt2B3yM4MNWOd1TlJGOr7pG4HA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=RgR4RvD2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b0682d1b12so26322766d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718633090; x=1719237890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuiBnTAk1GdD7Nn+nX9o9bL0mw0aUr07eq17+hCN0VA=;
        b=RgR4RvD25MqKkP5yHsza/YCgd4DnnH6w6F0W51CE1jcyikrZLCZ1LEvRkoBarAXqit
         G5fmnPbgEXmlo0KJ3H3WRhhswMbOvbkc2OChEJk/3+x4hDEbkODg4BiSbJheDwGv/qpI
         uuyjlksk4DSYL/npr/REK7HtGTz9U8O5aTZx5PSxUw9w5nC568kgxyVVKwJCjJQAloH5
         m7CQVXoYeIMNK1idWmxO9hbwMHQk8aJq82JAIASGQXyN9qr6sp1B6LAHSs7qP+hxttbx
         K43ipEwTAus3mCyWaQGwMGZtTU0lqwFDE4g0kpxyhHqI75BzpkKxcqMtAvlJHdL1S8Ae
         0Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633090; x=1719237890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuiBnTAk1GdD7Nn+nX9o9bL0mw0aUr07eq17+hCN0VA=;
        b=Eqxvw2TO7aQqb2pSGFe/qMImx6P9O2MtXItH/NlcoBmEvtSpR0nTg1ilj5ue8WWK2o
         0U0hLkxUE6pRVt8b3lXEXWlFQZKlQAmMuvkTiywS0Y5UvPojHwuxrCOUInnsShe5tWmf
         p+1K2fm4Mt9SY7YvuRbyIMAayF7spWC/RsusALGPuQZSlViwQJWaHrM+zDx89fUQ4CH+
         XheUwe849IR34ytbUjKyKiJogwmUAu/vKQyjlZbNGM+qEiO3IvL/zwVctkFCpIEWyU6v
         KVWZTjpdVu2ZDF78vbawvXaJgsuV0f2rQwCvts5zuqzImXm0znme31GtoTOzVPTSYXCE
         p34w==
X-Forwarded-Encrypted: i=1; AJvYcCWjTFE3BPV+e3/H9SB/O+jw69Kd8QcStULaqhKFgpYkav2d7yYbmIXLdSP9MRUk0X1Ve+Kyh+Wjxlx4YclPdu2zfolZVZDbXe8sIXDr
X-Gm-Message-State: AOJu0YycaUYG6zvJh/BGfxu6jWPKSASaqicDXmDfpfDbWlshZlTT5/Oi
	TsJxavRWPf0neBmM2ErUziUJosnOJOWVatxMFmOGzzCDBnDEMtcipKH7/iTfSUj7iWlyk7vnQOA
	IFWwh40hbiekkJti1TpWNIK/+0iFmKowWT0Xerg==
X-Google-Smtp-Source: AGHT+IHgt8vcIdjEnWNHVtl+wLq4vY15nqjqT8vHj/DvbcH6/AFoCHKztbbB0oihPAkdtwCT0DqCv4v4/vIp7abnqNw=
X-Received: by 2002:a0c:db01:0:b0:6b0:6dba:c947 with SMTP id
 6a1803df08f44-6b2afc8d656mr92366246d6.18.1718633089663; Mon, 17 Jun 2024
 07:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com> <20240614163500.386747-2-piotr.wojtaszczyk@timesys.com>
 <83cbf43e-c927-449f-8b7e-5c8d3ee8cece@kernel.org> <CAG+cZ06EeXUDiLsDXkz+6EHqJwpvv2MWwfpvB8AYw0=ZhUkTfQ@mail.gmail.com>
 <83a45f7c-d90b-44d3-b57e-9dad21045e27@kernel.org>
In-Reply-To: <83a45f7c-d90b-44d3-b57e-9dad21045e27@kernel.org>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Mon, 17 Jun 2024 16:04:38 +0200
Message-ID: <CAG+cZ06kzikieaD_JCBybwWk8XKZQjJxa34Cg4QHxrxpT+j0eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, "J.M.B. Downing" <jonathan.downing@nautel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 2:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/06/2024 11:33, Piotr Wojtaszczyk wrote:
> > On Sat, Jun 15, 2024 at 12:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >> Do not attach (thread) your patchsets to some other threads (unrelated
> >> or older versions). This buries them deep in the mailbox and might
> >> interfere with applying entire sets.
> >
> > I'm sorry about that, it won't happen again.
> >
> >>> +  dma-vc-names:
> >>
> >> Missing vendor prefix... but I don't really get what's the point of th=
is
> >> property.
> >
> > Is "nxp,lpc3xxx-dma-vc-names" acceptable?
>
> No, because it does not help me to understand:
> " what's the point of this property."
>
> >
> >>
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>> +    description: |
> >>> +      names of virtual pl08x dma channels for tx and rx
> >>> +      directions in this order.
> >>> +    minItems: 2
> >>> +    maxItems: 2
> >>
> >> What part of hardware or board configuration this represents?
> >>
> >> It wasn't here and nothing in changelog explained it.
> >
> > That's information which DMA signal and mux setting an I2S interface us=
es.
> > It's a name (bus_id field) of platform data entry from phy3250.c in
> > [PATCH v3 3/4].
>
> platform entries from driver do not seem related at all to hardware
> description. You know encode driver model into bindings, so obviously no-=
go.

In this case platform entries do exactly that, they define which dma
signal number is
routed to peripherals in LPC32xx. They describe hardware capabilities
of the pl08x dma
and which AHB bus the dma is connected to. This was carried over from
linux versions
before DT was introduced.

>
> > It's used by snd_soc_dai_init_dma_data() in [PATCH v3 4/4] to give the
> > dmaengine a
> > hint which dma config to use. The LPC32xx doesn't have yet a dmamux dri=
ver like
>
> and if I change driver platform data to foo and bar, does the DTS work? N=
o.

They shouldn't change the same way as expected dma-names shouldn't change.
Lots of drivers expect the dma-names to be "rx", "tx"

>
> > lpc18xx-dmamux.c therefore it still uses platform data entries for
> > pl08x dma channels
> > and 'SND_DMAENGINE_PCM_FLAG_NO_DT | SND_DMAENGINE_PCM_FLAG_COMPAT'
> > flags in the devm_snd_dmaengine_pcm_register().
> > Typically instead of this platform data you would use regular 'dma'
> > and 'dma-names' if it had
> > proper dmamux driver like lpc18xx-dmamux.c
>
> Exactly. Use these.

Then I need to write a lpc32xx dma mux driver, device tree binding for
it and adjust the
LPC32xx I2S driver for it. Is this a hard requirement to accept this
patch set for the
legacy LPC32xx SoC?

>
> >
> >>
> >> Drop.
> >>
> >>
> >>> +
> >>> +  "#sound-dai-cells":
> >>> +    const: 0
> >>> +
> >
> > The "dai-common.yam" doesn't declare a default value for this so
>
> Where is my comment to which you refer to? Please do not drop context
> from replies. I have no clue what you want to discuss here.
Well I didn't remove the context, you said:
"
Drop.
(...)
+  "#sound-dai-cells":
+    const: 0
"
So I'm confused whether the "#sound-dai-cells" should be in the dt
binding or not.

--=20
Piotr Wojtaszczyk
Timesys

