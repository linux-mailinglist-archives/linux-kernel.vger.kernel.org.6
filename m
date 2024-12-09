Return-Path: <linux-kernel+bounces-437813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C517E9E9915
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B77281D75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137941ACEB8;
	Mon,  9 Dec 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fW/Tr++m"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E615575F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755001; cv=none; b=IUALNPCANqwdRvCQUf+6GcyWjj0MWqzwsFNqG0/nZWfKw/9lTlnViPNtlIn50d+ivNM+bhVmktzRSvDDVHRmdPXgK/vsXCEbZ3J9NkjwvsetX+iyPz19zd8VpjkZTO7vqQzg6qCpkZ/Xb30wGpwOHHzFFAY34jo91rSwK8tlusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755001; c=relaxed/simple;
	bh=HOcFqG22OPgv//jIpTE8txLY4NFke2s9oIlcIahYCLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YON9IOr2468tTOVp+kosr+cc4pF4Ems8cUHqnhoq+LkA5O7ljJZ4Y1U3lQpxgPXUB2t+uiNVxItggc5W9xq1NzNt9LZt+wrZfe3EADLyichai4ipQexvi38OoQs9BTJhAwZjFrQp4Yg2niJxYZyxNkgoe/sbeNCcKY6SdNHhV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fW/Tr++m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so12300685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733754998; x=1734359798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iybk4BF/6wykwp3WZSJYg6zEzjmSlg73jx7zsIMKcsM=;
        b=fW/Tr++m3cVMNa4lvN4NW28HKhulYL2gS4wxoXBdV6HPwqHosHVU7aXSstUzh6WVMB
         UBKt6YdvXboOLfsFY0AxGuUYFDTqAt4326uhYhhZHKcnNoY9PpaeB2E2wRsX1qQC1EhV
         D+eXOMQ+8jCnIJyz2Xs5sj8jIF2tuA4nRPXtayNezeCEx3gyRwSmbpIVQbp6e+gpQoqo
         qLO5NJeAh0rLFHj/b+30e7lU4WpSpXU3XTI8QK1FVragoXaPTSOCsA/dQTX6fx9iJppM
         kw5vJ6QyephpPUFTBG3WtRSfZKDvmU3t8tIg3KXWjPa4n0bGIdX43E7Rp7W2rKfjbgbp
         j0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754998; x=1734359798;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iybk4BF/6wykwp3WZSJYg6zEzjmSlg73jx7zsIMKcsM=;
        b=HtIv3MAbRrtyuvTzjM3VDdIWfYyBS4qTRcc59grPPKBkVJ/bttkwwVcXuhDCv/GsgY
         xiD0zsJ5SaitQLhaGktT6HZhG3LAPimNfvdy1Eo/wAjjTV6qns4ctTi47fOxVdKl/knQ
         VmMdvLEV97VsoIifSbkW4EvEDTIfnOu2cr7EKFJAk4qrKr5RBl3SXRgm/O+D1OnOHDdC
         vV2lXoLNkzyl4CWH+70ql9NNqze6UIOY7JwMSuT/bgvikwG9RGdWdHNF9dc06ISl81A9
         Rmx0txxxLTOIQwLHJyXVXpYvxsMEE8QHraUMDmJ28paRdN7LBd2CAqHwJNlvKR5rKlv8
         abyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyEPyL5+bx8dikPUttX1ze23UiXTtmJl1zwVWWTkMyVqiVUnbsTwm017wojANem9+3AULyUUld2ykRqz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1lp7qvAzNgNXs8ouyo9IxzkRAYPkBueFmlt9S8B4aZ8vY0Nj
	mDDsF8u1VYlhMA4Y5iIyse+cgJsHbDWygSRon6if3vnHVH7cCyoKAtiOt2AcuG4=
X-Gm-Gg: ASbGncvN6EdqX4Frh2xR+eA6qhYiiXjbqCsdKDA2HF06YN1qlZZgtQkKWCNZ507fKrA
	NpWsykv2yDtq9gIViyxUOTuThyIeJRAsqUFU023hiDFSMt5O//EAT4VN373LblzedsFAQiAaYbN
	6DAyaBLxvAcaO0XxX/sWM85mPWk3Ix/APcnES01LQp7Lt4lRMu0pf+WV9iEOX/mi0QVL1vm7jwv
	/23+BMOd2dEOWy2+9kRJ/0irbwPnJW/F0zl3TTKYSkpAx7QkVq2tLjJvWD2x6Y9otrb2PR9lGEU
	xXnraMjMxX+a2P/qukOPCGi3/oI=
X-Google-Smtp-Source: AGHT+IEOK4H9LaTjsgxxy12uduCW2tkis7WEZcINrqzjSdHPEzoWLoWraQGVXtmGhjBHA/RvfogtGg==
X-Received: by 2002:a05:600c:5101:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-434fff3d84cmr8767285e9.8.1733754998160;
        Mon, 09 Dec 2024 06:36:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7546:6147:f006:709b? ([2a01:e0a:982:cbb0:7546:6147:f006:709b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2637sm160086625e9.2.2024.12.09.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:36:37 -0800 (PST)
Message-ID: <f85d5206-85cd-4246-826f-811624afad2e@linaro.org>
Date: Mon, 9 Dec 2024 15:36:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: phy: qcom,qmp-pcie: document the SM8350 two
 lanes PCIe PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204-topic-misc-sm8350-pcie-bindings-fix-v1-1-e8eaff1699d7@linaro.org>
 <uvgu5fpcoxmqnlqlu2evtufy7qtwl7bfztzpmxtvqsr7lvcdy7@645q74bovcyo>
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
In-Reply-To: <uvgu5fpcoxmqnlqlu2evtufy7qtwl7bfztzpmxtvqsr7lvcdy7@645q74bovcyo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2024 10:39, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 11:34:50AM +0100, Neil Armstrong wrote:
>> Document the two lanes PCIe PHY found on SM8350 SoCs along the
>> already documented single lane PCIe PHY.
>>
>> This fixes:
>> /soc@0/phy@1c0e000: failed to match any schema with compatible: ['qcom,sm8350-qmp-gen3x2-pcie-phy']
> 
> Maybe we will succeed this year...
> https://lore.kernel.org/all/20240124-pcie-aux-clk-fix-v1-5-d8a4852b6ba6@linaro.org/

Damn, I must improve my mailing-list search...

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 


