Return-Path: <linux-kernel+bounces-440237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D070A9EBA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D61283DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F822687D;
	Tue, 10 Dec 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9UeTwCu"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7278633A;
	Tue, 10 Dec 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861122; cv=none; b=YLDZEn0dff92SaTHirKNQI3IvWSKP3sf0WkF8ED/qlZ34hOpPzJbZPEIR1kc1C95BotacnVtVb1yMZYNEq5zKCGG3Fkou08Fq28GXH5LXMfO3f59NzD7O95qGHFBE1wBMKjBTFtIEvy1jQngbQU2I8EONYckGxMVxIlUg8yK8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861122; c=relaxed/simple;
	bh=l9Vj+MYUKR/x/ZRfUg51kg5nhfCcdc6BT83g53WrWtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE+qXCAIkBgWbgbH45k6ex90KutNMJeqjlcGyKtJRSYKeF91ctpt4+TI32ZqIKMeRC68zBnoZ8NJJcsIc66j2NMTHJ1nxn0/7VRM6kw5gOEbGp3jWMaiDU7ThEvta83s4yW+hYAc9oZtYGwDqPeDz5iKaYmbo8SQ8fpW5pQRIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9UeTwCu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so9393225a12.3;
        Tue, 10 Dec 2024 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733861118; x=1734465918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvOUnECdlIn1ZlNZEhyx+pBSjKFbbeY5fNNgTUdmNT8=;
        b=W9UeTwCufko1+4hrRsNgT7GLLaibI5bWzstn+s3Lw0Cu8jB5L7c3eXPdrxpLtrslbv
         ZfZ9cJLvd4TP0gBvm1C68pY+ii370A1xvpeJsA9o586SRtmvoBTFupM65SGiizJtjCkh
         K+d1LgIO690u407ns+E/C6l9VBTtjeltoko6OX5BRn6pPyMm/Y1YYNKpLtX/sT3EpyQN
         hQznnC//idQSWaBy3NkltDn4XkXzQAkD5DK+P7OIgQJqyvLXfCwcZnosC2ROqSVvyh9V
         mbbu+yjiO7kHNwhy6v8cYsBzp1b1s33EXPYhifUUKaCjl123CwbEF12oEKH5cZnDKBJg
         s5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861118; x=1734465918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvOUnECdlIn1ZlNZEhyx+pBSjKFbbeY5fNNgTUdmNT8=;
        b=VfGrEvly0qH/RWlDbIAx4NSB9xmuFz/zs99ZVP6VvICt+OdJsEw8832uTnxnbg/8tz
         NNQWe17ra8DGSFmd394cKqRaAdziJ7B+uq9J5lQYGLj+OuHH1H4Ia5X2hpDvtDvO/3I2
         NoFFwXwGwv1Je0s0cYkXIDGekYUr3X2Xc8tBzWhltmuTias4SomEybJ7AxoIx3OgWzWt
         tx+ZlXV1VSbaN3TBRtp3KVoV1nEyyktbydNcxhdXrMc3DLw25e7fJprAw5cYug6tDaKS
         4MwuK7fAXCCVnhvsYigUWwgstaRQ6Ye0ump0mJMz+oAJ0DUclCDkxWISj/Pec5f7r/DJ
         9pSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Uce/xK55bT4NmlYItICPe9oGaoxw3Vbyaa91pyoZcrm03uUv40kOsIDgnBZgO+PmrYIASJ1YpS+tSE+/@vger.kernel.org, AJvYcCW2/uMdLdDiO7KeyAv65RltCEtKFoC6JRjeU7AWIW3GeJpZoHkycKsyAJ5Qf2lDg+AZOVrtTVcJCWdi@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf0vOKaCJiJW8Jl4etBcILfonkaSU2LupNmxjK1CYTn2muHeb
	YRpf5d4gTKeSA1Hym/vVQ/9BEj6NfOgSCa5AcbaZY6Jevq15SKrP/rWdcXTlhoxQ3OFou6p7j8f
	71omzeqNbzdKNyv7b50n0f3xI6bI=
X-Gm-Gg: ASbGncvaoCbeA8vYV5jdqYo84agA5UXI78K5LoABt3qf09yGECW6EZQvDxeJEc8y+DQ
	+g+Np+eTzffAvyST9CSSfaq7kPjdtpVRtMXCB
X-Google-Smtp-Source: AGHT+IFXkkrhAuSsavIGEUxkwwkvaOjiLlKI5DmTFQ4zUXjuGwhzJrOwW6849qTMFET6yYHEDJESNadpe3rp2SbLEgg=
X-Received: by 2002:a05:6402:26c5:b0:5d1:f009:925e with SMTP id
 4fb4d7f45d1cf-5d4330aa586mr85600a12.16.1733861118221; Tue, 10 Dec 2024
 12:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-5-pgwipeout@gmail.com>
 <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org> <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
 <CAMdYzYquvGBzfWqvUOku7m1sM9qxmBHAL95cANDViUCT1oEEhQ@mail.gmail.com>
 <8c604ada27457698ad6d33d22a39b45a@manjaro.org> <f16b3688-91e1-4760-ac2b-ce53db98ed68@kwiboo.se>
In-Reply-To: <f16b3688-91e1-4760-ac2b-ce53db98ed68@kwiboo.se>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 15:05:06 -0500
Message-ID: <CAMdYzYoGo=dLag30Dp3p8xzrqvb0peB7Oke=zKR-9qbaTns+zQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to rk3328
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Johan Jonker <jbx6244@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, shironeko <shironeko@tesaguri.club>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:05=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Peter,
>
> On 2024-12-10 14:53, Dragan Simic wrote:
> > Hello Peter,
> >
> > On 2024-12-10 14:23, Peter Geis wrote:
> >> On Tue, Dec 10, 2024 at 8:13=E2=80=AFAM Peter Geis <pgwipeout@gmail.co=
m> wrote:
> >>> On Tue, Dec 10, 2024 at 5:04=E2=80=AFAM Dragan Simic <dsimic@manjaro.=
org>
> >>> wrote:
> >>>> On 2024-12-10 02:30, Peter Geis wrote:
> >>>>> There is a race condition at startup between disabling power domain=
s
> >>>>> not
> >>>>> used and disabling clocks not used on the rk3328. When the clocks a=
re
> >>>>> disabled first, the hevc power domain fails to shut off leading to =
a
> >>>>> splat of failures. Add the hevc core clock to the rk3328 power doma=
in
> >>>>> node to prevent this condition.
> >>>>>
> >>>>> rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-.=
...
> >>>>> }
> >>>>> 1087 jiffies s: 89 root: 0x8/.
> >>>>> rcu: blocking rcu_node structures (internal RCU debug):
> >>>>> Sending NMI from CPU 0 to CPUs 3:
> >>>>> NMI backtrace for cpu 3
> >>>>> CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
> >>>>> Hardware name: Firefly ROC-RK3328-CC (DT)
> >>>>> Workqueue: pm genpd_power_off_work_fn
> >>>>> pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >>>>> pc : regmap_unlock_spinlock+0x18/0x30
> >>>>> lr : regmap_read+0x60/0x88
> >>>>> sp : ffff800081123c00
> >>>>> x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
> >>>>> x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
> >>>>> x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
> >>>>> x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
> >>>>> x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
> >>>>> x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
> >>>>> x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
> >>>>> x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
> >>>>> x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
> >>>>> x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
> >>>>> Call trace:
> >>>>> regmap_unlock_spinlock+0x18/0x30
> >>>>> rockchip_pmu_set_idle_request+0xac/0x2c0
> >>>>> rockchip_pd_power+0x144/0x5f8
> >>>>> rockchip_pd_power_off+0x1c/0x30
> >>>>> _genpd_power_off+0x9c/0x180
> >>>>> genpd_power_off.part.0.isra.0+0x130/0x2a8
> >>>>> genpd_power_off_work_fn+0x6c/0x98
> >>>>> process_one_work+0x170/0x3f0
> >>>>> worker_thread+0x290/0x4a8
> >>>>> kthread+0xec/0xf8
> >>>>> ret_from_fork+0x10/0x20
> >>>>> rockchip-pm-domain ff100000.syscon:power-controller: failed to get =
ack
> >>>>> on
> >>>>> domain 'hevc', val=3D0x88220
> >>>>>
> >>>>> Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for
> >>>>> RK3328 SoCs")
> >>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >>>>
> >>>> While I was unable to formally verify this clock assignment,
> >>>> i.e. by using the RK3328 TRM or the downstream kernel source
> >>>> from Rockchip, it makes perfect sense to me.  Thanks for the
> >>>> patch, and please feel free to include:
> >>>>
> >>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >>>
> >>> It is unfortunate the TRM doesn't include the clock maps, because the=
y
> >>> are extremely helpful when one can acquire them. It also doesn't help
> >>> that the TRM register definition only referred to this as "pll". I wa=
s
> >>> sent specifically the usb3 phy clock map for my work on the driver,
> >>> which had the location of each switch and divider along with the
> >>> register and bit that controlled it. That combined with the TRM
> >>> register map allowed me to find this error.
> >>
> >> Apologies, that's the wrong response for this one.
> >
> > No worries.
> >
> >> This patch was the result of educated guess combined with testing. I
> >> grabbed all of the clocks that looked like they could affect things,
> >> then tested them one at a time until I isolated them to this clock. It
> >> lives alone with cpll as the parent and has no children according to
> >> the clock summary. (Though the writeup i mistakenly included above
> >> proves the clock map isn't always accurate).
> >
> > I see, thanks for all your work on this patch!  It surely took quite
> > a lot of time to perform all the testing.
> >
> >>>>> ---
> >>>>>
> >>>>>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>>>> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>>>> index 0597de415fe0..7d992c3c01ce 100644
> >>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>>>> @@ -333,6 +333,7 @@ power: power-controller {
> >>>>>
> >>>>>                       power-domain@RK3328_PD_HEVC {
> >>>>>                               reg =3D <RK3328_PD_HEVC>;
> >>>>> +                             clocks =3D <&cru SCLK_VENC_CORE>;
>
> Do we also need to include one or all of the following clocks?
>
> According to Fig. 3-6 RK3228H Clock Architecture Diagram 5 following
> clocks point to the H265 block:
>
> S51_6 (4PLL) / G6_3 / S51_0 (DivFree 1~32) / D4 ---- aclk_h265
>                                                  \-- pclk_h265
> S51_14 (4PLL) / G6_4 / S51_8 (DivFree 1~32) / D4 - clk_venc_core
> S52_14 (4PLL) / G6_7 / S52_8 (DivFree 1~32) / D4 - clk_venc_dsp

Good Afternoon,

Thanks for asking! If we were implementing the full encoder, probably.
However even with all the clocks enabled currently the encoder hard
locks the board if we touch it. For now adding just the SCLK_VENC_CORE
is enough to enable control of the power domain.

Very Respectfully,
Peter Geis

>
> Regards,
> Jonas
>
> >>>>>                               #power-domain-cells =3D <0>;
> >>>>>                       };
> >>>>>                       power-domain@RK3328_PD_VIDEO {
>

