Return-Path: <linux-kernel+bounces-188093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A88CDD16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F819B2291D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B2128391;
	Thu, 23 May 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="IHMELPK9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C184D25
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505505; cv=none; b=FRS+CCeT6EvSQTXmEC/1Fb3fnzC/qnTbOy0jpXcb+aGP2lup70ySyaSVu6QtUjd5Jp5WXq0AXM6FVNL5d7W1KvV32qUpYvzVXyszUMl9UldRlgDxGeBkzat8eFefhccn2E/UmF8KWOlvDLgx2tAMUBM92xksMTPxQUzEWfSavvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505505; c=relaxed/simple;
	bh=BHiJmgEBa1gvLNWntn5RfkJD/TJ7EaO5QDPUeZlRx5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGjasLI+OADzL6bNgshD4Na9p4eLpb5csaKi1ivTK76bB7eWNRDQCWx+oklve2z88X2hAbPEENQ0A8CdkoOXkV3lUlt+PzGOz4Y6fy0ppF65twYxZmXjyHCSvDUuTVfP792EKruH8IPuYTZIPDSgyrYmSc5CwWuopZr/aqZjIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=IHMELPK9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529614b8c29so309999e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1716505501; x=1717110301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNpjFzKLRaM/fVkxEdNIFaPzfJ+DbE01S4ZDfPlVfB0=;
        b=IHMELPK9/4ypLFW5wg4nTxVkJwgUoOF9GZ3d1ePcF76wn9BLpNyQLuQ1mSqLgro5yv
         9etqbQSF8L8OXkByHr5unmdydnjQ6M+DvS/qyLbNmbGQ5syR4pXWbnnCpckaWVvnKABL
         E1PuJqriFx+SOoTcH4XmCjXuZuTw57oD2A9AtqYqxn4RZqu6dBK0t2xoCZefAkJxv3pm
         NLnNADn6ephbT/Y4STbaa3N19q7bBvFCSVSmWq7niMKV9ur0QLRmjfKU0Ruh2vmFzcf8
         ouatAxFmyS4Eay935ZahhIvtBe6KcLWhRUWREJxJ4TxxBOYwy3c3PgTjRimldIBOsixk
         DQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505501; x=1717110301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNpjFzKLRaM/fVkxEdNIFaPzfJ+DbE01S4ZDfPlVfB0=;
        b=L9pF0hqidYaRy12KPwOTEkilnC1NtuDOUkmXD3Mu3kCzmk912j0sYYIRqpEX0SwICD
         d+JAFv2E57jYOk19/vvApmKLxcgPCE/nCNBl/gw2T9VuKLpxyaYokcQ4JFCi/GRxo+m+
         TrMsHoyCT+5deDgEGkKwEFfW6cqWb3hiTjwGqhJFpiMkmah+JCyhred53yZqR4GnYSmu
         LaCqTNdDCEnie317Z65ZOvrdkigJNiGMi4n/cBtZO4idoqVu+6fdlSxTRUglryicJ1hy
         8SPN90k84IFtxd29F7dR1iwufKRJkI1FZzOlBxQi+uGIt/04Fbm1TLRMcPRlxc7roiN7
         VUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUbYswRIq0pfwc/pGgi8Adk5aC6WopO8hgzeeqxi20bF/Q2wl0EcAdXfEeoi4NZhDVSTXEE5iThz6HrDyXvr+sUK7Sqw1PW7TMZCYzk
X-Gm-Message-State: AOJu0YzbsJtEw8sTYzvN/3vjlkTw0WX6JFM6+aVIn4yUY8jQ5iw7OOtm
	18H6RYpojKcWlQGTmXXeQ329EeGFXLnUQPG0w3EhTynouEadt0nkDcQ6AHQipGg88koZjZHrC7x
	R2sWrYoG3053tQ+ZrCGyXKcstX9sHcvT9FhP0Nw==
X-Google-Smtp-Source: AGHT+IEmckQyii9d5h+3SwFO5raoGBU1nq40RxOH1XcjOxKLm2r5qPhAiY+i55UsHnYaFQnU8ydp+dzH7XdOV3iZv2I=
X-Received: by 2002:a19:7008:0:b0:522:3487:3f3b with SMTP id
 2adb3069b0e04-52966005c1dmr291285e87.36.1716505501582; Thu, 23 May 2024
 16:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org> <20240523-vividly-sequester-d85ac7bccbbd@spud>
In-Reply-To: <20240523-vividly-sequester-d85ac7bccbbd@spud>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 23 May 2024 16:04:50 -0700
Message-ID: <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
> > On 22/05/2024 23:50, Tim Harvey wrote:
> > > The GW7905 was renamed to GW7500 before production release.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documen=
tation/devicetree/bindings/arm/fsl.yaml
> > > index 0027201e19f8..d8bc295079e3 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -920,8 +920,8 @@ properties:
> > >                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> > >                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > >                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> > > +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
> >
> > That's not even equivalent. You 7500 !=3D 75xx.
> >
>
> > >                - gateworks,imx8mm-gw7904
> > > -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
> >
> > Compatibles do not change. It's just a string. Fixed string.
>
> I think there's justification here for removing it, per the commit
> message, the rename happened before the device was available to
> customers.
> Additionally, I think we can give people that upstream things before they=
're
> publicly available a bit of slack, otherwise we're just discouraging
> people from upstreaming early.

Hi Conor,

Thanks for understanding - that's exactly what happened. I'm in the
habit of submitting patches early and often and it's no fun when
something like a silly product name gets changed and breaks all the
hard work.

The board model number is stored in an EEPROM at manufacturing time
and that EEPROM model is used to build a dt name. So instead of GW7905
which would be a one-off custom design it was decided to change the
product to a GW75xx. The difference between GW7500 and GW75xx is
because we subload components on boards between GW7500/GW7501/GW7502
etc but the dt is the same.

If there is resistance to a patch that renames it then I guess I'll
have to submit a patch that removes the obsolete board, then adds back
the same board under a different name. Shall I do that?

Best Regards,

Tim

