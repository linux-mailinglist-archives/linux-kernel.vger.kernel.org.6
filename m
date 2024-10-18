Return-Path: <linux-kernel+bounces-371138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC29A36F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD11F22AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE831187FE8;
	Fri, 18 Oct 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mT6pWflX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA1183CD1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236000; cv=none; b=qVd2BQKxIJbQ/9cuh8y9qI4xuTb5Hg9bG/ocG+Lf5IVNq2mImg2t8YNFscsoxwBUnpORjlnar7zWvrX0E7VJ4Z87cy4kvFTS+6xoXAXCiwzvknPqzrxu8Y5YDHfRLBzYZ9GhOcmDK6resFhwwIFqP1oYRfbyk+ogdUSyMgzB7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236000; c=relaxed/simple;
	bh=uUctaSUeuSR/tl3n40AoJXSAlasaIsytGhGjL1hzRfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SkHIDEe8Dk7zPdit8Wbb07CvoSxcLkW04PmoWgRITxPwMuoq/sj/yfTifjuzbWSPf/2vdLgeXlEIU+tQu7xWz9dbo/eFwSSfQG/P3UiDqfRsUSONTSlzMYcqcc+sDNvAhg5AGxvhs8x0zSmHw33Z+u47I994D3L+ZLVd2JnBWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mT6pWflX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so10260175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729235996; x=1729840796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFsQArlzln8F0OTpUr5gAS0Us5DdTYm+LCK0FQeTFXo=;
        b=mT6pWflXTcn/nOUtwWlFbmBlaoRkN1DOXTE5iI2gjHhh16XF+Kl9D+QKFtWHiZF8Ds
         rTWUCd3ucMoPIxCLwFGKGIoxvjz9HTDlmitfuaAqdXm+zG+LsSsYMPncWpV2U34kKHDU
         SYuq3IESat9zoIdFFblW2wWdV8N0sJddq/1KEv5cKI9MtU+Sp8aDizBsEKtVaveWeps5
         yGO8GLeWFcI8a6xmnvK3DMr1F9dbCDibPjDNnQPtAXt9MPHFvx1rxBSlVZbKejVpAmBf
         5FKexdNJYU1ZZ5mkOehPsqh2OAEwEgXXBon2IC7YO85NghhBCj3PxYNsCNHN4agCnQR/
         7gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729235996; x=1729840796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EFsQArlzln8F0OTpUr5gAS0Us5DdTYm+LCK0FQeTFXo=;
        b=bAIHjUR9Hu+8m248Hfn3Qkbv5R0CME1VqPkG2vUQSZxE5jfRWchrWUwSDAVka0ry9D
         aWFovVltckrsxv4gnECSeEu0BxeNPqRmhGxl9ZDH8BD2fE23IZOGEu2kkwMy8ioIQvGX
         1WeK4fIiCon2HxPEy6TnrG9ElWdXxvhEzY5jIREa7gz2viSj3SC9FO9IIJVL4+PjX6fA
         he+HUN+kIyPfehNDRjVo+s5WQnUSnEuS3KW8Y28CqODhU7GzNwY8NsfeYWAW8CT1pJ4k
         8AWv7L0vW9kTXQ93Uc+s7G/igATxvfuqyZjjZATXM/7L55g4zs3i4hkLeR2QPxsq4eUn
         vKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrqu0R4Cg75OBCnP0nFy3SL29v88O7Ij7FgxozVYA/aedaODNR4q9Auuu2fUUj0MRwH7rYrZQsrjl0ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaGJ8V7xEl7aIMC4Ma4scQUmLGhvz0Zdrv+jzB85+XVCJId7g
	wlK4Mjc1Sq9Ikkq2/Bx0kVLao9fBsvfdLn4PVmx1HtN+F4ARbKCktTivxQKqjbY=
X-Google-Smtp-Source: AGHT+IFRTNZaGcIqBNrqF0UQnvOY3WFj9aGTgwW75vhsIyJt3teEYr05LtJkleMEPi/b+g6VrdiNAw==
X-Received: by 2002:a5d:4b05:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37ea2177e67mr1025235f8f.17.1729235996538;
        Fri, 18 Oct 2024 00:19:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b623:41fc:e293:c9b1? ([2a01:e0a:982:cbb0:b623:41fc:e293:c9b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed24esm1133059f8f.82.2024.10.18.00.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:19:56 -0700 (PDT)
Message-ID: <e3386cf9-170e-477b-88d8-dab3bb437da3@linaro.org>
Date: Fri, 18 Oct 2024 09:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: add support for SAR2130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
 <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
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
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 19:52, Dmitry Baryshkov wrote:
> Define power domains as supported by the RPMh on the SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/pmdomain/qcom/rpmhpd.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 731feab9f17ddae699815332d193e9a298fff0e1..5c5f9542c3925045cc90872e81cae3e6c2936212 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -259,6 +259,30 @@ static const struct rpmhpd_desc sa8775p_desc = {
>   	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
>   };
>   
> +/* SAR2130P RPMH powerdomains */
> +static struct rpmhpd *sar2130p_rpmhpds[] = {
> +	[RPMHPD_CX] = &cx,
> +	[RPMHPD_CX_AO] = &cx_ao,
> +	[RPMHPD_EBI] = &ebi,
> +	[RPMHPD_GFX] = &gfx,
> +	[RPMHPD_LCX] = &lcx,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
> +	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
> +	[RPMHPD_MSS] = &mss,
> +	[RPMHPD_MX] = &mx,
> +	[RPMHPD_MX_AO] = &mx_ao,
> +	[RPMHPD_MXC] = &mxc,
> +	[RPMHPD_MXC_AO] = &mxc_ao,
> +	[RPMHPD_NSP] = &nsp,
> +	[RPMHPD_QPHY] = &qphy,
> +};
> +
> +static const struct rpmhpd_desc sar2130p_desc = {
> +	.rpmhpds = sar2130p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sar2130p_rpmhpds),
> +};
> +
>   /* SDM670 RPMH powerdomains */
>   static struct rpmhpd *sdm670_rpmhpds[] = {
>   	[SDM670_CX] = &cx_w_mx_parent,
> @@ -665,6 +689,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
>   	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
>   	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
>   	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
> +	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &sar2130p_desc},
>   	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>   	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>   	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

