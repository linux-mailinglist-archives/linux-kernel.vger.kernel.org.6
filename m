Return-Path: <linux-kernel+bounces-376009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB89A9E89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AEB1C21C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656A198E91;
	Tue, 22 Oct 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMWL9zCo"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13138DF9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589441; cv=none; b=EAkcd7YT6SXueQoi2+EUXN6hF8u+BU275ND2iNYdgJnfc5TgTcF7zghjj3rx10gJyGH6YQ9IMabNRpxGkdy7t1kcsHIWoVarUsfnLPr8JJb2O2/OGPoPrs6AfO3EmcIXG6NYJI6m2WAdvCkbC+4DaOZINMs1OVDZNEe8T0jB2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589441; c=relaxed/simple;
	bh=04uqPll08TndRHT1JewWFv7oA5E7wVeGMCcmQpsjSaA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnQj4yhUZBRtiZ245YxDPcNfktpQqX9Z7q7MJ6nTl/pc6pytVlorilq6Pra63GGoO6Oipf3PuoS3jP9rieZxJyo6EIH0Ft/oYmxWHOqUEEWh5TUQwKR9w+hUWArah++awmVU3aVKSxuXMQYCwk70incPiONrpAgyM4EGA0RY0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMWL9zCo; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso781951966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729589437; x=1730194237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMxl0HS+/hroXw7dMiyhKlhruRtZ/PIjrJLLm0t+HQ=;
        b=UMWL9zCo2RnoxbQaGuZgieJtcicQqNNVkam3LR42AZF8gGGtkkrhBRMsSjw/t6QkvJ
         ICn4rfdzfpJX5Drn7FIdmPGX4eubadJxQyMPGR+yHR9tqr9ieGr6kuZZPdpiZYftrlqf
         /w9gWEUx+sqewVS6yn032zRa3CL0+hH/TtsWWPnP5ljW/durjEP4ZTVckLTyOCji6ym/
         K7yCRbMYo9f5xn/2Jc0kWvJHRo+/bMRbEJBuJoY7JPvgkGD4dXStxoMLjux7zwePZcHu
         yofUo5cjjvDKpA990224yMXWO2mc9KSUPMD1fvDtQnuoWifoCJelQCNtbfoK2j7k2LY2
         vHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589437; x=1730194237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwMxl0HS+/hroXw7dMiyhKlhruRtZ/PIjrJLLm0t+HQ=;
        b=boHc9+uovXug1f0lXfuzfkTwBaqsuuMgMl/8nCHQve3Sh1cmrDzXQySpq/BSbUBGSK
         W7dCjepqtLDibgSA3bJjeWK/mH68CEnfOeMLY7bBa72I6pZZbUc4cdCyHLKHtJQ8YIEi
         VNbGd8Fx2Et2WR3lMHo29TQoFc82j2frKvjd6HE9AAN+/C2hnd2L8SU5LeKxR8k8GnIi
         +A3APfRc9E/8PIZPPIs0wzLsMICk0B9mPpa/fOZFSeVhPDF7tmJAnWo9bQ2ivbA0JcY0
         HWzG9ThMgGbspw+KABKnXpy1zcvlB1j6k8zRY+wF0pGe+ceUsuesODlmsDvRA4FubHRJ
         LrGA==
X-Forwarded-Encrypted: i=1; AJvYcCVjPC0dZBHysYYlSrZo7m1vS2yxtV5sHE7e1JPSBH4haFTrcaWVAzXA+1SMqAkJmCLtRsGuO4XYz3o3LZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyviq+5eCheT5//1I1YYKb4aiK3qxyDBxRyRJWeAmCCJhoNb390
	U7vJqwR4Fu7b/7cgXvTGjZaE0sj8N+HdNeJRkSnHfYCiLVECupxEh1mZw6gXlqg=
X-Google-Smtp-Source: AGHT+IEGyEQRCYQDtCFWizlbuy0GBX1uROrJVtmMFsgIeXcmwJ6NJZHdXYYpYRzJfgP5yt6o3uI6gA==
X-Received: by 2002:a17:907:2d8c:b0:a80:f840:9004 with SMTP id a640c23a62f3a-a9a69a63c0fmr1587260866b.12.1729589436425;
        Tue, 22 Oct 2024 02:30:36 -0700 (PDT)
Received: from localhost (host-95-239-0-46.retail.telecomitalia.it. [95.239.0.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6234sm312304466b.24.2024.10.22.02.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:30:36 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 22 Oct 2024 11:30:57 +0200
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 04/14] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <Zxdw0X2S1-4ciBMc@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>
 <20241010025244.GB978628-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010025244.GB978628-robh@kernel.org>

Hi Rob,

On 21:52 Wed 09 Oct     , Rob Herring wrote:
> On Mon, Oct 07, 2024 at 02:39:47PM +0200, Andrea della Porta wrote:
> > The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> > schema is intended as minimal support for the clock generator and
> > gpio controller peripherals which are accessible through BAR1.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../devicetree/bindings/misc/pci1de4,1.yaml   | 110 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > new file mode 100644
> > index 000000000000..3f099b16e672
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi RP1 MFD PCI device
> > +
> > +maintainers:
> > +  - Andrea della Porta <andrea.porta@suse.com>
> > +
> > +description:
> > +  The RaspberryPi RP1 is a PCI multi function device containing
> > +  peripherals ranging from Ethernet to USB controller, I2C, SPI
> > +  and others.
> > +  The peripherals are accessed by addressing the PCI BAR1 region.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-ep-bus.yaml
> > +
> > +properties:
> > +  compatible:
> > +    additionalItems: true
> > +    maxItems: 3
> > +    items:
> > +      - const: pci1de4,1
> > +
> > +patternProperties:
> > +  "^pci-ep-bus@[0-2]$":
> > +    $ref: '#/$defs/bar-bus'
> > +    description:
> > +      The bus on which the peripherals are attached, which is addressable
> > +      through the BAR.
> 
> No need for this because pci-ep-bus.yaml already has a schema for the 
> child nodes.

Hmmm... my intention here was to constrain the BARs from 0 to 2, since there are
only 3 BARs on RP1 (of which only 1 is currently interesting for peripherals).
Also, that bus should have the peripherals on it, hence I've added the clock,
ethernet and pinctrl nodes. Do you think it's not reasonable to define
all the peripherals on it, or if it's reasonable, is there any other way to
accomplish this in a more elegant way than what I proposed in this patch? See also
below.

> 
> > +
> > +unevaluatedProperties: false
> > +
> > +$defs:
> > +  bar-bus:
> > +    $ref: /schemas/pci/pci-ep-bus.yaml#/$defs/pci-ep-bus
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      "#interrupt-cells":
> > +        const: 2
> > +        description:
> > +          Specifies respectively the interrupt number and flags as defined
> > +          in include/dt-bindings/interrupt-controller/irq.h.
> > +
> > +      interrupt-controller: true
> > +
> > +      interrupt-parent:
> > +        description:
> > +          Must be the phandle of this 'pci-ep-bus' node. It will trigger
> > +          PCI interrupts on behalf of peripheral generated interrupts.
> 
> 
> Do you have an interrupt controller per bus? These should be in the 
> parent node I think.

Ack.

> 
> 
> > +
> > +    patternProperties:
> > +      "^clocks(@[0-9a-f]+)?$":
> > +        type: object
> > +        $ref: /schemas/clock/raspberrypi,rp1-clocks.yaml
> > +
> > +      "^ethernet(@[0-9a-f]+)?$":
> > +        type: object
> > +        $ref: /schemas/net/cdns,macb.yaml
> > +
> > +      "^pinctrl(@[0-9a-f]+)?$":
> > +        type: object
> > +        $ref: /schemas/pinctrl/raspberrypi,rp1-gpio.yaml
> 
> IMO, these child nodes can be omitted. We generally don't define all the 
> child nodes in an SoC.
> 
> If you do want to define them, then just do:
> 
> additionalProperties: true
> properties:
>   compatible:
>     contains: the-child-compatible
>

Right, but since you proposed above to get rid of the pci-ep-bus redeclaration
(being it alredy defined in pci-ep-bus.yaml) I'm not sure where to place this.
Should I just get rid af it all as you suggest?


Many thanks,
Andrea
 
> > +
> > +    required:
> > +      - interrupt-parent
> > +      - interrupt-controller
> > +
> > +examples:
> > +  - |
> > +    pci {
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        rp1@0,0 {
> > +            compatible = "pci1de4,1";
> > +            ranges = <0x01 0x00 0x00000000
> > +                      0x82010000 0x00 0x00
> > +                      0x00 0x400000>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +
> > +            pci_ep_bus: pci-ep-bus@1 {
> > +                compatible = "simple-bus";
> > +                ranges = <0xc0 0x40000000
> > +                          0x01 0x00 0x00000000
> > +                          0x00 0x00400000>;
> > +                dma-ranges = <0x10 0x00000000
> > +                              0x43000000 0x10 0x00000000
> > +                              0x10 0x00000000>;
> > +                #address-cells = <2>;
> > +                #size-cells = <2>;
> > +                interrupt-controller;
> > +                interrupt-parent = <&pci_ep_bus>;
> > +                #interrupt-cells = <2>;
> > +
> > +                rp1_clocks: clocks@c040018000 {
> > +                    compatible = "raspberrypi,rp1-clocks";
> > +                    reg = <0xc0 0x40018000 0x0 0x10038>;
> > +                    #clock-cells = <1>;
> > +                    clocks = <&clk_rp1_xosc>;
> > +                    clock-names =  "rp1-xosc";
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ccf123b805c8..2aea5a6166bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
> >  M:	Andrea della Porta <andrea.porta@suse.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> >  F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	include/dt-bindings/clock/rp1.h
> > -- 
> > 2.35.3
> > 

