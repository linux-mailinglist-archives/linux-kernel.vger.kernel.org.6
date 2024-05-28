Return-Path: <linux-kernel+bounces-192747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345358D218F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5078D1C22825
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F3172BC2;
	Tue, 28 May 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="ki6R0mGC"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E8172BA9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913406; cv=none; b=AduOYSij6b652e0pxpbHP5qx7GNtAlDIyjWY5wSwNOFGjqdONaRZgX5+Us6zJ6oWjAk9hldPXAupCiaNiwpzrdWdhRnvZ4iwLzlYNtGH1JTDkdXbNGoA1n8Dvize28nELVC34HEiMcuutN8PQ+CPzakVSkFCT+tTTDbQHCb2W5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913406; c=relaxed/simple;
	bh=YrRYmM2iOnvVpCpxFTLguETPlid9A8LGNFldLjX9+z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBxbmEFvxXI3PpdPOyzLVdUpN6uaCoA83QDYosPB0rdievtDXsj6dpBhQTDubxA7voFiwFPvzsnVWcoG61ypR7O/6EYKqeE749eGxm8PjrVrfHrHvOOAle45ZRBcfsFp++iKl2/nGs5RVV/QMCQFFu13po0d7hUxtsXE26Rpo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=ki6R0mGC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so138967266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1716913402; x=1717518202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Icz1iULGDWOGvffjSkBVlf/NabTBEP831PPUjJFQD5c=;
        b=ki6R0mGCpzlgkskgMcxMyyYBewY38KUSVCQFXnaF+KNvdW6D5YO0djHruN2386km5p
         DmCDYVzcOdGEM/bEqy/zoDahwiT/A6JZ5LSvo+8fF7wJdN05aLNjVN02+ezhIeoeQsg4
         QC/1KJjV8NSyozJDm1M4Pz5j4MdIOLys0ZU0tLwvpE2aNTLrjg/2krW5q2/TH66NbZ9X
         JCaYLfIbl/XpWTIUiRvcIXe/sKfKUtn2I0ZqGD6oBhElCMDGP3zZHz6flRuPP4X2ZMIS
         w3tWFGv7QE0/eNKL2daVsPHKinqxC9ZPetprnYU8Ni/THvxWoqPET4p+Vz9+u6LqoSEO
         fBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913402; x=1717518202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Icz1iULGDWOGvffjSkBVlf/NabTBEP831PPUjJFQD5c=;
        b=sMwWbP+YZcOGbYQWhVIcOwlOe6QrexYCVb+KQibnmZXAhodiiXqi8LWEyvI0gUgTwy
         Y1RL1BTTaw2kp3zKDbYvKlsNmT7yS98/U8pefGIvHD5pQTOU5NaUtAQXnTjxcSKFbFnq
         4FqKtD/w7ODnkgS9oMJyIvDN1A50Pg6c9NpoXQNciHZcb39hskmgXH3lhOlw6vkE/MjP
         LLLAF7Pv/S5TLnH0E0clwEVqou5rJ9ibsZqztKYY6lEp6xpAKAFGvRzIPmvo1ghzpgYH
         aqfWr3wJq9p5jFntC1SDzXuVX2PN23KYR+ZSz9C3woZSyst+720uc5YiVyDXhkdsk26c
         DZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWekf2qzTWK580iC3rCbSSabvPRg5gu/i3YUtGTTmu/PtbtR36YMESA/HFrl7Aa4p/TD+IWWaG9BAJGWC+3Pc3jA+w/mcVK8dXXQGJp
X-Gm-Message-State: AOJu0YzpVglrWS4uUw7y8e1HfrOsKE+INFKt187ZyjvdD7mOwQNghJiv
	YG7ZsSPSUEdv0G+Mv4FkWNYtOK7smEZZlTE2uF/HzS39iT4gtsrTP09rDL8ULGOX1CfyP25Vw7m
	iHW7hvw0qxFQC78Wx2duSLh/xuAd+BT9gZWkSiw==
X-Google-Smtp-Source: AGHT+IGfhHltMh6uxJiYUYZJIY3arEfGHNZl4L3jMAUX5mkMEtSLMBjHdCH6foV8SIu5pyn4zoFHWz0SJWajG0Ovtns=
X-Received: by 2002:a17:906:413:b0:a63:4e95:5639 with SMTP id
 a640c23a62f3a-a634e95579dmr120722966b.47.1716913402114; Tue, 28 May 2024
 09:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org> <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
 <20240524-cavalier-outthink-51805f49c8fb@spud> <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
 <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com> <20240528155808.GA695520-robh@kernel.org>
In-Reply-To: <20240528155808.GA695520-robh@kernel.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 28 May 2024 09:23:10 -0700
Message-ID: <CAJ+vNU225kyG7+AmXU8MTDArj8_6ibD-DkogXg89YpWS57ai=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:58=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sat, May 25, 2024 at 12:58:18PM -0700, Tim Harvey wrote:
> > On Sat, May 25, 2024 at 11:34=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 24/05/2024 20:40, Conor Dooley wrote:
> > > > On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> > > >> On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@kernel=
org> wrote:
> > > >>>
> > > >>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wro=
te:
> > > >>>> On 22/05/2024 23:50, Tim Harvey wrote:
> > > >>>>> The GW7905 was renamed to GW7500 before production release.
> > > >>>>>
> > > >>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > >>>>> ---
> > > >>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/D=
ocumentation/devicetree/bindings/arm/fsl.yaml
> > > >>>>> index 0027201e19f8..d8bc295079e3 100644
> > > >>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > >>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > >>>>> @@ -920,8 +920,8 @@ properties:
> > > >>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK B=
oard
> > > >>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > > >>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> > > >>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks=
 Board
> > > >>>>
> > > >>>> That's not even equivalent. You 7500 !=3D 75xx.
> > > >>>>
> > > >>>
> > > >>>>>                - gateworks,imx8mm-gw7904
> > > >>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks=
 Board
> > > >>>>
> > > >>>> Compatibles do not change. It's just a string. Fixed string.
> > > >>>
> > > >>> I think there's justification here for removing it, per the commi=
t
> > > >>> message, the rename happened before the device was available to
> > > >>> customers.
> > > >>> Additionally, I think we can give people that upstream things bef=
ore they're
> > > >>> publicly available a bit of slack, otherwise we're just discourag=
ing
> > > >>> people from upstreaming early.
> > > >>
> > > >> Hi Conor,
> > > >>
> > > >> Thanks for understanding - that's exactly what happened. I'm in th=
e
> > > >> habit of submitting patches early and often and it's no fun when
> > > >> something like a silly product name gets changed and breaks all th=
e
> > > >> hard work.
> > > >>
> > > >> The board model number is stored in an EEPROM at manufacturing tim=
e
> > > >> and that EEPROM model is used to build a dt name. So instead of GW=
7905
> > > >> which would be a one-off custom design it was decided to change th=
e
> > > >> product to a GW75xx. The difference between GW7500 and GW75xx is
> > > >> because we subload components on boards between GW7500/GW7501/GW75=
02
> > > >> etc but the dt is the same.
> > > >>
> > > >> If there is resistance to a patch that renames it then I guess I'l=
l
> > > >> have to submit a patch that removes the obsolete board, then adds =
back
> > > >> the same board under a different name. Shall I do that?
> > > >
> > > > I think this patch is fine - other than the inconsistency that Krzy=
sztof
> > > > pointed out between the "renamed to gw7500" and the "gw75xx" in the=
 new
> > > > compatible.
> > >
> > > I am not a fan of renaming compatibles because of marketing change,
> > > because compatible does not have to reflect the marketing name, but
> > > there was already precedent from Qualcomm which I did not nak, so fin=
e
> > > here as well. Double wildcard 75xx is however a bit worrying.
> > >
> >
> > Hi Krzysztof,
> >
> > Thanks for understanding. The double-wildcard is again a marketing
> > tool. All GW75** use the same device-tree by design. The boot firmware
> > that chooses the device-tree understands this and for a GW7521 for
> > example would look for gw7521 first, gw752x next, gw75xx last.
>
> You haven't documented the other 2 though.
>
> How do "all GW75** use the same device-tree", but then there are 3
> possible DTs for just 1 board?
>
> Selecting a DT is not a unique problem. We don't need unique
> solutions. There's the QCom board-id proposal[1] and OS provided DT[2]
> which are addressing similar issues.
>

Hi Rob,

I'm not sure those links are really able to address all needs. I see
some similarity with the concept of a board-id taking the place of the
don't-cares used in our names but not the concept of marrying a
baseboard to a SOM with the two different boards creating a named
combination (both which may have some don't cares). The Gateworks
Venice product family of boards (imx8m{m,n,p}-gw7***-*x) boards have
been in the kernel for quite some time now as has been the U-Boot code
that determines the device tree using a baseboard model number
combined with a SOM model number.

A baseboard with an model of GW7301 (programmed into an EERPOM at mfg
time) gets coupled with a SOM with the model of GW7000 and this uses a
device-tree of gw73xx-0x (prepended by the SoC name of imx8mm, imx8mn,
imx8mp). The don't care's here and the naming convention has been
chosen by us, the board manufacturer, leaving enough significant
digits for component subloads that was desired at the time. So a
GW7300 and a GW7301 are the same schematic, they just have some
different loading options.

I really don't understand the issue here. A board was originally named
gw7905 when I brought up the prototype in the lab and created its
device-tree but between then and when it shipped it got moved to the
more generic 'family' of gw75xx baseboards which get coupled with a
SOM. I already have a gw71xx, gw72xx, gw73xx out there for years that
function this way.

Device trees describe hardware using a name... the name changed :(

Quite simply there are no boards out there with a GW7905 in the EEPROM
that need to be supported... they all have a GW7500 programmed in them
(and some may in the future have a GW7501, GW7502, etc).

Is the problem here the fact that I use don't-cares in the names or
the fact that a name changed?

Best Regards,

Tim

> Rob
>
> [1] https://lore.kernel.org/all/20240521-board-ids-v3-0-e6c71d05f4d2@quic=
inc.com/
> [2] https://lists.linaro.org/archives/list/boot-architecture@lists.linaro=
org/thread/DZCZSOCRH5BN7YOXEL2OQKSDIY7DCW2M/

