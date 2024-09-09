Return-Path: <linux-kernel+bounces-321830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C297200F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CF61C234C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA616F907;
	Mon,  9 Sep 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="UbVtjPoD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62B16DECB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901851; cv=none; b=HAWeKBdJbCMCJ5VInWzmx7TjgQW0p0l00lKQsBy28hUSdWKQk/7fESC8Q70i6DDaTD4a/dvngxCqdYnRr+zW8Okqa2s5PsS0+T5mni9eakLDyDH60t9u0CFjZnce3Q5phRUIoUDUcflwd0juESlQ7DOvpT6staRqg03ilZLgwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901851; c=relaxed/simple;
	bh=dRfrIZS6Njo27yDGcp/CX4lUhpe+PQOLnAbXzE3pqCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fsg50oLaB+Ze4vDhaZiXMqXWyYU1MhgYoLT6csUCvVVzd/CZ1wC8ZbGyJqZNMXxSRVeHu7McbWmippu8evLRQfL2b9aZfzMpNIAoR2C23noMsDmXAMI22MGldmN2WwdX4eNy2qKfhhNLgExWcPqb8q/Sc0cdUDdh9n+u/vW6dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=UbVtjPoD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d3cde1103so297256466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725901848; x=1726506648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OukvZRcUZByAUfm38hAhCqj1SLJokR0fI3NcQUB9xg=;
        b=UbVtjPoD73UllsA90e2GIdrZtRI9WFZY/R1IipLb+vW3e2SXIYEB/6pOJQBYQkbZTP
         EYSD9ZWYzDK946q/rAPj6SXxU0GuqY4VkzpHX0FoVfFLP55lO7psXJg3ewg4J2NJITZT
         yS8C8NlTtBV/nsVlbiD5pnZwcrSRf8/i3YYvGroe4KRbYet1x3ILn6AVvGo4SczeLxIU
         8SaHzdpWOafns2sf2+pMbEx0iOLVFg4TBi5yCbjPrGXIRv34LXvwLfAm2Ljpff6hf22t
         STokcLUAqvu0lVWB+BRHWyXmkXleg335lTEvRti9w8Q+uOwV8/AkCYMVSfP1AeXP5hjl
         wxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901848; x=1726506648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OukvZRcUZByAUfm38hAhCqj1SLJokR0fI3NcQUB9xg=;
        b=uI6vY4yPr9dkDzqqMOsTyEskM2jyVYx3lGa62qcImzURG5tF/j8GmZblIURiwUj/iP
         2cDGr5Uabz6PsIuoExYrbcHQkfbioesvq4VrsGqTLohFMwbJuH/6SKzUnVluCJDq1gpY
         fvawtZtlZl9Ahvd9dgt9iANzO1T/s1n5QrjCIY2x9HggjESR+NG3Lar15mHMefW92E6C
         sHzHnsK594KqQb/+ligfqsZaEfjumHATBkTTvk258dvkUWtk7UdKPzUtDASc+cMFH3YW
         VciBvbeGQrErk90SyzQdYPKzn5N/usM8avkY782fKDY8iOkgzhSpdlVsC9Xy+3AWwVKO
         evlg==
X-Forwarded-Encrypted: i=1; AJvYcCXhK7j3gH7xx2BXjE+O82vZTlhyqYP2iYHrDJhNEkmMpL7hBMZvcU1Nb2WRwWq2qiG3DgUs01bUMqjP3EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNnHKa+t1v8pVoJPyyWEFJMngQuLGbrIlkw1PkXSlifIA0J4i
	Sa3BPuUnK5bAOtbzewygINYcFkosU3yXQMXVCSHfpD5IUzapYV4c9t87hzqIk760BzkE7TU41LA
	JlEM4vYgvKSjpb2U/7PbkihmLodBVHAdpmNoxNA==
X-Google-Smtp-Source: AGHT+IF/4AsAIyAQZgiHx9WUmw49BwTwtOVNEZFc4QOFGTSEQ/1CBo+iochu5lAkAw4d00gWIi2brAodC5mIGAHH+l8=
X-Received: by 2002:a17:907:724c:b0:a8a:8127:4af with SMTP id
 a640c23a62f3a-a8d1c4d739amr1019260566b.39.1725901846987; Mon, 09 Sep 2024
 10:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
 <20240807-fsl_dts_warning-v2-3-89e08c38831a@nxp.com> <CAJ+vNU3ZsJG-eoqf3JcHTyDwjp4uOW1XiEhnOfWZ1FJ-q1Y9Hw@mail.gmail.com>
 <ZtoDviZZQ0/pVGZs@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtoDviZZQ0/pVGZs@lizhi-Precision-Tower-5810>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Sep 2024 10:10:35 -0700
Message-ID: <CAJ+vNU2gabeVrKvDe_e7R4yuNp2Gn94QQTLYptfPRWmy=+hRdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8mm-venice-gw7901: add
 #address(size)-cells for gsc@20
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:17=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Sep 05, 2024 at 11:56:41AM -0700, Tim Harvey wrote:
> > On Wed, Aug 7, 2024 at 7:54=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrot=
e:
> > >
> > > Add #address-cells and #size-cells for gsc@20 to fix below warning:
> > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb: gsc@20: '#add=
ress-cells' is a required propert
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b=
/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > > index 136cb30df03a6..35ae0faa815bc 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > > @@ -364,6 +364,8 @@ gsc: gsc@20 {
> > >                 interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;
> > >                 interrupt-controller;
> > >                 #interrupt-cells =3D <1>;
> > > +               #address-cells =3D <1>;
> > > +               #size-cells =3D <0>;
> > >
> > >                 adc {
> > >                         compatible =3D "gw,gsc-adc";
> > >
> > > --
> > > 2.34.1
> > >
> > >
> >
> > Hi Frank,
> >
> > I just noticed this patch (along with a few others to
> > imx8m*venice*dts* which undoes what was done in commit 3343ab4cc698
> > "arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc dt-schema
> > warnings" which my commit message states: Fix the dt-schema warnings
> > due to #address-cells/#size-cells being unnecessary when there are no
> > children with reg cells.
> >
> > With your patch applied I now see warnings again:
> > $ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make dtbs W=
=3D1
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts:361.14-467.4:
> > Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
> > 0a20000/gsc@20: unnecessary #address-cells/#size-cells without
> > "ranges", "dma-ranges" or child "reg" property
>
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j8 CHECK_DTBS=3Dy f=
reescale/imx8mm-venice-gw7901.dtb
> No warning report at my side.
>
> Did you update your dt schema?
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
>

Frank,

Yes, I've updated my dt-schema with the above command.

So with your patch a make CHECK_DTBS=3Dy produces no warnings but a make W=
=3D1 does:
$ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make
ARCH=3Darm64 CROSS_COMPILE=3Daar
ch64-linux-gnu- -j8 CHECK_DTBS=3Dy freescale/imx8mm-venice-gw7901.dtb
  SYNC    include/config/auto.conf.cmd
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/usr/src/venice/linux-next/Documentation/devicetree/bindings/input/touchscr=
een/ti,tsc2005.yaml:
ti,x-plate-ohms: missing type definit
ion
  DTC_CHK arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
$ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make
ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j8 W=3D1
freescale/imx8mm-venice-gw7901.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts:361.14-467.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property

reverting your patch flips this around:
$ git revert c59339ec2661
$ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make
ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j8 W=3D1
freescale/imx8mm-venice-gw7901.dtb
  UPD     include/config/kernel.release
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
tharvey@tharvey:/usr/src/venice/linux-next$ touch
arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- -j8 CHECK_DTBS=3Dy
freescale/imx8mm-venice-gw7901.dtb
  DTC_CHK arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
/usr/src/venice/linux-next/arch/arm64/boot/dts/freescale/imx8mm-venice-gw79=
01.dtb:
gsc@20: '#address-cells' is a required property
        from schema $id: http://devicetree.org/schemas/mfd/gateworks-gsc.ya=
ml#
/usr/src/venice/linux-next/arch/arm64/boot/dts/freescale/imx8mm-venice-gw79=
01.dtb:
gsc@20: '#size-cells' is a required property
        from schema $id: http://devicetree.org/schemas/mfd/gateworks-gsc.ya=
ml#
tharvey@tharvey:/usr/src/venice/linux-next$ touch
arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- -j8 W=3D1
freescale/imx8mm-venice-gw7901.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb

Maybe the dt experts can tell us what the difference is with
CHECK_DTBS=3Dy vs W=3D1 and which patch is correct between
c59339ec2661 arm64: dts: imx8mm-venice-gw7901: add
#address(size)-cells for gsc@20
3343ab4cc698 arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc
dt-schema warnings

Best Regards,

Tim

