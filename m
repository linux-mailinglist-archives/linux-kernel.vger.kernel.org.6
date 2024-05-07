Return-Path: <linux-kernel+bounces-171668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5D8BE71B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258CB2828A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C95168AEB;
	Tue,  7 May 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsqPFWQ/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D7161313;
	Tue,  7 May 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094766; cv=none; b=u2ouEjI0vpIHItQhSpav5qICHHZ2bDI8ifW5vbMgOmXaqibVQ4mEGjBI/riQpX3sJ5IWfrjbHBK6Kh3nKjm/RKs49DAS5w0txIX4eAIkbVOXAbEyteFs6a509XLIxArlD5KC0M4SWU9lqoXpS4IiEo9qypU3ZIWILRoBRgU00nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094766; c=relaxed/simple;
	bh=AeQpyOACUEH32G+Z9i3H6jfYrCothtxTZY2nD1bb05g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkwvL1Xm/b29Hlq4s0QFih/CkPLnzquJvTPHA7eqlRnYjCmTbMF4XhBUYhZP12dBwsKVrdHCsKCyON8lbrgMfVXPzo231xCkbuStrdJewDw0Puv5HatP8OmkWxRFec4T0iv22h3m8+iiLOfT4qF4Np7cuvR7Q2p1uETgHcwiuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsqPFWQ/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e43c481b53so2424271fa.2;
        Tue, 07 May 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715094763; x=1715699563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0XnUy7N7GmzfhRBhUIrbtF1Olv4xCz/CaIdT4eaN4M=;
        b=RsqPFWQ/h2p0fgtOkqeDpDJLl8keWM3tn/KyqMXZsV2w5Jduue/LZPyJHLJsZc9bW+
         iejdWK7A3ChMGS8HAVrXlcch4jpLhxi7qETTiqTNTbspG7OoMdVnmb+fPJXp0SSPv6Rc
         rzsM4XP3JEr/qaBdsTC4TOD1dJOI8AaQX46KyGMyBWKTO+MOzG/93F8+Vz3ZSO54yo4l
         5TJ9n2b6Pw6drqqk9HqMFT3Z9mdCSWwzrJ53+19lsPIdH8pMnfZV3yNiTn3TWJJe1YNp
         eGzdmo+FUfaxQpNk5CRpy/IEMoXNpM8e0yKtdR5abovJ7hi6PjJN32/iqwrJn7ii0yut
         qcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094763; x=1715699563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0XnUy7N7GmzfhRBhUIrbtF1Olv4xCz/CaIdT4eaN4M=;
        b=WFIKfnuZEzNWo/1B1maSOtWx5KDOv0Yu8d1mYiEUV4yELNQr0wy6KDw+X1h7yXE4dF
         Xf3dOAgwITm3Ik3Axt2A4dTSAHsrDrUVnahZ8fpzQoxKcCv4xpdbNlPjlqDn3XNEYvmh
         E8m/+GtEyEAtqv4oPF5vw33zD2sq4S9Qg43vuNoTCIO5wAiE374HjzxyZmFmg0XmA7GE
         mfLO+KSm0qKZpKjm+FNfJrfCsv1mRIM4ssKALj4DQFOTdgS/yyKIjOPh9BRjBDJsGinB
         yfdvuOLCT/6YHuK7hnT+cGtBQnVx7hno4qqbrrF7KzidX1wNXnpzJykJzZps1REl+wBb
         Kg9g==
X-Forwarded-Encrypted: i=1; AJvYcCXAPwtNahVX+vZnbhc4mWScJHEHFZfwy6yNtDKf7dF615AJjHw+iuP7jTzCTJjGpEQdGtFQIQ2ltiKDro2TByTDpPcd+LQK+rbsYt6EZmppBZezK5yw3yofRpipJIMa6eOc29Xa0BxMDsflKiM4Cv7RstGI1Tou/rF/30UBfZkuJEmG7fgQ
X-Gm-Message-State: AOJu0YyHK4YbH44GtoI4UYfndBt84wlJJTq+7LaVsEYm2Owf3vUKt5yu
	oj98boFfjg/n/YZ5W6vBTcKNvhyiXHSd6+H+M4UTBPKH9q31T7UAXLqJ4o9PyuBUJZTGUZTkmmh
	jM3raXYiiFNUzbGgw6cXPmBQ3xcOte2P94mE=
X-Google-Smtp-Source: AGHT+IGG3otomvjTjqDrNJOeIRme01d0y8iKublirhdl/ykvSpRNO81I30xRl+f0DqUm4Z6jhxb9ZetVuFmB/uInhc4=
X-Received: by 2002:a2e:a9a4:0:b0:2dc:f188:a073 with SMTP id
 x36-20020a2ea9a4000000b002dcf188a073mr11287501ljq.35.1715094762470; Tue, 07
 May 2024 08:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417134237.23888-1-bavishimithil@gmail.com>
 <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org> <CAGzNGR=pvv67UJtNnkDUMhrpnPjNCCYEGeCaM7e_9=4G+Lcfgw@mail.gmail.com>
 <676ce61c-e850-4046-ad0f-e3382be3fe0c@kernel.org> <CAGzNGR=rDrd6LyAC2yB4XUcxn=H1VdY8LQO99NEOBR1sLGGT0Q@mail.gmail.com>
 <3425732a-390b-4c0f-ba1b-2a7e2219d581@kernel.org> <CAGzNGRmF8K7UDDERE_7UQw1EdC=J_jvvXqefU=M0v6FQcsnbhA@mail.gmail.com>
In-Reply-To: <CAGzNGRmF8K7UDDERE_7UQw1EdC=J_jvvXqefU=M0v6FQcsnbhA@mail.gmail.com>
From: Mithil <bavishimithil@gmail.com>
Date: Tue, 7 May 2024 20:42:30 +0530
Message-ID: <CAGzNGRmB5yYyVVDQZ0PaL7k0rie8TQAySwpzDx=QokUAV1NGug@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey, before making a new patch I'll just list the changes that need to
be done according to this discussion.
Change maintainer
Change clocks to only include maxItems: 1
Change clock-names to include
items:
 - const: pdmclk
Use correct address in example
Use flags for interrupt in example

Best regards,
Mithil


On Sun, May 5, 2024 at 5:19=E2=80=AFPM Mithil <bavishimithil@gmail.com> wro=
te:
>
> On Sun, May 5, 2024 at 5:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> >
> > On 05/05/2024 11:59, Mithil wrote:
> > >>>> Missing constraints, so replace it with maxItems: 1
> > >>> Similar to how clock-names are handled?
> > >>>
> > >>>> List the items. I asked to open existing bindings and take a look =
how it
> > >>>> is there. Existing bindings would show you how we code this part.
> > >>>   clock-names:
> > >>>     items:
> > >>>       - const: pdmclk
> > >>>     minItems: 1
> > >>>     maxItems: 1
> > >>> Something like this?
> > >>
> > >> No. Do you see code like this anywhere? Please only list the items,
> > >> although without context impossible to judge.
> > >>
> > > Quick search on sources gave me
> > > Documentation/devicetree/bindings/usb/dwc2.yaml
> >
> > Above code is different - it does not have maxItems, which you want to =
add.
> >
> > > which I used as reference for this prop
> > > clock-names:
> > >   description: Must be "pdmclk"
> >
> > Again, no, please list the items.
> > items:
> >  - const: foo
> Yep that was the old code for reference. Just items (no
> maxItems/minItems as well)
>
> > > compatible =3D "ti,omap4-mcpdm";
> > > reg =3D <0x40132000 0x7f>, /* MPU private access */
> > >         <0x49032000 0x7f>; /* L3 Interconnect */
> > > interrupts =3D <0 112 0x4>;
> > > Not really constants as they do change with platforms (omap4 vs 5 for
> > > example) but
> >
> > That is not really relevant... This is not pi or other math constant.
> >
> > > So do i just make up the constants for it then? Those just seem like
> > > magic numbers.
> >
> > Hm? Did you look around for other SoC nodes? 0 looks like SPI, 4 like
> > LEVEL_HIGH, but it depends on number of meaning of the interrupt cells,
> > so who is parent interrupt controller.
> >
> Ah the irq values, correct, I thought you meant the reg values.
> It should be <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>; not sure about 112 though=
.
>
> I suppose these changes are enough right?
>
> Best regards,
> Mithil

