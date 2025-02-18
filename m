Return-Path: <linux-kernel+bounces-519953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC35A3A3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116CF3AA7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEA26E14F;
	Tue, 18 Feb 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVNvjlRT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680526FA51
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899088; cv=none; b=k581EAe5E9b0DOd9Aads71GuW7G2kjWsa0LVN1e5/vp5Xjm0FYWX/wKt5JQk4yAIFM/93oAhp1sY+ljwRhM+hWtiHbmvctFO1AHylgv4XG0LLVfvNJWct/WOKNv1eurnbiF4BRantgNIBpEgSJgtbYpMKLsVBVzeHA52xWMTrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899088; c=relaxed/simple;
	bh=+HqbUx3NMhsdQmv5gJG5aY4LXcTPtScM4DxHwm+OZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJKTh/YxGo/PDfBCjql2pPw2EpN2lyDZIi5c1fwW8YBsK2bgIJCJ8ANCBStFiUUHOnvNdt5s876rZ5GOOMRldImcuMY2PAKY3c4KTZT1lLJ6u/sURjvXX6fbhmRhI6mNrwYvmkFw/CrtnUTH/IdSTFMl9cXOd2cnUV3MFoKE9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVNvjlRT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307325f2436so48833531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739899083; x=1740503883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFCpXaDjW046OAnqXzChWWxg9c6BmmKNGNdZCuQPouY=;
        b=EVNvjlRTUjkWqiPgbRWJw+S1FY9HkvT9IlDK2h1m0AJwDk16lysLtGRpnmF6DDGZ/u
         wA1eVgnaopeOtemJJSeb+neL4Xf+y63zfagZhIEiSEzYDwlXQiabOLHkJ5DQdR+vkglT
         RATECJW+hfCEci9yB+imfuLfJen7QC6TP2si8Vc86GA0FauTPr6rzMWaTw+hKJFkV+DA
         8x3PvFxtfec23ZKgOPtaRvQzj7gUXJgaXuFDdecqiowCO4AmkaUjfXPtYb8g+MCCbL4+
         LEtn6VylQrUhQc8Dg+BwO12JvMA/IiByyvbaNotBh+gTHGqHzgULgOqpRDYfaCqzfbsC
         YDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899083; x=1740503883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFCpXaDjW046OAnqXzChWWxg9c6BmmKNGNdZCuQPouY=;
        b=ALMhUgWJqUjeiVLf1UdAmZCU4i58kjEUZyH5HVP5fYgd9YTyW1+kOixggH+CKcDMLL
         VpKNpCkCtNTTjBG8L6Yszg8BTMzzc3kP9v2x5oUzUAWJ6jC1gFeLTN06woG5v1rCGS0D
         r0UibC5OKBw5M/v7Zr5f6AeI7pwOBAeNd+vB4LboP/rOTEVra8Pp0AkT+7NJkxIym2/W
         RtDPYrMOWAB0SKqaHulFol4jYbalqwTt9L+5fF87rK7W28XOGiBuB2n+IDumeeDz2X2b
         kMY82n+r77KHIUbxbdb077Sd6b+qDeNMzL8m1H7HGW+sQfMTRtMl3tddYwn57le/TpKG
         0qJg==
X-Forwarded-Encrypted: i=1; AJvYcCWZhqpI0wIsJkmkukT2qyvQ61rNcOY5n6ldAusiAqJVqhUiQUZNlHAdDkeQ0B5/8Kn7LSpS1wd2hgKXFdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzco1O8wzlINIphLYdDetghlIfLGyxEPCFYc7jDeuGiKuDeTelb
	sqgyN78FeB4upCESEygvu9ACzm6FaeAG7rNeVmQVAMbCdFh9egZo7feV77Fv8g+1oWlyAsq/vEw
	z
X-Gm-Gg: ASbGncutM34PoFaEnIHq0v83KQcRrprPjowAI0P05W8zO+q4oWj66+/g+mfAfsLbN/V
	tzQUYDKsUEqrDjcUp00rpp+J+9eqS+VyP/wOqkjGgdBKa8eHk5cTBloo62u1SiEPg7kMzuzNZpv
	KtupXOYOHAYpAR7LXnHrl1i/nFLwglcd5IFZRlrfK6VX9kGqb0h6+NYZZw0U+w1Kz6Iao4yFOuY
	vHk46V2LeLaFCv0gyhoKCll2PhZ5r6x+ogPV0cdP31Vb2hhRXmBCgPiaCbGq8FgiXJ0rVBSKmtH
	+XSPmNq9AK4X5cx2bPvl1gjqi5z//ml+jRxdChjsEORQloeAayRzaJtF6CKPYX5XwRIBcU0=
X-Google-Smtp-Source: AGHT+IE6rXImPRtO7WIVZArsGTCop6s7h35hJORLydABfahalgPYT5N99LSGxqzFHXrjk0jBaudiMg==
X-Received: by 2002:a05:651c:94:b0:309:1c03:d2d3 with SMTP id 38308e7fff4ca-30a45035a02mr559491fa.25.1739899083255;
        Tue, 18 Feb 2025 09:18:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309311777a8sm12756301fa.25.2025.02.18.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:18:02 -0800 (PST)
Date: Tue, 18 Feb 2025 19:18:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: common: Attach clock power domains
 conditionally
Message-ID: <2c5rbbpe5muw53oemyq6vhsmhzpzcpn7on4ujl5v7i7s3fdlob@eh37gy5dpfnp>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-3-cfe6289ea29b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-videocc-pll-multi-pd-voting-v1-3-cfe6289ea29b@quicinc.com>

On Tue, Feb 18, 2025 at 07:56:48PM +0530, Jagadeesh Kona wrote:
> Attach clock power domains in qcom_cc_really_probe() only
> if the clock controller has not already attached to them.

Squash this to the previous patch and call the new function. No need to
duplicate the code.

> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>  drivers/clk/qcom/common.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index ec27f70b24bdec24edd2f6b3df0d766fc1cdcbf0..eb7e2a56d1d135f839fd9bd470ba6231ce775a8c 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -300,9 +300,12 @@ int qcom_cc_really_probe(struct device *dev,
>  	if (!cc)
>  		return -ENOMEM;
>  
> -	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> -	if (ret < 0 && ret != -EEXIST)
> -		return ret;
> +	cc->pd_list = desc->pd_list;
> +	if (!cc->pd_list) {
> +		ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> +		if (ret < 0 && ret != -EEXIST)
> +			return ret;
> +	}
>  
>  	reset = &cc->reset;
>  	reset->rcdev.of_node = dev->of_node;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

