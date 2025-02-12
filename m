Return-Path: <linux-kernel+bounces-511871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB5A330DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700CB3A7952
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919B200B95;
	Wed, 12 Feb 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlkRQVC0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E2134A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392407; cv=none; b=Qj3Rt0H/Goe33swG3RiLx2oppLbhXaGQ3E8gzpj/GOUzCPFVC2DTs5f8Iox9WcnIm9CGj3KqjUG41p1T+5bVuxuEP20HGBj8Zl3b3wfUktXwLwr2GnhDgfquIFrMES1cZjyqy3OkciImSm0rLT57y4zRm0UCSodHHIxmDxI82ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392407; c=relaxed/simple;
	bh=yH64L4+bl1w0nfMZxq2PSZFyl8TfHHOghqbF6gZIU24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pS1ps06h9SSVB24+sN2uZyMcTuWphTSMb9Hx/U+ypUPG3oefwyUBleMBcRa+euzKGqGiVoatSEQ1fIEJtARJ1LLLAUEhIcCgK6RX4ZhcRdr7rgR+d9dqyushZKQ84+9WxTC+AB6FqdFJiModKBDW32hIGZEY9msixlcVS1bYg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlkRQVC0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de47b3c6c9so8376a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739392403; x=1739997203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIWQ1cYFsKmdYVBFw76fShsZ0oqbQapNfjENnquqJYM=;
        b=FlkRQVC0qgXgrTl+SzSkRhmZXoOCIpgxzWZdDf0yiLbXZ5kaRTJNLkyh+APzlSWvIv
         b7HROtqvCv51VdnlaERD+qnvZIh6ZllbCU4bp1iB6yjlQGtDpQzsCfzfIcORqTYVRtjp
         LKll7whQL8Bzje9h7fkoceN0hozcWtYSEckuSDX/RiIbUK9Ytfa/QGMHXs9FtX1fOJHi
         FNSaoBEPUC9hDOwDb0ZqLTJq25+aQlZb2w81FYJOO/a86O3z/IGIXjND9QcEjxJE6xw1
         RGhbdr5fAe6XvGAiE/3PscClIPjgShxj7mbUcQQ29yZS9ISq0gSG8lCgHLnddotEredb
         MlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392403; x=1739997203;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIWQ1cYFsKmdYVBFw76fShsZ0oqbQapNfjENnquqJYM=;
        b=ONSk2oAr1v7GA1cBPWLeUueyGx0weMVVlQgCxVsjC2uGGH9HNOSC9LoYs+xgoRwttD
         957VKm0dmABKfYLSIFod2DtM7JKvh2AFhqbgJy1bAjcYa9SvA8u4fkhoRBG5vL6KLxZD
         HZE1VElPUQ5662WxtZ7b11FoedTv1PEQa0EcriSFtBaso9U6ibdinBBFdpONKQI8XUXq
         CucSx8WT8LcVeTDbHjK66+tsCm6EwQTTQCOAiFjHmbij9cKcoTLOMWTbm5BF4QK+Ti/o
         5NV+ltWJ0EQ8xkY/eSGIRA3Sm46Nm5DXCSONGh+N8e2QkVy2RCNQvcaDDbFQFFpMv4mc
         lzjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpW+4M3FwWmTH75OPVPP1oCJ0hDDL6vjND+cMqXuELlFuKVzh/x4qqBQMSMa0R5P3eCGiN2TSl+7XoBfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2zG0liDHNFFfCf+3bO/MWQEUorrZbktn0Cq2AEV0IM4ISO0r
	G/wXSUIYj2MlL3WTUQQBrIttrEbG+5P8Eo2I2WRp16RO+6s9Pa/Glcw5LuArtbvAspVhBh8RW99
	p
X-Gm-Gg: ASbGnctjnManuikx0/+C3mhAwNk+e/i/xVKRamj/pJ5wG7g8Mau1jr/mcPcJ2FrSSeC
	UQH0PpsW3PpnEfJcmpXbOWc/FRdAepjaTElZTsbtplaq23DDGEE39FZKQ06YuSVKOzcYP2CchTO
	UtIHc5cJMrStAQktAXhA5ctFGyaX4ERovzrklmjO5no+b1zkNq+2PGVxIoJgzmuHCt1T5V6FB7c
	Qgb7zfuWQIXFrVfbRR0ierHA7uV9bDelnIzQi/42CbXC52gu1LDc876cMgZ0jBQIT9mPaSAG3kD
	P+RS7VnBlxrMcE6JPdhaf2lXDwxtOVzfu+o=
X-Google-Smtp-Source: AGHT+IGeDMm9h5OyPOgGl/JpRPwFojPaGai7niCiDvwSAxEh7i84pRRG1VSKCLWjp1rMUxxzCdw7xQ==
X-Received: by 2002:a05:6402:51d4:b0:5dc:91b6:10e6 with SMTP id 4fb4d7f45d1cf-5deade2734amr1424141a12.10.1739392403390;
        Wed, 12 Feb 2025 12:33:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf9f6fa21sm12002595a12.68.2025.02.12.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 12:33:21 -0800 (PST)
Message-ID: <7341db6b-aed0-4da0-a5b2-6992d86ffaf3@linaro.org>
Date: Wed, 12 Feb 2025 21:33:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/mediatek/hdmi: Simplify with dev_err_probe
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250112134708.46100-1-krzysztof.kozlowski@linaro.org>
 <20250112134708.46100-2-krzysztof.kozlowski@linaro.org>
 <ef0baed6-54d2-4f1f-9a4a-769ec09a069f@collabora.com>
 <59f8a02e-a716-40a8-bf73-111ad2a7af79@linaro.org>
 <8e8e3eca-dee0-43ab-95d9-aebd636245c7@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8e8e3eca-dee0-43ab-95d9-aebd636245c7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2025 14:48, AngeloGioacchino Del Regno wrote:
> Il 13/01/25 14:07, Krzysztof Kozlowski ha scritto:
>> On 13/01/2025 13:41, AngeloGioacchino Del Regno wrote:
>>> Il 12/01/25 14:47, Krzysztof Kozlowski ha scritto:
>>>> Use dev_err_probe() to make error code and deferred probe handling
>>>> simpler.
>>>>
>>>
>>> That's already done in [1] so you can drop this commit.
>>>
>>> [1]:
>>> https://lore.kernel.org/r/20250108112744.64686-1-angelogioacchino.delregno@collabora.com
>>>
>> Eh, this was first in v3 in the middle of Dec, so why you cannot get it
>> merged first? Creating such 34-behemoths causes simple cleanups to
>> unnecessarily wait.
>>
> 
> Getting the series partially merged is okay for me, no complaints about that,
> but then ... in v4, there are two minor comments to address (one of which
> is a one-char nitpick!) that might as well be done while applying, depending
> on what CK thinks about that, so there's no real benefit in getting 28 commits
> out of 34 picked instead of, well, just everything...
> 

OK, month passed, I waited, so is your big patchset merged? If it is,
then this will effectively rebase my patch, as you requested.

Best regards,
Krzysztof

