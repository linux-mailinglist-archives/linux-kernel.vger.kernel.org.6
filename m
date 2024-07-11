Return-Path: <linux-kernel+bounces-249116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024892E71E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7562C1F27E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D703156F5D;
	Thu, 11 Jul 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORCVTSyt"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970237169
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697751; cv=none; b=ddsfvoVGEHpUqokHCz1WFFtGWsUoC5hOpdrvlkq9357psUOJun0W0dt+Q+Rj2f/CAvNBRm67LjvsicZIf8Agao/pZzqwLnH03i6pNjntAu474I5iUSrg2Om1TWesgrW1NHLVNGk15H2m3WuzCTFrS07lqCl67MZXA3nSVoVwoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697751; c=relaxed/simple;
	bh=WNfYtTxA3mpKaMfjof5I3Mzuilw/m+RFPxQleWDdE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgTwquc6VS6BvLIFIU4JWkUL1wetECpsVPRAp0kPAssYBC7jhqqHwBg9740iRlyM9VmYmXvav57rS2hnHhTsIubQFCNlxz/vEyd5SaeLE3vffiwt01UiRc8dp+0hcxbUULZGvakT2NMbHZ+uUPw2qfE+HNCUuG4155ZO08K/emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORCVTSyt; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so8725031fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720697748; x=1721302548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXljFkqNP7CbNXZW/UztiSdfE2JPHZ4v+VL+r7mD4h0=;
        b=ORCVTSytyJ1znoZPrDxEJm1f7rWudYVffQscfdpxgCJDbgkPrCudoGMn3LQPv90HBI
         hBc9QVqBtiMnAIyhp1lBkK3uUTK6KIZ0SZ4wgnp+XhOCwfNTgAr3mknMvKHLvFK0TUcd
         gNVrBQGfzh+tg5hlyIV6yxb46Rn9f2VloiHz9vOhNsYL3CRvz49j1S1GhsiexctuPP7f
         mKud3HBBAINeBZ7Hn3ZGCDZpyHhLlruDLdxvJG0ZUjUW/uwI5lQU6MHtUR1T1eL3NUX0
         NdHWj370OeTFdiLwYLn83gJInNYNCvz1nUEBg4hnP1fFA1bO1SotXeClDcN6MTcLE8fe
         ijjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697748; x=1721302548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXljFkqNP7CbNXZW/UztiSdfE2JPHZ4v+VL+r7mD4h0=;
        b=nauwtVeuoczUrRQjuaOcFMDEMuWidc85Im56vKP9xPXWHgeh4fcw1BqYmv5wAWMegb
         uIn4zfhPiLsjoauvxu4eFWlxdkEB4iji8Ksz+hbXNmaXXUj1IFKsfB/HOravjCXivdyu
         GQSbjqPOVd9gQaoi24jAJUqd5K+eS6qmXkqCACkseGRVYvQsqASEBVAlSr3ZTzH0z7ZZ
         Hlt54ysNzaNGrzkbRhF9nj8LWtyluM7ggwJYORdzI0wygl03gwj44CJqsrlnYVMzNJPQ
         IKsP6uG/GH51gdPSFnPexDlO1IhGIOi0npBsU+Wjz/YzgedOKWmrhVWtFn4J4ci6FFoj
         G+xg==
X-Forwarded-Encrypted: i=1; AJvYcCX66p176HlzmJcKYgtYaOGQoVDSB2jU0e9zoDwqmZOH9LmmS0LugYAu84ETuH3LUXq1YIzz8Y/gIBZN+QdIP34PHdzet3oczeOL+J6l
X-Gm-Message-State: AOJu0Yw9WgutYGkQqVgdFX6loc8pDMpczj9+a5htfEbkOtmGZf9EtEWZ
	UVpXYUbH+kZ6nFTbh5IwBPF/OuoukzCXjVIdfni9i+/zMENoBg6I2AcHjY1CuZc=
X-Google-Smtp-Source: AGHT+IHz8tK1jzaE2u8cjgp8meMdQXT1ecN3TRFLd9ol6j/drC5ozKOvVH6kUT7yZ+bRcqEfAn0Eiw==
X-Received: by 2002:ac2:5bc5:0:b0:52c:dcab:6738 with SMTP id 2adb3069b0e04-52eb9990fc5mr4979174e87.1.1720697747806;
        Thu, 11 Jul 2024 04:35:47 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42725d2e132sm94451985e9.32.2024.07.11.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:35:47 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:35:45 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: x1e80100: Update PDC hwirq map
Message-ID: <Zo/DkR7CYS6JvQ3G@linaro.org>
References: <20240711-topic-x1e_pdc_tlmm-v1-1-e278b249d793@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-topic-x1e_pdc_tlmm-v1-1-e278b249d793@linaro.org>

On 24-07-11 11:37:57, Konrad Dybcio wrote:
> The current map seems to be out of sync (and includes a duplicate entry
> for GPIO193..).
> 
> Replace it with the map present in shipping devices' ACPI tables.
> 
> This new one seems more complete, as it e.g. contains GPIO145 (PCIE6a
> WAKE#)
> 
> Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/pinctrl/qcom/pinctrl-x1e80100.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> index e30e93840357..6cd4d10e6fd6 100644
> --- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> +++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
> @@ -1813,18 +1813,21 @@ static const struct msm_pingroup x1e80100_groups[] = {
>  
>  static const struct msm_gpio_wakeirq_map x1e80100_pdc_map[] = {
>  	{ 0, 72 }, { 2, 70 }, { 3, 71 }, { 6, 123 }, { 7, 67 }, { 11, 85 },
> -	{ 15, 68 }, { 18, 122 }, { 19, 69 }, { 21, 158 }, { 23, 143 }, { 26, 129 },
> -	{ 27, 144 }, { 28, 77 }, { 29, 78 }, { 30, 92 }, { 32, 145 }, { 33, 115 },
> -	{ 34, 130 }, { 35, 146 }, { 36, 147 }, { 39, 80 }, { 43, 148 }, { 47, 149 },
> -	{ 51, 79 }, { 53, 89 }, { 59, 87 }, { 64, 90 }, { 65, 106 }, { 66, 142 },
> -	{ 67, 88 }, { 71, 91 }, { 75, 152 }, { 79, 153 }, { 80, 125 }, { 81, 128 },
> -	{ 84, 137 }, { 85, 155 }, { 87, 156 }, { 91, 157 }, { 92, 138 }, { 94, 140 },
> -	{ 95, 141 }, { 113, 84 }, { 121, 73 }, { 123, 74 }, { 129, 76 }, { 131, 82 },
> -	{ 134, 83 }, { 141, 93 }, { 144, 94 }, { 147, 96 }, { 148, 97 }, { 150, 102 },
> -	{ 151, 103 }, { 153, 104 }, { 156, 105 }, { 157, 107 }, { 163, 98 }, { 166, 112 },
> -	{ 172, 99 }, { 181, 101 }, { 184, 116 }, { 193, 40 }, { 193, 117 }, { 196, 108 },
> -	{ 203, 133 }, { 212, 120 }, { 213, 150 }, { 214, 121 }, { 215, 118 }, { 217, 109 },
> -	{ 220, 110 }, { 221, 111 }, { 222, 124 }, { 224, 131 }, { 225, 132 },
> +	{ 13, 86 }, { 15, 68 }, { 18, 122 }, { 19, 69 }, { 21, 158 }, { 23, 143 },
> +	{ 24, 126 }, { 26, 129 }, { 27, 144 }, { 28, 77 }, { 29, 78 }, { 30, 92 },
> +	{ 31, 159 }, { 32, 145 }, { 33, 115 }, { 34, 130 }, { 35, 146 }, { 36, 147 },
> +	{ 38, 113 }, { 39, 80 }, { 43, 148 }, { 47, 149 }, { 51, 79 }, { 53, 89 },
> +	{ 55, 81 }, { 59, 87 }, { 64, 90 }, { 65, 106 }, { 66, 142 }, { 67, 88 },
> +	{ 68, 151 }, { 71, 91 }, { 75, 152 }, { 79, 153 }, { 80, 125 }, { 81, 128 },
> +	{ 83, 154 }, { 84, 137 }, { 85, 155 }, { 87, 156 }, { 91, 157 }, { 92, 138 },
> +	{ 93, 139 }, { 94, 140 }, { 95, 141 }, { 113, 84 }, { 121, 73 }, { 123, 74 },
> +	{ 125, 75 }, { 129, 76 }, { 131, 82 }, { 134, 83 }, { 141, 93 }, { 144, 94 },
> +	{ 145, 95 }, { 147, 96 }, { 148, 97 }, { 150, 102 }, { 151, 103 }, { 153, 104 },
> +	{ 154, 100 }, { 156, 105 }, { 157, 107 }, { 163, 98 }, { 166, 112 }, { 172, 99 },
> +	{ 175, 114 }, { 181, 101 }, { 184, 116 }, { 193, 117 }, { 196, 108 }, { 203, 133 },
> +	{ 208, 134 }, { 212, 120 }, { 213, 150 }, { 214, 121 }, { 215, 118 }, { 217, 109 },
> +	{ 219, 119 }, { 220, 110 }, { 221, 111 }, { 222, 124 }, { 224, 131 }, { 225, 132 },
> +	{ 228, 135 }, { 230, 136 }, { 232, 162 },
>  };
>  
>  static const struct msm_pinctrl_soc_data x1e80100_pinctrl = {
> 
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240711-topic-x1e_pdc_tlmm-a6cd7a0f6cbd
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

