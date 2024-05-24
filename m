Return-Path: <linux-kernel+bounces-188852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F58CE7CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD050B21359
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF912DD9E;
	Fri, 24 May 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsSgHFLT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560512C80F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564204; cv=none; b=KhZxxRQS+aVuMDvF56uk46kArFnAps7ln12C59xSI7fv9HpyOmUeAczMyl/WN5CUT+10KBZlO4a0GRh5U3TXXonhf6qVjwjQvSosIcccuCpPz1ZGvQ9ro0zo+VH/yx59BuwBTvCWJJR4JCr5hyYF2OR/b9m96/M0HgqEfY0slBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564204; c=relaxed/simple;
	bh=zXfqXpGWAQG4ZMLumxJ2Lnu86nfnso0TO3tH26EXC0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8yUyYralfkKzfDawrpmDVW7/K3m86pH5UdzO1o0mU/c6sPR9/03MYqVZBc/ivbv5KDKf1ZoR1QNPRO9Y0d1JsLLYOFdwqLnto+LdxhWWvLaE4YDsPI1EMZklqxoq2WDsMeyDLZcnffljcS7ZR7n4LwUY3ftFbi7M7OpEEnSmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RsSgHFLT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626ac4d299so104534366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716564200; x=1717169000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E/c/NoolbIiOnZjQKL5o7R7e5Dr0hpiTDegX3eduIqI=;
        b=RsSgHFLTW/YPBX976Eqs/65V2FMg/OHCSW1b0HntDIp7x3iwuNnisumt4nBT3MlL6Q
         WUWC1Kc5aMb5ePpRx8PMXfXerq3H7ojGnjn3KOz0Lc/v3opCyCghzsBRNlqWkRiVm1f1
         jdy0P8KdH9RWPBxhtRmdfgr1hiGxpbB8Zi/w6mPFjs8rEeLggIT+XTX8YUwWs/6eVKI9
         U7ocvD1bmeMznrKOct7vyoRbVJ1gTJVaawriGKOAnzignXGBSSXOUivceBWbcx3neF5I
         zpPO9vs3Qu7h24TcFTJHZJwJeNvJLiTF6Uchik1+5WPzoC+LLY2KeAU84H0NUVhLgsNP
         OGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564200; x=1717169000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/c/NoolbIiOnZjQKL5o7R7e5Dr0hpiTDegX3eduIqI=;
        b=O2qXT7w74jPArMOb7pJ+QPibegyRQzk9/95HQisEPG0UipIeHVHimXsSt/+r8FO0k9
         BBtwiueCUT4OPyIVOjjGh0N7fiLV9bcNaT98fJTbxcz5RfOfz6qe4ra4JA5m1HTr7fRC
         Easy0VmlsV6xOYErjP8c+3StG0M55GR5VM4TMkJjCq4BGnUFShY3GSlNM8NfC+0i/qnZ
         HwnbXtdIMmPXzUpYB+hovZChPHVI6OI8SG/NTOKoAoh3552/dHMqsrCxvq+Zgo0sXMWH
         sXsbu/6U9WiTYti39Y6DO9O09EarxZcCsR7mdqgdncoy93iL2Z6kuaWc0QG5muzI50DJ
         X0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXKmwHbDAZN617By6tobDdqXijJkHsXkeXyaM+oz8DS4XRxIJJ2mZRizTqdzjanm7BL4nomHJb0k6/lcLenS+XqwiABWVQhEFlhepkR
X-Gm-Message-State: AOJu0Yzno4WnjkDSkL+fDGW7Wr76skE9NATVY3s9u9ca3eDRi+XlvX3S
	WDeKRfNPRpd2dgbH/AQAqui4qfKaH8WbmMS+FIuo57Y8JJ+XnmlMdXa/13aEo5g=
X-Google-Smtp-Source: AGHT+IFTqRrx8FfSzxDfEsdShFcGX5aT/Vp4VnWyDG8+xgLaROCOzEXthZc1kR4w42R6OaXYXME9fA==
X-Received: by 2002:a17:906:3e0c:b0:a59:aae5:5840 with SMTP id a640c23a62f3a-a62651140b6mr180008966b.75.1716564200163;
        Fri, 24 May 2024 08:23:20 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c8181cesm147711666b.14.2024.05.24.08.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:23:19 -0700 (PDT)
Message-ID: <5cb66bd3-2a41-4698-8f2f-9eaf76cb06e9@linaro.org>
Date: Fri, 24 May 2024 17:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: drop duplicate drm formats from wb2_formats
 arrays
To: Junhao Xie <bigfoot@classfun.cn>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Ryan McCann <quic_rmccann@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240524150128.1878297-2-bigfoot@classfun.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240524150128.1878297-2-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.05.2024 5:01 PM, Junhao Xie wrote:
> There are duplicate items in wb2_formats_rgb and wb2_formats_rgb_yuv,
> which cause weston assertions failed.
> 
> weston: libweston/drm-formats.c:131: weston_drm_format_array_add_format:
> Assertion `!weston_drm_format_array_find_format(formats, format)' failed.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

