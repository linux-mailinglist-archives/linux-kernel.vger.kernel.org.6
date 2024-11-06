Return-Path: <linux-kernel+bounces-398094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6F9BE53F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2120F1C20E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316D1DE4FC;
	Wed,  6 Nov 2024 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGM9C+uD"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E501DE2DA;
	Wed,  6 Nov 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891376; cv=none; b=er1RKa4rl+ZoANyVRpsom0mAmBYv4kIOV7FYg4xThWnVH4Rqek8j+dT743/aag/UCg3q+LCdPBe2kdrFl1d7maLPcUAx3DpnxDsznUWK9g9dZZKmANY2TKumP7oi0Ybe+9zG7+25irM+sNpzzgBFg6kYxEn1MFIfFJxSxnrMR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891376; c=relaxed/simple;
	bh=snzjNfHjqAFnkGq1r9MG22FiC/VAIWDdrnPvCVsOl1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwvmct4YwSqyt9go6yyhadgynozmv1iVjAhY3f/2RXQbsfO7AuoXkosXDCtHabnngK/wUpi/mUvtyKekPetWCAxrH1JIv3Kd5dCxrvj65nKSovjcQ6+p1wB+4DNGF0oAfML9I/WHG+X3GPdVvF84YbQ/KDn2OxbUL1w6rEyAOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGM9C+uD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so5602292276.1;
        Wed, 06 Nov 2024 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730891374; x=1731496174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Vpj6pPEf0EmMHYTr4Iju1EZzUqtCf2UuA/FxmYMKsM=;
        b=nGM9C+uDJTssrDsSk1EqzyWSRyCO4iWwKowMnK2DCgqbIUDB6V1iQADctePnZnCerr
         FTI0WaUTRPmla3q5hrP5pRrI9KPdQ2i7ceaEdY+X6vtY5LIcGolXxNXJ5FoE4Lg/4L+8
         7f0P28AE+874C0QXmbbmFyOdqgR/uHkWELE6mLa2AfREOjL+lrMzKwx8x0HFypwytmV2
         cF0mn6uCkVreC1FY6fMEdg4Cm1/WQvlrm7CnwC47WagCUQ+y/l2Cjg5dJoqVckDhqMwQ
         oj7Nfn0zBQ7M5hRA3x2YZPrdDryuji3RAxRy/OYora/LU1rWzZu1yQmaFUpTYgAzBEOb
         UJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891374; x=1731496174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Vpj6pPEf0EmMHYTr4Iju1EZzUqtCf2UuA/FxmYMKsM=;
        b=Q8od4y6PvDiSjZkO0v+WNPIyPGfhxlbkIk77dXyaSJYnGGpUolhjPN1hT+z+hQTQYC
         +LEW6UQGXDA9l7r3qMvGT/jFuN9ia27luArrb1jkt3Ys033UpUj1bpVWDjgrdfMP2e0Y
         y32GaV82P8FJj3hvkSueENPrzhZxvzX5zj+N6DajHF46+kutiB794QNNGa+ACmzsixMY
         B1HYsZ8kw563xF6dNXLSy26qnjWMdTbh0Gioq3xm8zt/bAV/QCVxKk7FOIHz2jFeIXCP
         Gs0BE00f/N/nkFVvfbEv/ryXyvLbBc3VoV49A38KpVKL5nwjDX+l2H6WUWEJu7Vrmv5J
         dYkw==
X-Forwarded-Encrypted: i=1; AJvYcCUu69OF3ngNfx8dbMEJkq5SoG7NkRX+7iFsaH0RoiEmlQzY/ukBLt+DwsLeD9qv3kGwWtecTCM2MC+v@vger.kernel.org, AJvYcCXhKEhFSmKePd4yqkXTnj8NwUb2dxMXGfyhUhoXOsg52/uudPulv6Q+jc9ut9N7c2cvRWQgHl7svuhH/j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiW/Vuy2FXi7Z3LNDW0kel0rNASZRJsi6nVa5bdNqAx/rDWGq
	l27P11UOF0RIqHHpuR/HzosXwC0sbPnoFEIincnhDFfjQMsqgSdvDem0cJYbfMlfGHp7F+DU7CV
	k5tMoUX4DNYAhBtoDWX6bNMRRkDm+WeKoayA=
X-Google-Smtp-Source: AGHT+IE0WB272AhVsNiDIdLQWYOMWMiR/dwnuKDyc8ckezqJfdF5u82ZkLJ9uQe57n5OHXFMIVftWU43Jz6lJdD9KQ0=
X-Received: by 2002:a05:690c:4a02:b0:6e7:e3a9:f30d with SMTP id
 00721157ae682-6e9d8935894mr406686417b3.15.1730891373944; Wed, 06 Nov 2024
 03:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028080415.697793-1-wojackbb@gmail.com> <ZyDRIW0DIGn_FIsD@hovoldconsulting.com>
In-Reply-To: <ZyDRIW0DIGn_FIsD@hovoldconsulting.com>
From: =?UTF-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Date: Wed, 6 Nov 2024 19:09:22 +0800
Message-ID: <CAAQ7Y6ZGrQt+rPBK9PzwJRC5ErbFgbc239X=iwjRboY3HU6O8g@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add MediaTek T7XX compositions
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB AP Log Port.

I:* If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB AP GNSS Port.

I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB AP META Port.

I:* If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D86(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is ADB port.

I:* If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB MD AT Port. User can use the port send AT command.

I:* If#=3D 7 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D88(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D07(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB MD META Port.

I:* If#=3D 8 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D89(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D08(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB NTZ Port. User can use the port send MIPC command.
MIPC is an instruction set designed by MTK, similar to QCT's QMI

I:* If#=3D 9 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D8a(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D09(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
It is USB Debug port.

Sorry, I don't understand "not accepting modem control".
Should I set the non-MD ports to true?
for example: USB AP Log Port.

Johan Hovold <johan@kernel.org> =E6=96=BC 2024=E5=B9=B410=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Oct 28, 2024 at 04:04:15PM +0800, wojackbb@gmail.com wrote:
> > From: Jack Wu <wojackbb@gmail.com>
> >
> > Add the MediaTek T7XX compositions:
>
> Can you say something about what the various interfaces are used for
> here?
>
> > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D05 Cnt=3D01 Dev#=3D 74 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D0e8d ProdID=3D7129 Rev=3D 0.01
> > S:  Manufacturer=3DMediaTek Inc.
> > S:  Product=3DUSB DATA CARD
> > S:  SerialNumber=3D004402459035402
> > C:* #Ifs=3D10 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA
>
> > Signed-off-by: Jack Wu <wojackbb@gmail.com>
> > ---
> >  drivers/usb/serial/option.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> > index 4f18f189f309..b6118f545386 100644
> > --- a/drivers/usb/serial/option.c
> > +++ b/drivers/usb/serial/option.c
> > @@ -2244,6 +2244,7 @@ static const struct usb_device_id option_ids[] =
=3D {
> >         .driver_info =3D NCTRL(2) },
> >       { USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff,=
 0x00, 0x00),
> >         .driver_info =3D NCTRL(2) | NCTRL(3) | NCTRL(4) },
> > +     { USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff,=
 0x00, 0x00) },        /* MediaTek T7XX */
>
> Should you mark some of the interfaces are not accepting modem control
> requests similar to 0x7126 and 0x7127?
>
> >       { USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
> >       { USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
> >         .driver_info =3D RSVD(1) | RSVD(4) },
>
> Johan

