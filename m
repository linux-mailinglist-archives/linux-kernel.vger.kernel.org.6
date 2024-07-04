Return-Path: <linux-kernel+bounces-241414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2436927B31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242001F23CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28781B3720;
	Thu,  4 Jul 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHA7sDma"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242D1B29BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110989; cv=none; b=fKW3o+ZJDMPSjXkm+B/WfIUOZIqWlOm3EhiYauav0crtg8fG5UJgfSdInuREjTCMSM9x+olF488B0zgSAZQkFLBiUtMcjfTl5JL553XQ076ARyFuajEdma7GKnvo7IY4DNZMFhTGs4cWOPXZdTJGE7EclGAzP+W0K01q7C2XNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110989; c=relaxed/simple;
	bh=Nz8JYI9JXyUch96AAcnh/w13QSZg/uosfmFA78Nxdew=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q/Hz0ZPJYTtFwWrsywcvzv+WUXri0f6advtdtzReUuc8ZIsXuJAbW3u4IdZ1qPaUrUgRbHqiLVqeawdo90YMQld2R8L3Jnc3an4BducmWFhn3VswUyts0PzARmrJB+fHTus7ovtrG3Yu07me+C7B1FnMQVTl6MpKHoxIgxwMMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHA7sDma; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so6998465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720110986; x=1720715786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKajYCiQ1iiVMwCAgWteL1H9aoRr4BQZlud4q/bPLnQ=;
        b=zHA7sDmakp6oxjKZPyA78ibl8k9gIpVSClZ/eScPwTy8D2yG1XUCzFjUNgdTIja7AY
         8w2ouW/B8ih049jmwg8IvpKY8y2GK+bmHRjGfWmbPhjbOQbqeQSTjPL1EIv9tGxhKg4Y
         +eJE3m2vcdthLo0wRbVObZCjCHugD9P1G0mju6mDSMGmSHtS4KsddAG75BZGfLjCX9RS
         KInepHYBYzKgzioOmLUTpHPv9YuJ1EKxLaQug9llMXIJ/0gsVbhkwKR7mYPR0ItJR4RO
         3Ixbc9hcAz98q9lErywbnlUqHUagvRSjkm1ftibZUX/kji1C6Q4amEtmWWDow1bV+BgB
         5K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110986; x=1720715786;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AKajYCiQ1iiVMwCAgWteL1H9aoRr4BQZlud4q/bPLnQ=;
        b=Fgrm9tm9klCfG4V1pfL7IBK34023XnAHWDjoeZ08w6fngDgZaO6mrKKe12ROBelVjJ
         sOjJS4s3BRG1TQeiZqPeeQMgvPZ83aZgZehG2c875L6wEige9Joa//VqgUROCZgUMDS9
         eixcUJqBArtzNgaNf4u+UXtCXaBXYKDC1ZU2eHLnUPXBAMAQXD/mpqo2RsCtI+G5sx5y
         4DjBQZiiePPGtAQy2Xrk/M+hzL6c2eDiUmoTZo5KGe2blYIkTEoGCw6XFsgZ93vvGiY7
         y5Ssu2zGhwNGwbHsVq7HVwbTi6ioNr55NFJZcTuWGcT3zuxBN991e0+hHcOZ285OcsOB
         K78w==
X-Forwarded-Encrypted: i=1; AJvYcCXEZuQYlz99v+HnAMmDb4jVDRbVZziGgjMLxw/H91P79DQL1LYGAeFVRAxhamaZPS5dK6RgHtPO34f/dwvcw4bFuC5IIIA6agIcAuv1
X-Gm-Message-State: AOJu0Yw6rrU2oCATV/PSeKZOHqtHpU6qkD7z3JmkOTxKe7CwD+M7NRZm
	Jpfrk0z0H/BG/nosPODwz7OpE9UM2BXh2LzZvlS3QN/zODDIJvmzYi4+T262j6A=
X-Google-Smtp-Source: AGHT+IGre5UpCw3OECL+/TGIKu3h1VxlZMRFSjh1l4XV2EnfvdObWplteMiozjrCw186NnwMFbnfmw==
X-Received: by 2002:a05:600c:2182:b0:425:5f90:ed4a with SMTP id 5b1f17b1804b1-4264a415f3amr18062695e9.35.1720110984742;
        Thu, 04 Jul 2024 09:36:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c? ([2a01:e0a:982:cbb0:bf0c:e5a4:4535:f45c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42649dfa25dsm17001585e9.1.2024.07.04.09.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 09:36:24 -0700 (PDT)
Message-ID: <16e542bc-b0bf-474f-b421-60e99f42a803@linaro.org>
Date: Thu, 4 Jul 2024 18:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: qcom: tzmem: blacklist more platforms for SHM
 Bridge
To: Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704-shmbridge-blacklist-v1-1-14b027b3b2dc@linaro.org>
 <jdfuvgaty44kg3xm63l765eueoy66qp7yngmf67nxqh5oifuzq@7gbzytqn5cj7>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <jdfuvgaty44kg3xm63l765eueoy66qp7yngmf67nxqh5oifuzq@7gbzytqn5cj7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2024 18:03, Bjorn Andersson wrote:
> On Thu, Jul 04, 2024 at 02:12:46PM GMT, Dmitry Baryshkov wrote:
>> The SHM bridge makes the Qualcomm RB3 and SM8150-HDK reset while probing
>> the RMTFS (in qcom_scm_assign_mem()). Blacklist the SHM Bridge on
>> corresponding platforms using SoC-level compat string. If later it's
>> found that the bad behaviour is limited just to the particular boards
>> rather than SoC, the compat strings can be adjusted.
>>
>> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Fixes: f86c61498a57 ("firmware: qcom: tzmem: enable SHM Bridge support")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/firmware/qcom/qcom_tzmem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
>> index 5d526753183d..c715729f071c 100644
>> --- a/drivers/firmware/qcom/qcom_tzmem.c
>> +++ b/drivers/firmware/qcom/qcom_tzmem.c
>> @@ -78,6 +78,8 @@ static bool qcom_tzmem_using_shm_bridge;
>>   /* List of machines that are known to not support SHM bridge correctly. */
>>   static const char *const qcom_tzmem_blacklist[] = {
>>   	"qcom,sc8180x",
>> +	"qcom,sdm845", /* reset in rmtfs memory assignment */
>> +	"qcom,sm8150", /* reset in rmtfs memory assignment */
> 
> What confidence do we have in that this list is now complete?

AFAIK we don't but at least we're sure with this patch, it successfully boots on:
- db410c
- db820c
- rb3
- hdk8150
- rb5
- hdk8350
- hdk8450
- qrd8550
- hdk8550
- qrd8650
- hdk8650

=> https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/pipelines/91268

Without this change it crashes on rb3 & hdk8150:
- https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152722#L749
- https://git.codelinaro.org/linaro/qcomlt/ci/staging/cdba-tester/-/jobs/152723#L838

Neil

> 
> As Bartosz says, we booted RB3 successfully with an earlier version of
> this series, what changed?
> 
> Regards,
> Bjorn
> 
>>   	NULL
>>   };
>>   
>>
>> ---
>> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
>> change-id: 20240704-shmbridge-blacklist-021bd97b8a93
>>
>> Best regards,
>> -- 
>> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>


