Return-Path: <linux-kernel+bounces-523773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E438A3DB07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D160E172A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08991F8BCD;
	Thu, 20 Feb 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ns3ipbYl"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE71F8BBC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057238; cv=none; b=A+MFqdWMw2kygd04lRPvGP0tlzYnn49BrUF7N4/hyHvvnoglq7JQ3O7NBGAGygHl6DDyrk9NlLOPppR/wskeZcARUCdEpvyu6XZWzqmUZIGrs5n8Cv9m0U2ddeLwRezFXb4OcaqWZ3xw45RCHoW4O+3dHUk1wCDoPFK3vEfAe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057238; c=relaxed/simple;
	bh=9ijn63HF64nQk2zocbTH8lxmdhu1VHApMzIydIPUSKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3dP+zzH5dmkkQ5x6M7kKrShr3XEAzsbjNjwuLFm6F6xfS1A4UhMu4g2Xkaj4dB4R+JeV8kLrPjSqySbTe9ZOfiA0Dt77Uyywevdjd06WWrHSiF/CI1MOGOA/zBBPvB5TS7YhMy46zpQS4yUqE58I2NP46YqUmht0j0qyuHeols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ns3ipbYl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so1068313e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740057234; x=1740662034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kP23GmXhz+sywulZXPihQUzVc7VZ9G8fssRVpByAAE=;
        b=Ns3ipbYlOwhJVp0vlMYjs7AvSrXKlvIPC9pi1QRzSDhsdATMrD/nJ7gO1bYX8/JjC8
         LnEMfrVpWBCpCwgqfVSxaeggwO4uFfcodlyrAl30Qjb3elG5l7h30VdrLd7JYXZ79OjF
         prtJFiUQxyNRPPueOMy4liD7yXNJg1mLS6+l8cGz19rTXv5dfjtxcl7dZHIaMR8ENnLg
         QKImK5uumBAT9ssMmxLSLpEfGO3/Hmq1BwY05Q+PHfXbaLEo8f46+DURV7QARfCNyLWv
         IXluysTbP7fogCmN3w7Xe717fDD5TYU1UWvuaykMyFrHf9nYUpaWnjKNhaXOT2tBs8lA
         BLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057234; x=1740662034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kP23GmXhz+sywulZXPihQUzVc7VZ9G8fssRVpByAAE=;
        b=ZPKh5/OMyswHLh3crXUAABb/7qc6mT70i3yzRkYgU+RaIp+H5XlQG7I43sVwpQ5hje
         M/ZtRhzBeKmSRySKcxlCnsGmh/p87cqOaOTcjhGzMkFThXET81Xa5qJZZT8NcD248m36
         2mrb2E6t/v3anBUFBhut6kXUgkyQtGL/vqqzRncMtBdCo/8dpgOlC4lOBqCTUEiZVTXs
         maV8ZyhMbHgFUzNt/TqSNnbd29sTgGYaMP7Zz14LEUy5A5lRUWzjAne6Cm9LRfzCFCmZ
         jzws+A/M4k7lHB4j+H5ffAhFTA/ANtjiE7LONctzCpC7HmLwiCZU64ySHx0Iqc/7UZ/k
         JzAg==
X-Forwarded-Encrypted: i=1; AJvYcCWrltuFP59ycgE+dnCbpMzMlpUhOfQ3WWtdBR4E3Y4p+X35hrUcycLH/MgjTb6HxQZmtKW5icnz46Hg6fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOffW67vAAB5fvIRLTRqXOXZKqScUNhfK7/oFnQe8PV5l09ae
	oZo3g+8dPXhNIT7ewlH09bI5es+TF9OvHIJOrB1L13NVBK8aY03tEmMXosNL1tzBivJMTYPk+Np
	NJnWXyi5ep6iYix3nKeq0bITE1j7Fa0AXTai60Q==
X-Gm-Gg: ASbGncsN0qcD45mE6F51Cajf/tjUuJs/X0DgFuEqtq3adwtbCbswePzviT8AWbLIcMd
	XGZlNN4cVkLv6PgWAUJpZya/gZJ0MZ5CmhrsE+f4tTcQI+jVtCIbirJ6HPLg3KpDaHvcttDf37P
	aFREYnSr/yY2KdWX7xo9xacpO3rko=
X-Google-Smtp-Source: AGHT+IHocNQMegXnoS3SdZWBkIOVcm92YeUuCqgydRIhhg+HgzWjRnPCtTeV9xmk9c1IYVQ2DlKdIhExGaOChVrgXqI=
X-Received: by 2002:a05:6512:1245:b0:545:40f:575c with SMTP id
 2adb3069b0e04-5462ec7eb71mr3399669e87.0.1740057234366; Thu, 20 Feb 2025
 05:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218160333.605829-1-koichiro.den@canonical.com>
 <20250218160333.605829-2-koichiro.den@canonical.com> <CAMRc=MfmG0okVjV1nH78Aw18dFcoOAZ-UwU-iFc1VKb-BVcTxQ@mail.gmail.com>
 <wyicl2dgxkwxzfwd37cmhgshnqb3phmpeboz3gwqqfmbabaegy@tkjx56nj423u>
In-Reply-To: <wyicl2dgxkwxzfwd37cmhgshnqb3phmpeboz3gwqqfmbabaegy@tkjx56nj423u>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 14:13:42 +0100
X-Gm-Features: AWEUYZkQnndFYARVM4Xt3mn-9dY_JFZlJyjUkA-oUAnjd8Hd-SgXQzBpb8cEcHE
Message-ID: <CAMRc=MdhkiaDs8t9BYveYhy86+svQkHnPxhGx56AMOs=7n9mcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: introduce utilities for synchronous fake
 device creation
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:07=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Thu, Feb 20, 2025 at 12:06:33PM GMT, Bartosz Golaszewski wrote:
> > On Tue, Feb 18, 2025 at 5:04=E2=80=AFPM Koichiro Den <koichiro.den@cano=
nical.com> wrote:
> > >
> > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > platform device, wait for probe completion, and retrieve the probe
> > > success or error status synchronously. With gpio-aggregator planned t=
o
> > > adopt this approach for its configfs interface, it's time to factor
> > > out the common code.

[snip]

> > > +void dev_sync_probe_init(struct dev_sync_probe_data *data)
> > > +{
> > > +       memset(data, 0, sizeof(*data));
> > > +       init_completion(&data->probe_completion);
> > > +       data->bus_notifier.notifier_call =3D dev_sync_probe_notifier_=
call;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_sync_probe_init);
> > > +
> > > +int dev_sync_probe_register(struct dev_sync_probe_data *data,
> > > +                           struct platform_device_info *pdevinfo)
> > > +{
> > > +       struct platform_device *pdev;
> > > +       char *name;
> > > +
> > > +       name =3D kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevi=
nfo->id);
> >
> > pdevinfo->id is a signed integer
> >
> > I'm also wondering if we could avoid the allocation here and keep on
> > using snprintf() like in the existing drivers? On the other hand,
> > memory is cheap so no big deal.
>
> Are you assuming the following change?
>
>    struct dev_sync_probe_data {
>           struct platform_device *pdev;
>   -       const char *name;
>   +       char name[32];
>
>           /* Synchronize with probe */
>           struct notifier_block bus_notifier;
>

No, I was thinking about a local buffer in the notifier handler, like
what we do currently in gpio-sim, but no worries, you can keep it this
way.

> >
> > > +       if (!name)
> > > +               return -ENOMEM;
> > > +
> > > +       data->driver_bound =3D false;
> > > +       data->name =3D name;
> > > +       reinit_completion(&data->probe_completion);
> > > +       bus_register_notifier(&platform_bus_type, &data->bus_notifier=
);
> > > +
> > > +       pdev =3D platform_device_register_full(pdevinfo);
> > > +       if (IS_ERR(pdev)) {
> > > +               bus_unregister_notifier(&platform_bus_type, &data->bu=
s_notifier);
> > > +               kfree(data->name);
> >
> > We could probably simplify it by using __free(kfree) with the name
> > variable and just setting it at the end with no_free_ptr().
>
> platform_device_register_full() call path might finish probe so before
> calling it, we need to make sure the 'name' is filled in. That's why I
> didn't used __free(kfree).
>

Not sure I understand this. Would you mind rephrasing?

Bart

