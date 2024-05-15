Return-Path: <linux-kernel+bounces-179382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229968C5F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DC31F22AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829F38385;
	Wed, 15 May 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LONrvopU"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0D38F98;
	Wed, 15 May 2024 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744775; cv=none; b=MGSawe8CX/HLe9S+R/ZGfv1Vwjfepq2vZMFSgOa/v/nx4vvCYkU2qN8WDizal/y6qyvCnr1vwDawFBzVUm3jJrRQ+vFI+e1nywnTy8Iab3xtbiEoTp3b16whGDI/OzZGHuZeEZRmzA7M+MbBMIUeOfm+3ktfllNzLo/DaweGGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744775; c=relaxed/simple;
	bh=f0+RAJNpD4xwzDxXJtu5/ftCqWzFGWvy6Jlsa7uUy3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/s9bXNuNdqEUoVrwc7GAiwO4j57Usix0x83YsfvR8cI0eIaMi5uiz1oPyDEnBfBccfD2KHPRCIhExACmZp7fjuDhxSLW58atZxJcUiNJFmvs82+hrVD6HPhKBi5vHtwOH0gRBHWSKmYj4UIOCFQaRMlWpzRYSeO8sDzZmTPins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LONrvopU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36db3304053so4848845ab.2;
        Tue, 14 May 2024 20:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715744772; x=1716349572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK7QXti6gMaWIx9kOf1v+tHDmKiZibD5iL04jzdGCEc=;
        b=LONrvopUYMM3QAm+y/b47vtN7lltEA51qsKpuvU0LY40IwEKd8uE9s4IpECJC/Gype
         6X+mCYqhTLZRHQOP6H5e2lO4KB4wJM5uFVQ+wjvcbIDXR6m0+AjX0ZpVTXKXYUaKQ6vz
         KZqMAHvN7wM45rzx8YJNDPz9KOf48Z4skhHVCOPfmIztQSFpHVaXcFFwVOLlKgQUq0/i
         243Wd515s+zfNTkQcGmNGbdLuuVy9jKzeH7ijT8AZNDdBYUjbP3kBv16fU3MP7VDe9Zt
         tv4PnBIQ80Xg3z12eQBM14DXEByU2V2hKxNgnGA/fDgiuz85ErdrPj7ZePPKUzZOPH5P
         mFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715744772; x=1716349572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK7QXti6gMaWIx9kOf1v+tHDmKiZibD5iL04jzdGCEc=;
        b=q9FMjnqFBAnjMTsfPZ/wiEO+Hsz7fsLBttD84l+3MMEricvOqc6JYELJc7Uy47EpOc
         q5Riyl66lNKSHgaCH5XgqsJbOzeiaf7JMdE2JbRl9QNfPsoi7y/Y95K858+HCtKucIMS
         DZ+ViNq5+Ed1bBdvtiWSWyZXtYs/Pr8RSiWdsaNazqOhgveLh+gdY9wjRuAEsskzwxuU
         Smku2M9HjmjkiSLLuyEmHmKFPz4zhsu0Q2LXy3l/PDKJW0x418qneMyG3H0EOy5K2AFH
         28/yJePXQ8WabAuvD/HZuBnE5Av04UX4TPzUrzfwOjoEv7jIMSDgjiCg5PFZr4VHLXG3
         7lfg==
X-Forwarded-Encrypted: i=1; AJvYcCWn/vI6RCv3NttF+uFjt45pH0QEjwwxRdeMJdVRE7m5DakE3QLm5tfUCbBhYDpayRhcBzxNv0VeKs59McWD0DHPXQMFYui3phJUs5WwVpk74IqS9cLF3FZETpnXkVjEqQG5LllnUYxV/n+qWbv3oN6k6doqdpO/lPVnVlBHHZDp0M78bQ==
X-Gm-Message-State: AOJu0YxC9y3Jrg4GLhDsA5ZJ3tEOrG9lr9X1tRhQpV5p+43vem5hy9Kh
	IHO/dViH/NKzudaF0Y+79l9tgJkL8rhNDcauOf8m19ejg712KhVW1CCGaZ6TlP5vOeXTQw7pC/B
	62ZEUJu7+8b9ivR/5uYNCHU4zUx0=
X-Google-Smtp-Source: AGHT+IGZ+P53lPWGkktNPznbZTqmgsikuFuzx6bUIb82YiQyAOuspBc445HOheK/8XONNLi1B1dXlpKVb5ds0xBfnxE=
X-Received: by 2002:a92:c269:0:b0:36a:f9e8:5e7d with SMTP id
 e9e14a558f8ab-36cc14684f7mr178877585ab.7.1715744771891; Tue, 14 May 2024
 20:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com> <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org> <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
In-Reply-To: <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 15 May 2024 11:46:00 +0800
Message-ID: <CAA+D8AMaEEMk9F4bFYqYNez=XPhtF9VR8F-hcqYp_C2QKFq-4Q@mail.gmail.com>
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

On Wed, May 15, 2024 at 10:47=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail=
com> wrote:
>
> On Wed, May 15, 2024 at 5:09=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomi=
x.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > @@ -15,7 +15,10 @@ description: |
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > +    items:
> > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > +      - const: syscon
> > > > +      - const: simple-mfd
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -44,6 +47,11 @@ properties:
> > > >        ID in its "clocks" phandle cell. See include/dt-bindings/clo=
ck/imx8mp-clock.h
> > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > > >
> > > > +  reset-controller:
> > > > +    type: object
> > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > +    description: The child reset devices of AudioMIX Block Control=
.
> > >
> > > Why not just set #reset-cells =3D <1> in the existing node? IIRC it w=
as
> > > already suggested to you to do that and use auxdev to set up the rese=
t
> > > driver.
> >
> > Yes, do that.
>
> Can I know why sub nodes can't be used? the relationship of parent and
> child devices looks better with sub nodes.
>
> A further question is can I use the reset-ti-syscon? which is a generic r=
eset
> device for SoCs.  with it I don't even need to write a new reset device d=
river.
> it is more simple.
>
The document link is:
https://www.kernel.org/doc/Documentation/devicetree/bindings/reset/ti-sysco=
n-reset.txt

Then example is:
examples:
  # Clock Control Module node:
  - |
    #include <dt-bindings/clock/imx8mp-clock.h>
    #include <dt-bindings/reset/ti-syscon.h>

    clock-controller@30e20000 {
        compatible =3D "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd";
        reg =3D <0x30e20000 0x10000>;
        #clock-cells =3D <1>;
        clocks =3D <&clk IMX8MP_CLK_AUDIO_ROOT>,
                 <&clk IMX8MP_CLK_SAI1>,
                 <&clk IMX8MP_CLK_SAI2>,
                 <&clk IMX8MP_CLK_SAI3>,
                 <&clk IMX8MP_CLK_SAI5>,
                 <&clk IMX8MP_CLK_SAI6>,
                 <&clk IMX8MP_CLK_SAI7>;
        clock-names =3D "ahb",
                      "sai1", "sai2", "sai3",
                      "sai5", "sai6", "sai7";
        power-domains =3D <&pgc_audio>;

        reset-controller {
            compatible =3D "ti,syscon-reset";
            #reset-cells =3D <1>;
            ti,reset-bits =3D <
                0x200 0 0x200 0 0 0 (ASSERT_CLEAR | DEASSERT_SET | STATUS_N=
ONE)
                0x200 1 0x200 1 0 0 (ASSERT_CLEAR | DEASSERT_SET | STATUS_N=
ONE)
            >;
        };
    };

Best regards
Shengjiu Wang

