Return-Path: <linux-kernel+bounces-512377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 748EEA33876
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583AF7A36EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B02207DFD;
	Thu, 13 Feb 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2EmhXxp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAF207A19
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430329; cv=none; b=F9IjoVmNsmVZPV4VTSLBco1iEWVfljMKgSD+d+hxtfOXzloAYTppaIu3z93eXRHXo1ZUOsdwVRUzJeR7n1opawp+Nlcqj8l1HxLB7ta+1l+MQgwaWu9ZYddBIx6l/FC5nYW6TELa9oAjVWZHDNcMG1Vgq6qM0H3dL+UjDjMXdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430329; c=relaxed/simple;
	bh=QET72BwZuEgfgng3GFWuJsSpAa0rMxkNifDEi7QIWKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lyD+Ej3gZ8PkV/1pjr3SsjZsvoSAgIYYuQ7quIsKyfLdwx5Qxax1RIl/VuwwSeH5Bx1fHMU/Y6tGrsVvf/kQDZlT5FJHpaP/CXxAaWXigrArBpUKXkx0te024fH0RFgojE9WQ5LxlAsgn4SZpxrgZY/v5sWz1Ym7T8Kq9qGstEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2EmhXxp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so104183466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739430325; x=1740035125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXZVhKJ2K7k3WzqdZVJwEQ+tPoZ58G31W+/pRY1rx9E=;
        b=T2EmhXxpoAAKfj3W6Vn+l2Z2CbXmlA+e0sBJGxHkRa5iQxixCrlPLZuNitxmJOpvVp
         dAwvd7WCOZ60w3hRC1HdmD8ptUuBjkPTDkdSoLnltuxuqeMTSR+x4EFtEhfNCKsLxS1q
         R8mOSaFYui/ndm2cfELc6PJbZyqIwlv/1sJt7e5TZ36SFLjb1BlQnwe/NKY0hQW/X4OZ
         hxiqxHLINuMXX4Txc9da2IqCFNRW5fdRA3dq5S30bIMx6XgwIpgqWSc4dxq/z3Na121K
         ieJmrvWr1iWQaLc4jf70Fz2GJB+JSMOSQwmMkExjkyVk4pxGqTvExlZJEhfv+/fQ9q0r
         p/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430325; x=1740035125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVhKJ2K7k3WzqdZVJwEQ+tPoZ58G31W+/pRY1rx9E=;
        b=PblYGLUtztKAtglDe+Z/b2I2MHuFIIJCJR0F4V014tKtoirMDFnFL4P9rfee9m0Kxq
         YfxNxuPwIHo2Fx9SFcbeCGeb8LTrr3vGMR9XHKYKqoyDxvmHpr4mBGh7foBs92Ls/+5b
         vLwp+SvDnkxLBIXsMJSt0LXWsIaqgp/TI9WYrdhoQF2MU57IVzNkA+gcF4rAZLAb24Ry
         sdSpzlvJDSL0CQMrnicNAUad9YZVAn3kethyvDQwGwIJQJcmBtgo41YHR/FhyRVA3w5+
         JDy5aEaoFhHFX9RCIxOPLjtgTvwEoWeAgEMVIfntk6NmwP1QnCSGz9uGHEUypLdAClP5
         74Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVjsYu9R/erDlsUOF1kZvV4dVFQh0ECDuyqs8mzNwvcRlNT0wC2pU5E8UeSRaDGIdR2s4z6/l4WOnfBBZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIuSRrIWr6buqufcO3J/by6D09HDugo9lLmedqaVet8fGiQwF
	p3DSA/13Y8vu2HdxrNV+HlvMmf9bNxh7pJjKrfumLbH4lgZqygAQ7bkF35rXCZ4=
X-Gm-Gg: ASbGncvWfG1iZLjsBQ4qYUaqw3smMb0FiqIz8lpnhcU7/xXuCkyF9nPoK19wJeFd4GT
	UHkI+l2ObXsT90PnIfVIFDTvSWd4SHoae6mvGp+XUa+neP5kxj6WKhDcstM3+rdN359H0mtApb5
	qCPKjsKs/FxEAnaMMMkrXq/GTY5oCfxhQxFEkSEB8n238/ZhA1PJJuDc61UMWrdI/xPREk0qjJT
	WBVwnd66C7mIF9zcP21ETML7XgSsKFyctGbYuzszMWeCceMznM+Lg9gMvnlPk3HvMskawL1Lfjc
	kAoNYweQzp+029VroNs8qPZa
X-Google-Smtp-Source: AGHT+IHMrmKjXCi72IpIaaGCXzDCq4ibYmkuB+z09aLzRAGtSKSlts+BhuC/X0899B2uE4MTHf5wAQ==
X-Received: by 2002:a17:907:1909:b0:ab3:84ac:4dbc with SMTP id a640c23a62f3a-ab7f31a3665mr647610966b.0.1739430325446;
        Wed, 12 Feb 2025 23:05:25 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dcf3sm68465366b.156.2025.02.12.23.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:05:25 -0800 (PST)
Message-ID: <bad7b5b6-c61b-4e93-9415-6476976c8e81@linaro.org>
Date: Thu, 13 Feb 2025 07:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] spi: s3c64xx: add support for
 samsung,exynos990-spi
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, peter.griffin@linaro.org,
 andre.draszik@linaro.org, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212191241.280-1-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

On 2/12/25 7:12 PM, Denzeel Oliva wrote:
> The Exynos990 SPI controller shares similarities with
> the GS101 (Google Tensor) SPI implementation,
> but introduces specific hardware requirements such as
> 32-bit register access and variable FIFO depths depending on

gs101 mandates 32-bit accesses too.

> the SPI node where it will have to be specified in DT (Device Tree).

gs101 has some USI nodes that can work only in uart mode and indeed the
fifosize there is 256. Does downstream define SPI nodes with 256 bytes
FIFOs? Can you please point me the the downstream code?

Cheers,
ta

> 
> Denzeel Oliva (2):
>   spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
>   spi: s3c64xx: add support exynos990-spi to new port config data
> 
>  .../devicetree/bindings/spi/samsung,spi.yaml    |  1 +
>  drivers/spi/spi-s3c64xx.c                       | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 


