Return-Path: <linux-kernel+bounces-182492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D548C8BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C175C28531B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C213FD7A;
	Fri, 17 May 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs1jXnmj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242A13E880;
	Fri, 17 May 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968330; cv=none; b=Ob2wC5HWVtwFrwoTa49ViI3GaHVyke9fUzhbT523j8+n5DUmD1m4udkdsQMj5Xscps1ZujcC+ScI5UJfUSjLZE9kiZnbXCKwzIsce4nrjMHPtFYu1AyTDPdRc/3VMcPr26oMhmHXF36A1XFdagdKEenaKmnj4/noJ4wKJV8NSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968330; c=relaxed/simple;
	bh=k4u+Zs1U5N5Nbd0SXueo37qjRvG5FXkDRxl57ceJgZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYbI1fz/WuVb8KleEQn+MNKR5Gx7z30RhHoc9XVVx3Qq/YmyFgxnTanjLcI1Dcvf91cZzogijaQzqpiR9KTr0ymzn9lrSWNsMdh5SScycXmqHYqAe5hWAjVBOP6T3hkdHedK/Ea1vj1bNv04XyQD+VLw4Kt58SlwKO6oe8L1Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs1jXnmj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572d83e3c7eso5712990a12.3;
        Fri, 17 May 2024 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715968327; x=1716573127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks0RlD7UTKMn34Olp6UQuBmkLnxzPxuIP1wwEzn+Rp0=;
        b=bs1jXnmjXFjcXrKOaLthBUDh2dPpQB24X+P61pZwrwk1fHISg5ywNHReXkXu1N1kig
         dxsTZURJFIdj4KhhXJn0xw/CREzPYlExSePSEJPjp55nITT0/aANhiLpnPhm5m/nl5hq
         TyRVDzb7Xm1SfVn5KzUsT8PHadHKEHo4z3vuhUBwgLimRkN5PzVqSoswzoX7OxLhMZAs
         QyYpynBklLoiZIG5ejqCCqmMOd/VwDZLZpG3lc2ZgP8z09Kq68l3K2nkw9LZTBFLzw75
         QqmCrTJWdiUIY1IYeVTmVY38lrnORAxLH+DbwFQXapdQV3+WSz3WeyP/cojjL72fm+HF
         huHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715968327; x=1716573127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks0RlD7UTKMn34Olp6UQuBmkLnxzPxuIP1wwEzn+Rp0=;
        b=Qqtqy2eYyC5QrQ3debAUCR90YSrbG7FA9W5x+1x1WwQZAMJCV1EktPO5kWg0eXbjkR
         BJTmh7av7dljEJP+fWOKHtaNciaq6vwbkfbGggV4NjUjp++i16s9UtCrA2nD2v27lhc4
         2NMq8/hbS88+p/iWQALVoH6nQ0WD8i3R9SwUmUh2Aolpwozb/iaqb16LQs8oQnWCCS3X
         eBuO1HRQ8yoOnTGjgP1T9adXQGTwHtQZWrzZsgPeiZBNUpYzg398R5vRWYOQ/YS8i6oD
         1JdhSFBYeh07QdlOO2Ph9vBD16RsIs2AfSgT3fVm1bfq7XcSbFHM5FJyGEfNkwGFRX+X
         ljzw==
X-Forwarded-Encrypted: i=1; AJvYcCXbGoH93d2zD33Sl++/2khj36a9PW0kWa+kkF/h2XpNDRWLGX4LRhFpNXvfYyCLSw2iEqLCdNQhMGf5xusx7ivW3/8+8Mjo67c47XexEv+XC7Ei8z55W4ArTgHzNg2VWbOdHaTTWQOs0w==
X-Gm-Message-State: AOJu0YxmOvo88L0K+AMwzKoOGjeDZWtHeJmBM0icZoE3TSAKkkfvRvmw
	+77a05+XoejwPpcxpklEg7T3kolMxbl14vZuVFxylYhCs31zV3DsE7S0IhsEqFToGPIHFV7fxYd
	PotdsArnHSt+Vn3B1l3HRUYesM7A=
X-Google-Smtp-Source: AGHT+IGXBPfaWm4BNOrHGUznqjJZtFazRkWx3XGlwExdCUBUotfg2iervWCPbfcVUWeQDOqX38MLpTsRoflhFz9VyZw=
X-Received: by 2002:a50:9b41:0:b0:572:a123:5ed0 with SMTP id
 4fb4d7f45d1cf-5734d5cccf3mr15047824a12.21.1715968326396; Fri, 17 May 2024
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517150741.181303-1-kanakshilledar111@protonmail.com> <20240517-disfigure-disperser-1fa6b36729ec@spud>
In-Reply-To: <20240517-disfigure-disperser-1fa6b36729ec@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Fri, 17 May 2024 23:21:54 +0530
Message-ID: <CAGLn_=s4ghNODpVhPdk61Jt4XLteXp4W7oFS9WOb9O2-9BiXWQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: riscv,cpu-intc:
 convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:34=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Yo,
>
> On Fri, May 17, 2024 at 08:37:40PM +0530, Kanak Shilledar wrote:
> > Convert the RISC-V Hart-Level Interrupt Controller (HLIC) to newer
> > DT schema, Created DT schema based on the .txt file which had
> > `compatible`, `#interrupt-cells` and `interrupt-controller` as
> > required properties.
> > Changes made with respect to original file:
> > - Changed the example to just use interrupt-controller instead of
> > using the whole cpu block
> > - Changed the example compatible string.
> >
> > Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
> > ---
> >  .../interrupt-controller/riscv,cpu-intc.txt   | 52 -----------------
> >  .../interrupt-controller/riscv,cpu-intc.yaml  | 57 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 52 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/riscv,cpu-intc.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/riscv,cpu-intc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ri=
scv,cpu-intc.txt
> > deleted file mode 100644
> > index 265b223cd978..000000000000
> > --- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-=
intc.txt
> > +++ /dev/null
> > @@ -1,52 +0,0 @@
> > -RISC-V Hart-Level Interrupt Controller (HLIC)
> > ----------------------------------------------
> > -
> > -RISC-V cores include Control Status Registers (CSRs) which are local t=
o each
> > -CPU core (HART in RISC-V terminology) and can be read or written by so=
ftware.
> > -Some of these CSRs are used to control local interrupts connected to t=
he core.
> > -Every interrupt is ultimately routed through a hart's HLIC before it
> > -interrupts that hart.
> > -
> > -The RISC-V supervisor ISA manual specifies three interrupt sources tha=
t are
> > -attached to every HLIC: software interrupts, the timer interrupt, and =
external
> > -interrupts.  Software interrupts are used to send IPIs between cores. =
 The
> > -timer interrupt comes from an architecturally mandated real-time timer=
 that is
> > -controlled via Supervisor Binary Interface (SBI) calls and CSR reads. =
 External
> > -interrupts connect all other device interrupts to the HLIC, which are =
routed
> > -via the platform-level interrupt controller (PLIC).
> > -
> > -All RISC-V systems that conform to the supervisor ISA specification ar=
e
> > -required to have a HLIC with these three interrupt sources present.  S=
ince the
> > -interrupt map is defined by the ISA it's not listed in the HLIC's devi=
ce tree
> > -entry, though external interrupt controllers (like the PLIC, for examp=
le) will
> > -need to define how their interrupts map to the relevant HLICs.  This m=
eans
> > -a PLIC interrupt property will typically list the HLICs for all presen=
t HARTs
> > -in the system.
> > -
> > -Required properties:
> > -- compatible : "riscv,cpu-intc"
>
> > -- #interrupt-cells : should be <1>.  The interrupt sources are defined=
 by the
> > -  RISC-V supervisor ISA manual, with only the following three interrup=
ts being
> > -  defined for supervisor mode:
> > -    - Source 1 is the supervisor software interrupt, which can be sent=
 by an SBI
> > -      call and is reserved for use by software.
> > -    - Source 5 is the supervisor timer interrupt, which can be configu=
red by
> > -      SBI calls and implements a one-shot timer.
> > -    - Source 9 is the supervisor external interrupt, which chains to a=
ll other
> > -      device interrupts.
>
> I don't think that we should remove this test from the binding.

Do you suggest adding it as a description for the `#interrupt-cells` proper=
ty?

> > -- interrupt-controller : Identifies the node as an interrupt controlle=
r
> > -
> > -Furthermore, this interrupt-controller MUST be embedded inside the cpu
> > -definition of the hart whose CSRs control these local interrupts.
> > -
> > -An example device tree entry for a HLIC is show below.
> > -
> > -     cpu1: cpu@1 {
> > -             compatible =3D "riscv";
> > -             ...
> > -             cpu1-intc: interrupt-controller {
> > -                     #interrupt-cells =3D <1>;
> > -                     compatible =3D "sifive,fu540-c000-cpu-intc", "ris=
cv,cpu-intc";
> > -                     interrupt-controller;
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,cpu-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/r=
iscv,cpu-intc.yaml
> > new file mode 100644
> > index 000000000000..6fe86d243633
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-=
intc.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,cpu-intc=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Hart-Level Interrupt Controller (HLIC)
> > +
> > +description:
> > +  RISC-V cores include Control Status Registers (CSRs) which are local=
 to
> > +  each CPU core (HART in RISC-V terminology) and can be read or writte=
n by
> > +  software. Some of these CSRs are used to control local interrupts co=
nnected
> > +  to the core. Every interrupt is ultimately routed through a hart's H=
LIC
> > +  before it interrupts that hart.
> > +
> > +  The RISC-V supervisor ISA manual specifies three interrupt sources t=
hat are
> > +  attached to every HLIC namely software interrupts, the timer interru=
pt, and
> > +  external interrupts. Software interrupts are used to send IPIs betwe=
en
> > +  cores.  The timer interrupt comes from an architecturally mandated r=
eal-
> > +  time timer that is controlled via Supervisor Binary Interface (SBI) =
calls
> > +  and CSR reads. External interrupts connect all other device interrup=
ts to
> > +  the HLIC, which are routed via the platform-level interrupt controll=
er
> > +  (PLIC).
> > +
> > +  All RISC-V systems that conform to the supervisor ISA specification =
are
> > +  required to have a HLIC with these three interrupt sources present. =
 Since
> > +  the interrupt map is defined by the ISA it's not listed in the HLIC'=
s device
> > +  tree entry, though external interrupt controllers (like the PLIC, fo=
r
> > +  example) will need to define how their interrupts map to the relevan=
t HLICs.
> > +  This means a PLIC interrupt property will typically list the HLICs f=
or all
> > +  present HARTs in the system.
> > +
>
> > +maintainers:
> > +  - Kanak Shilledar <kanakshilledar111@protonmail.com>
>
> Are you knowledgeable about the cpu-intc on RISC-V? If you put yourself
> down just to satisfy dt_binding_check, I would suggest that you put down
> Palmer and Paul here as the maintainers of the architecture instead.

I am adding Palmer and Paul as maintainers in the v2 patch.

> > +properties:
> > +  compatible:
> > +    const: "riscv,cpu-intc"
>
> A new warning with dtbs_check from your patch:
> /stuff/linux/build/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: in=
terrupt-controller: compatible:0: 'riscv,cpu-intc' was expected
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,cpu-intc.yaml#
> /stuff/linux/build/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: in=
terrupt-controller: compatible: ['andestech,cpu-intc', 'riscv,cpu-intc'] is=
 too long
>         from schema $id: http://devicetree.org/schemas/interrupt-controll=
er/riscv,cpu-intc.yaml#
>
> There's a duplicate description in riscv/cpus.yaml:
>   interrupt-controller:
>     type: object
>     additionalProperties: false
>     description: Describes the CPU's local interrupt controller
>
>     properties:
>       '#interrupt-cells':
>         const: 1
>
>       compatible:
>         oneOf:
>           - items:
>               - const: andestech,cpu-intc
>               - const: riscv,cpu-intc
>           - const: riscv,cpu-intc
>
>       interrupt-controller: true
>
> I think the one in cpus.yaml should be converted to a ref and the
> andestech compatible added here.

I am working on the v2 patch, in which I didn't provide any ref to the
cpus.yaml and just replaced my compatible section with the one above
to resolve the issue with `/renesas/r9a07g043f01-smarc.dtb`. I tested
with others and didn't get any warnings.

> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells': true
>
> `const: 1` to match the text binding being removed.
>
> Cheers,
> Conor.
>
> > +
> > +required:
> > +  - compatible
> > +  - '#interrupt-cells'
> > +  - interrupt-controller
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    interrupt-controller {
> > +        #interrupt-cells =3D <1>;
> > +        compatible =3D "riscv,cpu-intc";
> > +        interrupt-controller;
> > +    };
> > --
> > 2.34.1
> >

Thanks and Regards,
Kanak Shilledar

