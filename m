Return-Path: <linux-kernel+bounces-356882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE6A99681F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C722288E04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03551917D0;
	Wed,  9 Oct 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlxcAB21"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14E18D650;
	Wed,  9 Oct 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472360; cv=none; b=WKnxRXRSXdq/jTchvbKC0ZlQFNwaGyku92UxY+dMeMuSRbEc3FupFHNT4VbcC34x1vuWXasx8vUlOQeP7+OE9T4CBHyKokMqvV6ejL+vq2VwTOVqGdazgqTgZaNCOToN4akaMgY5L/BQ1XWcyowyD1JIEE1uG7sdzQoxafomMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472360; c=relaxed/simple;
	bh=odr3KYGuwaICoyzUPe/rTktD0YnP2NYwUdz0JzWijOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpGI4CQqq8uoUOjpCIQP0jGet8/YMyG/2fVsA/DMZro94OCrA02sIz5SXuOWQGMvpAmROjNFYOdkdF5MAKNbIQd6sSSmLnuH0vmCFfv3CAzaspHI6Wvsfci8g1TYt8gYV1NtDweG1oGMP88udPRiAhUP7prBcP0Fqdwc13bl2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlxcAB21; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db54269325so5512850a12.2;
        Wed, 09 Oct 2024 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728472358; x=1729077158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odr3KYGuwaICoyzUPe/rTktD0YnP2NYwUdz0JzWijOI=;
        b=KlxcAB21vC9jwugsY4vyQgtpskVcYIe/LXT3tdhxNyZozVm9DwBt6rjlpEYPXhSd+u
         LbHAetVjINIh2yDwiEqtWpr4KwoRM0rWw9GssmpZNDb6G6NpJVA/UQtSlti03+mpk+rD
         ss0JtKfMYPqiQk+aZTb3XBECrwyjEjmAgQj2L0MwktXEdk2gfjCwNNV0xrUVaW0gTvUo
         cYLkN/QezAIOA+nHS4cVQfpAB2kPvTtbk3H8hG8VStF7I6dVruGJZxz33vGJgEho+mYO
         FoFXa1Da+S6RiHhKibG/aBKGA8SDKaEfngHMl46MpbRYI1k4WGwg1QA/t4anCngVuX3v
         wQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472358; x=1729077158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odr3KYGuwaICoyzUPe/rTktD0YnP2NYwUdz0JzWijOI=;
        b=RtJijIt1mA+ojh7QZG/V2oNTc9RicASwqcx3tZg3rMTdSpalR7e9d4DcImNC7k8iHc
         IneJJKBELle9BnNrbTCMLdS3qk4WapZgHvSL9HGjiGztbgA9P/KOYY3dvO2Wt3oRypj0
         NW0Xaysn3jFSJHQZC3BwVkJVCRS/c1RSg7/Czv3HYGuJm61eReQxbA8iT+2XqzPzaZje
         Fw1TA05S0mUprVcwgEZuaVCo5PlAZ4ptv+yrAObRtLCY50rIhv2nkzmSL9mkVv85NBeo
         BurmKLHRoqOG1+nxIo+OmvkHMjVAPNLxGLgxqf9/9YJtqAgSI+Y59zlw0YN3H/Div17m
         JuOg==
X-Forwarded-Encrypted: i=1; AJvYcCVPASGSuSRObJfN+ZiOD5tlV8U0xHJ5fJI5LwRyHld2KrCo58+2ZfM9e0QDxOHgAaRc5MUS92+0rPc3@vger.kernel.org, AJvYcCX5KsjRedmALmUWboKI8oXMNZn/98pJu9Nixv/qX9rsrJlSofiPbViUiLKv+TL1EB/ZSmiXf51dWzVBNdBq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7KrEtW6JN9Hbsjm+ZwsnX2PmmTwr9GeyzJ3izgiec+8luF2Q
	2yXdwfUHxmNsMzlnMbGaBjUTN80M3uXGxnJPhM/+K4/qvowNG70To+7P9z7bIszNwqJcESVqjy3
	rvhADkR8ANmdBnKyFkbS8x4w0WA==
X-Google-Smtp-Source: AGHT+IFwysyjBLU7ERqLumIJZpSaa7EbDDdS4YrYb7gYDEqaa8ju2PO2q8BQXBp1mVBphI1pWXcv7wgvxz3fAs4YzQ4=
X-Received: by 2002:a17:90a:2d86:b0:2e2:973b:f8df with SMTP id
 98e67ed59e1d1-2e2a25519d9mr2434624a91.35.1728472357961; Wed, 09 Oct 2024
 04:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930202639.37606-1-jihed.chaibi.dev@gmail.com> <e009fba7-7881-433a-9e33-f4c5f9d0fd86@linaro.org>
In-Reply-To: <e009fba7-7881-433a-9e33-f4c5f9d0fd86@linaro.org>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Wed, 9 Oct 2024 13:12:26 +0200
Message-ID: <CANBuOYrqCGd5x8Gh8DocMAPhGwDts4dKF-NGTGbqpL_OBtXrUg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: microchip: sam9x7: Add missing usart-mode property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, conor+dt@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, thanks for the feedback,

I reached out to the developers who initiated the DT support for the
new sam9x7 devices, he explained to me the general workflow, turns out
the dts files aren't yet in linux-next.

> I think you work on some really old Linux kernel, judging by CC list.

Indeed, I used get_maintainer on an old kernel, my bad. Will update
the CC list & the patch once the new DT files make it into linux-next.

Best regards,
Jih=C3=A8d



On Tue, Oct 1, 2024 at 1:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/09/2024 22:26, Jihed Chaibi wrote:
> > Add the atmel,usart-mode property to UART nodes in Microchip SAM9X75
> > boards' device trees (boards which inherit sam9x7.dtsi). This ensures
> > compliance with the atmel at91-usart.yaml schema and resolves errors
> > that occur during DT validation, such as:
>
> That's redundant statement.
>
> >
> > arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: serial@200:
> > serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
> > from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml=
#
> >
> > arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
> > serial@200: atmel,use-dma-rx: False schema does not allow True
> > from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml=
#
> >
> > arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
> > serial@200: atmel,fifo-size: False schema does not allow 16
> > from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml=
#
>
> And why is this a property of SoC? Does not look right, at least nothing
> here explains this.
>
> Trim the commit msg to relevant logs and statements. You do not have to
> explain everyone what dtbs_check is.
>
> >
> >
> > By adding "atmel,usart-mode =3D <AT91_USART_MODE_SERIAL>" to UART nodes
> > 0 up until 12, these errors are resolved, ensuring proper DTB validatio=
n.
>
> But in the same time you entirely skipped relevant information: why is
> this a correct fix for the issue.
>
> >
> > This issue has been tested on the sam9x75 (sam9x75eb & sam9x75_curiosit=
y)
> > boards, both of which inherit the sam9x7.dtsi file.
> >
> > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
>
> I think you work on some really old Linux kernel, judging by CC list.
>
> Please rebase on latest next or mainline kernel.
>
> Best regards,
> Krzysztof
>

