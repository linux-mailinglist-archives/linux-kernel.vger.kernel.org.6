Return-Path: <linux-kernel+bounces-227123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190169148A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82753B2248A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFE13A252;
	Mon, 24 Jun 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Skk7pb8B"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43613210F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228512; cv=none; b=J+MrPgR61wX7Yto6sKQ+uHvrivXjCFsAC/tk/JeBu1ratVp5+jqPqjxVA/AEclIkHPwjFkTuxOCs8KIoC+hBCkYhYpZEYZVd83qkcpohnrbI957wKqxhijSMrIYLxOagxzFnpwCZ4zUcfdaYcW78Gfda8nRwER3bn56c23O5x4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228512; c=relaxed/simple;
	bh=NYND7VdilAAcK8UQ6tNb4wM6mWC/LRp6HLGpJAraXLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlBfOHcWDCclBHvrFm2Ram4EK8H59Vy02y9RJQFBISnTfgMKaWsj0ogK9U1C7CLgQ/BSLJhXFHoI4ryAJGW/rlHhoGSBc2W4BvNDggt8t8epuJ42rtqLXJj+NhjG4R8mzMlKtm9pGwDk4lOXm0s8U+UBWsyScWxVc1aEGVOORwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Skk7pb8B; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bfb24e338bso1674267eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719228510; x=1719833310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QteiONYM0/7wKm8o/iZbfkWsRu+IEcJCYcDxA/UWpZM=;
        b=Skk7pb8B4pTG2wluyc+M3BEnjjfsc+cjoBKHYUgSt4mMKH8bSzkDEfLplA6wY7xiFv
         gyXyAmNkJqM+Lb1EUY8iXv2TyuKvwMPucVhZ6wnLKqg9/QXQICkHXfxdmThoXJziHjMd
         KhIrKs43ZDZEefLpo17/tzYlWXXbE7tU2P9pAusJMO1ElDxa6NIUiycheVX9zT6lVu+9
         gw29awlOqAcBZ4wcMeNCR3ndK95g1lDWnidLW/EPguZrSZ3dTX8oJBJZWiV+hL3jv3o2
         B5XVnfVVFkX3XisnDmr85HOkBWb5CubA0PjgbeODapqszdB6lHztFk6vhIqxZUkwl2sm
         qJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228510; x=1719833310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QteiONYM0/7wKm8o/iZbfkWsRu+IEcJCYcDxA/UWpZM=;
        b=Oxo/pYRmrJ9vS9CICrHPSaJ7vOvkJ0BXC0u15Mv2BCRf5OCUJ5EBR1KttIncuUYSGC
         ZX77KcDN7M8tfyc6wRfD+SIUjahU7XXGcSLWlmHmGQb0CgJ4vHz+0jMv0j21SM/MDy/8
         m9BUcLDyARfImeU+KDlsP4fRC21UDrEkHsA1fFSunfLk1TIvPu7H1Xr+o/aHsk+GDlQB
         q2oPsjofrGbMA8W/PtnDRQW2bBhOTW1ndIjjo8P5VS7S41pWSuw73mtdSemeHB9pZQE/
         RUE3w2vh28dhBdgvDPoYqRSDMPGPP1dgMcTLpwipg6epLX+fyNFvgm6eGgwF1ZBmEvqR
         FSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtpuNnaWOj4YV8gSrpOR2mvI4C6tInxfeKQTUb9GilPSlUFSbckQxnrQjb/FbOrpV1MsFtxCgnIPLsHeCv9p6QK7AWV0AIfa6MVky
X-Gm-Message-State: AOJu0YwMZfRWgAUYRALRQkcMBx6jbj1eG3qHzBHUpPfvSl6eTSk9e1sC
	FmAfjFDFxcqihyX4WxgKTgiINgvNEknvtgJOIVzhSJ05lkqSVMjvAwZes/NCLFn1vzI6yeQeUYz
	YAJnAJ8f/5cJ2eW6CKKFaDTUS/Kx9R6qO+umPlQ==
X-Google-Smtp-Source: AGHT+IFlNv2FZElqgVQlBk87lsFwbs9c65tZcdtCpO79u3aNcvuYkknMUcQr9mTDHrMDvpletr+cOs9nxhTCAnVSEb4=
X-Received: by 2002:a05:6820:60f:b0:5c1:e83b:ee10 with SMTP id
 006d021491bc7-5c1e83bef4amr2456768eaf.1.1719228509995; Mon, 24 Jun 2024
 04:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org> <20240617-usb-phy-gs101-v3-5-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-5-b66de9ae7424@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 24 Jun 2024 12:28:18 +0100
Message-ID: <CADrjBPpESTiZBruqMsZuuY=GyAjcFEZSXGEceeDAVESd52jJZA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] phy: exynos5-usbdrd: convert Vbus supplies to regulator_bulk
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
> Using the regulator_bulk APIs, the handling of power supplies becomes
> much simpler. There is no need anymore to check if regulators have been
> acquired or not, the bulk APIs will do all the work for us. We can also
> drop the various handles to the individual power supplies in the driver
> runtime data and instead simply treat them all as one thing. Error
> cleanup also becomes much simpler.
>
> Converting to the regulator_bulk APIs also makes it easier to add
> support for those SoCs that have additional power supplies for the PHY.
> Google Tensor gs101 is one example of such a SoC. Otherwise we'd have
> to add all additional supplies individually via individual calls to
> regulator_get() and enable/disable handle them all individually,
> including complicated error handling. That doesn't scale and clutters
> the code.
>
> Just update the code to use the regulator_bulk APIs.
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

