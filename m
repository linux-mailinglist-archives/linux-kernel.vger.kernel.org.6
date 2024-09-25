Return-Path: <linux-kernel+bounces-339537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C9986687
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD50286C05
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C013BC18;
	Wed, 25 Sep 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyNI2U7B"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7184037
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290133; cv=none; b=K8lXegYvhe+U9bPKP8grfMn9dBP0PfYBx4Zs7Rplkn5NSxzeMfntexKBTmrhzXZMJcWvXQMRi6lQhu3ECm7BgGD/Hd5lEXx1taiLI+ASFBwKgpqmulLogOhywnN8jr2B5W+MKI5wNPogrD91hp70vZKlIaRbj30vtDjxdXCKYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290133; c=relaxed/simple;
	bh=Gd87H2xMVTmicZyoo5wZN2XPtiKxw1QXyipV2N9j4pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucH1QY5uTx0956V3qJ7NS5/baxLyfc7eKNZXf3sEWxGDvZy5t9cFbVN1d4QXcoFZldjgOAHk28SMxaVrX4nxifxhEsLFWrSq2Qh3D97ICVQffGx5lAMTdq+V7AD9jXaexZL6cB2iD/mnOxOFRMS9RIOHvMRtlEvoWDKLU95BVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyNI2U7B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so131536a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727290131; x=1727894931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd87H2xMVTmicZyoo5wZN2XPtiKxw1QXyipV2N9j4pU=;
        b=iyNI2U7B2TeYyCL3jd3H7eyiREvVKNGg9uXNLsYC0Yb1Rog7R7TM4Az8Q5TIAUL+HK
         cJML0nEKJmhtIaDjoeR9xmRy3jMAB5l58eIzgyuTht9RdSmmdKpqhRWDQSYInmSs7NWz
         yfBCzKNcivEtlNkBUSB5DUWwwK1BDfS19eyN7GzPQaoVEge16K74COH0RM9Ju2Eg3HAa
         bXogbNDs9Ipkn/3UiP9nKHCWR1njlrxxRl3mtdNSFdJ7LtSFhiAjLMPP/GHhi69CHusO
         +6dtMRqj/LYUwX5/D3W8Z9meMDy18Lw8TS21f9RUGFIGujkrPFdcGYOkoBIHtllmhLht
         JIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290131; x=1727894931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd87H2xMVTmicZyoo5wZN2XPtiKxw1QXyipV2N9j4pU=;
        b=oDpS4pc2kK3B4DeTjQALvd6pfGwxlHOG44K9IAUBWcv8uvC71eC+IOXAGTLk8mNvqJ
         hnOnHkGzxI8gYVdYmxiMRsBQses3osgcgf13M9FEeIL/cx282So9Y4q4hsuZ5KH2b5Hj
         MkiYuNUuu3cCDj5s+DOLIZlMlcsPM4lx/AW/w52XEq4gudtuLDh4vGar/FtXPS1VZUyu
         kMW9g/ZJXeIhwyGULwpKFZW4BuTV24zBJ7OYuGyBMD26D9F1eW9I3ZqadtJmvx8GCvqt
         dd2pU0i6m0JzJqQvUkJZGqQ943JDa2Yy/mZ07Xo8Ue0hNVC98iX0KyBHRYNzT86d/h84
         Z3eA==
X-Forwarded-Encrypted: i=1; AJvYcCWtQ+k4sfwmta6b6Tb74yXa//S6qNpWSBIcMucAuRVrsCvFS5wVWAeu+4ZA1+KBTvFcqmTLAnBgXyWB4TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/dGXUrm3UmGF7sdP2x7pdyXeA8Wp+DgVAF4wWHnm93lknAjo
	uPLvEqizYfejbYAGvps3nAfLh+SCfRv742TJpkChvb9PgO2vs2VfmrJ57nJn31wEth5CR4ZqDbW
	CAWbegXGo9G1Z7KK41KY7yiKiEKRGRqKPkQYK
X-Google-Smtp-Source: AGHT+IHG5PYxOfAXC9TJ+d5TCd6CVfYlhF0i9aEHR6XQS7zRTzopHVVXiJ/gZQBm8SbhU10i1Y/hI5LMrgRV5ndiLSU=
X-Received: by 2002:a05:6a21:2d0a:b0:1cf:49a6:992a with SMTP id
 adf61e73a8af0-1d4ebeaa062mr921095637.21.1727290130828; Wed, 25 Sep 2024
 11:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925160026.84091-1-marex@denx.de> <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
 <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de> <4897ec78-b82c-415d-88dd-5092fa009f77@app.fastmail.com>
 <51c340c5-b104-4872-bfdc-8c6d52f6a35a@denx.de>
In-Reply-To: <51c340c5-b104-4872-bfdc-8c6d52f6a35a@denx.de>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 25 Sep 2024 11:48:12 -0700
Message-ID: <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
To: Marek Vasut <marex@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 10:07=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/25/24 6:31 PM, Arnd Bergmann wrote:
> > On Wed, Sep 25, 2024, at 16:09, Marek Vasut wrote:
> >> On 9/25/24 6:04 PM, Arnd Bergmann wrote:
> >>> On Wed, Sep 25, 2024, at 16:00, Marek Vasut wrote:
> >>>> With driver_async_probe=3D* on kernel command line, the following tr=
ace is
> >>>> produced because on i.MX8M Plus hardware because the soc-imx8m.c dri=
ver
> >>>> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the c=
lock
> >>>> driver is not yet probed. This was not detected during regular testi=
ng
> >>>> without driver_async_probe.
> >>>>
> >>>> Attempt to fix it by probing the SoC driver late, but I don't think =
that
> >>>> is the correct approach here.
> >>>
> >>> I think the correct fix would be to propagate the -EPROBE_DEFER
> >>> and return that from imx8_soc_init(), so it gets retried again
> >>> after the clock driver.
> >> I already tried that, but if I return -EPROBE_DEFER from
> >> device_initcall, it doesn't get retriggered . I suspect EPROBE_DEFER
> >> works only for proper drivers ?
> >
> > Right, of course. And unfortunately it can't just register to
> > the fsl,imx8mm-anatop/fsl,imx8mm-ocotp/... nodes because they
> > all have a driver already.

Arnd,

Can't we change this to add a platform device and a platform driver in
the initcall? And then the driver can return -EPROBE_DEFER if it can't
get the clock yet?

> >
> > On the other hand, making it a late_initcall() defeats the
> > purpose of the driver because then it can't be used by other
> > drivers with soc_device_match(), resulting in incorrect
> > behavior when another driver relies on this to enable
> > a chip revision specific workaround.

We could have soc_device_match() return -EPROBE_DEFER if no soc device
has been registered yet.

For cases where it's already working without any changes, we shouldn't
see any new -EPROBE_DEFER return values. But for cases like what Marek
is trying to do, it should work properly. He might have to fix bad
driver code where they remap the error instead of returning it as is.

On a tangential note, the soc framework seems to be yet another
framework violating the bus vs class thing. If it's a bus, then you
need to have a probe. Otherwise, just make it a class. Might be too
much to fix at this point, but might be good to keep this in mind if
you plan to write more frameworks or redo soc framework at some point
:)

See Slide 20:
https://lpc.events/event/18/contributions/1734/

> I know, I am unsure how to proceed with this. Convert this to
> platform_driver or some such and probe it early maybe ?

Marek,

Thanks for trying out drive_async_probe=3D* and trying to fix boards/driver=
s.

The issue you are facing and the proper way to handle it was covered
in my talk at LPC 2024 in Slide 18:
https://lpc.events/event/18/contributions/1734/

All the benefits of fw_devlink are only present for drivers that use a
device-driver model. And yes, in this case we should convert this
driver into a platform device/driver if it's possible.

Thanks,
Saravana

