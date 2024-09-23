Return-Path: <linux-kernel+bounces-335880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1E97EBF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990B51C214CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784C198E79;
	Mon, 23 Sep 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4+zwN8f"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49387196455;
	Mon, 23 Sep 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096514; cv=none; b=lGm5E4GdGHqspzLZH1J2TInOHRbg/vtQlNx4HkStxZkfv7JZPpCuAqaTynvhBkMPX3Wn9euB6L17xa0ICJiue0C0T0xBYk/PIGzIeRZSC/JWuSgVnSxny6ltA66RkXzAIkAoVSsEpzAxwsmeXxpsoXONu4onpmG6O5O2ZqNegxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096514; c=relaxed/simple;
	bh=17dSBcmNYrqCvUcJa8Rf2oXtwv7C6EFT3j+HUeQT6tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea4cjWtk9nNAF42UTTuqMWjmN/8Hmhqcd9K6JS4JfV/5P5nMERYbksJUgJQWO2jNYGmcbO67xNgqp1XjefWgYb+dODH/9hT7lMSvud1+IwNMYwyo3+sO1nNeukffTDnE8gDlKDD+AU/ndoguP92SB5OvV6elOMT62n0o1e13Hu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4+zwN8f; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a843bef98so583014466b.2;
        Mon, 23 Sep 2024 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727096511; x=1727701311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/gF8/Lfb4a/bJjAHEDn5s6YpBeBGVhxEuTLoEXlIKI=;
        b=N4+zwN8fKaD/sFEzobH+gFePsRWzTVlQOOte5EbSObXXCEcN9Z8b6eCS3QzFCaGCzl
         g817mH7WgyvQ7QX76rsYAiNRAvzDcl8dneuRpyd0KF5l/2kcgZAFMd3x7QJi7/pTpNbi
         EtvACyJ0mHdEFUo52oLyVXMcDZeeIjA5nRWZuCL+Qk8EMeMwMfWMwWRxTG/jv2IY/TL7
         s8l71jbtccF8Iec8EIHfFC3J+hNFlrYMVWNSVFldhLqCdRFHBLI5NAxJGR/lSgaSaI2k
         Gq2ANj+OLtAB29b1Os4843FIpNy1uFDsafJ93pPotCF0eZFpxsu/J5uDgasZfYqMgosH
         vOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096511; x=1727701311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/gF8/Lfb4a/bJjAHEDn5s6YpBeBGVhxEuTLoEXlIKI=;
        b=d7CEdmKm7tlp0FCqrwEQIDHD2vtquwc+pgr38c2IN6oSX8cIwGazhes+2ylyXOMP7j
         CgB+z0n2IvawSSXMZ19A2vIhDb2gMVYmzJUwZlUCHGZLCLEHFPYe16NeuYbBVtbThHqv
         PYS1Haok9cq/kVVHdqX0iTtr71iVxLcPrkfEGQyChLWkiD5nwTv3sOn2F2KNMOMZI1TG
         nu9D1qfG9DhYlDK1MWnXFIZiuq+DNUFnTwQwsipXFamQlYW/oWiUaeW+RmJL6a+JYG1/
         pVP3Bf+CQwUlRJEen0B14gd0rV2vRKZfcDB56b1rwPs+0atfTMK9KlqbhCYQ8ekWQi/o
         RAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjFi7mXl9Fba1SqbcSr4XOfLhd3vq+j9Gzivboi69sRtPG1iZKUdExX1MVc363ZXKz9Sw+1km0nov+y0h@vger.kernel.org, AJvYcCWGyQEn9ilrglLr5TtoWBgxei6Jpp/vkACggsJ/dnYhl0OrEW6SS6hcI/Wmv2UOa8X6zsfFEOinrNG1@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVfJHN8sKfpcDoOn2uizdOXdRGyBCBv9sYL18A3M5rZyHq1kQ
	dNFIk7KY8wgziTmP4uB5Z6dTwXWJZjfYWnSx8QRRDtkC8b/CooGLMe7N3weAzmWM9CEOxgYLfnh
	lopqW8zkc1vXIXpJue3uGhDoXQA==
X-Google-Smtp-Source: AGHT+IEy0HmVgdJuHDr2khlgjJkc6dmg17690sJbqL96jYBBl/KemeFLe4A4YJAnZ+5vfhJev+MJqSLMaQoK6KY2Loo=
X-Received: by 2002:a17:907:f148:b0:a86:700f:93c0 with SMTP id
 a640c23a62f3a-a90d504f5c6mr1085431466b.35.1727096510186; Mon, 23 Sep 2024
 06:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <2c87568d-3caa-4162-91de-094684f1b268@linaro.org>
In-Reply-To: <2c87568d-3caa-4162-91de-094684f1b268@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 15:01:13 +0200
Message-ID: <CANeKEMO4ckeJZHKEOKHVeamPzR045jpwkXWfJS9S6rBiMTayuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 14:07, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 9/23/24 11:31 AM, Erez wrote:
> > On Mon, 23 Sept 2024 at 08:04, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>
> >> Hi,
> >>
>
> Hi!
>
> >> On 9/20/24 7:12 PM, Erez Geva wrote:
> >>> From: Erez Geva <ErezGeva2@gmail.com>
> >>>
> >>> Add flag for always trying reading SFDP:
> >>> Some vendors reuse all JEDEC IDs on manufacture table
> >>>  with new chips that support SFDP.
> >>>
> >>> Add flag for reading OTP parameters from device tree.
> >>> Some vendors reuse JEDEC IDs
> >>>  with several chips with different OTP parameters.
> >>> Alternatively we read parameters from SFDP.
> >>> But the OTP parameters are absent from the SFDP.
> >>
> >> Do you have some specific flashes that you try to identify? Why can't
> >> they be differentiated at runtime?
> >
> > You can not figure OTP parameters based on  JEDEC ID and SFDP existence.
> > I did send a few examples.
> >
> > One of them:
> > "How?
> >
> > When using mx25l12805d, we do not read SFDP.
> > As it uses the no-SFDP flags.
> > When using mx25l12833f hardware with mx25l12805d driver, it did not
> > try to read the SFDP.
> > Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> > driver fetch the SFDP.
> >
> > Secondly SFDP does not contain OTP information.
> >
> > mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> > While mx25l12833f has two OTP regions of 512 KiB.
>
> Ok, so you want to add support for mx25l12833f which shares the same ID
> as mx25l12805d and has different OTP settings. Is that correct?

My patch purpose was initially adding Mactronix OTP.
After reading a lot of Mactronix datasheets, I suggest also reading
all SFDP to all  Mactronix chips.

I add compatibility as I follow Kernel rule, that new code must be used!

>
> Which flash do you have at hand, both, none, just one of them?

When I started working on the OTP code, I used MX25L12833F.
But later I left the company.
So I use my beaglebone black and connect it to a MX25L3233F.

> >
> > How do we handle it?
> > I would gladly remove the obsolete mx25l12805d.
> > And skp compatibles all together."
>
> I need to understand first what you're trying to do. Don't assume that I
> remember what we discussed one month ago. Describe the why in the commit
> message.

"Add support for SPI-NOR Macronix OTP."
I wrote in the cover letter.
No, I do not expect you to remember everything.
I did write my intention in the cover letter.



> >
> >
> >>
> >>> So there is not other way but to add the OTP parameters in the device tree.
> >>>
> >>
> >> If there isn't any way to distinguish the flashes at runtime (which I
> >> doubt/challenge btw), then as a last resort we introduce a dedicated
> >> compatible for the flash in cause and specify all needed parameters in a
> >> dedicated flash entry. This shall be more generic as further flash
> >> parameters can be statically specified in the dedicated flash entry,
> >> less invasive for dt, and less confusing for people when they decide
> >> whether to use OTP or not. OTP params in device tree is a no-go.
> >>
> >> But again, you have to prove why you can't distinguish the flash at
> >> runtime before introducing a new flash compatible. So don't go this path
> >> before sharing with us what you're trying to achieve.
> >
> > You keep sending me contradictory messages.
>
> when? Please accept my apologies if that's the case, it's not in my
> intention. Provide better commit message, help me help you.

I tried adding a new compatibility.
You say you do not want new compatibility.
You ask if it is possible to deduce it from JEDEC ID and SFDP,
I answer that this is not possible, at least in some cases..
I try to add OTP parameters in DT. You do not like it, fair enough.
What am I to do?
Seems like a dead end.

Erez


>
> >
> > I told you we can not "guess" OTP settings based on JEDEC ID and SFDP existence.
>
> When? And more importantly, why?

I send you example of 3/4 chips that using JEDEC ID and SFDP existence
is not enough.

>
> > It may be partial and Macronix may add new chips in the future.
>
> I don't understand what you mean by partial, please elaborate.

I think Kernel like using bullet proof methods.
methods that will produce a working results.
If I find one example we can not probe the OTP parameters this way, it
means this method is NOT bullet proof.

>
> And we don't add support for what we assume new chips will look like.

This is not what I ask for.
Just trying to guess OTP parameters in current chips will break with new chips.


>
> > They reuse JEDEC ID only retaining flash size and blocks.
>
> Yes, I know macronix shares flash IDs among flavors of flashes or new
> chips altogether.

I am glad you know.

>
> > This is why compatibilities work with new Macronix chips . Although by
>
> In the last 7 years we haven't add any new compatible for SPI NOR, I
> don't understand what are you referring to.

The fact we can not deduce OTP parameters with current methods.
I do not mind in what way we do it.
But it seems there is no way according to your suggestions.

>
> > reading the SFDP, we can use higher speeds.
>
> I don't see what's your point with this sentence.

SFDP specifies different methods of reading and writing. Double, block.
But it does not contain any information on OTP.


>
> > We can use SFDP parameters to read  flash size, blocks and speed.
> > But it does not contain any OTP parameters.
> > I found only one Macronix chip with an enterprise SFDP table with a
> > boolean flag for OTP, this does not help us much.
>
> So you say that there's a specific vendor SFDP table that contains a bit
> indicating whether OTP is supported or not? Use that then.

I found only one chip like that.
All the others do not have it.
Nor any information on OTP size and number of regions.
So, no it does not help much.
I do not hold any information.

>
> > Macronix technical support was explicit on OTP settings. You can not
>
> Provide us the answer for your specific flash. I don't care yet about
> all their flashes.

There are two parts:

SFDP - all Mactronix chips whether they are in the compatibilities or
not, have SFDP.
 There is no logic to skip SFDP just because we have an old chip entry
in the compatibilities table.

OTP - I want to add only one chip with OTP, the one I test.
 But I can not rely on JEDEC ID or SFDP to deduce the OTP parameters.
 So as I understand we have two options:Add compatibility for this
chip, or add dynamic OTP parameters (in DT or sysfs).


>
> > deduce them. You must know what chip you use.
>
> And I think I already said that you can differentiate between the two
> based on SFDP presence. mx25l12833f has SFDP, thus when SFDP present use
> the mx25l12833f-OTP configuration. When SFDP is not presence one may add
> support for the mx25l12805d-OTP configuration.

No, we have 3 chips.
2 are using the same JEDEC ID and both using SFDP, yet they use a different OTP.
So, the problem is here, and probably be bigger in the future, despite
you "do not care".


>
> Is there any case that I miss?

According to your reply, I would say pretty much most.

>
> > As far as I can see, Macronix does not reuse module names (god thanks for that).
> >
> > I do not mind using flash compatible.
> > Just clarify that point.
> > And I will send the patches accordingly.
> >
>
> I'm afraid I haven't understood yet what you're trying to achieve to
> provide some guidance.

I do not understand you either.
But I try to work on my communication skills.

Thank you for your feedback

Erez

