Return-Path: <linux-kernel+bounces-227110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9D91487B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25A6B24675
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCAF13A3E0;
	Mon, 24 Jun 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zu3kIjxz"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECC137C2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228186; cv=none; b=UvWIg0WvT5PlavfDsmE3HUQhZlfQvajHFUHT9NJm3qBGH6VbSUuyraFFi7RgcaCcBd3w+/AlVlRF7dQuGJMpQfO6ZK5lZArkmztFAqBeCko4/UQ4lAto6jwgRz6vBs4T/xXMdCX7Tuup8ALo6MadQCkQFbtU1eFl06wL4XA+oSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228186; c=relaxed/simple;
	bh=S4Oa3Fi8IQljVdEYLI5O8zdfZsxp5YbWq8vVORk/zlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn3kn/i+eg36CD4vwIb4i+ZPIbqGsp8A8Cqrl3/+9wLZTMwFtcBChrzrpFnLYaAozY13pM4lkWlD/Xh5zfm0EF+POoq77vlWpxEeeYysXZwLLNuEygBrCWOiRBnzU/esOYMkzn98t1onoFxv7KrM3f+Gzq713nm+TgSB74FTU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zu3kIjxz; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c1a6daa04bso2205619eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719228184; x=1719832984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u30lLX5MsP/IKxn1NfwcAHsSmZJS+FIZz7/OFIlaO7I=;
        b=Zu3kIjxzOftbaS3NAFWR008Jt3PeySACnJTg9Mo7KISu4z+38omBIFJvQyN++lv7cB
         zU0dAVDZs14c8ST/sK65k9V3nxxHPyq3Avm16Upe1dQjbaYvj8xrF8ZrY2TFCnnWDJ+V
         80Z9WBWkYVYcysLKNPrAistos06qhS5o6UZxaxOxKcKhJig5CTTgXwBEK0SSJCjqhbUM
         WpprSZV0Nj1nhIK6sdCd/mdHnjekAtUazD6Zgfbof4AQwlf6cJ+nu9krgbZGJY024tJC
         gbZgKtR2LdKjt1FglyrDKbvAxwApN0OG6Pq+WQu/gfmTErf4WW6MEv8+ASXQ9TvGUXYW
         /vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228184; x=1719832984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u30lLX5MsP/IKxn1NfwcAHsSmZJS+FIZz7/OFIlaO7I=;
        b=XtarkKnVmFuMzoybFSN1zLvZMy+NRSwNgRVkCvDGb0yT4Tu6/6f5GlY8pBGjVjTDcp
         5bZgGAWcTBxvuQ3484MAmytKvrRIV6pGeI3uiLe3YaLhpaw5/ZctmlyqYHr62L9dpbAU
         0uBpqIyU8Brvy0BkJCOK/NbcRC0L8EdsmmYIkmBZ1i53WW+031XfviGnsdAE6cQFb6ga
         88P7GzQut0r1V339tq4qnQQxqZmvC523HWySe2+IFaVSqG9oH6VzvCRQ0hvaAFYJXfYH
         KJnHRzKSqMYWWGA3mXDabpeGY2Jb68cQq6+5HphuZwpKRGah13/3JZG7mCp7DQWu0DIo
         utpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxWMV/fUz7ZXtKVOIgbVDAqimBnqff5CPKPXCzUXQaje57JTsCidqPXPQl1vd6b1KR/kVSS8tHqmLVcZ0IZ3Y8IQbO4MRPzSprSySL
X-Gm-Message-State: AOJu0Yx8bWOFd2LHaNHnVp965EMzrb0aFY18IFP1s7xU0d4nCYDt6qw2
	Zhh4ATaCdPnU2mcP1vnbIDzA0KFnwfV6z2RI1qLcmWexll3O/ybEhA7LCF0BdRWzMshsCTYy4Y8
	pTR/DPCI3Fme4c1YqSI6u7FuvgXijFcsyXMTWCQ==
X-Google-Smtp-Source: AGHT+IEMLOPKjw5oHjHxY0zCeeuDJx6nBikXHAv0mrWk60i33NBz4cPxYEwhe+RUgp41xs0jTLpfBU3mUf65mTiLoME=
X-Received: by 2002:a4a:345d:0:b0:5bb:3ab6:94d8 with SMTP id
 006d021491bc7-5c1eed472c1mr4618521eaf.6.1719228184148; Mon, 24 Jun 2024
 04:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org> <20240617-usb-phy-gs101-v3-3-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-3-b66de9ae7424@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 24 Jun 2024 12:22:53 +0100
Message-ID: <CADrjBPod9w5L_SNFCa8+=kzasnf8g6MmGC6m9E+kF8spu37Z8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] phy: exynos5-usbdrd: convert core clocks to clk_bulk
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, 17 Jun 2024 at 17:45, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Using the clk_bulk APIs, the clock handling for the core clocks becomes
> much simpler. No need to check any flags whether or not certain clocks
> exist or not. Further, we can drop the various handles to the
> individual clocks in the driver data and instead simply treat them all
> as one thing.
>
> So far, this driver assumes that all platforms have a clock "ref". It
> also assumes that the clocks "phy_pipe", "phy_utmi", and "itp" exist if
> the platform data "has_common_clk_gate" is set to true. It then goes
> and individually tries to acquire and enable and disable all the
> individual clocks one by one. Rather than relying on these implicit
> clocks and open-coding the clock handling, we can just explicitly spell
> out the clock names in the different device data and use that
> information to populate clk_bulk_data, allowing us to use the clk_bulk
> APIs for managing the clocks.
>
> As a side-effect, this change highlighted the fact that
> exynos5_usbdrd_phy_power_on() forgot to check the result of the clock
> enable calls. Using the clk_bulk APIs, the compiler now warns when
> return values are not checked - therefore add the necessary check
> instead of silently ignoring failures and continuing as if all is OK
> when it isn't.
>
> For consistency, also change a related dev_err() to dev_err_probe() in
> exynos5_usbdrd_phy_clk_handle() to get consistent error message
> formatting.
>
> Finally, exynos5_usbdrd_phy_clk_handle() prints an error message in all
> cases as necessary (except for -ENOMEM). There is no need to print
> another message in its caller (the probe() function), and printing
> errors during OOM conditions is usually discouraged. Drop the
> duplicated message in exynos5_usbdrd_phy_probe().
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>
and
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Tested using my Pixel 6 pro device. USB comes up and it is possible to
use adb from the host computer to the phone.

regards,

Peter

[..]

