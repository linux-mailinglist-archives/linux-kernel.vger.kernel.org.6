Return-Path: <linux-kernel+bounces-193969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C78D34B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B741F2393A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989BE17B4F9;
	Wed, 29 May 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvxUVA65"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773B16A38C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979283; cv=none; b=bkmL1UCtfkN+0KIEicVHKTJ7XzbZxxwWLrUxhR4As/EGscIvxtWU72WmFG+NFaTXMHjTd2+n85xek0SRLISmvhx43LyP287VOEHM0I7abAlpkqVZhO6b4sAyrOibc6PbZD4sUG64eotXzQ9cEVuKI17HcGj8cxthbR28DYeSQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979283; c=relaxed/simple;
	bh=CA/gJtzVIOXbSxBYf9GyZuSLnbZ96s+3qD9KnUlRTog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBIax88Ut+pDJJ9qYsbF7tPtX4k8PhP2e6tNk+qiOElV4UThaVzOgs0+HoNRQPsLTr3kFNdxM/C9kTazR3yZWjdpUTLNVMHQfr9L+OcPvkMjKF639cXkG41VR8BsThVwwJyjHcM9RGc8CkkbU5tX1Pa55gxSbqFy9fslYYqyHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvxUVA65; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a033c2ec2so703258a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716979280; x=1717584080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sla1AgMnfTvaVQbJp/AkvnN3q3g3If3gBgcTVDSAp8U=;
        b=tvxUVA65hI2e33xHZ+CsAJRJuQvmbVYI/jEFpLKONHQyNOWsEmuwXdftI5uJt8udlk
         z6JETDGTZSToW7UA36vNfnJcVJUjFmkibsRhLZZBfgPgTjzJIH+REqN5stOB95v5UBvt
         1s8+ZtFkQzMUiR6/yLTkjEIY21oY62N/FopJNv7zFH1ChafSLXP7Jl4akcXBUZJC39cR
         Mmewvec9FxW5TbW9F/Ha+mQZhLQCCj6s8svnAhkq3BaqERaIIGFr2SbZhj1eLElXODk4
         S0PX1Y+rjmNNA5f1y7p806wRyQiGl42YyxLKn8hqWcqBoVOtrmTRmEDUXX+qSik1weWR
         SWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716979280; x=1717584080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sla1AgMnfTvaVQbJp/AkvnN3q3g3If3gBgcTVDSAp8U=;
        b=GTPhado8P2ZTGKho/ka40P9+LETS4LOy5Ac8Ui3N9HjnLnj1CaE1aXh6LNlYCAmpzd
         xyQ6ZxNShTeZ2ib75nFGNfZAFjm/NN/i81vuA0tGZFYS11J+yZ3v6klHq5poU/N6ICf7
         fsTJkslOf0fJkpuuLsNajdrFS3A5m5n5j3xSg9pSPTtN3t/gAiWs1+WVeDNWD/0b/KxI
         2TWGKrtF30rsI52jX6nSv579tcE6Wv8gweGXpdl70Cj9oxLC9+sAbcW5styjHK2nwVPB
         pWyvHkhRpFoK3PnsXdW1lWKnvAnyaL9k0ZGmLOuOOX2s+Wdh85J4PajiLE5t9oSr77l0
         2khw==
X-Forwarded-Encrypted: i=1; AJvYcCWlGanE4hPsZ6Bd+1yhqodq6GuvtSN7EE985ZGKNgRyvaCcI/6O4h7VYfYZkfThQaGxWZGUUEJj8FgONhbrfGYGmY0DAmkFiXIXHc+t
X-Gm-Message-State: AOJu0Yycu5Rmcx4xyeJs3ZHXZZ4c9wV9EE8G26G72XnUOE3I/KKDuzDP
	znek5yF9oOUNa1JJEs2zIGOAirMTPf/plKnYl8y+/huoUc1be4pQEZ2+Q+s3DX0=
X-Google-Smtp-Source: AGHT+IFJb2R+Y16iwF/EewPOwd9YBStxfjgZzM8O2br3b03khmAr2gwVf6sHjTgvjvuxyJ8HDT025Q==
X-Received: by 2002:a17:907:82a5:b0:a5a:3da6:7712 with SMTP id a640c23a62f3a-a6265134c8fmr795610966b.71.1716979280376;
        Wed, 29 May 2024 03:41:20 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817ad3sm713720366b.16.2024.05.29.03.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 03:41:19 -0700 (PDT)
Message-ID: <76a124b6-8cc3-4060-866c-03f47da450cc@linaro.org>
Date: Wed, 29 May 2024 12:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Add A306A support
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20240528-a306a-v1-1-03a66dacd8c7@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240528-a306a-v1-1-03a66dacd8c7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.05.2024 9:43 PM, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add support for Adreno 306A GPU what is found in MSM8917 SoC.
> This GPU marketing name is Adreno 308.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [use internal name of the GPU, reword the commit message]
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---

[...]


>  
> +static inline bool adreno_is_a306a(const struct adreno_gpu *gpu)
> +{
> +	/* a306a marketing name is a308 */
> +	return adreno_is_revn(gpu, 308);
> +}

The .c changes look good. Rob, do we still want .rev nowadays?


