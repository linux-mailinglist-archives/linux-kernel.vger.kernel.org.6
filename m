Return-Path: <linux-kernel+bounces-236078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFC91DD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D21C216E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C2136664;
	Mon,  1 Jul 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB9yszEv"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB612C489;
	Mon,  1 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831357; cv=none; b=N/OzuxYFpNXgn/jE/R/iV/JRWmIp8IBqKD9YJjPil6PUFVL2w4ZHuuplWf9Z3drZIFTPjxlVZulEVkBPABrWg20xoyrzClWm2BOv8w1YAad3ZCGZmvoujAIvr7XQepfZHz0rr4+Jr65DkM6evI6O54urLI1jh1osXj6QM79sYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831357; c=relaxed/simple;
	bh=X3RcYdLq/Lsq/wq9vKrRrPvg8enu2de4SNTQnenVjbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rh3ieZWRRn98/tLtT7a6Gi0w1fuZJ/hdU9WkJbwD2ufVWpi9cU94a+55q+ks2Oivpuwkb9NM+4FrveZrSgdna8HnLYqZexgxZxH+pvsYQzB8LgpZxKv7+CppskYKYa8BFXkC94OJ9LucbyrFoc7EsTcv7wlOt1ISUDfrGVyUpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB9yszEv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6fe617966fso246265166b.1;
        Mon, 01 Jul 2024 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831354; x=1720436154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3RcYdLq/Lsq/wq9vKrRrPvg8enu2de4SNTQnenVjbY=;
        b=VB9yszEvSh6gare+muTp773UVgank/MKQMY+HikmnlkOABz1v1eZqjDyy6R9MzRt3l
         g/r9gG4CTFqxAd8F84a7Knf/p2h3zLJgiZbnW/OLPcZaghSE4E67RpBobw9c3TFK17y4
         +r3D5A04dZA6vv5i8A5Roo+suZfv4BffTnRfwqNnp5gRTt59PqVocKKn+aOpOHAGEGTY
         pNZadRttgcjy/f6g8WatJzEbFo22e9sscl/xMW86k++vGh8AZi3g4prhGK2gcRhibDg/
         S4bbxARe8pG6RKE8UXGUknrOSnAQteNMv82uOJOaLKWRSxF/AODXNL5z1g7OYhsNWUfu
         yl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831354; x=1720436154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3RcYdLq/Lsq/wq9vKrRrPvg8enu2de4SNTQnenVjbY=;
        b=C9YWfGC8T9StLXvvpB1+Jt30kze5jawACPQDvPBuJNeycoSmUqp99cNGGGROsaoP1b
         c3y+Z8jIZIeQRdThacPur/TusiGLBV4zMhqUAs+w0YNi6vSG2vsjNsjVY9Bvj5cKpa+b
         YPpQlftDTHLDAwdTgxs91cPSSugAi2kUSKjem/i/vLxZz2gYFVYwOoi6ujxWreKxNmuS
         SMKZGOSoEpuYg7/xBV/l5RcenFU1Rqv6GwPS1vIMz/Zet7CGhdLny1S1E3FUvjCMiXxC
         jDVpZHvcHtjZoVmDTnJ8AnSnTXXSOskAIW7KRbfO0o6Se/KN67t0FPDEblFzSa85J8Nq
         mNew==
X-Forwarded-Encrypted: i=1; AJvYcCXOoKp1JdCJgFovzezqjamROBOqkDbce05oclpqrtpbLi27vUwS98yGPZhROQTJwrfL7hs0ubb99JbMh8yyY2ewNoGlbK6fvwG0mI+lnY6Wr1Q/98FveFfK8Cf7yZlRYLwyxoKsJIW23w==
X-Gm-Message-State: AOJu0YzlD85QKGAilXTuV4Ikg0WssN9J1psff5bm3rkn00kv7xug+UvZ
	r19jNwF6KgBEEH8a6vaXNxa/E2z6xNt1CNb7d0jNu9INIh4Z7GscFrwhUBNNcVDatbpojo+6TBB
	4239gogI9qTRGJJUjJIn2MBDWNQ==
X-Google-Smtp-Source: AGHT+IHf+jvSnMsS7fnrtn/Hefkzj14PsozhqErpwtq9dwGfGgvNEIM8z2teFIhhWo8QauH1P4mlEOP/wT0RZ4zrz5w=
X-Received: by 2002:a17:906:af87:b0:a6f:22ea:55b6 with SMTP id
 a640c23a62f3a-a7514511fe7mr333247566b.65.1719831353783; Mon, 01 Jul 2024
 03:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629103914.161530-1-erezgeva@nwtime.org> <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org> <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com> <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
In-Reply-To: <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 1 Jul 2024 12:55:16 +0200
Message-ID: <CANeKEMM_9qs8neP=Dwks_enmUt9oqGx6+UO=CvAh_4Fm+eF+ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Esben Haabendal <esben@geanix.com>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 12:15, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 7/1/24 10:46 AM, Erez wrote:
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
> >
> > How do we handle it?
>
> You would first try to parse SFDP and initialize the flash based on
> SFDP. If there's no SFDP then you fallback to the flags declared at
> flash declaration. Esben had a try recently, see [1]. I don't know if
> there's any progress in that direction.

That's great. I probably haven't seen it yet, as I used kernel 6.5 based.
However the OTP is not in the SFDP.
Reading the SFDP with "mx25l12805d" does improve :-)
if a user wants to use the OTP, he must specify "mx25l12833f".
Perhaps less likely, but yet no other solution for OTP at the moment.
I would not go to a kernel config for this.

>
> Also, you haven't mentioned anything about the testing. Do you have the
> flash?

I test the code with mx25l12833f hardware, with an older version of
the kernel, 6.5 I think.
It is a kernel provided by Microchip with their setting, The SPI-NOR
driver is vanilla.

In my testing using kernel 6.5 with a Microchip based board.
Before changing, the kernel driver, was using the "mx25l12805d"
setting and did NOT read the SFDP.
Once I added the "mx25l12833f" without any no-sfdp flags, the driver
did read the SFDP.
The driver can find "mx25l12833f" with a read ID, once I remove the
"mx25l12805d" setting, I did test that too.
Adding the new 'SPI_NOR_TRY_SFDP' is great. but does not provide proper OTP!

All the testings were done using the same mx25l12833f hardware, only
the settings in the driver were changed.

I am no longer in contact with the company that provides me the hardware.
And as this is a Microchip based hardware it is difficult to use the
latest kernel.

Anyhow as mx25l12805d hardware has not been sold since 2010, it is
hard to get one.
I do not want to change any setting of mx25l12805d without testing!

Anyhow my patch is focused on the new Macronix OTP callbacks.
I do not care about the "mx25l12833f" or "mx25l12805d" compatibilities
or settings.
If I had a different Macronix chip with a unique ID, I would gladly test it.

I only add them as the kernel rule is that new functions must be used
and tested with real hardware.

Erez

>
> [1]
> https://lore.kernel.org/linux-mtd/20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com/

