Return-Path: <linux-kernel+bounces-525616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA929A3F24C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BF819C29D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103C206F1F;
	Fri, 21 Feb 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF6LzoJJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F488205E18
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134486; cv=none; b=Z7zxf/zeunnGcc+32vizsnzZQMCP+3AVizc56B8n6NubKbmNvtkhlZXEqRAqmAbLFScgvU4EH2Ewl2voalsADvAfUCuJ+GfFGXsSfaKqn/8/vh+W+YJdtps2IqY0N4rZ8xLKYyjnBz1/CgS0p+G+HVjVIzzGvNeybAE+rEo0/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134486; c=relaxed/simple;
	bh=HRGKp4PTcrfPhEDDYVhwA4A3grCZV4+hHImd0KjhF88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVNnK4uU3VY8vXK3kjMvyV6T7fr1RUPjXzDeLA6n5acevBUdeRiJiBMnbzEdZ4saG6bm0Av8UsADG3QH+0rPwcmjzDvFbDjJSludxC8lJY6Owfa6p5vr8bm2phy2hcm74Wv/ZI/NsG+pwpfd3RuRo3nxaZa+xMMbAK3drIVtJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eF6LzoJJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abad214f9c9so32623366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740134483; x=1740739283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IbPTL2MRvkhMm18G18+076KXTh1mOsNcC8FEdn2M8XY=;
        b=eF6LzoJJ5ZhW/HN15VsXaQSoSMAocPmZACHU7GQSqI/crvmw3J3tNSWmEOLUQP1okv
         Xx0bWAOxdjix7Q0UbSY3J01c42R8Oli3fPF+1067eLlQ5wwJ9pxlJF6CsNQEafIN3o0u
         X7DbAD2qOcb/Qm9w/A4wnNqBIWV+9uiYQv9Yb7/RJj/aOYAJBpAjOKNF3qsN6A6cKb0F
         7re65jD5HwdCiX49uFozmumUktqtvIvb2HEDM0dn4VK/FSPMKbp+whEX+Av5B55hcOP7
         tjkplcBPRljUs+T8oCgFa9QBQBH+SSip8HrTvqxgxdvMgolWZAEHpZ+t5yAhx/qyMPKu
         Vt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134483; x=1740739283;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbPTL2MRvkhMm18G18+076KXTh1mOsNcC8FEdn2M8XY=;
        b=NNMP7LKH8nurv+WwlTZXpdrbKMVHRn+Jin7w5SNIOy424DEOmLA/0clr0+3sr6OGOs
         JW/h8XEaTwhNFulvgPciwQQmpuzVL91v8R/Yh4h2wf+s+jaK2zhglGUXiUuX6rw/B0QW
         i83St4cxhXr7AOUSaxtLd3isVI0rf4xPje2b7wl6m6ViWQpOvYII9BUXk6YarzK7wShL
         37QgleiYMwgYWXifmo/jB+1P+TEfuYV8GpTel6n5Bujo5R2PupsXfgIZVoNRXppGjcrs
         wVX3DAah9U7yrGyTi/Vji7CAdUfTzF/VHHV7iYkCDLvACB+is+gWby3KAEzHVn6h89Ut
         4T9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqGTps2EiCphvLMsKUw81Scl7qBmtCrIsBQFIWOh/imz9f/VgMhotz1yRmV7YBv5zf2tPr3y3vMQCJ75Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFowm5Hss+WXpMRAQYPKbfDokzO08PeY3bZ3lrsP+oboJX+F2
	mAjVgoz68xJsJCzhiehfTDtVr+l6HU7zDk9C91IAjZsy19VDL9vWs4DhdsrOBho=
X-Gm-Gg: ASbGncsfzguPoaJ6ZYFcM0rpTSVjSMgNZ1KZnXIVTd4jVbo1IQO/I3Ym6zYeYxVwLu/
	sWpJOHZcscsHHNy98dIjZqJ6rsJPyyGfm23jmzlQCOus/ChOeFXIRCsn5r3KxP/h12g8Kqc/vxb
	ydjwg/OtuTTxiWjkfW7R0gu2hRR5JfkOe8AEZ2OF6aCPpH2K6oe5+/V6eAezpIo7665cuU5RYdZ
	AXusl4n5LJxd+Lb+S/dbVcVnDyxde888igrtRFbjhmlAs5ai5XVVbnJKn3qd3XA80KnyFKKutQs
	OnY3W4HrVBN7K0MHAvdMcQ5fAonGUwHKFoDLJcap8vXhls+KiPJcStQaZ7GkWWa7qZ1+Ibzyb1F
	AZs26
X-Google-Smtp-Source: AGHT+IEuJ8iuesNChPDrriNaIn7Vco3g4VAXYe7aSMcR8uOugRPzUwuC3ibURMIqMQmOaMTN70ZN7Q==
X-Received: by 2002:a17:907:86ab:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-abc099c1e93mr98976266b.3.1740134483371;
        Fri, 21 Feb 2025 02:41:23 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb77551c60sm1223095866b.63.2025.02.21.02.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:41:22 -0800 (PST)
Message-ID: <30b29961-881d-48a6-8688-cb520363b50f@linaro.org>
Date: Fri, 21 Feb 2025 11:41:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] drm/msm/dsi/phy: Add support for SM8750
To: Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-11-d201dcdda6a4@linaro.org>
 <e5b6b5cc-2afb-411d-903e-152a6a617d53@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e5b6b5cc-2afb-411d-903e-152a6a617d53@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2025 01:50, Jessica Zhang wrote:
>>   
>> -	if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
>> +	if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2) ||
>> +	    (pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V7_0)) {
>>   		if (pll->vco_current_rate < 1557000000ULL)
>>   			vco_config_1 = 0x08;
>>   		else
>> @@ -624,6 +648,7 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
>>   static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
>>   {
>>   	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(phy->vco_hw);
>> +	void __iomem *base = phy->base;
> 
> Hi Krzysztof,
> 
> I see that this line was only previously removed in a patch that was in 
> an older revision of your PHY_CMN_CLK_CFG[01] improvements series 
> ("drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk 
> source").
> 
> Did you mean for this patch/series to be dependent on that patch? If so, 
> can you make a note of that in the cover letter?

I indeed rebased on top of my previous set, assuming it will get merged
faster. I will mention this in cover letter.

Best regards,
Krzysztof

