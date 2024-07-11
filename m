Return-Path: <linux-kernel+bounces-249008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DA92E4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C66B281295
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07C9158A35;
	Thu, 11 Jul 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzDk7b7k"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6115748C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694536; cv=none; b=SnvKE3ckh9rA+O0/K4RSKNuPopUUmkxHk6C6sP+fGP92KgnjolzTDZU67yWEBJxzXOIQKrCc+FOV9u3bimJIaOxCOM5LS+Uw1lmvvoN32G4wfb/mSjDfZqmBDkBswhpTKlH1/kDtQN6VtJ4w7hT7qmTBRK/GyJfOupZxJZQSgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694536; c=relaxed/simple;
	bh=U96uAEEwrb/sj5LnOKS9rX/+t0nhVAh5wKtzNWTuP0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqnywqvzSy4XkfPZrOvxDbUwv+z+6LJubc6g8N0kFsYPM2FVZRlFe6q8fNhRxXlrYZD0il/2FE8gcOczOZwmExLIl2wmw7PzUy2RKLu7qBS8wNC5JKkrLPlMytih+j9ruhASCGC/BEHoh2rzkLG3cbQIbhp2zDbgcQlMHdz0qbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzDk7b7k; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1209800a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720694533; x=1721299333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtxqIAWIiTUKLX6AXhXVggOKB10pYOSotqE522q5edk=;
        b=vzDk7b7kjO7Rv/QifSKEEGNb82fgT7sRjGucVwW3WZqxR7EgQxDYVN+kMeIai1PGue
         HOTCeErGIAA1g9qetcmoCwv53BZJAddXxBXvp0IxseQZ34lgmLPoxuoU/V9s8KG28Siy
         xvaYZVhWV/dO3pw9gtZMJxVF/F00XDvF2cH4itb38S3E97s/UVMU00ba8t31o3CGSgOz
         qJeEPK9hQo0bYyV+4q2qJeCtH9qyDj/2YHBZHrydAU5VkUY5k1rBOzHZf96t0G1d/ARZ
         4NOfsbOt1MCgcxgxkudOMhVGhVnajrLN1ZAxO9/wOUOTTz4+s/4pQzd51MmSb3sDGG6a
         CaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720694533; x=1721299333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtxqIAWIiTUKLX6AXhXVggOKB10pYOSotqE522q5edk=;
        b=SBemMVT0sqsmcP/R22o8F5M7CFCY4d3g/zGP3iJ7qsIQ/7UQRYY4UBbifI7CGu5KIq
         4eQ8QX5deZztb6KY/9n0xsrU/cX+jfe8mZu8EjMJ5GpBU3lypqFnvdcOiClkzh1W81Cn
         tkE/mTVCn+PM3rMBd6FrhSq+JilLngpLuL5rBaVGuCHvAa7Ov64uLPcCfuVTJUewlqhg
         UY/I+cGQgUesdGn2HLVEkN/2j314Au/ySFvDXJedHB6oJjxx6kRj5xqJe0KWazLrWLzD
         iHpVp2hixZbel5dm1jiQdjh+bMAt3qesQt7Al6mtAvQ4/Cqrn8NF9U5opSpn6DptXEzM
         QeBA==
X-Forwarded-Encrypted: i=1; AJvYcCVG5QXryhtU6dpLdjMTR+VkPQeneTFm6mm/anaPaVUPT3JKHahwKBPneGP2gsmvRhhPDCUZo9lHqjwEPnsTtnmSYy5yYftzTn1c6A63
X-Gm-Message-State: AOJu0YxVtFb3oqSAasBzXzALHiK/LusoTfX0S8WgJz8wDo1W6ebSPLdU
	KsFnewuU/l3JQtmVF+st03Bu76bh+o7IfphA8As2CCb7awytLn0uiIVwFn64LWs=
X-Google-Smtp-Source: AGHT+IHk9aH+XY0uDq3os2yKd4DG51Hj7jKRYmxb0lTlr5Pw9fdKfxrwFD45/AkbwDIihG4ST2Px9w==
X-Received: by 2002:a05:6402:50ce:b0:57c:c171:2fb6 with SMTP id 4fb4d7f45d1cf-5980c8f9a89mr1901423a12.1.1720694533179;
        Thu, 11 Jul 2024 03:42:13 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba54b07sm3293826a12.14.2024.07.11.03.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:42:12 -0700 (PDT)
Message-ID: <5c4b7519-50e2-4de8-baa6-39a328886d34@linaro.org>
Date: Thu, 11 Jul 2024 12:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/a5xx: properly clear preemption records on
 resume
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240711100038.268803-1-vladimir.lypak@gmail.com>
 <20240711100038.268803-3-vladimir.lypak@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240711100038.268803-3-vladimir.lypak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.07.2024 12:00 PM, Vladimir Lypak wrote:
> Two fields of preempt_record which are used by CP aren't reset on
> resume: "data" and "info". This is the reason behind faults which happen
> when we try to switch to the ring that was active last before suspend.
> In addition those faults can't be recovered from because we use suspend
> and resume to do so (keeping values of those fields again).
> 
> Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

