Return-Path: <linux-kernel+bounces-512383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24579A33892
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696757A3715
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51EC207E15;
	Thu, 13 Feb 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="um1hTdoP"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4B207DF5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430661; cv=none; b=h5EiIqdKyQ89nf7oalSLUkE5C0yso0Zv6sDYWcV3b5PPvjke860NHIIt7+aJa2v1v91/vPFSyuFwi6+WDtW2mg8HfTp3k/bojpk4tqeeQuRRWyZGxTjcTadVUXth/2HH7SN3mUHId08rUgKrfmcaCIUFaHr0jJowY2ub0qxW1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430661; c=relaxed/simple;
	bh=1JzLXGxL0QmiLI5Q7L2Av98JRC5DJw0hUHJfC6Qg2Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JBV1aO+s4a9+mFBW8xE5WFqUKT3prN5ykXDu2lapWEvi17Tw9ebRRhmX2HQ7wJrg7dCT8dpAaypgTw8TLEqnn0XkoJ6v3Ngansvu9/vTNuZ5BQWkeRTHHHbZYV73ajoGyL9EcxO92M87hVWQ5vElECPHcYRO9gek2LlKaHSG8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=um1hTdoP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso92192766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739430657; x=1740035457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fM8nRNJfG7rUd02T8erTfV5HvN4Rbdhc15q2XjlMewU=;
        b=um1hTdoPBVMHAK/ZiGthqfaEd0BOvHcMehdhyGzNN+ELhG8nX3Q+kt3fSJ+4jMuN1W
         14UgncLJRs71GaPq/kRoZ9MFvParFrkUvKnRC3aa9ZRDiOYGsSJZZiKYqlqaWE81sF+I
         Frfj2avDxONZP9QTmKgXCAND2AAJQiTLtreLza8ti+GeLfHuX24jPqEHFWeKCoekWnE1
         awRAfC5weqdh+orzdee16f3p9X8Bfc9uIpd0ia46JMAa2aRishrNo4tx3T8nOoBc63ln
         oBPnrxrAOcKAlxlaSraoHGr6d+pSY5Ab4E4GJ+NL1HXvy7chia+tqOPQP9Uy2gUn9JiT
         jIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430657; x=1740035457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM8nRNJfG7rUd02T8erTfV5HvN4Rbdhc15q2XjlMewU=;
        b=ip2JSGBxKQro3XxOP7ZWbYGTRBI07hI0hfd9kcozRKAnmz66MXbtmO/fpR3MzQ7bnh
         YyU5o4nXih8aSrcyVvMxZoJVY1o20VEHLC00FoiWf97ZCeXvuVgY7XPyyyMiOBNg8pkI
         ka70XoApWnBK7ud6u+AL9C/pmPdXmjxXBx28HICf5QGroB+fZPaKJCdMuDniLGT/fG6z
         o+Ze3fiY24tRCviP/A7wyWMz9wLEa4+9bZcE9xNr8Su8b/fk0vGQlb0H9bJ6VjiiMOkM
         UQj3+Rz91crVnUuZMK/RKAJKHBKFr1Fcfe3oUbDQtCtjc4ds1JUs6dwr/2S24oTPgwoz
         NKPw==
X-Forwarded-Encrypted: i=1; AJvYcCXUtmKL0lFZcO7Us0KaiC0t/5v+O0gbKLlBOAcM/YdwdfqnoERfkECf9aovG0WpQaAzumZgx4ThChD7vJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyurYJED9ZZIJnugD0PsLulPOnGDj+xUQI5A1WqghmAyksEtjU
	FIvGziKIpwm8U0nghcKtPaku48SNUrITX6v8h5XDRh28KqLFflUlF13pA1Dy0FU=
X-Gm-Gg: ASbGnctxaRpPesFYvsB565bPWZbvg3PPVOf5Ftk2krBhfvRFawvCkeOTvsPKmFZe7Cg
	6f1a+lkuRYWZZpfDX1TBcxnFcq6Ou4bVrEg4nF81Z0qOZaYCZnw4oJJ+D7c6M80wexVTc/oOXMH
	FIJIZ61KG8A4P021OCua725aUz/leRt25GN6PwWj3YIOKjuZbBHw4bAIn7PpotNWpUWjWa/kerr
	V1bSx5pRuK5TvYh7xyKAfxU9usd9U2s7ZVfCoXjfJj6i8FLpthj5bA8HT380rF5nGD3JqKqCHlg
	emqMb1K1chq+KGhvXC6o8Ony
X-Google-Smtp-Source: AGHT+IHtrPRE46nXKkFCt4DHjiN8hmdANTLc5iX661OAdX/npX13cIu7Ky0HIkuVU57aNRMuRQab9w==
X-Received: by 2002:a17:907:3d93:b0:ab7:8520:e953 with SMTP id a640c23a62f3a-ab7f34d4f0dmr512307166b.55.1739430657085;
        Wed, 12 Feb 2025 23:10:57 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d349esm659748a12.33.2025.02.12.23.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:10:56 -0800 (PST)
Message-ID: <feefbcf2-e441-4cd1-a3de-40bfd4d7197a@linaro.org>
Date: Thu, 13 Feb 2025 07:10:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, peter.griffin@linaro.org,
 andre.draszik@linaro.org, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
 <20250212191241.280-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212191241.280-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 7:12 PM, Denzeel Oliva wrote:
> +static const struct s3c64xx_spi_port_config exynos990_spi_port_config = {
> +	/* fifo-depth must be specified in the device tree. */
> +	.fifo_depth	= 0,

have you tried testing without specifying the fifo_depth in DT?

You'll probably hit a divide by zero at:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-s3c64xx.c#n664

I assume the controller can work with 0 sized FIFO depth, and if so, the
driver has to be updated to allow 0 sized FIFOs.

btw, how did you test the set?

