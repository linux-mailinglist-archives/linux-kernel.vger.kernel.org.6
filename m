Return-Path: <linux-kernel+bounces-201999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAD8FC661
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224931C22F61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160E18FDCC;
	Wed,  5 Jun 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kr+LCE5W"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED01946A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575959; cv=none; b=kboalkhSEe5YkITMC1h3tgFvlyljukzuGo4QuNR5+y21MD6e8y2vWvaQMMJHyuMGvOp6c41fyXW3DJGlG75fC/zUD2B9bsp2T0MVzhCl32n/E+BB5yuOgCUe9jxgEutKe8+SGYtrhBthzI/OpPNNV/fy9k1M/32/bw9glCjGFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575959; c=relaxed/simple;
	bh=ZGckZDXYZoBdYKxgR4JQZaNiWYJn8XxdnxbJ0v6qLEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUZmOO5UztCnwIPim0EIKqXZHSkEWCPiDNHmonudeJeFA81sfTMXKG0FihBS8pcFQn5bzbT4XenaIZMXm+eIoqxSTOXyC9XnTvdXTcW9Fcyg1btACaH/7GneZb1vVf+VdFRgWEyC6kv/PCxil/Ymu8AuXgWYvUWfA3swTvm136c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kr+LCE5W; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b8d483a08so5602766e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717575956; x=1718180756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTYgiHqEKqI6DY4xUoSYEerbolGYT7sqcHeeQXdfKvE=;
        b=kr+LCE5W69vzIYoovALFjPU8M1t/n5j3jHw9QFGk/3yW0p4L1MyF2/+K6I8H2m+FkC
         8E4NLY9fx9gzwwIrfZ6/eBkGGbCLiPldR6BYqXeDpdMfID7VGjbWc8d23Gm6Sj3bio4U
         7XeORRdpkId5UFFNIwZSle5Rt9gbX5q8qeqsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575956; x=1718180756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTYgiHqEKqI6DY4xUoSYEerbolGYT7sqcHeeQXdfKvE=;
        b=UvK9f/tXJgU7Z2Nap6Vha5cIxQCrLHbgz8AZnVMhZPBk3f16cXguffgtpVoma9FZuF
         s1XbvBVKinedY3KoJB3vVizAx0YnIxHDBMhYX9f1NnVUenOPlNFn2BaOzTC46iTn/pnV
         wBann6J4H9d2jrRwTRumxL+gsLG3DEBa3MUeKDMTtPKk9ii/21lkEcgRfTHCONrmBATC
         CUu+mFA6FgXUb9V19joQNQy2ozWdwHTt14SA1SGA+BNK7DNhprSOKALMsvyubtHapZ+1
         xTiGR2t4F5E8FtkYTLD35BQulHqkORihn8cjNkeGVuzXLq0Cv/UUK2+x4ARpqQT2ai90
         tMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFzBBiOOtj6o+3B9n/hI0kFSc1TqgyQsuVMA0bD5OiVvVRCBQGOC4bLWDRtGSt0q3xoRTHXqC6ntlzmYRkA7LDseEqqbXMUf7xR1kv
X-Gm-Message-State: AOJu0YwMcs8FDP1r7tgVdLZ2De87Izw+CLX/0zJaAkTcMIBwGoCeToZA
	LhD2FYeV4D2TOXOISjfJxmE6CS1tF6nKk5j+boiwvaKb6OrV7XA1eJX1GTf5fhG8qpJPLl8NqfE
	LP9EnvIRIyO3NEyUAO/sj7ZeZmRrlx/DeQ7w4
X-Google-Smtp-Source: AGHT+IEz6cLO0SYpIuAYgl0GIp5y8JoS82uXIYv/gjnD7flwuduPkyTGJYNwDh582C9DE0cOUwen7uBXY5qAmo/W3wY=
X-Received: by 2002:a05:6512:3082:b0:52b:423b:ade2 with SMTP id
 2adb3069b0e04-52bab4b85b8mr1349765e87.3.1717575955882; Wed, 05 Jun 2024
 01:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530083513.4135052-1-wenst@chromium.org> <20240530083513.4135052-6-wenst@chromium.org>
 <4f20f130-c9ab-43ea-a758-e29d7be10db0@collabora.com>
In-Reply-To: <4f20f130-c9ab-43ea-a758-e29d7be10db0@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Jun 2024 16:25:44 +0800
Message-ID: <CAGXv+5GuGz-KahcbKtuyUA1-59sMWSL0QucOdp8FPoQWrc9YUQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power
 domain clock
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:03=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> > The MFG_ASYNC domain, which is likely associated to the whole MFG block=
,
> > currently specifies clk26m as its domain clock. This is bogus, since th=
e
> > clock is an external crystal with no controls. Also, the MFG block has
> > a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the bloc=
k
> > diagram, gates access to the hardware registers. Having this one as the
> > domain clock makes much more sense. This also fixes access to the MFGTO=
P
> > registers.
> >
> > Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.
> >
> > Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain con=
troller")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Just one question... what happens if there's no GPU support at all and th=
is
> power domain gets powered off?
>
> I expect the answer to be "nothing", so I'm preventively giving you my

Well it's powered off by default. Just double checked, and without the fina=
l
patch:

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          children
            performance
    /device                                             runtime status
---------------------------------------------------------------------------=
-------------------
mfg                             off-0
            0
mfg_2d                          off-0
            0
                                                mfg
mfg_async                       off-0
            0
                                                mfg_2d

And with the last patch but with the powervr removed:

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          children
            performance
    /device                                             runtime status
---------------------------------------------------------------------------=
-------------------
mfg_apm                         off-0
            0
mfg                             off-0
            0
                                                mfg_apm
    /devices/platform/soc/13fff000.clock-controller     suspended
            0
mfg_2d                          off-0
            0
                                                mfg
mfg_async                       off-0
            0
                                                mfg_2d

Things seem to work OK. I can SSH in, and the framebuffer console on the sc=
reen
works fine.


Note that accessing the regmap through debugfs doesn't do much good. regmap
doesn't handle runtime PM. And the syscon regmap isn't even tied to a
struct device. Dumping the regmap through debugfs while the power domain
is off gives all zeroes, likely due to bus isolation.

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Thanks!

ChenYu

> ....but if I'm wrong and the answer isn't exactly "nothing", then I still=
 agree
> with this commit, but only after removing the Fixes tag.
>
> Cheers,
> Angelo
>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> > index 3458be7f7f61..136b28f80cc2 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -497,7 +497,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
> >                               };
> >                               mfg_async: power-domain@MT8173_POWER_DOMA=
IN_MFG_ASYNC {
> >                                       reg =3D <MT8173_POWER_DOMAIN_MFG_=
ASYNC>;
> > -                                     clocks =3D <&clk26m>;
> > +                                     clocks =3D <&topckgen CLK_TOP_AXI=
_MFG_IN_SEL>;
> >                                       clock-names =3D "mfg";
> >                                       #address-cells =3D <1>;
> >                                       #size-cells =3D <0>;
>
>

