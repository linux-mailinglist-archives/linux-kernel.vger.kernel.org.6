Return-Path: <linux-kernel+bounces-439618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51359EB1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5415E1889A63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AC1A76A3;
	Tue, 10 Dec 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es0M8kxO"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD31A0B15;
	Tue, 10 Dec 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837016; cv=none; b=VpwLW28W4Gdz7OcE47vattDSkWrCaY3UkoY1Shv5gqCB1REttJk8ws4gBNirVAxqsP24EwOCzSvhBvTrkLJvGqQYDcNivsO5da1v+GKDt+FnmKNEqSHEwhJM0uS52cj1o8t92WoEYRcOWiZHiy0vIc4ezFxW7b9CND/CTyH7EtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837016; c=relaxed/simple;
	bh=+0sc2vJpmpDbHQqLJIlisp+L98Y+5CueKrPVCJYIBe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm8sPprtioIjb1ZURKj9Wedau7ihn5x4+1EGOAtfC0gGrQ2Zz6Gf/FirD0C2kz6MC3UCF7kaBlcACkiSjDUNQXIvyTCtXr4c46B/iENsEOXShfxpift27vOD9AoDj1Rv0KPgP8XTixdU/DzJbQd5eshBpoPEokkWqVw9PdeEMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es0M8kxO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso5598151a12.1;
        Tue, 10 Dec 2024 05:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837012; x=1734441812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cID+icBwQVZ1cLeVHmwo+pX71ArOF+/a0tJhAyvJi3E=;
        b=Es0M8kxO7VJ21i7AMBxPDbxewSv0RjL5A+pmjW7yWzoDgamafgad+TODW9wB9q7P8t
         FSiJNLzKWt+/6a7g8nKHzRO91tNEan7UZKdjJU5cF6QIvpjpPIp0ETLypUgiEED3PZs+
         Pd8wTmd8O2ZJ8ll5OnsnLwNr7GwZJGklsIeRqay7ilaD6pAJRSOWKmr1keos9PVjbCMZ
         JvPuy6Qf5kAa8eJDfDsAjiFaCtLA4NBfS7hJqDjZhNyC3CD4SjbwxJ25iHWbheAuXjPJ
         uMhFOa82FhgDV63m+GXDPOhF3i/gOEyoHGEMo1ZeK7ZFl5DkmslhOrOMu2aW/TpJIBjE
         E5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837012; x=1734441812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cID+icBwQVZ1cLeVHmwo+pX71ArOF+/a0tJhAyvJi3E=;
        b=Y0nrbFfgOGQg8FyToPWk2rqY57H89sySj1eSYszF81zL3lFhwqBNaWjTAlV8+/5LT0
         uPrEFZGDORasV4AjCCAu6pVL2356yqoHKIbtUA0IeOFsRgWQCOZ7izqykbWHiuShQWMr
         2jOSRmcw6sG1BfGZ9mMvbjXULiUL+cECY5lNDN8g0HMfEMEw/nTj8VD+qngFJBRPRmlz
         XS+vBJe0VLA1yEzAHdiAy7L2KgwUQ3FQEY1ZBAhksnBXsxFjBXow7UKDDK+99cB+T08+
         Hi/HIB93GL3qLgu4zBUsvyOBiipVh8G8ftV41afJa7eGghvfxqDB+laQs4oAYMY2D5P1
         g4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUDjNmIrKoQni02zJyWfgTETT+bB3TAVIwGoYKGOBAs4qjAaNSIRBTVShF+dv/HrLW5bUsGq6GZzzHLUosb@vger.kernel.org, AJvYcCVm43meu/XTNB/cWp60Ge0d9kX/3eju/ibiyPkdz6YlZ1GERL3NcjJLC6T1z8EElWu2BUacfcrxhV1E@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGln8tTEE3NEwe04CvVZa4w49CNh8r/lcFKzywYAEvqoZmtKS
	sOLQnc9l/9t2xP0hjvlkSxZIO/Bhq4BgsFnG8bc8gbhFGqkvdT/Vt7SPlndpo4nZorTsip6iKeD
	zirMCfAd3ux1u3W0Lf911x+AXLX0GMJzIj0k=
X-Gm-Gg: ASbGncscWsjym2ohX0X26DBIR26xvIpI0NxY+mkYdsNCrKG/wsqcmq+FjEV4E5EP/5Z
	jRetUvHcNP/dCclYpaMsU8Df5O9rvNCvAqOgytr2yqjECP+o5BYWuRwsHmtc=
X-Google-Smtp-Source: AGHT+IEiQZp+8ruy21+1lGoFTcEYaNOlU4Ihj6HejgjGDUx9L85LTtGqOVIO6IG1rybYdwfcnDlo7HnORY98CWMtsNI=
X-Received: by 2002:a05:6402:1ecb:b0:5d0:9c3b:faf4 with SMTP id
 4fb4d7f45d1cf-5d41e28eedbmr2927675a12.7.1733837012164; Tue, 10 Dec 2024
 05:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-5-pgwipeout@gmail.com>
 <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org> <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
In-Reply-To: <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 08:23:22 -0500
Message-ID: <CAMdYzYquvGBzfWqvUOku7m1sM9qxmBHAL95cANDViUCT1oEEhQ@mail.gmail.com>
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

On Tue, Dec 10, 2024 at 8:13=E2=80=AFAM Peter Geis <pgwipeout@gmail.com> wr=
ote:
>
> On Tue, Dec 10, 2024 at 5:04=E2=80=AFAM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > Hello Peter,
> >
> > On 2024-12-10 02:30, Peter Geis wrote:
> > > There is a race condition at startup between disabling power domains
> > > not
> > > used and disabling clocks not used on the rk3328. When the clocks are
> > > disabled first, the hevc power domain fails to shut off leading to a
> > > splat of failures. Add the hevc core clock to the rk3328 power domain
> > > node to prevent this condition.
> > >
> > > rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-...=
.
> > > }
> > > 1087 jiffies s: 89 root: 0x8/.
> > > rcu: blocking rcu_node structures (internal RCU debug):
> > > Sending NMI from CPU 0 to CPUs 3:
> > > NMI backtrace for cpu 3
> > > CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
> > > Hardware name: Firefly ROC-RK3328-CC (DT)
> > > Workqueue: pm genpd_power_off_work_fn
> > > pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > > pc : regmap_unlock_spinlock+0x18/0x30
> > > lr : regmap_read+0x60/0x88
> > > sp : ffff800081123c00
> > > x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
> > > x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
> > > x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
> > > x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
> > > x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
> > > x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
> > > x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
> > > x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
> > > x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
> > > x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
> > > Call trace:
> > > regmap_unlock_spinlock+0x18/0x30
> > > rockchip_pmu_set_idle_request+0xac/0x2c0
> > > rockchip_pd_power+0x144/0x5f8
> > > rockchip_pd_power_off+0x1c/0x30
> > > _genpd_power_off+0x9c/0x180
> > > genpd_power_off.part.0.isra.0+0x130/0x2a8
> > > genpd_power_off_work_fn+0x6c/0x98
> > > process_one_work+0x170/0x3f0
> > > worker_thread+0x290/0x4a8
> > > kthread+0xec/0xf8
> > > ret_from_fork+0x10/0x20
> > > rockchip-pm-domain ff100000.syscon:power-controller: failed to get ac=
k
> > > on
> > > domain 'hevc', val=3D0x88220
> > >
> > > Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for
> > > RK3328 SoCs")
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >
> > While I was unable to formally verify this clock assignment,
> > i.e. by using the RK3328 TRM or the downstream kernel source
> > from Rockchip, it makes perfect sense to me.  Thanks for the
> > patch, and please feel free to include:
> >
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>
> It is unfortunate the TRM doesn't include the clock maps, because they
> are extremely helpful when one can acquire them. It also doesn't help
> that the TRM register definition only referred to this as "pll". I was
> sent specifically the usb3 phy clock map for my work on the driver,
> which had the location of each switch and divider along with the
> register and bit that controlled it. That combined with the TRM
> register map allowed me to find this error.
>
> Thanks!
> Peter

Apologies, that's the wrong response for this one.
This patch was the result of educated guess combined with testing. I
grabbed all of the clocks that looked like they could affect things,
then tested them one at a time until I isolated them to this clock. It
lives alone with cpll as the parent and has no children according to
the clock summary. (Though the writeup i mistakenly included above
proves the clock map isn't always accurate).

Thanks,
Peter
>
> >
> > > ---
> > >
> > >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > > index 0597de415fe0..7d992c3c01ce 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > > @@ -333,6 +333,7 @@ power: power-controller {
> > >
> > >                       power-domain@RK3328_PD_HEVC {
> > >                               reg =3D <RK3328_PD_HEVC>;
> > > +                             clocks =3D <&cru SCLK_VENC_CORE>;
> > >                               #power-domain-cells =3D <0>;
> > >                       };
> > >                       power-domain@RK3328_PD_VIDEO {

