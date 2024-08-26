Return-Path: <linux-kernel+bounces-301418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AE95F05B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480B4284B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C516F0EB;
	Mon, 26 Aug 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="OjKD+kf9"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950C158D79
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673837; cv=none; b=qKFqwbF//TI8NEoXDJ4UUc/J76p29ovx2Ujiv/zVtAbB9hkZbDssqf6gpT/xBFPyJgltusZ+ylYfZmKo4m49YseFAsm8nJENKpY0E+90FMSi8wB7qU1ZMlK1lT4S6LI+4nh1MbZf2B/I8CPo8JSgt9hQCXUa/0AMQx3s67u7aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673837; c=relaxed/simple;
	bh=AdKKjBw0DdjcO03+Gfffep72LbSKw0s4dQV6oZNLrf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJL2lFi+KY7tmJTzbOg+VbK7Q7H3q1BdLj+8NFbETYol40VGn6H7ubfFMumGthjYG7f2BTd9J+MoIp+BEIrinoxLR1zjKCFq2r71+1/LVnSvPzKGZeKdsu6HJNtGv6OmwTl/YD3j7ZoAv2JYgtTDMy/F/7+fhapH8YuWx43wKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com; spf=pass smtp.mailfrom=noa-labs.com; dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b=OjKD+kf9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noa-labs.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2701a521f63so3392555fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google; t=1724673832; x=1725278632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTtYynZLm2SbFEN9z92QLFpQbSCk9t7wWnmClZpFWoE=;
        b=OjKD+kf9UGJUK7CAj7Hu88IhZkxv3v2cqysg0hF+eoa8ZMod2i+Shef30cGG3so2mV
         dnTpff8RNWXGRkc9wbspwPXCjzvqat/JArw4zjXhwmBYg3skOzLFZHtO/C+8I+30/DvF
         N2VbCUHNpmQU5OMLCCOGaSUAqisPfsQQ0wY7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673832; x=1725278632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTtYynZLm2SbFEN9z92QLFpQbSCk9t7wWnmClZpFWoE=;
        b=MPt2Z8mFlW7X9iVJkdugNKd3EQrY/DT+zMMZkuut52p123rXNZmpQDDDL0FoHVCm+E
         1GHTeCQA5dNvOPIAgWUZ+llwGKWnseh423EW1Qg8it9FPzOt2I2MjWbjTLJfxfY93VvB
         imhqTeyzdw6UzqeEx8Pd8anpz/3NXyu+JI/fe7jiSKGe/HV3r9X35Uy18DTU0EEbuo6O
         zMLRh+mZh4XZ4NtYGKC4Nr5In0OCRxNTgn1NSgJQ9igg91d6UfxeNsSdrmY4uJ+cQOPD
         qtjeXaIy7eQZclb/m8RbGJDT/CT01YRzlZf7BanrE16yCCDMpPB9ayvivfEPpruusVJ1
         nKYw==
X-Forwarded-Encrypted: i=1; AJvYcCWCWYGSaQWw0+hK3E/gIF4DlejOrLZJSZ8iJq1M1M676n8L39IPITecQFdje/mmbZV7Jnov1xEpJRQn/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4pnvS/q91n22KQ/IGFUFp+spBntUf5vjb0bipDWLJMrzmDQa
	9YEPwtOoildllGm/3MjbhL3bZSmWguP6pj9dz6co/q7GcwS4LHs7zlP5MAjISc0kQPmiDLs6xAu
	3iXbJLhOsmrWIfqN1nD6JQ2MWpB7meENIgGKlVg==
X-Google-Smtp-Source: AGHT+IFrNumdULsnEPR04kBNU8XMjX8bG9XSVfDlwM/zGpHmPKGcSfOV8lPe2vGJr0OSfW68l7jPhnVF9tH+ZD4Q1Vc=
X-Received: by 2002:a05:6870:d0c7:b0:260:f9ee:9700 with SMTP id
 586e51a60fabf-273e652019emr11521313fac.30.1724673831904; Mon, 26 Aug 2024
 05:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821110856.22552-1-pavel@noa-labs.com> <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
 <CAG-pW8EgBE4RwhcFtMXEuFtG56JJSyvOjG5+q71zG6pJyo05hg@mail.gmail.com> <CABBYNZJL6qkOPE6UuKz+=03KTUNF4091iR=1j4e2P+Wf2c+oWg@mail.gmail.com>
In-Reply-To: <CABBYNZJL6qkOPE6UuKz+=03KTUNF4091iR=1j4e2P+Wf2c+oWg@mail.gmail.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Mon, 26 Aug 2024 16:03:44 +0400
Message-ID: <CAG-pW8HB=jE-g1b5cy1AnwkmzHP_ckw0HtM+r_Lfsu8eOZpzkw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, 
	Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, just replace realtek with mediatek, and indicate that it fixes
https://bugzilla.kernel.org/show_bug.cgi?id=3D219182


Pavel Nikulin
Senior Engineer
+971 52 386 6738
pavel@noa-labs.com



On Fri, Aug 23, 2024 at 1:42=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pavel,
>
> On Thu, Aug 22, 2024 at 5:09=E2=80=AFPM Pavel Nikulin <pavel@noa-labs.com=
> wrote:
> >
> > Oh my, how I missed that.
> >
> > I think a commit can be undone, and the same patch with a correct
> > commit message submitted again. Somebody with access will have to
> > revert it.
>
> I will do that once I rebase for the next pull request, it is just a
> matter of doing s/Realtek/Mediatek?
>
> >
> > Pavel Nikulin
> > Senior Engineer
> > +971 52 386 6738
> > pavel@noa-labs.com
> >
> >
> >
> > On Thu, Aug 22, 2024 at 9:54=E2=80=AFAM Chris Lu (=E9=99=B8=E7=A8=9A=E6=
=B3=93) <Chris.Lu@mediatek.com> wrote:
> > >
> > > Hi Luiz and Pavel,
> > >
> > > I think these is something wrong to the title and content of this
> > > patch. MT7925 is an connectivity IC from Mediatek rather than Realtek=
.
> > >
> > > Although this patch has been accpeted and merged to the next tree, I'=
m
> > > wondering if the typo can still be fixed? I'm afraid that such error
> > > could cause some misunderstanding to users.
> > >
> > > Thanks a lot!
> > >
> > > BRs,
> > > Chris
> > >
> > > On Wed, 2024-08-21 at 15:08 +0400, Pavel Nikulin wrote:
> > > > Add the support ID (0x13d3, 0x3608) to usb_device_id table for
> > > > Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus
> > > > laptops.
> > > >
> > > > The device info from /sys/kernel/debug/usb/devices as below.
> > > >
> > > > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=
=3D480  MxCh=3D 0
> > > > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=
=3D  1
> > > > P:  Vendor=3D13d3 ProdID=3D3608 Rev=3D 1.00
> > > > S:  Manufacturer=3DMediaTek Inc.
> > > > S:  Product=3DWireless_Device
> > > > S:  SerialNumber=3D000000000
> > > > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > > > A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > > > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> > > > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > > I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > > I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > > >
> > > > Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
> > > > ---
> > > >  drivers/bluetooth/btusb.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index bb698ca98..df0d2e4ab 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -627,6 +627,8 @@ static const struct usb_device_id quirks_table[=
]
> > > > =3D {
> > > >       BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > >  { USB_DEVICE(0x13d3, 0x3604), .driver_info =3D BTUSB_MEDIATEK |
> > > >       BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > > +{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
> > > > +     BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > >
> > > >  /* Additional Realtek 8723AE Bluetooth devices */
> > > >  { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
> > >
> > > ************* MEDIATEK Confidentiality Notice ********************
> > > The information contained in this e-mail message (including any
> > > attachments) may be confidential, proprietary, privileged, or otherwi=
se
> > > exempt from disclosure under applicable laws. It is intended to be
> > > conveyed only to the designated recipient(s). Any use, dissemination,
> > > distribution, printing, retaining or copying of this e-mail (includin=
g its
> > > attachments) by unintended recipient(s) is strictly prohibited and ma=
y
> > > be unlawful. If you are not an intended recipient of this e-mail, or =
believe
> > > that you have received this e-mail in error, please notify the sender
> > > immediately (by replying to this e-mail), delete any and all copies o=
f
> > > this e-mail (including any attachments) from your system, and do not
> > > disclose the content of this e-mail to any other person. Thank you!
>
>
>
> --
> Luiz Augusto von Dentz

