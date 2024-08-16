Return-Path: <linux-kernel+bounces-289603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47265954811
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3772866A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81941917F1;
	Fri, 16 Aug 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQNEJrQ7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3C1A2C35;
	Fri, 16 Aug 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807806; cv=none; b=JakXaYFxVWnfEytVadP5S9kZbjyzEGBIEeQI0+Bn4jxZrwk0+SNSfbXKTx4nwx1n0SW30OD2QLgz1JUW3orluhXJaZhX3di6t2i8eCj2wGIskgZuCgOeiY9RjTtW5r4Usn2kbS+Trkqz7dN/Lq1Xh3zEEjSa0vVLLGA+HQwUC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807806; c=relaxed/simple;
	bh=xpsOi97EiZ8Kr2hHfas8gVdlAFhoEV4UmzAfJ4EZxx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkY1RAFAeGiCJsPqMpj5XYHeYkKyPzFrVNzJwN6CFdjqU5yzpxHk9gPx8u0xXcUeAcSvW+4kGmiqBXTA5d2wQLkI4XAk4bob95m2UYnx7miz63cMue03fRCVgLGNPgv6V1Epq3hEWdXNGBPKWQlvg/yICSFyzqrxVT3RPZk/Tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQNEJrQ7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f00ad303aso2555635e87.2;
        Fri, 16 Aug 2024 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723807803; x=1724412603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnMi7JbSYPde+7YBzDVTOzXtIwhsTCSKyuwPWEFsgL8=;
        b=CQNEJrQ7DYvfb4e6V8YdVekJ5GwiHPOrcntCRByV2EOgpSMX1N+rlly3YJvSBefsyH
         Vxaq5bzXyVZDd/ey7H917Ss+3SuSf9nGCrERT08m23G5LrQ3UCg377KyM08V1/Qfc+tN
         qvNdovLRRHTlsZBbuDpzOGVCjYNwI0APnk3kfL0n4maox2ExfQnUpHT2qJdYT9E1cjE+
         htgyvsHfL8ajVkv0+Itg3thdo/pco9ZjXA95MNo294tnzdU2qd1M0N+C+FduTOCPoY7I
         PN44lP47bzIX6RUs53Rhw5ToQBVyV6yeP9SyIUoDI0NDHfxXirPaIEFIfHaRHuThPOTg
         20mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723807803; x=1724412603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnMi7JbSYPde+7YBzDVTOzXtIwhsTCSKyuwPWEFsgL8=;
        b=mpmUBdOp9DBbMeIWanOnWa6evhtCRWhGwUhJ6n4H9IPrnbroV9AkJ7bE3mp0TSdaS8
         YY0L1eF3JNvx2pLZC0Hwe8+LK3F1oW99sbemVPlYOWa0yRRhAePaCF/TyfNtFRX9lQE+
         C3cIRUAsVWSSciFa2h6VWOfjziiLnnkEVRepSzoACM81P70s8Yrnnwo6DtITMcyi9ccn
         BvgdxO/bAoprn8CYdgGc2RoPHMUiq9x/ik15wNONCMSE9zCFYMaL4wwEtPDvKOlCb1WA
         j49J+ExauJnytqBS71fHVRz55g9zxx9DfBUHZL1XiLYZN99x3KIc2zwWm7wznJ9MoLyH
         9jeA==
X-Forwarded-Encrypted: i=1; AJvYcCUWQASAvaRDAVPcVDZBf5Mj0CqMkfJzijy1zDu2szqBHWAth16BQVZMxGAxI1LK9AuTVpslFhr44jS75y9iYVsQj/DPD1b1vQsPCNxSS3JO5HWkoRD8ZxwTz0zgr1p0S6/aL6siWGfnmQ==
X-Gm-Message-State: AOJu0YwWeyPZSVRre4JEIr6Ygw4WnCTAXbBItPd5DgGHGjPx+NE5Le1A
	uRilH3FU3hKX/HZU43tVqXSH5al217GZmEx14xGVtpBN4WFfYMe1E0zEpARnAGMDC/RFLHvvVaR
	zDUFkSoJeDlUoUrJiM2vR1eJNnScf6RTDkA==
X-Google-Smtp-Source: AGHT+IGyprlgMqb1PSWV/W4lvz0OA8aUMxdwsofz1Aj6sKzkZI1MvB/GcBj/4MOkkj417LlFdIz34kK7mdo05QGiGf4=
X-Received: by 2002:a05:6512:1244:b0:52c:d6d7:9dd0 with SMTP id
 2adb3069b0e04-5331c6a1a86mr1585932e87.20.1723807802357; Fri, 16 Aug 2024
 04:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org> <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org> <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org> <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
 <875xtd48ps.fsf@geanix.com> <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
 <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org> <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
 <878qy7vx5j.fsf@geanix.com> <CANeKEMPD=nLnor8-oF0t9D8f5D+mLU4XqZ-07avX55BF3TJ8_Q@mail.gmail.com>
In-Reply-To: <CANeKEMPD=nLnor8-oF0t9D8f5D+mLU4XqZ-07avX55BF3TJ8_Q@mail.gmail.com>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 16 Aug 2024 13:29:24 +0200
Message-ID: <CANeKEMMRuFXiqQ6uHuo47qai7w5E_1KdTht_rNczPdOHsEcpfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Esben Haabendal <esben@geanix.com>
Cc: Michael Walle <mwalle@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Jaime Liao <jaimeliao@mxic.com.tw>, leoyu@mxic.com.tw, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>, 
	Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I now try to test the OTP code using a Mactronix MX25L3233F with
Beagle bone black.
I manage to connect using a SOP DIP and connect it to an spi port using SPIDEV.
And I use the flashprog tool from https://flashprog.org.

That is just the background of my environment.
Now to the point, it seems flashprog.org does follow Mactronix.
The same JEDEC "C2 20 16" used for 4 different chips:

# ./flashprog -p linux_spi:dev=/dev/spidev0.0,spispeed=512 --flash-name

flashprog v1.1-dirty on Linux 6.6.32-ti-arm32-r5 (armv7l)
flashprog is free software, get the source code at https://flashprog.org

Using clock_gettime for delay loops (clk_id: 1, resolution: 1ns).
Found Macronix flash chip "MX25L3205(A)" (4096 kB, SPI) on linux_spi.
Found Macronix flash chip "MX25L3205D/MX25L3208D" (4096 kB, SPI) on linux_spi.
Found Macronix flash chip "MX25L3206E/MX25L3208E" (4096 kB, SPI) on linux_spi.
Found Macronix flash chip "MX25L3233F/MX25L3273E" (4096 kB, SPI) on linux_spi.
Multiple flash chip definitions match the detected chip(s):
"MX25L3205(A)", "MX25L3205D/MX25L3208D", "MX25L3206E/MX25L3208E",
"MX25L3233F/MX25L3273E"
Please specify which chip definition to use with the -c <chipname> option.

Now for OTP, looking at Mactronix data sheets:
MX25L3205(A) does not have SFDP and no OTP
MX25L3205D does not have SFDP, uses 2 asymmetric OTP banks of 128-bit
and 384-bit.
MX25L3206E supports SFDP, uses 2 asymmetric OTP banks of 128-bit and 384-bit.
MX25L3233F supports SFDP, uses 1 bank of 4096-bit.

New Mactronix chips also use symmetric OTP banks:
For example, a chip I tested before with OTP:
MX25L12833F with a JEDEC "C2 20 18" supports SFDP, uses 2 symmetric
OTP banks of 4096-bit.


My conclusions are:
1. The best way to support Mactronix chips is to read the SFDP.
    The table with IDs is relevant only to the old chips that do not
support SFDP.
2. The OTP parameters need to be provided via device tree or sysfs.
     We can not find them on SFDP nor can we deduce them from JEDEC ID
with conjunction of having SFDP or not.
     Sadly, we need to enter them on a hardware basis.
     As OTP support in driver is for symmetric only.
     We are talking about 2 parameters. bank size and number of banks
as Mactronix offset is always equal to bank size.

Erez




On Fri, 12 Jul 2024 at 22:16, Erez <erezgeva2@gmail.com> wrote:
>
>
>
> On Fri, 12 Jul 2024 at 10:21, Esben Haabendal <esben@geanix.com> wrote:
>>
>> Erez <erezgeva2@gmail.com> writes:
>>
>> > On Thu, 11 Jul 2024 at 21:57, Michael Walle <mwalle@kernel.org> wrote:
>> >> On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
>> >> > Yes, I think we should.
>> >> >
>> >> > Reading the specification provided publicly by Macronix.
>> >> > For all the JEDEC IDs with the no SFDP flag in drivers/mtd/spi-nor/macronix.c
>> >> > All of them have a new version or a new chip with the same JEDEC ID
>> >> > that supports SFDP.
>> >> > There are 2 chips that Macronix does not provide spec. in public.
>> >> > I can ask Macronix technical support on these 2 chips.
>> >>
>> >> We don't add flashes we cannot test.
>> >
>> > I did not suggest adding anything new.
>> > I refer to the list of chips we already have in drivers/mtd/spi-nor/macronix.c
>> > I presume someone tested them before adding them to the list in the past.
>> > And probably the old chip did not have the SFDP table back then.
>> >
>> > What I checked with the chip specifications is that all Macronix chips
>> > since 2010 have SFDP.
>> >
>> > The situation today is that all Macronix chips that are NOT in the
>> > Macronix table work based on the SFDP table.
>> > But new chips that use a JEDEC found in the Macronix table, skip the
>> > SFDP table and use the setting of the old chip.
>>
>> Not entirely true.
>>
>> Those that entries in the Macronix table that has SPI_NOR_DUAL_READ
>> and/or SPI_NOR_QUAD_READ in no_sfdp_flags is caught by
>> the magic flags matching in spi_nor_init_params_deprecated() and will
>> have spi_nor_parse_sfdp() called from
>> spi_nor_sfdp_init_params_deprecated(). So flashes reusing ID for these
>> will have the SFDP tables parsed.
>>
>> The rest of the entries in the Macronix table is not so lucky. When a
>> replacement chip (with the same ID) is used, it will not be configured
>> with the values found in SFDP table.
>>
>> > So I suggest we read the SFDP table for all Macronix chips.
>>
>> Based on their strategy of re-using flash ID, I think this is a sane
>> approach.
>>
>> > Old Macronix chips that do not have SFDP will use the setting from the
>> > Macronix table. i.e backward compatible.
>> > While new chips which do have an SFDP table will work with the new
>> > setting we find in the table.
>>
>> Yes, if we apply the new SPI_NOR_TRY_SFDP flag to the matching table
>> entries.
>>
>> > Of course, we might have issues in parsing the SFDP table itself.
>> > So we fix them as developers report and send chip ID and part number
>> > with the SFDP table content.
>> > I do not see the point of "hiding" with the old setting.
>> > Anyhow, as we do not like the IDs table and keep it for backward-compatible,
>> > so it only makes sense we should use the SFDP table as much as possible.
>> >
>> > My check was to ensure Tudor that all Macronix chips have SFDP whether
>> > they are in the IDs table or not and we are not wasting a no-op on a
>> > chip which can not have an SFDP table.
>> >
>> > All I suggest is we add the new 'SPI_NOR_TRY_SFDP' flag, to all
>> > Macronix chips.. Which will try to read the SFDP to any Macronix chip.
>>
>> Makes sense. But obviously comes with a risk as we won't be able to
>> test all chips for regression when doing that.
>
>
> Finding an old chip for testing might be a challenge.
> But I think we can simulate the behaviour with a new chip that does support RDSFDP.
>
> We can change the RDSFDP opcode of 0x5A to another value of an unrecognized opcode of the chip we use for testing.
> I assume the behaviour of receiving unrecognized opcodes remains.
>
> Erez
>
>
>
>
>>
>>
>> /Esben

