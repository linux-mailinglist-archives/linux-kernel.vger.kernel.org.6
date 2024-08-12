Return-Path: <linux-kernel+bounces-283913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9DC94FA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9057A1C22339
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A67E0E8;
	Mon, 12 Aug 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU3aPQjO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B415C12B;
	Mon, 12 Aug 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505410; cv=none; b=ti7kD07+W4NEZI6sPtfgfh4cjYJvX+1dmReA2TCXGPW8g39q6PilklkiceBTW9yolaWgdxMkTuYxOUUBiEfRl7PogGDtCRPdi0TrhShl2mODG/VbBHMzy94IezlurwENz8fQed4oGulxzkGw6PM33nkuUB18SofskMCjQ0eqlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505410; c=relaxed/simple;
	bh=672B6CU1k2ro7YOC70Vs4kawqYnphUTzcq7splC5Tsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGALG9ezEzDCmvYhGpeBcm8yaFI6TRLiSbmJ8pWc10m0tNFY5RF1aRd7SkSEO6aGKEgw7aQoBMhmVRh66jV0AfN0MlBLXeOwRhDsGLcwB8U7bI8EofoTWoy761Ka7uga4jfkfJaTDSKZ1KoARkw1L3ej5yCidjaJolvsBXdHvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU3aPQjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CD8C4AF12;
	Mon, 12 Aug 2024 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723505409;
	bh=672B6CU1k2ro7YOC70Vs4kawqYnphUTzcq7splC5Tsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HU3aPQjOOkicgG3OthDS69DU0GKVZDoT0KMG5fpqs/U/7VRA3pHP8whRotE4Pylr9
	 4lwEHf/U92hfsGi1dLXQTK9BYH8syvEPGz8nRMTVYXfQVZjs7AyOlIkOA72oSOp06A
	 Plr6z5+q0dbjeWJ8Fh/gKqKp5LjZxfFQFadUhBTGyovWFv8zifoNVT5rD1RE9jTXU8
	 cG3Jfzzcmi0Pzik/qj87Oes9ujHrljkkizz4SvOV33qcpXMUS1tp9aYg1541C9KpEV
	 Qk/hSH0m34vSa4YVcH76R1qjEsCZNqw3MawFaHobIXHdw/T/BQl24JuYsWYTJBaAaU
	 /O8LMqD/i0sAw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4201166e87.1;
        Mon, 12 Aug 2024 16:30:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzEz2ctSs/B9pzHwf9CG16Mi9NKbcUHDuW9ZU4lZ/xS2EuF8LAYq539uulYMKB34QFAp/6L0skHT9PZ76rmskpGFRGjka9MjiVrXR1OE1c2TKdobFrh9UBjtKqMTELqyPlt94HLhK2QQ==
X-Gm-Message-State: AOJu0YyM7j5diYK9V398J8Lzs8+GCFLDx57GmIG87zCpqqO8PHtLlGWn
	NGl5j2URV62VIbVDivMVC1InKAOy46+dwoxr8KaqfGD6DzU1vPYsFTLzfuAcbdHsbE37y9V7Ja4
	BWELSE8Q6kK5Fr2l+kFz1E6fM9w==
X-Google-Smtp-Source: AGHT+IGJetH4mJCREH8yIzJpuO64p9nN8xUWb99dU9DwgGP8eM/0/ohkB9aenrPWEZKtOKJgDX4cnQbwfJ5Qo7xg2fA=
X-Received: by 2002:a05:6512:2256:b0:52c:82fa:ef7b with SMTP id
 2adb3069b0e04-5321368420fmr1054927e87.44.1723505407821; Mon, 12 Aug 2024
 16:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808153120.3305203-1-Frank.Li@nxp.com> <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810> <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810> <20240809-freewill-compactor-4f441a4a60bb@spud>
 <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810> <CAL_JsqLzvEpXbTk0XjPuErz2nRaTXX1DP9WG8yshULcVv0bS-Q@mail.gmail.com>
 <ZrpdlNrs/qqFGhFV@lizhi-Precision-Tower-5810>
In-Reply-To: <ZrpdlNrs/qqFGhFV@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Aug 2024 17:29:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8vHeQzMQwU8LcpwEZ9ZqvtTxsMJKNhGpgAHAZpK_FnQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8vHeQzMQwU8LcpwEZ9ZqvtTxsMJKNhGpgAHAZpK_FnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string to fsl,ls2088a-pcie
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:08=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Aug 12, 2024 at 11:29:38AM -0600, Rob Herring wrote:
> > On Fri, Aug 9, 2024 at 11:11=E2=80=AFAM Frank Li <Frank.li@nxp.com> wro=
te:
> > >
> > > On Fri, Aug 09, 2024 at 04:07:25PM +0100, Conor Dooley wrote:
> > > > On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
> > > > > On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> > > > > > On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > > > > > > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > > > > > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > > > > > > The mass production lx2160 rev2 use designware PCIe Contr=
oller. Old Rev1
> > > > > > > > > which use mobivel PCIe controller was not supported. Alth=
ough uboot
> > > > > > > > > fixup can change compatible string fsl,lx2160a-pcie to fs=
l,ls2088a-pcie
> > > > > > > > > since 2019, it is quite confused and should correctly ref=
lect hardware
> > > > > > > > > status in fsl-lx2160a.dtsi.
> > > > > > > >
> > > > > > > > This does not begin to explain why removing the soc-specifi=
c compatible,
> > > > > > > > and instead putting the compatible for another soc is the r=
ight fix.
> > > > > > > > Come up with a new compatible for this device, that perhaps=
 falls back
> > > > > > > > to the ls2088a, but this change doesn't seem right to me.
> > > > > > >
> > > > > > > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exi=
st, which are
> > > > > > > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a=
-pcie.
> > > > > > >
> > > > > > > Previous dtb can work just because uboot dynamtic change fsl,=
lx2160a-pcie
> > > > > > > to fsl,ls2088a-pcie when boot kernel.
> > > > > > >
> > > > > > > fsl,lx2160a-pcie should be removed because Rev1 have not mass=
 productioned.
> > > > > >
> > > > > > Please re-read what I wrote. I said to come up with a new compa=
tible for
> > > > > > this device, not fall back from the existing fsl,lx2160a-pcie t=
o
> > > > > > fsl,ls2088a-pcie.
> > > > >
> > > > > According to my understand, It needn't add new compatible string =
if nothing
> > > > > difference. for example, it use fsl,vf610-i2c for all i2c without=
 add
> > > > > new soc-specific fsl,lx2160-i2c.
> > > >
> > > > No, you should have soc-specific compatibles regardless. Just becau=
se
> > > > you got away with it once, doesn't mean I'm not going to complain a=
bout
> > > > it here!
> > >
> > > Rob:
> > >         What's current policy for this? Not only for this one. If new=
 SOC
> > > appear such as iMX10 (maybe many derived chip i.MX101, i.MX102...), t=
here
> > > are bunch of IPs, Do we need add fsl,imx10* for everyone, which most =
part
> > > is exactly the same as old one and bloat binding doc.
> >
> > Yes, you do. Do you really know that something in the design hasn't
> > changed? Have you compared the RTL between the versions? The only way
> > to deal with quirks without changing the DT everytime is by having
> > specific compatibles *upfront*.
> >
> > The "bloat" is never that much because the IP really always changes.
> > QCom wanted to (and did) use IP version numbers for the same reasons.
> > Guess what, the IP version number changed on almost every SoC.
>
> It is quite dependent on IP itself. Some IP (such as I2C, SPI, UART) is
> quite mature. There are not user visual change in difference SOC. for
> example in drivers/pci/controller/dwc/pci-layerscape.c:
>
> static const struct of_device_id ls_pcie_of_match[] =3D {
>         { .compatible =3D "fsl,ls1012a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls1021a-pcie", .data =3D &ls1021a_drvdata =
},
>         { .compatible =3D "fsl,ls1028a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls1043a-pcie", .data =3D &ls1043a_drvdata =
},
>         { .compatible =3D "fsl,ls1046a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls2080a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls2085a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls2088a-pcie", .data =3D &layerscape_drvda=
ta },
>         { .compatible =3D "fsl,ls1088a-pcie", .data =3D &layerscape_drvda=
ta },
>
> Only 1021 and 1043 have difference, others just copy layerscape_drvdata.
> I met similar case in many other drivers.

My guess is some of these are the same die. I doubt FSL taped out 9
different die.

> Can we consider just add new compatible string only when visualable chang=
e
> happen?

Only if you know all possible errata already. So no. You asked for the
policy and I gave it.

> I am confused that some use old SOC compatible string directly, some add
> new SOC compatible without any actual change.

Because people don't like to use old SoC names with their shiny new
SoC. Or they just don't understand how compatible works. We push back
more on not having a fallback now, but the only thing the DT
maintainers have to go on is the drvdata differences or lack of.


> > The exceptions are really if different SoCs are just different
> > packaging or fusing.
> >
>
> I see.
>
> >
> > In this case, I'm inclined to say just match what u-boot creates, but
> > please make that abundantly clear with a comment in the .dts file and
> > explain the situation in the commit message. OTOH, just adding a new
> > "fsl,lx2160a-dw-pcie" compatible with "fsl,ls2088a-pcie" fallback
> > doesn't hurt, and we can just move on from creating a special case.
>
> It is small problem.
> In https://lore.kernel.org/all/CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqAT=
aJ6mFbk6A@mail.gmail.com/
> There are still small number user use ver1 even NXP not support Rev1.
> According to my best knowledge, rev1 never mass producetion, only few out
> of NXP to do evaluation.

Do those users even care about new kernels? Personally, I'd drop it
and add it back when and if there are complaints.

Rob

