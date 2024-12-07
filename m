Return-Path: <linux-kernel+bounces-435982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC89E7F58
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8F18849C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6713B293;
	Sat,  7 Dec 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGNeLECM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBBC200A0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733563143; cv=none; b=Em7ojmDveIH4aq3WB3eV6IsYjAwPQqvG+YVWpjcBdt4o35C4zang0r8BGydDzTzuiV1sHXQGHgRm76E/SM/HfsTQB9+Aa07LnypmJIGXMShx2rRzFZ90sidM61kwBbAzeZysSp7ymIhBpeEE22+EN8IYhgnmdResZwICAQo8lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733563143; c=relaxed/simple;
	bh=RyI1e/xEsZB3eSr3Qnpn3wWB2TssDvq5krwkcCHrEBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL6c/eCTzlgVU5G7yfZ6NmmXZuzM2S4fOc6PUMqLyB0tb9T4ERgqldA9XoF7KBswUYbXfFxHB65etbvGO7qhCwAcNfpAOLJE3cUtFj9ipdfiXLAwUM3ZgihJ4kmZ6RsDnRsbTjo4iF3brGlTokUlIvM0D7djz0G11sfpajHEn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGNeLECM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so3144427a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733563139; x=1734167939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+rq0wqxgxu5V2euZftCo8lD0SkMR0CJM33n+ojyr84=;
        b=lGNeLECMLrU0Dx5woCFHqe2XXQqJ/pmyDbP26kirSjQGXQ8+R+n4JBFY5vXc36hTpR
         gQlGxJg04e3WeXP61WZ/IKWSnaK/2yXuPc1ydXQkC37GR63nQ9vJ+gpVq8KuYWVsmLze
         U42nPbPzUrAEKMjbIz43t6AUl25ITF7csJVZlPSPUkJmJvYSQiV2nvxlnjaa4J9Wv7Wq
         IxmlV/UbSBNOxjSQ6LFCoQq94lWq4BOQ8E/3w705cZlBrh4bP4Lc8BdjoI93GMZ7JKhM
         HWOpkJ25KsANmdtQtC4zLowyxpElhME/hBZx+Hx01na24Qv6+bvPrXY80R3dHuSuzRpY
         1RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733563139; x=1734167939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+rq0wqxgxu5V2euZftCo8lD0SkMR0CJM33n+ojyr84=;
        b=ZNSH0l1X4Jj01PxP1GbmWfFyfsgOdO6cANtmKcJ9xCv6w5R+JcwjNXrAGHqJlGJIae
         kj54f6/XtIurtszO7L2B/vuH8pW5TaOMogZdqLiNR/hZy+0DlOwAFfx3D3tx7WTwJe/S
         m7XunBitotATG6aGdz2yoh2Jp0teppyzGkAlGSNS6yNvyvxoLjY+tqUnnDQdVpygw/Lt
         TzE/Y4UaW0zAdlWyl4n6qJStM736ZtwaM0UuogzgwUPZO0IGyGH336VjP50yHVB2ABKW
         X69peTbsWvHCEILoxUkWAafSPrJNqfQfSBIcMxussc0dXraDAUIO+LZGtZjaSQozzCYX
         xHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUdTTBmp2kYE3B4VJcKbLzkqVsPm78TV52+2xDNeKm9TtE+V7+IJSQ7zu0hGZXc0q6DnfN+Qfh702D1mE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwk0FUeaLmJ9a5T2+8klm/J+e1lN2iOAacJdu+SLoUPITAdfk
	2RsZgJLhnGz7hqrUSjOUXM4JcGEH78MrCq3GlrNrjp/9yM35jFd1lgC3Tz41teNGjRuVeYVGQ5T
	2VTLkDrZU3Ri6EljtFcq5HEHXR03Y4UaMPQI=
X-Gm-Gg: ASbGnctcKVw0wy3i/P7Q90j5DNbyVwBaG/jh16NN7s5B4tbxN24zKDbjNrV5HIRKHyS
	NSo/oH2O8tx8l8naXdNs8RfZsZhfjrZ0+
X-Google-Smtp-Source: AGHT+IHBikoFSiZ219zOdeuiZqWopGmJN0hSRJUzNdNr9dVXJpmrCr9XNiLU9E6VT0jh17f2/SIaBmEhmcrpQlS7d8A=
X-Received: by 2002:a05:6402:2115:b0:5d0:8197:7ab3 with SMTP id
 4fb4d7f45d1cf-5d3be6bd82fmr4442087a12.3.1733563139263; Sat, 07 Dec 2024
 01:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206123751.981977-1-simons.philippe@gmail.com> <CAGb2v66rd8AVUsTKG6Eic99fDmFxG95EtRsYrCoXhGrxn9EyFQ@mail.gmail.com>
In-Reply-To: <CAGb2v66rd8AVUsTKG6Eic99fDmFxG95EtRsYrCoXhGrxn9EyFQ@mail.gmail.com>
From: Philippe Simons <simons.philippe@gmail.com>
Date: Sat, 7 Dec 2024 10:18:48 +0100
Message-ID: <CADomA49gYKNGn9R-HaKFPQ77PR6vyHRHNYCJ=3iY_qyiTE8uYg@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
To: wens@csie.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 5:37=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Dec 6, 2024 at 8:38=E2=80=AFPM Philippe Simons
> <simons.philippe@gmail.com> wrote:
> >
> > AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> > which is 10mV in our case.
>
> Thanks! It looks like the reason the delay is needed is because the
> voltage ramp control feature is on by default on this chip.
>
> That is not entirely correct. 10mV is the smallest step forDCDC1,
> DCDC2, and DCDC3, so it makes sense to calculate the ramp delay
> using that.
>
> For DCDC4, the step is 100mV, so the delay would be different.
>
> > Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> > expand to AXP_DESC_RANGES_DELAY with ramp_delay =3D 0
> >
> > Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
>
> The ramp rate / delay is actually configurable between 15.625 us/step
> and 31.250 us/step. However the setting shared among all DCDCs that
> support this function and have it turned on. I'm not sure how that
> should be modeled if we want to make it configurable.

there is axp20x_set_ramp_delay() ops, but it seems to only handle
axp209 DCDC2 and LDO3

>
> Also looking at older AXP PMICs:
>
> - AXP803: ramp rate 2.5mV / us, on by default, has register bit that can
>           polled to check for ramp completion
> - AXP813: same as AXP803
>
> - AXP805: Similar to AXP717, where rate is given in time / step, the
>           options are the same two and step is different for different
>           buck regulators; difference is not all buck regulators support
>           this feature, and also the rate is individually configurable
>           for each one. Off by default.
>
> - AXP223: 1.6mV/us or 0.8mV/us; off by default; only two buck regulators
>           support it; individually configurable.
>
> > ---
> >  drivers/regulator/axp20x-regulator.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/a=
xp20x-regulator.c
> > index a8e91d9d0..8f035db13 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -419,8 +419,8 @@
> >                 .ops            =3D &axp20x_ops_fixed                  =
           \
> >         }
> >
> > -#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_vol=
tages,   \
> > -                       _vreg, _vmask, _ereg, _emask)                  =
         \
> > +#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, =
_n_voltages,     \
> > +                       _vreg, _vmask, _ereg, _emask, _ramp_delay)     =
 \
> >         [_family##_##_id] =3D {                                        =
           \
> >                 .name           =3D (_match),                          =
           \
> >                 .supply_name    =3D (_supply),                         =
           \
> > @@ -437,8 +437,15 @@
> >                 .linear_ranges  =3D (_ranges),                         =
           \
> >                 .n_linear_ranges =3D ARRAY_SIZE(_ranges),              =
           \
> >                 .ops            =3D &axp20x_ops_range,                 =
           \
> > +               .ramp_delay =3D (_ramp_delay),                    \
> >         }
> >
> > +#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_vol=
tages,   \
> > +                       _vreg, _vmask, _ereg, _emask)                  =
         \
> > +       AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _=
n_voltages,      \
> > +               _vreg, _vmask, _ereg, _emask, 0)
> > +
> > +
> >  static const int axp209_dcdc2_ldo3_slew_rates[] =3D {
> >         1600,
> >          800,
> > @@ -781,18 +788,18 @@ static const struct linear_range axp717_dcdc3_ran=
ges[] =3D {
> >  };
> >
> >  static const struct regulator_desc axp717_regulators[] =3D {
> > -       AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
> > +       AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
> >                         axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
> >                         AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
> > -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
> > -       AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
> > +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
> > +       AXP_DESC_RANGES_DELAY(AXP717, DCDC2, "dcdc2", "vin2",
> >                         axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
> >                         AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
> > -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
> > -       AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
> > +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1), 640),
> > +       AXP_DESC_RANGES_DELAY(AXP717, DCDC3, "dcdc3", "vin3",
> >                         axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
> >                         AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
> > -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
> > +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
> >         AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>
> Can you also add it to DCDC4 for completeness?

I'll do in V2

>
>
> Thanks
> ChenYu
>
>
> >                  AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
> >                  AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> > --
> > 2.47.1
> >

