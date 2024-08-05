Return-Path: <linux-kernel+bounces-274508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73857947917
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FA1F221B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262381547C5;
	Mon,  5 Aug 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4yJhM4u"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2C54658
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852591; cv=none; b=NN68lzVxNrot64XDzovrn19iQscy5sdMGsk66HUpOEcY+meZlW6/YpvTbtowd5VtCNcfcek2e28UrMlgF8dghE/L1/rArUNKTEE/NTnx6TN5oukHPbO8UKfo+nV+gGUbUoTcXmM/w1HALZoy6PV3nR0inOZHJi9OsjQ1CUSYzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852591; c=relaxed/simple;
	bh=+K9hSpGtE/3iLHQcSO8dUwYSy1HxcajpYURwgaK4bfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuDcBEYwT8HmXPnd4p1wrqk7AXJIzkLyChL23Iu+C01nuSrTTmvUnJdmq98TQ7yiFr0Ou0XQz2ov56rolJHtMqJ+J93jpqAwuOUNeIwPSljpb9AKYDdurEUoBKEY/zRq9ccMssomjadw1WRoA6tekJ3U9w6wHOyTe5mao8FtR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4yJhM4u; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-67682149265so83330527b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852588; x=1723457388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PndH4jnAZ185cGSKb8aNel1LJ2ETeEsYl8hD1+owehA=;
        b=d4yJhM4uaAAOBaRyU5bMwBHuHP9Ntd3SOpgRm0Ub4Zn1xSBmB9s2FU9H+S+H+xllew
         cI6gMbWdrg5TTrUNbXwI3y3HcWzh4msDIEmYLVp/4tXEBsVIAaVpCEprm8jXa/yoX3FB
         h//MgtmeQkzayhoZA6NsGwgBU+uzG7A0g3Lu6aPxe0ZE+Yw+CupccWLlUeUgAIEpocSa
         vKpXapd0i8UyaVJxV6Zu2XsFOn4VD9PrS2QJ3zJvf8W8avev9Jh8cnK2dR/uM7uHYEZi
         y2ita2wjeEQx1A7ykRlK30fZ+xwJYcwHh6KGgorMhLz55KPoiveqFKmtJxJepisHn38y
         Qbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852588; x=1723457388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PndH4jnAZ185cGSKb8aNel1LJ2ETeEsYl8hD1+owehA=;
        b=fgvXBuRYKbTrha8a6Y7xYHESFw1TF4V04F3Dt8kf33SsDS6XIQ5MOrEEkKbyeN8enW
         9gzN4r+f7ZbbACYQSt2mMTR/jBT9AwPj00a6yyW+Snwm04/83d0J3lt4qGZCFwIJn0Ix
         HsAmaMTwC6ztYn0/F5/MXmkQFdMs7Nbr6Vef6nPVlsg5dklKlY8uTziINa5Ibm4OLn6z
         ZiD1ValWpPwneEuEWDNEjXTFsGa7W0m0sA3VLG84DFjSsNciw+fVYaBaMRrdTH5JPmKn
         2JB6cMIzVRbt2JkPVYHfDyQOh/QcgAzg2wl7Y7Dgf/Uio+f/nbdFBqdLcWTVdD1k11GL
         LOXA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Bw+3VoKhz1kEv9OnrYwxDVqwIU9obNdxe7kTEo/k0TDCYy2+a5Qa6Jfj9zOcHOJamAAppcCRhGbLtw3Jb7Exffzw8Ku9mKLP6CsB
X-Gm-Message-State: AOJu0YwKYOQ+SCQGmF54VKwnD/ND3KpL+dPfnHmbim8Jemh/Sks9ggYn
	iG09NzYdiWyjLZF/+hTXIMDhuAi9JWU5DNxI2nhSzCY9ENXpIuPusxpzNNAYHPXobBv0Ag7PZc2
	2JerfqUqIFGoVxz7oQp7IXYZpHUhZ+M34+uIICQ==
X-Google-Smtp-Source: AGHT+IGg/GAsaKY8g93SL83rdsel5V/KlOUKwAqZsoGoMsz8VtQS+2FhX5IVmdELMhBPT3sA0+WSrmuA7ocZtIVCyHY=
X-Received: by 2002:a5b:1cb:0:b0:e0b:1519:e0d3 with SMTP id
 3f1490d57ef6-e0bde2c64acmr11465264276.6.1722852588222; Mon, 05 Aug 2024
 03:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724182119.652080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240724182119.652080-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXkPwfVT-iJp70pEi5ubpc5YBKt=a2C5NmL_tjbocXKRQ@mail.gmail.com> <CA+V-a8ttfEHwXqUU2OqxhjJ3E2jt+xCBrbziHtOUs1g74tandA@mail.gmail.com>
In-Reply-To: <CA+V-a8ttfEHwXqUU2OqxhjJ3E2jt+xCBrbziHtOUs1g74tandA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:09:12 +0200
Message-ID: <CAPDyKFppZPadtEBocoVyQJkchKzQ4WgnLb0_CYgeHWk+noVbFg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Aug 2024 at 11:32, Lad, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
>
> Hi Geert,
>
> On Fri, Aug 2, 2024 at 10:11=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Wed, Jul 24, 2024 at 8:22=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The SD/MMC block on the RZ/V2H(P) ("R9A09G057") SoC is similar to tha=
t
> > > of the R-Car Gen3, but it has some differences:
> > > - HS400 is not supported.
> > > - It has additional SD_STATUS register to control voltage,
> > >   power enable and reset.
> > > - It supports fixed address mode.
> > >
> > > To accommodate these differences, a SoC-specific 'renesas,sdhi-r9a09g=
057'
> > > compatible string is added.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v4->v5
> > > - Dropped regulator node.
> >
> > Thanks for your patch, which is now commit 32842af74abc8ff9
> > ("dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support") in
> > mmc/next.
> >
> > > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >            - renesas,sdhi-r7s9210 # SH-Mobile AG5
> > >            - renesas,sdhi-r8a73a4 # R-Mobile APE6
> > >            - renesas,sdhi-r8a7740 # R-Mobile A1
> > > +          - renesas,sdhi-r9a09g057 # RZ/V2H(P)
> > >            - renesas,sdhi-sh73a0  # R-Mobile APE6
> > >        - items:
> > >            - enum:
> > > @@ -66,6 +67,7 @@ properties:
> > >                - renesas,sdhi-r9a07g054 # RZ/V2L
> > >                - renesas,sdhi-r9a08g045 # RZ/G3S
> > >                - renesas,sdhi-r9a09g011 # RZ/V2M
> > > +              - renesas,sdhi-r9a09g057 # RZ/V2H(P)
> >
> > This looks wrong to me.
> > Did you want to add it to the clocks constraint, like the third hunk
> > in v4[1], and was it mangled in a rebase?
> >
> Oouch, yes you are correct, this had to go in the clock constraint.

I am happy to apply a fix on top for that.

Kind regards
Uffe

