Return-Path: <linux-kernel+bounces-566432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A6A677F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296D417C682
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC74210F6D;
	Tue, 18 Mar 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9NHJEZW"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038920FA91;
	Tue, 18 Mar 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311905; cv=none; b=fE29ocDitBrVHuTOe0Zfl4GY0M8UNMeHfagBgaZ2vmTkXcONTuYn/H3Z0FHCXafRihMzFWKARW0noKHqZKD2JmAek0dQ18pHuo6YbGbXTOJCvPRPwdL97Mja7XxmVgsdiyecb6uY5yIcs5FTf1cin5B849VD8d7pelHkkAHhizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311905; c=relaxed/simple;
	bh=XoyQyut0B0I09grFpiG22mcD2dPJKh7wdni3ku4Ykks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws46JEVlgitw/ZGJaZ8GkCJCSgkaaxad/8nejCpiQXeEvc9a4Lz30MMsG32i9doWFn9CwW9nGLtfvu/ZIAhI31tS1Gx2FWZloaSr73CdKaoSqVezH/C5ht+vAjh2TJ0O+Kwf8QJhVILBPyj4Cx9mV4+OojA5RZAoylGzEkotEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9NHJEZW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so6473967a91.0;
        Tue, 18 Mar 2025 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742311900; x=1742916700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTo+P4IDj/egBTC39do6b+maTrxFfajRm+lC64dJAgc=;
        b=l9NHJEZWfL+lu2uGwppIHjdociNfYxjtlF6WPBmjQi/hVyry9O1jIbLxml5OdHTaEV
         09G98V9uOO04Lfh24xYx77DGBeFhgkhVhjRLpv4UNhEgvvSpWZq9tTTnxiPLqIcZZ1MY
         IDAgrLdRih2H/aY+pVJze/H5LQi3/D+BWPfMngCrkNU02wK50GmpXO9dX446srEWSc01
         NlLin3j9oX1WZcOJCWPAX99CsmWNqu48YOs+kgJyM5tKG7jpGzXPqbcRq/0Eziy5Clro
         yWEM8/grZZQJPFrnfPORGFjwAE7sqE+EzcEojXqjjzKJa5Ld5rc6FznkrdA7g7fPTCr8
         EEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311900; x=1742916700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTo+P4IDj/egBTC39do6b+maTrxFfajRm+lC64dJAgc=;
        b=C4PWvhGGvzGsHUQW+MHn/npCUo/FkBswI0Ab3tHso/pWJ4vgSP+I7aKWhIxomhd3RD
         9P6dXnh5L6uPPBXNqCn3K98fTV+YfKIFGeWsWxy3c41yKLkyDQwXwOIgFqbvguGZvSJ2
         e3L45vJHQQo3vlWC6CcG/Gs0Co0/RWWV2V9Xxe+HYYIFpOa8R+1Y1yny/ayJZAA5rcPS
         xIXB5guHJjqZLvI3AZR8C3P/qwBWBp68xe6fJBPGx1d+cwaX+keAZWqNO0ArkH5soJ+/
         rwCZrMCBw6IPoQEWbscq+NzdkrpDI7xyRmPxSrWVJX5E9SxlL1l8XP8uAUbEOxaZgsw+
         epWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2igniwEURY8Ic8TcI0mppBRMeczwxiKhn4+iqzgY5p2hIFcaiSJfP9Vz+JDlnx0RP5dQdK/PHa0LOfoTr@vger.kernel.org, AJvYcCWRjtbyOsdCU+h0APnSARf4FbxqjInKtljKt6AvtEmg9euiJtHwTZmoy2BxotRHByNZ5ji5uKAiByYj3w0=@vger.kernel.org, AJvYcCXgZpDJvAudKULDPaaRyKN1IEfoQAmDEsxXCGmUuNGYpxk0MGkHLT7QAUT62aObuFEklZhqU+FV1tuv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIccBnZd51er6P72hqcL2FDsuK+kKLAoiqZ9CKIAEDIuKgbzH
	z2Qm6s6l1gEc0oxwAPWRvlkPF5y87JYuxqCo3uJL7rdenFCwYdJR4MvJZqbpm7crzp2HZYy2vLv
	buBo0O2V4/VVBlfNV4wNasQKBowY=
X-Gm-Gg: ASbGnctRrZvTUJHE2qdUHMyitDGYy1DvIpD8kuRcOr+RqizDqU0eIAxr8Ug8yRZOpN9
	LOc2WsEn96NnOK0dEfRlQQ6j7AqA689MxW/KFdURNJHwqgAftDrAMbB5mb7eAp86zPCC3+JlnFX
	ge82ttamXPbLwR08KghzhVWmM=
X-Google-Smtp-Source: AGHT+IGev3FhJjE3AIdupTysEnxLQqIhHB0aNv4HFA4FSPqyJjajPwHMn95jdK7N+OLjNP3hIRsGSfPOM63dkEDBTf0=
X-Received: by 2002:a17:90b:3d86:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-301a5b22c44mr3891136a91.19.1742311899758; Tue, 18 Mar 2025
 08:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com> <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
In-Reply-To: <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 18 Mar 2025 17:33:12 +0200
X-Gm-Features: AQ5f1JrGT6OkXhZLmAGbs6dhzXtsxvJYdhcQucC_VGy8G_11v7e7DfbTPZDv1rM
Message-ID: <CAEnQRZBmYdLh29ha1FKz8=CbxjFBFFTgDkjrEmwTxW2WcxodfA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, festevam@gmail.com, 
	Florin Leotescu <florin.leotescu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:22=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/18/25 01:54, florin.leotescu@oss.nxp.com wrote:
> > From: Florin Leotescu <florin.leotescu@nxp.com>
> >
> > Introduce yaml schema for Microchip emc2305 pwm fan controller.
> >
> > Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   .../bindings/hwmon/microchip,emc2305.yaml     | 113 +++++++++++++++++=
+
> >   1 file changed, 113 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,=
emc2305.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.=
yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> > new file mode 100644
> > index 000000000000..e61ef97e63af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> > @@ -0,0 +1,113 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip EMC2305 SMBus compliant PWM fan controller
> > +
> > +maintainers:
> > +  - Michael Shych <michaelsh@nvidia.com>
> > +
> > +description:
> > +  Microchip EMC2301/2/3/5 pwm controller which supports
> > +  up to five programmable fan control circuits.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - microchip,emc2305
> > +      - items:
> > +          - enum:
> > +              - microchip,emc2303
> > +              - microchip,emc2302
> > +              - microchip,emc2301
> > +          - const: microchip,emc2305
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  '#pwm-cells':
> > +    const: 3
> > +    description: |
> > +      Number of cells in a PWM specifier.
> > +      - cell 0: The PWM frequency
> > +      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
> > +      - cell 2: The PWM output config:
> > +           - 0 (Open-Drain)
> > +           - 1 (Push-Pull)
> > +
> > +
> > +patternProperties:
> > +  '^fan@[0-4]$':
> > +    $ref: fan-common.yaml#
> > +    unevaluatedProperties: false
> > +    properties:
> > +      reg:
> > +        description:
> > +          The fan number used to determine the associated PWM channel.
> > +
> > +    required:
> > +      - reg
> > +      - pwms
>
> Is it necessary to make 'pwms' mandatory ? The current code works
> just fine with defaults.

The code adding OF support is added just in the next patch, so the
current code isn't event
probed when trying to use dts.

Or am I missing something?

+static const struct of_device_id of_emc2305_match_table[] =3D {
+       { .compatible =3D "microchip,emc2305", },
+       {},
+};
+MODULE_DEVICE_TABLE(of, of_emc2305_match_table);

I have no strong opinion on this we could make pwms optional.

