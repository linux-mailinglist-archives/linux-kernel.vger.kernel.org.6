Return-Path: <linux-kernel+bounces-179360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B48C5F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC001C218DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE7374CC;
	Wed, 15 May 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqwutLph"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2012381A4;
	Wed, 15 May 2024 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741292; cv=none; b=smnh+LYoXmn1wC4EMRrTa4SWb9dEHVqIW+NVi//epqomQAd9qTgQ0lbjkSPvLaQGw25XWxUE9qgS0RvkVXvNIwqb56FI+47r+2ltOB8rtKAI5JbJezw4BAPM7pB45saQ47zdrzDX90ZKtvP4U8iMdmTXJOEU8U2bqKenpSO4ow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741292; c=relaxed/simple;
	bh=Zm/aWD0cPpxYKvZkG11YI0/Q+FB2yEFE0LiK+B1PVHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfrWOUAq9K6rjX9jxMlkWdLv7ycRJJJpe/9AsCrtzaQkM2mzVJ+P5blcxT14hLOGIKVitbTP2BuOs+exS5/mJh1Pebu5SV4iDXr6GI/dsSAKEaxLT14J/kXlz84gn5XIg5QI8GE9eR0objk8Ut2uebGe3mNV7Di/PFGI1ml/kW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqwutLph; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36da84df7adso6805995ab.1;
        Tue, 14 May 2024 19:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715741289; x=1716346089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIDhweI0h5UXcyTSp+TP3eWf/lMbo5o/HSpNa1VAcs0=;
        b=KqwutLphAbdHAKqhlyCzS7G7eP4R0z7BFsSyzy2sI8+Ueu6WfjqH30E7dQWuJ3DpNY
         BOwYmjVA34E6YMJks2kPxaZk4Bupd6wIYIdDXeLhTVhyNPCDDC4OfBZ2tKVJJ2qyqu2M
         4z/dpMqQ6o8AZZ2JVqTqmYoEZDv0LQV0TxT6ayN9tqqr+r+8eRZLNDnPV5PTalxF+yvi
         GmLLMQLV/H/euaJW584v7Cuc2HbvzMuJLuY9zVjOQzLQ9Iq/WoU3ziDkJCkzbiIF3IJ3
         9zy1F8xEoYN/sV+eO5N2YOvtGBhENRnii+uWb6nXxaVfZwiJYQzwN/50ZMNM6F+VioPe
         SvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715741289; x=1716346089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIDhweI0h5UXcyTSp+TP3eWf/lMbo5o/HSpNa1VAcs0=;
        b=ZP3vh7EHSToWMmlTKE0WeuT28Hn3UoJ3SR2gjysGRHL4xlz9xNaknpvxSVs98d6V1L
         JjEVzD0qXN9zitu8eZoNboPLmoBVQR46+r/dTHxurnd/1+m1rgvCrrXu0v/03ZAnxZhF
         Dw3x8Pcmj/iCSx3SgnvrOt8FPD841mNAACopZGR0699SW0yoY1arcnsfBNx9gjF9mXS1
         zzNFaW/yq+E83zqqsV4tquT5ahgLwPyW8QG1NPgpeQTdBEA05qZI1gvn1IIuUK3WhFTw
         mTWgaLf+sxBxDr31JHzc3C/rvFQZ3GLYuV+e+vTUWiufudbnvuZ47EML0vflbmtf7Gag
         FZRg==
X-Forwarded-Encrypted: i=1; AJvYcCW98HaLEwTcaQ4cSVkQhoRDYHz/zRP4H2oPWWkpdmDE0pbaTMYqhOvw9p8RosJcVy1BqA2hd+XqmkjLBxPj6AGvzdvuQSEsRkiMKDyjfvEITsiywMlNTd90GG4/NUmpeERXBP/AppU4gAtZUGdLi2Hfu6j8+snbb5XEMqaspqDHWSD2vw==
X-Gm-Message-State: AOJu0YyCW3bGnhVT/SnRfGJ/QhmzF21pktduzUuNS0DvLaxUA3nrHZ2/
	M5JfTy/w+pbeeB5LCX3PZeDj21M6QRuLRP0RtOd7XqMW4s7XynY5aR70Lcjgp0hkbIJOlfNWwKD
	s51IsRU8/2e5k5KMn+lKb8p6ZbeI=
X-Google-Smtp-Source: AGHT+IHzVUc9KZPaSMitplhr5eOK7tggKIv03qnC7VHPuAL+ASkz3/IadH5Ux+z2PF/krzlmkYV1zomwI11/ywZHr4g=
X-Received: by 2002:a05:6e02:17c5:b0:368:920b:e211 with SMTP id
 e9e14a558f8ab-36cc12a36a3mr120484205ab.5.1715741288898; Tue, 14 May 2024
 19:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com> <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
In-Reply-To: <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 15 May 2024 10:47:57 +0800
Message-ID: <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller sub-node
To: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:09=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Conor Dooley (2024-05-14 11:06:14)
> > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.=
yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > @@ -15,7 +15,10 @@ description: |
> > >
> > >  properties:
> > >    compatible:
> > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > +    items:
> > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > +      - const: syscon
> > > +      - const: simple-mfd
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -44,6 +47,11 @@ properties:
> > >        ID in its "clocks" phandle cell. See include/dt-bindings/clock=
/imx8mp-clock.h
> > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > >
> > > +  reset-controller:
> > > +    type: object
> > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > +    description: The child reset devices of AudioMIX Block Control.
> >
> > Why not just set #reset-cells =3D <1> in the existing node? IIRC it was
> > already suggested to you to do that and use auxdev to set up the reset
> > driver.
>
> Yes, do that.

Can I know why sub nodes can't be used? the relationship of parent and
child devices looks better with sub nodes.

A further question is can I use the reset-ti-syscon? which is a generic res=
et
device for SoCs.  with it I don't even need to write a new reset device dri=
ver.
it is more simple.

Best regards
Shengjiu Wang

