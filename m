Return-Path: <linux-kernel+bounces-264240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769B93E0A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC415281C90
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB8186E3B;
	Sat, 27 Jul 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvSqOS7a"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715C179A3;
	Sat, 27 Jul 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722106487; cv=none; b=Y0Oco2Lplr3f+dSQz8UTYaVAhz6001276WFy0y5a1DxRPUj3VLv1eyHDe4WwEUFEoG2DUc1t1u+Bh7tf+WYtZwQIclM5wQ/yNL8LluH1tI8p0uoK3lpSvJ/qD5mMxkRBGkTdgzXu3kfRSaKploRhP2Dal0VCmlcZoqFFJBPYUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722106487; c=relaxed/simple;
	bh=hl2sU+Q2AQkj+GvBmrCXNBYy7krd5P+IwfogcVOn3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNGt2hN1VdkQtsVjSGD4C4fVcOGzOBHRWZJRpeW3fbjZIFLjAiWJJTcjGDq1Mlo7LglZCOrftuiN5rhPpVe/UuX2HZrc46IbKynKt6BaiP6RD6r7/3oBclKiUic9apc+cZVeSvgWKfChkDRlCxBon/IhFhs3qBRxkNmu+oif0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvSqOS7a; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b78c980981so9950496d6.2;
        Sat, 27 Jul 2024 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722106484; x=1722711284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9b2EluIDdwCbEMT9V2F6Mpy73Q0qmkww/Qaik2t/B+w=;
        b=CvSqOS7axupxegwaGFe6QNqzgnwLESt9jW8+7wSu9ttTlzCB/ynLQJb52TQwBJsew/
         qX28ld7jfxjuqseZrohh9pQg9p81PDd2lVQmaQg6ML/EssBBT2nRY0GHoYAFl6Sdqd23
         0uiSEwUp+OxNy3yaoijs2/O/QpK3KaItMyLtRxfgCdufDVMCIGiQKsvMPPYM97ob/VBA
         IItpuioTVbavYDwrivTt14Z9R7biDD5zpDyJyP6GKsZBRDQhGlM9AcXBZOwwNuU/fm7j
         1Rjljm7S4/p3LuKmZlL8FbWy/vDXHknlpLw6Vvn3iYYBv8AMffr+MULex4Lt/93lpVP4
         9Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722106484; x=1722711284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b2EluIDdwCbEMT9V2F6Mpy73Q0qmkww/Qaik2t/B+w=;
        b=sSvL61l7yPG9wnazKmajM1ux6B/zr828PlYSiWwqHTWxDX/GyN7mBVQOIKnCIPzDbS
         +4ddM+t9BrxGdr3wpVW/ZQDewHy4s0YnSNYPSFQZx2ioESIVJyLaSKVHfR6wNYr3UPwG
         agv/ijbWr2wj7hkV2zPGxiSDF+heN0h6CJvnTSIDPCREHmzjn6lTaFGbW4CrUeYc6S5q
         PajjXeV/R9oU3FD/QEuLpUkpjSlA3GjBoCuNEfvvb4jorlrL7xtov+QLfG20TO2Qwp5Q
         cLbMRTE93saLGbmFQcGFAo9iIENfAd+ZBxbRbExuT3qIQ3/reYyJipMSlD94jMEnvK8h
         GAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1kkcfT5MKN//NRiYCjNpGvHaNw4C+52V9nM8N9mzcMJA8jw3N79hgk5NXLdxkI2weR+QiiFhhMfTP63m5+qDsjL7ptNA0UoWktOc4UkWZLY0H+KaxpB42NHSRxmJQxfpB/C5zfEr6/g==
X-Gm-Message-State: AOJu0YwDyaNzWlvfEnnRlC6ZtjMSnxMDBLPPjqCM70qgJvXSX4m1KxOg
	NSy6+6l6TvOpeRICaDXKBNofOetsbG7Suoce2Jyb2v1f+qqOZvv5
X-Google-Smtp-Source: AGHT+IHtqR5DOIyMv177rcxe4AjeaR9AX0+sk4521t4XZ+FIkJi22ahOIfLiRVbkdFsi5DkCJu+geg==
X-Received: by 2002:ad4:5943:0:b0:6b7:9c52:db53 with SMTP id 6a1803df08f44-6bb55ac596fmr51596386d6.48.1722106483720;
        Sat, 27 Jul 2024 11:54:43 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f83c9sm32265646d6.38.2024.07.27.11.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:54:43 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:54:40 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, christophe.jaillet@wanadoo.fr, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add Sharp Memory LCD
 bindings
Message-ID: <4jzq2jvezh6kcb2gxbyicveiaetn2drybi2wlrzmwziud6hcy3@gdqoo7bxmlba>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-2-lanzano.alex@gmail.com>
 <52bf1aa6-449f-4f77-992e-45e510fe6e7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bf1aa6-449f-4f77-992e-45e510fe6e7f@kernel.org>

On Sat, Jul 27, 2024 at 11:06:05AM GMT, Krzysztof Kozlowski wrote:
> On 26/07/2024 21:44, Alex Lanzano wrote:
> > Add device tree bindings for the monochrome Sharp Memory LCD
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> 
> The order of tags is incorrect. Who developed it first? Please read at
> Submitting patches - it explained this case quite precisely.
> 

Will fix!

> > ---
> >  .../bindings/display/sharp,ls010b7dh04.yaml   | 94 +++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> > new file mode 100644
> > index 000000000000..79bde7bf0d7d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> > @@ -0,0 +1,94 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sharp,ls010b7dh04.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sharp Memory LCD panels
> > +
> > +maintainers:
> > +  - Alex Lanzano <lanzano.alex@gmail.com>
> > +
> > +description:
> > +  Sharp Memory LCDs are a series of monochrome displays that operate over
> > +  a SPI bus when the chip select is high. The displays require a signal (VCOM)
> > +  to be generated to prevent DC bias build up resulting in pixels being
> > +  unable to change. Three modes can be used to provide the VCOM signal
> > +  ("software", "external", "pwm").
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
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>
> 

My apologies! I must've missed the comment on this line. I replied to this
on the v1 thread

> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +  sharp,vcom-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      software - This mode relies on a software operation to send a
> > +      "maintain display" message to the display, toggling the vcom
> > +      bit on and off with each message
> > +
> > +      external - This mode relies on an external clock to generate
> > +      the signal on the EXTCOMM pin
> 
> External clock? Then you might be missing clocks property.

This is to handle the case where a clock IC or other signal generator IC is provided
on the display module itself. So I don't believe the clocks property would be 
needed.

> > +
> > +      pwm - This mode relies on a pwm device to generate the signal
> > +      on the EXTCOMM pin
> 
> That's an enum. Otherwise why "pony" would be a correct vcom-mode?
> 

Will fix!

> > +
> > +  enable-gpios: true
> > +
> > +  pwms:
> > +    maxItems: 1
> > +    description: External VCOM signal
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cs-high
> > +  - sharp,vcom-mode
> > +
> > +allOf:
> > +  - $ref: panel/panel-common.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        sharp,vcom-mode:
> > +          const: pwm
> > +    then:
> > +      required:
> > +        - pwms
> > +
> > +additionalProperties: false
> 
> Instead:
> unevaluatedProperties: false
> 

Will fix!

> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        display@0{
> 
> Missing space (see DTS coding style or any DTS)
> 

Will Fix!

> > +            compatible = "sharp,ls013b7dh03";
> > +            reg = <0>;
> > +            spi-cs-high;
> > +            spi-max-frequency = <1000000>;
> > +            sharp,vcom-mode = "software";
> > +        };
> > +    };
> > +...
> 
> Best regards,
> Krzysztof
> 

Again, thank you for taking the time to review.

Best regards,
Alex

