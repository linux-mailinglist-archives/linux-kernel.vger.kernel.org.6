Return-Path: <linux-kernel+bounces-522078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB72AA3C59D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB11768B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DF214225;
	Wed, 19 Feb 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqf0gLgC"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF421E8326
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984655; cv=none; b=Nvw3BKZEUSbxPwST9bpyo/lpYpvPlHT6G78LJ52cB25g1NdfvOn+GqhyAyxCe5M8IWXuQbA0M6LqNvlIUAOcgFBKY4DG210rOLi8fA2MyEDF5UNVdtlRnQSnTE8ev1114s1leYuyaC5RWlwH1tfzLdyeuO8G8w1dqbudANJCkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984655; c=relaxed/simple;
	bh=ZSlCHoccH1fd2TiMJkNz1beL9R2IY6D8yT+/UdOdbKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMMAY2sivFIZEXXnNoPJtpCiWsvKWxHM05S2xNKCDa8jJBhh0Zgml2AczJ+jDbsKWmPQ32IecyR4HZu03cSyjBddFAEokjeK0JkLUJKPq5ntV5mZsFLEW87VK4c46UYyCj/k1z76szQhZRA25TjvkAlgsY+W+odJufqWDy19/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqf0gLgC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c4350826so591966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739984652; x=1740589452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nS+re8IZzfg78cocQERJ5nCGG/g/BmDYdKGFLYilFLk=;
        b=qqf0gLgCFha3f3ExQ7ULIY/83BgVgOqu6dB36siK9OEZUhwB0NdOaEqhuPoHrH3UtV
         tj1Xav3TedRp9IlU0x9JADufvV3buKBVkWMVmvesuig4DOSrtXu90iJlgMvymyrGnNP0
         WC+CESLVhcz7BI9Bzt4UwG6s5iQaS04OuNL1VwcBMnYimIzgIT8SKJAwLuIXAVTGmfb7
         bISofjboxsjegqzTjUAAZiMFLv6wKWTAG85Uca2esEsewNoTLQM93005R+6DOVMooIGG
         LogMuYWn9tUk4h6j6AyelaEU2y0+lfQ2Pxc+VqC/+0LeJu+0Plwt5j1/H92PcqEyJZsH
         SMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984652; x=1740589452;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS+re8IZzfg78cocQERJ5nCGG/g/BmDYdKGFLYilFLk=;
        b=VfBLMSvF2WWyHcMW7WHfdKFu4M1xgLzyQKnm27yquMUAiSbK+3A/TvqMWmFl0gNApe
         EYfU46S/dzGRYoG1uB48pcFvkB9WL9n/OiRsx9DJMIpQ+cN3v83DPZqIHprKFnMuv7K2
         M1FdgfpVH0TRByhx9aVoNugaWmf/kPX9XxsILLGba/IiHntIWeZS7siXySpdOttpzBLk
         cC1WF674mamEZ6/u+atIhH5bCqjXqVm39BtFYwvS52Kfk7eGsuuUxvIxgQ8wEfyDOVcA
         88wcL7OQnY+ypPDobOWwwhj/HrlQ5uhNGM1yRlUIOP1i2mW+t1jJgbGoaAF9sKwLfmqj
         wzsg==
X-Forwarded-Encrypted: i=1; AJvYcCXt6fJzGEKcADTj7xncDiBDpgYI3OxhwO+rg4Bj+q617Zen/MkO9SHvi1DxtiIhGp6HnVqSU5YqD6+diN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1lJSIFUZF8Z08qyZ81P7RzkVwG6MtyQLJBuacAfYvxKyHyFV
	FvNKEk8yC0QuLXy8YLFBo5VhXXPpSa7bploteJPydd7cL0+0HVLdg7v6Zj5VTek=
X-Gm-Gg: ASbGncu4syb+SkoBm+3LtXR7TRa41t3vS6//U8w8ybCi6fvbiXQERJ5RjZxQuT3t3YB
	+L8zCdqRuepWJ8do2NxD+ybxZwwCBMtHLatrSioQfErf/+jtBl2rvFKrdyhAAR6ww1XFObUvcD6
	Yah7UC13f0WTvwyCOHffTiEvjzWfA6mGMBcREhmm/8Mzmu1xmUQqAo97DMpGzC65PAcq9WmxEsA
	yjjgcURPywiU2uR+ssAxfF1Zm20Hhb+iBiPlV6KpzYxkqVkfm+qbMIw2Fpyp73MVw2OkwsOfyu7
	UZjjTC+RlrQgns407uoMiMI3bZZUTfIplgY=
X-Google-Smtp-Source: AGHT+IHSBmAP86VSnxXjkgY3cMH8/9ybX2ae7f5N9URrzW7hspPUH+L+dLL7ObVqx/KKAuYObmZ2zg==
X-Received: by 2002:a17:907:7248:b0:ab6:6176:9dff with SMTP id a640c23a62f3a-abb7053d8e7mr780406166b.0.1739984652450;
        Wed, 19 Feb 2025 09:04:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm1299545566b.6.2025.02.19.09.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:04:11 -0800 (PST)
Message-ID: <4b2426d2-a7bb-4c19-9ebe-77f6a90caf5e@linaro.org>
Date: Wed, 19 Feb 2025 18:04:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: Implement new v12.0 DPU differences
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>
 <qlotuliwnm5spneolztca7avmh2a46pz2xqlxzqbw5kwa53m6q@oyhnzz7fhay3>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <qlotuliwnm5spneolztca7avmh2a46pz2xqlxzqbw5kwa53m6q@oyhnzz7fhay3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 20:18, Dmitry Baryshkov wrote:
> On Mon, Feb 17, 2025 at 05:41:36PM +0100, Krzysztof Kozlowski wrote:
>> Implement new features and differences coming in v12.0 of DPU present on
>> Qualcomm SM8750 SoC:
>> 1. 10-bit color alpha.
>> 2. New CTL_PIPE_ACTIVE and CTL_LAYER_ACTIVE registers for pipes and
>>    layer mixers.
>> 2. Several differences in LM registers (also changed offsets) for LM
>>    crossbar hardware changes.
> 
> I'd really prefer for this patch to be split into a logical chunks
> rather than "everything for 12.x"
everything 12.x is still logical chunk. I can split more, but without
guidance what is here logical chunk, will be tricky.

For example 10-bit color alpha looks like separate feature. But
remaining PIPE/LAYER active - not sure.

I can split them but I would not call such split necessarily logical.

Best regards,
Krzysztof

