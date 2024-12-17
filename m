Return-Path: <linux-kernel+bounces-448550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D753E9F41AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F3188DA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3051494A5;
	Tue, 17 Dec 2024 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zu8s1fNY"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05313D25E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409192; cv=none; b=tH/gmKAh+0jfg0PVT4s9hEvS/l0Bhliac7Shuj0mHqFgLPWJwd0Cz3BDjsUbJ+jMwGAc+eXh3p61cGvCl48L5EsEntbnZfb092zAHalZBQscbMGmb1/xl+hEVt95G5xjUQnC19hO5rffN0aDkPym0WjH5Z4nxSF+LNHznorc2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409192; c=relaxed/simple;
	bh=QZmqhdVsAT2arRv5BiYh8G4Ca8gJY8A99rpA9VIjAxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbg8QlQRZfPXJTkgDXG+azX/FdXxBfr6cc2Beuhu5yVx3s8N8cDUlHnCvqDnFjLC8/hZm7SRa/lVcTa3xrVaWZTgtfGWTphrX0YSQX4moxJ29AkTBu4LjdpPh90OiDodLVcNpXHPLEvq5ksk+SVNZDUzDjj5XMoFHr0tefDB+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Zu8s1fNY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-540201cfedbso4942439e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734409188; x=1735013988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMW0UeIvJI+AhemOmgTlEsEldsGeJG60ZjFykMIumKo=;
        b=Zu8s1fNYBZe+DfEScdR9ln5aEODn7OyiEoFr7iwdr33G+GWaMT501IMRrfENrpflCR
         WzJ5KPEVQB559LNJ6G9tDFQl60ybRefKeB0/m+ZATaFo8q+xNHk8HuXzyPAlTHhGB+1e
         eHJcyWJV9A1DeB8Pk8DyYPZGVmToLAYspbduqPJjSc6tDJcU/lDtIgvI+NGYikSJt1gn
         zDh9PmQ31xKTnp1Qaw6U0BFnv+kTXylfH+6lXWKg0VvhtqfIBY+5UCscLKUP4xm6TMsh
         26ZFEEjcE/iU4yIPywjFXYR85U1Zf8xt+vD9zW+SOLUiAmZcScHVFgtXX9ZdZYY2yT02
         wMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409188; x=1735013988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMW0UeIvJI+AhemOmgTlEsEldsGeJG60ZjFykMIumKo=;
        b=n1zVno5253l5VDI9D2SC74w94x1QxvnNiq9sm1uHJHMliQoVMxgn5JGwU/TyUyBNit
         so84+arhTUMMvkiEkMitFJ2qKP+mud0d47+D+5xCxyHC03MRj3nyhCAoWbr/jC0DyjrK
         KniLy3YfmdksJaQylbCKaZpE620FQUnNXU8jwDuEufP0QDMm8dJFIAILYbLt/7C+hRGv
         crvgFTGT94e+xUojihilysY9q/bRmgEqfbF23q0fMqt9JXIo4I2IAqcAZeFBAPiMNqvW
         ZRbja8JNOh7Mxck9GdU5k/bFtn4kp5fP0v4GMz3qxjPbkmdNcl+hVH6HcMrDAGJd0sTY
         7TKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfgae2mK3D4BImPI34KsElhgxXB9WQ+o87fEKJDW16bFebApsDmt1peAjhyT0BCRgBdfChFOzzudBMKcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAhwbAPpN7UtVyM0aulmFGkPq6BPa3u2ndCUi/+sp8MCbb6V9
	mHSRxw5cirAohULZ9fR9PHZRc2nTcPn/l/kVdkz80RANCK6GxJoXTG4wLtxd58Bwb+rCa7fZ21M
	b70NmRnmg4X+60b8Tc1WvC/Klz4EfcO/5enYVag==
X-Gm-Gg: ASbGnctlvoilxMaLV5M/iVbRl89+dVtbJRmzbcMsjDpxglj2IsetEQzYC/TSvE65fnP
	DN73AWj0aIH6nyclx5OlpFYLI+yZTuSRD+lQUWKai
X-Google-Smtp-Source: AGHT+IE4WGSqZi/gpxX7yhuAHe5iSqT/x1A4bVt45VkgotfxHWWf4b7WOZPPzXtry/pOUrXrcUS5yW49UEDWenDscJ8=
X-Received: by 2002:a05:6512:b8a:b0:53e:3aaa:5c7c with SMTP id
 2adb3069b0e04-54099b72a81mr5673404e87.51.1734409188244; Mon, 16 Dec 2024
 20:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216084817.373131-1-apatel@ventanamicro.com>
 <20241216084817.373131-3-apatel@ventanamicro.com> <20241216-untrained-scarce-211d99984416@spud>
In-Reply-To: <20241216-untrained-scarce-211d99984416@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 17 Dec 2024 09:49:36 +0530
Message-ID: <CAK9=C2UtxKm_38SVzUZoe_OSqcU5Q6k87cZvGyPTozkVR8YoFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] dt-bindings: mailbox: Add bindings for RPMI
 shared memory transport
To: Conor Dooley <conor@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Dec 16, 2024 at 02:18:11PM +0530, Anup Patel wrote:
> > Add device tree bindings for the common RISC-V Platform Management
> > Interface (RPMI) shared memory transport as a mailbox controller.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 135 ++++++++++++++++++
> >  1 file changed, 135 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpm=
i-shmem-mbox.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem=
-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbo=
x.yaml
> > new file mode 100644
> > index 000000000000..8d713ba7ffc7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.y=
aml
> > @@ -0,0 +1,135 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Platform Management Interface (RPMI) shared memory mailb=
ox
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description: |
> > +  The RISC-V Platform Management Interface (RPMI) [1] defines a common=
 shared
> > +  memory based RPMI transport. This RPMI shared memory transport integ=
rates as
> > +  mailbox controller in the SBI implementation or supervisor software =
whereas
> > +  each RPMI service group is mailbox client in the SBI implementation =
and
> > +  supervisor software.
> > +
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  References
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +  [1] RISC-V Platform Management Interface (RPMI)
> > +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> > +
> > +properties:
> > +  compatible:
> > +    const: riscv,rpmi-shmem-mbox
> > +
> > +  reg:
> > +    oneOf:
> > +      - items:
> > +        - description: A2P request queue base address
> > +        - description: P2A acknowledgment queue base address
> > +        - description: P2A request queue base address
> > +        - description: A2P acknowledgment queue base address
> > +        - description: A2P doorbell address
> > +      - items:
> > +        - description: A2P request queue base address
> > +        - description: P2A acknowledgment queue base address
> > +        - description: A2P doorbell address
> > +
> > +  reg-names:
> > +    oneOf:
> > +      - items:
> > +        - const: a2p-req
> > +        - const: p2a-ack
> > +        - const: p2a-req
> > +        - const: a2p-ack
> > +        - const: db-reg
> > +      - items:
> > +        - const: a2p-req
> > +        - const: p2a-ack
> > +        - const: db-reg
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 1
> > +    description:
> > +      The RPMI shared memory transport supports wired interrupt specif=
ied by
> > +      this property as the P2A doorbell.
> > +
> > +  msi-parent:
> > +    description:
> > +      The RPMI shared memory transport supports MSI as P2A doorbell an=
d this
> > +      property specifies the target MSI controller.
> > +
> > +  riscv,slot-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 64
> > +    description:
> > +      Power-of-2 RPMI slot size of the RPMI shared memory transport.
> > +
> > +  riscv,db-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Update only the register bits of doorbell defined by the mask (3=
2 bit).
>
> For an untested RFC, the bindings here look mostly fine. I'd suggest
> renaming "db" to "doorbell" in properties etc, since we can easily
> afford the extra characters. Please make sure to actually test the
> bindings next time around, looks like all 3 bindings produced warnings.

Okay, I will fix these issues in the next revision.

>
> General comments like not needing to provide minItems: 1 when maxItems
> is also 1, and not needing a | unless you have formatting to preserve.

Okay, I will update.

>
> > +      If this property is not present then mask is assumed to be 0xfff=
fffff.
>
> Also, things like this should be handled with a `default: 0xffffffff`,
> rather than describing it in text.

Okay, I will update.

>
> I'll give the !rfc bindings a proper review when they appear, but before
> that I'll give the code here a go too - thanks for sending the patches.
>
> Cheers,
> Conor.

Regards,
Anup

