Return-Path: <linux-kernel+bounces-432690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471A9E4EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15E6188071E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7F1B4122;
	Thu,  5 Dec 2024 07:39:42 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248719FA7C;
	Thu,  5 Dec 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384382; cv=none; b=KMATo7HKZ2MhlQ1YFd7WkeFjyDCOB5d89GfQ8O/myTSxY88EtLloqLNpOmx8iAfYR6HnLrYtARUBM04yO+Z8Ku2Zdh7VOblwTVYzAjSxHTl1o7cna/9zPfDgWjCcx3kwNpyVS+2rFLiOhFxtU0lFFFzV01QhvE3INdei8xjKqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384382; c=relaxed/simple;
	bh=UUx7Qubxx4GnAWHZgQwjgtRTgGXGDcZjSsTPqDDDgeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qyc1ZOlo11uL9AOgZqZD2vUZPHl7spIeGjo4YLu/A1pDhgk8l9flxkmXGs/6QYpy+/nM/XGB1r3UAnYwAZeVrNHnUZWu2B4HpXSGj2go49QvOxp80+N1m1caPPa8mvvLjz0uz98AkFZK4RLpQ65foQE5wtGmTrnARWXxmuGIKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df119675dso801459e87.0;
        Wed, 04 Dec 2024 23:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384377; x=1733989177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haUzoOdl3j5ZhKh6v9Mp+uyoSF/yENN0p8H5q1O4kPw=;
        b=WVMeOGzoc+GwHUpR/aI23/qye1uJvLbBsLXcsoDhYiOejhnW49thOsPVM2tN6VzsSp
         RpjEHb3NGg/VutXvvq3KWj20ocf9jubPSmp1TdegaL2fIv5dma316AD5KzzGFmChOQ6U
         yqKmKfTksZfjF1KMDzMhLf62/T+IhcTNOXQhGwiDidYNjxYroScTpwX08hr7dkdzXIwZ
         Jn4FndaDE+FKNoi/6PsYjXEpsNGbqoQNzXAywKrPwsLCPz+BrLfLU44Ja0YSKhJhnqrr
         o2X84miEhgvqb5aCbfwkAYmmaDw8kfVtlZmGqoP50BS7rRj+iOYMtKTmrGhsebfr2a+1
         0RHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy6xW6IuTuWH104dzCfuG1hy5dHSqtY9KO++ajD1hyEmUHiH9ABjSb7GLoehT0CzaeQOmMVtCWsVtyyBq1@vger.kernel.org, AJvYcCWYvOKCMJvsB2baMelaXF3tk/+TfOip0DI0EJ3oujksHiIa2SL8C9tkbDY0cUjU7K5y1IbeuhMS9q0J@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCLuQiJTS8yxFqdPWa05ZKKmAp0XdJhyoLq/ofaxW2L7EYTjq
	qJnj9iYEfb0iINsTxuyDfyJ6lymmsQyBadiQFcWtpvbb+Y2vPgIRXdCBNFG6
X-Gm-Gg: ASbGncuGtdzZatJrNrHOyCY9/AvZz1eY3hzolb/jbviWB6ZYLbkwbo+Bn5M8SWdhaKY
	N8c8bSDc7gwq2YbFAGe+qy7Z5a/gB3RRiKNBjo/4vGLyBv7GbaozzBWYI7e85HHrLBxOcT8iR+y
	OKQdT6TVnATgyDSv/iMpIuIgZ04cX+VPMQaNqVGBasJen0rIcIjQvevVRrZHS9KYwXry+BKb1Jw
	YD+n12SUi/Jcx2L2E9U3FcpUojixG63O0co5vCO99RKE0xAqS9QybGfghF1RWGTc//9oy7Jagr7
	+P4D1hE=
X-Google-Smtp-Source: AGHT+IGIoISwZgxWoOrR8XB8iF/PuOIVafA7KMkeFjid9Qh7CO7uubcy/4Hen0CeoEo0ce+etMZ+xg==
X-Received: by 2002:a05:6512:1107:b0:53e:1959:3238 with SMTP id 2adb3069b0e04-53e1959331amr4884562e87.27.1733384377242;
        Wed, 04 Dec 2024 23:39:37 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba728sm146175e87.165.2024.12.04.23.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 23:39:36 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso4902341fa.3;
        Wed, 04 Dec 2024 23:39:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVB8RGT3LrafkBP0yZnu6psGebHxS6tQ/qNLQJTNMH9IfIgLlfoFw19EkDzrtuqhtcMZHkSAu4TtaCz@vger.kernel.org, AJvYcCXuvfuHr23XsOmWaAnrs8AUGyBB76HRAlIMeNi1sLbQSxZHSdvX4TfmkFZWvldrrUJIAEHiB2y68wKlpa3y@vger.kernel.org
X-Received: by 2002:a2e:a907:0:b0:300:8ff:d93f with SMTP id
 38308e7fff4ca-30009c50cb0mr55293541fa.22.1733384376650; Wed, 04 Dec 2024
 23:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203203824.23306-1-simons.philippe@gmail.com>
 <CAGb2v67Uv3SVQSqox85qt_05aVvX0oCynNRoaN9BA1Nha3eo8w@mail.gmail.com> <CADomA482XLFNySkjujoPmPCnCrKn+RcppW=SqRqcA2WLMe-mNw@mail.gmail.com>
In-Reply-To: <CADomA482XLFNySkjujoPmPCnCrKn+RcppW=SqRqcA2WLMe-mNw@mail.gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Dec 2024 15:39:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64YFcEhTYVzTJWTvw7CZ3XF08e7+1jiTg25HN6C1Ny+Jg@mail.gmail.com>
Message-ID: <CAGb2v64YFcEhTYVzTJWTvw7CZ3XF08e7+1jiTg25HN6C1Ny+Jg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h616: rg35xx add missing regulator-ramp-delay
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:26=E2=80=AFPM Philippe Simons
<simons.philippe@gmail.com> wrote:

Please reply inline.

> Ok I can do that, but the driver (axp20x-regulator.c) is using macros
>  to generate these regulator_desc structs.
>
> So I have two options, create a new macro with the ramp_delay, or
> modify the existing macro, using 0 for the regulators I don't know about.

You can add a new macro with the extra ramp_delay argument, and modify
the existing macro to expand to that with ramp_delay =3D 0.

ChenYu

> Philippe
>
> On Thu, Dec 5, 2024 at 5:16=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote=
:
> >
> > On Wed, Dec 4, 2024 at 4:38=E2=80=AFAM Philippe Simons
> > <simons.philippe@gmail.com> wrote:
> > >
> > > AXP datasheet says that ramp delay is 15.625 us/step,
> > > which is 10mV in our case.
> >
> > (CC-ing Mark for knowledge on regulators)
> >
> > If this is the property of the PMIC, it probably belongs in the driver,
> > in "regulator_desc.ramp_delay".
> >
> > The "regulator-ramp-delay" in the DT can be used to override this
> > if the board has excessive ramp delay due to other design reasons.
> >
> >
> > ChenYu
> >
> > > add missing regulator-ramp-delay to dcdc regulators accordingly
> > >
> > > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> > > ---
> > >  .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 3 +=
++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35x=
x-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024=
.dts
> > > index 80ccab7b5..b6e76a804 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.=
dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.=
dts
> > > @@ -238,6 +238,7 @@ reg_dcdc1: dcdc1 {
> > >                                 regulator-always-on;
> > >                                 regulator-min-microvolt =3D <900000>;
> > >                                 regulator-max-microvolt =3D <1160000>=
;
> > > +                               regulator-ramp-delay =3D <640>;
> > >                                 regulator-name =3D "vdd-cpu";
> > >                         };
> > >
> > > @@ -245,6 +246,7 @@ reg_dcdc2: dcdc2 {
> > >                                 regulator-always-on;
> > >                                 regulator-min-microvolt =3D <940000>;
> > >                                 regulator-max-microvolt =3D <940000>;
> > > +                               regulator-ramp-delay =3D <640>;
> > >                                 regulator-name =3D "vdd-gpu-sys";
> > >                         };
> > >
> > > @@ -252,6 +254,7 @@ reg_dcdc3: dcdc3 {
> > >                                 regulator-always-on;
> > >                                 regulator-min-microvolt =3D <1100000>=
;
> > >                                 regulator-max-microvolt =3D <1100000>=
;
> > > +                               regulator-ramp-delay =3D <640>;
> > >                                 regulator-name =3D "vdd-dram";
> > >                         };
> > >
> > > --
> > > 2.47.1
> > >

