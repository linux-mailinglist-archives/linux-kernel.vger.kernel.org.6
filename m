Return-Path: <linux-kernel+bounces-332562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7EF97BB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A33B2359A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317717BEB4;
	Wed, 18 Sep 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSPZ7zWn"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3EA172BD6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657216; cv=none; b=HhjUkxQI6wL4ig2pEEhuAQ8RTCEO1cQpMVsS2a+u0ba+8ezP5hzNIjkj3feJV0CftuiRlU+sCsgXzF1/XXdW8uUnCg4OVrPuod74MOCVWOr0ETY0a7UgDs+7X0+uP9couczouOGIV50qpCmf9M0S2w1VOeoQlCELuuxPPjf4n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657216; c=relaxed/simple;
	bh=fFDG2O6uVfN5BabQK+bFRTLg6JogWoNvGo3M5U/0W38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST9dzXfkmkxGrqiFdWqRPlHjvtTiRTPdKzk+ZyVUALskm863YEzV4qDR4GzNjTsXxJ8i3perKHQDUNg15LBSLxTOCYC1zt8DLvs5N0l503jUnJMqIdkLHddCHwV8O/rSauR2IJ57YR4/gUqxr2XfWht6C4BWAFylzOTsbV7lA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSPZ7zWn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53659c8d688so523896e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726657212; x=1727262012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyoz+r3z2fTtTxOXwV3PfYzr+O9ELMQOoDfKks2rgks=;
        b=ZSPZ7zWnh1ujlU18jHG2Cgu1+s6/ZCvdDINC3TrdiL8b5vFIClnUyH3BbsfAtFgJD/
         7bfcozJR7lJHc2etGq98afTWDLeaeDDzoQMuJLjgk6LQEOvvxyBvpeB6D3maK+lyelUR
         y9qXU0wDi+KduYCerwc/XH4cwY2zMB2j60Vgf2i25RDEnkleSryu79yg9lvDpanFNTew
         7C3WhVZ05oOw7pvqsiuzG/bDyOUmqZAMwbm/ZIeblURmaPzJkZFabDZDlMZRBfLAlB1E
         Cfv6KEfa6SoLPk5zu694qv+6spE0pRhs3OSvHKJiFr4CbDBHqBFme2V7al6Ts2SSp/Hu
         bfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726657212; x=1727262012;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyoz+r3z2fTtTxOXwV3PfYzr+O9ELMQOoDfKks2rgks=;
        b=KQ2pgGN8v1TkqpqfkoeHK/Q76cdBsyllpKssTVh+eablTPehcA7GijovWQ87nbJSx6
         GFBKsHMO5LE+D13l/X9QfDQHC+TA31f3XC3nT4+a1Ry5CXssZZOGUWQGSbG9a2iR+yOP
         8vFIRKROMIIWH6k2Cei9joRH1n6Gh3VcmUVgk8k67yVrBJwZBauK6uoNZTigEje66Bdo
         YTvWyS3bhLDmYE1B7Eog6O5ge63n6kCDgnXa6Fch/JkO2ahpi4gUJQ9lceDbeMXXM8md
         qRL/erYdr/i58B8kuFEirt2ikCO0ZXzoO0IeB60dk9KTLN/wDBTSAwvGpyVkmGSqsscU
         +pNA==
X-Forwarded-Encrypted: i=1; AJvYcCXceeTcuYabgUjr/a/zSm/A78CvxQYiHXWPnMDoWbCDdenfz3rKS9DAPJX8s4Ehbjl1tJZCULEeB5BEPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxanO1j4U0pTBRC3IGEPZK7d2unLkw6ZQX93OvvsUg2WCZtA6YT
	MOfioBXiTMRh1Vl2ZARVyhoA4kAPo7XAijPl3bBT1xN3JDRIiU7C
X-Google-Smtp-Source: AGHT+IFlJ2O1ZZMm0urEG0PIruAPf3kfHMNdT/Jxt4BdRNZGgUDCk9cJYsWZo8HwEHhRbUhpLyeHCw==
X-Received: by 2002:a05:6512:3051:b0:52f:441:bdd6 with SMTP id 2adb3069b0e04-5366b7d4cdcmr9419364e87.0.1726657211673;
        Wed, 18 Sep 2024 04:00:11 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046f7bsm1482259e87.35.2024.09.18.04.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 04:00:10 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:00:10 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
Message-ID: <ZuqyuvZ6tdzp5XSW@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org>
 <ZunCysUTSfQU1ylg@skv.local>
 <c7664fda936d36e0d916ae09dd554d2e@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7664fda936d36e0d916ae09dd554d2e@manjaro.org>

Hi Dragan,

On 24-09-18 11:27, Dragan Simic wrote:
> Hello Andrey,
> 
> 
>   arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
> 
> The patch description should be reworded like this, reflown into
> proper line lengths, of course:
> 
>   The way InvenSense MPU-6050 accelerometer is mounted on the
>   user-facing side of the Pine64 PinePhone mainboard requires
>   the accelerometer's x- and y-axis to be swapped, and the
>   direction of the accelerometer's y-axis to be inverted.
> 
>   Rectify this by adding a mount-matrix to the accelerometer
>   definition in the PinePhone dtsi file.
> 
>   [andrey: Picked the patch description provided by dsimic]
>   Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
> Pine64 PinePhone")
>   Cc: stable@vger.kernel.org

Thanks for the commit description, it's much better, than original
one.

> Please note the Fixes tag, which will submit this bugfix patch
> for inclusion into the long-term/stable kernels.
> 
> Also note that the patch description corrects the way inversion
> of the axis direction is described, which should also be corrected
> in the patch itself, as described further below.
> 
> After going through the InvenSense MPU-6050 datasheet, [1] the
> MPU-6050 evaluation board user guide, the PinePhone schematic,
> the PinePhone mainboard component placement, [2] and the kernel
> bindings documentation for mount-matrix, [3] I can conslude that
> only the direction of the accelerometer's y-axis is inverted,
> while the direction of the z-axis remain unchanged, according
> to the right-hand rule.

yes, it looks so on the first glance, but in MPU-6050 datasheet there
is also following information:

 7.8 Three-Axis MEMS Accelerometer with 16-bit ADCs and Signal
 Conditioning

 When the device is placed on a flat surface, it will measure
 0g on the X- and Y-axes and +1g on the Z-axis.

So sensors reports positive acceleration values for Z-axis, when
the gravity points to Z-minus. I see the same on device. positive
values are returned, when screen and IC point upwards (not the center
for gravity). 

In device tree mount-matrix documentation [3] there is

 users would likely expect a value of 9.81 m/s^2 upwards along the (z)
 axis, i.e. out of the screen when the device is held with its screen
 flat on the planets surface.

According to that, it looks like Z-axis here has to be inverted.

It applies to other axes as well. And because of that I came from (only Y-axis is inverted)

x' = -y
y' =  x
z' =  z

to inverted solution (Y-axis is kept, but X and Z are inverted).

x' =  y
y' = -x
z' = -z

probably should put this information into commit description.

> > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > index bc6af17e9267a..1da7506c38cd0 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > > > @@ -229,6 +229,9 @@ accelerometer@68 {
> > > >  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
> > > >  		vdd-supply = <&reg_dldo1>;
> > > >  		vddio-supply = <&reg_dldo1>;
> > > > +		mount-matrix = "0", "1", "0",
> > > > +				"-1", "0", "0",
> > > > +				"0", "0", "-1";
> > > >  	};
> > > >  };
> 
> With the above-described analysis in mind, the mount-matrix
> should be defined like this instead:
> 
> 		mount-matrix = "0", "1", "0",
> 			       "-1", "0", "0",
> 			       "0", "0", "1";


x' =  0 * x + 1 * y + 0 * z =  y
y' = -1 * x + 1 * y + 0 * z = -x
z' =  0 * z + 0 * y + 1 * z =  z

your description says, that only Y-axis is inverted, but this matrix,
imho, inverts original X axis as it was in original description.

> Please also note the line indentation that was changed a bit.
> 
> [1] https://rimgo.reallyaweso.me/vrBXQPq.png
> [2] https://rimgo.reallyaweso.me/uTmT1pr.png
> [3] https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt

-- 
Best regards,
Andrey Skvortsov

