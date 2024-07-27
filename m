Return-Path: <linux-kernel+bounces-264084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6C93DEDE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212091F24032
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD218605BA;
	Sat, 27 Jul 2024 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khJd4ew+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2B5589B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077550; cv=none; b=fqUJ78tubWHr0U0miaEdXHWMRCreEImWc/BGrM1w9cF+slIZDHqCXYLhSGIPsfeW/H7Up7GLIaSDM1BM2Xt5cA2Lm7SC7lNAUeppseepbchLwjL192g+8Xku1XArAGLg8+MtBYhXoMTUcoH9zOGSdAeT7vI4tfwzEG7FUq5LpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077550; c=relaxed/simple;
	bh=Dq/S3mGmdRihp+JQyrTu5C6qBncgApK9D6D/aPhzwkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3JHz+9LKGndc9TtrEIIBQxppdEOpw0aeUdJlL0knOQ8k9JzIDd7SbSAtzyC/ESjSB+weOJ++mUBMiMH3BGOQkjozZDG2jQ7F2BB0771CQQcjSxtDriUEURBfKBcuww+W+F/lD+r+Ic/9w0KxCQF0Lc6iNPWfmPb9gWHOZW52HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khJd4ew+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04c29588so3530874e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077546; x=1722682346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M39AnRc/yLkaurruReHwFcUb7PkkGNUB51pOqOiOq28=;
        b=khJd4ew+Ba8EP6Qj69oPFBo3aWzx/NDEtIu8ZtjExdmwgv+LkbQaBsXo6S/1jD6F5I
         Absy27nB3L+VRLrCkOVPm7jn3x0veN/0f/fOM4YAhJkmd1saqotFk6L8mkS+1ND5QA7I
         RBVv96Th0fnI9VLyWc2cccRx5DdrhJhza8s9vWH7/AqZKkTtYh07IPqN1n3dx1aht+8k
         8X4qAalMadQrBNiwqBZm1BrLlzraN+y+94yoiPZuDITresXTouwhcEt+rPMvCWedF9/q
         WJBqkPIvHg2+eRzT9GBswUIcNsMaoXZ5vLhsur6jbod8PgRCuowRRRqa5Ewozc7zcjf/
         vJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077546; x=1722682346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M39AnRc/yLkaurruReHwFcUb7PkkGNUB51pOqOiOq28=;
        b=kfe0VIne3+ifb2UoHlP5lOhjctZw1kxBlnvZ6v6bkOfAzL31glSZE1mMUHSm1NbYI/
         AkCX1P1pQH4v3aOZT097bqcuKMgZmf7FB+T54ZfDWfBpqbcoYxDDyQy7fjzepw6cEG0E
         3z1SFqOJRjwyVYd9NrzOnPzqd9TmfpWUADykOQ4m9Qb5gG0uSzLpdwhbtakwSjruo8vp
         rR8tKpjVzAJaTZCSOyzta1QAnJkQ/GhEEYRZ5A/VNng78X2vKMowM+XBekqv31zNvT/g
         kvWomBtQIlzEYd04G7XMOwKCeKWxdCM72cs4SKCyKaDKE8XOthpLu1a76d9uHy2+mQhG
         2F6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiEnUWjhBsAGfAwECTLHMxUgvFRavD6KyhupauMxg4Tbkpwz8ot4xlPrS+Cw89jVr/HTjzyYQJ1bsTxEVGHBRxgMzCbpLWsRqTTMC5
X-Gm-Message-State: AOJu0Yz1mIWNLB7js0iQKJdq7wfr8Nml70sbH6Eefh57n7xH6jUghH14
	Cf+MqHarf7KQLZhAJuLCdP1U81Mb1fwYDHHN95UBb+tS5pk3zjaUqSc/2Bc7q4s=
X-Google-Smtp-Source: AGHT+IHEK+Ar+39CmHBEjPmZWaPhpcW/F/KwytZDZLq5IAKrn/S9+eIP36e2PYbbl90Ui4zs/Oh4GQ==
X-Received: by 2002:ac2:4c87:0:b0:52f:cea6:69db with SMTP id 2adb3069b0e04-5309b2ce8d1mr1305559e87.51.1722077546351;
        Sat, 27 Jul 2024 03:52:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bcfec0sm733378e87.64.2024.07.27.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:52:25 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:52:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4
 clocks freq table
Message-ID: <ezpxuw2eduh6i4lum2mb2627l7beoi6k4bchngustt6pyhuzmh@hpzfw3jiulud>
References: <20240725-gcc-sc8180x-fixes-v1-0-576a55fe4780@quicinc.com>
 <20240725-gcc-sc8180x-fixes-v1-4-576a55fe4780@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-gcc-sc8180x-fixes-v1-4-576a55fe4780@quicinc.com>

On Thu, Jul 25, 2024 at 05:03:14PM GMT, Satya Priya Kakitapalli wrote:
> Update the frequency tables of gcc_sdcc2_apps_clk and gcc_sdcc4_apps_clk
> as per the latest frequency plan.
> 
> Fixes: 4433594bbe5d ("clk: qcom: gcc: Add global clock controller driver for SC8180x")
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Fixes should come first in the series. Also consider following stable
kernel process. If possible, describe the reason for the changes.


> ---
>  drivers/clk/qcom/gcc-sc8180x.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
> index f9f3e1254ce1..e85e75792ac3 100644
> --- a/drivers/clk/qcom/gcc-sc8180x.c
> +++ b/drivers/clk/qcom/gcc-sc8180x.c
> @@ -974,7 +974,7 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>  	F(25000000, P_GPLL0_OUT_MAIN, 12, 1, 2),
>  	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
>  	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
> -	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
> +	F(202000000, P_GPLL9_OUT_MAIN, 4, 0, 0),
>  	{ }
>  };
>  
> @@ -997,9 +997,8 @@ static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
>  	F(400000, P_BI_TCXO, 12, 1, 4),
>  	F(9600000, P_BI_TCXO, 2, 0, 0),
>  	F(19200000, P_BI_TCXO, 1, 0, 0),
> -	F(37500000, P_GPLL0_OUT_MAIN, 16, 0, 0),
>  	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
> -	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
>  	{ }
>  };
>  
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

