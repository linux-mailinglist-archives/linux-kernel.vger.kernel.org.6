Return-Path: <linux-kernel+bounces-567715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49CDA68960
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D123BAB14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09583253F2B;
	Wed, 19 Mar 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogfrWQGk"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96502253F07
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379723; cv=none; b=Z7t1aay0Hi+TCN/OZOQkD2yfu79mm+c272Lx0rD6YJPNtd+V2ODHO6Me5FPOhpNkqOPjGQvQZ0BgjyT+6ZozwqDFQiPZHPFqv+ZM3lbVHGxZjaFfHQEGQUWxvOFh6PbJpEmf4nHBr6gCALny9KICvcneFnRcu6DguJqdTgXgbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379723; c=relaxed/simple;
	bh=LAMhHX/286y3/HXXVcKrs+SLYXTmuluHXWt2q4eZ26Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OFaG3J3N9VX9GUPm3hs2N8TuTYai1zRUII4CNEAukh1LT3PEb2tvf+hRvkvlysBJzQKeI6cO49daYLWi8LVXctcpvkdzW3+FCEwg+GhIoBVPoBnCer+O5WpUJpzNjM5gBIYl5eX3RcXCv3oD5gQeSs4vALJIVYFN05WfwapUSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogfrWQGk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so20516735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379720; x=1742984520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPFvbCwo+PRCHaD6jfdENXZY2EG3HCcoClKlZq94Cy8=;
        b=ogfrWQGkDofFk8lSIBf8lOrvjoZ88sBahQdwg50NyY0mltPfy2bdwqCr14HMIC3dCo
         ZY8axDh7Az/CrDmClzPwlvYr+ObWROnu8UuqrTej+eeHGVS3Ng6oWKUyX+t0sgWOJLLU
         oaof5fW2GIaA+OG3xTTKl25P8VFjjRrKuF6euUyTE32+jmTvaCtDq0c3bA6mrx6ryESZ
         1TS/XlaAOPxF4ISzfWYYWJyQDZR6LabJtpHTiB3i9c5CIHhz8IBELA9N3Asp58e1ZY8f
         rMH07DBqKqzWOe1yy4GIFI44OfeMr+BMjKIF0TJn6ies/OZLB6Yo8r5OnSaQ75UlAZzk
         CAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379720; x=1742984520;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPFvbCwo+PRCHaD6jfdENXZY2EG3HCcoClKlZq94Cy8=;
        b=KITfT/MaS3V8H9JACjVb0iaqskAEG9j58Bt8037K3bjoUvOUQUya+YujYviKX2nq6t
         JeooLeoLhun0NXn4MDvZRqoDL6TYuHgdOSZoLxj/GUqmKcSYsZctQ6Vb8YeDFPsMIp+K
         KjfQGymXSY94v6yy5AZcZyBdyaa9Xu0X/sFL+7q7W+meKhPX71bLvdGE6lX7nV/Wki0O
         uBqmpw5zdMJpI9fz1vdv38jkhz97GVkECMMT2srr/gZLrqfNh1Mdz8v3NlKABhAFRj44
         NZE1mFrpYBO+R8alwvCpXll/0xleDW7sLUhCA88H8aU9+TIC4pBXBf7f9wpnMo24EV6G
         K5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3JJIy8g02EK/JxUWIIQmrbbuBAKXhFPvqSFIR/hBBKEpIPoIaReI5wBmvVpNZBNcyc64cm6jPi6qxLT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWmLbgzj+KGC372B6B1lvFAnmlD979gA7dXtoTFsKmOHyNpzh
	Yftbwt/yY0aUUwB1QlbOUMcyoIEhlMJeKoymnOktOeVm3cf5gX9y6xxDpQQW2bg=
X-Gm-Gg: ASbGncv4q2jC6x7ocPXi0E8dPXeWi3vH2zCQ9M2sWqrNpYGmPIhDo6sdgpvfekvfSFa
	01uXtnQaoMVl2J6AD2GR7lxSbHLOYIjus+2DCq54Z6MW9a4ChbzAxOF4IO1gROEGKV5Ih+exJ0k
	W9q5r1XHpz3Bz/+bIC2d5iJSCtwtaFQVVKUAYyOkX+Y0Zd96c8HMCt4lDKmwANW/PACy+cXWVpT
	PnuT5iF9T91yvNMm4lBqG+2O5TdoZ/p8ZfdxnIyma2lR/RcpsEaiJtctMh+BIYbOy5QruvALha4
	FDC/EWE2G4GPg15jevi15Dkdz/39za6bf4K723RqeEpCaK4sJ3Zj2YjySxQuxb1iUFu4FeONetB
	leppprt+oB2bK1uTgcH3Veg==
X-Google-Smtp-Source: AGHT+IF7qsUFGh7b/cZ62KfV0CEOIKewRH8TrAKUxQUlzKd+BTZTQCyUCBgYT9vnQFSO9Z26J4XamQ==
X-Received: by 2002:a05:600c:3b07:b0:43b:cf12:2ca5 with SMTP id 5b1f17b1804b1-43d4378d067mr14030935e9.8.1742379719772;
        Wed, 19 Mar 2025 03:21:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f407:ab81:b45a:93e8? ([2a01:e0a:3d9:2080:f407:ab81:b45a:93e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f33242sm14664945e9.5.2025.03.19.03.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:21:59 -0700 (PDT)
Message-ID: <42932860-dd78-4eed-b8ba-6eca1c7099ef@linaro.org>
Date: Wed, 19 Mar 2025 11:21:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
 <38cd738c-1a2a-4382-80f8-d57feb7c829d@quicinc.com>
 <6717d816-02b3-4d27-848b-620398808076@linaro.org>
 <4pidr33bvbtykyufw35ubfr7mut2ypqmoiydgjlcsyxolqteze@j2xhigdoxqhp>
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
In-Reply-To: <4pidr33bvbtykyufw35ubfr7mut2ypqmoiydgjlcsyxolqteze@j2xhigdoxqhp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/03/2025 11:18, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 11:00:34AM +0100, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 19/03/2025 10:46, Baochen Qiang wrote:
>>>
>>>
>>> On 3/19/2025 5:12 PM, neil.armstrong@linaro.org wrote:
>>>> Hi,
>>>>
>>>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>>
>>>>>
>>>>> On 3/19/2025 1:34 PM, Neil Armstrong wrote:
>>>>>> On 18/03/2025 17:35, Jeff Johnson wrote:
>>>>>>> On 3/3/2025 7:00 AM, Neil Armstrong wrote:
>>>>>>>> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
>>>>>>>> single_chip_mlo_supp")
>>>>>>>> the line:
>>>>>>>>       ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>>>>>>>> was incorrectly updated to:
>>>>>>>>       ab->single_chip_mlo_supp = false;
>>>>>>>> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
>>>>>>>>
>>>>>>>> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
>>>>>>>> crashes on driver initialization with:
>>>>>>>>     ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
>>>>>>>>     ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35
>>>>>>>> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-
>>>>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>>
>>> this FW version is not upstream yet, why are you testing with it?
>>
>> I was not aware the driver supported only a small subset of firmwares.
> 
> Yes, this has been communicated by Kalle (and now by Jeff) for ages:
> using any firmware outside of linux-firmware is not supported, unless
> you have been explicitly told to use a particular binary. Firmware
> coming from the Android / Mobile might use different knobs and have
> different expectations regarding driver behaviour.
> 

The patch remain valid nevertheless, the 46d16f7e1d14 changeset remains
bogus and needs to be fixed whatever the firmware version or ongoing work
to fix MLO in the future.

Neil

