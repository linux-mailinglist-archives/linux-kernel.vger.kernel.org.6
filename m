Return-Path: <linux-kernel+bounces-256372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619A934D36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C0FB217DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16213C3E6;
	Thu, 18 Jul 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT+Hy6LA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91313B780
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305629; cv=none; b=p5uR1RqQWqmYHCcGfW+RXQBtU1iJHqTS4Gb/wLYcSgrchtWl2uZurOsmCyFDv0XS04cjSWJNccXn8pdod+cdF8UwOF4ooMWPTZXMV1HTzglxO9BEJZ7h4YJ0RaAenCt9TmG1dRyyg9GXhjV6fR3KE/P+MmzvrJS1xi0/uhzQueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305629; c=relaxed/simple;
	bh=5ch03PbNO0KcpUZDwUEQITWA/MHyvkqxecTlQA6KFMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOAcp/BLxAZqF+ZqwCu5gecgU4vgMhEcCx11nOn9ffpidexUV5yoQrkYeJ/GIX3YoasrLqhvMkqY7lkeEeeirHn343NPnoqcgk5EQCWUl8AbN9FCqadLZAlZQH5sto9HgNBlDscJ+Ghg/U8pJ1I6rc8CT7AnNTV5fcnfzq0doSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pT+Hy6LA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e9a920e73so329540e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721305625; x=1721910425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q2XFn5QQgFe1WnayUef7JKEEQ6sdt3Zxd24uxnNsJOo=;
        b=pT+Hy6LASr5nE8QrvxcAqDK8X6noHc90OzYPJHY8PppHAToVUqpWjh6XlUbkuTFfPp
         2TMntZLHbMH89wGt64P/Im9Z1gvHZTTs+DPYYRExySW9ZgmkxsfyRPRagQjnFoSpbsHw
         wWss57xlTuE2xWE8PgtCJZFx8NMQzBYUix4HkPQApbV1cwMVO0EuoKaEJ2INLGoaTnVg
         NTlW/Tl38wlydVQIHWpWn3d4OgNXDNeXYYcwQ+HNxXpgDt7dtJ3gkMr5uRDu3k4oMeED
         oCkd2iU7H3xbU37tSr2OP9eJATD+G9MtlzLVOTu6MHdHG7rpRvPFn+xVLg6CAn0KR0a/
         ujaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305625; x=1721910425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2XFn5QQgFe1WnayUef7JKEEQ6sdt3Zxd24uxnNsJOo=;
        b=IKLrGx+FOrgIaZdwNbAqdZwC7M/jeGgukrMIU8ZvORaZs8bNX/R/78WLrwFsoByIER
         MzpkWF7yC3ArRnpMggUqTh0wqpjSO9N59KtAkzvm9/zbQA1/n9LgvQZQUGFpQNxqcEzp
         sDUjc85gGUbi6WwPogG6ff0h0XQTGUoofjlbsCVXxBTRvqtRHmK4OUlXYEtbpXLopmAo
         1USARK0oOlmfyA6nOsb6IyblOG7jB8/whrHWRlITIhrW49oHhsye1dvdZEFHy46WpJ4s
         D8wpTx+ZZ1rtX3NShg4vk1LZ17Rtb8jNyN0rxvNHjFtmr+gFYQWiecYxCJlHt+ECpIgo
         /nbg==
X-Forwarded-Encrypted: i=1; AJvYcCWHjC/HpMVobDpDTl9pyXZYcBVY6/BCQCRRo+XsLmNKgYXp33hCavMx9kkll/7qHdw2gibN17yYB5tlO5ysrsxWtXh9Ingi0AfOcI90
X-Gm-Message-State: AOJu0Yyds+GPvElWYZtpr5O47AxpBga2aZERO38gdCa9AxGNFbdYmwzB
	Uvt4KMc0EBpBh2/wV9KX4z9P29SeNKa4EvYNlh92vb9aufSv6O2Q7sO6HDRjc1Y=
X-Google-Smtp-Source: AGHT+IFpho18lmDKc7X0msF9sfCuM30i0lyf/vediCfHZae4eLSGRU9CVd8hHv7u8hXrqS7690aQVw==
X-Received: by 2002:a05:6512:130a:b0:52c:e17c:3741 with SMTP id 2adb3069b0e04-52ee53acb53mr3121740e87.5.1721305624269;
        Thu, 18 Jul 2024 05:27:04 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a38c2sm551628566b.44.2024.07.18.05.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 05:27:03 -0700 (PDT)
Message-ID: <fd74e1e5-a652-4fd9-a4fa-d44e1482a9b6@linaro.org>
Date: Thu, 18 Jul 2024 14:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/msm: Extend gpu devcore dumps with pgtbl info
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240717163627.43423-1-robdclark@gmail.com>
 <20240717163627.43423-3-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240717163627.43423-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.07.2024 6:36 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In the case of iova fault triggered devcore dumps, include additional
> debug information based on what we think is the current page tables,
> including the TTBR0 value (which should match what we have in
> adreno_smmu_fault_info unless things have gone horribly wrong), and
> the pagetable entries traversed in the process of resolving the
> faulting iova.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
>  drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++++
>  drivers/gpu/drm/msm/msm_iommu.c         | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
>  5 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 99661af8d941..422dae873b6b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -861,6 +861,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  		drm_printf(p, "  - dir=%s\n", info->flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ");
>  		drm_printf(p, "  - type=%s\n", info->type);
>  		drm_printf(p, "  - source=%s\n", info->block);
> +
> +		/* Information extracted from what we think are the current

I'll keep poking you for not using

/*
 * foobar

instead :P

> +		 * pgtables.  Hopefully the TTBR0 matches what we've extracted
> +		 * from the SMMU registers in smmu_info!
> +		 */
> +		drm_puts(p, "pgtable-fault-info:\n");
> +		drm_printf(p, "  - ttbr0: %.16llx\n", (u64)info->pgtbl_ttbr0);> +		drm_printf(p, "  - asid: %d\n", info->asid);

0x%08x?

Konrad

