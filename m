Return-Path: <linux-kernel+bounces-231645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F5919B49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A731828183B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE39194A51;
	Wed, 26 Jun 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhdYsgFp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FD1946BC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445148; cv=none; b=BrST12Re7C3fRjMIjnKLMhNedioWBGBuViZcoAwJqUFAKNFrm8TD6aLyP9mWBJ3VBvSEP7YQshuGXRNLIYHxXqIxGFT1dd6yTCGCvrJeOGOsSD1of5uJOgBb0Dw38Z6ckuXpoKqpu9TVKMETOWM3XzWgNFHSQRrBfjWcYXO9qiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445148; c=relaxed/simple;
	bh=b6WYlfkbjmi7vg40d8+F6oKkGWP0eLaqM1jbxdGWZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7jewcwf0d2jO6RbAuyxhWnwnKfNTrNClWsk6Era0VjpJ0uco/zoqUfHLvn15PMYDB9z/pojaQsHb0YcsGxIOwOoR1WBAf7uIsTTx1srfkxuyxu21P2vj6nMr2s9tQGD9fEGaVyzOJvQo5tbO5XOirELrI2PAzxzzu6dVTufFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhdYsgFp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa4b332645so39955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719445145; x=1720049945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3pmB34cCwtjnl+eYO8f6Z1wbmFiYiECc2kegHJsZVI=;
        b=QhdYsgFpqnCTNhhQJzsxrR/t4xE747dDo8ikQcVYTChFnC6GcJptwEbnb89ma11dO/
         TypW4FWTl2wzneOiH1n0TQLN4wTexHT7cF5h7hggzfvGDReFT4UOweBU8KvPEcK25ruG
         SPI9iJFVC6Y/T18tqmiHrwBYOQuOvrDfUXBB5R5hUbOqhNelv+bgeLmamde57tVo2Fv/
         9zAU07S2cJJDbfkqZj1DIdBWZMk8gP76f4A28HUyshD9dbi2JUZmrVl1+mc6PFaUP+LT
         SJE0palp41Dkivfndo023opoLbkU9ZrZ/Z6Yyeh8lwIbAq/MQZGpL9TOeiXHDDz7ZOJi
         pDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445145; x=1720049945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3pmB34cCwtjnl+eYO8f6Z1wbmFiYiECc2kegHJsZVI=;
        b=WLFOVb2kXb4a2VP47/U3RlyXLYHu4BKT1fS9ANknVCIQ+IgT2VX8F+CnAoHIP47hUS
         eTANPxXk0mWedbQH6gdBZ0JqiUhQHkP8YJ2YwsKjjxgoScOyMcPJ42FxSTEiykP6/6dt
         Gqi+9T9g38Adz8OaAAowpTjtLgh6+/NNlPAYn/SBrln+CEhhickfsEi2Ud5ChZq6uwrP
         DWTNSkWb8o2ibPFd7igaLqlOse2oaIo7hJX+BJbEKaeXMig0KrZHOAjS9vaeiy2Cf3/L
         qzB4DnOB/Dl8WTvdJ5kvT1duS0lt+2CqjbTfG0YqwOVtyO9pK7Yu0MkOVV/nOYdxXK/o
         dK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbbDm708VMBN1oe0BwNkXrMHjcqVlDIKVkwXiH73W5JZKFrwoOByi6BxWblBZFFb+HNA9EIiKm5XCJFtlGFcJ2Oj1frnK5J/qxJOIO
X-Gm-Message-State: AOJu0YxuvfznuMddXdvzGzHvtaUVw1aIxgjOvs8waOEtT+DrOL8sd1CW
	N5U6JrQ03PiimBYOUaMoJpD6msfhc3YLX4xuGvH2O6t1ETkfPRFZ3H4GnCI+Dg==
X-Google-Smtp-Source: AGHT+IHRdsS+/Y76sEwDfKIkrb+jsZorceifOYSrWmMRro/2TsN9MxZqihS12VYFCI7AWUK+mR2ByA==
X-Received: by 2002:a17:902:f74d:b0:1f6:5bba:8ea3 with SMTP id d9443c01a7336-1faab5992d7mr812505ad.25.1719445144627;
        Wed, 26 Jun 2024 16:39:04 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac99a30fsm527375ad.223.2024.06.26.16.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:39:03 -0700 (PDT)
Date: Wed, 26 Jun 2024 16:39:00 -0700
From: William McVicker <willmcvicker@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: samsung: exynos-pmu: add support for PMU_ALIVE
 non atomic registers
Message-ID: <ZnymlHiCCIDt2dCJ@google.com>
References: <20240626194300.302327-1-peter.griffin@linaro.org>
 <20240626194300.302327-3-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194300.302327-3-peter.griffin@linaro.org>

On 06/26/2024, Peter Griffin wrote:
> Not all registers in PMU_ALIVE block support atomic set/clear operations.
> GS101_SYSIP_DAT0 and GS101_SYSTEM_CONFIGURATION registers are two regs
> where attempting atomic access fails.
> 
> As documentation on exactly which registers support atomic operations is
> not forthcoming. We default to atomic access, unless the register is
> explicitly added to the tensor_is_atomic() function. Update the comment
> to reflect this as well.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Will McVicker <willmcvicker@google.com>
Tested-by: Will McVicker <willmcvicker@google.com>

I verified reboot and power off on my Pixel 6 Pro.

> ---
>  drivers/soc/samsung/exynos-pmu.c            | 16 ++++++++++++++--
>  include/linux/soc/samsung/exynos-regs-pmu.h |  4 ++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 624324f4001c..5556acc7c092 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -129,14 +129,26 @@ static int tensor_set_bits_atomic(void *ctx, unsigned int offset, u32 val,
>  	return ret;
>  }
>  
> +static bool tensor_is_atomic(unsigned int reg)
> +{
> +	switch (reg) {
> +	case GS101_SYSIP_DAT0:
> +	case GS101_SYSTEM_CONFIGURATION:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
>  static int tensor_sec_update_bits(void *ctx, unsigned int reg,
>  				  unsigned int mask, unsigned int val)
>  {
>  	/*
>  	 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
> -	 * as the target registers can be accessed by multiple masters.
> +	 * as the target registers can be accessed by multiple masters. Some
> +	 * SFRs don't support this however as reported by tensor_is_atomic()
>  	 */
> -	if (reg > PMUALIVE_MASK)
> +	if (reg > PMUALIVE_MASK || !tensor_is_atomic(reg))

nit: Should we just move all the logic, e.g. `reg > PMUALIVE_MASK` into `tensor_is_atomic()`?

[...]

Thanks,
Will

