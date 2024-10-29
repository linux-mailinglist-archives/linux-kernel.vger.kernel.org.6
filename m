Return-Path: <linux-kernel+bounces-386245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0C9B40F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE31B226A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9D1F9A99;
	Tue, 29 Oct 2024 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktnPYQxR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC211E0DA7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171715; cv=none; b=hCVz3loSkkkFs/nrWdC5l7ZNt+5ozrMwNupIl3QekRKuyaFdOKo0Ljruh/FSu5UBEfcus4Q0rW5vRnH3QN+j0EtDJwQwIpGpbAcayiAkxRSwK9F7M6WapVTpssRxrozAVpOSiXkxQSk9QcO5sviZN8KPeJK74F6L2h9Wd2YlxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171715; c=relaxed/simple;
	bh=Xv0YzA0UkRLy0ZJYZoi95BnkLvdKfs8R03HLHBBj1Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQrONqrlpE2xobwsNEbsWWdJxceAFkRD28+wuUgxZIlvh4bEZxC0tqmu3OZ+BKSpoB/rWJaEn38k5sDAz/8oocAuCihK4cGm2/LegiI1s0G2efGkmWBsqyEyU+s0ZTdi5uYa7Ib/3Cx7Baa8L47kZDngvTp89QuvS813FHo0twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ktnPYQxR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53b1fbb8be5so4866884e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730171711; x=1730776511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwCHZzOi2IxF0273uCz1RBIIGqQ3HHsLcLh3T1vj37E=;
        b=ktnPYQxRaETTCNlfRvsCodfxKOfpTlxz5YuTg7mGCg2/Yj03+r2y+M/cMuQbfslQpE
         MleCHDlQBzYPTiUt/rDbAm+1lyipdINOgyqe4YZt4HBy40yNr3p7HXuzpO2bcM6b95aX
         9ytQOAutkUPSwGCd4aYxgalhAHrFuwLYxlO+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730171711; x=1730776511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwCHZzOi2IxF0273uCz1RBIIGqQ3HHsLcLh3T1vj37E=;
        b=YIIUAASdFG8et7dpuXb6XcJD6tJZHhxwBynU+eK/1bNDG2RCmkH4ocf0qA/jlNoSmz
         CzP1dr4ecmGB7lQhoij/D/H5OUaO5jOFcFS3qmtrCz6LAMc/kEvkWEatp4H4AA/W5p6x
         ZHi79dqThyBfxYM//U3s5NMYW8oWjBa8WKb9jjVfTJ5SvK6uYN8k2UtEn+5j1BCeoj0r
         PqNbY922jn+y2ktlyejQc5TNS+/JvaxTGuQ3uvyLWIHVv9feZj5hhV1EdRibTwnniLs5
         zqpqBr2vEu/+hPz0OO6XAZNvKE2fhI5UqUp18RJlSxxMR8KCxt4QlPPf0FqBek1oSN4b
         KZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDR2FE1rxUz+USaq4EyW9Rmacf2EaG6LXCI/jNpiHR1ivhiDeJa9yLA/Siq2qDR7Ibc7U1b+8YhKWdLJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkjL4p4EJ0NAUfRibFCF43qNBj3Uc9hEwPZmpAg3NReeZhY4D
	ICeEypn424ZU7iB2Rjfy4XxueirUmW1WyNOKTZwg151hjY7jhrA1LkARPS0XdBLkyDwAKNDKfsx
	3o3+qD5dqxOm/BntFpd/sxcuwhjpZ6RYXijO6
X-Google-Smtp-Source: AGHT+IE/PeX5d+WkadX6mrq9k/9kf941Iyu+kJldmFZ1nqsFjejU2v3e96UXSMIqxJKvoz+7XYik6OvMSya72Oe1z6c=
X-Received: by 2002:a05:6512:3ca4:b0:539:edc9:7400 with SMTP id
 2adb3069b0e04-53b4927d0c1mr147190e87.20.1730171711103; Mon, 28 Oct 2024
 20:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018073139.1268995-1-wenst@chromium.org> <20241028171901.2484882-1-daniel.lezcano@linaro.org>
 <be7ad677-f7e3-4eab-8b7e-1c375eed3ef7@linaro.org>
In-Reply-To: <be7ad677-f7e3-4eab-8b7e-1c375eed3ef7@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 29 Oct 2024 11:14:59 +0800
Message-ID: <CAGXv+5F8Ga8DF-G4-RtkpQA4b34QtYn8z1WGkSeMtfUkVApNpg@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: support thermal zones w/o trips subnode
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, Icenowy Zheng <uwu@icenowy.me>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:23=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/10/2024 18:19, Daniel Lezcano wrote:
> > From: Icenowy Zheng <uwu@icenowy.me>
> >
> > Although the current device tree binding of thermal zones require the
> > trips subnode, the binding in kernel v5.15 does not require it, and man=
y
> > device trees shipped with the kernel, for example,
> > allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, stil=
l
> > comply to the old binding and contain no trips subnode.
> >
> > Allow the code to successfully register thermal zones w/o trips subnode
> > for DT binding compatibility now.
> >
> > Furtherly, the inconsistency between DTs and bindings should be resolve=
d
> > by either adding empty trips subnode or dropping the trips subnode
> > requirement.
> >
> > Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > [wenst@chromium.org: Reworked logic and kernel log messages]
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> > Link: https://lore.kernel.org/r/20241018073139.1268995-1-wenst@chromium=
.org
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> In order to fix a conflict when merging this patch I did the following
> changes. Let me know if you [dis]agree with the changes

Looks fine to me.

Thanks
ChenYu

> This change will go through the 'fixes' branch, so for v6.12
>
> Thanks
>
> > ---
> >   drivers/thermal/thermal_of.c | 21 ++++++++++-----------
> >   1 file changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index a4caf7899f8e..07e09897165f 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -99,18 +99,15 @@ static struct thermal_trip *thermal_of_trips_init(s=
truct device_node *np, int *n
> >       struct device_node *trips;
> >       int ret, count;
> >
> > +     *ntrips =3D 0;
> > +
> >       trips =3D of_get_child_by_name(np, "trips");
> > -     if (!trips) {
> > -             pr_err("Failed to find 'trips' node\n");
> > -             return ERR_PTR(-EINVAL);
> > -     }
> > +     if (!trips)
> > +             return NULL;
> >
> >       count =3D of_get_child_count(trips);
> > -     if (!count) {
> > -             pr_err("No trip point defined\n");
> > -             ret =3D -EINVAL;
> > -             goto out_of_node_put;
> > -     }
> > +     if (!count)
> > +             return NULL;
> >
> >       tt =3D kzalloc(sizeof(*tt) * count, GFP_KERNEL);
> >       if (!tt) {
> > @@ -133,7 +130,6 @@ static struct thermal_trip *thermal_of_trips_init(s=
truct device_node *np, int *n
> >
> >   out_kfree:
> >       kfree(tt);
> > -     *ntrips =3D 0;
> >   out_of_node_put:
> >       of_node_put(trips);
> >
> > @@ -401,11 +397,14 @@ static struct thermal_zone_device *thermal_of_zon=
e_register(struct device_node *
> >
> >       trips =3D thermal_of_trips_init(np, &ntrips);
> >       if (IS_ERR(trips)) {
> > -             pr_err("Failed to find trip points for %pOFn id=3D%d\n", =
sensor, id);
> > +             pr_err("Failed to parse trip points for %pOFn id=3D%d\n",=
 sensor, id);
> >               ret =3D PTR_ERR(trips);
> >               goto out_of_node_put;
> >       }
> >
> > +     if (!trips)
> > +             pr_info("No trip points found for %pOFn id=3D%d\n", senso=
r, id);
> > +
> >       ret =3D thermal_of_monitor_init(np, &delay, &pdelay);
> >       if (ret) {
> >               pr_err("Failed to initialize monitoring delays from %pOFn=
\n", np);
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

