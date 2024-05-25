Return-Path: <linux-kernel+bounces-189408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5028CEF8E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950BB1C20B40
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E1A60BB6;
	Sat, 25 May 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W79X/mzs"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B943C08F;
	Sat, 25 May 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649034; cv=none; b=XDg+ynSB2NtJKbnxqqs7yURwveup2mQktvoULt2yZgPsqHiIhPfZqXIS+RwJiUysfGBpwuD9GSLu7oZXBE1yJ3vhPdyWhTW24yxubvumHTjhiOxQicwXH4DdtMQ7vO5vGHDmGUBGdCZmEh8iCo+eX4Ry/sGjINqrGa3u9uns/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649034; c=relaxed/simple;
	bh=QMwElAfCIaoW3VvCQJ0Aba3nXaVHbKNoj2smh37TLdM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9nvaCIEF/5wuyW/SUMoWwRGQ+uI+DI0p3IiAzEY+oL1Tbl3fJivKM571gRBa6xHgbnQzLMOKGHx2XFt/z6RNqyfeDAjxv4sFhLhwpKCHx+u9BbxPWqZr869D5aSaCCBnh0pr1Du9GArRh2A/5qQ13DJmdWm/6nkKiTZ+YHm+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W79X/mzs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso72992541fa.2;
        Sat, 25 May 2024 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716649031; x=1717253831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TIfet0oo2M0dTN9IioUaowhYpfdPo8hWYoxafPh4BQ4=;
        b=W79X/mzs53RIXzLRJX8a+H6vzzp2DBCE0cjqADB/snj6fcLpoAo/6SoH2XT/dK4CFX
         JWgiBvOm8itrcTpfShIDNLW6iYEr+U9bxhOzVXwgqRoY5MIaS2FbOrTviNrC9PcQpSz0
         YqNZTIkT376MjGMlprgGmjB5kg1SwSm5vC28MLHieDp6EnomHXRkXoj7iJ2g/ZFmaAkP
         9GNSG7UFK6HcNWB9TVMSmc4Oidt/W+S+Gcwi8G2R+LuwafwZOLZJCeioiKJfgXE7gXfm
         HhI0xVaOWWeWRMetifLO6PlpeHD722ZKfiPHECrn44A9rwF8rVoZDSWis0FWvMvpvj9E
         VmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716649031; x=1717253831;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIfet0oo2M0dTN9IioUaowhYpfdPo8hWYoxafPh4BQ4=;
        b=OhKhAG+1bVTvMToCbNiUHyu7yF6PtBZ9PjcD4ArP40GVCKqOhr+vy1JQGzmMA3vaev
         eqzL6nHcIOievugHIorqLnSWx5oz8JRREBxC0N4kPX4BbNnXMdOJNps8DwWzHA3AfYgi
         YA+pzmGoKkw6jfHaWkJfDTSFTDk8LoFSSUi08zOfVJudcvLNneZGNEaE4Dsy66gxDvjt
         pFzFpmI57LxwGJqGQfJjcwwIOe6FiTazDPmiwl+8PBQpSTPUrj6VcQlCYHxZEV1khbZW
         REmNzilcSdg9ltsH9+xmiPgiZdnjHBCb/U2Wt0444zDJP/SRASL64BcfDx9hZc3HHqy+
         f2aw==
X-Forwarded-Encrypted: i=1; AJvYcCW+NeETzHbP99oZM/NWFZvHuymlLSbue2Oi7LtZ/pjb0zPoPns4pPbl9IlRQfycjQKf2emSG2qkVOpudSUN6TRxN+kgQgjW66rd+3KFJvfJx13vZrmRKdKs5ZkQ4S5dKiJ2TtxX0D7r8DVQNsTz6whA1FJbqE4GgEUBNUD00pmLo9COyPY9
X-Gm-Message-State: AOJu0YxWTQ3yBWEDXIiApJXuAJBRjL3+DGyESeaDBPT3e69jOSa93SCO
	PbMIB2TsmuyiLepAPHZ0SMQhf+PfY07xmxuNtgMTw732gevLg+uAZzOuqQ==
X-Google-Smtp-Source: AGHT+IEQLAp42vuhTf+k4A91OUPMJVggFXAaF5UDWAZ9n2WZwj9ZRgm7etUs8D1J72fzlRAhzR0kfg==
X-Received: by 2002:a2e:80da:0:b0:2e6:eb0f:5f59 with SMTP id 38308e7fff4ca-2e95b0977c7mr45542491fa.17.1716649030545;
        Sat, 25 May 2024 07:57:10 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm83514765e9.15.2024.05.25.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 07:57:10 -0700 (PDT)
Message-ID: <6651fc46.050a0220.5b758.034d@mx.google.com>
X-Google-Original-Message-ID: <ZlHHqlNtcwaOLhLx@Ansuel-XPS.>
Date: Sat, 25 May 2024 13:12:42 +0200
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
 <6651f77a.050a0220.9b079.fbf3@mx.google.com>
 <818aacc7-5244-45e1-844d-561e8540cb46@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818aacc7-5244-45e1-844d-561e8540cb46@roeck-us.net>

On Sat, May 25, 2024 at 07:53:57AM -0700, Guenter Roeck wrote:
> On 5/25/24 03:50, Christian Marangi wrote:
> > On Sat, May 25, 2024 at 07:32:04AM -0700, Guenter Roeck wrote:
> > > On 5/25/24 03:29, Christian Marangi wrote:
> > > > Add support for g761 PWM Fan controller. This is an exact copy of g763
> > > > with the difference that it does also support an internal clock
> > > > oscillators.
> > > > 
> > > > Add required logic to support this additional feature with the property
> > > > gmt,internal-clock and reject invalid schema that define both
> > > > internal-clock property and external clocks.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 43 +++++++++++++++++--
> > > >    1 file changed, 40 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > > > index bfefe49f54bf..d6e80392d045 100644
> > > > --- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > > > +++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
> > > > @@ -4,13 +4,13 @@
> > > >    $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
> > > >    $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > -title: GMT G762/G763 PWM Fan controller
> > > > +title: GMT G761/G762/G763 PWM Fan controller
> > > >    maintainers:
> > > >      - Christian Marangi <ansuelsmth@gmail.com>
> > > >    description: |
> > > > -  GMT G762/G763 PWM Fan controller.
> > > > +  GMT G761/G762/G763 PWM Fan controller.
> > > >      If an optional property is not set in DT, then current value is kept
> > > >      unmodified (e.g. bootloader installed value).
> > > > @@ -22,6 +22,7 @@ description: |
> > > >    properties:
> > > >      compatible:
> > > >        enum:
> > > > +      - gmt,g761
> > > >          - gmt,g762
> > > >          - gmt,g763
> > > > @@ -48,10 +49,37 @@ properties:
> > > >        $ref: /schemas/types.yaml#/definitions/uint32
> > > >        enum: [0, 1, 2]
> > > > +  gmt,internal-clock:
> > > > +    description: Use the Internal clock instead of externally attached one
> > > > +      via the CLK pin.
> > > > +    type: boolean
> > > > +
> > > >    required:
> > > >      - compatible
> > > >      - reg
> > > > -  - clocks
> > > > +
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - gmt,g762
> > > > +              - gmt,g763
> > > > +    then:
> > > > +      properties:
> > > > +        gmt,internal-clock: false
> > > > +
> > > > +      required:
> > > > +        - clocks
> > > 
> > > Is the new property even necessary ? The absence of an external clock on G761
> > > could be used to imply that the internal clock is used.
> > > 
> > 
> > Well with how the driver works, if a property is not defined, then the
> > value is not set and the one set by the bootloader or from device reset
> > is keept.
> > 
> > This conflicts with the logic of no clock = internal.
> > 
> 
> Not sure I understand the problem. It would be a simple change in the driver
> to add "if the chip is G761 and the clock is not provided in DT, use the
> internal clock".
>

Yes sure code wise is pretty easy, my concern is more of losing this
info in DT. But anyway ok will drop in V2. Thanks a lot for the review!

-- 
	Ansuel

