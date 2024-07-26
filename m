Return-Path: <linux-kernel+bounces-262742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00C93CC18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3251C2149F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF96EC7;
	Fri, 26 Jul 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb3SCh3N"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7419B;
	Fri, 26 Jul 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954030; cv=none; b=PMk6O4uzXG6b/eoq3TDKqzSSWroz87vyu0azlURTBI+HAgZrk4DQnlnP7VaR/2Wjy8HV78TeqkzKjE3ucVW7PqZ0RSIKg7q5/kqv0tj9YwZ+wSP+48fyBmTBopfR29BqhDprtFzP5EtIRwm7UKo/wQLjytUeC7e6KwRhkn1TrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954030; c=relaxed/simple;
	bh=3JWQJxgRjgnRDkV+J163/giXHdA9KJEk2gKFlONUNB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4Tg14XdPJBFmvBiJrW7yIF3hvJvFU09tsL3lEeJDD8I+2O4ivQZU3pexy1ybAuszN2gKGsyNcRSs3Dw0zEkCVgqD4uD4jSPCDLOKe4ZfR0LNU8yqFKP37BhjIkiztYqME/5eLQ1tvVS7bYtRLj4+vdprnP8G16Zn7paLDzCJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb3SCh3N; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-67682149265so10467877b3.2;
        Thu, 25 Jul 2024 17:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721954027; x=1722558827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGbRMFqNjqE2FGzKnJAnVl6N0locpudqp71TjSFPoRA=;
        b=fb3SCh3NkQmZMDiIwnW6nhNcnjLbjJU6YbVskaX4HPoSFV/GAgSPEipxMCiwyC9oy6
         63lSy5p1km9JWH4/7qmHXTj87A7aGTkyhMkgeeWOhHF2HFrM4+IAvmjfTgTw0noe/ny1
         nXHBuY1nUKOdI3c3WHPuo2L7+B8ICjqglMYgst7ueU5dcvVtEtaR5WmQwLROWvbtLPYy
         uodEWP3RYCTd7R43SmAxtov8qF2bSoaQg4XESUKWgjFe958Ddwsotm5pBw6VODZbGfAB
         CA6pz4riF1vH9f1WaplsrFk8+OmffEfmFHcVJrVNh6fuYzQ5QMXFtwvTkDCDwSZd//ao
         Flkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721954027; x=1722558827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGbRMFqNjqE2FGzKnJAnVl6N0locpudqp71TjSFPoRA=;
        b=eTrrC20tLSe1PQMmVVF2vnah/oLjGyGuF5VvOS1dN8qrOOoWXTR+WoYw89YUsAFkfp
         nwHxx0XtQRy1nu2i7YtbvBbR3+GGznoOH/jib/U/Qil2+y2fY2e+oqzo4g4if46fR2Q6
         u7aHWutGr+WvbDehB5DMXw5VjWVwPfRd/GGB4epZfMCmTOYvZWDrsoO48wI6FF+l0hFt
         v5vhimkf8NfxDRx9FVqT7GSK2jpDqd69+xJwGS0EGUJkceqcyrVF/bW3PMz872wS1T82
         ElkFUlzvJE4RcK+vDrRZtZ0guRNX11gtF2KWg7nIkIUEzcoLCFeOtvIOnpP1d165fBvB
         2AvA==
X-Forwarded-Encrypted: i=1; AJvYcCVykLn+PM0vrVeMFIMIcycvBQuyCjOxn79e0FsGXv76mPzHhlVMqIQuPF+5k751+8lf7y8ITryawji/JknXlh6jDMRs+a/dzigAftz31ZMqLfPkyiumE2QAu/j51tXJmZjzbX0cnKRTtw==
X-Gm-Message-State: AOJu0YxKEqnekWfV9YmmXjD9h9jGsQiPHSWkOL86sITCxPhl1N6FKPpT
	zWvln1Tlit8kjbEECojx0LGLUF14hmGN+OprmmtHJ4dMgi7VoZy9crFYT1Lw
X-Google-Smtp-Source: AGHT+IGvyKLluKIWk4xhy3Z+igBHGE1XI2dKeVygogOJaSS0FOIYI1CJKYYr8IK+0PZw+U7Unncn8Q==
X-Received: by 2002:a81:bf4e:0:b0:648:3fb2:753b with SMTP id 00721157ae682-67512028191mr51762717b3.24.1721954027486;
        Thu, 25 Jul 2024 17:33:47 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3faea19bsm11714666d6.121.2024.07.25.17.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 17:33:46 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:33:44 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Message-ID: <7l5jyzk4ojxtmihsnuz355x2qk632vgxdspgllxljhpzxzdhcb@aq5xyd64d2kb>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-2-lanzano.alex@gmail.com>
 <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bf08aa-e7a0-4b60-b9fe-b43215ce3fb9@kernel.org>

Thank you for the review! I will address these comments in V2

On Thu, Jul 25, 2024 at 08:17:01AM GMT, Krzysztof Kozlowski wrote:
> On 25/07/2024 02:47, Alex Lanzano wrote:
> > Add device tree bindings for the monochrome Sharp Memory LCD
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> >  .../bindings/display/sharp,sharp-memory.yaml  | 97 +++++++++++++++++++
> >  include/dt-bindings/display/sharp-memory.h    |  9 ++
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
> >  create mode 100644 include/dt-bindings/display/sharp-memory.h
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml b/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
> > new file mode 100644
> > index 000000000000..a79edd97c857
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
> 
> Filename based on compatible, so e.g. sharp,ls010b7dh04.yaml.
> 
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sharp,sharp-memory.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sharp Memory LCD panels
> > +
> > +maintainers:
> > +  - Alex Lanzano <lanzano.alex@gmail.com>
> > +
> > +description:
> > +  This binding is for the Sharp Memory LCD monochrome displays.
> 
> Do not say that binding is a binding... instead describe hardware.
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sharp,ls010b7dh04
> > +      - sharp,ls011b7dh03
> > +      - sharp,ls012b7dd01
> > +      - sharp,ls013b7dh03
> > +      - sharp,ls013b7dh05
> > +      - sharp,ls018b7dh02
> > +      - sharp,ls027b7dh01
> > +      - sharp,ls027b7dh01a
> > +      - sharp,ls032b7dd02
> > +      - sharp,ls044q7dh01
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cs-high: true
> 
> You can drop it.
> 
> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +  vcom-mode:
> 
> Missing vendor prefix.
> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      VCOM is a signal that prevents DC bias from being built up in
> > +      the panel resulting in pixels being forever stuck in one state.
> > +      vcom-mode can be set to one of three modes
> > +
> > +      SHARP_MEMORY_SOFTWARE_VCOM - This method uses a kthread to periodically send a
> > +      "maintain display" message to the display, toggling the vcom
> > +      bit on and off with each message
> 
> You described Linux, this is not suitable for bindings.
> 
> > +
> > +      SHARP_MEMORY_EXTERNAL_VCOM - This method relies on an external clock to generate
> > +      the signal on the EXTCOMM pin
> > +
> > +      SHARP_MEMORY_PWM_VCOM - This method uses a pwm device to generate the signal
> > +      on the EXTCOMM pin
> 
> I don't see why do you even need this property. Just choose the best
> option based on available connections/pins.
> 

I wanted to cover most of the hardware configurations I've seen with these
displays. This property simplifies the driver implementation and allows the user
to explicitly state how the VCOM signal will be generated on their platform.

> > +
> > +    enum: [ 0, 1, 2 ]
> 
> Here 0/1/2 but above something entirely else. Just use strings.
> 
> > +
> > +  enable-gpios:
> > +    maxItems: 1
> > +    description: Enables display
> 
> Drop description and maxItems. :true is enough
> 
> > +
> > +  pwms:
> > +    maxItems: 1
> > +    description: External VCOM signal
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cs-high
> > +  - vcom-mode
> > +
> 
> allOf:
> 
> and missing ref to spi peripheral props
> 
> > +if:
> > +  properties:
> > +    vcom-mode:
> > +      # SHARP_MEMORY_PWM_VCOM
> > +      enum: [2]
> > +then:
> > +  required:
> > +    - pwms
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/display/sharp-memory.h>
> > +
> > +    spi {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> 
> Mess indentation.
> 
> Use 4 spaces for example indentation.
> 
> > +
> > +            display@0{
> > +                    compatible = "sharp,ls013b7dh03";
> > +                    reg = <0>;
> > +                    spi-cs-high;
> > +                    spi-max-frequency = <1000000>;
> > +                    vcom-mode = <SHARP_MEMORY_SOFTWARE_VCOM>;
> > +            };
> > +    };
> > +...
> > diff --git a/include/dt-bindings/display/sharp-memory.h b/include/dt-bindings/display/sharp-memory.h
> > new file mode 100644
> > index 000000000000..dea14c7bd7ec
> > --- /dev/null
> > +++ b/include/dt-bindings/display/sharp-memory.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +#ifndef _DT_BINDINGS_SHARP_MEMORY
> > +#define _DT_BINDINGS_SHARP_MEMORY
> > +
> > +#define SHARP_MEMORY_SOFTWARE_VCOM	0
> > +#define SHARP_MEMORY_EXTERNAL_VCOM	1
> > +#define SHARP_MEMORY_PWM_VCOM		2
> 
> Nope, drop the binding.
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
Alex

