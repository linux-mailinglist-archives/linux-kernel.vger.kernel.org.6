Return-Path: <linux-kernel+bounces-432480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994539E4BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6802916A952
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A037D3F4;
	Thu,  5 Dec 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3asihIp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F923919C;
	Thu,  5 Dec 2024 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362412; cv=none; b=R/aDk2wf1BhLwZUbB/gL5kV7+w1luHjc/ZuUIfKUK6AO+taXcm33dQBwyMcqTE4dXwPekppfAyCmpK3naVnXxjB7DYExDcOd9KWCGwy2cx6azxiHdOUJnvw/OQJhcvS3FcpY81SVvGkUsAzVWUeWMaEgg5V7Oao+rlqDnQdCFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362412; c=relaxed/simple;
	bh=qRcPCJDBsuJwnVcTfEGJv+WNBM2IIrAmERQP49X3/QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9ctXrBKVKF9Ql+CsfLcklLX8unJBIiv1GYmsaRNtcPswSOV7RoVA/2SQxvh9ob+ujjEP2YIxpRZ15QoVycB6cS7Y7AbgwC1WwXdnXFwbJsdJcw5jUM3XCfpJQw5TrtORw27hvesFshTH3lnR8l8c7Tv1KzFiSbhQ07C7Dkmu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3asihIp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so360598a12.0;
        Wed, 04 Dec 2024 17:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733362409; x=1733967209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmY128hLLsZSkLyQnAO+inPpFdU2SYtNdTmH6knAX/U=;
        b=I3asihIpVLJWWzCwS9eTUZtoRSYkj3lkfylW56RcKeGBCmi/qrSVMYSUJd9QngXxim
         mpeVRI+LEc/4wL57CY4lRGUu9PcS1RaBwn4x2uQVTvxZCemKaQu3bbD+IJDkcOcZC8+n
         Ej15mFGxu9lK1bhXqe1zK4IMSHYsGnFjNOaK+4ZUHzVhnmolFYJDxAvTq+KkoDSBg6i9
         A0brwR3gdVQpyUpsE7fEt/tVR8Sxd13PqMT+6FIHyZPvpuQOacvqrPLprISVMuoO4ky8
         S8LMn9GYoPjVwnuXAedK9yvNIUNrKjBr0gVL900ULT+v+QPNXyr6At9RWJGXzFPNotuz
         Q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733362409; x=1733967209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmY128hLLsZSkLyQnAO+inPpFdU2SYtNdTmH6knAX/U=;
        b=r0fO+1Ka1oKNydPPW/5XlfDidcW7/TH9IQ9718/wyW1bQW5j4qr6iLVjt1F4RQ2QEr
         qU96ztsD+jz4Os5HjQkmUyAPRHImQjY7eTbYt6cXkTUk0Q3gODpNIZLrmZRMO3bMjF+c
         esUUY0sY/fBiuz9w1I2t+E3Kox6bMxbFRB6m7DdqQoYrapTMnG/YEfyOUwZwUpLF/iGi
         joolKxwNBmDIutAEKcNIhKIiDloj5KK4GYtH1pGp88ekComUnPB50lGJV8GIgSSxt/V6
         EnrCmtaE82Ol/fHyJvukuP0VT2tTfmR1muVsxh7jRGDR7lKtcM/QTnJS8Av29YbQXgaD
         jUUw==
X-Forwarded-Encrypted: i=1; AJvYcCUZNy+YT+YPWJdOxLN0sT7bMxq0XkcHrMcpKD5xgGvP0Gm/LLB6Y8GZ4LDu617L/otoW8PzODy8mfio@vger.kernel.org, AJvYcCV6HSVMW49r8/m5j6l0Kqo0rMaD5rJQWu3Jmu1BlKGVMWvzskDDpH0wfQulaQ3D4u2uWWRpG59TYKoBsHDu@vger.kernel.org
X-Gm-Message-State: AOJu0YyKs1kBIfKYZQZMHhDqho+9YmAmO0jWOmJFrdtF6sETXLKaTMhi
	K8H4J1osuynnr1iGcJBO2oyyyBOUSPg6pH6i/lrPd7YPn2Ns0yVh8PHBIsRl3ZZh4jPuTVUJZOM
	8J4OpoYggsb3qw+dhiz8RP4vsSHw=
X-Gm-Gg: ASbGncvgEdfwSZmfhjmW8buFHYM85sHPSet0IQtqLUQmr7xg7jZCql07Ca8aBKLlj34
	j5hwQTP9xZ/OYNxncDjyVlBfOm1U8Bo49
X-Google-Smtp-Source: AGHT+IGu14tQuy4YA+pl+VRTeC/EhlZsBCpudHv1pXmMQhBMw4Kj54oDa0ew0+2Yf/3xN1DFUoO8tAA/uR4K5It/c00=
X-Received: by 2002:a05:6402:5106:b0:5d0:feec:e160 with SMTP id
 4fb4d7f45d1cf-5d10cb82702mr6569303a12.22.1733362409228; Wed, 04 Dec 2024
 17:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
 <63b3be80-cb6c-49e5-858f-70fd826140c5@cherry.de> <2578458.4XsnlVU6TS@diego>
In-Reply-To: <2578458.4XsnlVU6TS@diego>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 4 Dec 2024 20:33:17 -0500
Message-ID: <CAMdYzYr9bULWou5gf43G-AywREWRCOhHmJ-fOQ1cEDWJSmGSdQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on rk3399-puma
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Iskander Amara <iskander.amara@theobroma-systems.com>, 
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:58=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
>
> Am Montag, 2. Dezember 2024, 10:52:06 CET schrieb Quentin Schulz:
> > Hi Jakob,
> >
> > On 12/2/24 10:04 AM, Jakob Unterwurzacher wrote:
> > > During mass manufacturing, we noticed the mmc_rx_crc_error counter,
> > > as reported by "ethtool -S eth0 | grep mmc_rx_crc_error" to increase
> > > above zero during nuttcp speedtests.
> > >
> > > Cycling through the rx_delay range on two boards shows that is a larg=
e
> > > "good" region from 0x11 to 0x35 (see below for details).
> > >
> >
> > Is this missing a "there" after that? "that there is a large good regio=
n"?

That large good region is actually an eye that you are aligning to the
clock signal. The board is on the tail end of the eye where it is
barely working. This value is supposed to be tuned to be in the middle
of that eye. You may want to test the old boards against the new
boards, because if the original board was tuned correctly something
may have changed in hardware that caused a significant shift in the
eye location. Examples of this would be changing to a new phy,
enabling phy delays, or changes in the trace length. If this is the
case, you'll probably want to make a new variant of the dts to cover
this.

> >
> > > This commit increases rx_delay to 0x11, which is the smallest
> > > possible change that fixes the issue we are seeing on the KSZ9031 PHY=
.
> > > This also matches what most other rk3399 boards do.
> > >
> > > Tests for Puma PCBA S/N TT0069903:
> > >
> > >     rx_delay mmc_rx_crc_error
> > >     -------- ----------------
> > >     0x09 (dhcp broken)
> > >     0x10 897
> > >     0x11 0
> > >     0x20 0
> > >     0x30 0
> > >     0x35 0
> > >     0x3a 745
> > >     0x3b 11375
> > >     0x3c 36680
> > >     0x40 (dhcp broken)
> > >     0x7f (dhcp broken)
> > >
> > > Tests for Puma PCBA S/N TT0157733:
> > >
> > >     rx_delay mmc_rx_crc_error
> > >     -------- ----------------
> > >     0x10 59
> > >     0x11 0
> > >     0x35 0
> > >
> > > Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> >
> > This would be a candidate for backporting I believe.
> >
> > Therefore, a
>
> also please include a
>
> Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
>
> > Cc: <stable@vger.kernel.org>
> >
> > here would have been nice (in the commit log), c.f.
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
select-the-recipients-for-your-patch
> >
> > > ---
> > >   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm=
64/boot/dts/rockchip/rk3399-puma.dtsi
> > > index 9efcdce0f593..13d0c511046b 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > > @@ -181,7 +181,7 @@ &gmac {
> > >     snps,reset-active-low;
> > >     snps,reset-delays-us =3D <0 10000 50000>;
> > >     tx_delay =3D <0x10>;
> > > -   rx_delay =3D <0x10>;
> > > +   rx_delay =3D <0x11>;
> >
> > While at it, we could reorder this alphabetically and move rx_delay
>
> I would disagree. This is a "fix", so should ideally only do the minimal
> changes to make life of the stable people easier.
>
> Doing this one-line change is way easier to understand than stuff also
> moving around.
>
> Heiko
>
> > between pinctrl-0 and snps,reset-gpio? c.f.
> > https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-s=
tyle.html#order-of-properties-in-device-node
> > rx_delay and tx_delay seem to be vendor-specific but without the vendor
> > prefix, but so is snps,reset-gpio so that should be fine to reorder thi=
s
> > way.
> >
> > Considering we have an option for KSZ9031 on RK3588 Jaguar and RK3588
> > Tiger and the "same" MAC IP is used and that we use the same TXD and RX=
D
> > delay than on RK3399 Puma right now, I guess we would want to check
> > those don't need a change as well? (funnily enough, all RK3588-based
> > boards in 6.12 actually have 0x00 for rx_delay and 0x43/0x44 for
> > tx_delay, except ours which are at 0x10). Not a blocker for this patch
> > though, so:
> >
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > Thanks!
> > Quentin
> >
>
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

