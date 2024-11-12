Return-Path: <linux-kernel+bounces-406770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F69C6542
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F70B6826D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068921A4D8;
	Tue, 12 Nov 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvM+mkfU"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9B43AA1;
	Tue, 12 Nov 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447693; cv=none; b=ERJO6f5PhUL5lpBoQz8FeqzbQCURXIB7jte/pRiBp00CEPrcNQH48wEMEC8xv9Jwa9AJZCNS90flyoKK0ixTJ2vBIxSVP6QT4guFnMnaR3Vdsna1W4rP9AinlJm9SfGMMULr8GHYuGQc2OGjZPsI0s5KRmAHII3O3zSJ/GZCBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447693; c=relaxed/simple;
	bh=KtnVxQVsskG1USUpb1Ic8P4L+45XhIprxg4BVAU8c3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ6r7AdX0p+0qLKKwQpWn/dYn0wdDOgNrBX1HCtF8Sat1Ww4pQGt8x1h1bRcnv3KeES2yXy1142ZkncyZXqzc5KS1ZX7J6Jo84GkD1IffKL6Uv0Qrd4ZR7tiZELjKnaVgU68FHLOZffeAWMl3kR1CzBHyF6yA3Fw79pLLCuZFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvM+mkfU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso53999921fa.2;
        Tue, 12 Nov 2024 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731447689; x=1732052489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRngAeELuwQJtRBB1/POe1L4vH51gEWaywFmKgXDLzY=;
        b=MvM+mkfUfmBwJzfAMkLSa3XGs6lXiHnOIIR6xTHCsGFUT8sGFrqTZBn1Zm7B7Z9JJu
         Y5W6UBxhRTEAduNFoFI1nXB+3xiGuALc6iTrF9I8Kedkzliabc0bgLUDxFmeePkTBy7L
         Nklto2iVJbctyTWNsuJuLpbO+swpvmhUn+kGyLZkAvjJcvv+aQuAZd/BkUQPGyIU1iCT
         AfjOE1GAKivSnTWL/5dGXVPmnrn/9KOMl6y14RPBybCFpdtU9KzDxMYmDnWz+HwOkSoU
         7AjJCiiOLmONILXMwka4eWWEqfUplQVkhaGxPF8PnEtIIk00g77rzg2t0kOPgHe9el8L
         Pqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447689; x=1732052489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRngAeELuwQJtRBB1/POe1L4vH51gEWaywFmKgXDLzY=;
        b=AEgXiuGh1uwtXhfjX2MDm4bX1nFov1cUwdLojcGnSwMDSwBJ+NDERTEoph83iZdRts
         wpyCz5uvGIPCffaeLB5rj7gpRuJcmnZT83grxqUd1V7zcPbhvjor/jWEkKiUBDgUyS9x
         qAMwAHxShk4gIMHH82amgn6X6wzn3VGwuisXKtz3sHcQIgxUAhcd1i/uHH/nGGPFSEyJ
         XTIcHmhkYFA262HKohVpAY5xCrpJgSCxAedvlKu6dRYddFlleZ+m5LeUEzyRIpKgePEv
         T8lkbJUrnIFwkD7E8flOmnXeOrHe7cwljmeEO4OjgWshMTRln2XgTMntuRTYGMEqKfFf
         UAsA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ghQmNIswJe4/byy4b3z2mu9TeAoCCxdarSxU4D1PhmiLqq8iMslvEy1aCklZoGnqpoEFpl5yaiyOhssJ@vger.kernel.org, AJvYcCXNsBANpi55icXDmy7dD904wKRfqXTP8yYIQFFvd+90Bm6ls0XT+XOehfBCl/KKYoBbndcABGGKpkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqW7ie/SF+zxmjqz8MN1zQBQYELy7GRVQ+yrN0RgftrLf8nvt
	nJc4/P6OwxRJ1zeAQsHaCM3S0FDrDg56Wrf81DZkgDVLs95SsA8LHhTVS/rV/23PaQ88fUcfLry
	YAD2IMVGCwUpTTYScyESXLHXEboE=
X-Google-Smtp-Source: AGHT+IENMuhrw0g7Zkg4wFiRcXgNlRLJsvSoukbMIIkcwCcSQPJJsJGcIAvElPiN+4GE5DtJiF7wnZaxIyJiN/egH/k=
X-Received: by 2002:a05:6512:1386:b0:53b:1526:3a48 with SMTP id
 2adb3069b0e04-53d862c57cdmr7890107e87.14.1731447689288; Tue, 12 Nov 2024
 13:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107033303.97509-1-yesanishhere@gmail.com> <87a5e4qk7p.fsf@trenco.lwn.net>
In-Reply-To: <87a5e4qk7p.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Tue, 12 Nov 2024 13:41:17 -0800
Message-ID: <CABCoZhCp0oCTXFx911ftkUhHzkg5wwTVJyNQ1yKMWsocuwJM9A@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-model: generate kernel-doc for driver model
 using script
To: Jonathan Corbet <corbet@lwn.net>
Cc: broonie@kernel.org, dlechner@baylibre.com, u.kleine-koenig@pengutronix.de, 
	Jonathan.Cameron@huawei.com, pstanner@redhat.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:18=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> > In commit 63dc355 ("remove the driver-model structures from the
> > documentation"), the kernel-doc text was removed, and users were
> > instructed to read the documentation directly from the source code.
> > However, using the kernel-doc script to extract and generate the
> > documentation is a better approach, as it ensures the documentation
> > remains in sync with the code. Additionally, it provides users with
> > a more convenient way to access the documentation without needing to
> > refer directly to the source code.
> >
> > This patch adds kernel-doc annotations for the driver model to
> > facilitate the use of the kernel-doc script.
> >
> > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > ---
> >  Documentation/driver-api/driver-model/bus.rst    | 4 +++-
> >  Documentation/driver-api/driver-model/device.rst | 4 ++--
> >  Documentation/driver-api/driver-model/driver.rst | 3 ++-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
>
> This does not work very well...
>
> Documentation/driver-api/driver-model/bus:8: ./include/linux/device/bus.h=
:3: WARNING: Duplicate C declaration, also defined at driver-api/infrastruc=
ture:3.
> Declaration is '.. c:struct:: bus_type'.
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-ver=
sion 7.2.6 -function struct -function device ./include/linux/device/device.=
h' failed with return code 1
> Documentation/driver-api/driver-model/driver:5: ./include/linux/device/dr=
iver.h:3: WARNING: Duplicate C declaration, also defined at driver-api/infr=
astructure:48.
> Declaration is '.. c:struct:: device_driver'.
>
> Please actually perform a documentation build and look at the results
> before sending patches.

I followed the steps, but unfortunately, the warning did not appear
in older kernels. I also couldn't find any mention of where to
download the source code for the patches in this directory.
It doesn't seem to be listed in the MAINTAINERS file. I think I can
use the latest mainline kernel for sending patches for this directory
where I can clearly see these warnings.

Additionally, I noticed that this api already appears in infrastructure.rst=
.
Given that, do you think it makes sense to continue pursuing this patch,
or should I modify it to reference the infrastructure.rst file instead?
Or, would it be better to drop the patch altogether?

Thanks for your guidance.
>
> Thanks,
>
> jon

