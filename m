Return-Path: <linux-kernel+bounces-566492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E07A678BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588AD3B4CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667120FABC;
	Tue, 18 Mar 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf0jiky0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05720A5E5;
	Tue, 18 Mar 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314047; cv=none; b=LhOmp5X/Nq7Xp3vCph4xj0rHeJE5VB+q8jBxYca1NuxTouxx3nNjmofAVCEhvx2EdRM7RneYi4iz/4FpkkJgiO4xBWpng1D0Rc1bU2mw/iYTaiv/GnPWyGLEZEXdOXtLKTQjzJ4934asDwY5cR2E5Quhp3A0/L2izbdjRe7o1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314047; c=relaxed/simple;
	bh=VFDJ6R20oErvJ1RvFC7kFeyiipQ7Njgq7oc2ScOfLV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ7dBEqggru525ELawkk4o/DPL7FiMtqfq3DrcxaidE/TdGU52LB22aMhpr/AMrV6+XKuQMiBR/lipzQUqP2Ugkea5dFDgC0uaoK/hGzp2qtSl7Eurr2Ou+JpLEElQQGhzAG9xnYlTxpBitHD4dm9LuZQ8/jts+PNCFKjJ9YAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf0jiky0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B8C4CEF0;
	Tue, 18 Mar 2025 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742314046;
	bh=VFDJ6R20oErvJ1RvFC7kFeyiipQ7Njgq7oc2ScOfLV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mf0jiky0HfSYAcke+XzksLCfXMxzRAKwid1cSMKa+/FqAs8b01hZrNy40ci0cbZR3
	 /GctjHeHaejSImKXrwkjZrCBfDK/1/JHyUSXaDFYhx0IrhfRf+cCx5Q7aTOQ2bQFwp
	 8XZF2MW/surd/uwO2j16xI06beN9nhlg+qnwrxkn3kzW7FEqcECyoHDT3SFFTQwZ1y
	 jfxawao9KpOXKb+XQ4/yd40n0e+mnDCbdfPJ6CQvnyWW8KFuZzlhP8Hk9mPn6araIO
	 VYjcBMx4YX5249UItUKUPyT1X4K5LuWMflP34XCADuZwWGMFrlZyAKAe/2chXszqD/
	 CqdGQ4cj5KXvQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so11228557a12.1;
        Tue, 18 Mar 2025 09:07:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdh4zPBN/hI+qrW1rlDs/LwpSIQwAbJhcAG8wVwU4rxJ6b0I/lPq322K7JMC3GGMpQTEt5zI2LTp9d@vger.kernel.org, AJvYcCWJKCNvVGmndfWBd7LixIbVJvzH0W97GTtX5OCtpFRQFtvM+lEL9VZVka+qYicj/2VC8C48qP036kGDF+Gk@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDeP8vuWJnuadkfUyDsTi6JAM11K6UeTseCeT41brSe0j6J54
	H/Hndrsp1/tyIpwey5Z4pmeYjdTBX97e7XoK9iKWrqWwy93WLSmo0IXhXW7FU2FgNZ2RvI+VyOv
	HZNrpeDtGBhpzlnta5gV/X/Xrmw==
X-Google-Smtp-Source: AGHT+IFfnNV/DMQy8HRb/U6rr2KEZqHbalMfe7H6o6yIu+IcvHNe5Tqpi/2irnP5g7ZQWivPIchyuNgNQlRu8Y5ZLIo=
X-Received: by 2002:a05:6402:3514:b0:5e0:8a34:3b5c with SMTP id
 4fb4d7f45d1cf-5eb1ed8f4e4mr4278576a12.0.1742314044717; Tue, 18 Mar 2025
 09:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314081255.3718-1-nick.hu@sifive.com> <20250314232518.GA2513550-robh@kernel.org>
 <CAKddAkCL1qKG7dRaVDAO0HCdsEiRR3NxOEka8aFONvkXnZ5j5A@mail.gmail.com>
In-Reply-To: <CAKddAkCL1qKG7dRaVDAO0HCdsEiRR3NxOEka8aFONvkXnZ5j5A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Mar 2025 11:07:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQDQKq-WubM5VOBQh8BJ3ts1dNjKPoZofFu5W3zahgaA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq1SluFDnMmpoz3ztYp0O7KwWv2ESVliCn-nl31fii805EQa98fNbHWhOk
Message-ID: <CAL_JsqKQDQKq-WubM5VOBQh8BJ3ts1dNjKPoZofFu5W3zahgaA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: Add SiFive CLINT2
To: Nick Hu <nick.hu@sifive.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 9:36=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Rob

Please don't top post.

> Sorry, I thought I had replied to the mailing list, but it looks like
> I only sent it to Conor.
>
> The control of sifive,clint2 differs from that of sifive,clint0,
> making them incompatible.

The answer belongs in the patch, not just in a reply. Assume we've
forgotten everything said in the prior version because we likely have,
so you don't want to get the same questions again.

>
> On Sat, Mar 15, 2025 at 7:25=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Fri, Mar 14, 2025 at 04:12:54PM +0800, Nick Hu wrote:
> > > Add compatible string and property for the SiFive CLINT v2.
> >
> > Conor asked about being backwards compatible with v1. Please say why it
> > isn't here.
> >
> > >
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > ---
> > > - v2 changes:
> > >   - Don't allow sifive,clint2 by itself. Add '-{}' to the first entry
> > >   - Mark the sifive,fine-ctr-bits as the required property when
> > >     the compatible includes the sifive,clint2
> > >
> > >  .../bindings/timer/sifive,clint.yaml          | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yam=
l b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > index 76d83aea4e2b..4b9dad11c1e9 100644
> > > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > @@ -36,6 +36,10 @@ properties:
> > >                - starfive,jh7110-clint   # StarFive JH7110
> > >                - starfive,jh8100-clint   # StarFive JH8100
> > >            - const: sifive,clint0        # SiFive CLINT v0 IP block
> > > +      - items:
> > > +          - {}
> > > +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> > > +        description: SiFive CLINT v2 is the HRT that supports the Zi=
cntr
> > >        - items:
> > >            - enum:
> > >                - allwinner,sun20i-d1-clint
> > > @@ -62,6 +66,22 @@ properties:
> > >      minItems: 1
> > >      maxItems: 4095
> > >
> > > +  sifive,fine-ctr-bits:
> > > +    maximum: 15
> > > +    description: The width in bits of the fine counter.
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: sifive,clint2
> > > +then:
> > > +  required:
> > > +    - sifive,fine-ctr-bits
> > > +else:
> > > +  properties:
> > > +    sifive,fine-ctr-bits: false
> > > +
> > >  additionalProperties: false
> > >
> > >  required:
> > > --
> > > 2.17.1
> > >
>
> Best Regards,
> Nick
>

