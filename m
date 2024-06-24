Return-Path: <linux-kernel+bounces-226980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B377B9146A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344501F24426
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A713213E;
	Mon, 24 Jun 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuBvBILw"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BF5380F;
	Mon, 24 Jun 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222389; cv=none; b=nRKm/tnKy+CEpe6hrMteQxc1aXUwuzG/NyucqyLzJpHHJCq3ktlASkNZktz2qfUkIPtbex5uchY++9XZQpE7WVZWpHpp78Oqo/yuFoxUk62abwSTdlf9u5+xawG1g3IBWssDnH04+SQHJamTGR26YtqLvcbou5Xc1aTw68UUbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222389; c=relaxed/simple;
	bh=4mTV9YXrOJ/yZMyGkZfmGhr6QWhkhaOb1pz/rZcvkdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXY6K74Ruoju53UwdZYOmVR3/2mId8XeNZC0Xl4GnS2RPCyUQlLg8j4gJNUszQgtkVJ8edVU8N3FAMWCTahMpD0FmvQ//aX9Sbeg5BNA/pT883NtANZB9Wv7q//v19DNMzPq2IZa+VQVXa9zlf6TaCvjIKUJkAdvztzWvLRzKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuBvBILw; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9794dad09so1914621eaf.3;
        Mon, 24 Jun 2024 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719222385; x=1719827185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbYplUMzhR1IxUvNZWKsrLoE8LHYWjW6BSc/xXyUo+M=;
        b=KuBvBILwvor6zhuJJqb8GGCwZYMonRMoHCdJmVoq+chY3AwpnPkLXOZmn9bBFYtS/X
         apMS/RiDqEyOenG6SPxb1Rw39PLLwy+q5bOdjAKQfdxnYZJyltUWVP8w6dc0oEU2hB5v
         P8xChuMXn4VwNWMenMa5pF3WRGcn0RTcyT5u7iN+A6gApFqa9RXJm66VQN3c0wL11V94
         hPREnZO+/zqeA283+blYvH4ZHwuVL2M0t4fjwDVyChXU6wbszqKY5zZxLMyEc5wjHDj6
         DWLE42YfHY7Xiss5n67ByOuS1elKiss+kblDvCdou7tAwcw4/O7fC2GPtAr92X2kxrkm
         g71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719222385; x=1719827185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbYplUMzhR1IxUvNZWKsrLoE8LHYWjW6BSc/xXyUo+M=;
        b=PaTAMH+LIFIvHj7E8Gzo5UOGAH7twIE15cgBiiB9jZecdLcsExavKIMlc6+gafyHLL
         rCib0xw/gHKss9vMk/oP6TLK8yHnykTIz6fx8AZJESVvvElBzmYHRN6T57kUCulBU/8c
         HHHumSP0ZkTZUWthLwesRj4QCiWCk8XsjL43Gvo+WV6RMf0L4zjJTT8WXr4/dVmkJeur
         xYveK9sE4E1ELKlkzG//w8Wsz9EA0hwJQ8NakjwOicPEM3/yKEhayT6ee80+9qWluYJx
         M54GzZ4bBa8fUudZz+JyfwWWIVWGHF+cEPSgGiNU/3WsSC+B9NRFMlwlCxyhfVwRuxqz
         Bypw==
X-Forwarded-Encrypted: i=1; AJvYcCW5JbicX2lpMlJq2i4cEL+9uigZlyD7rY0BmRPc1HO8OWla5D2HLhtuMBEbVg8wDj2u611hewTdeQj73KQmipPccS21J75Xw6IGpDb8Sr8FDsYIBoVn1d0MmGrRXpJanfnUwTLE1frbFw==
X-Gm-Message-State: AOJu0Yx59aTWJaH7HRDNwqIJoki8t+dzqo+P0No+FY1P0xifQbAlm0io
	sfcOgLPqTGz0XVl87T1luYC6RZmQp4rCkmQ+WDSvCi71bAQ1WTXIef18EFcCXAJg3G3MPlORGpy
	4HqdSfux3IR9/fOx5qIgZONSv5OQ=
X-Google-Smtp-Source: AGHT+IHSR6rbq3FIuKqHp0ot3ROxaxKLl2NcsdfsVuRhutbdT72OR6D67vRm8iSBissHjEm1b03lKoYZIYpEZCpukGY=
X-Received: by 2002:a4a:6c55:0:b0:5bb:672:4067 with SMTP id
 006d021491bc7-5c1e96b6632mr4696719eaf.7.1719222385363; Mon, 24 Jun 2024
 02:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613123020.43500-1-linux.amoon@gmail.com> <20240613123020.43500-2-linux.amoon@gmail.com>
 <dbea269e-2de6-470d-96b7-ce1e07c8de07@linaro.org>
In-Reply-To: <dbea269e-2de6-470d-96b7-ce1e07c8de07@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 24 Jun 2024 15:16:10 +0530
Message-ID: <CANAwSgQroyVKvy8zgTta+-Xgw8B1P-4OVYDxodriXmzn6qzApw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid n2
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Mon, 24 Jun 2024 at 13:45, Neil Armstrong <neil.armstrong@linaro.org> wr=
ote:
>
> Hi,
>
> On 13/06/2024 14:30, Anand Moon wrote:
> > On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
> > switch to used on-board usb hub reset to enable the usb hub
> > and enable power to hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v7:none
> > V6:none
> > V5:none
> > V4:none
> > V3:none
> > V2:none
> > V1:none
> > ---
> >   .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++------=
-
> >   1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/ar=
ch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > index d80dd9a3da31..86eb81112232 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> > @@ -31,6 +31,30 @@ hub_5v: regulator-hub-5v {
> >               enable-active-high;
> >       };
> >
> > +     /* USB hub supports both USB 2.0 and USB 3.0 root hub */
> > +     usb-hub {
> > +             dr_mode =3D "host";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             /* 2.0 hub on port 1 */
> > +             hub_2_0: hub@1 {
> > +                     compatible =3D "usb5e3,610";
> > +                     reg =3D <1>;
> > +                     peer-hub =3D <&hub_3_0>;
> > +                     vdd-supply =3D <&usb_pwr_en>;
> > +             };
> > +
> > +             /* 3.0 hub on port 4 */
> > +             hub_3_0: hub@2 {
> > +                     compatible =3D "usb5e3,620";
> > +                     reg =3D <2>;
> > +                     peer-hub =3D <&hub_2_0>;
> > +                     reset-gpios =3D <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> > +                     vdd-supply =3D <&vcc_5v>;
> > +             };
> > +     };
>
> Why is this nodes under / and not the dwc3 node ????

it's similar to usb-hub-hog, mostly usb-hub is just used to reset the
USB hub controller
and set the power source of the USB hub.

>
> With this current DT, there's no way for the usb controller
> to find those usb devices subnodes in /usb-hub, and it's clearly
> not described like this in the bindings.

USB hub is independent of the dwc2 and dwc3 initialization (phy, usb).

With this patch applied on my odroid-n2plus ,
I could see usb-hub entry in the /proc/device-tree nodes.

alarm@odroid-n2plus:~$ tree  /proc/device-tree/usb-hub/
/proc/device-tree/usb-hub/
=E2=94=9C=E2=94=80=E2=94=80 #address-cells
=E2=94=9C=E2=94=80=E2=94=80 dr_mode
=E2=94=9C=E2=94=80=E2=94=80 hub@1
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 compatible
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 peer-hub
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 phandle
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 reg
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 vdd-supply
=E2=94=9C=E2=94=80=E2=94=80 hub@2
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 compatible
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 name
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 peer-hub
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 phandle
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 reg
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 reset-gpios
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 vdd-supply
=E2=94=9C=E2=94=80=E2=94=80 name
=E2=94=94=E2=94=80=E2=94=80 #size-cells

3 directories, 17 files
alarm@odroid-n2plus:~$

alarm@odroid-n2plus:~$ lsusb -tv
/:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub
        |__ Port 003: Dev 003, If 0, Class=3DMass Storage,
Driver=3Dusb-storage, 480M
            ID 058f:6387 Alcor Micro Corp. Flash Drive
/:  Bus 002.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000=
M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 001: Dev 002, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
        ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
        |__ Port 004: Dev 003, If 0, Class=3DMass Storage,
Driver=3Dusb-storage, 5000M
            ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA 6Gb/s
bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
ASM1153E SATA 6Gb/s bridge

>
> Neil
>

Thanks
-Anand

