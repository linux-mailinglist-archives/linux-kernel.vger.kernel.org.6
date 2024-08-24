Return-Path: <linux-kernel+bounces-300094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77C95DEC6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAAA1F21EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D08558B7;
	Sat, 24 Aug 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XR9HEKnX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A01EA80
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514711; cv=none; b=QM1fCBY10LfGnMVdw6n9xuzepdLDCvQEPoCmPRUqDcOi+GjiL1HRUAlzf2iV8IExSUE77K8JWTzGX3VYxXf03CE+d9j2b6Yp27FUDSvotP2SOhlGguxqf68Cvp/Yf8Hrqh71+Xs7Qg6mJ+GAPfKqDVlmtL2mbWm2PgAEa1x2re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514711; c=relaxed/simple;
	bh=3rsoY1FU7PXt2i1P2fvZpI0bI0xuuXcGJKQ4ihibeJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3DmTEgFHWkKC6H+MkyDsKvU7HVoX6Wdum5W6GXsgh01Exn6tgLUG+gfwMAr/Fen9X9D1ZX8KA+CfwigiCi1HFUUPMTL7CVv/vBWJ43VBMjkFdYAVOznoQgJQ2I/RsKOEe1hZhoZKk6mYnjn6PUHZekGvlZdGpxul2mD77DsR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XR9HEKnX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so3709293a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514707; x=1725119507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cyZK84w2Us0lGO2sQYjQnsuOgO/XxSuKCL7oSJjQ6s=;
        b=XR9HEKnXHXy4sTzoiuUOX2majmSmzXnRlhB8aLOXFikXPe3Lgb8yBrr6XleH/L78Qm
         LO38MOUVirx4CgTxsFqXdwsO32tGYCgoYnq1tKpqm9g059hROuQeQ4C6tW1pVEp4OGa+
         /xUu5e1nmich2zOSOFg2yalNXGh2iUiWv8AKuhws3FsdeoBYPtM+JOBPHpsC4U9F0Y26
         IINAWyToSOuAyqwTbu4mLUT0pElRLE+s4hh57LJWGRmqzvfCPLNK8UKwEnwkB4CeFerb
         GnLUr0ULuZUWaTaKj9jvZButzZzWJpYGR/GXSjEu/+hJG7JSTWnwvxHy9u7Y+gHjOQQ0
         esGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514707; x=1725119507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cyZK84w2Us0lGO2sQYjQnsuOgO/XxSuKCL7oSJjQ6s=;
        b=AO5b9vUf7knhLI6H6u5DX3N1RBfCcRnZBsE5Z8hOO0CcBa6tu27iBPS9H/uKdw4RoH
         3IowQWXVQg5mCt9LT/HzcJQitnIwhSU+/6Wt6QynIkPK9doVbYgzqqlcqxZwJpo3ZvKv
         fl+qw+/mnEHmklSrv+zMUmeuyFtHZYX14fgH87wjABcBH6yVGxmfcczT4UdTN5RT5DTx
         Mtwhw3xYJp2MfGLkEIc5zhRGhqFAOESoS9tblsABi4j68qGgstoeOTkShLh5CbCnVnct
         FO6qJH5gW6jOrlRTP770Wmt5k/0Ih2oUO4hZtm7hwpIYCr2M007F44Aey/ey2+P6lDZ8
         tdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf1+RdTZNORe+opVneZ5Icohdmo+TNUpLMVDWsGidZvNZ8COIjhAWdSNEhjFkdmTl1uZEbqTYK63z3F88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItNEpbFyG7+PdQ1UaFFLtLnr2ByoZaMwlQaFyuEbIW76KYfTW
	qx4/aRxXxLmbeo5HSFX1AKHHsGi375xJouQ30fpCFtTxNiH1ra0lUXOz9q+GhVM=
X-Google-Smtp-Source: AGHT+IERgC66zmHL2W8RzwCYkyDM4LDBBVFXQSL98eF9JOj0PY+R9szkItVKcF/bn7lZrb4grpQMHA==
X-Received: by 2002:a05:6402:34d6:b0:5a3:283d:b05a with SMTP id 4fb4d7f45d1cf-5c089171c7emr4131347a12.17.1724514707235;
        Sat, 24 Aug 2024 08:51:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:51:46 -0700 (PDT)
Message-ID: <5d2a6498-57c5-4fb4-9a68-e35072f4b8e3@tuxon.dev>
Date: Sat, 24 Aug 2024 18:51:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/12] nvmem: microchip-otpc: Add warnings for bad OTPC
 conditions on probe
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-9-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-9-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> These conditions could affect correct function of the driver.

Can you please detail why this has been added, what was the issue you
identified etc?

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index 4630e96243ac..a80535c3d162 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-provider.h>
> @@ -260,6 +261,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  	struct nvmem_device *nvmem;
>  	struct mchp_otpc *otpc;
>  	u32 size;
> +	u32 reg;
>  	int ret;
>  
>  	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
> @@ -270,6 +272,16 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  	if (IS_ERR(otpc->base))
>  		return PTR_ERR(otpc->base);
>  
> +	reg = readl_relaxed(otpc->base + MCHP_OTPC_WPSR);
> +	if (reg)
> +		dev_warn(&pdev->dev,
> +			 "Write Protection Status Register Bit set: 0x%08x\n", reg);

There are many status bits in WPSR. Some of these bits suggests warnings
even when their values are zero (e.g., ECLASS, SWETYP). I don't know how
accurate is this message.


> +
> +	reg = readl_relaxed(otpc->base + MCHP_OTPC_ISR);
> +	if (reg & MCHP_OTPC_ISR_COERR)
> +		dev_warn(&pdev->dev,
> +			 "A corruption occurred since the last read of OTPC_ISR.\n");
> +
>  	otpc->dev = &pdev->dev;
>  	ret = mchp_otpc_init_packets_list(otpc, &size);
>  	if (ret)

