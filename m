Return-Path: <linux-kernel+bounces-365778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C099E9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB00C1C21361
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72C1F4734;
	Tue, 15 Oct 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvHFbJS6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC9206E62
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995262; cv=none; b=mT0yRRXV/RQu8y+2wD5tt3DK9GdXmBklkEgHQUqYEAZRnB0W8Lpb8as9Rf/tUcqmHkKzNOSsawtmT6R3PoLiZJAQCny02yUM0v9c7wwxSy+9nCJYwzhwQuRIvXyAE/M5F0RqbZ0Kaodp9s+4O3Gdwg/89BIIaMXeW+rGQWOl//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995262; c=relaxed/simple;
	bh=feQDBjUKAiUPRO0p3liJWLuxYKg2KJKcrPn67v5j4ng=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m8q71MESh+MFZ88QtXg4UOBxGS4j3ooq20wyQxqC2LH0VgqJdVYR84MdD69+IN7gIywQWm4Nm5qr7xzdcyhDpFTKqmF6BZKmglBwhmrb0CfUeJp+W0EDqZSsXZSTaxiY+N2+bsM0dHJ0yyLlRtbaK46RJNKnzaddyBlAXma9rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mvHFbJS6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431286f50e1so34827075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728995258; x=1729600058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jp7MnEnWaCupoBR7Ejaobihsf5bkTsK/bDvsZp/OLs=;
        b=mvHFbJS6pnd99uv2KAVWpwj5h98frz9DFwf+ADO+wdNgr5wBN0IEQWCFjcF2Weu5Ot
         h7+DtdO23Lig1DkInfMdw4GZImILuQ8WluWcqb4U3uYXChmEkm0rsfxFNX4MfEaxVUYt
         tO2AL0JOnxLtLd4L6PmPBOqGB4NdBUUhP1ZLtKm2xvE8BmP3xkuKzQpPqcut3gjc4FyF
         T4kZLE72ROetet9H4MafbreEKUBGpxGcChJrdaP8nGRcESLerEcjz/NoFPJh02izwV7X
         qGNknFNidxaZdyQHU7aDvCZ96dWjwxyEv4xwoglNtJRJ16M1zMOjYzRlBG7cuEzcVV77
         moxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995258; x=1729600058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jp7MnEnWaCupoBR7Ejaobihsf5bkTsK/bDvsZp/OLs=;
        b=EV7i7NBOjD5x1sXmZLwOCQwarS2oWZ/wbJn1zOKy3iQiQSM/mPBg+5TOjzotiXHA2F
         PL7Rx4krL83zqf9Swai+otnbYvMsNrkfAQvTtD9J98ybfudlnfzTpOfNOinSHJADsL7Q
         eU+0tF/RPgm6tbjiV0DZk1zelpYlbM3on6D6i2MEJL1kjE0yutKBREdKz9k7PQrUlVMi
         m/V15ana3LXyweZ+NbMtyYA93LP7s8izWPMmYcXzCGztj4r27ubfqz4mZ6gxpPttoJsi
         a474wjdPkcwXcl8pOInI1p0JaIpGjWFzwGuk7azoDhvbJ5hauN/nPHWCsM/SoZwKfSo0
         +94w==
X-Forwarded-Encrypted: i=1; AJvYcCUjfncpPeOU6jeaFA6F9KaIXYH4YUZ6goFlmZCu4E1hjPrtu2EkIxQ5rsXITguM4Ucizl6RqWNcA68/PzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLFfI+D2/tI/cKK8lV9bZ5sRhG1YJt5Qw+WSm9fOg3H2KLBxA
	zPVV06vu8mByBM+wl16ZW7SNVsOb1MOzFFO+6ZzhuDKCIUiXlthhXRU4XKE/F3x2HPald2bwAsc
	+wbo=
X-Google-Smtp-Source: AGHT+IF5nBLO8Fh0jojEAcLQEJwPyUp6jyRdDuWX0jMQK/+gUYhmGD66OBVnQzWcvbP+N3t1yUIrjw==
X-Received: by 2002:a05:600c:1c13:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-43125617834mr113128555e9.35.1728995257803;
        Tue, 15 Oct 2024 05:27:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e686:73e1:36a8:3467? ([2a01:e0a:982:cbb0:e686:73e1:36a8:3467])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b323asm16450925e9.36.2024.10.15.05.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 05:27:36 -0700 (PDT)
Message-ID: <0f3d1827-c3b0-4e58-95bf-7ccfb1366928@linaro.org>
Date: Tue, 15 Oct 2024 14:27:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] phy: qcom: qmp-pcie: drop bogus x1e80100 qref supplies
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241015121406.15033-1-johan+linaro@kernel.org>
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
In-Reply-To: <20241015121406.15033-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2024 14:14, Johan Hovold wrote:
> The PCIe PHYs on x1e80100 do not a have a qref supply so stop requesting
> one. This also avoids the follow warning at boot:
> 
> 	qcom-qmp-pcie-phy 1bfc000.phy: supply vdda-qref not found, using dummy regulator
> 
> Fixes: 9dab00ee9544 ("phy: qcom: qmp-pcie: Add Gen4 4-lanes mode for X1E80100")
> Fixes: 606060ce8fd0 ("phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index f71787fb4d7e..36aaac34e6c6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -3661,8 +3661,8 @@ static const struct qmp_phy_cfg x1e80100_qmp_gen4x2_pciephy_cfg = {
>   
>   	.reset_list		= sdm845_pciephy_reset_l,
>   	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> -	.vreg_list		= sm8550_qmp_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= pciephy_v6_regs_layout,
>   
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> @@ -3695,8 +3695,8 @@ static const struct qmp_phy_cfg x1e80100_qmp_gen4x4_pciephy_cfg = {
>   
>   	.reset_list		= sdm845_pciephy_reset_l,
>   	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> -	.vreg_list		= sm8550_qmp_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= pciephy_v6_regs_layout,
>   
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

