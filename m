Return-Path: <linux-kernel+bounces-532137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB1A4491F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1641891ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310118A93F;
	Tue, 25 Feb 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQszEG6i"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177841891AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506225; cv=none; b=QymsKbREYhhIa0XZjKl3m669+G6hQIWBSV7gJJIOYIXXuR6qQimpFdCcpgpCmswKkpcWE6yc8QMJPAR0M5ZFp9oyKFp+55kIN2dmUUErTyF6idgfVvhBQ1Fo+Z9q8r4SgVhHk5IZEV9S3gZ/sLUEb1Oo6MEwW9j2lP9yvLv+a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506225; c=relaxed/simple;
	bh=hfqAN0fagSCmL2HyOK5nwh1j0eHuaZ5mjszK1wKU/EI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YN1lPsYcpDdfk5TAH30QOykkyyFlaKSTYZ0UA4t6H1RmTxA6dSx0YCkXcg3T9Ej5gGczt256/AWQAgnJdBWr/QJKs2eTcV8Dv0RWkLhrPFcWBpdynr6EnCZi0eS9EdpkaCxc9EJb+Pyy8ZneAkhWs/tI7CToWPkD8VIi7LRrkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQszEG6i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso37830435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740506222; x=1741111022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9USewdvJ7PYqMLaARTkWJYtBQaK26VR+XCGXeZgq7M=;
        b=MQszEG6iu9Kgxy6NAOk2hcRc+Y0rU8qUKK1fwAOteZXggH2i9jpE+9ChBVglvuTids
         qRsnZOpN+RcYVGFmn6Hu+uptscwubAHjkdV0aPmKc4t1o4BiSVxG3depkkMN3QhcHFcT
         j75NvKfSaXRG/aPU2Ep7l9U2phh55dlexdu/F29ddw/7bqc5DYhZE72Dqo+NOtikbsHy
         Xz7xQWmEIBFSYPjXjqa8ItOEZWEXATyP/0OEprKylLyAEPRcr6wLudNHeTwiEtcSUxgc
         PK5EK0RrNhEIZvri2zvJrtiAMkMB85aj5U8YHNPJfvGenvUEoNCVkfGEw7yEpfnLfiXE
         5G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506222; x=1741111022;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e9USewdvJ7PYqMLaARTkWJYtBQaK26VR+XCGXeZgq7M=;
        b=f0q80hfAq56/4KjTRQtbM537rSIaA/Yj+PFv3H4Ug7//8DMkww9nCOGzYYhVC7pl1X
         yW2HskufxRroV1Z+ctvUClLgDYQxTv/1gWuXUnu30FJbHzP07O29Qw0vBXPOC8rLLPbF
         n7eCwKxSITCJlIAFn3AWoB5wB4QGFhLttXlUWLdpsLSNjZzfJMdzHFI6JW7LEOUB7ljp
         6IfrA4YdCuX5NDfANg64XjFBH8u3hLgof7FmFs0v5gmw1QC5ZklC+TJ6jDAY+yvBOwbX
         683DhnhTMmPzupV5rd95eXcC4G0gAZ010bqxtyNda7+TzlgxMlGoxJ8+pu38E4Xwd6BM
         BO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL3a/s8dCzlt3dA85/XtVpT9KFf2rm3P099X8EBDGru839JriMHEGoXhYWKNxjMNIh1/VBdr+yjO82LLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaejR7e7/anbBJZgwBa76ZVinc91+yGGp7uz3LKd6YsT8V4Zln
	5yG58oowrVhpWcSjAknT+LBe900ViIyeXoge3LqcOAuNGTU875alj6q/JHGbF8Y=
X-Gm-Gg: ASbGncv8j/Xc2L8dgKxOBy75VVsvsMkGVEbt9wx8yd42mgcChmbCIOk2sQu/6BMEZ+g
	AFbiX59N/i+VlJPL07idE71UYZcIE1qP77wDodPEAojXVutZjj8H9UdTBSqqL9cvE8SYOmqELl9
	TwBi5azu1EVVPzv+pFRnm9QNO4Z9/Eed9O9/l4Pn/J0YgCFRmDqHA4rB18xLjrs7AT9fKrktDII
	8SA7PXT9SKFAqMOlgNJVJ8J6kIvkzVnoZyWoMwxEmTpv4sYAnd9QtSfded0OVn433fnF2AVZsT7
	ctZvXDNu3jVJBDccgYwprzxlcr3POHBL8D5FzFq5IPUfmRV+iQfQQab+fkxF11bJ1+THI7fV9Af
	3glY=
X-Google-Smtp-Source: AGHT+IHUAgL2tByhpFFBEFGQOdfrkVcNwwIG2P9l39t0NBi1UKfkNO4hyH6LvwamNSW5TxfMBytNRw==
X-Received: by 2002:a5d:5f8a:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-390d4f84733mr232456f8f.44.1740506222366;
        Tue, 25 Feb 2025 09:57:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:23a1:f1ec:7a08:3a2b? ([2a01:e0a:982:cbb0:23a1:f1ec:7a08:3a2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fc1f9sm3000134f8f.88.2025.02.25.09.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:57:02 -0800 (PST)
Message-ID: <07d7f05b-ed3c-444d-8879-9df99174b7c9@linaro.org>
Date: Tue, 25 Feb 2025 18:56:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm IRIS & VIDEOCC_8550 as
 module
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250225-topic-sm8x50-upstream-iris-defconfig-v1-1-8a17e2e193d9@linaro.org>
 <e959c772-9c10-4c87-a22b-e2f91ca05af8@kernel.org>
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
In-Reply-To: <e959c772-9c10-4c87-a22b-e2f91ca05af8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 14:08, Krzysztof Kozlowski wrote:
> On 25/02/2025 10:10, Neil Armstrong wrote:
>> In order to support the Qualcomm IRIS driver on the Qualcomm SM8550
>> platform, enable the IRIS and the VIDEOCC_8550 dependency as modules.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/configs/defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index a1cc3814b09b31ee659536a64b7db704153d6fe9..710452f75133896af2e3a19ae544f139e1c28a98 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -847,6 +847,7 @@ CONFIG_VIDEO_IMX8_ISI_M2M=y
>>   CONFIG_VIDEO_IMX8_JPEG=m
>>   CONFIG_VIDEO_QCOM_CAMSS=m
>>   CONFIG_VIDEO_QCOM_VENUS=m
>> +CONFIG_VIDEO_QCOM_IRIS=m
> 
> 
> Does not look really as Kconfig-ordered. iris is before venus in Kconfig
> include.
> 
> 

Surem I'll re-order.

Thanks,
Neil

> 
> Best regards,
> Krzysztof


