Return-Path: <linux-kernel+bounces-394701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B219BB2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7086328495E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2D1D359F;
	Mon,  4 Nov 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f2latYEc"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD91D3564
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718684; cv=none; b=apLinFeThB4I4ZRruzNQqvpQkpwMKVZGShl2g8Dei6kuvtMnIj6ohLFCluyie5LPTWPFCr0vtAnWgP1Vt/4mJH8Kh9CCTUnayMznm0v0Of0c8a9UkpfdLq8K+PTjHdFvYQtxHsQpfVEK6UXijohbDsuScv/wrU1yL6Fv5zeVHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718684; c=relaxed/simple;
	bh=VYra1vd3ZI3DNsV6QlM4eJ9XfY/djVw8e2jACzdfLOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbCo8pZM4KtqUJakhaY5i/4+5D/EssQxFvyR+a4ApmJNg0WvCsHoG4WBtrsWlioWgOtsgw7uIKZBICTzauHNsAz22LOuta0t17c/n+gGBx0Vdf+2yT/RLQm7A9RPSGmZFS/fn3u/qljXDRLajvSxomJ7RNgN0MWAt/oUWxqgPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f2latYEc; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a998a5ca499so546950766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730718680; x=1731323480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iR/eLuJ7hqRBDR8qMgEyoLrx9OmW3jzB7EgHhAaqCPM=;
        b=f2latYEcCfxv/mg+dMcplFmR9kD+CqsREUQxM0ESpc6ArVsrL3JqgD48rnwG5iHSZB
         8WHGwSkydfyuEov4YZ7hVA4svZFmyKIDCwtYLEGo9H+GqbMcfs+vvL87c20UKTC9YAyl
         +jRqTBp3OYz/C5xqX5YERS6K5GCQdg1c8M9AzAaDR1yS0ssNAMcm9dpdDnFQ1V9HSCGy
         bVtkOQRSkCgtzpXAN6yLLwypuYqMJXkezICBa54xhJZ9Z0icylFmWIbt8JjROnHtZQtN
         M/aaYKjY9pTKKQbzsh5EXk4+cuOOrPvww6uhkLfCszYKWFH8kAMjcJnCL9/ZgaPIkg70
         gDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718680; x=1731323480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR/eLuJ7hqRBDR8qMgEyoLrx9OmW3jzB7EgHhAaqCPM=;
        b=kFB4wpQ5tmjE3q6fYGqG2nVBZpgMusnhykOV66opDZz3sui/s8WoWV4UuX5vqPZn5N
         pYjX1EWefqbE1MI1d3NxclzKMXj/Wdw/RlPxKYhVenKxQkE4QSro43Wn3bDbtUBN3T5y
         heOo69pxi0l7o38qNZyLnZ2CmlXq2MiqXdTes6rzYLEsEPOv303ZZVmW9THApclRulJ0
         acCNKvr23fJxSWFzic229Tftp+JPY96AIi6uQbQgaYgRTRz3ABms6P2OonJ9OJbpjEXK
         4BiOt9S1PKlRo4201vRiK6KQxJWn56l3qqUgJx65VPvJHuzVFGXo4rzbpe6EPlASsiTk
         cjxg==
X-Forwarded-Encrypted: i=1; AJvYcCXmyB5Oo6tdqamF11QTzT1A5ba7wsnIWw6ItCObCi5vC/boTih/WW5QJxY+8fD8OFeZvuKs/dfeWiF+dLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfQE1xty8dOEo6bca3dgnPrJ9YwnViWxFZxWYtCZN12gWDB4y
	JjQR6sN5MjM78OqYJQDNTeq5ho8odrx1Ua87YJOQ+9LpqHsVlAiOnS9X1gfjEO0=
X-Google-Smtp-Source: AGHT+IG5tnzS154o2gsQZG2Mb2tToZi0pE7ZGdMnxoVRw4hvBg/+92C8iupvzX1HwjwL9uMQzQiObQ==
X-Received: by 2002:a17:907:9446:b0:a99:88ab:c7cb with SMTP id a640c23a62f3a-a9e654fd997mr1068397466b.33.1730718677440;
        Mon, 04 Nov 2024 03:11:17 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56645dcbsm549642066b.177.2024.11.04.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:11:16 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 4 Nov 2024 12:11:42 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: Re: [PATCH v3 02/12] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <Zyir7pu8T-fjUIA4@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <9a02498e0fbc135dcbe94adc7fc2d743cf190fac.1730123575.git.andrea.porta@suse.com>
 <mjhopgkrjahaxydn3ckianqnvjn55kxrldulvjkpqivlz72uyi@57l5vhydpzc2>
 <ZyOPHm7fl_vW7mAJ@apocalypse>
 <cc2e1a17-c5b1-4608-8e32-a6dea23a7efb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2e1a17-c5b1-4608-8e32-a6dea23a7efb@kernel.org>

Hi Krzysztof,

On 19:10 Thu 31 Oct     , Krzysztof Kozlowski wrote:
> On 31/10/2024 15:07, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 08:26 Tue 29 Oct     , Krzysztof Kozlowski wrote:
> >> On Mon, Oct 28, 2024 at 03:07:19PM +0100, Andrea della Porta wrote:
> >>> Add device tree bindings for the gpio/pin/mux controller that is part of
> >>> the RP1 multi function device, and relative entries in MAINTAINERS file.
> >>>
> >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> >>> ---
> >>>  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 163 ++++++++++++++++++
> >>>  MAINTAINERS                                   |   2 +
> >>>  2 files changed, 165 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..465a53a6d84f
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >>> @@ -0,0 +1,163 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> >>> +
> >>> +maintainers:
> >>> +  - Andrea della Porta <andrea.porta@suse.com>
> >>> +
> >>> +description:
> >>> +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> >>> +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> >>
> >> Please wrap code according to coding style (checkpatch is not a coding
> >> style description but only a tool).
> > 
> > Ack.
> > 
> >>
> >>> +  as an interrupt controller for those gpios.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: raspberrypi,rp1-gpio
> >>> +
> >>> +  reg:
> >>> +    maxItems: 3
> >>> +    description: One reg specifier for each one of the 3 pin banks.
> >>> +
> >>> +  '#gpio-cells':
> >>> +    description: The first cell is the pin number and the second cell is used
> >>> +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> >>> +    const: 2
> >>> +
> >>> +  gpio-controller: true
> >>> +
> >>> +  gpio-ranges:
> >>> +    maxItems: 1
> >>> +
> >>> +  gpio-line-names:
> >>> +    maxItems: 54
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 3
> >>> +    description: One interrupt specifier for each one of the 3 pin banks.
> >>> +
> >>> +  '#interrupt-cells':
> >>> +    description:
> >>> +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> >>> +      include/dt-bindings/interrupt-controller/irq.h.
> >>> +    const: 2
> >>> +
> >>> +  interrupt-controller: true
> >>> +
> >>> +additionalProperties:
> >>
> >> Not much improved. You are supposed to have here pattern, just like
> >> other bindings. I asked for this last time.
> >>
> >> And there are examples using it - almost all or most of pinctrl
> >> bindings, including bindings having subnodes (but you do not use such
> >> case here).
> > 
> > This is the same approach used in [1], which seems quite recent. I did't
> 
> 2021, so not that recent, but you are right that it's not the example I
> would recommend. See rather:
> git grep pins -- Documentation/devicetree/bindings/pinctrl/ | grep '\$'
> 
> 
> pins, groups, states, etc.

Perfect. Thanks for the example suggestion.

> 
> > use pattern because I wouldn't really want to enforce a particular naming
> > scheme. Subnodes are used, please see below. Since pinctrl.yaml explicitly
> 
> But we want to enforce, because it brings uniformity and matches
> partially generic naming patterns.

Ack.

> 
> > says that there is no common binding but each device has its own, I
> > thought that was reasonable choice. Should I enforce some common pattern,
> > then?
> 
> Yes, you should. Again, look at other bindings, e.g. qcom tlmm or lpass lpi.

Ok.

> 
> > 
> >>
> >>> +  anyOf:
> >>> +    - type: object
> >>> +      additionalProperties: false
> >>> +      allOf:
> >>> +        - $ref: pincfg-node.yaml#
> >>> +        - $ref: pinmux-node.yaml#
> >>> +
> >>> +      description:
> >>> +        Pin controller client devices use pin configuration subnodes (children
> >>> +        and grandchildren) for desired pin configuration.
> >>> +        Client device subnodes use below standard properties.
> >>> +
> >>> +      properties:
> >>> +        pins:
> >>> +          description:
> >>> +            A string (or list of strings) adhering to the pattern 'gpio[0-5][0-9]'
> >>> +        function: true
> >>> +        bias-disable: true
> >>> +        bias-pull-down: true
> >>> +        bias-pull-up: true
> >>> +        slew-rate:
> >>> +          description: 0 is slow slew rate, 1 is fast slew rate
> >>> +          enum: [ 0, 1 ]
> >>> +        drive-strength:
> >>> +          enum: [ 2, 4, 8, 12 ]
> >>> +
> >>> +    - type: object
> >>> +      additionalProperties:
> >>> +        $ref: "#/additionalProperties/anyOf/0"
> >>
> >> Your example does not use any subnodes, so this looks not needed.
> > 
> > The example has subnodes, as in the following excerpt from the example:
> 
> I meant, you do not need properties in subnodes (1st level). You only
> want properties in subnodes of subnodes, so 2nd level. What is the point
> of allowing them in 1st level?

I will add those two sub-nodes to the example:

            rp1-i2s0-default-state {
                function = "i2s0";
                pins = "gpio18", "gpio19", "gpio20", "gpio21";
                bias-disable;
            };

            rp1-uart0-default-state {
                txd-pins {
                    function = "uart0";
                    pins = "gpio14";
                    bias-disable;
                };

                rxd-pins {
                    function = "uart0";
                    pins = "gpio15";
                    bias-pull-up;
                };
            };

The first is just a group of pins with the same settings, the second is 
a pin group with different settings per pin. This is basically the same
usage as in qcom,sm4250-lpass-lpi-pinctrl.yaml.

Many thanks,
Andrea

 
> 
> 
> 
> Best regards,
> Krzysztof
> 

