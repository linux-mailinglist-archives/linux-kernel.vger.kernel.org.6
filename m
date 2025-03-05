Return-Path: <linux-kernel+bounces-546807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1BA4FEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E381890143
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394A2441A3;
	Wed,  5 Mar 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLQpFvYe"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE72E3396;
	Wed,  5 Mar 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178768; cv=none; b=OBi4eEfqGzhpiuPvmdL8BCx89kGMfn4CgRNUbdY5KKsBhnr2QqGkn6XXnMwdXgcjo0NH6S9TKMElOvmukTH1MhMcb/EG8SmPKXu4GApk3vAWt4+n2p8V707vdGRz+yhwUnGFdYQCEnXfC+0kZozz8MW+2W1rUU2mqtAyGi/nPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178768; c=relaxed/simple;
	bh=xx8JpjJPC8xYDKoDVOJwNq5GyjLhOLnf6u0v8a2NSeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVyLfY9T8p5ADf+tTevA5xMs39RR9snFdoLdNYjo7lkTFwS6u/N2HT9aCQGWe2yVx4pIbfVd8t46Zhq3RhSJ6nRTJZbPyxvSB+RGnqF2A9ZTyrZeIkXPjOimW33U4RlFP8c7Xa352AwJEdtfzfLs92KaWv85d95ZpLWCsajXlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLQpFvYe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2234e4b079cso123431685ad.1;
        Wed, 05 Mar 2025 04:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178766; x=1741783566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZhOmEpDhm76SJPq5OYpOzDDF0g2lT4rBhjCoTGHE34=;
        b=BLQpFvYee5o9JLTUmNAR4oG8A+aopqFUfD77x5yxXRfK871LUZS7hJib92fBxwjfAr
         Skh6QLDnvGTVJjYkDyVbsuK8nFInafuXfl4/G4QONEpTSgiudCzmC6VCCWgGMTXW2cBL
         EBTOLjaIkpPfHInQK6YWiLAMoqjwD2Nxkk5MYZTUFyFuWglPvMooiQLjoXciUBXiFUOO
         YNlyolofzP7APtrQ3/sb8A1Fvtiz66angP/HnChDX1fY9FtsAJsCy3DkygEdomMVezgu
         Ln2Wn81oFXEffKVHZ7c7cL+pIRwVafjMp7zokB88UKzXMVTQCO1V8p1wuc/25f9YXyTa
         ZTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178766; x=1741783566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZhOmEpDhm76SJPq5OYpOzDDF0g2lT4rBhjCoTGHE34=;
        b=WsLxyChz4rLGXYFzyH7AwPFr0u0MisNFgt4KDYu+D30Qg3Uyjq3BJ0f7vqiDYb8X1F
         Evwm0JTlA9JxlGYgzw8ivL61rhOLL9BxyJ66h62RePsO5ZDyAbaU3NuMYtgpC+3m+HXP
         2cPbG6KkwCBDgEhWYJfIqIKMS3e4/y7LmIg9/VlGfuAZNdSr1bXYyUgVgU4zQ6rUD/CI
         eF3HFBnuSS6sJMJqSbuWFKt7ySIZoZvCYDxwuVyjy+E36MLUwyp1XPhw8D5qNgv9ux1M
         j5CplclM4k/KWDwMd11MuqGKac5PQsRK+zRP1lF/yrDW5iTqI+bUtM15cgeLbQpy+1Oa
         O15Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfoc5kbHjyjbYaHJrRhFe33QKcBCtTvPV8Zr8vtqZkMYNJPAyyvTydD4MMxfUsBcTvdDqSy2QkcfFR@vger.kernel.org, AJvYcCVJqXjJJit4GYdNdjiWI7xsbEgMWT1eECjC9MArtsNGQgndddzNFOuDG4sYl9qr7KMORYZuMHe4rrts+0DM@vger.kernel.org, AJvYcCVatLH5MTz7C956s+722jzazRwP57fB0Y77DmoE0sbS1cRJcsNIr8c2ptBVXZmSMgikbYtUPcSDRlET62M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl86Sy8NzArbDdj6XTr2hiz8joLOLvRQqrdmpka+Hk15YYL5Xl
	SM+NARud8dt80KEUzkjHeqccM7jH6J1a9+Kd6njR5pJHDQNfspWTfiZReWG0U5hY/OZARR3LonB
	9zHl+G7P4/pIO1VdIlKYi/Nee648mAN4s
X-Gm-Gg: ASbGncuJcRFRCcjByhxwS38zYZEvawt+F1HAHFLOgKAX64qsV3laoHQYXW0DE9jZIu1
	7RE4i+bFmge7RvNFzNaXCm/B9nf68XKoKkdisy7lu/bqy3GU27q7kFBWNiEd/4MzcK+SwLRXGQR
	XxBaToQU+1xoUiFjQwep0BxVk=
X-Google-Smtp-Source: AGHT+IHdwW4hQa2cLPlWYrU5ue4mWciZc0p5rQqeJ2JBGI1XN4w7WGoKToi7KE7C9eD7Ld4Askkac6qqdMHiE8X06ik=
X-Received: by 2002:a17:902:ebc1:b0:223:f9a4:3fa8 with SMTP id
 d9443c01a7336-223f9a457bemr25544855ad.19.1741178766361; Wed, 05 Mar 2025
 04:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-2-florin.leotescu@oss.nxp.com> <Z8cp1xoIXT8lgD8T@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8cp1xoIXT8lgD8T@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 5 Mar 2025 14:47:45 +0200
X-Gm-Features: AQ5f1Jq_yZI7Qka024KvL_NkiadJQvrOZEyL3YURWLhpyxIxGw7rSu6jJaSDwjY
Message-ID: <CAEnQRZCT4vfFBApv+C3Wp17Fk0-Rwx36h4eCTTygaXFYFipEGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml schema
To: Frank Li <Frank.li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, festevam@gmail.com, 
	Florin Leotescu <florin.leotescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Frank, Conor, Krzysztof,

Thanks a lot for your comments and help.

In this initial patchseries we only add minimal OF support and
introduce a minimal binding.

> How did you pickup the maintainer entry?

We got the author of the first commit for
See 0d8400c5a2ce ("hwmon: (emc2305) add support for EMC2301/2/3/5 RPM-based=
")

> If only one reg You can go through trivial-devices.yaml

This is not a trivial device as we will add some specific properties
with our next patches
(e.g polarity etc)

> Missing descriptions of the fans, no?
> missing $ref to fan-controller schema.

Do we need to add this now? As this is only the minimal binding
support. We want to add that
in a follow up patch when we go into specifics.

> The emc2301 label here can be dropped, it is not used.

Will fix.

> The nodename should be "fan-controller", not pwm here I guess.

Sure, will fix.

On Tue, Mar 4, 2025 at 6:56=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Mar 04, 2025 at 06:21:34PM +0200, florin.leotescu@oss.nxp.com wro=
te:
> > From: Florin Leotescu <florin.leotescu@nxp.com>
> >
> > Introduce yaml schema for Microchip emc2305 pwm fan controller.
> >
> > Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> > ---
> >  .../bindings/hwmon/microchip,emc2305.yaml     | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,e=
mc2305.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.=
yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> > new file mode 100644
> > index 000000000000..cac0075a65bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip EMC2305 SMBus compliant PWM fan controller
> > +
> > +maintainers:
> > +  - Michael Shych <michaelsh@nvidia.com>
>
> who is it? look like not Microchip and hwmon maintainer.
>
> > +
> > +description: |
>
> Needn't |
>
> > +  Microchip EMC2301/2/3/5 pwm controller which supports up
> > +  to five programmable fan control circuits
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,emc2301
> > +      - microchip,emc2302
> > +      - microchip,emc2303
> > +      - microchip,emc2305
>
> According to your driver code look like all compatible with microchip,emc=
2301
>
> oneOf:
>   - enum:
>       - microchip,emc2301
>   - items:
>       - enum:
>           - microchip,emc2302
>           - microchip,emc2303
>           - microchip,emc2305
>       - const: microchip,emc2301
>
> So your driver just need one "microchip,emc2301" compatible string.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        emc2301: pwm@2f {
> > +            compatible =3D "microchip,emc2301";
> > +            reg =3D <0x2f>;
>
> If only one reg:
> You can go through trivial-devices.yaml
>
> Frank
>
> > +        };
> > +    };
> > --
> > 2.34.1
> >
>

