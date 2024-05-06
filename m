Return-Path: <linux-kernel+bounces-169854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71C8BCE8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C05287E26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995574BF8;
	Mon,  6 May 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF3fbcQo"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131966BB29;
	Mon,  6 May 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000057; cv=none; b=l8QTkWOXFc1UVn4og53tVbAI/RTOhRfTa/9iaJ/6ix4vO08GWdXzHammSoM2ciMz2JnvQxu8wP2raBpPhfxkS+Oijrk7AW33MAikcA4lB/NUHOx34+jVR/MZH7m9Cpm0UoG4WY+Ajxz6Ql9jgDMWTB+QUMENvi/8pv84AuaJatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000057; c=relaxed/simple;
	bh=E29O+zMWl54OXMlXahFL9wvPKNx96W/D2EieMI10Y/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHQVro7JaSP8wBlLi44b4jv1ii6pSlsmSD3hlqeIV284RQvu/Y7OS99H6d5Wpn6GaxvFz64RshGTJtTFl4gsGCSbAxWGFKkslUE3feqABrMZlI0bPowuOUnvJUtPsStqmQXEiAd9s4U0bkfI48wttIzTeQLPE2ot1/nuHsc8UAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF3fbcQo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f29e80800so2020175e87.2;
        Mon, 06 May 2024 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715000054; x=1715604854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYJUMLyOfuPVkBGsjqvkIOkmksaH29NkjD+X1QlY6WE=;
        b=BF3fbcQoIMk3XTJYeL5bDMvtsnGmu+My9/JmRckN6IjsfWsaN37APcJrKTeXzGDLHf
         eG7kUdnLzpeS2+AhUrcATHPW9YB7m2vChQItecg3TzhaBvJVlCHlWgy0cL8GrII4/835
         zEXLOkqXIk2dr/pYVj03aGUHWXiu2DwrbRvO0wJkiBafst4FPt0hXrTcMoVZ4z2fEKrQ
         ngxc63zvUOrQ0YTRg0Js9a6BaBoXP8j4T0a/CP9rc8kSEaNd5hDIOp3HMYQVWfO7iMqQ
         GZGZBKsRo0oeuyY3w+Tv3B0kdIZZe2eiJIoPQubCVQTxVCA2LvF4gdvkv3L79IEl04ke
         5BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715000054; x=1715604854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYJUMLyOfuPVkBGsjqvkIOkmksaH29NkjD+X1QlY6WE=;
        b=O88JYHySBcZuCSkEEkUOQw6VZqBj6AZRTfg0T+3vScNGh8Y8tV3PXoZxtXE4ppBWf2
         +J1HgvDqTLkPfNnPSlnzYuRyARilllQuJERxyuiwYWiizDgK2AatR3ozE+WJI35zLI/Q
         Yx14Y26AHpBv+x7dCvGwivPkcbTsPtuL6YUad7FyMCZrIpmht89XqsLHWTWKygvQlrWf
         P6B1FghXG7dDshfxaB++meFt9o8eXUINtNLOjmeILBcY1o1lDChCqbkqsNgu6kAQJ3yk
         HZle4e93rI6C/BguVLOgBicqaW8NlGnLAKjGQks47AYhngoHQDMowrDBv9UZIs0QlKEN
         TmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYvUUb334/0gme1cf6H1iO9qWVXppxT8MQEtvla43ZTCCQz0wK2cJBBbrNePiY46p0lTDvJsKjISz0aJ/WGGK9rXJxWMJVf6IT9pmdG/SsXUykSLLa2ZTyd2jWn9TlcPCVmxYNfIAqkw==
X-Gm-Message-State: AOJu0YwLVxa/Acr3unn+vvvf/vUnpWdOgw1Zgo8AbgIyjuG2c2B5Fzn1
	ZbMSrxBDSMZFsZMO/uTdm7JNry0/nLhev/JkQTuxhjHv2kSeALi7rSWqb59Sr69d36i01yKFgwu
	PJHrzmWIXsvXRTJR1p7JZNmQCouI=
X-Google-Smtp-Source: AGHT+IEuu9HAQAASDPOvUv+eo4vaDmGpspytyOqJN4kLuzL+gyh+71AymJnLzYz3lQHVXAn61CiMQkJLULyWq0AKhf4=
X-Received: by 2002:a19:f51a:0:b0:51e:eeb1:f24b with SMTP id
 j26-20020a19f51a000000b0051eeeb1f24bmr5882309lfb.34.1715000053829; Mon, 06
 May 2024 05:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com> <2543817.5xW6y1K4kI@bagend>
In-Reply-To: <2543817.5xW6y1K4kI@bagend>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 6 May 2024 16:54:02 +0400
Message-ID: <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Diederik,

On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas <didi.debian@cknow.=
org> wrote:
>
> Hi,
>
> On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> > This enables the on-chip thermal monitoring sensor (TSADC) on all
> > RK3588(s) boards that don't have it enabled yet. It provides temperatur=
e
> > monitoring for the SoC and emergency thermal shutdowns, and is thus
> > important to have in place before CPU DVFS is enabled, as high CPU
> > operating performance points can overheat the chip quickly in the
> > absence of thermal management.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++++
> >  8 files changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> > b8e15b76a8a6..21e96c212dd8 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -742,6 +742,10 @@ regulator-state-mem {
> >       };
> >  };
> >
> > +&tsadc {
> > +     status =3D "okay";
> > +};
> > +
> >  &uart2 {
> >       pinctrl-0 =3D <&uart2m0_xfer>;
> >       status =3D "okay";
>
> I built a kernel with v3 of your patch set and someone tested it on a ROC=
K 5B
> 'for me' and it had the following line in dmesg:
>
> rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
>
> I'm guessing that turned up due to enabling tsadc, but (also) in v4 I did=
n't
> see a change wrt "rockchip,grf".
> Should that be done? (asking; I don't know)

I'm getting the same. Neither the mainline TSADC driver [1], nor the
downstream one [2] seems to use the grf pointer on RK3588 at all. It
still works in spite of that warning, although I can't see how (or if)
it configures the reset mechanism without those GRF registers.

Best regards,
Alexey

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/thermal/rockchip_thermal.c#n818
[2] https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/thermal/=
rockchip_thermal.c#L961

