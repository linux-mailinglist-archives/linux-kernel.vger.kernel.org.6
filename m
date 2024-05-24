Return-Path: <linux-kernel+bounces-188381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A498CE153
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE034282446
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425B128807;
	Fri, 24 May 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePDb2sDG"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1A86AFA
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534526; cv=none; b=uxpJLJ++3eL/75tmBohqt76xzQQA97TCJE4W9rHXKhVFZhyLdAglT1hpTeqs9MEXdYkdvPzwF9e1VI3qAtvzvLDc5uuL3aGSI9y7UenZqAY0LC0Zwqp1oSMW4b50xf3LQNZ+0aCB3xsB/N9z3E4y+w0103m6jasc70yEmSY9kHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534526; c=relaxed/simple;
	bh=0zL78J9MpyFNUiYWqKOJbE1a9M+z4vN5gFKzhKamHTM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hqY8Yv2r3Z7nmPvFk4LkSGjGm8M6MoRRMzD5jN5cC+Teaa1SNY7dXPmFAR4+OD2qZPEYKrwrvk+sHgFxbr4qvlqN9wJ9CojJp+W9OX8Pyiw8+PQruV2oeuNelKPdcNsPvZzZx+U48q/pGB3C7D00JQsSLsME5bTg75xK+w7tW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePDb2sDG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso5975367e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716534523; x=1717139323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8MAm3h3NI5iKT+iweY3kApju3idNJyvBAdIptvUy6g=;
        b=ePDb2sDGAdYyCu4xf77GuFpwdQjgaSkotctDzWD/LFYyN2WEdkp3EkPzFXZiI3MSYu
         eL+EiCAwGuxFV2pcTFaOpsdEyTxySSQFmI3CP77F7KqaWHI/FUiAqBVPR4UIEuUvJnFk
         TBZkSH+yLMAJ+J+oVjKfLMfaRfg0uZlYZeS384BTizckgGp1mRs4F+lpbqBnX1I9kUs/
         tIgrvDjRrCgWOu60zzmgUsKGzdc/qyO7cMkEXEmYWfKSOW3JnfX6N2eNCpA4M8cp2DSY
         44TQBmTUvLwdK7Vg1UpvWOnlJ8MZxzoCBoffR0inSQh0KFE7Nl/KpYaTDnoFPtxYqYJI
         yb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716534523; x=1717139323;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E8MAm3h3NI5iKT+iweY3kApju3idNJyvBAdIptvUy6g=;
        b=IUXBxuCl4mRN+93Kv8GXNNs1RXf/Ah5+L7UMxRAniWMiFbVebcDqxB5Ujic2uO9NRD
         rPdYbQAVHPD1nO7g2Ozbzt9GumVhSgblJ6Zqz+3J5ewL1ZH+DehroqvEH0dNgUq0I3FT
         K03W3vO5JR9oQpLsxzzHnWTMiNHQ0WLQKxqJQ7N3mibmRU4eHzsK8Xho1rrWGEo5La+q
         PrCKw3NtCauogZOW7Q8H38vQpojtOwv1R5lsxnlrgqR2eLkVTve6RixbXVuftuT6Tehr
         zNykotsbiq5NPFKD8ANr/eQ/ELn2MR8rd5cl+V7bBJ0YVZcvGIJoV/+eH9WuQlvPN5gd
         JU2w==
X-Forwarded-Encrypted: i=1; AJvYcCVi6cvQpKvIO92elsShMdhQfrBPA1HVEW6zgQ68bVBJKQkrDdcyu10TUFHBOdTj6JwTKktldoC5KKGgJOeQb7rsftcKMegXO1rj7eBM
X-Gm-Message-State: AOJu0YyFAjUA7GvXC/9x7iR6uHUIV/3T6TudMuBmeDRI5AINw1lM8kC2
	K71k925t+/++eCSjwW+O6JYIbIfidgOV2kNHmtsbUZVmtu0LKvKKlP3i0pH1Hko=
X-Google-Smtp-Source: AGHT+IEEwe7apvr6NvFS8zzXW6dwrwy77zqWwTpWL0vW66DGjKQDCMmPQg9s5wT1CDWXq/2wlTSXiw==
X-Received: by 2002:a05:6512:4cb:b0:521:54b5:86a3 with SMTP id 2adb3069b0e04-5296717fec4mr687397e87.64.1716534522716;
        Fri, 24 May 2024 00:08:42 -0700 (PDT)
Received: from [192.168.7.32] (212-114-21-58.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cda51sm12113335e9.47.2024.05.24.00.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 00:08:42 -0700 (PDT)
Message-ID: <f8370655-1bb8-4d1e-b9ed-df2e95e44d30@linaro.org>
Date: Fri, 24 May 2024 09:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
To: Luca Weiss <luca.weiss@fairphone.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
 <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>
 <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
 <236a104c-fc16-4b3d-9a00-e16517c00e3a@linaro.org>
 <D064242SMIVM.1GUC1I9GE9IGC@fairphone.com>
 <963b60e5-6ab7-4d9f-885a-ba744c2b7991@linaro.org>
 <D0C42YR1270X.23P9WCWWNB8XF@fairphone.com>
 <f2d96f99-d8ac-4ff1-83fa-742e541565e4@linaro.org>
 <864063fb-eeae-4eb7-9089-0d98011a0343@linaro.org>
 <D15RKEU49B4G.1B6A2MYB4LH3X@fairphone.com>
 <cbc8a2c6-0047-4345-8c93-afdba9c2bd10@linaro.org>
 <D1HOCBW6RG72.1B2RKGKW2Q5VC@fairphone.com>
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
In-Reply-To: <D1HOCBW6RG72.1B2RKGKW2Q5VC@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2024 08:51, Luca Weiss wrote:
> On Thu May 23, 2024 at 11:06 AM CEST,  wrote:
>> Hi Lucas,
>>
>> On 10/05/2024 08:51, Luca Weiss wrote:
>>> On Tue Apr 23, 2024 at 4:08 PM CEST,  wrote:
>>>> On 23/04/2024 15:03, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 4/5/24 12:19, Luca Weiss wrote:
>>
>> <snip>
>>
>>>
>>> Next, with DP 4 lane (not working on mainline but still plugged into a
>>> screen) the diff is quite a bit bigger.
>>>
>>> See attachments for the full files:
>>> * usb_1_qmpphy_20240503_151052_android_4lane.txt
>>> * usb_1_qmpphy_20240503_122443_mainline_4lane.txt
>>>
>>> Not attaching the diff because it's quite a lot
>>> $ diff --ignore-case -U0 usb_1_qmpphy_20240503_151052_android_4lane.txt usb_1_qmpphy_20240503_122443_mainline_4lane.txt
>>>
>>> Not sure this is helpful to anyone, but at least wanted to share what
>>> I've done so far here.
>>
>> Thanks a lot for the traces, it founds out the QPHY_V3_DP_COM_PHY_MODE_CTRL stays at 0x3,
>> which means the mode doesn't get broadcasted to the phy because.... the retimer only broadcasts
>> the orientation and not the mode... and it works on the HDKs and the X13s because they don't have retimers.
> 
> Hi Neil,
> 
> This was it!
> 
>>
>> So I made the changes in nb7vpq904m and ptn36502 drivers to get the next mux and broadcast the typec mode,
>> if you find time could you test it ?
>>
>> Bjorn could you also test on the rb3gen2 ?
>>
>> The changes:
>> https://git.codelinaro.org/neil.armstrong/linux/-/commit/a61fb3b816ecbe28a12480367d9e09b700ec09e1
> 
> With this ptn36502 patch on top, I can confirm that DP 4-lane seems to
> work on qcm6490-fairphone-fp5 smartphone with DP over USB-C!
> 
> Tested with a USB-C dongle that only has a HDMI port on the other side
> (so no USB), and cat'ing dp_debug while connected showed num_lanes = 4
> 
> So feel free to add my:
> 
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Thanks a lot for testing, spinning a v2 with those patches!

Neil

> 
> Regards
> Luca
> 
>> https://git.codelinaro.org/neil.armstrong/linux/-/commit/f6f976ff692bad430cd945f02b835e355f19632b
>>
>> Thanks,
>> Neil
>>
>>>
>>> Regards
>>> Luca
>>>
>>>>
>>>> Neil
>>>>
>>>>>
>>>>> Konrad
>>>
>>>
> 


