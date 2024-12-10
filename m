Return-Path: <linux-kernel+bounces-439611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002C9EB1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CC8283CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086841A9B2F;
	Tue, 10 Dec 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK26wryR"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624519F12A;
	Tue, 10 Dec 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836452; cv=none; b=F1oe/qG1oEcwGhb2CRu7mwcaGbR0LaegzUb0MUhrsNAzpxWpZ9jza7F48lceeZt7v24ZkvGOdVXNwZeTV2ODl4cCVY6cTSqo+mA5/7qnZfUnIxfooI84A4W7DWD0qcihM88PYdn9RG/7dLjoc2E7QnqOMRoIDWOcPt0Ath91e24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836452; c=relaxed/simple;
	bh=pR/jOhfZzi6/RPTLrri7j4xcKZp+ZIOVLDQOiGBiehg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNnxq20qOvdWD9yAjOdo08nw0a3eCS88MlwnoR/yPkzYSngJ6lsWWv/AFVFIwa0xFMB7HcFFhArOCbE5mKjzgCljqkldEE9iX7d2VR3zsAdNfpBQM+8nI6jWe5Dw85yM0T83zUSQPgozX0flzMfANwC/i+sVZF38cR3Mg8i66co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK26wryR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so6337301a12.3;
        Tue, 10 Dec 2024 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733836449; x=1734441249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTo1WlZxDcXuwYlzN2yAn2e/Fnhdn41jTbwJ9a++r3U=;
        b=VK26wryReCkc10/+KyTBwax4Jh0UBWtoylqBW8K0d44aldkjtl1Slj+NiBs0tY7Yd6
         CUBGYcMYTB735tE+4rjuJS/akiso/wnwAWgaOaMtlp9agOwb0wuP3+8k+0jCWLxgrHxi
         9iNJEZsXnGFuqLm48ItgYXWZXRgYnnzekHvW7t4pUkX3o+qtZxYJftFzfltDmQlT2uI8
         pVxIembKjBrQBiRYawSuQYsO4OS0oTM8LCzV3vY/U7zhejB9LHUhhk2azRmRLzunaai/
         i6XLT67EBkXtacc5t/OEJ8cjFM9K0v4qgDrxV1p2v/mMAcqq0efjtT4LnzTBdzMc/7Zw
         MjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733836449; x=1734441249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTo1WlZxDcXuwYlzN2yAn2e/Fnhdn41jTbwJ9a++r3U=;
        b=UexARQEBIqgr9LctoKgTsDg1PDxKj0FuXGnVTCgKyLvcN0ah92oGDSg2M039uNEe2Q
         syWe+rgkALngYC/p/RStccuZHVCZuo8froL1CU6TwBiU/l8JY/pxIGYUPuK9LWRe/p75
         J3idq493KQHOs+4AG3Ooom3YeUx+Oi1k06HmBYY9JkraHvXiCP9SBWwHh+1QvzHUavfG
         rdnWNfpnBaSdMGiHE0BKQTeDprgvMqm40lOxThkaa0Nmo0L/FAy3BCu00WgAVzsRHxgq
         mK8HDrfyzxHVd/rXnQPzxCOBI6gXR5nMqg0qJ8/vrppuYglBszU9bbpQ9VCq0SWavNln
         A/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVmt2d38FkxwkJJt//9E2+PjaaZD0xtzhA5PuzY8BqbrCIFJeIrVZc6DSb8FpxWl5R+H8qpUouXlDC8@vger.kernel.org, AJvYcCXLgH9tNc+b03W+zUubB/UUrnW0vls7bC1CfdQOugevWiLVx4S3hbtIsZCWvZScxB5sDpk7WhjebCr1ZTSa@vger.kernel.org
X-Gm-Message-State: AOJu0YyfI65zhqi3vk+gzM4Ms6BRA2d8LYIaZhqbWXlkOEJsaRk8AnbA
	DdEICAyvMyV9JbFCNw9ZL9eIFuH/LHHx/9oQefHilwMMfGUJ4d7UEXEPG8Jh4h1K3d5ixTtxpWQ
	oZdySqQbuPCsUV0dP7ut6tZFA4lE=
X-Gm-Gg: ASbGncu+97Y3FMXlIG+K8mLXhS3edwlotB5OIvbeDq9trHK4qIwWloyupiFr7jBGc1o
	NbYsWT5l6niEVsV8lFkDuK6SksDLPInFDzRc1FIwF16hNPPBNmyQ57uVGH1E=
X-Google-Smtp-Source: AGHT+IHVzXa45twYUZopjBlz3Jtr4P+Wzu5Go0KaAZG4d/AM8XCVGszRXr/gWupt2mkcpi97dJ9ZGq0TBZUR5kCx85s=
X-Received: by 2002:a05:6402:350f:b0:5d0:b455:36ad with SMTP id
 4fb4d7f45d1cf-5d4185faa5emr5425785a12.27.1733836448713; Tue, 10 Dec 2024
 05:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-5-pgwipeout@gmail.com>
 <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org>
In-Reply-To: <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 08:13:59 -0500
Message-ID: <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to rk3328
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	shironeko <shironeko@tesaguri.club>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:04=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Peter,
>
> On 2024-12-10 02:30, Peter Geis wrote:
> > There is a race condition at startup between disabling power domains
> > not
> > used and disabling clocks not used on the rk3328. When the clocks are
> > disabled first, the hevc power domain fails to shut off leading to a
> > splat of failures. Add the hevc core clock to the rk3328 power domain
> > node to prevent this condition.
> >
> > rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-....
> > }
> > 1087 jiffies s: 89 root: 0x8/.
> > rcu: blocking rcu_node structures (internal RCU debug):
> > Sending NMI from CPU 0 to CPUs 3:
> > NMI backtrace for cpu 3
> > CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
> > Hardware name: Firefly ROC-RK3328-CC (DT)
> > Workqueue: pm genpd_power_off_work_fn
> > pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : regmap_unlock_spinlock+0x18/0x30
> > lr : regmap_read+0x60/0x88
> > sp : ffff800081123c00
> > x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
> > x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
> > x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
> > x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
> > x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
> > x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
> > x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
> > x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
> > x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
> > x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
> > Call trace:
> > regmap_unlock_spinlock+0x18/0x30
> > rockchip_pmu_set_idle_request+0xac/0x2c0
> > rockchip_pd_power+0x144/0x5f8
> > rockchip_pd_power_off+0x1c/0x30
> > _genpd_power_off+0x9c/0x180
> > genpd_power_off.part.0.isra.0+0x130/0x2a8
> > genpd_power_off_work_fn+0x6c/0x98
> > process_one_work+0x170/0x3f0
> > worker_thread+0x290/0x4a8
> > kthread+0xec/0xf8
> > ret_from_fork+0x10/0x20
> > rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack
> > on
> > domain 'hevc', val=3D0x88220
> >
> > Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for
> > RK3328 SoCs")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>
> While I was unable to formally verify this clock assignment,
> i.e. by using the RK3328 TRM or the downstream kernel source
> from Rockchip, it makes perfect sense to me.  Thanks for the
> patch, and please feel free to include:
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

It is unfortunate the TRM doesn't include the clock maps, because they
are extremely helpful when one can acquire them. It also doesn't help
that the TRM register definition only referred to this as "pll". I was
sent specifically the usb3 phy clock map for my work on the driver,
which had the location of each switch and divider along with the
register and bit that controlled it. That combined with the TRM
register map allowed me to find this error.

Thanks!
Peter

>
> > ---
> >
> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > index 0597de415fe0..7d992c3c01ce 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > @@ -333,6 +333,7 @@ power: power-controller {
> >
> >                       power-domain@RK3328_PD_HEVC {
> >                               reg =3D <RK3328_PD_HEVC>;
> > +                             clocks =3D <&cru SCLK_VENC_CORE>;
> >                               #power-domain-cells =3D <0>;
> >                       };
> >                       power-domain@RK3328_PD_VIDEO {

