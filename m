Return-Path: <linux-kernel+bounces-566398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C30A67766
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2539416AB39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E820E708;
	Tue, 18 Mar 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQZJuMMb"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D612209F27
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310821; cv=none; b=jcdKK9DxVdyL8U4MP/Q0NvIE1+aEBulKOl8wT9R0ZwBYtD0YDI+3oLfMYQ7Lbk0wdTdOYk65ms/ZKcCzzSHqAnEzkOpTPxmRwThD9Jo25ae1sHgn0rhxuHm2XbdtND8Z0xJF+g9chMV5BzcpT3CzNo+8pGc/IwR8PIaLWdLT4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310821; c=relaxed/simple;
	bh=S4UbmgbCq9MB6GqRqr/p+N/dUf2OOGX1ukT34f2nIX0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EDc7xmjbt71N672/a6QnPbPgcGgg51OuVcjwmrkIWYf7udLWoaXMyKEC7Ob4TrbXCnr4D3qOhkfDX99u7MzCrEgsYNTt6TlQzdb/2h1ahzCA67IRAD2a+NaNeLMRl3zaXuFGSidKZcbgwLYsMSVpsGiNQ5vKTlCc4smfEKIsWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQZJuMMb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf848528aso28664185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742310818; x=1742915618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yUDZJP2SM0YgcV/93zcQ6kDj56FosP1rr3RyiKi/9I=;
        b=FQZJuMMb9/2jx+B1BCqr57tVYA8T5PL2SKAyvHxVEUlkaXfFksBqR7EEQCRqrnlDMR
         AvB7OnKgNEwo7L+6yuK0b/gdTlVWt1QFkMAQ78QRnZSh7YluBh3RxoEiAXU0XPkfAgXb
         BVTp/jt05I3uh97j0Ex0lrfvYcw86oj4hzyYAmGs5TtrnI7nqhRQ1gpeAoMHg9zroMSd
         jCGT4Viw9/piloOqaimMs9cNIRq5/AtB5H6+OmvuZ922BHx1+L5TKngbsUsImJobyJae
         1IGKJv73sv8MhCGafTkJVU+mGI5aqx+nGxQAM9znLopVcRjiMidUarqglbT+NMbdClcx
         qvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310818; x=1742915618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yUDZJP2SM0YgcV/93zcQ6kDj56FosP1rr3RyiKi/9I=;
        b=FcRO487YhHlP/VLaoa5QYNNTdu3OBGuJ2anTDWS+Qw7rPC2UDXTZquVHh9yAIQXScR
         Nk0j1vMZAgtI2Ii34+fWN5cH2LlJo/9gclBNwcd+LsQVXfkQmqEsayQYE9PgClw3Epkc
         WtaNfFfpmnmKJe5kCwckzQP4RfXpmSI6lBiw/MsiAhBB3QoyjeNxtczL4dzhb6HVQVFR
         /XhALhEgXWZ7LDMDNLDxvplWhOpqOOq4iBGlFj/pZNjwNsXJBnb8/SI2/RU7oO+BHLnG
         o1A5I9x04Dyu2txb7NHE2v1Y1yxwbNiqqvPGNh2EQs6ub7snCc9GesKQhrTsV+Jp9Qkj
         oCjA==
X-Forwarded-Encrypted: i=1; AJvYcCWVd6W6X/9Gi8alcorqCpVjD/N2/99gxjZjNfeZMQow9I14lG0sXatzPPsLof/Gfw5n9M39KYDys+/uLiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2w0BIQaL9he5Nx5FlkYhBIBk/BgJ5YPrqv48+FT/kS8o8GhL
	Uk3jUdzfX/X722Pl8pz4Ql43gOPKNN19cLvw4uXGq70d2dqXIuxwf3hMUndKg/M=
X-Gm-Gg: ASbGncuISDVE+uJUNNnF5HB5jpU29RxAet+EbGAzqJL3cbaXTm0YGH+R66+rTAUNJeM
	YFchHtMWQYX5vifQ9n2TrO6QTroVPVVOiGaXvSfHjhUeXr3gj83Iape0LkhHNvF/APpxz91KZ+s
	YkmaZ21yPo65rr8pqZ5SIFmUW7fWqtn6xSpco46ZEcXcRPgI+Wd+/qK/GaAdCf0703jBowGxwff
	7+wAAyMny4iNhnx7v7vFHO6uRGwZJaD8Q2XGHmbIY3Ay4baira/17E6VAnkcsv3Ufd5TinyOPPh
	up2Iyax5GMOk2eeLA3Y7WgBXy60Z1a5WH9+xUBSDLMwXRy9IbUcM5b7Q0h49Pa+f750rRu31+x9
	YVLViqd5Dz2h+3BBgePK2FA==
X-Google-Smtp-Source: AGHT+IGUjoIGYDas8gkpp8G+lgjRxCUGyXnBQnaHKKHqfPTXpCc+7ovIZBRp+DbAz/aaNbbshlGP7w==
X-Received: by 2002:adf:9b97:0:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-3996d536aabmr3166784f8f.38.1742310817752;
        Tue, 18 Mar 2025 08:13:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff? ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40fab8sm18965595f8f.63.2025.03.18.08.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:13:37 -0700 (PDT)
Message-ID: <c2d692a4-826e-4186-955a-41286c99de3f@linaro.org>
Date: Tue, 18 Mar 2025 16:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 3/6] phy: qcom-qmp-ufs: Refactor UFS PHY reset
To: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
 kishon@kernel.org, manivannan.sadhasivam@linaro.org,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 konrad.dybcio@oss.qualcomm.com
Cc: quic_rdwivedi@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20250318144944.19749-1-quic_nitirawa@quicinc.com>
 <20250318144944.19749-4-quic_nitirawa@quicinc.com>
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
In-Reply-To: <20250318144944.19749-4-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 15:49, Nitin Rawat wrote:
> Refactor the UFS PHY reset handling to parse the reset logic only once
> during probe, instead of every resume.
> 
> Move the UFS PHY reset parsing logic from qmp_phy_power_on to
> qmp_ufs_probe to avoid unnecessary parsing during resume.
> 
> Co-developed-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 104 ++++++++++++------------
>   1 file changed, 50 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 0089ee80f852..3a80c2c110d2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1757,32 +1757,6 @@ static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg
>   	qmp_ufs_init_all(qmp, &cfg->tbls_hs_b);
>   }
> 
> -static int qmp_ufs_com_init(struct qmp_ufs *qmp)
> -{
> -	const struct qmp_phy_cfg *cfg = qmp->cfg;
> -	void __iomem *pcs = qmp->pcs;
> -	int ret;
> -
> -	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
> -	if (ret) {
> -		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = clk_bulk_prepare_enable(qmp->num_clks, qmp->clks);
> -	if (ret)
> -		goto err_disable_regulators;
> -
> -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
> -
> -	return 0;
> -
> -err_disable_regulators:
> -	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> -
> -	return ret;
> -}
> -
>   static int qmp_ufs_com_exit(struct qmp_ufs *qmp)
>   {
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -1800,41 +1774,27 @@ static int qmp_ufs_power_on(struct phy *phy)
>   {
>   	struct qmp_ufs *qmp = phy_get_drvdata(phy);
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qmp->pcs;
>   	int ret;
> -	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> -
> -	if (cfg->no_pcs_sw_reset) {
> -		/*
> -		 * Get UFS reset, which is delayed until now to avoid a
> -		 * circular dependency where UFS needs its PHY, but the PHY
> -		 * needs this UFS reset.
> -		 */
> -		if (!qmp->ufs_reset) {
> -			qmp->ufs_reset =
> -				devm_reset_control_get_exclusive(qmp->dev,
> -								 "ufsphy");
> -
> -			if (IS_ERR(qmp->ufs_reset)) {
> -				ret = PTR_ERR(qmp->ufs_reset);
> -				dev_err(qmp->dev,
> -					"failed to get UFS reset: %d\n",
> -					ret);
> -
> -				qmp->ufs_reset = NULL;
> -				return ret;
> -			}
> -		}
> 
> -		ret = reset_control_assert(qmp->ufs_reset);
> -		if (ret)
> -			return ret;
> +	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
> +		return ret;
>   	}
> 
> -	ret = qmp_ufs_com_init(qmp);
> +	ret = clk_bulk_prepare_enable(qmp->num_clks, qmp->clks);
>   	if (ret)
> -		return ret;
> +		goto err_disable_regulators;
> +
> +	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
> 
>   	return 0;
> +
> +err_disable_regulators:
> +	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> +
> +	return ret;
>   }

This change is too fuzzy, please introduce qmp_ufs_get_phy_reset()
in a patch, move qmp_ufs_com_init() inline in qmp_ufs_power_on()
in a second time, and finally move reset_control_assert() to
calibrate in a third patch (and explain why).

Thanks,
Neil

> 
>   static int qmp_ufs_phy_calibrate(struct phy *phy)
> @@ -1846,6 +1806,10 @@ static int qmp_ufs_phy_calibrate(struct phy *phy)
>   	unsigned int val;
>   	int ret;
> 
> +	ret = reset_control_assert(qmp->ufs_reset);
> +	if (ret)
> +		return ret;
> +
>   	qmp_ufs_init_registers(qmp, cfg);
> 
>   	ret = reset_control_deassert(qmp->ufs_reset);
> @@ -2088,6 +2052,34 @@ static int qmp_ufs_parse_dt(struct qmp_ufs *qmp)
>   	return 0;
>   }
> 
> +static int qmp_ufs_get_phy_reset(struct qmp_ufs *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	int ret;
> +
> +	if (!cfg->no_pcs_sw_reset)
> +		return 0;
> +
> +	/*
> +	 * Get UFS reset, which is delayed until now to avoid a
> +	 * circular dependency where UFS needs its PHY, but the PHY
> +	 * needs this UFS reset.
> +	 */
> +	if (!qmp->ufs_reset) {
> +		qmp->ufs_reset =
> +		devm_reset_control_get_exclusive(qmp->dev, "ufsphy");
> +
> +		if (IS_ERR(qmp->ufs_reset)) {
> +			ret = PTR_ERR(qmp->ufs_reset);
> +			dev_err(qmp->dev, "failed to get PHY reset: %d\n", ret);
> +			qmp->ufs_reset = NULL;
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int qmp_ufs_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -2114,6 +2106,10 @@ static int qmp_ufs_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
> 
> +	ret = qmp_ufs_get_phy_reset(qmp);
> +	if (ret)
> +		return ret;
> +
>   	/* Check for legacy binding with child node. */
>   	np = of_get_next_available_child(dev->of_node, NULL);
>   	if (np) {
> --
> 2.48.1
> 
> 


