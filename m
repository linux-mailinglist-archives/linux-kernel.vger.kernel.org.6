Return-Path: <linux-kernel+bounces-281927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38C94DD13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 15:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE81F21986
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846F1586C7;
	Sat, 10 Aug 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POgsqgHU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31713288D1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723296913; cv=none; b=fabH7l0akrK/KyYPTfELrfuoIqK8dsgyAcSUgfn+ZFdaKcnzXAASpBb1nrlI6kEYyX4BSi1VsOxHzvk7FfnZmr/d5OPR3+EoF/liwkGCrqLfJ1kOte2VVPjEwxf72gX3t0jnUOFaD5miKY3aa3BHEnC0to3VuRm6q+qW6fV5DIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723296913; c=relaxed/simple;
	bh=aQewt7vPczpUKAA/uJAmW8It+gKC9tITEDZ8veguycI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3aOFVdUOi91YLY5eGVX5Xfh1PFNiIucyDavDroXV5rdsqWbzMXh7s0DjUDCOz8O+W8oG2Qtz2uBnnNbtx3hhqRcSWOFMQ7f5sqOZ2zEl5P3+Izzv8SojqISGsVBRIp3sMfDm2MLo7jvUIBTDbkR6RHCLQNsTUYJ6jZSkSrPAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POgsqgHU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so35135971fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723296909; x=1723901709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWOlz01J1kNGb6F3FCqM2ubI8vKf+h12MNqlLoVyrtA=;
        b=POgsqgHUY9+YtDkTl9IbChRvOPtYqtCKO4dZ3rwDszRergtRidA8FxgDw9QGvcgbp0
         s2kDBTm4Gh4XAgmOn7ENRkN/4m2fWV/j1JtaNA2++t6yCmB8HZxpHMdnCNnavQ40Tsx5
         +01zaHJO4HY1YKaqS8rwxbCI7io7ideY30umilv+yw48ZCsSYsjudopr+bOPpaSv7AXW
         WZSYh+a84fhFXAGtTnWG7vxPWlmtrOHUm5Pa2yibigI1xGtcOroisRRDs2xRAzL2Utyi
         c4Kk6zQW07N1d3H4MTi/DP/m/uN4Nzs0ymReg3M9OavkErZitqcPd+4g0kcsuMWFSkGV
         gPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723296909; x=1723901709;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWOlz01J1kNGb6F3FCqM2ubI8vKf+h12MNqlLoVyrtA=;
        b=PYFzGVeTU+1AovMGx5kkHj8xz+dKu29GUfZDfSQlrsKKz29EoX0Kic1PqT9UE1YxDP
         KVe+z7iE6KQI0X9AFCoFO4mJnp52ULJDq7C5/lwqTp4bVKlot8TAmyjrwcZsRP+b05sF
         7ysGAt83OycWc8nfCOtaRCwqemKQiJN6VqjO33TIVBWIQ52c5MwDXLzUljo6cSW3YmOC
         G3MVfK3wjJwTBiigbMb/rnfj65RUbPKfqAqeg+WpTHwCFftIrL1XxurIvnVePicGFDbD
         7boDlPyldDhyj5bEPHsK4RxMsak3M1hkpyPXOz0+FVoOu6AtkDiSrLse4v6ljZHjCAmk
         qb/A==
X-Forwarded-Encrypted: i=1; AJvYcCUdbI/9GcwtDgG5hksRM1267VdBzAP3aSYqAkuq48J1CdODitXNMk/anFyddRpYI/xgH6bemaAA2lPwWCoN1mf5qRMuilXPw61GoL6Y
X-Gm-Message-State: AOJu0Yzl3Sisnj8ZlNWBJPElbUFt8ZPc6e4YuD7ShkJ5vUFkMAlp+FlN
	kDw/mHL2CDzvM0bIFsnTDXRQLX5O98hVLNwMOPOfGSrCvatbrbts2ppNNkKEgKQ=
X-Google-Smtp-Source: AGHT+IFaRpwR2YyQK55eQYAtWSJ2LR7BdB/qlKnCpt8sVGA9kFLuSKkqvPtUhKyG2hmxdhtAePuTpg==
X-Received: by 2002:a2e:a995:0:b0:2ee:7a54:3b08 with SMTP id 38308e7fff4ca-2f1a6cd446bmr36503211fa.3.1723296908974;
        Sat, 10 Aug 2024 06:35:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938582sm2385803f8f.38.2024.08.10.06.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 06:35:08 -0700 (PDT)
Message-ID: <0bded05c-0fe6-4f35-b527-662b3356fb56@linaro.org>
Date: Sat, 10 Aug 2024 15:35:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: Add support for Xilinx
 Versal platform
To: "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Simek, Michal" <michal.simek@amd.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>,
 "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20240801120029.1807180-1-sai.krishna.potthuri@amd.com>
 <20240801120029.1807180-2-sai.krishna.potthuri@amd.com>
 <27da3261-8c1e-4c4d-a548-acdfee1909f2@linaro.org>
 <BY5PR12MB42586B02EB54BA76704F1062DBB92@BY5PR12MB4258.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BY5PR12MB42586B02EB54BA76704F1062DBB92@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2024 07:53, Potthuri, Sai Krishna wrote:
>>>  1 file changed, 398 insertions(+)
> 
>>> +      bias-pull-up: true
>>> +
>>> +      bias-pull-down: true
>>> +
>>> +      bias-disable: true
>>> +
>>> +      input-schmitt-enable: true
>>> +
>>> +      input-schmitt-disable: true
>>> +
>>> +      bias-high-impedance: true
>>> +
>>> +      low-power-enable: true
>>> +
>>> +      low-power-disable: true
>>
>> Why do you need to copy all of these? Just switch to unevaluatedProperties.
> I tried with "unevaluatedProperties: false", it worked but by adding this all the
> properties in the pincfg-node.yaml become valid for this platform which is not
> true. Not all the properties in the pincfg-node.yaml are supported in this platform.
> So, is there any other way of representing this?

If they do not make any sense, then sure, you can keep it like this.
Drop the blank lines between each of these, so it will be compact.

Best regards,
Krzysztof


