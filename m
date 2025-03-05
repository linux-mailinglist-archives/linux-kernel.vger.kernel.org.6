Return-Path: <linux-kernel+bounces-547020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F8A501D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369C73B180C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E224FBFF;
	Wed,  5 Mar 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhaz8w7H"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423324E4B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184591; cv=none; b=OMJbJ2dl8s8iBg+SMrLpXK0Sb1lMCQ7Ni4OoxMPVd7+RcSPo2QRkbt+cfYyxP5ovY9XFWiqwtE8we6GcxG/cYF+rbebK25etiUQXwP6/uetKR8vSRaiT1Gl8tzKkw0gHKiLSpyzdKvN/EZYnOg9bmddULoW1p8mBbxFWmyLPEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184591; c=relaxed/simple;
	bh=Y3p4LBE9WXSBmze6nc8QffxaOmv0qMigh53x+CI5U90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WovbLlqvHMrRfKbqKwG2sDYVemCoc+LHws6GJ264Qgey6wCfGwLw4y96L9ziXAKusNP+eSJLPlANnSjekwhrMHrngkem1XnurxniYyvS1Jb5kXHlwpQwXbw+zg9F4Eny6XkCZYWTId5YriO3OWvl3clRUgGBkSqbKa9D30NmauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhaz8w7H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bbb440520so38873165e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741184588; x=1741789388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/EDlj+KCqtnghUmkpWYPx5sg24VjMYJxMv5mgQVSzE=;
        b=qhaz8w7HsRDtH+dkmhm9PBNSqGoI97u9DRw49x6aDnMBZf6b0QAOuIIgOR+Q6XvVTi
         awhGgCajPHYfPhVf1qaOd5OLEU9wGla1S/kjG6hnti/fmUikOA3A6qlw5gjld7LfxfrB
         NJqp6ozipLtNw9XMI7rUp9Irra8QqUMF2tQCoMLorYg9pKhuViRox33GNQabR4FjQv4+
         j48eBQk4mdbXxhQzsruci6D7lZatVuIsDePJwGJQavbDd/UkraEaXo93g55+t409O6Bi
         JltHX8SoKoVLKeEYChK19hjDxa77ZZRM9b+kGS4qLfZcCg37GZCS0C6we8bVVncfK3Fz
         5R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184588; x=1741789388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/EDlj+KCqtnghUmkpWYPx5sg24VjMYJxMv5mgQVSzE=;
        b=I2MdbN7ue2I5WNuPDZ5TcPGzm/izSePEIVbMhXO36Bm2Fyt2iy3yVs1fzYCCZWJ9tT
         OcgrqW1cuaA23Lg5UUhh0GQMJEdvD2yMYtO6I2tgEuz0qGtE5Ox8q+fRinnUjayFQ7vN
         vcw3/ZtnE+PZHKDJuiJyCTMd1cT4Ajc/xXFSPsXIZg9baT/2wkDYLN6/GUF3ESeNbsFO
         2c+vXAyfG6lR+2Cwf4uMdcsYwhbvgQjVloN1vncbiCCQYR0v7f/G0H6o75PlXEh/DAXm
         Ur7K2OcOZKZEVJcEb+3Hn2jFVB3jfIgND5p09AdYDj3WoD8Uhwjs+HIsqrRtw93L3PlW
         DVgA==
X-Forwarded-Encrypted: i=1; AJvYcCUUjrkkQ05z19Gi8BSbu7qPZTuIg8QlrH8LzFvr3SqMFZbW+Fx4C1sLQ65hUc2AAwa2XmyxTOc1LpUbS6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJVrkZqTuxFsAvk/QDM4FLIyMb7s0PhZhv7JviS09Lw6D4nDg
	VBoj41fR76zbzZdoGVSZdSgusbroq6myG5XEg4xikQBjMjvxdaeqVhA+X5NJvGc=
X-Gm-Gg: ASbGncu/1cf0Jh27hTvpzpC1YPiW91/GoevEupdIuc9Ql6N+LtPyyac7OOatUHP1HNV
	4afIkDGUl/wGXio8kx9n9EPGpYFHxUKtOjYHrWzmEZl07iOID0RJpXwRA2ZJnWga/WR9+4UJfFU
	ViBeYVVBx3QjFnUVNeJeANr8k9ns5ESeD8nvY1FQmahqdUuzYlr1R/Z5+2Uldkrmk7Rh/+qsSYH
	NAcWFvJV9fNee9HKJdqkyknm/eQMhTE3xiEysEOhFN5ytozCwyVrjNtj52wwAMk5VCt3oNwepfL
	xLuE+PYTp9oh6FuZypnVX3uhoTQbiUPs/9Pr5lBqtqPklj2oyIzHvg==
X-Google-Smtp-Source: AGHT+IFhtHEtHPZDbikFBxfqwSObZ6We/RGoyHTAtxKyvh9iiCUNxXuSQTE/D9Gy3GIUTiWcaX07Kg==
X-Received: by 2002:a5d:5886:0:b0:391:2e7:67ff with SMTP id ffacd0b85a97d-3911f724d55mr2796904f8f.10.1741184587814;
        Wed, 05 Mar 2025 06:23:07 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm21390361f8f.57.2025.03.05.06.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:23:07 -0800 (PST)
Message-ID: <9063abd1-b417-4623-b44d-fcb18f3c71b7@linaro.org>
Date: Wed, 5 Mar 2025 14:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: samsung: Add missing mod_devicetable.h header
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
 <20250304-clk-samsung-headers-cleanup-v1-1-81718e38246e@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250304-clk-samsung-headers-cleanup-v1-1-81718e38246e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/25 6:45 PM, Krzysztof Kozlowski wrote:
>  drivers/clk/samsung/clk-exynos-audss.c   | 1 +
>  drivers/clk/samsung/clk-exynos-clkout.c  | 1 +

drivers/clk/samsung/clk-exynos2200.c can benefit of the inclusion too.

>  drivers/clk/samsung/clk-exynos3250.c     | 2 +-

drivers/clk/samsung/clk-exynos4.c too

>  drivers/clk/samsung/clk-exynos4412-isp.c | 1 +

drivers/clk/samsung/clk-exynos5-subcmu.c too

>  drivers/clk/samsung/clk-exynos5250.c     | 1 +
>  drivers/clk/samsung/clk-exynos5420.c     | 1 +
>  drivers/clk/samsung/clk-exynos5433.c     | 1 +

drivers/clk/samsung/clk-exynos7870.c too

>  drivers/clk/samsung/clk-exynos7885.c     | 1 +
>  drivers/clk/samsung/clk-exynos850.c      | 1 +
>  drivers/clk/samsung/clk-exynos8895.c     | 1 +
>  drivers/clk/samsung/clk-exynos990.c      | 1 +
>  drivers/clk/samsung/clk-exynosautov9.c   | 1 +
>  drivers/clk/samsung/clk-exynosautov920.c | 1 +
>  drivers/clk/samsung/clk-fsd.c            | 1 +
>  drivers/clk/samsung/clk-gs101.c          | 1 +
>  drivers/clk/samsung/clk-s5pv210-audss.c  | 1 +

drivers/clk/samsung/clk.c and drivers/clk/samsung/clk.h too.

With that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

>  16 files changed, 16 insertions(+), 1 deletion(-)



