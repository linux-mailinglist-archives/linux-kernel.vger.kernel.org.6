Return-Path: <linux-kernel+bounces-289420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93D95460C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912381C21FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E716C6A7;
	Fri, 16 Aug 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dsae4XQO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FD76056
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801598; cv=none; b=b9acBKz29XRPn08j/ofAqY7t+8SOZxCpbrkveiLpIHmYch+avgnYih4mZk8QEuJheWQBGEykehNFNUKosNQ+B6OprMcmsqyE7N5LuvsOAHJpvUn3xqUEIAzLeBXnE2VPlU5RwGj29aVRBZzQq72E7klwf00+YmpfVNF1bzoWBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801598; c=relaxed/simple;
	bh=W8HKJXZt0TN3Tj9q4TYFeHZ4IWMQolPAsG4dzs16Wo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEO3oJeB8HsY4oUZ3FnaStub76L+jiwX02McL6gHMFlMDB/FPdGVG0rM4l5eDwz1XsKAVVyrrvRBEu7LedRWbGu1sb4+A+YiBGXsn+shXr5InvO4fdM0Ry56BwdByRD5H6QBuuMT3d5fqMIH61k5YceGM4JAC0/h3IzVtLGHmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dsae4XQO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efa16aad9so2265684e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723801594; x=1724406394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9FPDpC98yx9w2tg8hr+an2980Cz94S+kQLAPpDLRKA=;
        b=Dsae4XQOtQm1E4S6uv5+cSfopQh3nvjF77wG9E/9+OpoM9yg+utHEpdq2MMdgsZM5Q
         GGhwxV/KhfjWozXioGp/8r2yRZX6cASSi2+DD2lNbW4pndYZzpn6YjrUo/qkPi8t6gyG
         VO6WJAs8kYnJZGs/f18+REmDOFjRl0HWlrOI/8plWzhOChgXg0Yfw+P1ftxmyl62RxWr
         CsCuJnkMk+kkORenP+PicDKoMgUp7tFz5+YUzFAOw1jysZIsqOpkkWAizyhICwCKVxCJ
         yO3i2ioNayWkxmGVF+WHYr7I+Cn0B4ToVkVc6veiUJDwMx6oFnJ0ySV7RtKCvyRrcmd0
         uZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801594; x=1724406394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9FPDpC98yx9w2tg8hr+an2980Cz94S+kQLAPpDLRKA=;
        b=J0970GL2rBE44j6LX3MYyVyK+GYLFILGEmS2TpiVnj9OSqEDz2OYduhpfo6NRTfsRw
         L0oly43A1ZRDxTaiOVJJCS3xkD39JnxDaECJOMYj9Z/Y+I94fNwmHtdrvlvPCoC+qi4z
         VUg+Uk8AFrgd+rq3AttsH/Y83vSxOPZBHtbLZle0ospyhKs7T9v6jfGT446lxYUB6h0Q
         mGBFYUK9ybiNoOEneLvz5Ep2TdnxHRODq0Lj360ZPj1SPrP2cKjjdDTS1oef4L7JQFwk
         1IYsn3Toj0eaL3DInSbq4Ep7XaLbUywg1MYyLICBlWOaD7AV3KWzOBxK1cCHZqPA3Hzk
         1tlA==
X-Forwarded-Encrypted: i=1; AJvYcCWJM1D7SDj+oStyiSfxHBfwHUPjlnEdm7j+1C+rQCFmtm23CnRC/N8HWqj7kf4DrG+ngCoFiUeOJ0e3f/rJDiJGfaxsvr4cDl1sPveb
X-Gm-Message-State: AOJu0YxH5mhNvyEarFCerWHHARrtx9ZEyGox8GT+LMfHYFQr2ONxET+j
	n6Hp5PwOo/+T5/59eN3Vb8e3uNSlsikkyD20EpkmvQxO372VnOA1oL7u/Dy5kZDNf2OB4DGC40w
	gpthDqCuIaW0xRT7Ey3Ec/HY33zgxaw5jXRW3Og==
X-Google-Smtp-Source: AGHT+IElPnoMlGEFeaYa6XJMX42p2RFjCrFohE/fSRX4wJDpOl934ILAd0fjz1CAkQ4BdsJ8KwsBja6aeGlxue7xk1w=
X-Received: by 2002:a05:6512:2528:b0:530:d088:234a with SMTP id
 2adb3069b0e04-5331c6ede52mr1482287e87.54.1723801593845; Fri, 16 Aug 2024
 02:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-1-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:46:22 +0200
Message-ID: <CAMRc=McL-ddFd8foH=cXW8nNvX=FVY+PwErYkh_OO9t0K=a_AA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] gpio: rockchip: Update the GPIO driver
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> GPIO driver support acpi and new version, set input direction in
> irq_request_resources, fix division error and debounce config error.
>
> Ye Zhang (5):
>   gpio: rockchip: support acpi
>   gpio: rockchip: support GPIO_TYPE_V2_2
>   gpio: rockchip: Set input direction in irq_request_resources
>   gpio: rockchip: avoid division by zero
>   rockchip: gpio: fix debounce config error
>
>  drivers/gpio/gpio-rockchip.c | 286 ++++++++++++++++++++++-------------
>  1 file changed, 180 insertions(+), 106 deletions(-)
>
> --
> 2.34.1
>

Please Cc the GPIO ACPI maintainers on this series: Mika Westerberg
<mika.westerberg@linux.intel.com> and Andy Shevchenko
<andriy.shevchenko@linux.intel.com>.

Bart

