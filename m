Return-Path: <linux-kernel+bounces-525620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8728A3F259
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C208216C32F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7B20767F;
	Fri, 21 Feb 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLbpB5Bt"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BD2066F4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134607; cv=none; b=YVukBIYy5RgNic/wSuAaLZYzH5QL230KOecjOHXYCZlLtJIvrmlCAAmyxhqCe9iS9z6gwAJSWJLyBQl/s9fDbdc7y16kFGIuQLQbvBgX7hWhP2QaSim4gcPTLZBQCNBdxfCi6v2nd8coeRV1pQgd4tHDx6OElpnbvkYB+LIq6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134607; c=relaxed/simple;
	bh=inTo0+7VB9UT27tkyLLmc7uDsc/wf0E/vQHnSjcYBGw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hUJDJnA7bIRGTMdhEiYz+9b32926hdCqM9WOA4CPsGOT8hkEwWYOeztbVvLDfgXGPk7btK2UDXAI0zX3knSlrOz6LU9VNQwgjpeOWdTCy4bi+soCXFr3pLZ3cqCsk8W0CJQ6U1TQm1FM5oCO0z/yI9ZlTqI1y2Z0vl2SZjy32to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLbpB5Bt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb4944fa73so26983866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740134602; x=1740739402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W9nDvBHgnq2Y1NVf5ENVQRjZ2yktIiYk3KFxT6GMAUs=;
        b=bLbpB5BtfDcVYUdDuWfiHBbP/A0k4XUTxn6VpIHBw0IRd4VM2ziogFEQSjca+zG5Ph
         PapKC8d5TMy0cdraLJxv4qm89ZUNTrPnhqGQLX6eE3CQbBC2kf3F7O7Fm9IMeT7Q2Zdz
         PBvfjtrn9kKtwbLMCzrituhQN/9yzqOjIMvPblFYUauOaZNTd6HXgc7wOMApbR3VUswU
         lYxBE3AjxO2foItmfaZrLvwzpPrzdgmRLko55pWUPoe69BF17/IttC920g0oUFPlmIOI
         ovs5dyS/yMtvwFLMRBYQ3EGHYEfLt48S8qkgP4I5N5niYhst0gJORIy1ub/0K706kdyk
         v1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134602; x=1740739402;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9nDvBHgnq2Y1NVf5ENVQRjZ2yktIiYk3KFxT6GMAUs=;
        b=Z+7mITu1VWhMFZKLF0GY/cv1mvWPHPGNlJkc2esJR5w3kT1dPYRSyx71c9QDrsYuMY
         h2pZHwsQ3eDJ8e6LvdxboRVNEYRXpuCYlCfe4Gh6Zbtxmg1jgtvziF5bKjnOaUhJnRpa
         insgZLh9Cr4vxY1+Vt6+BRZmaOPX6isAo2JshQ/TAY+XSz3Hk1+2ZmSH9b4khAwwrgMg
         QNVZu2X8jKtouFLtdsIhTwvdJOmEWXj3uI3F37mdBLEZAuL6RpbY5SoIZgm/WuBL+p/v
         QVv26DHNki/XUH0hcfFjU/GByFYkp6JZJGZRi4H9GJjWN9pQ1BwyRocF6b74SfyWfixZ
         lsmA==
X-Forwarded-Encrypted: i=1; AJvYcCWFS6risL1nXfJwH9QOlBu/f+WlUXF1nzXNTduICTAkxwSkh4n1gb/ZrqzeULWfGf9x8e4b5X6kUlPVzIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMqIsTJPEP2bBOyvTigPZkeyekqmwV/PYzp+Ge6+3cg1eknB0
	k04K0NxnoIX65QxaKOjmzfj0+buebGs0ATcyOyPq4QTrizhCvli27+TGZl6+46Q=
X-Gm-Gg: ASbGncspg89fv/cbf/JrBVJxVAITH5E8l5vz7mo0S+RNicZb4HYJIyN9SR5q1vJ9+MD
	YWtURf+nXTVdPZU/d/qbIC59rXaH8Tpy+rqn+nEgmLSaUuugZA7MbwxBh3MxCVSGJZlH/sERaxZ
	s2y2tgI2ZHhg/yX4zF+/P0fMss7+ct169mUnTFtGzUUC5pSm6SiQdemmv+9l5EL+9UmG0kPR/I8
	fMZLJmLVDcdB8YsjNXOX6tMLbEWz5M+hgNpfTB9QBgzlOkiEKoJyiqbM/l64XypmNCCioKn42H+
	cEttQHDG6SM8Nyqh2vNTYx0OcatYq4DPZS3pBarjQFeoBabJwvMFQm2+oDc9Tme2qEtXbSbLaHQ
	oWE7K
X-Google-Smtp-Source: AGHT+IFJ61t1Ztkvz7Fj0diXrn9EhDeYjqCaFDp2KZ4iJ3snoJlNHALHHuaGmotnRpz7Yh9bL0nhQQ==
X-Received: by 2002:a17:906:4fd0:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-abc09e5e43emr101017566b.13.1740134602287;
        Fri, 21 Feb 2025 02:43:22 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb925bbb1fsm1023439666b.70.2025.02.21.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:43:21 -0800 (PST)
Message-ID: <15edc720-1fc3-46a4-b7b2-a3b2217109d4@linaro.org>
Date: Fri, 21 Feb 2025 11:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] drm/msm/dsi/phy: Add support for SM8750
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <30b29961-881d-48a6-8688-cb520363b50f@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <30b29961-881d-48a6-8688-cb520363b50f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 11:41, Krzysztof Kozlowski wrote:
> On 20/02/2025 01:50, Jessica Zhang wrote:
>>>   
>>> -	if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
>>> +	if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2) ||
>>> +	    (pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V7_0)) {
>>>   		if (pll->vco_current_rate < 1557000000ULL)
>>>   			vco_config_1 = 0x08;
>>>   		else
>>> @@ -624,6 +648,7 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
>>>   static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
>>>   {
>>>   	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(phy->vco_hw);
>>> +	void __iomem *base = phy->base;
>>
>> Hi Krzysztof,
>>
>> I see that this line was only previously removed in a patch that was in 
>> an older revision of your PHY_CMN_CLK_CFG[01] improvements series 
>> ("drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk 
>> source").
>>
>> Did you mean for this patch/series to be dependent on that patch? If so, 
>> can you make a note of that in the cover letter?
> 
> I indeed rebased on top of my previous set, assuming it will get merged
> faster. I will mention this in cover letter.


Ha, not anymore, that "PHY_CMN_CLK_CFG[01]" pieces were already merged
to drm/msm.

Best regards,
Krzysztof

