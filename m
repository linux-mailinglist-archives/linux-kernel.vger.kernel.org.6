Return-Path: <linux-kernel+bounces-398299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22BD9BEF33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AA51C217B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB91F9ED8;
	Wed,  6 Nov 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ1Wbbd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FDC1F9EC8;
	Wed,  6 Nov 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900247; cv=none; b=kGzJr/yAPvhTu4DTz1o+YtnoKJ4wPchvsGltAEwLa0VUBmCreQEGayehpH3yGM2WR03igqpfUAtBZHse3LXmtkuQUQVfFulD6t7Cq7tGTt/GstiRDOWY+8AL5wcssz2s2Puyko9RqENO2p14/ZStgMKt4ms5I21NAo1tPJSdTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900247; c=relaxed/simple;
	bh=i4AlosLBQzzOHteyyP9uDXuMzU23Zyl+2F0eKBpiqgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ovm9GOE5TXb7TD2OH0kmMURa8oIzvsqlhV7Tk9zzJAkV3hwWO049/OLAGRnDRp8sdQ1U0pXpQaqX+l1mXnZZUdGzpcK3USniaFXZvH2m6xuDAoHiOx30jAfEBNmWGxI1ZDMe/L6Lv+cEpKZY6elBz+GsN5IHjjGF9lLNeRGuz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ1Wbbd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08836C4CED3;
	Wed,  6 Nov 2024 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730900247;
	bh=i4AlosLBQzzOHteyyP9uDXuMzU23Zyl+2F0eKBpiqgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NQ1Wbbd8j0KK+MRiwV3If7Y/qJppkn6FA1S5TxfOgZLaqzzi624E1HBEZ17mNLrk0
	 GEYa75CSQqUbyJ1lt+z9f6sC7TFCsJ4Az+MJg/x0qR/wu9c4a5Kn38GPngj+TTpkV2
	 vg0UPNmHWV10Q6ns/iZ/T7pZQed946rZ1l0SwqxP8/NDA05ERi+Lscv7uu4Ax/qOL/
	 +ZwMOLSpfswvibNG3LaVZU7GT28JpRvDbTB64uMrsKd61Aa9c8d1D4b5U3dLd7X+sR
	 gNR6ro5GT3eFjrN83cdT/liHsUAry8ZszH22IinIyzuozu8muibUWfTzsB5vLzhzYk
	 Q3rZgbvC4Mpeg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea5003deccso68477907b3.0;
        Wed, 06 Nov 2024 05:37:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyieMR5ihqu+m82iDska7IV84CQX92NtUZrJl0/JyORaatxpdme6tUp3HFksyAdmJQS63zAk2jCmD8grg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+wIXRwgXP9oJgcyOEXypTr2HZ/x14cearZFQizG9N2eRPvBt
	GupL05/f+LBHwGlE6hczTRzkEatsE1ixAR19V7rRUp5NHta7zPwl6H3I/iPXtOFPKBus40RJF3c
	s+G26ai9/7M18JwjDzA89JfF8vw==
X-Google-Smtp-Source: AGHT+IFNGEcs167bof7M3seZfYE6hOFkqDhkr9mxXX2vvtAZanWVLiQhQdZjWx6CPsMTwGe+UXOV/J4NvL+kA+b7yEg=
X-Received: by 2002:a81:b183:0:b0:6ea:807c:bbaa with SMTP id
 00721157ae682-6ea807cbf79mr114752047b3.5.1730900246246; Wed, 06 Nov 2024
 05:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105213232.443192-1-robh@kernel.org> <173084557910.617337.976853252835079367.robh@kernel.org>
In-Reply-To: <173084557910.617337.976853252835079367.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Nov 2024 07:37:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLnFcDMerh3DTVnscCQxjzm+gvcNk4RLAGKBu8p=JNdSQ@mail.gmail.com>
Message-ID: <CAL_JsqLnFcDMerh3DTVnscCQxjzm+gvcNk4RLAGKBu8p=JNdSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Enable dtc "interrupt_provider" warnings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:26=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 05 Nov 2024 15:32:32 -0600, Rob Herring (Arm) wrote:
> > All the warnings from the "interrupt_provider" dtc check are fixed now,
> > so enable the warning for the examples.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/Makefile            | 1 -
> >  Documentation/devicetree/bindings/example-schema.yaml | 1 +
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example=
.dts:27.33-39.11: Warning (interrupt_provider): /example-0/msi-controller@5=
d270000: Missing '#interrupt-cells' in interrupt provider
> Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example=
.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
> Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.exampl=
e.dts:22.55-31.15: Warning (interrupt_provider): /example-0/bus/msi-control=
ler@33d00000: Missing '#interrupt-cells' in interrupt provider
> Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.exampl=
e.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
> Documentation/devicetree/bindings/usb/cypress,cypd4226.example.dts:20.13-=
50.11: Warning (interrupt_provider): /example-0/i2c: '#interrupt-cells' fou=
nd, but node is not an interrupt provider
> Documentation/devicetree/bindings/usb/cypress,cypd4226.example.dtb: Warni=
ng (interrupt_map): Failed prerequisite 'interrupt_provider'
> Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.examp=
le.dts:26.14-48.11: Warning (interrupt_provider): /example-0/pmic: '#interr=
upt-cells' found, but node is not an interrupt provider
> Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.examp=
le.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
> Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dts:24.23-47.1=
1: Warning (interrupt_provider): /example-0/pcie@dfc00000: '#interrupt-cell=
s' found, but node is not an interrupt provider
> Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: Warning (=
interrupt_map): Failed prerequisite 'interrupt_provider'
> Documentation/devicetree/bindings/gpio/st,nomadik-gpio.example.dts:24.23-=
33.11: Warning (interrupt_provider): /example-0/gpio@8012e080: Missing '#in=
terrupt-cells' in interrupt provider
> Documentation/devicetree/bindings/gpio/st,nomadik-gpio.example.dtb: Warni=
ng (interrupt_map): Failed prerequisite 'interrupt_provider'

These are all fixed in linux-next.

Rob

