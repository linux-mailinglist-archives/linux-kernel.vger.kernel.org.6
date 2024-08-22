Return-Path: <linux-kernel+bounces-297988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5B95C012
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD353B235FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EC1D0DF5;
	Thu, 22 Aug 2024 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="DD7e43M3"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C861CEACD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360961; cv=none; b=GMFnROVNTf+zl4NT9thSUZPz5OLxhenWz5WFt640hhr17sn/jRqepujQ+1eJyJA2A7ivhmSeKqUJYdCH6yub1kSFDBiD0ManBEnh1Aw2jz8wVNfv5IaSjhrXIkj391M2K7oak5BiDesxKJdxKNUNZHGclg0Q/3ZPOM3CpYUJQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360961; c=relaxed/simple;
	bh=k+W9b7G5rvqcwjRSvf8ADkLS8HeeKeVnAa0LBd1mxuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZGbZ+4f0z4p3W/C+Y7AqOkH9bgZ8dA7wn0JToQ9oRVb2k9fLwthjp6Vm1UQ7TuYNDF3AShuIY4nrpD9J0ktBmwuxqnJiy2FOrYjmu2a5ReASEakCB+4nWWU2d7YBREiJhdrAa1/NJevdnQXbvCxsp2F0sKd5/cNY97lpsOSRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com; spf=pass smtp.mailfrom=noa-labs.com; dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b=DD7e43M3; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noa-labs.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so1294214276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google; t=1724360957; x=1724965757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW07k5i/80VytuCWf6fd5wnrlfOfrcGBGvooRl/kEYs=;
        b=DD7e43M3Xgk1sbrRp0zBAKJYHmSbhy+O1Vdw9BKMIaCmjKyZva3k5aBfmwj2VZym0d
         V6a/oNPcmQfKYQ1GjyRR+ChC7+m3oWFqSBJxkii1qkJAHa4lPHbY0pnmH8x/+1tC2FQw
         YTIinvrR6ZeKsh+TYUiQEOgIzLaNDHQBiKG6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360957; x=1724965757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW07k5i/80VytuCWf6fd5wnrlfOfrcGBGvooRl/kEYs=;
        b=sVnKa5pVBibSy53prmTmKrGGzcLyMIGaW7FgLOQlfmgbjxHxYfLnQVjOZqESrpkOF8
         ZABW/AoqeM2DrQHina5rll+PdrNKlNH+/GZxoh512shfhYp/DtHot4LFa5VGN/tvnM+h
         cE4VC35TeP8hz558JpoRuL3hu1PaCRWYnxH6rMbQSW0nbMaZ4vNhDnHKQbLIH4f6Q4EW
         e247h8F/fWk4X3ClHkqD64+yLzKdJpgkKTPidriTM6aPhPl+4n86Pqul8vSDfeWL9HaW
         18eQIgF1I/TndXWZmsuHlBQl0YopQEN32fFlK7s0MlnRmHQs0ktwdDzmD4h84zs6Tmi/
         LySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDdlOhGB7s47Yw7XP7nSi5nCacCMQL6GIdXnI95uKH3c10XgeVPGcUzYvvH3NH7XHdMBI4GJHk8sx2Ya8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjLnXErJ7aJG3jk3hgJhNvQpTZj60HDgJSPGkrABQBG1fLMhy
	5CvTlca7VzRHkbYmDdCG0hpyoYEPTSr6BNwILLV3dOZvRHSxT1pJhhBlWB9iDvzwl49X/XtyVI2
	Qho590UAx4sj3H9ehgczCJM+7Xe4x9ABCND3IBw==
X-Google-Smtp-Source: AGHT+IHWA6B8BYv2zJOjY+Qab+88faFqm4Nf8qTahVMFYNr1h94/ndxDhjAemM2Gxy9Ys1H/3Ldl8RodsBm+9MRP2rI=
X-Received: by 2002:a05:6902:1896:b0:e13:c10d:85d with SMTP id
 3f1490d57ef6-e17a83bfc22mr320369276.7.1724360957298; Thu, 22 Aug 2024
 14:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821110856.22552-1-pavel@noa-labs.com> <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
In-Reply-To: <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Fri, 23 Aug 2024 01:09:06 +0400
Message-ID: <CAG-pW8EgBE4RwhcFtMXEuFtG56JJSyvOjG5+q71zG6pJyo05hg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, 
	Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh my, how I missed that.

I think a commit can be undone, and the same patch with a correct
commit message submitted again. Somebody with access will have to
revert it.


Pavel Nikulin
Senior Engineer
+971 52 386 6738
pavel@noa-labs.com



On Thu, Aug 22, 2024 at 9:54=E2=80=AFAM Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=
=93) <Chris.Lu@mediatek.com> wrote:
>
> Hi Luiz and Pavel,
>
> I think these is something wrong to the title and content of this
> patch. MT7925 is an connectivity IC from Mediatek rather than Realtek.
>
> Although this patch has been accpeted and merged to the next tree, I'm
> wondering if the typo can still be fixed? I'm afraid that such error
> could cause some misunderstanding to users.
>
> Thanks a lot!
>
> BRs,
> Chris
>
> On Wed, 2024-08-21 at 15:08 +0400, Pavel Nikulin wrote:
> > Add the support ID (0x13d3, 0x3608) to usb_device_id table for
> > Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus
> > laptops.
> >
> > The device info from /sys/kernel/debug/usb/devices as below.
> >
> > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D13d3 ProdID=3D3608 Rev=3D 1.00
> > S:  Manufacturer=3DMediaTek Inc.
> > S:  Product=3DWireless_Device
> > S:  SerialNumber=3D000000000
> > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> >
> > Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
> > ---
> >  drivers/bluetooth/btusb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index bb698ca98..df0d2e4ab 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -627,6 +627,8 @@ static const struct usb_device_id quirks_table[]
> > =3D {
> >       BTUSB_WIDEBAND_SPE
> > ECH },
> >  { USB_DEVICE(0x13d3, 0x3604), .driver_info =3D BTUSB_MEDIATEK |
> >       BTUSB_WIDEBAND_SPE
> > ECH },
> > +{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
> > +     BTUSB_WIDEBAND_SPE
> > ECH },
> >
> >  /* Additional Realtek 8723AE Bluetooth devices */
> >  { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

