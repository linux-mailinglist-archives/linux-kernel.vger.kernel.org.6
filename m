Return-Path: <linux-kernel+bounces-168965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35D8BC04C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA21281B2B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6418E3F;
	Sun,  5 May 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMWe2S5e"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C2566A;
	Sun,  5 May 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714909762; cv=none; b=JTksgPwrz1KbpFt7mR8ADtRrYhAoUk/miJxzr3XVTK9fYOPk5Sc8rPJZgcRkRiFI4gO1Cd1M7j5f6gXHD+CO5XhlHpa6aQ61bneUQb6ehjO6h8FF4sG9FVpFsP7MpYxTxb5T1BShyCQlVrTZL6J+E9P85IOAIC8x5HX6Bv3oFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714909762; c=relaxed/simple;
	bh=nZ9DoDxIAHGkGfKZpRm9W0RNc9mhT7mYOsvGO4dGogw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKaOGDKDnUFy/YqyUbD8ir5XX+VoYJQTcYf/8qboMZoYhxOWzwX1/Cgx3HJ7pQ8xfMpL5R/sTkHWxsAHphrhj7cG1bC+u+ZLa9Kto6Z5QZjcH7X+HxQ0JZFlYrkhc7dnyqAMqrnEx9TGgNiOi+OY5+AAf4BsXJo8/t/TBHa9/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMWe2S5e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f0602bc58so3206168e87.0;
        Sun, 05 May 2024 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714909759; x=1715514559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j91vB77d38iXmPuLzDqrLJwLXMLQrd7oPNcj1a35vlo=;
        b=TMWe2S5eAWed7Pisw/0fXuNrK4RF9gexq5rF0FEn33cI4JQPSv5cdlx13eBpz9cVhR
         cDoOiUAxqhUWFjXKj2Vdfj0wQ1rFG8ILYjwMJlP8knLlFd7URqj7eO4v7rDpPptlZshR
         ogVgWIaVZVDR4Y9racwNSjLUeXKosXjhzN151H8KCmR2SfMgumENJU776yLWTeK0aXaT
         NDXP178Ew5VBdKsJBnMp824ZaMrzpSAZXy6eXlZfCKSj+fLb3iN1rlM0jNjCJVOiljoc
         EoKlEm0dpR2on0LDDO3iLbI/Wg+oiwohOASVkey1VByVJDsdGPXPeHv0LK9NNOsEFhN2
         289g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714909759; x=1715514559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j91vB77d38iXmPuLzDqrLJwLXMLQrd7oPNcj1a35vlo=;
        b=KRO574Z9k2yGzPmGBtvRzXlzb4FQ1ofoliEeti7dNqNhosQR6MC7JL2xGhcDJtqo/5
         Tbm1UmDED1mvs953QHyWf2FVYEkeqSZV4mQ2SLaT7plUVJfap3Es8xluij0FxkoGdUx1
         dg3OZlTePQaAKA8vnj3uwuVG+zRsXPeBWNYchRiuqt6Vxx7sAVwVEFpImGC1AUWKn2fv
         OiQmECeEeupzQ4XQTteCsnaxgUVBbPqE4eG6CMVOiEnqvO6CHS0rhV/x4845UcZIcUfL
         eUpnZtmEKNEVfNgTTs1cmlOen5jWyTKxTOZVIb85Eh2fvuL1AgGsy2E9hPlF2v+cmmzt
         lI+g==
X-Forwarded-Encrypted: i=1; AJvYcCV3Bz2kYYTEYyTnFOa8fP16AlrdUmZAn8/hRBvIDO+PZY9zHP+CIs7PNgE2ZBUs6DF8lamycoA4I9winA1XpIfosCGPnFB8U0mTR4xqYgB1y5ZIXmHNInQ3sqtNheWlIPWM+vake3XYAAytQBbQ7rV1Wg0GVyTF9TdZ6tKgeNNt8EUS8PRv
X-Gm-Message-State: AOJu0YwnCkrFb2IZv6eBo3ERe+Uzjy2Cuv6U11JaMbQSCxdkdcbMUWdM
	zACNDqjQenzXKwgN/5BbIKEFY0/uRKIBwggonTp+lvPu/+oCEmUsVjbtfIhbRBACfvizcKrpUJw
	IWDjicwKPvY62s7KRRXFC6kf0rK1xdcYQQCvLXg==
X-Google-Smtp-Source: AGHT+IHsdpwx3ip29NRHURwclH3Ar8qkby318NuJiCi8aLlLedYRsGKEWTiTF8yVLTEHPsDeXT5s4afAo5891NfAZEc=
X-Received: by 2002:a05:6512:3ba5:b0:51b:a86:ab57 with SMTP id
 g37-20020a0565123ba500b0051b0a86ab57mr3556776lfv.22.1714909758530; Sun, 05
 May 2024 04:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417134237.23888-1-bavishimithil@gmail.com>
 <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org> <CAGzNGR=pvv67UJtNnkDUMhrpnPjNCCYEGeCaM7e_9=4G+Lcfgw@mail.gmail.com>
 <676ce61c-e850-4046-ad0f-e3382be3fe0c@kernel.org> <CAGzNGR=rDrd6LyAC2yB4XUcxn=H1VdY8LQO99NEOBR1sLGGT0Q@mail.gmail.com>
 <3425732a-390b-4c0f-ba1b-2a7e2219d581@kernel.org>
In-Reply-To: <3425732a-390b-4c0f-ba1b-2a7e2219d581@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sun, 5 May 2024 17:19:06 +0530
Message-ID: <CAGzNGRmF8K7UDDERE_7UQw1EdC=J_jvvXqefU=M0v6FQcsnbhA@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 5:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/05/2024 11:59, Mithil wrote:
> >>>> Missing constraints, so replace it with maxItems: 1
> >>> Similar to how clock-names are handled?
> >>>
> >>>> List the items. I asked to open existing bindings and take a look ho=
w it
> >>>> is there. Existing bindings would show you how we code this part.
> >>>   clock-names:
> >>>     items:
> >>>       - const: pdmclk
> >>>     minItems: 1
> >>>     maxItems: 1
> >>> Something like this?
> >>
> >> No. Do you see code like this anywhere? Please only list the items,
> >> although without context impossible to judge.
> >>
> > Quick search on sources gave me
> > Documentation/devicetree/bindings/usb/dwc2.yaml
>
> Above code is different - it does not have maxItems, which you want to ad=
d.
>
> > which I used as reference for this prop
> > clock-names:
> >   description: Must be "pdmclk"
>
> Again, no, please list the items.
> items:
>  - const: foo
Yep that was the old code for reference. Just items (no
maxItems/minItems as well)

> > compatible =3D "ti,omap4-mcpdm";
> > reg =3D <0x40132000 0x7f>, /* MPU private access */
> >         <0x49032000 0x7f>; /* L3 Interconnect */
> > interrupts =3D <0 112 0x4>;
> > Not really constants as they do change with platforms (omap4 vs 5 for
> > example) but
>
> That is not really relevant... This is not pi or other math constant.
>
> > So do i just make up the constants for it then? Those just seem like
> > magic numbers.
>
> Hm? Did you look around for other SoC nodes? 0 looks like SPI, 4 like
> LEVEL_HIGH, but it depends on number of meaning of the interrupt cells,
> so who is parent interrupt controller.
>
Ah the irq values, correct, I thought you meant the reg values.
It should be <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>; not sure about 112 though.

I suppose these changes are enough right?

Best regards,
Mithil

