Return-Path: <linux-kernel+bounces-289608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6795481F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFA01C21CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D41AAE3B;
	Fri, 16 Aug 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GunVUYqC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339A54BD4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808065; cv=none; b=qiLfy12PTPY7IH98AtDhC+2pyuxkcpyKqPCnpJHwc/j9mcW80eIk3gBgQm1Nbvwhe/15u8Tn8PfMqLhHXCGpje2itsUSZOKCyn+ADW+jhhODvummIw/VcL5NhXbm7lMuWTaoIElB0AyJ+V3zVmy0B2dykQM5g6eDYC89YgdOnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808065; c=relaxed/simple;
	bh=6R50P25VUglNb6oXZN4lyDG1RygKx2LfyxopQiWqb7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDGwMgWOVzUnc5aAAbNMKSlhK60auvlz55g8OyANLOYFByJuwUmcHkR6nUEhyjzJD0njUh7FDP9B+REayt4Du9e+rpnB+Rb43iYlP/Nhsm+fc2Loh/GV4U2fiVcaLa7FCltj0xWkAWT0VS7fejyDB0pM7obadLl4jiRV+LzwUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GunVUYqC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42816ca797fso13670435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723808062; x=1724412862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFzZNe7OfgMfItNDQGhaTWGUwq1aQam/TzneCKR2kpI=;
        b=GunVUYqCjNFy2O6UC5W3NC0YVF9L0W4156eszaYm52HeorFYQpwQ0WQq3hAflF1UL1
         X+zAX2VY8Jp87RBy4KucXW3xE6a9Xr+wZBeWjVlRmkVswG6TN5TkQVOCTNwBuYVGWscR
         jb6RESLB40XOoSjvA2qVhs8ypTgBdVOvqJ4it7+dePbHl0mU/1wm8eL9sXNF/vhBA3kh
         LKKUC/Ay5WoiF9+heBMAiO7DK8bqqF9n/aloBzWvcarYE+VzG+4Ppny8epvFHZx3pSvu
         qz/eKMZB1NK1rcnTjr9MkuDtC9iTIMxfJB5d+x+ocufmMrOsdvT3HxYeyxhBOLyyitYF
         KpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808062; x=1724412862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFzZNe7OfgMfItNDQGhaTWGUwq1aQam/TzneCKR2kpI=;
        b=rYQt8wJ8th+F/SLiMIIgw3YRa7uMYDb/GGNd1+XEu0yL7hLa9O6K8A+OYYXUDwZ0jB
         lMtZAGYa9mj3M8WAnLyThWvNhuHFLvOvc1jxDwWvR2KkCzgNe/kprGOrC9OGkrqFRDnn
         2TAKmNR9PXHEmFGsd1AC+2uhCqgECyFnDTMnFtCnF7epmd4vjyA9Zw01mewhBDn+cDOw
         sJIiG9WheDVYaAtvoiOsrKggbOzxUStEiU8DEebcZTQRg08ZCBFsEjsdd5AT8ApJDB+J
         zOQ8Szt6JmFq2kb4TPAscGkrHJuz+78j/JoVhjCm1TaUuSMm7O9kmuPlP9YeTC6f+uan
         53Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXvrOKmqWKagfpamtZLKbf4b6Vlafzxryrsl+447vQLUMxHjdFzgUi+AvJ4hSlSzccXnwYgl+6NjCpxQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecfHUwCfhVNT3lwUmoEmd729ML9krE/dpOVX4MKiG3g05M4fR
	AwKSGlc76lmu99/knZsQfUMU04TeBYyct2z2SDa35qiheH2cSHzsro3WsaVdzC8=
X-Google-Smtp-Source: AGHT+IGPR3fLSe1jPOcXZeD3IwyAqLhaj+Dpm02AIv35ZOc+p+G7vfooX3dSt+28S0R/vGn/23MHiA==
X-Received: by 2002:a05:6000:1112:b0:368:714e:5a5e with SMTP id ffacd0b85a97d-3719431764cmr1940797f8f.2.1723808061661;
        Fri, 16 Aug 2024 04:34:21 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b8ae2sm3469287f8f.113.2024.08.16.04.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:34:21 -0700 (PDT)
Message-ID: <9c254643-2d95-43c5-98c5-cc6f2866213b@linaro.org>
Date: Fri, 16 Aug 2024 12:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] media: qcom: camss: Add CSID Gen3 support for
 sm8550
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-13-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240812144131.369378-13-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 15:41, Depeng Shao wrote:
> +
> +static void csid_configure_stream(struct csid_device *csid, u8 enable)
> +{
> +	u8 i;
> +
> +	/* Loop through all enabled VCs and configure stream for each */
> +	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
> +		if (csid->phy.en_vc & BIT(i)) {
> +			__csid_configure_top(csid);
> +			__csid_configure_rdi_stream(csid, enable, i);
> +			__csid_configure_rx(csid, &csid->phy, i);
> +			__csid_ctrl_rdi(csid, enable, i);
> +		}
> +}

Just noticed this too.

You're configuring the CSID routing here for each enabled VC but, you 
should only do that once @ the top level

->


	__csid_configure_top(csid);

	/* Loop through all enabled VCs and configure stream for each */
	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
		if (csid->phy.en_vc & BIT(i)) {
			__csid_configure_rdi_stream(csid, enable, i);
			__csid_configure_rx(csid, &csid->phy, i);
			__csid_ctrl_rdi(csid, enable, i);
		}

---
bod

