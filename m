Return-Path: <linux-kernel+bounces-230425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BCD917CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BBB1C21DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608816CD0D;
	Wed, 26 Jun 2024 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1iVBOAp"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303D12B144
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394699; cv=none; b=lvdV0nE44bT8OksYyBIXyVmM+GBVBzX8hUq8G6W3tfpjnTlLd4qTdxWjQFjrDV5GSTpaHAJQqbqZxj3oHWSIK9TPGlPTV4VHpk1H6tHBCg8zDOCdU8yjRB/Exhzkw/so4sE7IFWakkA7BNkOLtdDSioXu7Cxz6m5mPLIFbF6gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394699; c=relaxed/simple;
	bh=c2rLFz0BIgPPMzKPVpGfu3TBAoN3a11ZKGAdBOGnP+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFNM1B7Di90ZNdqDbBuqwHyMJC417GuZes9gGsKJ7K1ZukRmErrFC/HKTbBOUmmu9ryCa9oqTPpCChIoHykCHpxe/C3JIgohVq1/IpyQIzUctXMIR5cxLaguCdihT+zVYt2QM2xtDUCSxlFEHSQGyLQF+GDpO6ENjAMP0KB852M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1iVBOAp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso7546743a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719394696; x=1719999496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtgRu1hSkNXJVH/wLpskaZQjg+HOTe4PmSs3H6aE+QY=;
        b=I1iVBOApkFCtXZW6aEsUN9r8dhydMxfOhGTxslJQbdngXiNX67xIracxFMGMrweYBq
         7BZ7XEC8pqNVNpwZlfZ/d++Zx9rHx2dYUhOOnXUE0i/HzCoy3lGZnZFCq/3cvh2Ip1sV
         5g0kZgtbe5TUQ0HXe0lMpf/+V3mVcvwptd/DCCIOUDVlujq6LJkvYHe7dxbklraCrU8e
         wZMKpG3VAOFS62UN+HYgfb2tGzAfOztp26QFmc0ky2FJu57TyxI4khIg9/HF8MsHIvnL
         NBsOd7srR3utWIGqPZI0AorOU41u4cmktTSvFzRLJp7eNDdViTIMaot6QcYTHxd76xum
         hhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394696; x=1719999496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtgRu1hSkNXJVH/wLpskaZQjg+HOTe4PmSs3H6aE+QY=;
        b=CZBt0HJJIGlft3gxjXGCPL5JcAnab2T7QZPz47dgdHK5y+05KM7TG6U5cC9oKQ4SLH
         yxjDXa2B+oymX7Eyr3EtfTWvPAgLLHK8cG/YMOLpk1BIK5KLZNo5gcLrcHJJpbkIQa8B
         WRwqSX3ZsbeDjo44owY72QH7J/I6LTKNKanRL51Jb78DrFfI7aJyVT15IthFoFZTigko
         ntucxhbFVpHP4EIxtx+8hMUMQEFj0Aufwk7qsV7FJAs3est0S4sK+yv82cbDcnj5F6FC
         +BED1hQ6s1F1WkN4DqJq8QEoOTpQWu9MOIP3tKtajE7iibIeuqC23p/os6+VAZjJALS1
         +8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUuITi3+BDqvrh6yUByEwbdX4xlqtrZxbeMi3E9UWlyLwPEe2bTN2Ng6MueIpMhBO6cO4ghegJkGJOhI7/a2TMD+yOSxrs2ia3a15+t
X-Gm-Message-State: AOJu0YyNEdSjV7lgpIzgjWpEHEJjf/WSr9UIv6huq6dLQwN++IA1zhiP
	OQdb0UpjgZvjBlHi5qLN6Yr7aG9745HkCU8juwH0YznuCseu27J7qvmmTpb327U=
X-Google-Smtp-Source: AGHT+IG8q70Wfm9EEv2AuTnKLh1TLqbrSwrYoDamHfO3r9IuQeHyXkYQ2f/eHmnrKoLpFJZtU9E2wA==
X-Received: by 2002:a50:bb69:0:b0:57c:6f0a:bc57 with SMTP id 4fb4d7f45d1cf-57d4bdd8e36mr7500901a12.36.1719394695602;
        Wed, 26 Jun 2024 02:38:15 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040f3e0sm6922516a12.25.2024.06.26.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 02:38:15 -0700 (PDT)
Message-ID: <b56ec42e-f8e2-4ca2-a40f-eb55825e800d@linaro.org>
Date: Wed, 26 Jun 2024 11:38:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: fix a7xx gpu init
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-v1-1-ff0a0b7c778d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-v1-1-ff0a0b7c778d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.06.2024 9:53 AM, Neil Armstrong wrote:
> The gpulist has twice the a6xx gpulist, replace the second one
> with the a7xx gpulist.
> 
> Solves:
> msm_dpu ae01000.display-controller: Unknown GPU revision: 7.3.0.1
> msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.10.1
> msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.20.1
> 
> on SM8450, SM8550 & SM8560.
> 
> Fixes: 8ed322f632a9 ("drm/msm/adreno: Split up giant device table")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

