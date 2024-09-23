Return-Path: <linux-kernel+bounces-335739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC597E9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2C11F21AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82F195B14;
	Mon, 23 Sep 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAx9xVyR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895A26AC3;
	Mon, 23 Sep 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087543; cv=none; b=T/jNiI8cSwv0e/kjWm7yuT8PeqrHTy4PMxBKmdXB5Rl/LiJ7G7LpbeTSdYmKy1aY0et82PYs3ortVEmQbh25y5jrpI0EfZSlqd8dupQHQM5LFYAewemo3Jsw9S7pREMAlPmrQYfXm+r5/T45XIxIgsF/A3ks/RjUzBMF0eUbdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087543; c=relaxed/simple;
	bh=1nn2x9pxDWV/l379KhESWhG2apMUdXu6/sxP7e+JNcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpJLd5rmSaDcTzUKW/ow9RPBJ9qtZ47KT9IgiYSvoGgTiYZTnw3yHWp0bOpkBkjINSoroG8Mlwlc5TnnIcWCCX73rzNcm9pQlte8B/LjCoFr7nmCv4YFbArYbjUPl4o/WFbrItWZmWdQ34ZL7M5ezsh5d8FzIf1ko4jsnH4uZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAx9xVyR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso2082566b.0;
        Mon, 23 Sep 2024 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727087540; x=1727692340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7WybMhTFjyQNe3MuiaKvgD14pvzxhatRQ1+PvPY2Qk=;
        b=TAx9xVyRnHoNRn9FrDiazMl8CWSebwC46tXMhbBLXOHgSb9QCMv8XVp6iN1fnqO/R1
         Tk0PjpuvZ43gNqk79zfuS3EJpWawOtRQVCRxXNvM0bbWG9FQyikh4VhrR+hYQSMJsD6O
         zDjf26ZerQIQWgujP8OfrQgah/mXaqfD/C9X9D6hENhKUVGAH2fGiP5ElXHUq+j6sJQq
         fsH5PQNMtPn/7eX8TE99DZuv1MrZRKkxLSmcRCbmY8IZmxF0sn1gd6vB+wnrmprKZIqV
         rtdkq81XAb0HwO9/e7OKlpfD+tl5+3AvQSgqBt+lxszuozjiW91j2GGjQRL9rTiOJ4n3
         o1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727087540; x=1727692340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7WybMhTFjyQNe3MuiaKvgD14pvzxhatRQ1+PvPY2Qk=;
        b=Xq4zH3ZSoV2iqgTTbo4aBvERntHx37FFS/aCFsFmaQUVxVYI4q/m1SBO9oemKT+lHz
         lNPX8SL5rFev0mJlrZ0jZxl86/ZmPrtijiPmuwota/EghBBZdePsKIhhC372/rcSs31X
         HBjLJuPurEy+FmkiI0nWvxqwdP7UCBR9kMcmDXPdl2bqggpVpe5RMPRBm6mqrW4gWbfC
         3eXDggoSxNB2WU5HO5rn0q3SEz05X+sxwk+bY73XS3Mlzf4R5FYkdQmtB7flKk8+viN+
         UM+y0iGk7jD+mhPBKYMrzk726zDJGoPNADiwgTH/q3PB28Ye4N/tXveNFw4g/JTKJ7Ns
         eF2g==
X-Forwarded-Encrypted: i=1; AJvYcCU0uQnZ67YKYDa5tfTrD7BM31Swm6aCQB+OpcCUkcxS7Te2tl3r96P8OMYCio3nb0LZd5mm8HeWa9NP@vger.kernel.org, AJvYcCULxXjIffaNlBLxT62l+wQpttw2plaVasW/tPqCpety1bypUiqSsMGyweA1blzYAN3B29ucChnL99EzLIwY@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPQrB9xFIb4GRf3HOQVQLGjjhjTsDJUtHcMeOpEWFsyXBBSMo
	E7XHEVHhcR3WI05zzSy52INq9Dk+dUiWi+Jo4ud/S1qhx7fLVYFT+Gq6nnxYWTi+I/Uy7xuD0gt
	wyLyPUlEwAuGhbAl4Su9PQe5VbQ==
X-Google-Smtp-Source: AGHT+IHeqaggM+UXfU/T/6f5PbCqBXtnxIWll8SaceKEzyUrkfKVLbRY45ZmR2+j9VeHTNJR6u24o1KKU9NZSFh29b8=
X-Received: by 2002:a17:907:3daa:b0:a86:6a9a:d719 with SMTP id
 a640c23a62f3a-a90d364310fmr1068934966b.29.1727087539905; Mon, 23 Sep 2024
 03:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
In-Reply-To: <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 12:31:42 +0200
Message-ID: <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 08:04, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Hi,
>
> On 9/20/24 7:12 PM, Erez Geva wrote:
> > From: Erez Geva <ErezGeva2@gmail.com>
> >
> > Add flag for always trying reading SFDP:
> > Some vendors reuse all JEDEC IDs on manufacture table
> >  with new chips that support SFDP.
> >
> > Add flag for reading OTP parameters from device tree.
> > Some vendors reuse JEDEC IDs
> >  with several chips with different OTP parameters.
> > Alternatively we read parameters from SFDP.
> > But the OTP parameters are absent from the SFDP.
>
> Do you have some specific flashes that you try to identify? Why can't
> they be differentiated at runtime?

You can not figure OTP parameters based on  JEDEC ID and SFDP existence.
I did send a few examples.

One of them:
"How?

When using mx25l12805d, we do not read SFDP.
As it uses the no-SFDP flags.
When using mx25l12833f hardware with mx25l12805d driver, it did not
try to read the SFDP.
Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
driver fetch the SFDP.

Secondly SFDP does not contain OTP information.

mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
While mx25l12833f has two OTP regions of 512 KiB.

How do we handle it?
I would gladly remove the obsolete mx25l12805d.
And skp compatibles all together."


>
> > So there is not other way but to add the OTP parameters in the device tree.
> >
>
> If there isn't any way to distinguish the flashes at runtime (which I
> doubt/challenge btw), then as a last resort we introduce a dedicated
> compatible for the flash in cause and specify all needed parameters in a
> dedicated flash entry. This shall be more generic as further flash
> parameters can be statically specified in the dedicated flash entry,
> less invasive for dt, and less confusing for people when they decide
> whether to use OTP or not. OTP params in device tree is a no-go.
>
> But again, you have to prove why you can't distinguish the flash at
> runtime before introducing a new flash compatible. So don't go this path
> before sharing with us what you're trying to achieve.

You keep sending me contradictory messages.

I told you we can not "guess" OTP settings based on JEDEC ID and SFDP existence.
It may be partial and Macronix may add new chips in the future.
They reuse JEDEC ID only retaining flash size and blocks.
This is why compatibilities work with new Macronix chips . Although by
reading the SFDP, we can use higher speeds.
We can use SFDP parameters to read  flash size, blocks and speed.
But it does not contain any OTP parameters.
I found only one Macronix chip with an enterprise SFDP table with a
boolean flag for OTP, this does not help us much.
Macronix technical support was explicit on OTP settings. You can not
deduce them. You must know what chip you use.
As far as I can see, Macronix does not reuse module names (god thanks for that).

I do not mind using flash compatible.
Just clarify that point.
And I will send the patches accordingly.

Thanks
Erez

>
> Cheers,
> ta

