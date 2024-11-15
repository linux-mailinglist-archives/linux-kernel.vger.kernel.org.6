Return-Path: <linux-kernel+bounces-410958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C529CF0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24E31F284C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDA1D5AC3;
	Fri, 15 Nov 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQCE61+C"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3C1BF37
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686413; cv=none; b=O/OT7BVyt93sPLMzx0HawbMwhnISplPdsqpKAwCT/pixI/u7T2oaYeYxM0V30lkgJeI+3gT5JASaXt5MIDk5sSzXrv2kwZDr20R9oFj5DRxMrQpGNKZxJD5e40gfZQJaCNailtVL+zbFVx0q0UJfvKOGmM+pSguJq1a6+C369Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686413; c=relaxed/simple;
	bh=EuU3FL+szVJHLV4tZSKxX7MKhBx3f3MWhDCsqgir82I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtAw2tICysuVFrU/cvaFSOA6KL9GI09U2oyOXIHZxJjHj9mpkik7xnhbHSth48yusUsePBELzY0uxfK1WoCQmpwcetPoziETukbmVq6fkHKzTGsqXDJl6gJWYoQIT6DSe5u2dzvI5ujGFVWyd4hljKSIH3r1Jh0x41JvqhqO8F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQCE61+C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f1292a9bso2328430e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731686410; x=1732291210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaLAKrQweplwqb8UavNOcgrYMHAr/FPGjJ6BisEpYTI=;
        b=qQCE61+CIVzMJAx90evYXVz2LQw8ezf2wHn6ruJIRwAPLsJSZP1EfaPqnPiqB1iZst
         aQg+S0HimXjlU6WDU4bmIblIF+ijTd9v4h1DZJBgtc0Z6IcIr5ihiBMN1+q47DlJY7ul
         iyxEzXNubtrf7Cf9m16zxYqtzcQblzGaR8lhPOk67t3vJQSHwLMwPJ1xt23nBHHEpILD
         6rFicYGT5SfxcSYa3PwTV4L/QYI9XwpKbVFDIyofWVOovwqYTR7eVBSmH2Nalo7RvK0D
         jYIh0Te38rRI3wey/KgFjEWbSs+jxm5g1nAJP1w9WO3tYWA2KLDEsWChjgI+MZCsPuLO
         BnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686410; x=1732291210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaLAKrQweplwqb8UavNOcgrYMHAr/FPGjJ6BisEpYTI=;
        b=jRjJpenJg8utpgvK0APxwSbcUYDmUAHmt89xhfKC0DPy+02LI2T3ik6o7fhO7N8T5t
         rKbGZWXwChATGnGceZtU0vDZTcfpZJifQ+J8xseI1kj9Kld/AtctBk2LL+YAiWQNwzb+
         AycYL3zxMFBz0Fct3wY9d2xoZKL+vEDabRucyTTtDRwZOh0XqeniIo61d3FpcXHIEtgi
         ASUvTS7O00h/IcS2sM9TvF+S368zBFgdQ5xRfO0rZRuUoIlSaSc+Tphm/uXkUsZ2tp8R
         YmrstfvrwjWDz7ytFmZPVyV0UmpCxg/IPJRtb8zvFDAXWv+LCrEwH6WjrcYPDU5aZFxI
         /W4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWqRK31p5mgjmv/y/HPr0ej+mXEcDgcff9+18kqbwVihH8J0ODvClc8CuXdeCSKkXKaLJNdN4F+Qi+8dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRgHoT8kw6Z1KUH/9CnzvN9omj4Su3wffePy1IOaV1YfBOZgh
	HNiG3gDVh2oD4s2MOo98kdDfA54rClc0lBTTxi/0j3cBo2BZf3mfkbEmq0mvmDM=
X-Google-Smtp-Source: AGHT+IHzBxQ6sjTh9N3GvFMNODCImPz+3AydoFwjZjWQMctmEJdU/TK280ahRieoU3Ew0RU+LJLeoA==
X-Received: by 2002:a05:6512:3b82:b0:539:a353:279c with SMTP id 2adb3069b0e04-53dab2a7044mr1720075e87.28.1731686410231;
        Fri, 15 Nov 2024 08:00:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f8cafsm609701e87.54.2024.11.15.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:08 -0800 (PST)
Date: Fri, 15 Nov 2024 18:00:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] soc: qcom: socinfo: add QCS9075 SoC ID
Message-ID: <c4i7fashqxyenkkywjx5k7hteznqv65cgn7o4v6xls7gvrahrf@buyzke62vzo2>
References: <20241110145339.3635437-1-quic_wasimn@quicinc.com>
 <20241110145339.3635437-3-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110145339.3635437-3-quic_wasimn@quicinc.com>

On Sun, Nov 10, 2024 at 08:23:36PM +0530, Wasim Nazir wrote:
> Update soc_id table for the Qualcomm QCS9075 SoC
> to represent qcs9075 machine.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---
>  drivers/soc/qcom/socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 805dc3c4de40..a473d85bc033 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -451,6 +451,7 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(QCS9100) },
>  	{ qcom_board_id(QCS8300) },
>  	{ qcom_board_id(QCS8275) },
> +	{ qcom_board_id(QCS9075) },
>  	{ qcom_board_id(QCS615) },

I think we should sort this array in a sensible way.

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  };
> 
> --
> 2.47.0
> 

-- 
With best wishes
Dmitry

