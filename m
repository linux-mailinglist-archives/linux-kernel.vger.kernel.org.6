Return-Path: <linux-kernel+bounces-568341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0EA6942D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6465C3BA0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2CF1D5CD7;
	Wed, 19 Mar 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPgVT0oM"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC51DD0EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399576; cv=none; b=IjV5WjBXcByFYEnB85yEuvrSksi2g61NHliy6vqhQ6M22CASOryxhp2ilMGtKPcduGwdvrYEEZDBmpkEWLjnrnmBFHRHRM+pRJ5eadiPiefu/LRw2Czss3vARI937VbwN5ymYAn3MZtrqLWud9+5ShgF5OzbCYbrUNgzcVv8oOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399576; c=relaxed/simple;
	bh=O11BgruQbl+UKgDttpGfPSppdluCW3BNuYGdXOixy6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bXM6movWsjbdQWWx0O+4Llf29c9S4qdiummrW6yHR3QMumQEUz18+EgPK7DoU61ZZscEi1v3PqQYd9nqw9S5V7YYjItfZxSXpQJDL9pDDSIhVd9DKOouiERINlMpOui1ezRm05EiPxZkzWtuEv0DcDEmMZUUdXzRZXseqAWckwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPgVT0oM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-399676b7c41so2211568f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742399572; x=1743004372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtS7yrlPmvbmoIZ5I3j5iqPfhEamBd1a1pbda+O2aq4=;
        b=IPgVT0oMtKgPbVTsrimDkNKsLb44VRrLiN7gqASDcjIW3PbPPQk3uC4xw6uf1qTPcj
         CsCDWnGMevAJhuX9ScNh/vvp5WInY0VHroC1plfe6SeZ1qpr9/fWNqAnRvAWNijGBK/O
         hMI3fV7885I/sXXjwRK3yJNyBQEoN2QjDf/ZLe75KUDHLnRwvrZLzdIdMtge4Ral0Z+f
         SB9LyAcUdHNHWP/LyPgjFUbocQBKvxbfYUn9crLvk5QWJvvfntbqP7P7f7GxizKuYO63
         JoCv+ljsAfxHQARBxGTNsos733siiyhC46pSoXwHOE8T0oJMZuXlAh2rpHIb5vWZGvxW
         Gkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399572; x=1743004372;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OtS7yrlPmvbmoIZ5I3j5iqPfhEamBd1a1pbda+O2aq4=;
        b=RAsOXOHnNFPqKNGpcOF3xYQ/0I+ZONFrUGziu5/LEvPlyuHEF4XnEBaoMdLJEuXhcs
         jt19aStxnEsZArjWKXV3iatbTOyUR9Ygk/j10fQxZYf/2luzykrU+l85jeKef4v80DJu
         GwEvzQefm3pFqCvSpdI3nBV4TZecQuk07h5oyppe2SCOPBCNh9ZoCg/FZ/wNKguf0xxA
         RF+OYHVfrjXC2/FjynWl+cO6fCy/JdSiMmOFWHgOcd/cjbTMVou3dbSZ95XcY1dhitXb
         HFMVB61Gsyi6U7DQd0uiUnqedxb8dX3/RjqyRV2ofB769+yZqGFzawRpf4ybjS8qcSHx
         yFQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Up9BVtMXFneNl+ydUVW8IDJ3rJ8nTInzk9xfRObisN3hoY3a/hxtAaRYJ2m4Pa7K7HBZvCNgPxgo/Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgyK+Y95XFzeZZ5jZMDEOEZTFOiSpN+IUyTrlM5s94Dcorluw
	qW7Z0+W6wOi5ktKP/iUtNYEbJZ7xWMi4IYktgzn/7oOlGjDs6corT13yxpKjIv0=
X-Gm-Gg: ASbGncuA81pShhSyWRe06g/kNjTM8ZQa7xlK/f7/p0iBtjp7Grm9V8kBdcgfqwCGBXO
	s+LceqS88jp/mmq0IcgvU3iQqLapo0pShMTT46GLCYQXwzSFeWphAmflIbQicrVf/f7Jy6GGA/+
	2YPnFi93cgSli6v0ejHUSze9+3zi2NdzUbFSqNO4K/Hq6xgOGckRZxsRe2AVUmnV7H3c5YrP+yz
	SyBHr/Vng8uMOrpBFOeB6y6b5q1DATVIILCriW4w4QNFBZbdvi5T7JeCA6N7n9BFexyoZvsRi+H
	cHtTrHZV5jpDF3FZQ+MV70dtjz7RdPMIFGNeGROwZNi3YmB0hQv3L4sfL6uwc8pUyIQ9HTexPpi
	zsTTeGYXNzsFThx2QGriu0Q==
X-Google-Smtp-Source: AGHT+IGsoc3lhwMmNWUU7VPFLD8o2mSVAZY4GJxoMl37et8H1SS/K5nKfGy4iqKsLgIPiZmC2lFXVw==
X-Received: by 2002:a5d:5f90:0:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-39973b08eeemr3730040f8f.44.1742399572180;
        Wed, 19 Mar 2025 08:52:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f407:ab81:b45a:93e8? ([2a01:e0a:3d9:2080:f407:ab81:b45a:93e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b34sm21539248f8f.55.2025.03.19.08.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:52:51 -0700 (PDT)
Message-ID: <bfba8edb-b1e9-4b9f-bf96-bcba35e0cd8f@linaro.org>
Date: Wed, 19 Mar 2025 16:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 4/7] usb: dwc3: core: Don't touch resets and clocks
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Saravana Kannan <saravanak@google.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318-dwc3-refactor-v5-0-90ea6e5b3ba4@oss.qualcomm.com>
 <20250318-dwc3-refactor-v5-4-90ea6e5b3ba4@oss.qualcomm.com>
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
In-Reply-To: <20250318-dwc3-refactor-v5-4-90ea6e5b3ba4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 20:05, Bjorn Andersson wrote:
> When the core is integrated with glue, it's reasonable to assume that
> the glue driver will have to touch the IP before/after the core takes
> the hardware out and into reset. As such the glue must own these
> resources and be allowed to turn them on/off outside the core's
> handling.
> 
> Allow the platform or glue layer to indicate if the core logic for
> clocks and resets should be skipped to deal with this.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>   drivers/usb/dwc3/core.c | 20 +++++++++++---------
>   drivers/usb/dwc3/glue.h |  3 +++
>   2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b428b6fc3d0a55811e2f75d33d79df4b0c67dcac..77a9848a0ac70fbe563988cecbe489130989aadc 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2198,15 +2198,17 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
>   	if (IS_ERR(dwc->usb_psy))
>   		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
>   
> -	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
> -	if (IS_ERR(dwc->reset)) {
> -		ret = PTR_ERR(dwc->reset);
> -		goto err_put_psy;
> -	}
> +	if (!data->ignore_clocks_and_resets) {
> +		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
> +		if (IS_ERR(dwc->reset)) {
> +			ret = PTR_ERR(dwc->reset);
> +			goto err_put_psy;
> +		}
>   
> -	ret = dwc3_get_clocks(dwc);
> -	if (ret)
> -		goto err_put_psy;
> +		ret = dwc3_get_clocks(dwc);
> +		if (ret)
> +			goto err_put_psy;
> +	}
>   
>   	ret = reset_control_deassert(dwc->reset);
>   	if (ret)
> @@ -2321,7 +2323,7 @@ EXPORT_SYMBOL_GPL(dwc3_core_probe);
>   
>   static int dwc3_probe(struct platform_device *pdev)
>   {
> -	struct dwc3_probe_data probe_data;
> +	struct dwc3_probe_data probe_data = {};

This should go in the previous patch

Neil

>   	struct resource *res;
>   	struct dwc3 *dwc;
>   
> diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
> index e73cfc466012f07214291abe56454934ab014013..703d40c189565b1e28ae28afb8728b78f4cd2fca 100644
> --- a/drivers/usb/dwc3/glue.h
> +++ b/drivers/usb/dwc3/glue.h
> @@ -13,10 +13,13 @@
>    * dwc3_probe_data: Initialization parameters passed to dwc3_core_probe()
>    * @dwc: Reference to dwc3 context structure
>    * @res: resource for the DWC3 core mmio region
> + * @ignore_clocks_and_resets: clocks and resets defined for the device should
> + *		be ignored by the DWC3 core, as they are managed by the glue
>    */
>   struct dwc3_probe_data {
>   	struct dwc3 *dwc;
>   	struct resource *res;
> +	bool ignore_clocks_and_resets;
>   };
>   
>   int dwc3_core_probe(const struct dwc3_probe_data *data);
> 


