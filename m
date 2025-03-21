Return-Path: <linux-kernel+bounces-570616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38FA6B29C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F42A1897E20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529DB1ADC6D;
	Fri, 21 Mar 2025 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2H9hCxB"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DEC1C69D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742520036; cv=none; b=tjX/sijwxHb6iE7bAH3Zp1kQfA2GrsAEkIUU8fi+BRVIwnfp2TYsv/TvBhf8viykFIY0aYGFlDmqxOdfkXFgGYfhgG0YQTD3Zv3iwj4Cop+MAvLIV9dY/efDnrZKHoi4ME2ZE+3VcTFzpqOSc2Es1txWdWCJ64AMjxCK7dd/L/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742520036; c=relaxed/simple;
	bh=d1equHrIwerth6ci4u5Gvux0j0YeejlVZrRFHJJu+zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIyAZUziyDn9TxVPr9Fs/Zzm63I0rGScDpNHX4qq1sy1l20hyp9GxQ6q/SN+OnYShwejxSr74NkPbAcHyyf+HvNypEdWmH50jJgf1620TQQ0P/IzExBA8lutxTVgR0+iprrbG+S+0NwndifLsVDNv82wlIWdqvbmNVjnbW2uXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2H9hCxB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2667460a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742520032; x=1743124832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HZK/FjsgxH8rgQz5UdjpktKxGwid5B9t/SURmUdS6A=;
        b=U2H9hCxBql4SQTyGqfdLBz2mDveNJzgrB7OrHNKWwKCSZ1AF6HKJF3vViI8s1XR4cR
         4i4RLds/KfC8iMcP6BO68C6OM3L9Ujzgc1YthR3/0EzXOhi0Aacw1KHLSFSfqP3qHGNV
         aSKr1adWZGSi3FdOoTIqwf/RUk1ZRrWWg5InXKONPLjkoS79hOQ3DvX2XNpAna5b4i40
         QY2/OGBw17LpdR4pH1OfUmXyHOY+iP+iWMkiLzqc7vN6Yfiq7KXk9vdqjwnpMU422fKU
         rNbZYiPoQwFbBuSfQW7fUucb/gg6BuhOo8Ki4eo130aWlgyRHTUUzoCeorxdL0CG2vmv
         e6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742520032; x=1743124832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HZK/FjsgxH8rgQz5UdjpktKxGwid5B9t/SURmUdS6A=;
        b=uw3jv96Wkt6+FwV6iop6VtahUoEDEg8yYGod9aED5e9rLUlfyZmHj9dWnIRBIAqL/g
         VaJNt/kA4QT+cJ1kHbWkfV4uGZ9V5/Am4lTrhd2qeJyRnHAi/aTqbZ5tNM+GQpdvujms
         5GsJUO69uaUi/gaaI3xNZdphdyguNt2pfvjSvNUrE/UpKffASBNH5AxPULqjFjxn80Lx
         DyHwO+1y0xQ9GIIYFDRAgK9epLJ+Q20QGiaCTIDHm7a3Jd9lFYiQNkIQ4JZTn6qG7vGB
         6RcAyUkK1zk5LIVU7N4U9q/sD37mCxP2zt7gl2IC+odkVMXNCUzciw8hem/tS6RXcENU
         SVyg==
X-Forwarded-Encrypted: i=1; AJvYcCWV8psQa4Mll/Hmo9Fp58f2ylxS186TOHafW+EI36KgF+ouNBdHD8UzWzdbi4PHlST1uIPiXFpRVS/P4MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaStd7OMjI6dYGrVLgagd0xfWDWsWliaMrBtI2Y3GiJ+F6p/cT
	hL23s8Taux6D4qW4oB8+CBE6pm7j6Y5uWGxlrKputCOzYCYajQFDLPQPnmg0oeb6BzVocAImHAE
	QUYaMVzr/uispd0IUE3RKENqblk4=
X-Gm-Gg: ASbGncsRPo1Qy2r3A1efX8EqlEv0YSD0LxskFNU/D2f1QyO4hFKgwsJxzOgfs+VaqxH
	VUPe7YjuiZoyygQgmKdX/GOUgVV/IF3cFA0/jqUdE+B3nJub9mJO2QC5wE51c7WJaGKQuSwaIXj
	SE0DpLgswGPBeBflfmfDlS6w4AADPwaBHDuf+oVwoG0iumKsdU6bNr/HxEwB4=
X-Google-Smtp-Source: AGHT+IGIE1+moUJxAvVppTaWNdlItcrjKuGQPgygcTy+VdcsvgnoPSCeR+4j8NRkAklH93BWzVlDqMTDcRKMNKFlmI8=
X-Received: by 2002:a05:6402:2793:b0:5e5:3c1b:c0ff with SMTP id
 4fb4d7f45d1cf-5ebcce07a08mr1613441a12.13.1742520031566; Thu, 20 Mar 2025
 18:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315204852.1247992-1-CFSworks@gmail.com> <e1cdc3a39b9201cb115b12b559899aee@manjaro.org>
In-Reply-To: <e1cdc3a39b9201cb115b12b559899aee@manjaro.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 20 Mar 2025 18:20:20 -0700
X-Gm-Features: AQ5f1JrZ70w76EeL0x7DU0tc9VlG6Hcd3TPBcx3Yd7HL18hR7dxsfjuAIY08JdU
Message-ID: <CAH5Ym4hqkMMBsT7XEz_f+TCng+0X2m0nV_Kdr-LAPBqgENgr5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Allow Turing RK1 cooling fan to
 spin down
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, 
	Sven Rademakers <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:38=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Sam,
>
> On 2025-03-15 21:48, Sam Edwards wrote:
> > The RK3588 thermal sensor driver only receives interrupts when a
> > higher-temperature threshold is crossed; it cannot notify when the
> > sensor cools back off. As a result, the driver must poll for
> > temperature
> > changes to detect when the conditions for a thermal trip are no longer
> > met. However, it only does so if the DT enables polling.
> >
> > Before this patch, the RK1 DT did not enable polling, causing the fan
> > to
> > continue running at the speed corresponding to the highest temperature
> > reached.
> >
> > Follow suit with similar RK3588 boards by setting a polling-delay of
> > 1000ms, enabling the driver to detect when the sensor cools back off,
> > allowing the fan speed to decrease as appropriate.
> >
> > Fixes: 7c8ec5e6b9d6 ("arm64: dts: rockchip: Enable automatic fan
> > control on Turing RK1")
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> > index 6bc46734cc14..0270bffce195 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> > @@ -214,6 +214,8 @@ rgmii_phy: ethernet-phy@1 {
> >  };
> >
> >  &package_thermal {
> > +     polling-delay =3D <1000>;
> > +
> >       trips {
> >               package_active1: trip-active1 {
> >                       temperature =3D <45000>;
>
> Thanks for the patch, it's looking good to me, with some related
> thoughts below.  Please, feel free to include:
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>
> After a quick look at the RK3588 TRM Part 1, it seems possible
> to actually generate additional interrupts when the TSADC channel
> temperature readouts reach predefined low thresholds.  Moreover,

Hi Dragan,

Ooh, I see that now!

It seems to be as simple as adding a `.set_cooloff_temp =3D ...` that
writes the lower thresholds to TSADC_COMP#_LOW_INT and sets the
necessary bits in TSADC_LT_EN+TSADC_LT_INT_EN. Since the driver
already rescans all temperatures on any interrupt and acknowledges all
interrupt status bits indiscriminately, I don't anticipate any other
necessary changes.

I can easily take care of that this weekend or next if that plan
sounds good to you. However, since *this* patch is a Fixes:, I'd
rather land it as-is first and handle the above separately. :)

> avoiding the polling would actually help the SoC cool down a tiny
> bit faster, which makes it worth detailed investigation in my book,
> despite not being used by the downstream kernel code.

Do you mean "spin down the fan a tiny bit faster" (since it would
detect the cool-off without needing to poll for it), or are you
emphasizing saving CPU cycles that would otherwise be spent polling?

Thanks for the tip,
Sam

