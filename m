Return-Path: <linux-kernel+bounces-576173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0CA70BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8513B9218
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3421DB154;
	Tue, 25 Mar 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ghwJKhCT"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9518A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937585; cv=none; b=fYC+1fpOqGRZueEaOwr1TwMhBzW+L0Gtif/PUAcSNPcZrNAGl+hJNpgQLXUMksBJQTChS4+LMBdRH18jOKxd0nvxqvvMfifgDYuj6SleissXArycn0TPzOBaC0pkFL3dx1VQv0rCAB06q2lkYCoHM6gYvNm1DhCyLVBjuVGucRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937585; c=relaxed/simple;
	bh=NQnbD776Zb8ERF4HsMHcXnwkS/TO5s/52zWgVm5NNQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGn4eBOB4PD9zuxtvcrZWP0t2mG7HJbjiCfyKHOanarS/h6KcWSbOSH4FXbhO7xH8UfDUujUwlupYJgiVV+n5oRV/X4811Q0PVkWukOE49ZVyrEQPQ0MkaiF+jRWheV+XnIZTyHWBdzu7zY01peuXM7UwTlUpRjWoTGkKkMky7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ghwJKhCT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e73562577so53183839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742937583; x=1743542383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKG8KtS1PtfoFoAQY05FHNouuuEBpDMQ8ANK42hHsEk=;
        b=ghwJKhCTXyRH2muFJhSV27I5BgoFf4RiIMZmSRLr7Q1Xk3yBt8SJTfVibbuC32YsRU
         Z38S6RKL2eyxecuGDU372y3mEXSNog5lZwWpM2rS3gmtdyZYUgMZa3/CSPNbRRR0+Ove
         75mRkDkaGLUO4KPgNZVNUvBGRL+dGmFPxz2pQWf5K4HalCB7cdq766NfbOw+NnK/BE97
         AcDJ1KnuH13PxiWU/4zY24bCOdvKE6tr/hZaz4tE+QKfDZuaJHNXNxcH2Y+qXZJo2vSh
         mVBdJdW3Bg6FV2zoAsxTcNtC7Qh3vY1D8TadKDERNVuq+14LYaVdTFnnptuR/odiFST6
         /F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742937583; x=1743542383;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKG8KtS1PtfoFoAQY05FHNouuuEBpDMQ8ANK42hHsEk=;
        b=vkqNmxqFpI8EnPDThqu+XcdiTjdFvofyHEoEB0x/97QY++Tu4sFBIs0Hy9b33OQaGt
         Mc+40sB4YoWwdEUWSTDVNMQvEFC66NcACfzqIwD7hkl8i0rgwgf+ktE7gwqC3REhZbR3
         RYOZdPksSJpNgynha90s5uX+RhkhWGBB9sBeCtcR4i3gMp3/KYiotNs61sCSlW7sIgTe
         PiLcSTeqXCFFC1Rxd8nXIMXuu3pKsHGlpN0Z539GPwhW519M+Yyju7UWHkriaFVgaxIr
         0C/N2/kUzioIdOAQVCmwdC9kIjn8EOdh8PbrWGV725TNAVJ1r7JbbKCyOf7gtSnWdLA4
         wR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmvs0WQsRqNLNurTMF4LqeWUCAawpWAw9exvK8R6DkwtoHh4YRxiMXIT9PcAoDvRwP++il1WdpRFcmKFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHS+0pFZ8gCYBLktNDaOyVfHz0a9TFXpkYDiYhYL4l3eItl2NN
	W6tb+g87auDhlyR7ISmX8mC/KJQUDksx7i2qAPZxt4apsDDPyprupG7h8D8CqJQ=
X-Gm-Gg: ASbGnct3OPjBO6euTqmRbQf7mCIppnF0nS2HwDc9kOCRY28bXKZlCxGTiTFzQp058+2
	j8isjffFh3iieWaq/neC1tjlSDQ27hbeZz7rDZTvbVjkOwGf3DR3Sk0nPWuv2A0394h26/DLmaC
	LMn3KFnb+rJmwPPY3USYKSlqK+3K596ay7pcuVf3rW9TMewuJ5nUOYI2UArIq/Tw4SmteY0A4wo
	1eecZUWEgDa1QkRkQvTtKYFYf4IPZ+zGrrwlzlP/zf5wp78YtYCQcy0QXymjefYzdDrnf7iODsb
	sj4HwK5CUqD5nAScfZ/ha8MCjgUzvaQiv0X0uumNsD9KNFnAypyVBCKe2A3wlw==
X-Google-Smtp-Source: AGHT+IFJ9ei+dbxpqumX89NY7ke1+osmRH5g+C2Bjhwac4EqYyI6bFrpBXPDDYMUEUIaTXB7SW5t8w==
X-Received: by 2002:a6b:6806:0:b0:85e:2e53:ed27 with SMTP id ca18e2360f4ac-85e2e53f5e9mr1462507639f.3.1742937582760;
        Tue, 25 Mar 2025 14:19:42 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbed215asm2531270173.136.2025.03.25.14.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 14:19:42 -0700 (PDT)
Message-ID: <4a45df45-b2b1-4da9-b829-c5310cf32b5f@sifive.com>
Date: Tue, 25 Mar 2025 16:19:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] ESWIN EIC7700 pinctrl driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
 Pritesh Patel <pritesh.patel@einfochips.com>,
 Min Lin <linmin@eswincomputing.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, =?UTF-8?B?6bKB546J5p6X?=
 <luyulin@eswincomputing.com>, =?UTF-8?B?5a6B5a6H?=
 <ningyu@eswincomputing.com>, Lin Feng <fenglin@eswincomputing.com>
References: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Emil,

On 2025-03-25 9:13 AM, Emil Renner Berthing wrote:
> Hi Pinkesh et. al
> 
> It's great to see you've begun upstreaming support for the EIC7700. I
> read some of the data sheet for the SoC and noticed the pinctrl is quite
> simple and could benefit from using the same model as the TH1520 pinctrl
> driver. This version should do the same as the vendor driver, but in
> less than 2/3 the code.
> 
> I hope you'll consider switching to this version once the basic
> support[1] lands. This patchset also depends on that series.

Thanks for your efforts here. We are working with ESWIN (CCed) to simplify and
prepare their driver for upstreaming, and we have ended up with something
similar to what you include here. We were hoping to send out a first version of
the driver soon. There are still some differences between the two drivers, so
ideally we can coordinate on which series to move forward with.

Regards,
Samuel

> [1]: https://lore.kernel.org/all/20250320105449.2094192-1-pinkesh.vaghela@einfochips.com/
> 
> Emil Renner Berthing (4):
>   dt-bindings: pinctrl: Add eswin,eic7700-pinctrl binding
>   pinctrl: Add driver for the ESWIN EIC7700 RISC-V SoC
>   riscv: dts: Add EIC7700 pin controller node
>   riscv: dts: eswin: Add HiFive Premier UART pin control
> 
>  .../pinctrl/eswin,eic7700-pinctrl.yaml        | 141 +++
>  .../dts/eswin/eic7700-hifive-premier-p550.dts |  46 +
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        |  17 +
>  drivers/pinctrl/Kconfig                       |  14 +
>  drivers/pinctrl/Makefile                      |   1 +
>  drivers/pinctrl/pinctrl-eic7700.c             | 802 ++++++++++++++++++
>  6 files changed, 1021 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml
>  create mode 100644 drivers/pinctrl/pinctrl-eic7700.c
> 
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> prerequisite-patch-id: 2e5cc67f66a8cfe463ec73b98cd17130d4094a86
> prerequisite-patch-id: e39d6867f89c605fd1e3621937c8c91a6cfbe7c8
> prerequisite-patch-id: 5d2232bb3ce3d7d4e23477c2ad3db30424fee33c
> prerequisite-patch-id: 946719f43a0cc23ffe82e996e076de2221dcd8db
> prerequisite-patch-id: c2c2bc1b676b1e15165e107515b380318e9ca941
> prerequisite-patch-id: aa4a955dd99d0796973fedb78bea269ebab73b6b
> prerequisite-patch-id: 1cd27ddae721cc1e6c52723f8b360b09b5e712c7
> prerequisite-patch-id: 237813218e54e0c7cbed8d72e30eb649ffd9ecd4
> prerequisite-patch-id: 8e687755e898e71c80b0294b90deac71fe05c421
> prerequisite-patch-id: 05622d10a27ba9cba36b3d194e51a2d8d7b7b783


