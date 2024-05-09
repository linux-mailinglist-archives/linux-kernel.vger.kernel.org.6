Return-Path: <linux-kernel+bounces-174535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C978C104D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0CFB2385F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633521527A9;
	Thu,  9 May 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdAm49Vp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4812FF8C;
	Thu,  9 May 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261111; cv=none; b=F1KnlCotcqTW3ltu1G8xeHQXFezeODQCrfFjsXTm3Vt7UXNSRopmVmZrYUdGUbaBwzRvWmWlQgNBS0yPvbBANEX0PAj7AzU05FC6OdebHTyuVbbkaxrEK/zaQX3kIf8rQDad3nzwwbJg3sD7VH7gA0uAVNKa0OtKJSG81TH4s3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261111; c=relaxed/simple;
	bh=JV649ATEV4XPPgP4HiuRDayNGxbrbAKaljGSAztjUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvhElXr5drIDgVLVBlcBuuEo+PVq1ebATPb1MTcU3aCKyNK/TXHyajJdby0a2OI3FgxcxwewGxgvq6GazIh3v2C/a7iQFn6zIkXX0TILAP77WBywLt+gRXp9MK4AkbxWiLiHM84tZXpMXmWHf7vrhWhjsHfbmBW1L2YxU5MxTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdAm49Vp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec486198b6so6719955ad.1;
        Thu, 09 May 2024 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715261109; x=1715865909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gECO8dWt5ZSkQ7aTn7k2QvSXHdHQpi9kJPWdBRbodCk=;
        b=gdAm49VpKmOlWcWA8YuTdjk6eblGB+wTSJICJgZaoob4MPcJKfnA0Oy6+BbX7BNMYf
         R/ujAcXoyl6fQ3VYLW8WJ+V1xB1TzR6sMAqMJuFfc3EcJTz2NrpfxD3sE0jN/4cDgxVX
         K6jPARyvMt99S1xBpjGeVPWTEMn14mH7sNkEhrUR3HF9shy8vFqK9ib33QKTtMFiyrqX
         ia8Fy0GQX169btQRjZGfxrR+LwOK/vyDL2yjCYbgpK7hU272p9t+IqELsshN5DKgumpm
         uMlFHUWZjk/V2H14cN0MMgqf30CUhNUXOPjZ+Rus0cA+FvajMQJ2AT+j6Ny7fgVs9uxT
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261109; x=1715865909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gECO8dWt5ZSkQ7aTn7k2QvSXHdHQpi9kJPWdBRbodCk=;
        b=NR2gipFOODdFMhza3uYOOy/e5J8lR7DwQp85WSn3pAgOm/ezgHPPYiSgHuGvaAQ3G5
         JTeR19JqiOoZlSK7nenUk6tTY4lKQx5yLResaT9V23aWaovl8cljkBY5+XtTCjgdKaF5
         Qb1hJW2rexSHmoUCNLRdcuz3nKGPg3ruIzTFJ8tMzDic+1dWxkS+6yNLDxKdiDDmFDSg
         T511UfGJwdnqYFhyag9nXpxIU02eFVnK4yi0YogYB+izra6xPX51SFt9t0JtnHW9AsHc
         ssxW99NMTE2g6ecRFr/M2A/TRbRNuDqNODpfhKABcjqQBvsx7z3YUN2tNDYeVG/pfwMP
         0ZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtWXKl6Aa8WZDgTmb7cdDl59Y37+2VPVB0B0P+OMGb2NtzNe0hWmztS1uWveyUt8BZAjbe0MfvXoCrIRfast4lU1pQBQHyJ4lT8xQzJ4VrGTlw4n0sXeJn2akjfRvyBQyv8udcAFGEPo6jIrB7wDJ329N951y5/eN/d+SrCxYSbWF1P3lY
X-Gm-Message-State: AOJu0YwE20SD7Yb6n7G4H2BoG2fFavbPs+aI9VY/u03tTP2PBGH3qynL
	SEDi17r2yQuuJx4wd/f8wvDJfgqvo9Ss4l/l7B7UQi628kiRyfJq
X-Google-Smtp-Source: AGHT+IHw++13444ZKLc5laCTjSB4UZ+ilE5n+mO3jKnotLr81kt/+x48TILiKaJsCawOyI1V5Z5Pyw==
X-Received: by 2002:a17:902:f689:b0:1e8:b715:45bc with SMTP id d9443c01a7336-1eeb059741bmr60742605ad.29.1715261109146;
        Thu, 09 May 2024 06:25:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d499csm14071395ad.45.2024.05.09.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:25:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 9 May 2024 06:25:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Message-ID: <7ab19e2a-7360-4c38-a237-43db57dc92f9@roeck-us.net>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>

On Thu, May 09, 2024 at 09:06:49AM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2024 23:55, Chris Packham wrote:
> > Add documentation for the pwm-initial-duty-cycle and
> > pwm-initial-frequency properties. These allow the starting state of the
> > PWM outputs to be set to cater for hardware designs where undesirable
> > amounts of noise is created by the default hardware state.
> > 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> > 
> > Notes:
> >     Changes in v2:
> >     - Document 0 as a valid value (leaves hardware as-is)
> > 
> >  .../devicetree/bindings/hwmon/adt7475.yaml    | 27 ++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > index 051c976ab711..97deda082b4a 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > @@ -51,6 +51,30 @@ properties:
> >        enum: [0, 1]
> >        default: 1
> >  
> > +  adi,pwm-initial-duty-cycle:
> > +    description: |
> > +      Configures the initial duty cycle for the PWM outputs. The hardware
> > +      default is 100% but this may cause unwanted fan noise at startup. Set
> > +      this to a value from 0 (0% duty cycle) to 255 (100% duty cycle).
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 3
> > +    maxItems: 3
> > +    items:
> > +      minimum: 0
> > +      maximum: 255
> > +      default: 255
> > +
> > +  adi,pwm-initial-frequency:
> 
> Frequency usually has some units, so use appropriate unit suffix and
> drop $ref.  Maybe that's just target-rpm property?
> 
We are talking pwm here, not rpm.

> But isn't this duplicating previous property? This is fan controller,
> not PWM provider (in any case you miss proper $refs to pwm.yaml or
> fan-common.yaml), so the only thing you initially want to configure is
> the fan rotation, not specific PWM waveform. If you you want to
> configure specific PWM waveform, then it's a PWM provider... but it is
> not... Confused.
> 

As I have said before ... almost all fan controllers have pwm outputs to
control the fans, because that is how fans are controlled. So, in your
terminology, pretty much all fan controllers are also pwm providers.

At the same time, I resist the push to implement pwm controller code in
fan controller drivers because that would just add a lot of code for no good
reason other than "because". I guess we'll have to find a means to extract
pwm related configuration data such as this one from devicetree without
actually implementing a full blown pwm controller driver.

Guenter

