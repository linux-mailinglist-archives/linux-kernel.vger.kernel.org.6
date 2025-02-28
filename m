Return-Path: <linux-kernel+bounces-537964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B61A492F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E93B93E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25311D63EF;
	Fri, 28 Feb 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpnCHUlE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB881E0B72
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730076; cv=none; b=OtSPd3M+NTfruPGD8M2sIqAxKQpZbHH8PTu8C+gK+4eb5T/aqaJp55UlH0iOJu/BOJxd1RwRjBhTC+uDx0Ru+JGHDozpQgg/ikwRf9WV6yYADhGTwwoHdaExEqQ7V07TuQDuSLtMZI8ebP2ZwnqKlkNrG4eJ+0lTBGB8Je9zClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730076; c=relaxed/simple;
	bh=av+GYBuah5kwsd+f6ZBwHxLGEhswPUOByxf64TBpD/k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mO1MUXJ8NHgECMLft4jO+LR508NTjsbttJD5n4d2B5SmrQ3NEaD2XTixB36n0by/HEF+zQYQnO4cVasB7r5R31JbynKaFVLMvmRbOs8sLxjBxdRSq00eoBIYZI55XZvobBaZoHR3auzVYlFkKLRaqaxyMgEig+OH4Hk4NlfMAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpnCHUlE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso987797f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740730072; x=1741334872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+8y/RjspiktbX4LE+yHfwUXNlIZh9WBbyGG87aWFoY=;
        b=mpnCHUlE1qEpozEIE3jKTALYtWyTlm56lDlVlCvJ3P4I4qDQJOUABTFNXh75twMk+N
         GBaa9Npp5GGsSSdKLFI/P/26UspOd5xhiboW36sokXc1eE0Ot2QHJQ6VbY7KvJuswSvt
         +7E8f9/QYfvhIcMs3NkrUiVljQsc8fsko90gBVd6Bxa2OpPFf0jDsC+6r9pM1QmqPm0n
         SJTQcmbkybZmsMTIxw/sNeNGscikoa3wYb+zPUF/NIsTdAueGJKbHkS8Qo1mDtpzf0IJ
         LjIFAJICn9TKYc2BmNhxTgEVCyWSyMNelwkgknM1MJsiIyIoBqK2B+jDW8RaA8l2CgK5
         17hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730072; x=1741334872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+8y/RjspiktbX4LE+yHfwUXNlIZh9WBbyGG87aWFoY=;
        b=BQG4WnKobDvlz1ifWOqw9FWwxeeDdUcJnqTG+tJ04U1mtI08kKenS/RjGDftCU1V+/
         L0O5wq6xFucfGO/nqvt4Agyq5gMp4XXcc/1KwZ8cd/n7+de0HzoLi8QldeA/np8OkuNq
         ZfQiQzG/V+01+bhaIYtj4mE0fnVWqrCBkuYC5Uns0CITTaC3kNXzbtQzdjGUEpypYJau
         TKj5S8DUKN174Bn37BbympYIXSEas+jS2qcKI4qF5jerSKzwsZmodDqveYZqUy1/eSAk
         wpin7O4vBCzOd4KFp3aqxgC/iNym6+smCXeHN1XBMcxracBFFCqjStrJoBTl6RWcNIPa
         kXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1A4CjA42BRTVnrsqe6ets2Hl0npNmgzFW/zUFaWw7u9x4+0+Nc9tkC/fMrzS6FnOrspi4x37U9Ff03sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTkag4os0nZ1QU3reZzg2+eF4ERTGZgDSueIvvxsghn/GRBqh
	4nUgGQWOpltZn5zFQtIdz93sz1cms4Yqk7lN5/wCH9+dR7julO/8DSBumHDZoKc=
X-Gm-Gg: ASbGncstz/zTfxF/BSM4x7QHqvGosfm2u7zC+dMO/WSGrLl7PlF7oQ3B1f1V6vLfgcm
	dXk35QVecwGoNYNNoE6wNh/DD/wtgkkTUFVlpOHNTx0byai4mseo1lMwVo4IiagXwSesAVL+deH
	HL3kbt05GtCAsd1QEaZx/IRDR7TRl+xJ0tD6iqqbmz7nD0EwLvHA1hmlhRPphA5QItSCnb+ky1q
	GtNLFDVpHJvrtL11Yfb/p25LhyVZeKy5oRLNOJBQVH+WQpuwjI5ixDOvE0SsLd8oG3M2ZbeklRj
	YgbhFiMfx4QoBIk6TYT4RPfGFhDIj89dc5VaCzFY57nhrtr46JcCqwufP13zTh6mLB75P4UVaOI
	07rk=
X-Google-Smtp-Source: AGHT+IGL1/oR2jv5lxHH3F0hdQ11YJv7QHlrvrb1+UqRBVZtgLJZd8ANUORgj2WPHhjqtZrRd0SoYg==
X-Received: by 2002:a05:6000:1844:b0:390:db1a:15a9 with SMTP id ffacd0b85a97d-390ec9be589mr1857858f8f.31.1740730072615;
        Fri, 28 Feb 2025 00:07:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c728:ed22:3bb8:f351? ([2a01:e0a:982:cbb0:c728:ed22:3bb8:f351])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm4510432f8f.58.2025.02.28.00.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:07:52 -0800 (PST)
Message-ID: <9c15f084-ea4b-48e4-add6-c5b0c6de1155@linaro.org>
Date: Fri, 28 Feb 2025 09:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sm8650: fix PMU interrupt flag
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-topic-sm8650-pmu-ppi-partition-v3-0-0f6feeefe50f@linaro.org>
 <20250227-topic-sm8650-pmu-ppi-partition-v3-1-0f6feeefe50f@linaro.org>
 <7535057b-b6fc-4831-ac5b-b68903083747@oss.qualcomm.com>
 <Z8Cza7ZZxy3fbBC9@linaro.org>
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
In-Reply-To: <Z8Cza7ZZxy3fbBC9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2025 19:48, Stephan Gerhold wrote:
> On Thu, Feb 27, 2025 at 06:50:31PM +0100, Konrad Dybcio wrote:
>> On 27.02.2025 5:04 PM, Neil Armstrong wrote:
>>> The ARM PMU interrupt is sometimes defined as IRQ_TYPE_LEVEL_LOW,
>>> or IRQ_TYPE_LEVEL_HIGH, but downstream and recent platforms used the
>>> IRQ_TYPE_LEVEL_HIGH flag so align the SM8650 definition to have a
>>> functional PMU working.
>>>
>>> Fixes: c8a346e408cb ("arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs")
>>> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>
>> I couldn't find anything to back this up, not inside, not on Arm's
>> website, but downstream agrees, so..
>>
> 
> The GIC doesn't really have a notion of LOW vs HIGH in the programmable
> registers. This is generally a design time parameter, e.g. for GIC-600:
> 
>    Level-sensitive PPI signals are active-LOW by default, as with
>    previous Arm GIC implementations. However, individual PPI signals can
>    be inverted and synchronized using parameters
>    gic600_<config_name>_PPI<ppi_id>_<cpu_number>_<ppi_number>_<INV/SYNC>.
> 
>    https://developer.arm.com/documentation/100336/0106/components-and-configuration/redistributor/redistributor-ppi-signals
> 
> For Linux it shouldn't really matter, because gic_configure_irq()
> ignores the polarity and looks only at IRQ_TYPE_LEVEL_MASK.
> 
> If you still want this to represent the actual truth, then all hints
> I can find only back this down (not up) I'm afraid:
> 
> Arm® Cortex®‑A520 Core Technical Reference Manual
> Arm® Cortex®-A720 Core Technical Reference Manual
> Arm® Cortex®-X4 Core Technical Reference Manual
> 
>    17.2 Performance monitors interrupts
>    When the PMU generates an interrupt, the nPMUIRQ[n] output is driven LOW.
> 
>    https://developer.arm.com/documentation/102517/0004/Performance-Monitors-Extension-support-/Performance-monitors-interrupts
>    https://developer.arm.com/documentation/102530/0002/Performance-Monitors-Extension-support-/Performance-monitors-interrupts
>    https://developer.arm.com/documentation/102484/0003/Performance-Monitors-Extension-support-/Performance-monitors-interrupts
> 
> So please check if this patch is really needed, otherwise I'd suggest
> dropping it.

Thanks a lot for looking into this !

I guess I'll drop this, and we may harmonize all qcom dtsi with LOW.

Neil

> 
> Thanks,
> Stephan


