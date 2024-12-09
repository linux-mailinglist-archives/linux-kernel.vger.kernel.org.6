Return-Path: <linux-kernel+bounces-438172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39E9E9DCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360121885D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180AF15665C;
	Mon,  9 Dec 2024 18:03:30 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A61F5F6;
	Mon,  9 Dec 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767409; cv=none; b=AXN7U45zIpZ2WU4FaERY9owCCGwhivD+YLJ4NUsiuA007s58FRXIpPDEJ5scoeADgRXw9Nhe2+XtQ7jEQ1pdZ/7EPJMfHJWJQLs3qspgDPbBTtmEEGoVxpx/FOniJxV8dU7GqTnzagRCKsCrGay2n6ZJd20NeJONBEwIQJiS01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767409; c=relaxed/simple;
	bh=EttPOx8CTHWiEQjm6kODu7k6KrmesqYnGdfpbFKYER8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdhRG0wHgK2eZsQD4I06rAkAHbhuEuoKeYpU3N/F6thaZnoyhRYhdj1iaxzdVjkpc7+h9IqEaBvyUMQuq39oX8uV+ViPqPBm8NaAdObi9i8t1eqTIw+qfiV3x3ToW6/Zu7e91doqN9iHhs21aQn+iJ8JcoXgRbAn50oSvO+xHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-540215984f0so987377e87.1;
        Mon, 09 Dec 2024 10:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767403; x=1734372203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vt1eQkp9pAQVTjzNi7SG9xZxFIH63Nwe6vPPAcwIYGQ=;
        b=TWbCzdTaNExx8NfETUl4vqUPju/f2YZFxk8FeQBWiClzTt2YHzVzTBmBpZUpmnkk+H
         TvtBA+PsRMtQ36IMol951QkWjE52Nogj/pULJqjJQ5x5Qww82lo1863WvcpCW4uVNImX
         hw3zP2qT1wqMto/e8PFwbm6BJ/jUyCR/7JHZGZbE22YDFQAGA79EfyM6aCilMl23kOer
         VNfhGXlEmd3ZVWiKNw93qrghlSNdWpjUoLXHNw8tuQX7/gn+Zv6uvtyAV9u7/5dGqdJR
         2Zu2D4T5xZZHoHhRbm054Vw2e2iYNa/kFUNBBRFbt71erOlj/reQjWHl1RohLH86B7yD
         7Jww==
X-Forwarded-Encrypted: i=1; AJvYcCUoAmAG0Q4QUf2gVlzdZogPDXb74CHVD/xL+4loDwBLApxAE4OfEliWp0qWXodLIuXQ/HkaGisEE2LatqbW@vger.kernel.org, AJvYcCXLWYQ/VxAnySpO8nFI2Qzbrs+tTpMwABh9/EypA3qtz3DfXnt9PBc7Dvph7fk4g/3+oqQM4OefQxsT@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjNaY0T/2dsKZajS+kQRkiHfl6jqqdhN2RQCq35af20jJs+qj
	Xe2ERWgovTPWzpR36Xhd98kwOxqfvIZMgZ0mj5qCfiVVFi5rKvLvBUzAxQ==
X-Gm-Gg: ASbGnctbCFadfgdDswYvP+tnRxDZKkrwfSID68E2kMzGRh7LAkbJijwCz/5wUPi9RUD
	pRtwUmt+nqwuzbikQ1AARd5xqpXdIlUiIavjHPW/M3cyy42wPdab2JxBP365T84Zwi5CvkJ83gr
	Mv+ILCWTfy0dhb6MKfNSuSaPT97J8M9e8jn4cfz53xF2LmHaKCgl4uxArqx4B+DCh04eLSwVriN
	nS8qvUA3oWiMp4Gm90XPJNdW4mOZyri9HhI6ciQ9GKJBIMCBl5NKUtELPXS+WquWEoGA6/9U4gk
	79rYeRc=
X-Google-Smtp-Source: AGHT+IFREMvkmaQuoq8UAyjZmgeM2srNOKZNVSewT0B21kmxesr1SjsA0Xa+l3V92ddAUb6sEXvdrQ==
X-Received: by 2002:a05:6512:230b:b0:540:1b7e:7b3d with SMTP id 2adb3069b0e04-54024104993mr700018e87.36.1733767402851;
        Mon, 09 Dec 2024 10:03:22 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f23320d1csm751678e87.235.2024.12.09.10.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 10:03:22 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so43866941fa.0;
        Mon, 09 Dec 2024 10:03:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5cpQa3C3gu28/trXUxNDrc/zFqaptS+AfOYsJfor8VyZHXNJ4oVddh6k2RREVgQfwvXDZ4S/Tp36E@vger.kernel.org, AJvYcCVcNeHdRXeO7siNkmXfE6XI4h9E1idp4GNP4w/u3MeDJO2/lzrlYT42/pEx/tTEoOJLYSJGx18j+SP2NUZo@vger.kernel.org
X-Received: by 2002:a05:651c:509:b0:302:2cb3:bb25 with SMTP id
 38308e7fff4ca-3022fd7da65mr6276521fa.29.1733767402058; Mon, 09 Dec 2024
 10:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
 <20241205000137.187450-2-csokas.bence@prolan.hu> <20241209175637.283312fa@donnerap.manchester.arm.com>
In-Reply-To: <20241209175637.283312fa@donnerap.manchester.arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 10 Dec 2024 02:03:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v644AgZvuOmvQCUXGWyJWYCgVnCkVohNdD-Z0FhgOrp1cQ@mail.gmail.com>
Message-ID: <CAGb2v644AgZvuOmvQCUXGWyJWYCgVnCkVohNdD-Z0FhgOrp1cQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: suniv: f1c100s: Add support for DMA
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mesih Kilinc <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:56=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Thu, 5 Dec 2024 01:01:36 +0100
> "Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> wrote:
>
> > From: Mesih Kilinc <mesihkilinc@gmail.com>
> >
> > Allwinner suniv F1C100s now has DMA support. Enable it under device
> > tree.
> >
> > Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> > [ csokas.bence: Rebased on current master ]
> > Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
>
> Compared against the manual:
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

These have already been merged. I picked them from their original
series.

ChenYu

> Cheers,
> Andre
>
> > ---
> >  arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/=
boot/dts/allwinner/suniv-f1c100s.dtsi
> > index 3c61d59ab5f8..290efe026ceb 100644
> > --- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> > +++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> > @@ -6,6 +6,7 @@
> >
> >  #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
> >  #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> > +#include <dt-bindings/dma/sun4i-a10.h>
> >
> >  / {
> >       #address-cells =3D <1>;
> > @@ -159,6 +160,15 @@ usbphy: phy@1c13400 {
> >                       status =3D "disabled";
> >               };
> >
> > +             dma: dma-controller@1c02000 {
> > +                     compatible =3D "allwinner,suniv-f1c100s-dma";
> > +                     reg =3D <0x01c02000 0x1000>;
> > +                     interrupts =3D <18>;
> > +                     clocks =3D <&ccu CLK_BUS_DMA>;
> > +                     resets =3D <&ccu RST_BUS_DMA>;
> > +                     #dma-cells =3D <2>;
> > +             };
> > +
> >               ccu: clock@1c20000 {
> >                       compatible =3D "allwinner,suniv-f1c100s-ccu";
> >                       reg =3D <0x01c20000 0x400>;
>
>

