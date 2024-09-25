Return-Path: <linux-kernel+bounces-339593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7D986765
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E997D2850EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2914600F;
	Wed, 25 Sep 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9FgP/7N"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4641459E0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294722; cv=none; b=RTKqfhps8NfZ6FKAgbw/fKHr8rQCz80ksx4DPTK8s6RSx38GlUfhGN4vvD/igy/qVngirF3D/Xau+OaQYGV+yzirt1wsZ3tD/T4ld+mgKi9CkKZLCF73kEKhfvqG0ti4IGJr2SdAb7NJdZOWi4jjlQ1XZwD0LTOtRuI8cVs2ZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294722; c=relaxed/simple;
	bh=YeblqJYwm2BtjWpPCooiZuze5OgFV3qFGUvUKNxIth4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmqd+FvDb+zEoSGpjmtW8BtQWXOoOmb1WxL5FXR62zZysCQFChLzNY2G0F558z38WU/BVJuk2wawf/Df2o6GLaxMycC06dRZpMPbdX08H+GfovUqlKndZ5MG8Pl2E8EnCo7uy/cPSDabiULHBeTOM2Mt0T/n24AJ6gAVq02H0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N9FgP/7N; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e7b121be30so139046a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727294720; x=1727899520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeblqJYwm2BtjWpPCooiZuze5OgFV3qFGUvUKNxIth4=;
        b=N9FgP/7N5m8ndETu8Txl2KIbqDonUui3do2uroazmcb5Kqc1z1NKmtMtI1mspjPH5Y
         gNr2kzTnWNP1Gi2/Kxg2D0XbfLjTHhSouty1XWochwqd+wfL2lv/QD1T59lc97c6DLds
         HZfCLKb87qecO4QpeP9f8fMVrg49AexwWhgi0P97D/6TKlTLjWOYoKk11EIWxsPwty3A
         dpCh6Rig5ENxoVGgsdU2DXZhj1m/2kIGArUOKgi1JmElUi2+GmjTdqSM2j4tCoOLi81n
         Fdd6TI/LBRWzYKFr7TpwyCETvYk6iObEQAgS8KUWpHDCQeAwo+4N1AKa6TFecChEXlfW
         8dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727294720; x=1727899520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeblqJYwm2BtjWpPCooiZuze5OgFV3qFGUvUKNxIth4=;
        b=JrxOeeKUYhyWPC0uzvo/6yNgcZtWcYhxX7pGYY55RXll7wYk7XSGFiB/4RzhWumZ+c
         T6RzjoCNjxMDdu0uvrJHcIdAl32/RGy6ZDtS5hobebfePQGcqJ0i/FX8I9HHM5O/UGwe
         hbqBcMqxyq8QphRtEnv4oPj0DhwkpnhuCH9/Q2Y5bWeuwYuwQngk4tPE4sbGlT7OQECE
         uKT1OJPXr1tHAkBTQvPnKLuqTxxC1+6aMuxUP/vMVG/9Zb1N2pDPgk6ruTRsx8Rc+uIq
         IAxzmgGb1EYI+mqOBsgKns6FtGmWYQpuahV6ugau89xFmf1wOn+66Hv24KRQ6epOtZL7
         tjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUDk8cnc9KEWv1l8rIoCIIRNATy6T6fwdJNK589OX0aFiDNyiuJUHgdpPQmlEiy87EFxpyn7wEQwCQgJKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg6PWTSE6KlWQddatCwT02YjPXI7zE8Jk5vQ5gycZv0lmZ54E
	76dNZI/bQInPnFxnV4+ibzKaDCg/igaBJITquDxyDvqlkNTaDATKKkyawwfVUSp9uDAmeU/n+jk
	sPMJgjBwv506Uus+HMcXf1zkVKjJuLoWdsz7G
X-Google-Smtp-Source: AGHT+IFeUPcDhTOCy6XpxwUvvIKVTfi64DqAL33+O7MwLkOljqYRRc9rq5Nt5AYfJqXkUxRtu20PsFxjE0VZ4uNbqCk=
X-Received: by 2002:a17:90b:380b:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2e06ae21a45mr4279639a91.7.1727294719839; Wed, 25 Sep 2024
 13:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925160026.84091-1-marex@denx.de> <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
 <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de> <4897ec78-b82c-415d-88dd-5092fa009f77@app.fastmail.com>
 <51c340c5-b104-4872-bfdc-8c6d52f6a35a@denx.de> <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
 <37634d8e-678e-45ba-98e9-a40a5e71cf77@app.fastmail.com>
In-Reply-To: <37634d8e-678e-45ba-98e9-a40a5e71cf77@app.fastmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 25 Sep 2024 13:04:39 -0700
Message-ID: <CAGETcx-=UvJx1C9nNYzLP7v1T6sELN3QPzfbZT==b83LUAC=VQ@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org, 
	kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:00=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Sep 25, 2024, at 18:48, Saravana Kannan wrote:
> > On Wed, Sep 25, 2024 at 10:07=E2=80=AFAM Marek Vasut <marex@denx.de> wr=
ote:
> >> >
> >> > Right, of course. And unfortunately it can't just register to
> >> > the fsl,imx8mm-anatop/fsl,imx8mm-ocotp/... nodes because they
> >> > all have a driver already.
> >
> > Can't we change this to add a platform device and a platform driver in
> > the initcall? And then the driver can return -EPROBE_DEFER if it can't
> > get the clock yet?
>
> Yes, good idea. So the initcall would still use of_match_node()
> to see if wants to be loaded and then either bail early or
> call platform_create_bundle() to register the driver and the
> device.
>
> >> > On the other hand, making it a late_initcall() defeats the
> >> > purpose of the driver because then it can't be used by other
> >> > drivers with soc_device_match(), resulting in incorrect
> >> > behavior when another driver relies on this to enable
> >> > a chip revision specific workaround.
> >
> > We could have soc_device_match() return -EPROBE_DEFER if no soc device
> > has been registered yet.
> >
> > For cases where it's already working without any changes, we shouldn't
> > see any new -EPROBE_DEFER return values. But for cases like what Marek
> > is trying to do, it should work properly. He might have to fix bad
> > driver code where they remap the error instead of returning it as is.
>
> Right.

Sweet!

Marek, now you know what to do :)

>
> > On a tangential note, the soc framework seems to be yet another
> > framework violating the bus vs class thing. If it's a bus, then you
> > need to have a probe. Otherwise, just make it a class. Might be too
> > much to fix at this point, but might be good to keep this in mind if
> > you plan to write more frameworks or redo soc framework at some point
> > :)
> >
> > See Slide 20:
> > https://lpc.events/event/18/contributions/1734/
>
> Very useful, I don't think I've seen this explained like this
> in the past. It's probably not easy to change now since I'm
> sure there is existing userspace looking at /sys/bus/soc, but
> I can at least make sure I'll follow these when reviewing new
> bus_type or class submissions.

Great to hear it was useful!

-Saravana

