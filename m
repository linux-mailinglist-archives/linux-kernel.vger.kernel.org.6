Return-Path: <linux-kernel+bounces-515031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774DA35EED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB49416A5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D03265CB2;
	Fri, 14 Feb 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctv0z7XD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D1263F28
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539129; cv=none; b=sgR4CscGyOl4c/fwrWGYPvloWpEB9feeClDefHsY8jDvEoHofIKyc9yWltk3atsYYeE9eXh29RBDCqONzQlbfvLI6DxYaUnxyEPsQS/fnkwK4IOSyxlYgB+tsosV5yGvTsV/Sc4WQG0bJQhbW5Atza6UQQv/wgZgkvtSshVcmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539129; c=relaxed/simple;
	bh=pToG4Ksx6o1gvuZY9Gnggq0zrKIa+mtMW6XKamS6PUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWxg/T7V1lvV4DgjwlG4BisM9KTtXfUbUr8CZGXGnTYHPMBwzI8O1NQFNnrwDrldLqUZRUG96PMkAnV4spO745r4NdccBqg/8QJqWDZWoK7hjKJSP/G+e5gKd3bO0dsMlhV5NkRW/IclYFFzgJYDqmkgZPPzHrWNxyXWhqPhmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctv0z7XD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d398bea9so28100985ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539127; x=1740143927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UIFBSo0KZ65tGs7lIwblNS9Ead+3QceXTUKjiZlNVB8=;
        b=ctv0z7XDuXK31acl9Devz0DHtUVZ3OKiM/qZGpi4P7YQjA5VxyuHJWoei3OQG2YNzt
         Rg8vJ9t9t5wemGYZs8kL1aPvfR1AHMUBKqo2yJ3tcobva2pkiKFUkOO6XDUm82s+Kzla
         qfxId+xZqpCpQdeZnfHQf+mTzlw7YPVLpy2kMBA2h6qOY7d2exzHYP+/sTSCYAzwEhaS
         DaUsm/LD3+S1NvEPeOFZkJ4GyGzxe3jSZtEZLJO1GYS5TxIchAn543+h8R034+mtfnBP
         Ii/wQGcOWrjzh8op1Psicu5G9uUIPmmfyJzQnXV7My2ubez36cZLnHL+ua7sA3Ve7cEZ
         a9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539127; x=1740143927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIFBSo0KZ65tGs7lIwblNS9Ead+3QceXTUKjiZlNVB8=;
        b=VOx6zPqfDaHx74tOuB8pPx6MjoXYjCiIhXvnBwashPkteaeBkROMVtGE/Kp+ZBsUl5
         9EqJ1/CbNWEwIfa33Y2kSVezzFpwiW8yDkwVWuk9YOywHjNJeUlbrRY6VkrUcLzpf12J
         qRfaaeKu/BQNEaXg5qoOniJSAlSsMjeEaBdtnqgrRdFElD7RjDxMV95Rg2R91y7gv2ci
         DNA+MwxMzQl4C1sVqcTaVzWKr4vu+9WX+B2r/87yCEpTEzXGrxRyTZtBdDinj3iFP8mL
         2OBxX4FESzoxpb0DdjScRSde+D5sr4g7VUVnsZHm/yQ0IlHvQECtTb6ATq8hOQzarlea
         Z4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWrdYqbt7Norm8MnEXvMOjP6HH5uR8ho/wQB+dQ2FlL+NZgCZxRrcaeyetfkRP7NSyhiPrnvBaBIxUj+a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1c9vg0nQhGDbUViVXACl9P3t7uihSvByFjJ3eOTQyyQq8FRG1
	rQKatTN/LCjjYJFCJmUn/h/DTK4Fb1aljWjYGYON1oRbBIgzHFU7IfjHZHEfKg==
X-Gm-Gg: ASbGnct0T1MZS6pyYYz2JVZpyBpJZIOTbC20KoiZcZH2iwi/QDPH2UmQ833DKujQhIo
	rdaHtBw6zWhaPC1eNNt3iBUMYNJoVPibArKN3yqe/PJt/uW7I7utYxZSajIB4FxkE/TS4K/cvvR
	p6H5zBJuDkpafylKA5W+M81gNaScLLJRHZsf+AHhIV2QY8tfrhrGkLciz0fsCkTjkncW0V7Rmgj
	hmBE5ebEPay/KHyRJieE8whxhB1Sociwx9ZgRqRgSISMpV0T2aT7hQ3wrZq5T4eI1bC6gJGxlME
	37hSOx+F0rCb8siWkZQB1nnTaijkNCo=
X-Google-Smtp-Source: AGHT+IEEFI+Q6slwYq+gvb8gGXdWQdiInLwAAJ5utThRzTzCUAO3SUSNbGpqXGLiGQM61ve1oAUoYA==
X-Received: by 2002:a17:902:e887:b0:220:e8a1:c819 with SMTP id d9443c01a7336-220e8a1cb06mr72616895ad.34.1739539127170;
        Fri, 14 Feb 2025 05:18:47 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:250c:8408:d2ac:10db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491ecsm28668465ad.9.2025.02.14.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:18:46 -0800 (PST)
Date: Fri, 14 Feb 2025 18:48:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, andy.gross@linaro.org,
	vnkgutta@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qcom: llcc/edac: Correct interrupt enable register
 configuration
Message-ID: <20250214131840.desyshjr3dbb5lyl@thinkpad>
References: <20241119064608.12326-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119064608.12326-1-quic_kbajaj@quicinc.com>

On Tue, Nov 19, 2024 at 12:16:08PM +0530, Komal Bajaj wrote:
> The previous implementation incorrectly configured the cmn_interrupt_2_enable
> register for interrupt handling. Using cmn_interrupt_2_enable to configure Tag,
> Data RAM ECC interrupts would lead to issues like double handling of the
> interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be configured
> for interrupts which needs to be handled by EL3.
> 
> EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to
> configure Tag, Data RAM ECC interrupts instead of cmn_interrupt_2_enable.
> 

Cc: stable@vger.kernel.org

> Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/edac/qcom_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index a9a8ba067007..0fd7a777fe7d 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
>  	 * Configure interrupt enable registers such that Tag, Data RAM related
>  	 * interrupts are propagated to interrupt controller for servicing
>  	 */
> -	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
>  				 TRP0_INTERRUPT_ENABLE,
>  				 TRP0_INTERRUPT_ENABLE);
>  	if (ret)
> @@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
>  	if (ret)
>  		return ret;
> 
> -	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
>  				 DRP0_INTERRUPT_ENABLE,
>  				 DRP0_INTERRUPT_ENABLE);
>  	if (ret)
> --
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

