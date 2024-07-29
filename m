Return-Path: <linux-kernel+bounces-266477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EB940070
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E821F22A42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EF18D4C4;
	Mon, 29 Jul 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLWmfrOD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0018E75C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288606; cv=none; b=hGBav69tiWXwJjxUhqh/RUl5HQ+Mgl7IAPfSYhb0rUBpDh/0dTOOTEiJoqm7XXS1x5ONirLjsrvNPwYcgjq+8/yeUgAV7Kyb7rP7rREMTxgIK1XLsFJZrW7qipfUwanIUwcBXkUN9Cpsku+ynf9toiqYwypWRR0sJo+T/A7aQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288606; c=relaxed/simple;
	bh=g/WJVRftOQU+p5sUv/q6VS/YTP00ki2GYTNMRQkeiXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHPh9fc+NbCPGOg3/nqEeEj0psKrnQ0gqkcvQlg56ACq4iu40Joki49+gfXmZQWwU6I5frneP0UKli+ZCTuDkn9lD0Ak3Pw5s2VgG21+oJMzP47MMF1aDTMtmgnnO8ikaweoYJkhpKrg9V/GPGMHBF+APrAG/+edCbY9CF13Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLWmfrOD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01b8738dso3983491e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722288602; x=1722893402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEtdATLoAu0WQzNF8Gz28caMWwGb1q0CyaodS5o89po=;
        b=YLWmfrODQuTZ6sPBEHjjwMM1FUg0TTYSOK68Li0YiVqUu42/RuEI9gVyqEaiLvvx6e
         xAbEygTGbZxeaniVECvTBiX/Jf6fE5/nPRctWAjVrZD5FgJwaxArUHwtSVCd/pqUVqCC
         XDsQv9eleLpC2igRG0MzRkYmXIpwv6NmyHImAiZlVbaJz5tajy83UViH2Jd7NYrg4ZzB
         0gS9XjXwoHOzUg65//N3sQumhGBbmQj2BqXp4M/JxbX+zOEEE4uXN1taT32wVXArqc+g
         WK5NsNMOwX1wdd1aJS7yK/q+zxwPzWUYHBezPp9i0Xl6BMT4J1L7Ck6ljq0JW2FGeFk/
         tkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288602; x=1722893402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEtdATLoAu0WQzNF8Gz28caMWwGb1q0CyaodS5o89po=;
        b=hc/bX9E/Uot+4cc3vRGEZASPkdM4YcDos5MAOAfCHLmj1J5L4JKygMOMfDJh5fSw3m
         //1KH1UMz2rDq3SFn6Jz0RoQ/Wl7mKKm6dQ1zjyaEGi1S8pVzgCBTcJupfOslI/T6nPd
         aZ5ZDCeRaBS22whirt6jYefxl8JRVS70O02OUdme/IcoWuyVg9C8HPEpaKjzuSgesyZX
         NKsSteu0V6EEH5rnWXt/mEETQ3G4ppbVUSajbrvYmRKUEx5pxqVgI4RO0PFbO70izzpI
         oGq+YC3gIcQar1cVPAXyuPWaPqyWkP8ogdeU5FQvcKRytDv78j9BnTM+ceoRFGIeejYm
         x81w==
X-Forwarded-Encrypted: i=1; AJvYcCVq7+CrV+X8zppIS3iunFiGIGtUQqMR9U5fAPqjLoGwAt0JclnUtkqoJOcpYa/cZaET/UabLhTMXSbFfxFs1qbnj/KRYiWIvqCQQ4Mi
X-Gm-Message-State: AOJu0YyXrbVdROCNYjpcAcyy1r3rqBOuajzgOBQgwrKD39agaOPHpNM0
	TOy+UYF4kpv2KyiMT1IX00BSfL9GT8XoLfjS66RnLooAqRykFngfvXrGYxlrDGk=
X-Google-Smtp-Source: AGHT+IFPvmk1OwviBwRVVszZXvlS0BNlYTjVmbK6wi42PM0zXUgltu3j3dtvA+jjWTedypHUKKE+bg==
X-Received: by 2002:ac2:4bcc:0:b0:530:aa3e:f397 with SMTP id 2adb3069b0e04-530aa3ef480mr117816e87.43.1722288602194;
        Mon, 29 Jul 2024 14:30:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0bb5sm1641116e87.76.2024.07.29.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:30:01 -0700 (PDT)
Date: Tue, 30 Jul 2024 00:30:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com, sudeep.holla@arm.com, 
	quic_rjendra@quicinc.com, andre.przywara@arm.com, ulf.hansson@linaro.org, 
	davidwronek@gmail.com, neil.armstrong@linaro.org, heiko.stuebner@cherry.de, 
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org, 
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com, quic_kriskura@quicinc.com, 
	lpieralisi@kernel.org, fekz115@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH 04/11] soc: qcom: pd_mapper: Add SM7325 compatible
Message-ID: <s7mgtc2llbn4daw3culapxfe6bbwcc7r2rla7obu2ts2q3jkqp@fpvqyvjqzkpk>
References: <20240729201843.142918-1-danila@jiaxyga.com>
 <20240729201843.142918-5-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-5-danila@jiaxyga.com>

On Mon, Jul 29, 2024 at 11:18:11PM GMT, Danila Tikhonov wrote:
> The Qualcomm SM7325 platform is identical to SC7280, so add
> compatibility leading to SC7280.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

