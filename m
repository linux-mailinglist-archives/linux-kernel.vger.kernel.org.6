Return-Path: <linux-kernel+bounces-320629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D405B970CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F8D1C21C63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D5175D4A;
	Mon,  9 Sep 2024 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="gD7f3s6Q"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB311ACE1F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725859805; cv=none; b=KaoCS6+qVHzsaWbXENoA83Q/k1ItW5jA4PapKqHSAtvm4vCg4LDvQc0ngHiB/PtajHZy5D0kpKgNK8k3w4WjzjQkfvVkG9T0gtbMFM0vL7qlhsaHga8ybpyT8CtOVFYKkvRwbCiIaTbYjEtdsdFybLXe3MctCsLSDdd/5X5Dslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725859805; c=relaxed/simple;
	bh=0MbEq49rTZQvKlNPrqFQwIwg+JdzsRbN95IFNB1yQ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8TqecYyIahiW+cGh/7OfN2CXSn0flLailfWd0nHSOUb59i7a1VDVpRaR+/PA+qwrvtgT91W7euVIRJQ2NGrC2S9BDQd0M+6hfrcgaXVbHOlKexIoWKeXsLwzc9dqiQ4KtlmxouoagGcfnMcvYcivdfiT+d4jm7tO2zqaPKJD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=gD7f3s6Q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so20975021fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725859802; x=1726464602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2ngmaSXcBqewvYTJxzeO329sFBXri/yhAj5w7/Inig=;
        b=gD7f3s6Qb2PVjJNGtvzEqh9qHbdfXJ6SXF/h/4u1ZxinuPjhCRjAE07+BB2R1GoHWu
         C764AToxAKa1IA2q50NBoPDtxjr95uPxAwPFNmqXbDPlK9Ga/rc61i57gZSLqsrhj3Iw
         IChnNhwgaPlBjYfAc+30dxdi0Wzlz/NUWVL5mxuOUJ3u/fm1tI/NUHNLZ0MVRllL1lFc
         A+0l4s611zGPpF9w7Wau0fV7dY2MI/S0jhwfovxN8U+lxnK7jeQVFnb2a2iuKH/8bp8s
         ZLttDOwNmi/LrQTMQd3Lj2a/0xWYZfyl2pemR/Py7yZcimeACbIb1GAcsiSSTmzaC0yk
         CcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725859802; x=1726464602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2ngmaSXcBqewvYTJxzeO329sFBXri/yhAj5w7/Inig=;
        b=jlz8S482RdYw1mVQG/BK2FJ5ZXDXsNkLY0ypuJURSPyJD3CXU/n46OeOfy5NB3xASA
         VEoP2osZR9ctk3ytrn2PUZLj02OL+9CqSdyiUgtpElKPKXsP5PE6oeDRiwubkM2JFjwI
         Pg3XuOMijFihhE0o/V5vIZLikebPYsYcmW+IZkhJ74DGg/Ry6zGkzA1eMT2rCjkmVD1G
         TFK3kPUcNkB2IgyRv2dKjnUvrZGKUqTVQ1Usolecbz/MvaKcS2qXlRNvkLRDi+RqzM5x
         0peS2SilAcRftxhBUadkuZFIAPa3tB5V6V6jQdxCZa9ooBtCDMXVylrjL4vDtBltmVMk
         mGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUJKl+2E8cJOpydxElokQFS/5CNCkyJ5V792XnIToavpuOGDXGBI6H6mkNf1ZT2Gw1HPW83BGVFDt9uUiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTjdJ44gEqcv2bJkP4sYU544mrBEZ8JxihFrkJOnp82/nC0nl
	+4BVLvYwQxq7Zje1butp10sImUL0Erh9KVYjCBcwZfiog1fuFo0D2PZ2FyGdthOzPtYWtKaRQTQ
	kXFCdSgBanbODYcwCzhLptLHUN52weSuhnRB5lQ==
X-Google-Smtp-Source: AGHT+IHltu72PrN7ncZlY52C7Xqomq1WLsnBRUjIxxx0pxPEleRO1qqrTtBPbeEkK9A2Oz54wKSGz/uiIYvo9FfCW9o=
X-Received: by 2002:a2e:be0b:0:b0:2f7:5cf9:46dd with SMTP id
 38308e7fff4ca-2f75cf94792mr37355141fa.45.1725859801484; Sun, 08 Sep 2024
 22:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
 <20240506-tc358775-fix-powerup-v1-9-545dcf00b8dd@kernel.org>
 <CAHgnY3=KCD4gyJ4nL6nN1tvWcsiRQL+Oz11RNOniDdyMoEPcSg@mail.gmail.com> <D3Z9XTBHSUEN.2GW0UCIPLR6HY@kernel.org>
In-Reply-To: <D3Z9XTBHSUEN.2GW0UCIPLR6HY@kernel.org>
From: Daniel Semkowicz <dse@thaumatec.com>
Date: Mon, 9 Sep 2024 07:29:50 +0200
Message-ID: <CAHgnY3=bRyAoDDm8dCuT0z7MaF_LzCa-MDYRqQgKVqgVhFcJjw@mail.gmail.com>
Subject: Re: [PATCH 09/20] drm/bridge: tc358775: remove complex vsdelay calculation
To: Michael Walle <mwalle@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Vinay Simha BN <simhavcs@gmail.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:34=E2=80=AFPM Michael Walle <mwalle@kernel.org> wr=
ote:
>
> Hi Daniel,
>
> > > To cite the datasheet on VSDELAY:
> > >   During DSI link speed is slower than that of LVDS link=E2=80=99s, d=
ata needs
> > >   to be buffer within 775XBG before outputting to prevent data from
> > >   underflow. Register field VPCTRL[VSDELAY] is used to for this purpo=
se
> > >
> > > This driver assumes that the DSI link speed is the pixel clock (as do=
es
> > > every DSI bridge driver), after all the LVDS clock is derived from th=
e
> > > DSI clock. Thus we know for a fact, that the DSI link is not slower t=
han
> > > the LVDS side. Just use the (sane) default value of the bridge and dr=
op
> > > the complicated calculation here.
> >
> > I am not convinced this is a good idea to revert to a default
> > VSdelay value. I tested your patch series with RK3399 platform
> > and default value (5) was not enough there. There was small data
> > underflow visible, resulting in display offset. Removing this patch
> > and using the original calculation formula fixed the problem.
> > The calculated VSDELAY value seems to be a lot bigger than required,
> > but keeps us on the safe side.
>
> Did you use just parts of this series or did you port the "lp11
> notify" mechanism to the rk3399 platform? Please keep in mind, that
> this bridge doesn't really work if the reset isn't deasserted during
> lp-11 mode and lots of odd things happen.

I pulled in your complete series and ported "lp11 notify" to RK3399.
Both reset and standby pins are connected to the bridge on my board.

>
> Also, do you know if you have an EEPROM attached to the bridge or
> does any firmware part initialize that bridge?

The initialization is done only by Linux kernel driver with your patches.

>
> > It looks that hback-porch value for panel is used also on DSI link,
> > effectively delaying hactive data delivered to TC358775 bridge.
> > I suspect this causes the requirement for higher VSDELAY.
>
> It was ages ago since I've worked on this bridge and extensively
> tested and even measured and decoded the DSI link and the LVDS
> stream. But IIRC this delay was only to compensate the difference
> between the DSI clock and the LVDS clock, that is, if you push the
> pixel stream slower into the bridge than the bridge is pushing it
> out to the LVDS panel.
>
> So the back porch should be irrelevant here (?!).

That was also my initial understanding, but for some reason original algori=
thm
for VSDELAY in tc358775 driver, takes blanking period into calculation.
It does not base only on DSI and LVDS clocks.
Additionally, my experiments show that the default value is too low
in my configuration.

>
> -michael

Kind regards
Daniel

