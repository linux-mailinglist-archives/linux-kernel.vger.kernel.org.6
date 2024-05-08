Return-Path: <linux-kernel+bounces-173160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FB8BFC51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBB1C22180
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F5824AC;
	Wed,  8 May 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnLsjxTl"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57605823C3;
	Wed,  8 May 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168424; cv=none; b=aB+W0C1wJbGidrrIuMrhZl6l+bzgK8t1PXfv/fqLg8arlzB3MK+Vavnu7ijBcR2ZGFnZLDfE6lnTapShGf2sjTnSeSk2z90/EpBc+cxBiRNdajZvi9M3eVwtTj1+jWcbIivqgU+au3blL7pljvClpSBg6E8rC+pe30UorAT0r2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168424; c=relaxed/simple;
	bh=LzkcsxBboOgTqBhvmxB1AA5X0VPmOIkAnWcagywa/TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMIqoa6z+ZFb0qX3hmKwz7/bRPn8+0T1bb25n0n+pe5+lshySxjkoODy2DTo3cXIsLdTMP2xu0TrsIVl0d3l9+rd28wePqw28AFZAV9b8otp7hAu8jqZETYZs5J9v69Sk0xYTv6x3+cTZu19CVXd/nPsAF+5j08xJlMggjFcROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnLsjxTl; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b203c9933dso2267152eaf.3;
        Wed, 08 May 2024 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168422; x=1715773222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOIzh5hay1VG+baSkhj40F76B94Bx+2N06xZr/PBSXw=;
        b=GnLsjxTlU/2dVrZE8+WMjbY0VMLNLbBbnA5YrhMHhR7q2cbI0XQyq5dgFmEfLylK65
         G8e7syVaiLXR1q/NtIZ+5Y8w5isHEQviYloB2o1j/8f8m21X/+LS9hfiTOVTkcFSSA9r
         9D/oP6rsLFrUcMYJuOWlQ3vFF9os4REMNWgK6PXw+hpi9xiHUOg972DGWuG9mvPI2Rl/
         eX9k4tGsCDmUiOSWhbaGnI6PMHCwY2kHvtJMOh3Wj6ImrzYkzXp3Nl3WAyvpfis3IYqd
         jnp6BYG8RYVQUMHPDnz0U19jOoYqO2lcZbUsOawLTD33IeBR6bKyUBsWpyHPCxZEh0UE
         Za8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168422; x=1715773222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOIzh5hay1VG+baSkhj40F76B94Bx+2N06xZr/PBSXw=;
        b=WXhFxa8mfmpTobscMItxtiwCQx7lxK/TpoBw1pJgakmm8M6ZvweD8soUbGanJXkYDr
         AaLbeZPr5t89+FeQzuWVoaWxWnL916RvWWqMfzFUFT/VelDgsxQSrDushS4XBDFJ95+H
         TNvelYbw1ZfLJ4aB8VvRwGJ6q9tqhrzPByPaM/NX4e9SS8bbIq/ARWXP6Df5y2V3Z7rL
         qiXQ+vmdzA5EpqHoOsIUBbG5oLFYV2Nk+7uJ/LncbJ0KbLVoxNK2p3j/y3v2vetrD4HU
         +ITQnMkPic9Kw7E9r9uFPIFzdW/R83XoevcYQVBBbH1fA98de3wB3/6bFN8/xyJcz9x0
         77DA==
X-Forwarded-Encrypted: i=1; AJvYcCWYuRWlmXOWqsB0YGiQ4C9nFWAoDbyzdrKFrfEacWtD/gZdJnN9/ewc6VIZBkjR5Yp4B0Qd4GHYLjibqeZXCPvO9qEFoc3D8aVhRK5Q/ofciV7NIVxcLnLR6VBhqNUMQS5UDRxo/AJleA==
X-Gm-Message-State: AOJu0YyGfguW+bhLtTe0f1UTPijWDYIOJyhm5dqC1wi+CfpIkcV5nIdp
	tdTOaX7NFwuz8C9dPrtU9DXr2CAZ9o+deThI0EVsN2PZQI8PgvinWWkaPZ913XIvJZXJgwf8K7w
	QRDzi32ZcnrVowH3krliTU/oZTwljLorWx7Q=
X-Google-Smtp-Source: AGHT+IHmLv/TAPoHKLua1wTR21SZpjGzAQp6CSeJ56q1NNnw1JuHDSs+rZx7mIDbkUq4KHNnaSNxsszq9ha12ZE1pgk=
X-Received: by 2002:a4a:58c8:0:b0:5b1:ff93:de40 with SMTP id
 006d021491bc7-5b24d60d1c7mr2278127eaf.5.1715168422279; Wed, 08 May 2024
 04:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com> <2543817.5xW6y1K4kI@bagend>
 <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
In-Reply-To: <CABjd4Yw-JA5=SfcgtVNYZN37hFbqf14Ut1yHTSz1YZiZ3NQ-pw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 8 May 2024 17:10:05 +0530
Message-ID: <CANAwSgTU7UF_RaNnVSZR7SehQqC7Eo6D=JqT11gN7jK2diN_Ug@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
To: Alexey Charkov <alchark@gmail.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On Mon, 6 May 2024 at 18:24, Alexey Charkov <alchark@gmail.com> wrote:
>
> Hello Diederik,
>
> On Mon, May 6, 2024 at 4:29=E2=80=AFPM Diederik de Haas <didi.debian@ckno=
w.org> wrote:
> >
> > Hi,
> >
> > On Monday, 6 May 2024 11:36:33 CEST Alexey Charkov wrote:
> > > This enables the on-chip thermal monitoring sensor (TSADC) on all
> > > RK3588(s) boards that don't have it enabled yet. It provides temperat=
ure
> > > monitoring for the SoC and emergency thermal shutdowns, and is thus
> > > important to have in place before CPU DVFS is enabled, as high CPU
> > > operating performance points can overheat the chip quickly in the
> > > absence of thermal management.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++=
++
> > >  8 files changed, 32 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts index
> > > b8e15b76a8a6..21e96c212dd8 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > @@ -742,6 +742,10 @@ regulator-state-mem {
> > >       };
> > >  };
> > >
> > > +&tsadc {
> > > +     status =3D "okay";
> > > +};
> > > +
> > >  &uart2 {
> > >       pinctrl-0 =3D <&uart2m0_xfer>;
> > >       status =3D "okay";
> >
> > I built a kernel with v3 of your patch set and someone tested it on a R=
OCK 5B
> > 'for me' and it had the following line in dmesg:
> >
> > rockchip-thermal fec00000.tsadc: Missing rockchip,grf property
> >
> > I'm guessing that turned up due to enabling tsadc, but (also) in v4 I d=
idn't
> > see a change wrt "rockchip,grf".
> > Should that be done? (asking; I don't know)
>
> I'm getting the same. Neither the mainline TSADC driver [1], nor the
> downstream one [2] seems to use the grf pointer on RK3588 at all. It
> still works in spite of that warning, although I can't see how (or if)
> it configures the reset mechanism without those GRF registers.
>
> Best regards,
> Alexey
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/thermal/rockchip_thermal.c#n818
> [2] https://github.com/radxa/kernel/blob/stable-5.10-rock5/drivers/therma=
l/rockchip_thermal.c#L961
>

If the following changes fix the warning.

Checking the Rockchip RK3588 TRM V1.0-Part1-20220309.pdf
PMU1GRF_SOC_CON3 which has tsadc_shut_reset_trigger_en bit
to control the Enable TSADC shut reset trigger for DDR fail safe.

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 85c25d5efdad..5490a44e093e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -2662,6 +2662,7 @@ tsadc: tsadc@fec00000 {
                rockchip,hw-tshut-temp =3D <120000>;
                rockchip,hw-tshut-mode =3D <0>; /* tshut mode 0:CRU 1:GPIO =
*/
                rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity
0:LOW 1:HIGH */
+               rockchip,pmu =3D <&pmu1grf>;
                pinctrl-0 =3D <&tsadc_gpio_func>;
                pinctrl-1 =3D <&tsadc_shut>;
                pinctrl-names =3D "gpio", "otpout";

Thanks
-Anand

> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

