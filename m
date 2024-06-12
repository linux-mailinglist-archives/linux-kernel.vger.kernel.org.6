Return-Path: <linux-kernel+bounces-211278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F8904F67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C971F22814
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9A16DECA;
	Wed, 12 Jun 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaSue+0H"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD516DEA9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185086; cv=none; b=tn/n/G6dEjKDXJ8/89UdSlaVgt30znX9KuziFGsf7395UWDNyv4aXR2K/o6t1b2m+Bx57DEjmySO42Yj8AKIb8YwXb4B4ty6bs5ySQvrJB1Szq+iOOkd+8DMEFBgZQfAw6xvReWi0EPOjy4bEJURWoCWM6CDXXXUVlqyw9qp2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185086; c=relaxed/simple;
	bh=/OLzwTXfKEVgX1FDemg7z7MaKi7DyqZprPCae8jyq/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxGvMiAPmdzWhVDQ5K0bzyUF/AgnCjm478xUxrFohHmTY3f/GTEDUodpswvq3BCntlq2IjmrwnZefkCG+lMigqf6i9A+N9CpekfVrKFxEZ/YCSJF1wPDeZRDMXj2KJc9Ix4Qq1wmOjk1+dQb7iqz9RurQDb1uCgycqD52LUvRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaSue+0H; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d226c5a157so2178387b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718185083; x=1718789883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD/9IUJ0GX5iY+Im1dJVEqyByZWn0TG0w/F44NXDHLc=;
        b=HaSue+0HEf1EKaAvFHDsyFqIGIRUCyJooADNpL5tStVFr+fmpdvkCC2WiY82KLTdrB
         Q27l23DB+nRAdUr92geFocVTLhICYdYSxFnUItA2P2JH91ylDOzsW2IetDA3QO/lKx1Q
         IOmc7ZHjXjfBDIg/m68wRsGgp6WoL/hjQ2UuNshqSNAAS1DXPotuvw07EGxoOZ+sBZgg
         EG6S7v/mJyjNjnPQMvMECrvUt/QhibQRbux0pjQiA+wyBFIK3azG8Xyx+yGeXEqQEPfR
         lptY/aseWxp4IDeTa+JdJI2+41MehHjA25N2MrWv5vRn43P1Sa1IN6MdIhZRJfg1qeRS
         wGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185083; x=1718789883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD/9IUJ0GX5iY+Im1dJVEqyByZWn0TG0w/F44NXDHLc=;
        b=VOIB1Fpy1htx22ZNOqWhjB+zCJv17btkGAGkJVnQxb4X9bjTtwUCesju/QpsWvpRk2
         xF3hCj9NMfZt5sxp5LbGcCE3prn32KP1472hXDeAHeS/myX1NcXyZLnu8RChuMhC6e0K
         ZyuIcmxw/4aKR0TiJu4bpSB6f+OC9N48oy/9bG9gTQ3Vswj8jU1YeZ3VNRkbB+YTpAn4
         T8wWADbedMp0EfeqGHy0s20x8JvQ16mmrwmgeh8rxEwrZv8Ew8EUJ7rMxa7cp6Vt/ttc
         fgszolggCqcNtHjkfvws5BCqK8mV2SsOz29SXqGw6PBw33pXktpfkeEc3nwxJ1xlb8Bj
         vsJw==
X-Forwarded-Encrypted: i=1; AJvYcCXhjPnr/uMpK8M/ZjXiz9Mz3mZSHwPdM9G09hjS4Zo8+DVVxH+LePIkOxEAOuUg1mhqfd3WkdrWZ1IdfjoCbVYIRVShhBNv7XASIolP
X-Gm-Message-State: AOJu0Yw1R4rMeqIUni/1YAkEvdyVxtbmyb9cKefggx5rcmMs4k+PAVWy
	R8U6ARIRWrynZScFgqDOa68tINZMnbXJzNbw8GFM6BVZLuCbAYX2Ot8lL1o67scMbPakEt+5NAa
	pVThIDtliNu85Upmjg5Peu/C5CjGRZigOyBLSAQ==
X-Google-Smtp-Source: AGHT+IGm+RwZ0B9L/QOSni4O4Rx1n2ES+x8U9sHD7LvNXczdj6rZMABLoZ66Mwklcv5iX/J6wqTx4u/KMr664uropCc=
X-Received: by 2002:a05:6870:5e12:b0:254:a57e:1aed with SMTP id
 586e51a60fabf-25514c799f2mr1439059fac.26.1718185082718; Wed, 12 Jun 2024
 02:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org> <20240507-samsung-usb-phy-fixes-v1-5-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-5-4ccba5afa7cc@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Jun 2024 10:37:52 +0100
Message-ID: <CADrjBPqvdBsLVNeXVtqWp=hGS0G_=0jYQ_91pyg6jvFPN+2CvQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] phy: exynos5-usbdrd: set ref clk freq in exynos850_usbdrd_utmi_init()
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Tue, 7 May 2024 at 15:14, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> While commit 255ec3879dd4 ("phy: exynos5-usbdrd: Add 26MHz ref clk
> support") correctly states that CLKRSTCTRL[7:5] doesn't need to be set
> on modern Exynos platforms, SSPPLLCTL[2:0] should be programmed with
> the frequency of the reference clock for the USB2.0 phy instead.
>
> I stumbled across this while adding support for the Google Tensor
> gs101, but this should apply to E850 just the same.
>
> Do so.
>
> Fixes: 691525074db9 ("phy: exynos5-usbdrd: Add Exynos850 support")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---
> Feel free to drop the Fixes: if you think that is unwarranted here.
>
> v2: add missing bitfield.h include (seems this is implied on some
>     platforms, but not on others)
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

[..]

