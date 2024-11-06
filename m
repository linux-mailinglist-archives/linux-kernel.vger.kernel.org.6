Return-Path: <linux-kernel+bounces-398011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E29BE42F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98E81F23405
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304D1DE2BF;
	Wed,  6 Nov 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiGmJ5CE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA641DC194
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888611; cv=none; b=FmYBVTYNyyTTNcyPZ1otCZfXjA1aQPXFXMeWVk42GtsT9113uR8KZn+QaOI3LYhjB90ZwS+T3u9yEREUN4bLpYSmpSPi8kfiK6NnRpsnbdkKHNEG391fHmoKOwfjYXhL/VivuWaTgj4PkqOPHlKUmyU8APrzU/BQip0A/ig8KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888611; c=relaxed/simple;
	bh=5ZTdlscXjwXdZc28p/Of+HAHBUGlSUNLJL2+POeD/0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7tl8FvzMO/6bJWJuX0+fuE3VTnzwcwVFBqZXxrQN8bHScBhaiOD0U5BuAnccVdzQ4W2ByE78o0xS6wWmA9GvH72DKxnEVubF1BeDUy8MPEdoAwLh9fnFf0eu7XOIJjrJPEDnp1Xmha4KoGqXf0c7ZRsiBy6sCbJOK25IRq6dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiGmJ5CE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so4130452f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730888608; x=1731493408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alvW05AqLZBKVkpX7PrdplTn/4fsq+k1H0ntLD4wbXM=;
        b=oiGmJ5CEao4H6rKyhsxFpBjCTur5f4gOHB+/e6XUgD3noEyw41iKZGX7HYDd5g0GHw
         UzvV4yb4kOzQvXHGlh8wtFU/8LCZs8C63ZsLmO6EDihFOoc8fgZY6mDh3yd+p8ZzEhTB
         H2+yOAKGPNw2IIB0JAf8nng/IvRQBabEZrIOweUm1EeNZMYLMP1sOckai1KCF+gJOZ2v
         AsNU1I+tdVe5RBEoXn1tzxSsM2phQCIR0wFChh3gbnXdBzrg1EjjyvwE18anJ8KVlUnC
         xPKdCtx6IOPMWr/gk+rzfRmjFbrTg/BDLOVmz5QEo53HENphwDVA0Jj9nT2abnNgFMXP
         nUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888608; x=1731493408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alvW05AqLZBKVkpX7PrdplTn/4fsq+k1H0ntLD4wbXM=;
        b=wF4N3nBsca0fVUE3Q9EitUwd+RYS91tnkeCuRkwKag8wjNLl2gaQK3RaVEbL5P7+Q+
         6n4bC22Dicc654sJ8IA8a1hkjKy5vuGf4I2XpBwkV//lQ6nJB9NvwVLApCOHuwsvbeCn
         ezh3Qeyd7bOjy7roO2+/Pn39I6XOQ4ovvJqYXjAsTrEcUQRtxM1FtmYlqzq7zSt5SCEH
         XQzKgVUZITa5HNDN466239ytKpK563ms9k75cSnFGDaHCVBmg2VszxPcaNiR1iXXCe5I
         dYXiKwGM2t6LMWdz3bwGm7rWqkCt2vDaaLgntFiyUmXrM0rR6tdO7zLWiVpHWnS4sAvr
         nU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWuSinl9FXYFdltFSuBrB549q0B8qCD2j3OwzlHeY2kKqIAroP04bFlhWAukzcTXegP4z6h2QPzwS2Mqrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSW9DtyVIT+eZk3BeCTowXfjLjrLQuVqKhaci+E17QOV1vIRqb
	T1O6DUlVV4gveI+2PsapZ3sfuphj3F2I9kH0Ldn87rWQMahkPnxF3WCYsPHnbXM=
X-Google-Smtp-Source: AGHT+IFM/sNFa+KEx8YfPwmIWtaTMMW7EIUGwvTNJkiyP0jY1dX7JPo3+l8pDyMtrZbP5YVgM2SUvA==
X-Received: by 2002:adf:f28f:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-38061190da2mr24474893f8f.35.1730888608072;
        Wed, 06 Nov 2024 02:23:28 -0800 (PST)
Received: from [172.16.24.72] ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e61f9sm18666123f8f.58.2024.11.06.02.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 02:23:27 -0800 (PST)
Message-ID: <d39c7613-fda1-417c-a205-daddbc378bc3@linaro.org>
Date: Wed, 6 Nov 2024 10:23:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
 <640fe933-078d-4bf5-815c-7db0eb8b9de4@linaro.org>
 <7f350d73-65dd-097e-8b4a-e9a23472aa28@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7f350d73-65dd-097e-8b4a-e9a23472aa28@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 07:25, Vikash Garodia wrote:
>>>            cap = &caps[core->codecs_count++];
>>>            cap->codec = BIT(bit);
>>>            cap->domain = VIDC_SESSION_TYPE_ENC;
>>>
>> I don't see how codecs_count could be greater than the control, since you
>> increment by one on each loop but >= is fine too I suppose.
> Assume the payload from malicious firmware is packed like below
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> .....
> for 32 or more instances of above type

But you do this

           cap = &caps[core->codecs_count++];

for each bit.

Anyway consider Dmitry's input re only calling this function once instead.

---
bod

