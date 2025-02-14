Return-Path: <linux-kernel+bounces-514427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B4A356E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FFC189320F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64B1FC108;
	Fri, 14 Feb 2025 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na+XqpLG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB41DDC18
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513658; cv=none; b=DcGgK63ScSt4rX4lCi5wRylNr7orPJZqOMKUm86sGaj1ikQyGLYI6ZwTV1QbX1jYTbuOtuyc4SMHKBiYC61fUBrjG9mOE2n9VAebOEdU1o+FiTwDwTUqOUcM8kz2Mkhg2kUauhzJlPNcvMZ1T2pmp07dNT5FKky/zAbzvnNL9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513658; c=relaxed/simple;
	bh=E+zHukzTxoUAqQh1pniz8wv7WSmBiWd4YYjBi2Wtb9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y61RoRGKBDcZaZYirqYh2FoL7sZncvvFgFUGRC2Zwl5p7CbbzNzZzqJeFbvIyJ3i999EzpfYagY5mmAKbB69fKeOhB+gA8F93VXZbEcvR4XxAU37qEIuEzrcr40BDqJrLdD5jyV6I4zp/qNW8MuEHz6XZoaiTjMUL6mOuHlw9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Na+XqpLG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so320170266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739513655; x=1740118455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+zHukzTxoUAqQh1pniz8wv7WSmBiWd4YYjBi2Wtb9c=;
        b=Na+XqpLGWcI+DhFBWBNj8ihX3QXlbhQ7PWgqxkpSpXNDqQ7cyzcARnDBQ6OeTzqT8q
         Qo6IAHxgXcX4muL+yCs3x9kmHzqf+PFkIoLYesZOJrZQfYPCSMBlzHDLzFTL2ujvkWxB
         aMGsBAlWvxUr3PSoQDxXgGrgZCYSPVLWLFM1WTptbZNj2Mu1ELYD8+ZVzoAsrArbHmJe
         LPLD6Cwyre0y5aTZfmQZOrnC6Xtl575jZgAXw1u2imNWFV/CBOXFnDBP/zSkGFquCI1P
         jFh0Qw2QPFAEsBd/CWxFKITxtGy4Ga8K7/4EuTjdn0WD3mVOXNvmiSVNhOQDoZVgCu62
         fDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513655; x=1740118455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+zHukzTxoUAqQh1pniz8wv7WSmBiWd4YYjBi2Wtb9c=;
        b=UiSfX83Etk+MSdqfLev3Nmjg38HRlKaOuehGWWv7rQrCK1uMVv7c/EtzB4kOaCGSRm
         ouOxtC7R2a/jn0Q+xKYzrt53IscOzojnkm/k7kY1z6mxt1uKi6LuMzKNXXvlcSwsjRL7
         dwZuqtWkgfyx7s7OohbjmMdCbTmrmXq708o2jONp1C+X6FMUKaAZAt+43/m1/puDgjtx
         fjJWYg3D4Ox9wEn+rvI7vlXe1V9z0ord7BCkkElyKcGBc1qPxtlbvC4kqViYorbAvqXC
         sH5oyCmBWMNymdtoL4RpyKLhpO6rCOK/AkBx83vaOVmvewWEW3BXmHe2t6Hm1B5sSneX
         /s3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXXgxOllaVCZLJocMqIJWY1B33P45wPj7iywuqEedphPnBmQQBaIDbLw1cPX19LSXom7GFkT/EKUE4cr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJcbVwgVzuBtEasfoEFVRAhKewK09pVQ3y/vDlqz2iC0IhSpL
	oFUJn0rkTGqzA460oOiC7Fop7V+cIuJNJ80XHZ2hGtNKlxxlQRooxblftPJKubA=
X-Gm-Gg: ASbGncvPbgXw0vaKh1yj8nZ9ufhWrQidskKs4CBvrLqHZiRnrvAaDVRpzqNvfuOl4fV
	YHIrytVPpq7UHyeCNwsttQoikRj0d1GIEIZ8I63ezSHnbUln/1+Rika6w6mG8dcO9d2/1K8/1SC
	kqZ4A1V6UUvVfPM9ljU/9XRCdoSE19aGDnHr3g6m+PhRyxuHdiAEAmvD+3TWlAQlKsShrtOkNgk
	y0Pyz0gAJPrufylizo6jELG447sDX8XVz8PIbl73uTRW0TTyC95k340fpcxarvGeg/KXfDHpBEd
	OKf7RpAFNZEqcfMe21eXtHFa
X-Google-Smtp-Source: AGHT+IEmV/spFwDvPJBmBni+qOvQYaJLBVXLCJxYkFEXGyz6aAo+8zl5YqR1HK+HjXkmRorI/a/vqw==
X-Received: by 2002:a17:907:724c:b0:ab7:d10b:e1de with SMTP id a640c23a62f3a-ab7f339c868mr973175866b.13.1739513655453;
        Thu, 13 Feb 2025 22:14:15 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532580c5sm276049766b.56.2025.02.13.22.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:14:14 -0800 (PST)
Message-ID: <f4967c68-d79d-4ba5-ad0c-5526e7e1ccec@linaro.org>
Date: Fri, 14 Feb 2025 06:14:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] spi: s3c64xx: add support for
 samsung,exynos990-spi
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: alim.akhtar@samsung.com, andi.shyti@kernel.org, andre.draszik@linaro.org,
 broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, peter.griffin@linaro.org, robh@kernel.org
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
 <bad7b5b6-c61b-4e93-9415-6476976c8e81@linaro.org>
 <Z65MYSNuDdCFNlv6@droid-r8s>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Z65MYSNuDdCFNlv6@droid-r8s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 7:47 PM, Denzeel Oliva wrote:
> Yes, Exynos990 has SPI nodes with 256-byte FIFOs, and you can see this in
> the downstream kernel. Here are some relevant references:

thanks for the references!

