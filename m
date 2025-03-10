Return-Path: <linux-kernel+bounces-554188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BAA59431
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C311881F35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA5226D11;
	Mon, 10 Mar 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qg615k3X"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B92253E6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609474; cv=none; b=n47vZiFsJbZX7plhbrP6RgV0SkKIBcb1C5jwUtLjNx0218UUw9T+46wjmwBdyrYLKfybC1C/5pwBI9SwXLcuYq0Ap+JotF3Y6D+1H4AdzrpqJtMSCqK/cr7OFDL6DPua5tUpoNGQyXcIwD/s8mPwQCgS3zMWEWWzSuyZ8JAaxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609474; c=relaxed/simple;
	bh=ezOfzjFdYGlLoQAyZoe/ywMFL5iM/T7GC4EdJXi45wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4s20fpvKzQDsPSed4kNmow2oUQwC+2ah3VBoC5kxhFllVByvCxN1ba2nY63gPRJvanzWwvVE+hy49/ApA/jxxcdTivQDTfhTLpRWTuJcOOwJueUWI/TXR90mI31wwgU3LZaOdV33zgS5T+91uCSNyOOlxQE+usf6IhsD0L+7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Qg615k3X; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e63504bedd0so2999286276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741609472; x=1742214272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ND2kqJOrUJ4yzGsa9gnO+yqtj6hclSewbFNs2ty9z4=;
        b=Qg615k3XR2da93bp16k7Co3Xf8xiaQukaGouBR8GCPbYOB01sfJWVSYwZrJzcbHzCL
         35fL3ApRStXe8zl17PQ9eSzfXF6QLyNrO3JVO+N1Lwtc3RmbURD5fvmI3wbXK5AHOznQ
         uTrvmmia5vMweQmFvv7wEH9PUmmicsL7Uieao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609472; x=1742214272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ND2kqJOrUJ4yzGsa9gnO+yqtj6hclSewbFNs2ty9z4=;
        b=MevFHihJSr2sS/zkH0zolKYSdvfRYUT41dxYiuDhGe86nhlQ4LE4u7Urk2qqACRiS0
         tLSldIIWcwxJ4QO6OrxD5P5DIhTgLHKH6EV3PNR8Vn96htVMqMb2pCKqi8UMC7o/xElT
         EbqgVvJN473+QtH5IJGKEfBR7XRwmllJ1P+JHJqoBcszKCWiadY3Ln5p6975TJRVOt+y
         qYc74RH0E1PORBEH18DaxAqVydOhky3F5sal5ST/q24KYbNgoqJo2Y1njTsJTq1lHP1W
         ozD+TlveiO87/RwApFmjlw0b+EL1JehCVyPQQiam9csEDtrudQDMjJN+283NO+5s96jA
         Ejzg==
X-Gm-Message-State: AOJu0YzJbdGPcYOuS44jT1FEUTxRRd7DkjKvxwZfJa/QoR5fmMHPsZG4
	Iwswla906XzZ+SYRggNSsZNudrkgCfc2IZ9I9LcVoMunY2yD6TXzagUxaXaHUqqFlDNG6LPUhV5
	QpiRa7n2OrtPQTJbQHf3/4d72xYOXBQt2DOHeEA==
X-Gm-Gg: ASbGncs/NXehOPelyYpC5T8XmpU0QJThleDPQ3BLUfOY+4Vm61eRNef3Lfukl28Ao8w
	lFXyg76xJgOiaugCUb6BAaw8TEn4Ll3dC/INYqIQqEgZCoFtiuxg644ipdjpd2FCKMA2jDNLzVs
	hn0yUFJP3Y3MzY3M1a6W+f5sllsBd3
X-Google-Smtp-Source: AGHT+IH0tHXGp9UeHGxfrLbUzZnkh/DxT1q5vNyoFPhPKc+dkvw3h1KG8wG9Fqv0xSyH4YITslHYsvlvq709Vj41Cn4=
X-Received: by 2002:a05:6902:3388:b0:e5d:bcc5:c33a with SMTP id
 3f1490d57ef6-e635c1dbebdmr14201756276.43.1741609472105; Mon, 10 Mar 2025
 05:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com> <e5a5dd9b-475b-4c66-a580-08f11a80e5a3@foss.st.com>
In-Reply-To: <e5a5dd9b-475b-4c66-a580-08f11a80e5a3@foss.st.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 10 Mar 2025 13:24:18 +0100
X-Gm-Features: AQ5f1Jpjge_vQvtcg2fYtLcCxKDZuRZi6uFbkDzRqCoH-Q0HlGPggWhyZjwoZak
Message-ID: <CABGWkvpM+MbC=W1Z2yVnQiCXznVKXXv6ijn0dw8AGup8Wuyh0Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: stm32: use IRQ_TYPE_EDGE_FALLING on stm32mp157c-dk2
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Mon, Mar 10, 2025 at 11:50=E2=80=AFAM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dario
>
> On 3/1/25 12:51, Dario Binacchi wrote:
> > Replace the number 2 with the appropriate numerical constant defined in
> > dt-bindings/interrupt-controller/irq.h.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >   arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/d=
ts/st/stm32mp157c-dk2.dts
> > index 5f9c0160a9c4..dcf17c493022 100644
> > --- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> > +++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> > @@ -11,6 +11,7 @@
> >   #include "stm32mp15-pinctrl.dtsi"
> >   #include "stm32mp15xxac-pinctrl.dtsi"
> >   #include "stm32mp15xx-dkx.dtsi"
> > +#include <dt-bindings/interrupt-controller/irq.h>
>
> really needed ? as it comes also with
> dt-bindings/interrupt-controller/arm-gic.h

yes, you are right:
         stm32mp157c-dk2.dts
         --> stm32mp157.dtsi
               --> stm32mp153.dtsi
                     --> stm32mp151.dtsi
                           #include <dt-bindings/interrupt-controller/arm-g=
ic.h>

I'll submit v2.

Thanks and regards
Dario
>
> >   / {
> >       model =3D "STMicroelectronics STM32MP157C-DK2 Discovery Board";
> > @@ -67,7 +68,7 @@ &i2c1 {
> >       touchscreen@38 {
> >               compatible =3D "focaltech,ft6236";
> >               reg =3D <0x38>;
> > -             interrupts =3D <2 2>;
> > +             interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>;
> >               interrupt-parent =3D <&gpiof>;
> >               touchscreen-size-x =3D <480>;
> >               touchscreen-size-y =3D <800>;



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

