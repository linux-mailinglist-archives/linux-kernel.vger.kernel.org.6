Return-Path: <linux-kernel+bounces-345864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4A98BC18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43944B22525
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984A1C2307;
	Tue,  1 Oct 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tfl4OFDs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02918C011
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785912; cv=none; b=UglewVaDrNaJBNrfZlLCTRBEHyoruPudCtteggw77l3IM7uOSgHyxEXji52ttuVgmf9AIIt1kovCM+C993QbEoVe2DALgeWMtTnqqc/MhHsqZRyqKryyV2iWwF05F1Stcr54O6K+nIeeVCy/808S+Mh0toZv5SHa+UpjuQ0XKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785912; c=relaxed/simple;
	bh=7cTxSzEbxeF+GrapdnzboHQLIrMSUvGWzJ30ZsSYLz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXlj9ZR2wsU2Nmy+j3j/4EUABrpC1nu8PpM0NtiEy1fktbh/bRw+PJreju4/wTKAD7w+fooHxX4FsVvun7JTmPN7NR4/aSsPoySLFW6QWVLlgfBjzYfg5oT75D94azogI498/Uj/gHkYNsGJ8e/r6+pdUCGhVRb3nvYIjPZfk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tfl4OFDs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e58ceebso2549755e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727785907; x=1728390707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaxPtIxc6X89i3w/fWNhCG9bzXeEBrVoBRN+stIijtw=;
        b=tfl4OFDswlFVjHH8gE/N76W0gkYW6MX8G19CaZ+l/JdUSv/EH8+44PKjE72OMNf4Ig
         l+fuJ3TJV46+M+saN/CsV3gocvb1LHqbn9kQh354IFuTOBqL27jzR2ye9OVeG7QZVUHM
         fEAkO/ZWCDvygqnN+LEnL3bBjNajs1rooPs3lrrCMiwdrA2Pkf4l+VRulXMwm/nluVF2
         NWReARK58xX5QJvylwJYlweVB5stVcLI5jqUaPj9Ur0VI0gPHTqy+tbSUXS9UVcXrms1
         2t/+2ZxGMeEWpmghLhPiUqGsWUooZVLTAP2X/uXd9IY9d2ExTX1d92kLlxLNm9EIcPcX
         NETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785907; x=1728390707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaxPtIxc6X89i3w/fWNhCG9bzXeEBrVoBRN+stIijtw=;
        b=mf6KyWaCAlFtMd5twqA1ND+7BEoxK1ALIBmwCCnhG44mF4D6ipoqahVtVLPe7/Odmb
         cuGPm5D+3z2DUzY2eSyb8lzbUK+WD7EHkgDkmjsWD25AHohrwPx0Cltw6ibN2PMECVxG
         GKR/KfDg4+/9cVC292iauQ2fkm0rosT8dps50zjCDtsM21+XZY9mbt76PPoel4WUOMT0
         i5V9ZAt6T97VRT2GEro6dBm0PFMiIuVPkydU1xFon/jW1qtSQ8KLjr6Bnu9xV60yMjj2
         CrL7baIr9SpPXtqw0A7BvfbJ6ifct9Lb98juperdhdfshbXpowS0ZnmGqg/N/3NNGWlY
         xrjw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3TnxUqvGiIcIgCLT9Zur8SmFvk20iSkygPxM9+HQKX3DE827qd5BzR08BaW5FFc51lERMygNxa85ctw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxCWVSXrI3sKz96mIeukZqlXN3Rm2l2ltywASlpCHArWSnzOS
	dJ8OvDkD8KsDuaCsEAxi2WuPKSDb7nVOE+tcg65cGFx13TPMgvlsg40ZTfQNDb9a2wMw7i2uHOh
	ZkYPAAfM9zlN4qkIIKzNt58SNb9J03QDkOSg600Ug21plv59/
X-Google-Smtp-Source: AGHT+IE6cgwbL2vduTVHBVWFI7W1VvqonH0A4ZabzA3pe8dns/kIazi+ANVfWemf5d3Z3XG8mWpEFAxiZ7o3tz4fgFU=
X-Received: by 2002:a05:6512:224e:b0:539:96e0:f0a4 with SMTP id
 2adb3069b0e04-5399a2834b9mr951452e87.23.1727785907094; Tue, 01 Oct 2024
 05:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144804.75068-1-brgl@bgdev.pl> <c56f17e9-8da2-4894-9000-b74b7cb66e86@amd.com>
 <CAMRc=MedULpeE5Dwb4W-ten1sOWr_+6Xgb05VDW+w0_9ZxbMqg@mail.gmail.com> <36b70588-9ef5-4686-89f3-32603022f242@amd.com>
In-Reply-To: <36b70588-9ef5-4686-89f3-32603022f242@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 1 Oct 2024 14:31:35 +0200
Message-ID: <CAMRc=Md=3cDWG4snPKqD3UHe3t+hAJo2T1hRTx2YURg3_L1NAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: xilinx: drop dependency on GPIO_OF
To: Michal Simek <michal.simek@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:13=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 10/1/24 12:44, Bartosz Golaszewski wrote:
> > On Tue, Oct 1, 2024 at 12:30=E2=80=AFPM Michal Simek <michal.simek@amd.=
com> wrote:
> >>
> >> On 9/30/24 16:48, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> This driver doesn't really depend on gpiolib-of being built and can b=
e
> >>> compiled without it.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>    drivers/gpio/Kconfig | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >>> index d93cd4f722b4..0d676c96b72d 100644
> >>> --- a/drivers/gpio/Kconfig
> >>> +++ b/drivers/gpio/Kconfig
> >>> @@ -796,7 +796,6 @@ config GPIO_XGENE_SB
> >>>    config GPIO_XILINX
> >>>        tristate "Xilinx GPIO support"
> >>>        select GPIOLIB_IRQCHIP
> >>> -     depends on OF_GPIO
> >>>        help
> >>>          Say yes here to support the Xilinx FPGA GPIO device.
> >>>
> >>
> >> The patch itself is fine but it should be likely applied as last one n=
ot the
> >> first one.
> >> If this is applied like that feel free to add
> >>
> >> Acked-by: Michal Simek <michal.simek@amd.com>
> >>
> >
> > I think you may be confusing CONFIG_OF with CONFIG_OF_GPIO. This
> > driver doesn't depend at build-time on the latter and this patch can
> > be applied right away.
>
> ok then.
>
> Thanks,
> Michal
>

Now that I think about it - we should probably use of_match_ptr() once
we drop this dependency though.

Bart

