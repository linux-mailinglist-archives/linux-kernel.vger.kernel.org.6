Return-Path: <linux-kernel+bounces-212725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC805906559
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3D28664C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA1139CFF;
	Thu, 13 Jun 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+XNb2Vq"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE601386D8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264359; cv=none; b=GzZ23gk40h7qLvsncWChM3cBSSY29AzTTPWq9TGcvafMoSXTGox7yE46gjQHWtgNf7wYpjOiOP48ExK893CDc+GtpexyspIW9TFyub+zjNMCTk2nqBjX8cpJiCkmeaTol+ATtOfJdSzjHUN/Ey0RmIoVl6nD8Lv792kT5UqLYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264359; c=relaxed/simple;
	bh=gvd3iJZhXkv3oS3HiOW3qGIdtOu46n2nNHFMDvtAZ4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4t0kK3Ha9DzXuHxs3yFVWnPD1++vBN/FTf0g2i7fwQY58ZCC0Th7HDNN7gUB1HYzzV8ekhIZsJF2+YqehHcXQT0e8MMDl4MSCr08AP8q4zFt9m1VcDYpdpepSWqgxxtqAxZThU4HYIo2l7sMf8ogLfF8HNS6DzW0ceD1xCGar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+XNb2Vq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c32d934c2so744810e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718264356; x=1718869156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ8kTSJ2fttE0Jg9Brzhxa9VkzxRO9QjtCb/V2tPU30=;
        b=q+XNb2VqD/glMgMtdcGr7VlsQvaS6QtUDsiPGGXw6pBbsi1GWuOSFTR92gFRodlPdm
         KnelBpeNVgOLXv6lvgwT86ICFh8BUXOQ+ZNRa3fcf8mGTeJuhwNq5/co6yoVrkHOArgR
         SVKevhgENtkwS8upOOT6rLBL7y1l0EYWcGcnVkJXjZV1YzBzJDyrQ4DFrY4OSXKcCwVy
         8xodQqMlsh2FTDxgpQe8Q3GECOy0Na/tpU38D3XYAFbUgixQ8U2YoWj3/EAbze3MJRSZ
         EHu3y+nHJ3eckLT1GifAgn4nxM7yS7pQR/xmYoAHrHd84OhXpH03E2QaHQjeOJXy6XHz
         Nhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264356; x=1718869156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ8kTSJ2fttE0Jg9Brzhxa9VkzxRO9QjtCb/V2tPU30=;
        b=FZEsWZL457XxVNKRyt2xOK3AHpQX2ydQdPsWq6VXsr9QVOe8xuGAsEd0nGBYxopHsb
         L0wlc9DoThVS+sN8APs9mPzHCswzFlSJCFIhIa9K8YrPg6M8SclgOXEvNkLCF/jRVtBZ
         EmR/3daYA7j9JPiWTR0uOzgmTWzz3iQJkEMw2+Ot989zzXMrRVNsVQ4Mc4eG9o8gqIHy
         d5h84fETsYp9MrLYTOfjzac+9HwBX4gg6CQJvkf6u3tjAg7xLnHqCmoHen9z6mMaRpjq
         qV/b8ElXjOdv8cQRuk6AfnCTNdd/PtXcDTVbzM6vCDry8cA+0RvSlHakfPNMnU3DCSBl
         AjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+93FPIWS58XeSdiyOxwJOpP/jZdjSPe0CP/ZquVb5DG/9oZaD0K/+XEfek/J8LF8chq/YyzK6pHw8vVSpO9PrcXhhIZcW3FhEwkPs
X-Gm-Message-State: AOJu0YwMkPJfLKafdoj21Ev2YeIfpb2dXQIPtHdtSUbzLHzVymuTCEaU
	eDaUF7udzI+3Y5d3+NEp/OhpivW/81tli6w+sSO3DRtjKuCyLkzk404behujqAs=
X-Google-Smtp-Source: AGHT+IGcPXEciBUgZAJMu6A19p7a0FAIiSQHe4SAYEBWGWog4rrglEIKAByhDs97NDz3T+Vmd3FT/Q==
X-Received: by 2002:a05:6512:2353:b0:52c:1c56:a230 with SMTP id 2adb3069b0e04-52c9a3b99a2mr2873051e87.5.1718264355932;
        Thu, 13 Jun 2024 00:39:15 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:c71b:4253:8a9f:c478? ([2a00:f41:900a:a4b1:c71b:4253:8a9f:c478])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282dd55sm117491e87.65.2024.06.13.00.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:39:15 -0700 (PDT)
Message-ID: <43d4f973-2768-41f1-900f-a24afe280bc4@linaro.org>
Date: Thu, 13 Jun 2024 09:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: Mark get_wq_ctx() as atomic call
To: quic_uchalich@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Murali Nalajala <quic_mnalajal@quicinc.com>,
 stable@vger.kernel.org
References: <20240611-get_wq_ctx_atomic-v1-1-9189a0a7d1ba@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240611-get_wq_ctx_atomic-v1-1-9189a0a7d1ba@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 20:27, Unnathi Chalicheemala via B4 Relay wrote:
> From: Murali Nalajala <quic_mnalajal@quicinc.com>
> 
> Currently get_wq_ctx() is wrongly configured as a standard call.
> Here get_wq_ctx() must be an atomic call and can't be a standard
> SMC call because get_wq_ctx() should not sleep again. This
> situation lead to a deadlock. Hence mark get_wq_ctx() as
> atomic call.

That's quite a word salad.. could you try to make it clearer what
you're trying to achieve?

Konrad

