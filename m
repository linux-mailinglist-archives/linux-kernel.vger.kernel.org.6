Return-Path: <linux-kernel+bounces-242392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DC92877E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D1A2882E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E01148844;
	Fri,  5 Jul 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpFF45lM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D9146A70
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177456; cv=none; b=h5vgTTzYWqnV+5KhG6MrpHH0NwAGLsJTg3NLUCfvRaVzHpTggI51nDo1H6hhSZWyVvGlooEiJ6aLK2YmsjDkpFbPR/ywQZbQIkYXEZ1e7ShxU3s3cEgSJbjwkC/5ul7HCc92R3KZ7u8cW+8ToEI3KqYwhzhoznMkJjni6gZHI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177456; c=relaxed/simple;
	bh=gzFFA5iz/FJG9Oztn1BmLja6YQotxdgEjIoPRRo+FdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdCiThIDt6Q/LbQpDhud8q5vrpOZLTX+vDl9YRswwdpKfWBY8hXGZUZ79cGco8DEKFPKxVgRAoj4H4lOABY67wvkv43UloYN5qermtRVtIKVHOkmacCGtlsbQsrd2xGXEZJN/Rhuq+bJ7aBn+Q8SkllPQII0Jm9A2ZGmD9tqIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gpFF45lM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso70182866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720177453; x=1720782253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IzWJLcVV+TWw1YdewZiMFn9FjbSkvBy18SqRor7M/5o=;
        b=gpFF45lMoAe7qFpwkrWs9ejHVu+rykZk/QlBoRWXabXHl5OIUomjIl2I+6VeWgPyQ1
         HbcItLJYUD/W5WZltWCaqvEHr+KJ+bSsjFMoZlPm2QMK2vvyBHEbgr0ocSbM/t9EEnlf
         CtkPwHUMwnD3Y4euYyFW9Hy0Z2KjdZD/wU/3uIcV0ujuP1utvRBqfnYFM2x67YxMuBSP
         RIZY8hddMUSAzo+ReHaBi0IAC1hdG5xLZXJ2shKcEz6LK4CxN50j91yUScSOofANgluw
         9desz5cs8O3le9StQixWrQM1X70PkVTkzwh1W/TMLCvNVVm+5i2Q76xsjqb8VPj2AdTa
         jwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177453; x=1720782253;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzWJLcVV+TWw1YdewZiMFn9FjbSkvBy18SqRor7M/5o=;
        b=SLGiL8+yV7nmYvGKviNW0YNtcy8kNl74sJYKJjt347jwLNFog/h8X0KlLau+vg6iRJ
         NjM0Lwf8gkvEoeJDRRpBIZ5kwVO59Ue2beEaD62CbB+HBzf1CKiWZXJQt3ViLC3+Oyy7
         Mi0vr8NhRRSg6/sXv1Sl37/OezFZxmIyNNMeH5rX29/jlHNAabgd6fkVCsYCDTBHjfK5
         oq1wJD+aC5ioKVQj96IyOI/1KcCT/Be0lqDcu8M1xwm/dv76G2U7HICFATgt95c75/X4
         sdELnTdVCuYeKCm3suONRFQfWLN9ct92+RP99T7XxFEO/xknOxO9TCOHAtNUtweka/pw
         ip4w==
X-Forwarded-Encrypted: i=1; AJvYcCVgEku08YL+thd7VDWSNd4lmPE1F8a7JpEA2d1t/SJ17tR6t7NiBZB0VjYiWpxH3r8DE2VRvXgp4UVtMyYAvfvy6L0cfSUgRlcA6ZYf
X-Gm-Message-State: AOJu0YxvYRTQilRwE0OfKx7UW5EjFoTURVtXEErP41HsUm156zNzjgjG
	le9WJX5MKVVzACYmDJwbfeoQ30sbOzXL7UZ0f1pM8nkE66wBhfjfX/R6KTzH6aI=
X-Google-Smtp-Source: AGHT+IF29OzRCHzOdP7Tf7Vq2QkYkcCMXyFdU6xoNQYAB7hk1KdFuAtw90mzQ32FsmnCP/ibfiUtHA==
X-Received: by 2002:a17:906:a40c:b0:a72:4b4a:a626 with SMTP id a640c23a62f3a-a77ba7278d9mr311938966b.68.1720177452831;
        Fri, 05 Jul 2024 04:04:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6295csm669675866b.72.2024.07.05.04.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:04:12 -0700 (PDT)
Message-ID: <d452970f-804b-4b96-bbd4-a3de73b5ecce@linaro.org>
Date: Fri, 5 Jul 2024 13:04:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, neil.armstrong@linaro.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
 <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
 <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org>
 <f207b481-f530-4f54-a482-218908869050@linaro.org>
 <78384e57-4139-47c9-ae5a-480c0d6b9daa@linaro.org>
 <CAA8EJpqmawrbXyhQ+5SrX+=F5LUuyLNnOb21SPzbg=3vbnDg7g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpqmawrbXyhQ+5SrX+=F5LUuyLNnOb21SPzbg=3vbnDg7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 12:37, Dmitry Baryshkov wrote:
>>>>> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
>>>>
>>>> What does this ack mean? You are the maintainer, so what is supposed to
>>>> happen now? If maintainer does not take patches, then the DRM STI looks
>>>> orphaned.
>>>
>>> +Cc Neil, Dmitry,
>>>
>>> I pinged and pinged and wanted some sort of clarification here but one
>>> month passed and nothing was clarified.
>>>
>>> I could be understanding the DRM process wrong, but if no one picks up
>>> trivial cleanups for 1.5 months, then to me subsystem is orphaned. I
>>> will send respective MAINTAINERS update.
>>
>> Let's do that, if Alain doesn't take his own patches that were reviewed
>> then it should either be orphaned  or moved to drm-misc.
> 
> But it already a part of drm-misc as far as I can see:

In such case who is going to pick up such patches?

Best regards,
Krzysztof


