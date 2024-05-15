Return-Path: <linux-kernel+bounces-179517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B018C60B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED06282E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127E3BBD6;
	Wed, 15 May 2024 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Ao+R/+i6"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8F3C488
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754086; cv=none; b=G0mABWUUv71+6UFsfDy0jaxgHu3uYDylJpEIIPZ7oOxPfdU44woPCmOyqOnPuHATgNXU27nyB0vRua0oD3HirQjQUtWkBvHZ3FrJOXMQVUOiYJ7C5YaN31OWT2/VJl2AwR+iC7gBNdbSRJynxLQGxmWYNmxZJhzcNp6TdCLl3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754086; c=relaxed/simple;
	bh=kcQJvLCc1/I2+fl8rDk29nGaXS9kvZzyvViOdGCrMAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0EZCbZZ/iENHvj9n67feHwzTfJp0QYjIYNpxoB5Hb7GlZs/3UROtx0+WnXYBEz23mhfXdtuzbY72Gul9TMKjeTeSaTpSOVUUKlRymVrvRz9TJFTNsi1U1/C/LT0FgA+0UQZ1hS27aJAs78p9MfH06cwYMhpTpnLZuaecBgHAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Ao+R/+i6; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e1b887c488so158339039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715754084; x=1716358884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pewL15YSqYyntUzZ2YESL84hcx8HG85YGqfAIHHWdj8=;
        b=Ao+R/+i6Qa7XP5HRhcm4D1cueKOHXeIy9I4EoO6b5srOFqlnJt5PQQypmSL6jqJ/BS
         h2dJYYjDahqeUaOpqE66CVN/adaH7oLwU4M+Re6ESrrikxu/UasMYxrd8n04E+gc6ECY
         TecwGoyeY4KSWcD1WygOmFAZnRqByaDmJHO1ycSf0Fibpk8GktwRf9QiO84LjIrCyNMD
         pZZInTy7peah/wJQh9uMlW3mc+nsA1p+cPldMFuX1A5MpL0kyQytc6mN5O9LmExdFd/K
         4QqvfTRuydVL0i9JR1OHzkwRlfqUbizFdF0/6ptnJJY8BnANfh3oAlPyIXIXUjeBKz7m
         Yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715754084; x=1716358884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pewL15YSqYyntUzZ2YESL84hcx8HG85YGqfAIHHWdj8=;
        b=fy2oC4kYB+ps1xjlby/J8QqQ/C8DQFnWUjgtHxILkVlDOf60Kqm7OF7+DXgu0DIW2b
         io7wCvZECfIll5TsFuGrQm8niNiRdBDtY1iDhLF4A6OZl/yLIpEDtPvCEjVBYfN8XrmZ
         zqKJp1rFi0sxNGBHhP83zci2zuaFEZJDo8FDF4tbc90fULKhV4e9aMUmqoaZfjkq62k2
         jdBH9StGWs3hciv+fbCc03I4KDrYX92sLSjG3jA9RDpnpqgpRNEGSCzkJ5BEBQdZDveQ
         JZ7Ga95Gjgj3gtdNJ+Kh8mLKpkYjVmOSJw5bsnJGnh2kzHqQjKLSthMNXtGIyNJCL2Qy
         1+GA==
X-Forwarded-Encrypted: i=1; AJvYcCWQJqxoy20rJeYh6Vgobext8bsTGn+ahgRUnv/uFXjhuAKqidtr1kDAjsEiB8cz7WAXcsUHddj4w1uPv2q+a2CLhv/KhKf2bZoO1H13
X-Gm-Message-State: AOJu0YzOauh+N+AzXdG8aTsluC7SC46L75IlMyGlChyhEumCA9DO+ewC
	bSrpZs4Zi46b9UXeTjk0lxrfwkj1QMFfBWNWBALmwne+JJmR4ZU8LuorGxaKW9TuIJi18RSFRZg
	6/yaXPSwDcuDtCljo6FQM8Jd8Od/Ga335xx8T8g==
X-Google-Smtp-Source: AGHT+IHj1X7ctGdv9YJkalDZLMbFRUyxyYp6gndkUfhYp5Mhxyh+tcKm4XPw8K1pSADIXlV0LoBEwCYK5xLJibmm7LI=
X-Received: by 2002:a05:6e02:b49:b0:36b:aae:613 with SMTP id
 e9e14a558f8ab-36cc1319624mr127252835ab.10.1715754084373; Tue, 14 May 2024
 23:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <IA1PR20MB4953F852CB7A9C5FE45E18EBBB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAAhSdy2uSAA4TLmCvjuLsZT26wJyCQ0L61m5vg3BbBCSvHxVqg@mail.gmail.com>
In-Reply-To: <CAAhSdy2uSAA4TLmCvjuLsZT26wJyCQ0L61m5vg3BbBCSvHxVqg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 15 May 2024 11:51:12 +0530
Message-ID: <CAAhSdy2Fsu8PJH_+cPsFWQ8HmuPr_Ym-_YjnLKWtCqBLWTZ5kA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:49=E2=80=AFAM Anup Patel <anup@brainfault.org> w=
rote:
>
> On Sun, May 5, 2024 at 6:48=E2=80=AFAM Inochi Amaoto <inochiama@outlook.c=
om> wrote:
> >
> > Due to the design, Sophgo SG2042 use an external MCU to provide
> > hardware information, thermal information and reset control.
> >
> > Add bindings for this monitor device.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>
> LGTM.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Applied this patch to the riscv/opensbi repo.

Sorry, for the noise. Please ignore.

Regards,
Anup

>
> Thanks,
> Anup
>
> > ---
> >  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg20=
42-hwmon-mcu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmo=
n-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mc=
u.yaml
> > new file mode 100644
> > index 000000000000..f0667ac41d75
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.y=
aml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2042 onboard MCU support
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,sg2042-hwmon-mcu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#thermal-sensor-cells"
> > +
> > +allOf:
> > +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        hwmon@17 {
> > +            compatible =3D "sophgo,sg2042-hwmon-mcu";
> > +            reg =3D <0x17>;
> > +            #thermal-sensor-cells =3D <1>;
> > +        };
> > +    };
> > --
> > 2.45.0
> >
> >

