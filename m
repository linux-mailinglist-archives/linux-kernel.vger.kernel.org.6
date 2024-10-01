Return-Path: <linux-kernel+bounces-345705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573898BA07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BE11C23003
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6161A01A1;
	Tue,  1 Oct 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="atqrT35H"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668F19C562
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779514; cv=none; b=GWW482KMasPXUx6uRQH0f4ymZe98CK9lDyPUbbnoYi9nEV6zYhkUpCls+Bnl121AmbX95faZdXqmREtYBk6aAVUiL2vrp6Oxpbm4i0LSRVgnTaLUmyCcfffIwYTapld4eu4NJeJvm/vmA94OIEjQ6W3jZv12sm6vHIQ7MLKbkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779514; c=relaxed/simple;
	bh=hWhJzzkTWKbIxbb3tnOrWSuu/Bxy8W/zS6ybBinJqgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSla8io2bnHSUVCTqzW9kWHmYdgy1iC/1/9Mg8c117G9KyVR17MJce8NYl2T9V0ul8G9YHHzJGDNBghn8c1LQI+b59pvdznMYpQx+9TYKG2r9yO5nyNcOMl2QoN4DBk8amuGG17igcqPR/fTCEwMYLLZYy63ZHBiTvvOE8z0fjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=atqrT35H; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53997328633so2716192e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727779509; x=1728384309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu+nsdUKDnBZoXSQTIiY654wGIRAE6Z/S+0DnpAlLvk=;
        b=atqrT35H2m+mGQvYmM4iSPgkYSxFQHNM8gEEqVfJxdmeLhvlwRa8dL4/7nTqPjYTNe
         iI83miigkHE/U8h0YuDg8/ZXF4MQkOowBIjPS1j///k9E5xyLfdqn3bsZXGGCRY1Ky9Y
         kwLBfczH3lya0LP6P3i15jKvLFS1/sSzaNqY764dmaaWwrjZsFa913kTUu2QsrP+0tiP
         GGE9jIfZyNnGOMRoWRw17PZrzdmbdp8eBY2RRSyRH3eFjGT8D/reREGckQ3wmMh2ziZN
         XcON8kTK1+aPTQ4Zht+QKg+x/yrYAcOZWxA2nibCLLiq6MWxQqxyr7bQFU6GqXv86uNg
         vE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779509; x=1728384309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu+nsdUKDnBZoXSQTIiY654wGIRAE6Z/S+0DnpAlLvk=;
        b=CVOnUdq/hIUOQXDJXh+4okoF5nNIYb7OiS3aK6h9sjJJl3qARcsZf+1Tw6IIne8KZv
         j1UyBkzx0UOETF8b7NnzWpaSGxufTe5j79ZJI/AVAzIrXWE71Zlxn3wkseTpuSstCp++
         BDx5k3R8yHy9bLkyVnLgf9JoIuLk4eM/ejr7rHQLwqRVAzvPnct+Uo3n+IwhLb0hBosA
         nRkfBBBvpPEjtwzAVpijt6nHg+cBH7lT3hoDoxaQIK2o7T7dm6MGCPo8YxNEMavX8uKg
         1w9GwmmkGHJghYI2yWFsG5/9EHL93V6n6GuISRYEmZ4mZpKpBmrawtpxmzFAX2AHmnc1
         VLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0GKkxAwJ/fYWQksx4iUvjTxftU9OAsL/aQhCp1LMF06Ya42d9KxqLY67a47m4nVREOAkC3fBdvGXJInw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQt8RnhNEUWU7CLadkJ24v//wmnZZLMF40HOUNuFBVytsva8A
	V2fUHQQMtqTxutpwsv63ozNoGIMeqaboPQvmKe36KWnSfnEBEXhMw1SyumeMmKa6SPyu5jUDO8e
	yzAwuo3JA/xqvTzhcqAnOYTiXayA+mbS3ob/qhA==
X-Google-Smtp-Source: AGHT+IGzHyyKjW6FYsVHWIUrSbXl7hbF1eFwVLE0SfqCQF7cj3uXQOwp9Azng6BK2LtmDhtsGYbc4ov7NyUAuajokXg=
X-Received: by 2002:a05:6512:1047:b0:536:55cc:963e with SMTP id
 2adb3069b0e04-5389fc7d219mr11185843e87.44.1727779508810; Tue, 01 Oct 2024
 03:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144804.75068-1-brgl@bgdev.pl> <c56f17e9-8da2-4894-9000-b74b7cb66e86@amd.com>
In-Reply-To: <c56f17e9-8da2-4894-9000-b74b7cb66e86@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 1 Oct 2024 12:44:57 +0200
Message-ID: <CAMRc=MedULpeE5Dwb4W-ten1sOWr_+6Xgb05VDW+w0_9ZxbMqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: xilinx: drop dependency on GPIO_OF
To: Michal Simek <michal.simek@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:30=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> On 9/30/24 16:48, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This driver doesn't really depend on gpiolib-of being built and can be
> > compiled without it.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/gpio/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index d93cd4f722b4..0d676c96b72d 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -796,7 +796,6 @@ config GPIO_XGENE_SB
> >   config GPIO_XILINX
> >       tristate "Xilinx GPIO support"
> >       select GPIOLIB_IRQCHIP
> > -     depends on OF_GPIO
> >       help
> >         Say yes here to support the Xilinx FPGA GPIO device.
> >
>
> The patch itself is fine but it should be likely applied as last one not =
the
> first one.
> If this is applied like that feel free to add
>
> Acked-by: Michal Simek <michal.simek@amd.com>
>

I think you may be confusing CONFIG_OF with CONFIG_OF_GPIO. This
driver doesn't depend at build-time on the latter and this patch can
be applied right away.

Bart

