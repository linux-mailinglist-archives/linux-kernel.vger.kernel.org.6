Return-Path: <linux-kernel+bounces-204367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97878FE7C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A4C287DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51498196444;
	Thu,  6 Jun 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mi/A27KI"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE11196434
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680597; cv=none; b=sWgPOJSWKH4ZEgO3lVVW8vOOHnd11hX2tlCmYH/xrJAN0YTzq58mwFyxVOFua3e6Whp/Oqy488PDxYkkQUNfUKNGMn5cw3op5jIrVYcAT1it7GwyniVIqcVyoUI8uVn8fAT7lYYicHNM0yN6C6BSDT8chT3xjOPF0E00Fl9LvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680597; c=relaxed/simple;
	bh=Xp5rd2qLWgZKlx7+NHtfHQHaeXuFPQwRFoaUiFzP9c0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VBKwsklmA+35qYgtdY6d3hWbHKHZ6LIsa/nKYQCtX0mrH1PifnKliPDWZ+9gLVT10yPEK1LMSyXCjAV4xN3hyyMsBVXZeFy34vsjBfEsGFJeZimdD85/7VNWeobgu6vE7If1wozhTRkEYbn9bvzprhYCD7QVscRdVfv2bBPuhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mi/A27KI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so18652021fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717680594; x=1718285394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvkU3UYNCCgjYLGJcSgfkTy9W76vquBkQdOXEHTQQXw=;
        b=mi/A27KIaTor+ulh5MzfJEuaKb9VRtYfC5LYhS9QVjfBJgycaWeK9sNG/ut2QKkBix
         2WZjTC1HaLuWzRunQdXdd+LS8NApHW31xtwnJjEfnucX/iV/Cepz5nUQraPxyfREBWjc
         hUuFf/Jd2N2lNiDo+LOzNvbBvaAXWQfOK27gha3MHhTRJn/+N2Q+OHybctKAId1l6tJO
         4yQDK4aF/wvMGqBsy7FogSGCQKcrRC2HPpNgOcRNqyX7/XW6OgU3yl8ENOxBgy0yJpMG
         sB710kiGBnJKMnvHCBr7U1vbRe+8J2/iqeZ7o58A2whpHjRpcBgpSp90pkBkV//de0vE
         /O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680594; x=1718285394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fvkU3UYNCCgjYLGJcSgfkTy9W76vquBkQdOXEHTQQXw=;
        b=P7yoUSymDmviQCP/EQon0YlhpQrchVl7DUWxGAFiAkTim+OUVuVsj/qvb4l8AY6Qz2
         28UP2mRiUgYMIjjD1uLlW3Wwoa2M0xEICMjmieKa4CzB8QfK1xKHfnboyb3OaVdx97sT
         NtjEwcEPwl2ack3Xutb9CvZ/LrDnJJFvVQMnycHVUXxXoF9OXc8Ep3VqPSkut4vB6MlA
         PtIVVDgj5Gjx5LudVwMZqJmqC+w+yfcjylYA+8oNjSnCfVXLKAMO/+SJGNwzYXtevZNR
         m7ol+qaOcNcql3yidb8oCc1m4UPcELfaVhXjDS1qD1Q9umndw8BaBgcykbECiY2n+uPk
         17Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWU08/alIQkgt4HiOHD5CLllOvDTbHQQsZfTDrQytnVamUq3Cc2E00vrQjQl3iu1Sxoj3DVvoSsHLmawfbYOUGjKNB4sEbTVkoiXUN6
X-Gm-Message-State: AOJu0YyN+LLwIBjKZzpH78uBjZeX0vrtcaDczHBOAl04xqp9uRFHWV4C
	4gUc+3G7pPPPppbnkoyW2pDVX/L8XWM0OmtAIvTEy3mMXz7H3AGo9BNlDbujxgM=
X-Google-Smtp-Source: AGHT+IGihh4KKiZRsPsUimCWbL/IXXf+hS2Ri+W4mtukAS+JESrNRz3BD15VPN3J+yIaWrUosgA6mg==
X-Received: by 2002:a05:651c:152:b0:2d8:5fe6:820d with SMTP id 38308e7fff4ca-2eac797f1b3mr42093651fa.11.1717680593837;
        Thu, 06 Jun 2024 06:29:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6d66:dc6b:6c6b:f7aa? ([2a01:e0a:982:cbb0:6d66:dc6b:6c6b:f7aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e989dfsm1572105f8f.80.2024.06.06.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:29:53 -0700 (PDT)
Message-ID: <ec78bd64-b1f2-48c1-b1ab-b7e2f0b9e24d@linaro.org>
Date: Thu, 6 Jun 2024 15:29:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/7] phy: qcom: qmp-combo: store DP phy power state
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-2-a03e68d7b8fc@linaro.org>
 <du4345tswno5pfeiux5ks5eo37bbydilvdzw3firnsps2ejgn5@avnoqzxbmzj7>
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
In-Reply-To: <du4345tswno5pfeiux5ks5eo37bbydilvdzw3firnsps2ejgn5@avnoqzxbmzj7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 10:59, Dmitry Baryshkov wrote:
> On Mon, May 27, 2024 at 10:42:34AM +0200, Neil Armstrong wrote:
>> Switching the PHY Mode requires the DisplayPort PHY to be powered off,
>> keep track of the DisplayPort phy power state.
> 
> How is this different from dp_init_count?

dp_init_count tracks the DP PHY init, while dp_powered_on tracks
the DP PHY beeing powered on by the DRM DP driver, those are
not the same state at all.

While testing, I figured that de-initializing the DP PHY while
is was powered-on by the DRM DP, caused the system to freeze and crash.

SO I've added this to track this state and try to de-init the DP phy
if still in use.

Neil

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index 7f999e8a433d..183cd9cd1884 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -1512,6 +1512,7 @@ struct qmp_combo {
>>   	unsigned int dp_aux_cfg;
>>   	struct phy_configure_opts_dp dp_opts;
>>   	unsigned int dp_init_count;
>> +	bool dp_powered_on;
>>   
>>   	struct clk_fixed_rate pipe_clk_fixed;
>>   	struct clk_hw dp_link_hw;
>> @@ -2685,6 +2686,8 @@ static int qmp_combo_dp_power_on(struct phy *phy)
>>   	/* Configure link rate, swing, etc. */
>>   	cfg->configure_dp_phy(qmp);
>>   
>> +	qmp->dp_powered_on = true;
>> +
>>   	mutex_unlock(&qmp->phy_mutex);
>>   
>>   	return 0;
>> @@ -2699,6 +2702,8 @@ static int qmp_combo_dp_power_off(struct phy *phy)
>>   	/* Assert DP PHY power down */
>>   	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>>   
>> +	qmp->dp_powered_on = false;
>> +
>>   	mutex_unlock(&qmp->phy_mutex);
>>   
>>   	return 0;
>>
>> -- 
>> 2.34.1
>>
> 


