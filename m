Return-Path: <linux-kernel+bounces-352889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE569925B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C41F22CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442FE17C9E8;
	Mon,  7 Oct 2024 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmjgo/Cd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC5175D44
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285075; cv=none; b=bdRDMC8LN4sKLLsI8kHAnlyKFF95rF3lrOKqmD/AYT/GgB7DkYm4t441U53oqDte2iw3uz82b1myqp94GQjlqd+FaP5tebmwFAkbpSyCbjuTFSS1ZvWCCKKi+YDmoQ18wc/rI2duzmScTUvss9q8IvzVvBYz4SBuDk4ddr7CsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285075; c=relaxed/simple;
	bh=ku8uJDr+QRwsk1lGUGa0hS1U3Qj5p+wR3CQr8UpBG40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X01iq8LRJXPxQGnXOqBsg2xdasHDjEBp5HlvyA0HaaS6qMTXWM2bn3k+CEZ0PLbR4phXdgwjH9xiCj+zaiiTOUPCzCd945Pb0IRDuGuUwZzc3zO4AcToV1ibeGuDGdkuPjNV1ZtRjFPBg6OFP1FEVEY17fvk/6LqoapsTxjDZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmjgo/Cd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso54206955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728285071; x=1728889871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2OtAupPj912oaWTk70eSxGnJNSBiZ0taXrAiEBAlYM=;
        b=zmjgo/Cd5qyDJiihweMlq6YX68L0uc7hZ0FMXfkUEwVIzc3G4gAGpI3P3Tbfp9CqVV
         Pd2jYLNSj3QOzVkzrimEwKypXNGTFAATCQ0hMbu2KaXxhsb2Mwe0xZm6tPfdV54IPyBL
         pQAAKgXsLN7g++j25MiM+aZ66J3fWtEcxEoDlz4HLVdHGbgIZ4ugYFWt1+VW3E03IlVQ
         hCPlZrRBOwCfBJ1AhhPcOVN7aoB2bd3jV8UZr5mR/Uwax+TWd0ea8yzwitX7TT1VNPg+
         wsVprinntIp59SDb8bpaQmF07PqASQyPJQRM+f0o1ING9VdQQuYRNiuhdrra7kl/2T1n
         7hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285071; x=1728889871;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t2OtAupPj912oaWTk70eSxGnJNSBiZ0taXrAiEBAlYM=;
        b=IkFdKYkFWQsDqjv+euKs0oWCGUzXK15sZmgTehKWsS4c5dowjk4IbWD78e2U8TbLf3
         ynPc7R0YBYjFFUtqZlc8pmsfm20XP4bxBMNjie7BI6jr34SVJfO5Ea9FmJhzNfFtCP7K
         KcZ9r0F6tdLLgvOADyD27YU3EQ82xuLTgJmDAfwYBf3LvLHaFVPF5Qo6E4DxsHCANhs/
         k100LWKhty+tXHP3HqIVGjAVA0r2rMpGJ213H3WoQb/PiAW9mZb1zBDcheBr+zmQ6qqD
         hjaTpO0CKPEypnOm6rP+I1YJkpBPzfMiNrDKRS6oGHBsFTGeErlgYTLMG2NzFv52sa4k
         0k7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/oE4RptYypYNEiGBEXa7lKor4JAwx0cgaLQgMkB+pG31ZAckvSYyKVWuhSC9BUc6okq8Nm9tNs2YGEck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMrkHZmPLjSc05HGgcBz61bK6PEcUk8ZmoT2/1ENVt3Dsaiu4
	PtywbGLJp0BvKa0uj+6xRRuugSgvrrba34GX7jZYQx6tN/pkfiOu84/ddg510xw=
X-Google-Smtp-Source: AGHT+IFVFxaRMFfUaEbq3HUpjZ/b1H2g6WoDRhYYqt96M3soQzVRwr1DKsgQB9gASFRhW0F++A16dA==
X-Received: by 2002:a05:600c:3ba9:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-42f85a6e0c0mr122280805e9.1.1728285071045;
        Mon, 07 Oct 2024 00:11:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7? ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1698c188sm4988483f8f.112.2024.10.07.00.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:11:10 -0700 (PDT)
Message-ID: <e44d7132-72ac-49aa-b44e-c6f9ac237ccc@linaro.org>
Date: Mon, 7 Oct 2024 09:11:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sm8650: extend the register
 range for UFS ICE
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Om Prakash Singh <quic_omprsing@quicinc.com>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>
References: <20241001-wrapped-keys-dts-v7-0-a668519b7ffe@linaro.org>
 <20241001-wrapped-keys-dts-v7-1-a668519b7ffe@linaro.org>
 <Zv/2Xgs9o78HkXne@hu-bjorande-lv.qualcomm.com>
 <CAMRc=MdC2yRMK0Sw+5nJvBsTtxtVW=XbJ=3RixsKp7mQibMTww@mail.gmail.com>
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
In-Reply-To: <CAMRc=MdC2yRMK0Sw+5nJvBsTtxtVW=XbJ=3RixsKp7mQibMTww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/2024 16:15, Bartosz Golaszewski wrote:
> On Fri, Oct 4, 2024 at 4:06 PM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
>>
>> On Tue, Oct 01, 2024 at 10:35:30AM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> The Inline Crypto Engine (ICE) for UFS/EMMC supports the Hardware Key
>>> Manager (HWKM) to securely manage storage keys. Enable using this
>>> hardware on sm8650.
>>>
>>> This requires us to increase the register range: HWKM is an additional
>>> piece of hardware sitting alongside ICE, and extends the old ICE's
>>> register space.
>>>
>>
>> This commit message doesn't follow what Neil requested in v5:
>>
>> https://lore.kernel.org/lkml/109b1e46-f46f-4636-87d5-66266e04ccff@linaro.org/
>>
> 
> Because we have dropped the new property two versions ago as per this
> series' cover letter.

The patch now is fine for me, the comment was applicable to v5

> 
>>> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> I unfortunately can't find where Neil provided this.
>>
>> Is this tag referring to this patch having been tested together with the
>> driver changes, so he's saying that HWKM works fine. Or is he saying
>> that the old feature set still works after the growth of the register
>> region (i.e. what he requested in v5)?
>>
> 
> I think Neil tested the full functionality of HWKM on sm8650 as per
> Gaurav's instructions. I did the same as well.

Exact, I can re-test if necessary, but I trust Bartosz here.

Neil

> 
> Bart


