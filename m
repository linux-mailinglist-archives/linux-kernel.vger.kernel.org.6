Return-Path: <linux-kernel+bounces-189383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31B8CEF54
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8148281834
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE155C1A;
	Sat, 25 May 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtYvpEqo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225A4EB51;
	Sat, 25 May 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716647805; cv=none; b=Z04kAz26R4ojcqOijpFneaGaVuJIE6+jByJGsxfKj4KTAwKUGXAk3udMsN3CESZIM0DJ4dKf3zNa+QkjKeik9iJ10577lljS9gLkHQ8pr+j9oyQHTtyqRtJg+kO1BvPKujuGCaapTDiUt51rFZizucg0yT/5MIjgqjFF80Wz6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716647805; c=relaxed/simple;
	bh=B22/fE5n/tUIdZkkXpOM1JOMbxjDeybFnhsg7upMGNQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgWcg0yNNKuIvw1lDr2FpyVLD0srphluNV5/PmOngFVQigLLb0J0SNm5xRfl2k/3275wrL4WbyzMOVSNB1FcOk9ejnWPDaDc77ZomM/6O/UCaO5HbBpvx0W9psTiPvPFXGm9vMo+3Nv9zg3/JPKE4W0DMlJWfMrHSHeLwSv7d28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtYvpEqo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354b7d76c52so3455882f8f.3;
        Sat, 25 May 2024 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716647802; x=1717252602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQnVpwHFdxlugRza/DesNP5iM1P3CKDJhcdhgbGcEQ=;
        b=TtYvpEqok1QGvYV6IQBGicSMolcZ731Z7a/3zEmM7hrx4BaZt0HihyL9lP0DmKlOB9
         vj1ofN8h86n+uBWdn7Gn3e1rWob8Ty6J0SLp5SjQ/Oao/7TeYkKVLt+Ya3bnoWnjusSH
         uZC/idul8R+GYQhUSyQWxiiobnQQMOc7EvOeqSwcqeHGN6UVjBNjzPvtC+Oc5hftr3XW
         uvWLaVvbEDkS2DsgKMaCzO1BaI5zQkmVpo/+xeKupP0hZ1gMHkAXcG5x1jUmuCE7PS8g
         BTPA0FJ0Y+lM4StZncwjyfuTCF7/XfpHeR/oV15tszvFxgCLd6n/tR39KHnhUH1c+MNr
         nb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716647802; x=1717252602;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjQnVpwHFdxlugRza/DesNP5iM1P3CKDJhcdhgbGcEQ=;
        b=Wq6s0BSZzuilOfT+7zN3RnaSv2yAolZzrI4BN23FyUHd8vdHw0U/lsBcXr39lERP+C
         paErfCmFZlPFvGItfU6eFZcTl+JnzuzEBrRhDHbEInok7SheWLAfQl2V4sbWXv/4RjFI
         V7Z6YeHbCnK6WsVfaXYAyas6G80zQzeJ97EbPW/R7bUJjObDNJP+w7Ts4bchad3DQwhH
         /nBJGVUOiK2QwFrb6Zo8pr8BNuI8jtiibJ6aRaFuO9dWKNs6ZOYyqUr8r3XB4lwfamN4
         b6eH1TRYRYDcwFG3ZkJu1GnD56DO0aN8rfH2zHfznVM4XtEZZyOkzHie01Aiv/S3qd/q
         yx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC0v0z7lx1ZmCVm9Ya12eN/0xc/g+kgq1FqxZbs3LoKPDsaFkv9fg7UtwL2y9v6ayQKAmVhO4/0ui81AmDZoW3eFmgqgdCD3Uh0IdcVGDJ+OgyCXWnoufKHZxzQH+SoumSZwo6h70YZ6PSUjE56bGWAHQWU+CxrlK61Vdwi3vsuXHDfw9U
X-Gm-Message-State: AOJu0YyIlrRGiveZMqalA2lvCrVxvUQKDlZPR21K5RyoT+PscnbujrkU
	aHkzlrIR+xcFn+Qa8Y/jNW1FIB7WRPvIuAAEOuCXr6wjfE3n/2KyFfrS0A==
X-Google-Smtp-Source: AGHT+IFLKo1fCIS2uoQeL1/yJB4MNhgKkjHvSkY2Ov5bdH3GLXt1qoMxqEZwkrfzM756CNPUVQhXxw==
X-Received: by 2002:a5d:6c65:0:b0:356:c47a:87d2 with SMTP id ffacd0b85a97d-356c47a8ab8mr1582952f8f.6.1716647802405;
        Sat, 25 May 2024 07:36:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8dfsm4121592f8f.30.2024.05.25.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 07:36:42 -0700 (PDT)
Message-ID: <6651f77a.050a0220.9b079.fbf3@mx.google.com>
X-Google-Original-Message-ID: <ZlHCd8upWMBfbuM2@Ansuel-XPS.>
Date: Sat, 25 May 2024 12:50:31 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: g76x: Add support for g761
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-2-ansuelsmth@gmail.com>
 <22e1daf4-ffce-4fac-be4c-0e7bebd91c88@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e1daf4-ffce-4fac-be4c-0e7bebd91c88@roeck-us.net>

On Sat, May 25, 2024 at 07:32:04AM -0700, Guenter Roeck wrote:
> On 5/25/24 03:29, Christian Marangi wrote:
> > Add support for g761 PWM Fan controller. This is an exact copy of g763
> > with the difference that it does also support an internal clock
> > oscillators.
> > 
> > Add required logic to support this additional feature with the property
> > gmt,internal-clock and reject invalid schema that define both
> > internal-clock property and external clocks.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 43 +++++++++++++++++--
> >   1 file changed, 40 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > index bfefe49f54bf..d6e80392d045 100644
> > --- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > @@ -4,13 +4,13 @@
> >   $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
> >   $schema: http://devicetree.org/meta-schemas/core.yaml#
> > -title: GMT G762/G763 PWM Fan controller
> > +title: GMT G761/G762/G763 PWM Fan controller
> >   maintainers:
> >     - Christian Marangi <ansuelsmth@gmail.com>
> >   description: |
> > -  GMT G762/G763 PWM Fan controller.
> > +  GMT G761/G762/G763 PWM Fan controller.
> >     If an optional property is not set in DT, then current value is kept
> >     unmodified (e.g. bootloader installed value).
> > @@ -22,6 +22,7 @@ description: |
> >   properties:
> >     compatible:
> >       enum:
> > +      - gmt,g761
> >         - gmt,g762
> >         - gmt,g763
> > @@ -48,10 +49,37 @@ properties:
> >       $ref: /schemas/types.yaml#/definitions/uint32
> >       enum: [0, 1, 2]
> > +  gmt,internal-clock:
> > +    description: Use the Internal clock instead of externally attached one
> > +      via the CLK pin.
> > +    type: boolean
> > +
> >   required:
> >     - compatible
> >     - reg
> > -  - clocks
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - gmt,g762
> > +              - gmt,g763
> > +    then:
> > +      properties:
> > +        gmt,internal-clock: false
> > +
> > +      required:
> > +        - clocks
> 
> Is the new property even necessary ? The absence of an external clock on G761
> could be used to imply that the internal clock is used.
>

Well with how the driver works, if a property is not defined, then the
value is not set and the one set by the bootloader or from device reset
is keept.

This conflicts with the logic of no clock = internal.

But yes if asked I can drop that, I can totally see your point since the
clocks is a required property anyway so it's always set.

> 
> > +
> > +  - if:
> > +      required:
> > +        - gmt,internal-clock
> > +
> > +    then:
> > +      properties:
> > +        clocks: false
> >   additionalProperties: false
> > @@ -80,4 +108,13 @@ examples:
> >               fan_startv = <1>;
> >               pwm_polarity = <0>;
> >           };
> > +
> > +        g761@1e {
> > +            compatible = "gmt,g761";
> > +            reg = <0x1e>;
> > +            gmt,internal-clock;
> > +            fan_gear_mode = <0>;
> > +            fan_startv = <1>;
> > +            pwm_polarity = <0>;
> > +        };
> >       };
> 

-- 
	Ansuel

