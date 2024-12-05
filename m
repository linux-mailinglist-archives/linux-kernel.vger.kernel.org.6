Return-Path: <linux-kernel+bounces-432657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B269E4E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D5A2865AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC141B0F0F;
	Thu,  5 Dec 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="immwk6wz"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68231AE009;
	Thu,  5 Dec 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383574; cv=none; b=EZiTugKaKNXkhctt0cHPEl8TyR+Y/HvS3+ojMXVQlWCeCk/KRbJ7RJ6291mJRdsoHH9m6mXkc4lJC8QUO+c2oM6nULsjcHm5ziNde7Bjyqhl5QQsh8GFr0jfPb7a6PnaKHjDDeGpWu70S8T5Q05AZIPVgAyBozIlyHsktyukKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383574; c=relaxed/simple;
	bh=Y2QaX9gVKGxNagsoDmEZMqVr4sqCCzk6oBiVfc2Cd0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS48mCeTJic1Cxty2/eYMj8GqkS7MggYZC9N+84/j0nVr1G/5mHcdGvGfMyoQ2YTTcrLvHIsGtN69tFHzJIi5CU22hw2LvckgjKRsDxDvU/PbzHhHKf1x6hb2CQFqky23egjIWM0LWVIXvqg0sbF9q+//Hfj9ZH+4DUv5NVzjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=immwk6wz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0419so573610a12.1;
        Wed, 04 Dec 2024 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733383571; x=1733988371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyamlqHI1fumzoheugLJdZAdLQLKXUTMBwxcQkBbITI=;
        b=immwk6wzexy+Z9ndStzZKSEVoC8KytAB0RpaJwNqNm5ucTRQcXSdmTv1We32yzhFWJ
         6Hr+9si8OXflp4+W+fALogtx5vfYB8QWU9MLHVmO2exYAEOELkUDLBHYcTnL7fYKrW8T
         dd0L1AACqW3+bPrSLIkPh1LSQ9TrevYFbH2gJoEtMzfaq/7QQoFX4cZTx6F0tyu0LCwn
         mX3qhMAD/JhLmVnGPXu1RqNMmwjQkAHj+RKDiVKlA6zrNpEWhrVPz3bgEnmbJU5mvcwH
         9siSS4eWBqB5atYnmUO/oI9lLTw2x/H/G4h+7b4tH2eVh6ST0Pd2qFSswZFN2cYeeeKr
         kquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383571; x=1733988371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyamlqHI1fumzoheugLJdZAdLQLKXUTMBwxcQkBbITI=;
        b=gTjuqYoBnYOXcEarmYYT+tp2JH7IJD1CwgPQqzPlOCgpf+Hj8OexdNdpqJUMuRP7iH
         8A1gQdEw77IVMTRAXJ4BJqW0MlV8S49Pmsjgx+ZsOvm9XtjYGyKySr1geUzNKGARmoyA
         dlhOj+BMimU529eRC416fNUuoa0Laz7NqyjbWXrhPfD1dSebEjmQzC12gctNpQPwG3YS
         PkF4DDQ+1iBNnkOkQwvDhApGUP2Z6m4SMZod9FLHg/C1Su5o+Un1il3pyAaUWCjeUvXq
         6waEFNQe6cUERAXIvLry1XequJ+mxKg4iSr33IH/iRd4J0BcZqN5r9Ip0l0fwM0Mw8SU
         AjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8V9hrGIGil5TKshGZa66oOh1Rn00jj6tw3fwS8NxPKOSFPFRTv4zpfwA4N1C+g7wNA36k5tt6N2zKYyG4@vger.kernel.org, AJvYcCWMERp+UMtAVEnAyozkcAcOeF/MGctEQApsGEzPdM09VzcRlCEO3tcYoXqCVEgwDp2S8crRKli23PLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+xNYnxgQj/Wf/KaaEUuJnIJHsfnpTgupc+lM/UiivfJL3XoI
	YoVpDhZ4UL0lkw4312JGtsYCK/IFg+B/fun00F+1d2EHx4VKTywN4utmfC9RpUyu11ZCivwfuEj
	BJeBchBBNC/2ML5SsMTiOm3W5DontBo28iqk=
X-Gm-Gg: ASbGncub7d/aZhFQNO7FfH+n5TYN0frygxHa3tO20zEEl3vMbI0tvvfvrCxYz3C/T85
	ihWLzPsmBRkx3UuLgMCPcxp6FZOXfPGHm8tlk
X-Google-Smtp-Source: AGHT+IEjjB6Yn5ERQ4OSD0aCIa1Del//AgoR//24wAIvdKXXlyvcU8djUAx+OKR/4R6Km+pIAmIVry+Wods3NVO2neI=
X-Received: by 2002:a05:6402:42c8:b0:5d0:ceec:deec with SMTP id
 4fb4d7f45d1cf-5d10cb55abdmr8598789a12.13.1733383570763; Wed, 04 Dec 2024
 23:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203203824.23306-1-simons.philippe@gmail.com> <CAGb2v67Uv3SVQSqox85qt_05aVvX0oCynNRoaN9BA1Nha3eo8w@mail.gmail.com>
In-Reply-To: <CAGb2v67Uv3SVQSqox85qt_05aVvX0oCynNRoaN9BA1Nha3eo8w@mail.gmail.com>
From: Philippe Simons <simons.philippe@gmail.com>
Date: Thu, 5 Dec 2024 08:26:00 +0100
Message-ID: <CADomA482XLFNySkjujoPmPCnCrKn+RcppW=SqRqcA2WLMe-mNw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h616: rg35xx add missing regulator-ramp-delay
To: wens@csie.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok I can do that, but the driver (axp20x-regulator.c) is using macros
 to generate these regulator_desc structs.

So I have two options, create a new macro with the ramp_delay, or
modify the existing macro, using 0 for the regulators I don't know about.

Philippe

On Thu, Dec 5, 2024 at 5:16=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Dec 4, 2024 at 4:38=E2=80=AFAM Philippe Simons
> <simons.philippe@gmail.com> wrote:
> >
> > AXP datasheet says that ramp delay is 15.625 us/step,
> > which is 10mV in our case.
>
> (CC-ing Mark for knowledge on regulators)
>
> If this is the property of the PMIC, it probably belongs in the driver,
> in "regulator_desc.ramp_delay".
>
> The "regulator-ramp-delay" in the DT can be used to override this
> if the board has excessive ramp delay due to other design reasons.
>
>
> ChenYu
>
> > add missing regulator-ramp-delay to dcdc regulators accordingly
> >
> > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-=
2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.d=
ts
> > index 80ccab7b5..b6e76a804 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dt=
s
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dt=
s
> > @@ -238,6 +238,7 @@ reg_dcdc1: dcdc1 {
> >                                 regulator-always-on;
> >                                 regulator-min-microvolt =3D <900000>;
> >                                 regulator-max-microvolt =3D <1160000>;
> > +                               regulator-ramp-delay =3D <640>;
> >                                 regulator-name =3D "vdd-cpu";
> >                         };
> >
> > @@ -245,6 +246,7 @@ reg_dcdc2: dcdc2 {
> >                                 regulator-always-on;
> >                                 regulator-min-microvolt =3D <940000>;
> >                                 regulator-max-microvolt =3D <940000>;
> > +                               regulator-ramp-delay =3D <640>;
> >                                 regulator-name =3D "vdd-gpu-sys";
> >                         };
> >
> > @@ -252,6 +254,7 @@ reg_dcdc3: dcdc3 {
> >                                 regulator-always-on;
> >                                 regulator-min-microvolt =3D <1100000>;
> >                                 regulator-max-microvolt =3D <1100000>;
> > +                               regulator-ramp-delay =3D <640>;
> >                                 regulator-name =3D "vdd-dram";
> >                         };
> >
> > --
> > 2.47.1
> >

