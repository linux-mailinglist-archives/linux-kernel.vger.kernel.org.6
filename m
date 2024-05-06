Return-Path: <linux-kernel+bounces-169669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C501E8BCC04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AF31C21172
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF06142909;
	Mon,  6 May 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJTHnEME"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F414265C;
	Mon,  6 May 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991397; cv=none; b=OGnDsETXxU12ncMjXbx1i+VqyIvG063hZ6UJZavcgWCbMhynRIzvoTPFTumGIqyjM288co8odD5AJjF2hZ1bTRT0+VYNJ0TvmpnuJZW0g9q+VeBlCPEt6U/uEekXQGfXfZlzB9OPQjcTQeVly3IM5RegFlp4jQMs5lWvtiPnN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991397; c=relaxed/simple;
	bh=3PoJY7tNXwvsdNUc2P3zuM49T2QEkSgVCQPu9yNoIQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goTh1qY2tJI8U5Sl0QXIzZ4LGRVUjlTBd8DfBk+CQyU5PeUmOXE/Kw67PvvUS9UE1H7DzUjMWzhGag+sod0qvNB+wdI8LjLev3oZgWEGzX6AFiVkxvK5DWlbVyWxtIGGoH8ipxS7HFc5QIcbXHmrORZBePaN0OIwHKPlRbnYL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJTHnEME; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fdc9af005so2632827e87.3;
        Mon, 06 May 2024 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714991393; x=1715596193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNMaBJWGHZyABbZOaeEJdaPLgk7Dz9409DKeZNEhRws=;
        b=iJTHnEMESoEnqovcI2yy2yqnM2qYNEnrUE9lEeM3JPqNQ4Td48/zil1+Ppr39vpK4I
         aaPJWvn+J/26VrK0QpZkYpSjC/2XAL3ugwLe9eLDn9FirWQX/FkmYr4I1vuW+qCICnCw
         x2CLNmhfV5/7OTmVm9LRT/5FxuD4RniMGGGXWusYyfvJkfUrMM6Dhdg5/2arJeJKEnlm
         cnX1ov9l0n5CZbP3XYj/KwriIwUNUbM3mls5U+0eRPtgHJRREvLzNqddjPpCskQ5WXnC
         46Psip0geqolO33Va/D8Xlu0bi1FyotTcEBUHkrNeM7KbDMKjVlqFBJRJlxMosvkyhPz
         aCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714991393; x=1715596193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNMaBJWGHZyABbZOaeEJdaPLgk7Dz9409DKeZNEhRws=;
        b=TynYazd6tvu1rzFeOKD69wMHBAbYTXmROuK8odK018PKw6hvI1VCR6CIGvKA/kMTO1
         bTIK3y3nkPdxUbfk7z6sto9E4V/R0557vXAqNbsGBCSmI2JqXRzQAUecC0YafbFTRnOS
         a6h8ns/3GIgtIRBG0Tn3clkFPgornTOHeH3uTumz7JCqzOpkkJkxilToEcMPzIrhpjOf
         m0W268ukxBW5p6FOOXFL+bNpQBNydnV5T+JxvAR9W7DtA9J6JdmTyRax7qekiCAQfaJr
         OQQXAz32q3U41ZbOr+rwLjGC7TAeMrEsb+AX4K4gl1DHZf7L7t/5ULEYWQ8jCxYb3z5Y
         IzWw==
X-Forwarded-Encrypted: i=1; AJvYcCVOpyam0pz8jvsmwUnyyqKOvXX5J9St/Fb/Gyiukrx+KuUHlJOPONNZz0VwVl6UURW/8LytiKdZ8cWXuAbzO+/U9L2Y8Kt5el9a9w/JpcVpJVoUr11M/0X4/FR5zjjCEs9GCZ6LlAcWDg==
X-Gm-Message-State: AOJu0YwDX1NT5ZPs4arafsyoTukQPc0MrnGxj7gZXMez+ZnAD2hgx4qw
	ezKYcw4tkFCQia5PrKMKR+/09w6vI8vS5qsSHYQH5SxdHAJ0NOJPgh8bUvIHchBWKN9Id3sHHyq
	Od2+/upLTjLwvbtezstxTBlusNr4=
X-Google-Smtp-Source: AGHT+IG+kj32TsL8muODw5VYvjt7aRQOGre2x2qhtWjM/D/2fzkEhZvrp99rRg39tty5jMlGjdEnSiLMOm9Us3O0nvU=
X-Received: by 2002:a19:381a:0:b0:51b:528e:ce7d with SMTP id
 f26-20020a19381a000000b0051b528ece7dmr7786951lfa.34.1714991393205; Mon, 06
 May 2024 03:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-1-271023ddfd40@gmail.com> <5332d58d48607a5559a84a2f85ce3e1b@manjaro.org>
In-Reply-To: <5332d58d48607a5559a84a2f85ce3e1b@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 6 May 2024 14:29:41 +0400
Message-ID: <CABjd4Yz0NyqgJL8HXH2-KCxP-GbsiZjvdwqcQGh6RJuECH=kvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] arm64: dts: rockchip: add thermal zones
 information on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Dragan,

On Mon, May 6, 2024 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Alexey,
>
> Thanks for submitting the v4 of this series!  Please, see a couple
> of my comments below.
>
> On 2024-05-06 11:36, Alexey Charkov wrote:
> > This includes the necessary device tree data to allow thermal
> > monitoring on RK3588(s) using the on-chip TSADC device, along with
> > trip points for automatic thermal management.
> >
> > Each of the CPU clusters (one for the little cores and two for
> > the big cores) get a passive cooling trip point at 85C, which
> > will trigger DVFS throttling of the respective cluster upon
> > reaching a high temperature condition.
> >
> > All zones also have a critical trip point at 115C, which will
> > trigger a reset.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 147
> > ++++++++++++++++++++++++++++++
> >  1 file changed, 147 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 6ac5ac8b48ab..ef06c1f742e8 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/ata/ahci.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       compatible =3D "rockchip,rk3588";
> > @@ -2368,6 +2369,152 @@ pwm15: pwm@febf0030 {
> >               status =3D "disabled";
> >       };
> >
> > +     thermal_zones: thermal-zones {
> > +             /* sensor near the center of the SoC */
> > +             package_thermal: package-thermal {
> > +                     polling-delay-passive =3D <0>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 0>;
> > +
> > +                     trips {
> > +                             package_crit: package-crit {
> > +                                     temperature =3D <115000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +             };
> > +
> > +             /* sensor between A76 cores 0 and 1 */
> > +             bigcore0_thermal: bigcore0-thermal {
> > +                     polling-delay-passive =3D <100>;
> > +                     polling-delay =3D <0>;
> > +                     thermal-sensors =3D <&tsadc 1>;
> > +
> > +                     trips {
> > +                             bigcore0_alert: bigcore0-alert {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
>
> Doesn't removing the second passive trip, which was present in the v3,
> result in confusing the IPA governor?

Not really - it will just treat the missing trip as 0C for its initial
PID calculations [1], and will continually run the governor as opposed
to putting it to rest when the temperature is below the "switch on"
value [2].

Getting the power allocation governor to work optimally (i.e. to
provide tangible benefits over, say, stepwise) is much more involved
than defining an arbitrary switch-on trip point, as it requires an
accurate estimate of sustainable power per thermal zone (which we
don't have for RK3588 in general, and furthermore it must depend a lot
on a particular cooling setup), and ideally some userspace
power/thermal model capable of tuning the PID coefficients and
updating them via sysfs based on how a particular system accumulates
and dissipates heat under different load.

So after thinking over it for a while I decided that those extra
passive trips were rather self-deceiving, as they are only useful in
the context of a power allocation governor but we do not have any of
the other pieces in place for the power allocation governor to work.
Better not to clutter the device tree IMO.

Best regards,
Alexey

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/d=
rivers/thermal/gov_power_allocator.c#n156
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/d=
rivers/thermal/gov_power_allocator.c#n487

