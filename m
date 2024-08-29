Return-Path: <linux-kernel+bounces-306174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D913963A33
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186261F20F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DB14B946;
	Thu, 29 Aug 2024 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnJ4LC15"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E113C8FF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911259; cv=none; b=gvH9h2gas8sDuU0glKlZQRYujCDEf5smTRuW19lpFQbLNRIMjVqudb4hgCglQFcPYF45S9Bv5dEkuU0VuB6P56i+b68x1voOJvz0ZFxz/RFy0mEP4MWrjIH9Z0p2clM6nyskzOIP3cP3zikAU71EoTSVEe+LAX23rvby+YHRLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911259; c=relaxed/simple;
	bh=rTa3XsXku6QK8O613kSE3+g/znl+3iIDxNm2YCFySyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGwl1t6W5w12V6prXCrliPgskjR3nLwIfdLPaVsdsN6+1rn0MsaxFwvq3h1PJUbwfUjZEDUGAXV/hrWM2uwIzsGGgnh76jedLudXBoByV0Y5Bl+XmjjCcSfBned35+Qc2wL/BY5xHzawVWfpO3WKMOhzQSKVlFw6pZUSRi7NyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnJ4LC15; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5343d2af735so229922e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724911256; x=1725516056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QCAhMrP/2Wo6lEwg2mhkvbMU/xvpL6c0No5lhHxznQ=;
        b=hnJ4LC1588xB7+EvWx302HOTOeB2OqEzW/6HbCj4JoWeoUIE0wnHWmIz6CjhDiu83X
         AwAgCge6LpfbS1UPjSOq9lvxX2Q4kSSqa4lURisCpRFaC8pTM0Fum2AxV5Y+WiOwQU5M
         OEpGmM5ylYw3T6xaS96ugxidf0ukltd7JgZWdC9NjB0OnF592pLIEhEDIliqHu27XebU
         VsinAxMWgA3aqgVYm62FTJzWOYqFkuyF6zXQmw6cWPtIVAGNTd2fAmtq6SfJPnWobRMu
         bIA6v7qAzTqILkamAzi1xFGTXbU9hsJJYmRU/VP6pUuVPniiMjuWRpTR8huAopDWORBY
         4qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911256; x=1725516056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QCAhMrP/2Wo6lEwg2mhkvbMU/xvpL6c0No5lhHxznQ=;
        b=OXET1Gvdg3l1dyVMK99vB6dBnf56dfNic0QOdRc1n5WKYNCrRErZ2b2j6FRKzZIv0I
         kisoiWjI1MTP/KA9ZMl1uzLUkFdEqLEEETGvlsBamkFCc7AIID8rAWDpeuJ6ZOABWO68
         bChJa5AupjZNidrkADu13VZArLoE0zPCTvyKNU9pL9vosbfCrR6TR60YLTUcGQjU+4cB
         rYcuv+nQ6l7LsW/jnHVv7IIktn5ehrmTauDbmLtAUmk33GkPGJbCRC9tA7Qy0ueyozWw
         E3Ll2CORt2LIO9lwtk5tRNRMzo2mGH6R+I6RCLJDYfmsAMwY1mI41bc/yW/pEFr+3YOj
         SUNw==
X-Forwarded-Encrypted: i=1; AJvYcCWqg2l2/Qm1RSGSAXdjH8TltIxo0Ng/XOBp46tvv03rsFFykG3RSUqZc4Id8arYjzPYM1/xjXEsyLq01ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fF8G/gaU0GNWlOPANqgq7Z4fLaA5+gsZ4xC+KJSwRZ9NlGAh
	zPJV9fp8vyPSMTYuS8x4sBAmw0IuEzHkobFzeuSzO+ZbsjFu16S+CbLanwkouKJQbRYT3m0ggNB
	+
X-Google-Smtp-Source: AGHT+IF/ev0myceQVG/fqJWa5DVy+JJpHZ5PG25+A295HmneGmTxlMtKNLzMBrVcMi3DRAaIvh3L+w==
X-Received: by 2002:a05:6512:1310:b0:51a:f689:b4df with SMTP id 2adb3069b0e04-5353e5aad11mr1066914e87.44.1724911255535;
        Wed, 28 Aug 2024 23:00:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084cbfesm57911e87.247.2024.08.28.23.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:00:55 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:00:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qcom: MAINTAINERS: add linux-msm IRC on OFTC
Message-ID: <cjn4iridgeqelq6titafgbf72c6qx2axsbedzdvdilqf45shgc@lnufja2y37f3>
References: <20240821102602.134216-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821102602.134216-1-krzysztof.kozlowski@linaro.org>

On Wed, Aug 21, 2024 at 12:26:02PM GMT, Krzysztof Kozlowski wrote:
> Qualcomm SoC community gathers in #linux-msm channel on OFTC, so mention
> it in the maintainer entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

