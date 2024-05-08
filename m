Return-Path: <linux-kernel+bounces-173215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D550F8BFD22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BA4B221E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695755102F;
	Wed,  8 May 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwx1MVje"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AC17D2;
	Wed,  8 May 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171455; cv=none; b=nwhdr/oAg/4hS9kA3coVrCcyzwLRG+RLWx27tvdv3uPzwGLoiv39moS/52R9e7wOtkMuHdmK2HnIJZ8vdqOHHnm3WUsmMHk327wr+UudUrhYF6UGQ+bJZwrVMU4shg1hqybTlwEiCT48hKdHMHjiXPZlQpUROJLDKdhlN8v3Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171455; c=relaxed/simple;
	bh=ALq+GbVInLjCqyOE3VcX8VbwJqOjvawQQIc4bTCD7cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjK7LEV3d3Rp84A6P2tPSKPgnmCYxFEYaUdX15ainKqXsb9F8j7Ec8riU0A8KQlj+oAwzB9SYtoY3Kwd5FE61tpSUagY/tjrkRpV9TUUOtIrCineMmDj8V8+asACbUg34etrG0ezdkeMbGzL5Y4Rwd4FV5C0/3d7+urMwtyOFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwx1MVje; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5200afe39eso1135295366b.1;
        Wed, 08 May 2024 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715171452; x=1715776252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcm2/YfLi6B6QSCpP7qXLx5hvzXORG9bOF9gqBdKX9Q=;
        b=Xwx1MVje0sLndPaK7kmGs0+d66y11zD+S+PtV21KZikfKE+wzCdoQd4sDujGb7rzaD
         VqMthpvlFvVUX6Cmx0L5opdbP8GzDqXjJjnGfKfjWAAxitO+vKQ2W/FSkbV82qPwVzLS
         K597AAd2HMDwlqYlBcULhrR1FQDA+6B7bORjGX2sLPebnMxKOHMQelwdVhp2Z6+rtlfJ
         VmtahI2eEggYjhUerNBQqG7k3tWbF2NG4bm7FJSjGtJmggT9D+jAoI3+GvDzVqDgPEaH
         nMTAu9qBkODZXQwbgQWgMZOCDohT2ECwri660XI+Vsg2S4lIHeNHuKrtwba58/1QFFKk
         V1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171452; x=1715776252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcm2/YfLi6B6QSCpP7qXLx5hvzXORG9bOF9gqBdKX9Q=;
        b=PP7hIGfdQYC0sQDk2Jg5GtjtDmqLe+Hg5IUaYD2crS0i+wvilaVjvg9w+g6zpny41d
         53tNo7jz68KuR/eMyfLc18Fo8P99ZdwKJ5OMdD4Ydh5f+nJQgIe3Ye9OOzmP0nbQ1jcM
         4n8//4Bj53r/Or7kuDqkJ8WdKeOatuvFG+kMfsX/CJR1smTS7HIIv5KqtUbiDG7/VDpY
         U1YX2Gh5Ao40QKJ7B/V7j9bJjYt8uygQ2x833ZHhKJ+V9yR1EA+Qd6iG6h27x3rnTovM
         6CTBX0Ts10HFCNaiyDg2HXhPtDpj5lWWeQ12RxNk/0yZhijt7wr6xxTbXW2+u/VnOMyL
         dbNA==
X-Forwarded-Encrypted: i=1; AJvYcCUrDj6GtWSXtjd9ACo0mXr3QOxoUcz+XnCfwk6oiThgTXZ9x8VysTquTW5oLrtmuk9mUOeRs3HS8gxV2PpydYP4rrXmVmvRTNtcbQNPbArCq5X8I+Zz4BoYKPfEmWlK1bgyV2cmRMA74w==
X-Gm-Message-State: AOJu0YwefzJe53tkH7loMQURvvJb1rFEO9OVrHDu21ZH58Yc3GdrR7qy
	kEPXDdXxhf0urioJ1G6NXDwjVcP4JG8t1W2KNJBFAEnltXT6DUc5bm/8TwQwqKM71hRcoBmZczk
	syaz3WnGMz3Eqau5VLI6Im/MShY4Wi8lMuzY=
X-Google-Smtp-Source: AGHT+IGl8X9MaGsulmww8nCeO5gSLtUDnL5MWBFljZFyxkO8eM+qiXDpQYJ8Z0NXgOWoOT66jo3S89FPe5HQd5NxLRM=
X-Received: by 2002:a17:906:a41a:b0:a59:ced4:25b0 with SMTP id
 a640c23a62f3a-a59fb95595fmr200267766b.34.1715171451873; Wed, 08 May 2024
 05:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com> <2543817.5xW6y1K4kI@bagend>
 <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
 <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com> <a1fb157c88f420cd85d56edff2a4d85b@manjaro.org>
In-Reply-To: <a1fb157c88f420cd85d56edff2a4d85b@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 8 May 2024 16:30:40 +0400
Message-ID: <CABjd4YwHGYRrpMFn1uoQMRh3Tp4-py111tZiCGgf7afWxNGXnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Dragan Simic <dsimic@manjaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Dragan and Anand,

On Wed, May 8, 2024 at 3:46=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello Anand,
>
> On 2024-05-08 13:40, Anand Moon wrote:
> > On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wrote:
> >> On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas
> >> <didi.debian@cknow.org> wrote:
> >> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> >> > > This enables the on-chip thermal monitoring sensor (TSADC) on all
> >> > > RK3588(s) boards that don't have it enabled yet. It provides tempe=
rature
> >> > > monitoring for the SoC and emergency thermal shutdowns, and is thu=
s
> >> > > important to have in place before CPU DVFS is enabled, as high CPU
> >> > > operating performance points can overheat the chip quickly in the
> >> > > absence of thermal management.
> >> > >
> >> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> > > ---
> >> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4=
 ++++
> >> > >  8 files changed, 32 insertions(+)
> >> > >
> >> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> >> > > b8e15b76a8a6..21e96c212dd8 100644
> >> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >> > > @@ -742,6 +742,10 @@ regulator-state-mem {
> >> > >       };
> >> > >  };
> >> > >
> >> > > +&tsadc {
> >> > > +     status =3D "okay";
> >> > > +};
> >> > > +
> >> > >  &uart2 {
> >> > >       pinctrl-0 =3D <&uart2m0_xfer>;
> >> > >       status =3D "okay";
> >> >
> >> > I built a kernel with v3 of your patch set and someone tested it on =
a ROCK 5B
> >> > 'for me' and it had the following line in dmesg:
> >> >
> >> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
> >> >
> >> > I'm guessing that turned up due to enabling tsadc, but (also) in v4 =
I didn't
> >> > see a change wrt "rockchip,grf".
> >> > Should that be done? (asking; I don't know)
> >>
> >> I'm getting the same. Neither the mainline TSADC driver [1], nor the
> >> downstream one [2] seems to use the grf pointer on RK3588 at all. It
> >> still works in spite of that warning, although I can't see how (or if)
> >> it configures the reset mechanism without those GRF registers.
> >>
> >> Best regards,
> >> Alexey
> >>
> >> [1]
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/thermal/rockchip_thermal.c#n818
> >> [2]
> >> https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/thermal=
/rockchip_thermal.c#L961
> >>
> >
> > If the following changes fix the warning.
> >
> > Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
> > PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
> > to control the Enable TSADC shut reset trigger for DDR fail safe.
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 85c25d5efdad..5490a44e093e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
> >                 rockchip,hw-tshut-temp =3D <120000>;
> >                 rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU
> > 1:GPIO */
> >                 rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity
> > 0:LOW 1:HIGH */
> > +               rockchip,pmu =3D <&pmu1grf>;
> >                 pinctrl-0 =3D <&tsadc_gpio_func>;
> >                 pinctrl-1 =3D <&tsadc_shut>;
> >                 pinctrl-names =3D "gpio", "otpout";
>
> Basically, the rockchip_thermal driver doesn't use GRF at all on
> the RK3588(s), so virtually any value specified as "rockchip,pmu"
> can eliminate the warning.

To me, specifying an arbitrary GRF in the device tree just to silence
a warning that the current driver emits sounds bad. If the GRF is not
needed for TSADC initialization on RK3588, then it should not be in
the device tree (and it looks like the case here) - otherwise the
device tree ceases to be a truthful description of the hardware.

I'm not sure if we need that "DDR fail safe" logic mentioned in the
TRM that Anand quoted, given that neither Rockchip downstream nor
current mainline driver implement it, and furthermore none of the
other SoC revisions supported by the driver mention it. If we do in
fact need it, we should probably first test it along with respective
driver code before committing to an upstream DT and thus making it
part of the ABI.

IMO this is more of a driver issue than a device tree issue: maybe a
small patch to demote this warning to an info message would be better?
It's harmless anyway.

Best regards,
Alexey

