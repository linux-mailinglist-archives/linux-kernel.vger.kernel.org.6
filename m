Return-Path: <linux-kernel+bounces-336107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4A97EF51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FCA280F87
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920519F105;
	Mon, 23 Sep 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGi8NoRi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DC19CC3C;
	Mon, 23 Sep 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109105; cv=none; b=NrvalSNTibmLgl9+4kjcU7fAP3s7pE7pPaY3hcWOWUnEWDuU+KYqP1qdRh6CKtYUVQK5kJb70iRoXoGc7SG5FVNY84AgDz5iWshdGDxGO0L2kCbA0BZen1AvFME065BrPnpBRWtNyiiOUg7tOWQHP7yRGsgqpLXUG1hWTK62PmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109105; c=relaxed/simple;
	bh=6yRhze4FyHuIBcTP7r7MLtpkZlAiemKY30J0LMEljAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwH8jpVKTm1sf5GhsMq2X97aPt2CBQO7/3nl8PGlk3uOOhlsCnJTt3se0SrLQu7wWqQx9lG+KtNHOUcGMbBbgxM+R/wPkRrOq91R/8HlqOvBjGpeZwX0CHOXcCAMuQjtfX2sJt5fNUoQHpO/xDA7eeA7A1VGoehUr2zlr5QbpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGi8NoRi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d64b27c45so847145966b.3;
        Mon, 23 Sep 2024 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727109102; x=1727713902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ9IXPKcoO2aAJVUqui1Nik74LMtr7TP71dwMS6Tmt4=;
        b=eGi8NoRiveuD0o4WvmG2AtWViI/CnnBAzI+YuZi9GqekgseSKERB8bGVPMbzPirpRM
         /buLui6YLJ7xeSnhsWiPS+KHQCnriZFGG+MyKe9i6uwfoPU5WRCeweJHWSWTtXaV3mhk
         b+MEVK0UlXaPtSvX4AhtjEyegFvk50sjizBD2YLwuyoC7K3E8T+zB9nbINJa5BnBQHfS
         yIqzNYnvSRF8Wg/Bjj7zXy6Rep8tWeo1C7rQXHhCgx4i3m9YrRVgCq6LN7Z1dZlC/KYO
         uGc3VYrU04oS3lKlnq1KZkOghOTn+FjqYIBqE8hOEzINaRvy4xgz6w3+41Da3AXZWX/T
         kIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109102; x=1727713902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ9IXPKcoO2aAJVUqui1Nik74LMtr7TP71dwMS6Tmt4=;
        b=a7ic7HPL+BEDcvx9iQ5VQaljvZUAIk8R/Unrd+XKDa6s6ls87gC2fodcJKpM4AlS5e
         0UbE/kAPhuwJANv4cOjcatxVn453duLvWJnPbIZYRvGxY6v8bGfMMul6F64v8FeQFx7z
         S932LorOjZnZ8+Y3n55ZVAeoNn+Ase7pt/jT/I+Y6BR5QEtG4GRsc+KWHV0YELlbclJm
         n1v7/yqXqB/e2icudt84GS97UlzQMdsS//g0Fxj/1WPU0QKmY2E9kePCQUZFnjwOkCSB
         oGbj+kRbqOQ210wYBGHHjnSmrHRdmmcfMLC1AOaRpoe4XF5Hmh4fczlHOBrbTCTYcAqQ
         +MmA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZTjCUZ7YRFNz3pFJZLTGS5biGILlnvCQH886lK4LjCtlJ4WgR/0QfLM9dtwLZRlCCb8/WbJeYSCaaO87@vger.kernel.org, AJvYcCW83Ilh6bUyDOTXq6fODD5hBqGBWPIgTrlxxRMIbGfL3julA2os9yslMoDJX4BZzTkDB36xlVl6rzmA@vger.kernel.org
X-Gm-Message-State: AOJu0YzzypcLxqycSnLOft4Eb/upXR1mb3RryTXli8WmQ0lEu1Z/7e/N
	uXqyBIXThctzE1tDeS3jZv6GzSOzvKXB2auHsxeEtp81lW+ddt2f6rZef/9uJtx91gP2I8U1AzS
	Mls76vH47f0GiYZnZ3AzXu+SudA==
X-Google-Smtp-Source: AGHT+IEkBJsEaKkiZf7XPyaAeoupkz7AviiwpDfFXYO8AAKPZWXhTaGvK2ID1LFyBCALPoOduXqpNp2Z2P07lzg5jD4=
X-Received: by 2002:a17:906:7308:b0:a8d:29b7:ecea with SMTP id
 a640c23a62f3a-a90d5182575mr1225005966b.61.1727109101816; Mon, 23 Sep 2024
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org> <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org> <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
 <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
In-Reply-To: <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 18:31:04 +0200
Message-ID: <CANeKEMO1nyzEKGCt8N8_UCmAcQ3L53=H8U07AdJzcnFaVuwjGQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Erez Geva <erezgeva@nwtime.org>, 
	linux-mtd@lists.infradead.org, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 18:19, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> > > > I would gladly remove the obsolete mx25l12805d.
> > > Why? I don't see any need for that.
> > Maybe because we do not want compatibility table?
>
> I don't get this? Anyway, we do not remove support for older
> flashes for no reason.

I did not insist, you asked.
Macronix stopped selling these chips 15 year ago.
How long do you want to support old chips?

>
> > No, reading the SFDP is great.
> > Except for OTP parameters/configuration.
> > As there is not way to find OTP parameters using JEDEC ID/SFDP
> > So as I understand there are only 2 ways to set the OTP parameters:
> > * Use a compatibility.
> > * Use dynamic OTP configuration, through DT, sysfs,
>
> * Use the in-kernel database to look up the parameters as it is done
>   with any other flash device. If the id is reused, look for

All IDs in table are reused.
The change I suggest is to read SFDP to all Macronix chips.
As today, we skip the RDSFDP. "to avoid no-op".

>   differences in the SFDP to figure out the correct flash device,

You can not do that unless you actually read the SFDP.

>   then add some .fixups to manually add the OTP flags and
>   parameters.

I am in favour.
As we can not use JEDEC ID or SFDP for OTP parameters.
How do you suggest manually OTP parameters?
Tudor Ambarus rejected my proposal.
I am open to implementing your suggestion.

I will split the two patches to avoid confusion.
So I will submit 2 patches:
* Always read Macronix chips SFDP, as Macronix replaced all old chips
in the Manufacture table.
* Support Macronix OTP.

Thanks for the feedback
Erez



>
> -michael

