Return-Path: <linux-kernel+bounces-567460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E472A6864E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CA63B95CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B92505B8;
	Wed, 19 Mar 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPliIogF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EC20DD4B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371460; cv=none; b=GanLQ9oSqi6KapJlMQxfiCljkMMad+sqiu6tZp/Jz6Iua9c3ZDO2KzRakNeBA16Oldr2SssPcLfD0kYgtqjS9bplxe6eXN/fSfa5Et+l3S1U3oTJJhNXCdD/ZlmWY3QgLIfor/m4iuBAVWGs1P09NUPTrJJxGjcuNL1d3L5S/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371460; c=relaxed/simple;
	bh=F/12CIjOr51pQeRUvwXlQawPLx6VfXbl8nDRleK88tQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z4LfoZVX+e3B6F6stuDPbUJ/19ieefp7VJlvwJEvQAChfAxV/Snvl2nqgcwmp6PhsnaSN7syE/DujEEqFC8eAuVQ6eYIY3+gdMvfPTRGqAVYtfYTM3A+r6zMzk/BdnRg6NgV+3rAe1N5jjho9CtQUPzN1KY9tm0agOkXPDaTr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPliIogF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so27087775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742371456; x=1742976256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH0E8XLLA1KY428T+qHl58BmGuRGu4mPp4ZKMUDvZAg=;
        b=MPliIogFdtet1rPGakOWWHo2/66yT1Z8rTckCKiffPFUarghpOJyZqqf5LS/bN5/BK
         4JDVYQ/ri7zO5gqZFraC6PjbI84egIgJSgSuUxdFHY7I0oVcCRHwFObhe4GqYoYnAGgi
         OFNSDAqiWAYPiqE4E3SYc1uPLyfgVDrD56/v7BrqsWkBZp2Csvf7I6A3jcA6vZi4PS3m
         GL9xDI+Gbli9Y/MxayXwtCyauWfLdTXkqCsvGFpN5HKXLY3kd/uJXo768I8+n7KSq6ri
         Ztn6RtnsRDv2Xzn0CWBNtuu3drsrwTs790gK6jhnOAQXcPuh3yGdHOY59OdoCYJtfyEa
         PBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371456; x=1742976256;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eH0E8XLLA1KY428T+qHl58BmGuRGu4mPp4ZKMUDvZAg=;
        b=exreJ4MEduqDnX5x885sQBbdqJDaNN02aeFrjNO4srtAVeMxJaPPhEc5lO4POjBGgr
         0VYHeGM7Vge6XKrC285WYb3p3SpT3+WRHaCMP7S5FipBbYkcwGjdTsrUpJXKxroHRD+0
         TBBswxJItV/rYwirhSa7Mij1r7bCsYU+MJjiict1H3wLvHmfmYCxSqYho0RwTsH0P7jI
         DHV5t90eDULdDggxsQKG86r4FvsU6cCs89oWHs9Gorf5Goq96zuB4hvORtQO0bDCDQ+/
         k07jeIIGXq+AAoifz5GT5VFnmPAsscpoG0wXKGaJP/N1KwqtEusYkrSeysPpitV8dFgT
         P15w==
X-Forwarded-Encrypted: i=1; AJvYcCV03pc94BwbrUf1cOcfxn3w2wy9bh9s1FFF9BNmwr7jSuUs+WRAyHpuboztVHFcCTL5l+6/41ypE0vFQ3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTQqBoPtyhYChxhRHDIiqGyPK8fxiVajNdPUYI0OaXqyjuWtL
	sqsWhEeE7OyeGGU196hYYhQwJTrs/p4C7nM5hzhyZRSWZuxb4y376L4/O/NK1gk=
X-Gm-Gg: ASbGncuS8FlLO5tKmqY+if85ZXz+rOtcxcEt13Nsk+WVWOFd0iHD4w7KbI/FCklPeSu
	R1TvxyEKCu7f/acW5UuLOXOcAlTSTVPQxR6lQQwT2t6saCHRaGbxlsPNBLn/D4/I6iMZWqRD2w2
	aSW1LYD5a+qe2u5Ln5y7EaeYD28hPm50daJVL/zkG+iOY4kWj42kImN+/AI4FpJ1j8Q/GKY25WN
	CA7XxEgzj6T5B4vcTui41vhJNBSA6D3o9prvhIH47UAkq9QJFhkoM5Bg8hp6BqJ72stPF/4uYYv
	x5CW/5ALuPmvLOF8SiP6GHziJDJMUF3+YrLmjZi7IAUdSOGV4I37vSaIIiAFyC3RVBQxdaeikQf
	VPZ7Ms4ye7cgBRGTahHkY9dPpfUbE+1Lg
X-Google-Smtp-Source: AGHT+IGm4Cl/9Qdcn8Kqt+6pglJBGnM3+tCT1SYRVaz3toWe58WaCwdu233p+SYotsc1rYYrwJQAhg==
X-Received: by 2002:a05:600c:1da1:b0:43c:fe15:41d4 with SMTP id 5b1f17b1804b1-43d437c3379mr14689285e9.18.1742371456087;
        Wed, 19 Mar 2025 01:04:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f407:ab81:b45a:93e8? ([2a01:e0a:3d9:2080:f407:ab81:b45a:93e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997656f43asm374382f8f.25.2025.03.19.01.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 01:04:15 -0700 (PDT)
Message-ID: <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
Date: Wed, 19 Mar 2025 09:04:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
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
In-Reply-To: <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 17:35, Jeff Johnson wrote:
> On 3/3/2025 7:00 AM, Neil Armstrong wrote:
>> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
>> the line:
>> 	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> was incorrectly updated to:
>> 	ab->single_chip_mlo_supp = false;
>> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
>>
>> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
>> crashes on driver initialization with:
>>   ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
>>   ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>   ath12k_pci 0000:01:00.0: ignore reset dev flags 0x200
>>   ath12k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
>>   ath12k_pci 0000:01:00.0: failed to start core: -110
>>   failed to send QMI message
>>   ath12k_pci 0000:01:00.0: qmi failed to send mode request, mode: 4, err = -5
>>   ath12k_pci 0000:01:00.0: qmi failed to send wlan mode off
>>
>> With ab->single_chip_mlo_supp set to True, firmware loads nominally.
>>
>> Fixes: 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Bisect log for reference:
>> The bisect leaded to:
>> git bisect start 'v6.14-rc4' 'v6.12'
>> git bisect good 5757b31666277e2b177b406e48878dc48d587a46
>> git bisect bad d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
>> git bisect bad cf33d96f50903214226b379b3f10d1f262dae018
>> git bisect good 12e070eb6964b341b41677fd260af5a305316a1f
>> git bisect bad 6917d207b469ee81e6dc7f8ccca29c234a16916d
>> git bisect good 4fefbc66dfb356145633e571475be2459d73ce16
>> git bisect bad a6ac667467b642c94928c24ac2eb40d20110983c
>> git bisect bad b05d30c2b6df7e2172b18bf1baee9b202f9c6b53
>> git bisect good 56dcbf0b520796e26b2bbe5686bdd305ad924954
>> git bisect bad d302ac65ac938516487f57ae20f11e9cf6327606
>> git bisect good 8c2143702d0719a0357600bca0236900781ffc78
>> git bisect good a5686ae820fa7ab03226a3b0ff529720b7bac599
>> git bisect bad 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
>> git bisect bad 46d16f7e1d1413ad7ff99c1334d8874623717745
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 0606116d6b9c491b6ede401b2e1aedfb619339a8..33aba5fceec946fad5a47a11a4d86b7be96e682e 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -1927,7 +1927,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>>   	ab->dev = dev;
>>   	ab->hif.bus = bus;
>>   	ab->qmi.num_radios = U8_MAX;
>> -	ab->single_chip_mlo_supp = false;
>> +	ab->single_chip_mlo_supp = true;
>>   
>>   	/* Device index used to identify the devices in a group.
>>   	 *
>>
>> ---
>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>
>> Best regards,
> 
> NAK since this will break QCN
> There is a series under internal review to address MLO issues for WCN chipsets

???

The original commit is wrong, this fixes the conversion, nothing else.

Neil


> 


