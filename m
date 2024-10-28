Return-Path: <linux-kernel+bounces-384460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02C9B2A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1DA280B40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97760190692;
	Mon, 28 Oct 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxCf3ste"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7D18E04D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104232; cv=none; b=kyg1EZHeQuclwx62HL1AX6z6TLHB81H2SzB+uJS3cjs1A/WVAqJL6hyessV6yut8n47r6tFSvob0FRtLygwDjWbOGfsIfUz/t7DtYSQwxWJUTe/9iU1v1IY/rm7nYDAN5hmLY8bHf//TIYvn7yUKEAzVQur+iSP1r5Jt4GaJlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104232; c=relaxed/simple;
	bh=b22lpaZwQiZeRfSjo3PUIdP3+liqMITYadt/5xhXlm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u3TxDq9/NfJqYVV/B+T00efMv9gdumquQGtB2DEH3Cdr6SvKaFBHWHhVEsXl1v5L9e7bO3YqMsgwbDZYQj6OO+ZI+l1BaHMDwzRM7TLxqPKkUd6rVxfqxZsEP2T+zkxhi2dR3JomMsYY2GfXn+xBkna8TnEIPvUXcrKfst3RlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxCf3ste; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso37585125e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730104229; x=1730709029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73g/0+gUgeDCUsnUF3fGVV3ByR3GRRyQwDQ4Lqj2ePg=;
        b=IxCf3steuL1ijh92perQ/BAZZWRx/hL+9Cg4V080UWB8wEHZWRqGG56JzmxqH34oVX
         N6VL0TJHY0LoEwDHUuiS0/52VBAgqbgfGVCpbjVfm832IbBNYhFo6J5cMXcv8j14J50I
         /QT2iVWPEC5wU44jEIq99mPkypqfR5taHTCjL8QHGzmyfT32OYVjCvVnqbp1VFJ93cWP
         Bp9Z6LmEj7nzqbf+fosXyxXd/pp83iiST+X0u7u9V4Bme6HtzzGZi1zUUGFjzrgf7mm9
         4+QPNtfoeG5wmqw1Qj3qORpeUMhHm0imCydkmjhEdtFSjYkAoj9oCoWviF92Z/z8hOqQ
         gEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104229; x=1730709029;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=73g/0+gUgeDCUsnUF3fGVV3ByR3GRRyQwDQ4Lqj2ePg=;
        b=vC40s8m4vZUtUqOwy36DU+BWa3uhgJxgWQgE5fOidDnJiOHXoNcubC/2Gt0bjVilok
         AC+cNcUz/NHW57utkDbPiuLTWcDrfJ7NM2keghFOFcjUsi08oq3y1G/6dS9uhzJZ0iLd
         FWX8vgxmFotV29lB7RKdcKNzFdGQPTBz1DMsC+nZ5q87pjXPuUI8OUvCzFMjRRj4aEfw
         mk2hmma+tXeVbMNdNZsjigqtI/iMeJIVBt2bz5owQjdpSYnbNpwt2pbZWKMX+PAxVOAB
         C3LTIOZh9JK/4x9kFSkUuIekHBAT4jEE/S420uWtA4agAwwO7XhA9Uc1NEdophGpuFHy
         lpnA==
X-Forwarded-Encrypted: i=1; AJvYcCWV/LXJrFjA9lH2wAGhMe0jBGGWhRbb6farYFqQ9OLxN02hJ1gclii4Xa5IgNatMdYQoQkRC0DmSTt6pOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qk8QqrZlHZajYVG4ZsXIrLndMQ/qnvJUMMnSsN2C6UyrbRMe
	tVaMnjniTlIqs2yJX19mFxDNScWqkq2H6mg3qczKdDidrvFduxzgJUMuk6dHPHI=
X-Google-Smtp-Source: AGHT+IFMNl7wjLjMXP2uoBDuMSo97549a4E58NbpIteSsy1yxx8bvOMqVrJeKpHQpR1Vr/uDGWI2QA==
X-Received: by 2002:a05:600c:314a:b0:431:5aea:964 with SMTP id 5b1f17b1804b1-4319acb12e3mr61888985e9.19.1730104228909;
        Mon, 28 Oct 2024 01:30:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c11d:e163:200e:8a5d? ([2a01:e0a:982:cbb0:c11d:e163:200e:8a5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f39fsm131747095e9.12.2024.10.28.01.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 01:30:28 -0700 (PDT)
Message-ID: <c266daa5-c8a5-4832-b85a-783c92b10bb2@linaro.org>
Date: Mon, 28 Oct 2024 09:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] remoteproc: qcom: pas: add minidump_id to SM8350
 resources
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241027-sar2130p-adsp-v1-0-bd204e39d24e@linaro.org>
 <20241027-sar2130p-adsp-v1-2-bd204e39d24e@linaro.org>
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
In-Reply-To: <20241027-sar2130p-adsp-v1-2-bd204e39d24e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2024 00:09, Dmitry Baryshkov wrote:
> Specify minidump_id for the SM8350 DSPs. It was omitted for in the
> original commit e8b4e9a21af7 ("remoteproc: qcom: pas: Add SM8350 PAS
> remoteprocs").
> 
> Fixes: e8b4e9a21af7 ("remoteproc: qcom: pas: Add SM8350 PAS remoteprocs")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index ef82835e98a4efd4bc603cff604d531a51fe9f9c..b10b4fc84f14eb40d64b278a339f2ceb45250a62 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -923,6 +923,7 @@ static const struct adsp_data sm8350_adsp_resource = {
>   	.crash_reason_smem = 423,
>   	.firmware_name = "adsp.mdt",
>   	.pas_id = 1,
> +	.minidump_id = 5,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
>   		"lcx",
> @@ -1124,6 +1125,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
>   	.crash_reason_smem = 601,
>   	.firmware_name = "cdsp.mdt",
>   	.pas_id = 18,
> +	.minidump_id = 7,
>   	.auto_boot = true,
>   	.proxy_pd_names = (char*[]){
>   		"cx",
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

