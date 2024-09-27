Return-Path: <linux-kernel+bounces-341542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAA988171
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2889D1F24ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59818C017;
	Fri, 27 Sep 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WiyBggKv"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC416B75C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429738; cv=none; b=BcW9GZJp1h9pnym85F8gVICgtYoWkExotPiwfs6UC8cO8X25RFqZYwbUas8SZrTrmUg2arzCsi2qhLH9KnctLeetElhg+XZ7/GCpgxv+6hueDUODD16GEJbDAyAr771IvjURcTMS3c6FcfJ1Qs5rdZ3J5hPJvg8caI6ViePRqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429738; c=relaxed/simple;
	bh=a0DWjUa41cUDfBOtmgSKGPt/mr3trahjM32LvsXV3kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og3IZ1hT/pLlnE1+/jSfbrTxWcWzpSefSSu4ufLxq7J7EapZToxNvIogFc5Nq4lb8YPQWkufBNvaKJazlrn/kSZKF8VeWGairB0hkhPyqgkmX68K8dS9ZKQhvoh40ab+tIidiD5lKPG3ooz21CwMg76blElnYSicG2EHduIhf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WiyBggKv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso277064066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727429734; x=1728034534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdqJDKq90Nm0DTAUllzbeVhEIbGw2kuOZfb4DezjBhs=;
        b=WiyBggKvWj/STxggGtOn6/fU6GfszlU/ihgaTVGP/RB0ZRz6xXe1hIijYkPW0T27V2
         oS/6kdAZ56E2WtPmNCooCDDmrJCBxAOH712MlSHOJQDn50IUJMFPmhsm+rTMbAHfADJo
         rtlEdPb2mcNlI4eIwtfj68EYMIJ3hpCXHez6h0XCdM1voh+aAwIB1vOtqbhNbBRQv9lu
         qscmkOVFKDinJLc5zBk3jrDvy64i6rKV2cwHlyYtBf2+jv4yt2v22exadhZNZ3IJI9La
         PU/4qZZf+ylPAz/znsXnjIJew+NVY8LPp9ngLdDQOC4mPlObmIjQqiL2FuPrAKJqCxV5
         9O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429734; x=1728034534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdqJDKq90Nm0DTAUllzbeVhEIbGw2kuOZfb4DezjBhs=;
        b=s/aH4PL126nxnQM0/kpMHF9Z+0iuNvftsbgygzI15M3x4eDhOJYa2IUKnrhXy/vkuq
         Zzkm2AeYV0Ph3CJf0kn5LGhxLf364l36+9dV8QyBuKS0efGBO/jJM0EdbOUirqWen2tI
         aJbs2RTIz5Kt5JCWBBx/07TUVbCCvfeKpzs8+ym/HoNpEf3nHJkfxNr/2qT/bh/w9g/q
         NLl3P4Jhnb0VWJi4+/thJ6CdoQ57qvC600m/lKXrbZ0L+eF1doNIq+I8OMv992ATPWNr
         d2ivNQYCHaa9Z5jf3mbazRKTHj3v6BNhshSxwbgQTmhMNMIwVVV2QIGxeoomFvuqcPje
         D1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXHXU1z67S+8VqJMwAyODHpRF3eARFkq9Hspv0aEALGpz12houqRoug4B+cpnXIpP6Z0Nh9cfOj6ro1p8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSC6HXo8riWOQGNLsl7sOVB8wADyxd7svWDRwu58GNfk38Igd
	yAx7sJgCJi+xVEyQJaffrgxFERwD/SzTMbpQqeG3jcPjc0gek3x/KJVP5XmxsKw=
X-Google-Smtp-Source: AGHT+IFUn4cw1IPMlYkelmk8YWyIKLzvZK1NTTHf3l088PIRaer906x5gUY6LBBhIu0Ovb0Td9C9gw==
X-Received: by 2002:a17:906:4fc7:b0:a8d:439d:5c3e with SMTP id a640c23a62f3a-a93c49679e7mr230723066b.30.1727429734192;
        Fri, 27 Sep 2024 02:35:34 -0700 (PDT)
Received: from localhost ([89.207.171.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948231sm109839766b.99.2024.09.27.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:35:33 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:35:25 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
Message-ID: <ivyujm6do2wmpgoa42amgli4yqthhqzme6xepzcj2ifzg7xzxp@rauwer3wjigp>
References: <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>
 <ti4ffymrixcpptlrn3o5bytoyc4w5oovdrzgu442ychai2fjet@wtdhrmwrozee>
 <44feed5a-95a7-4baa-b17e-514c0f50dae6@kernel.org>
 <sf2pklbnlkpgnkemv3wevldpj55kk2xqh4fabbmkcbh2tvnbzr@gg3gxgztq6pt>
 <d2eb4faf-c723-453b-a9d8-68693c96fb42@kernel.org>
 <fa11631e-48f9-4e95-95c4-20b77cb0a1be@kernel.org>
 <h4kapqs5vpparh5b3tter54fbnxubq6gpnb4yrqjdio66tj37w@l3xzum2bq5sz>
 <58f5f778-9f0a-4a05-8c33-949f3b3d1f49@kernel.org>
 <sisw3whyzr7itjtuznvt5t6cbmfxzop5c4nfrxwpxjil6rxqzc@cfnb5panavxe>
 <4f2ec575-4c2c-49d5-b1c0-85d5b6ce9f2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f2ec575-4c2c-49d5-b1c0-85d5b6ce9f2e@kernel.org>

Hi Krzysztof,

On Thu, Sep 05, 2024 at 01:41:47PM GMT, Krzysztof Kozlowski wrote:
> On 05/09/2024 13:17, Markus Schneider-Pargmann wrote:
> > On Thu, Sep 05, 2024 at 12:41:05PM GMT, Krzysztof Kozlowski wrote:
> >> On 05/09/2024 11:49, Markus Schneider-Pargmann wrote:
> >>> On Thu, Sep 05, 2024 at 11:25:48AM GMT, Krzysztof Kozlowski wrote:
> >>>> On 05/09/2024 11:15, Krzysztof Kozlowski wrote:
> >>>>> On 05/09/2024 11:08, Markus Schneider-Pargmann wrote:
> >>>>>> On Tue, Aug 06, 2024 at 10:03:00AM GMT, Krzysztof Kozlowski wrote:
> >>>>>>> On 06/08/2024 09:11, Markus Schneider-Pargmann wrote:
> >>>>>>>> Hi Krzysztof,
> >>>>>>>>
> >>>>>>>> On Tue, Aug 06, 2024 at 08:18:01AM GMT, Krzysztof Kozlowski wrot=
e:
> >>>>>>>>> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
> >>>>>>>>>> Partial-IO is a very low power mode in which nearly everything=
 is
> >>>>>>>>>> powered off. Only pins of a few hardware units are kept sensit=
ive and
> >>>>>>>>>> are capable to wakeup the SoC. The device nodes are marked as
> >>>>>>>>>> 'wakeup-source' but so are a lot of other device nodes as well=
 that are
> >>>>>>>>>> not able to do a wakeup from Partial-IO. This creates the need=
 to
> >>>>>>>>>> describe the device nodes that are capable of wakeup from Part=
ial-IO.
> >>>>>>>>>>
> >>>>>>>>>> This patch adds a property with a list of these nodes defining=
 which
> >>>>>>>>>> devices can be used as wakeup sources in Partial-IO.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> <form letter>
> >>>>>>>>> This is a friendly reminder during the review process.
> >>>>>>>>>
> >>>>>>>>> It seems my or other reviewer's previous comments were not fully
> >>>>>>>>> addressed. Maybe the feedback got lost between the quotes, mayb=
e you
> >>>>>>>>> just forgot to apply it. Please go back to the previous discuss=
ion and
> >>>>>>>>> either implement all requested changes or keep discussing them.
> >>>>>>>>>
> >>>>>>>>> Thank you.
> >>>>>>>>> </form letter>
> >>>>>>>>
> >>>>>>>> I tried to address your comment from last version by explaining =
more
> >>>>>>>> thoroughly what the binding is for as it seemed that my previous
> >>>>>>>> explanation wasn't really good.
> >>>>>>>>
> >>>>>>>> You are suggesting to use 'wakeup-source' exclusively. Unfortuna=
tely
> >>>>>>>> wakeup-source is a boolean property which covers two states. I h=
ave at
> >>>>>>>> least three states I need to describe:
> >>>>>>>>
> >>>>>>>>  - wakeup-source for suspend to memory and other low power modes
> >>>>>>>>  - wakeup-source for Partial-IO
> >>>>>>>>  - no wakeup-source
> >>>>>>>
> >>>>>>> Maybe we need generic property or maybe custom TI would be fine, =
but in
> >>>>>>> any case - whether device is wakeup and what sort of wakeup it is=
, is a
> >>>>>>> property of the device.
> >>>>>>
> >>>>>> To continue on this, I currently only know of this Partial-IO mode=
 that
> >>>>>> would require a special flag like this. So I think a custom TI pro=
perty
> >>>>>> would work. For example a bool property like
> >>>>>>
> >>>>>>   ti,partial-io-wakeup-source;
> >>>>>>
> >>>>>> in the device nodes for which it is relevant? This would be in add=
ition
> >>>>>> to the 'wakeup-source' property.
> >>>>>
> >>>>> Rather oneOf. I don't think having two properties in a node brings =
any
> >>>>> more information.
> >>>>>
> >>>>> I would suggest finding one more user of this and making the
> >>>>> wakeup-source an enum - either string or integer with defines in a =
header.
> >>>>
> >>>> I am going through this thread again to write something in DT BoF but
> >>>> this is confusing:
> >>>>
> >>>> "Partial-IO is a very low power mode"
> >>>> "not able to do a wakeup from Partial-IO."
> >>>> "wakeup-source for Partial-IO"
> >>>>
> >>>> Are you waking up from Partial-IO or are you waking up into Partial-=
IO?
> >>>>
> >>>> And why the devices which are configured as wakeup-source cannot wak=
e up
> >>>> from or for Partial-IO?
> >>>
> >>> Sorry if this is confusing. Let me try again.
> >>>
> >>> Partial-IO is a very low power mode. Only a small IO unit is switched=
 on
> >>> to be sensitive on a small set of pins for any IO activity. The rest =
of
> >>> the SoC is powered off, including DDR. Any activity on these pins
> >>> switches on the power for the remaining SoC. This leads to a fresh bo=
ot,
> >>> not a resume of any kind. On am62 the pins that are sensitive and
> >>> therefore wakeup-source from this Partial-IO mode, are the pins of a =
few
> >>> CAN and UARTs from the MCU and Wkup section of the SoC.
> >>>
> >>> These CAN and UART wakeup-sources are also wakeup-sources for other l=
ow
> >>> power suspend to ram modes. But wakeup-sources for suspend to ram mod=
es
> >>> are typically not a wakeup-source for Partial-IO as they are not powe=
red
> >>> in Partial-IO.
> >>>
> >>> I hope this explains it better.
> >>
> >> Yeah, it's kind of obvious now that just use wakeup-source. Your
> >> hardware does not have two different methods of waking up. System is
> >> sleeping - either S2R or partial-IO or whatever - and you want it to be
> >> woken up.
> >>
> >> Entire property is unnecessary... and as I said before - you added it
> >> only for your driver. If same feedback is repeated and repeated, there
> >> is something in it...
> >=20
> > It's not obvious for me. Maybe you can elaborate a bit.
> >=20
> > The hardware has a different set of wakeup sources depending on the
> > power mode it is in and I would like to describe these different sets of
> > wakeup sources in the devicetree as for me this is a hardware property,
> > not a driver thing.
>=20
> I stated the argument to which you did not respond: it will not matter
> for the device whether this is wakeup-source =3D S2R or wakeup-source =3D
> TI-Partial-IO or whatever.
>=20
> Each device is or is not wakeup source.
>=20
> And just because your device has some registers or some configuration
> does not mean this property is suitable for DT.

I came up with a different (better) way to model this in the devicetree.
This group of units that are powered in Partial-IO are all powered by
just one regulator that is always on. I can simply describe this in the
devicetree by defining the regulator and consumer relationship:

Defining the regulator as described in the board schematic:

  vddshv_canuart: regulator-7 {
         /* TPS22965DSGT */
         compatible =3D "regulator-fixed";
         regulator-name =3D "vddshv_canuart";
         regulator-min-microvolt =3D <3300000>;
         regulator-max-microvolt =3D <3300000>;
         vin-supply =3D <&vcc_3v3_main>;
         regulator-always-on;
         regulator-boot-on;
  };

Adding vio-supply to mcan and uarts, note, this binding does not exist
yet:

  &mcu_mcan0 {
         vio-supply =3D <&vddshv_canuart>;
  };

  &mcu_mcan1 {
         vio-supply =3D <&vddshv_canuart>;
  };

  &mcu_uart0 {
         vio-supply =3D <&vddshv_canuart>;
  };

  &wkup_uart0 {
         vio-supply =3D <&vddshv_canuart>;
  };

Best
Markus

