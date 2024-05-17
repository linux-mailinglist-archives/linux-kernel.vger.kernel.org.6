Return-Path: <linux-kernel+bounces-182679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E788C8E60
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF58D1F22BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6CA266A7;
	Fri, 17 May 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKwKUEP8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3221E86F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986726; cv=none; b=sSmMtFTQHboW5pVUav7CnpNFMayM9XGKZQnIKGMXpCAAqH7VfSrb5HdChWmOs8Ci6tNLQfi8Y0aedu8bVLTE61MY49V6HZulHELQLH+r6A4gvmpE+ors2bEIpKcXBCoC8N4fnSGY/iG6Y6FoKJ4aA4nEwpKokE0dA4PH4e60CoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986726; c=relaxed/simple;
	bh=b3HEzdbmvtrX5WdGd9rjQfRwTpx8tZmqQi4EvaEALuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXpqEwTN6Btq7vObEF+Pvl5mjdClaZUtIQnv7OLLRawfNhnwUf5KVcVbd6YD96PMIEjwBdDrNXwfiaSMnK3Yjs+schnGGBVoBDIDd5hEj3AieHq64aSxkl/3W4300lspyU8sdGnE16/hKjz/cOe5oVnI5SD0mvL8ldfN+23aE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKwKUEP8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3504f34a086so552961f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715986723; x=1716591523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxt5WSyPNmlFYnh1kzF3WbtIYIDZ+lmJH/CiUrzIcLM=;
        b=wKwKUEP8hOsGDf8mIyWwP08Eg/OGmaHKYcLz0Xcs4kqXKLx3hZLugsmf3NQXtBWODx
         1d3QwVlbRV+i2nR6/OPPi6BLvkxwUGYOwfrWGUp601bXXdejDBzUQTKz02T+OuM/+G/O
         zx8Iakk14oG2eZUFVR9GiO3SJRoKOWD9qN6NCZXbzFVDrcEgsB6AGp+CWZKKKHZhs7wl
         eK09j9YmkNtUV//+Cw8Zc7UCFP+gTI12RMYpMUe6I5Gdx42QLZsqayN07C6vEFHgwoFx
         ubDduvko201G3ToONBTQ9FeG+ab5OmFIy/SxPV7MQpEB9qNFeGr6CF4MClSqv5DhwOSa
         kVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715986723; x=1716591523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxt5WSyPNmlFYnh1kzF3WbtIYIDZ+lmJH/CiUrzIcLM=;
        b=c7DD2XnA4Ba7YV5IRSC6Ct9lqrmuGkAM8WMKRwLAndbNxE8ujWFB/gDjmcwURheVuJ
         HoGlvbGhZHiY5w43xjTxQ7Dy2pdchjpJsDJRYLT2HgrzEBDgTkZC5ofQ/pOdDjMHqt7y
         iDMOPx2YiuhFxpOrwVA95kqL9au0j2pjAe1o1KBSpbJzxVDoCwqUNoUSw1c/Rz8Vfg2h
         RxqurHV+mG+g4hyRYzpAARRSQzeGjkg/NJV8CSqeJeVuL0vlEkwfOM8QhCopJjTJx6TQ
         cTxOu5Z2sh6NqrLJTZ6clWHjeEhFbt6iApMFS6tzrCX+Ka+Vo6V11kqFU6QZmKg3VUQv
         j//g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ65u7hC+KlupPoBM5YNznd2SwYEJmlONqpqa9hSDltnpwm2/wungBAzP5mjJO9nlBlH+ow36u/ZEsdkLLBEiCvTYFKrfwaxcToF/3
X-Gm-Message-State: AOJu0YzM4A01XXS9KXm9C40ZuykHG8i35KTTxGLwGfnTj7jtUfVvw0Eb
	yXVPhjZa1k7lo6MkHsfl0yyQrgIZHRIfn7PCxvE9J9nC/n79k8eb+r4Q2Hogkm5DLa40+U9eqv/
	2zjvyTQ==
X-Google-Smtp-Source: AGHT+IE6e2aENPVFCzrjc2I0B5zRRsvgtx95F6JJIdCaV3ViherGH3/B7Gcz5xrvw9dnsNCNeyaV9A==
X-Received: by 2002:adf:f683:0:b0:351:d2e6:9296 with SMTP id ffacd0b85a97d-351d2e69673mr5333036f8f.41.1715986722995;
        Fri, 17 May 2024 15:58:42 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3525f7f7d88sm3315262f8f.57.2024.05.17.15.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 15:58:42 -0700 (PDT)
Message-ID: <3fe6e86d-5b4d-4b3c-a5d7-59f01dc6b0bc@linaro.org>
Date: Fri, 17 May 2024 23:58:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Frank.li@nxp.com, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240516152537.262354-1-linux@treblig.org>
 <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
 <Zkc69sMlwawV8Z7l@gallifrey> <Zkc9J4vbQdeCmTpO@gallifrey>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Zkc9J4vbQdeCmTpO@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2024 12:19, Dr. David Alan Gilbert wrote:
>> If you look at the V1 I had
>> ''gpi_desc' seems like it was never used.
>> Remove it.'
>>
>> but Frank suggested copying the subject line; so I'm not sure
>> whether you want more or less!
>>
>> I could change this to:
>>
>> 'gpi_desc' was never used since it's initial
>> commit 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Oops, of course I mean 'reg_info' which is what I fixed in v2.
> 
>> Would you be OK with that?
> Dave
> 
>> Dave

Hi Dave,

I saw your v1 interaction after commenting but, I still think commits 
that say "this removes a data structure" should elaborate more.

"This structure is no longer used since commit: 12charsubshahere" or 
"This structure was never used and should be considered dead code"

I generally hope the intention of my commits is clear from the code with 
the commit log adding whatever context or elaboration on top.

So that's what I'm suggesting here. A bit of commit log sugar on top 
which elaborates on and justifies the change.

---
bod

