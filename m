Return-Path: <linux-kernel+bounces-196949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950228D6416
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B361C1C2485A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0623169380;
	Fri, 31 May 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhYt6pW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5915CD55;
	Fri, 31 May 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164669; cv=none; b=bJ/nnVHx80gv9D/ufhhtUxYDamuhbjtt3NMo0uaT904s6DB5peoyjE8RvnQf9JdXUtjsBtok11I7u1nXnXWCrmn3m8qmJa2VGcgCoqFJ+QXwZbFVSUzyjPz2Nq4MtzX+yQ5LEEx0bJG0RdHmquBeWxvzkZT9YqTIrW0Hw3pYdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164669; c=relaxed/simple;
	bh=K0xHXy2q6dRipVm0n2lXko/1zCuNtyjfzp6U4rJzUsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuItlUwzSXPLJfCNVUQO2pjQYi2qO4ge/4AWTsttwo5N0+f72vtZ7+zQaETVlspldD30rWQL1fipXXCLT/gw2s69GzdPq3/vXZRGuGeqoaI1NUm2IX8C3TsoS49spFYIOgJgi8FBoGUjoI7jrdOlU0mVevGT2a+2JhiUwuwTgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhYt6pW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C2BC4AF07;
	Fri, 31 May 2024 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164668;
	bh=K0xHXy2q6dRipVm0n2lXko/1zCuNtyjfzp6U4rJzUsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NhYt6pW3uY9U9PBXpWSMlo2mGQ16YCmvOUpue6pN0+vxmgGJUU6gzYL5LxzEIaTbZ
	 yAPUPn7K88Ap2LMYhzkWUcx5JgSrEtjSixnkfRWhdj9FeKG5raD0XPjNcw8sbc5xOU
	 EjliB0BVuJJwx47diirD3dELRQ8+N07kv/VkWvr9JwMPal/L2bbM7afkW/BzxOimjS
	 +KqR2tXbYB0XJNEianyOIlPZfYQvGLiecap5PpRre83ZZKg8KNXatnAoDJ9e7opxgG
	 fAZsrrDZTKmRpanIil+zt0nu38ltY0YwfWNNutu96U4OCTyN232Y45FvuntArnJ0Ig
	 V4iJ92tkImc7A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b7e693b8aso1707525e87.1;
        Fri, 31 May 2024 07:11:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzmeIzXMKJ9N2r7cbo/R4q/TU1VBg6hMbxHitVZq1tWuqa0/BMb3nmMFQkjcUP5AEA534g4DjPW+klZmCS5p4v5eGrlhqg83zbr83GtHOWOIyVo+UW6Sn1WWm3VPxyVQvtZKlp8K8lXA==
X-Gm-Message-State: AOJu0Yxni9yRkYHyHt+fncTpCoN1AQVr/gEL8UNPympFKQ2woqzK13qr
	jChYJtNCgXh+xcSYImohIM+E6z4tqjdQm8o0bVuqGBCgEikDxy89+jXQtskeLefZTjTqqGKkVtL
	9+ahrNtgUKSj4tgYcZR4hwO/MRQ==
X-Google-Smtp-Source: AGHT+IHIqTs4eLz3G6haHEggOKQpNgNQdSLxmxdJSf8+V2cY32GWNGtHxyT5Oq/VVbYGkZbVocajtPazQcGxy+rb6oE=
X-Received: by 2002:a05:6512:61:b0:529:5644:c1a4 with SMTP id
 2adb3069b0e04-52b7e10bc05mr1544861e87.20.1717164667003; Fri, 31 May 2024
 07:11:07 -0700 (PDT)
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
 <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com>
 <20240528155808.GA695520-robh@kernel.org> <CAJ+vNU225kyG7+AmXU8MTDArj8_6ibD-DkogXg89YpWS57ai=g@mail.gmail.com>
 <20240530-powwow-outpour-ca48b1f22a3e@spud> <CAJ+vNU1Vu9oM1W8RhBo1H+ddHUovmJGSPhmmW0aaTEfYgVoerQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU1Vu9oM1W8RhBo1H+ddHUovmJGSPhmmW0aaTEfYgVoerQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 May 2024 09:10:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHs_cBJWrS6+tzoUZ5fESAsim2uasHmFRg1CT7BOjDWQ@mail.gmail.com>
Message-ID: <CAL_JsqKHs_cBJWrS6+tzoUZ5fESAsim2uasHmFRg1CT7BOjDWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Tim Harvey <tharvey@gateworks.com>
Cc: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:36=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Thu, May 30, 2024 at 9:54=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, May 28, 2024 at 09:23:10AM -0700, Tim Harvey wrote:
> > > On Tue, May 28, 2024 at 8:58=E2=80=AFAM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > On Sat, May 25, 2024 at 12:58:18PM -0700, Tim Harvey wrote:
> > > > > On Sat, May 25, 2024 at 11:34=E2=80=AFAM Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > >
> > > > > > On 24/05/2024 20:40, Conor Dooley wrote:
> > > > > > > On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> > > > > > >> On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@=
kernel.org> wrote:
> > > > > > >>>
> > > > > > >>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlows=
ki wrote:
> > > > > > >>>> On 22/05/2024 23:50, Tim Harvey wrote:
> > > > > > >>>>> The GW7905 was renamed to GW7500 before production releas=
e.
> > > > > > >>>>>
> > > > > > >>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > >>>>> ---
> > > > > > >>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > > > > > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >>>>>
> > > > > > >>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.ya=
ml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > >>>>> index 0027201e19f8..d8bc295079e3 100644
> > > > > > >>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > >>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > >>>>> @@ -920,8 +920,8 @@ properties:
> > > > > > >>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4=
 EVK Board
> > > > > > >>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK =
Board
> > > > > > >>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB=
 Board
> > > > > > >>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gat=
eworks Board
> > > > > > >>>>
> > > > > > >>>> That's not even equivalent. You 7500 !=3D 75xx.
> > > > > > >>>>
> > > > > > >>>
> > > > > > >>>>>                - gateworks,imx8mm-gw7904
> > > > > > >>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gat=
eworks Board
> > > > > > >>>>
> > > > > > >>>> Compatibles do not change. It's just a string. Fixed strin=
g.
> > > > > > >>>
> > > > > > >>> I think there's justification here for removing it, per the=
 commit
> > > > > > >>> message, the rename happened before the device was availabl=
e to
> > > > > > >>> customers.
> > > > > > >>> Additionally, I think we can give people that upstream thin=
gs before they're
> > > > > > >>> publicly available a bit of slack, otherwise we're just dis=
couraging
> > > > > > >>> people from upstreaming early.
> > > > > > >>
> > > > > > >> Hi Conor,
> > > > > > >>
> > > > > > >> Thanks for understanding - that's exactly what happened. I'm=
 in the
> > > > > > >> habit of submitting patches early and often and it's no fun =
when
> > > > > > >> something like a silly product name gets changed and breaks =
all the
> > > > > > >> hard work.
> > > > > > >>
> > > > > > >> The board model number is stored in an EEPROM at manufacturi=
ng time
> > > > > > >> and that EEPROM model is used to build a dt name. So instead=
 of GW7905
> > > > > > >> which would be a one-off custom design it was decided to cha=
nge the
> > > > > > >> product to a GW75xx. The difference between GW7500 and GW75x=
x is
> > > > > > >> because we subload components on boards between GW7500/GW750=
1/GW7502
> > > > > > >> etc but the dt is the same.
> > > > > > >>
> > > > > > >> If there is resistance to a patch that renames it then I gue=
ss I'll
> > > > > > >> have to submit a patch that removes the obsolete board, then=
 adds back
> > > > > > >> the same board under a different name. Shall I do that?
> > > > > > >
> > > > > > > I think this patch is fine - other than the inconsistency tha=
t Krzysztof
> > > > > > > pointed out between the "renamed to gw7500" and the "gw75xx" =
in the new
> > > > > > > compatible.
> > > > > >
> > > > > > I am not a fan of renaming compatibles because of marketing cha=
nge,
> > > > > > because compatible does not have to reflect the marketing name,=
 but
> > > > > > there was already precedent from Qualcomm which I did not nak, =
so fine
> > > > > > here as well. Double wildcard 75xx is however a bit worrying.
> > > > > >
> > > > >
> > > > > Hi Krzysztof,
> > > > >
> > > > > Thanks for understanding. The double-wildcard is again a marketin=
g
> > > > > tool. All GW75** use the same device-tree by design. The boot fir=
mware
> > > > > that chooses the device-tree understands this and for a GW7521 fo=
r
> > > > > example would look for gw7521 first, gw752x next, gw75xx last.
> >
> > When it is doing this matching, does it actually apply a wildcard, or
> > does it look for "x"? IOW, if your eeprom said "gw7521" and there were
> > no devicetrees matching "gw7521" but there was one with "gw7500" would
> > it match?
>
> I attempt to explain the algorithm used in the comment of the U-Boot
> code used by U-Boot to both choose the DTB it uses as well as the
> bootscript to choose the DTB used for Linux when booting Linux:
> https://elixir.bootlin.com/u-boot/latest/source/board/gateworks/venice/ee=
prom.c#L164
>
> Consider a GW7001-F.1 SOM married to a GW7201-G.2 Baseboard (the
> letter at len-2 is the PCB revision and the number is a BOM revision
> and those are the full model strings in the EEPROM's of the boards):
> fdt_file1=3Dimx8mm-venice-gw72xx-0x-g2f1.dtb
> fdt_file2=3Dimx8mm-venice-gw72xx-0x-g2f.dtb
> fdt_file3=3Dimx8mm-venice-gw72xx-0x-gf.dtb
> fdt_file4=3Dimx8mm-venice-gw72xx-0x.dtb

These all have the same root compatible I'm guessing? Based on recent
discussions around firmware picking a DTB, we really want that based
on compatibles, not filenames. After all, compatible is all about most
specific to least specific matching. Maybe it doesn't matter for your
products. However, that's likely the direction we're going and it may
make your life easier to align with that.

> The script that loads the fdt for booting Linux looks for fdt_file1
> first, then fdt_file2, etc etc so that if needed a 'more specific' dtb
> could exist with base-board and som-revision fixups. However to answer
> your question the algorithm already assumes that baseboards have 2
> digits worth of don't care and match specifically an 'x' for that.
> Including the SOM and Baseboard PCB revision and BOM revision was a
> safeguard that has never been needed so in practice we always just end
> up with the last most generic dtb above which is the case of
> 'imx8mm-venice-gw72xx-0x.dtb' case means a 'gw72xx' baseboard married
> to a 'gw700x' SOM. The 'gw70' is removed from the dtb name as all
> Venice SOM's start are GW70**.
>
> So in my mind the dt for the baseboard above is called
> 'imx8mm-venice-gw72xx' where 'xx' is part of the name but does have
> implied meaning. It certainly helps our customers know that the last
> two digits of a baseboard are don't-cares.
>
> This is nothing new... I did this for the imx6 based Gateworks Ventana
> boards as well most of which have been upstream since Linux 4.x:

Based on this, I'm going to say what you have is fine and let's move on.

We'll all probably forget this and you'll have to remind us the next
time we see wildcards.

Rob

