Return-Path: <linux-kernel+bounces-171846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617F8BE967
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD5292B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8316E890;
	Tue,  7 May 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sG4H8R4A"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEA16DEC5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099736; cv=none; b=eVnK3k5KYLIOmuKgQuRnATffIQBcWVXcoJaXin+UcNspWl/ev5Z5jo43vY3PZ3Y5wkL91YUvShSMGAihGITjscKU11giphYzd7fN1+C0qZVILFXPjQAaOP6d6bhLoaAjf8ec7b+GJp9rp/ODRDRRu0/dj687U2ssLDrwQITLe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099736; c=relaxed/simple;
	bh=gonHCVTy2VNCz0Bst2JtnmVy2kVq/TO+ccZqwiI8jic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTpuNuu0AwxKcteU2SvrRV0gAB82i7JFwJ5EBq/4o5VRSyGmB+PkCf0+V9C21A9ylvkV1o+aacrY7QaNmY3vyfqTAn/mwyWj8EjvuszvsrotCvRTNJALnNiQKxB21uj1ka6kLkPaoJdID5cmw2U56ftu/x4BttFwRsttSf62Zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sG4H8R4A; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f40b5e059so4167462e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715099733; x=1715704533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0wxpXSgV2vu9Cg8Y1DENV2ZH05CDCilqjIzS6gLOhXA=;
        b=sG4H8R4AFZ1L9CFe1oOdII1gp5ZNcHJvDd/HWwVChZrJEvhFrL0IBn1f0EkLj4ZKfl
         p5S1+Zw8rILHz7SWjxNw4NKwnWtyjcXwlnciFUUiiWr6GTqFqcZfvJgAVObELHqFQXOG
         Br50OyePth8w7AA43NFN2L4581KuKwvndZvs8xlG9xTEp4Fpo3NKpwXz866mghobcLdz
         dGz74CWFJdbXhFBfIHGM2JvoLXYuPZIMhScI9ysU1r6avLtfLPP38Bx/zkzXpsNCL246
         iKfeX99JDvPzfrj8N9NAzPgAnotyQ8I8Al6uUcSu1vmTXOJLtFAUIxBTiMCknNtujfDV
         dkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099733; x=1715704533;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wxpXSgV2vu9Cg8Y1DENV2ZH05CDCilqjIzS6gLOhXA=;
        b=VXk8CKNCs0fiF2yf87IWxnbytfCX85GqcMNUhVJvY0gIvhACM2zq1Q1wzVHiDX67bj
         mb/Z8GWAj1DV4v/RY2IVcpJKAmGzzYOEo3SwvcRDnBVKbDOk603g8qiy41bddqrC24DW
         Bl5oNQXqGsEsc2+Lu6BZ2Y4zdoen4ZQSJ6OuhIDyaIEw05x3W/LhitTuVRTEqUkZ2i7G
         gMhPd9IPj8+2kiUk6g+A9KACorg0mni8wRo8zymm+IoRjSYzJAB1PfhVOtj98JeH8oBu
         bSht2+2ju0VpKNiCpO9B6B1ooIPeqUBCEF/3oKKWMAF6skiBHeGXRj4+sTNuiTxXGbv4
         Du2g==
X-Forwarded-Encrypted: i=1; AJvYcCWIdaOHzQr8p8vqcg7A7u8pZ0hHrQt5ued4PYTQ37MfKSNRhZNoeWp1P2NH4y3i/EhY5EZkShS+/URUSWnhC2pjvXH3fth1CUW+JAYx
X-Gm-Message-State: AOJu0YzkkeykvreeNGdmWgnSKES7kFAcVLAxeO4t1nYH3gFhYoaZwevc
	ORhwjcezaQU1eNgwEXMt8zj73NWvN0k8zUl+vCJbRgM4Bqc8YvoCs3DE/5vygdM=
X-Google-Smtp-Source: AGHT+IHnJmB6YLIDzfSurogWeOre9zoUYSgzDdpa/UcayHut1a/VHi4gJBHdRBQ51rlqFxrduGSzew==
X-Received: by 2002:a05:6512:79:b0:51b:ebe0:a91a with SMTP id 2adb3069b0e04-5217c6671a4mr40379e87.36.1715099732820;
        Tue, 07 May 2024 09:35:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00562d908daf4sm6511503edq.84.2024.05.07.09.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:35:32 -0700 (PDT)
Message-ID: <a32fa81d-bd70-4dfa-b512-e2adce4f8c35@linaro.org>
Date: Tue, 7 May 2024 18:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: qcs6490-rb3gen2: enable hdmi bridge
To: Venkata Prahlad Valluru <quic_vvalluru@quicinc.com>, andersson@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_abhinavk@quicinc.com, quic_nankam@quicinc.com, robh@kernel.org
References: <jr3ble6sxr5mr6cvm6ldvpyk5j4rucj3xy6vbha6ttoecte3d7@llu6qf6oasuc>
 <20240507163045.28450-1-quic_vvalluru@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240507163045.28450-1-quic_vvalluru@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 18:30, Venkata Prahlad Valluru wrote:
> Rb3Gen2 has a lt9611uxc DSI-to-HDMI bridge on i2c0, with
> reset gpio from pm7250b gpio2 and irq gpio from tlmm gpio24.
> Bridge supplies are Vdd connected to input supply directly
> and vcc to L11c. Enable HDMI output, bridge and corresponding
> DSI output.
> 
> Signed-off-by: Venkata Prahlad Valluru <quic_vvalluru@quicinc.com>
> ---
> v3: - Updated commit text
>     - Arranged nodes in alphabetical order
>     - Fixed signoff
>     - Fixed drive strength for lt9611_irq_pin
>     - Removed 'label' from hdmi-connector, which is optional

Please respond to each Bjorn comment and explain how did you implement it...

Best regards,
Krzysztof


