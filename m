Return-Path: <linux-kernel+bounces-575492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA46A70338
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B30516B319
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AF25A2A2;
	Tue, 25 Mar 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5oC7SqO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92050257ACF;
	Tue, 25 Mar 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911486; cv=none; b=pTBWPlkkqJzJIw17DrZ3IM9axqbX8v7IQdD2tninNySsRpk/F1uQXUPZ5QB7XQoh8N0hU359BqDUpZBfm00Oav/3CmVh8peQFA9ZMJwE0mNOvY4B1qMZNJL+++K5GEdMFKPOjiUYPzv9srchI8JhQBF0UMEYYMEUH75LmHBWO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911486; c=relaxed/simple;
	bh=xXUBo/r08ppfabdNhfRKMeAHV1zknb55oszvUJ1765I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGCw1l/0CUMAajAfYQHM3/DXWkmxYFGBxEoBniNDdxLKaspYKwlGEPYFc8Fec/wzc+2CO8TYZa3hAmS5BFESNleV3jb5zN+KZZ3pYXbTuYVkbKSvJrR7z9N5Sxq08sDK4UeZ+Y0luDVSnAzSBg3OR8Q/3u0tWNlazjt558yK48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5oC7SqO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso938108166b.1;
        Tue, 25 Mar 2025 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742911483; x=1743516283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IR5ujn7AjLMQZFopFo7J/ncF6+SQ7YPLcWumbPW8qZ4=;
        b=P5oC7SqORMiba42/Rys/CRSvR7K6P+tE/WJGRZU3I6yiLeXsLSM2wG2AveJlyTZsmA
         /0D6YXbIx18rcLte8XGgY6cL40cLMt7zLLc2zYCAl9I+XKO+NgTlVJl6aqzKx6I8YC+b
         4wuOyRowKudTohwGx9XOKZsCG3xgd7Y0roR4LGtS5drhao/nGMDzhssOcK1DOSUyKO0J
         r0atoajUJlkYIH8EZXxhMMhPdqLxDM0YUx461lDNsJhJUn9lmR1tFWQQN5oOP6iRwET/
         2ISh+BNpAUdHgFobAbGcEDS1ZXPUuPXSRU9/QJeSYUKeJXRrZUIESGHVJiDy1AiEicgQ
         mwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911483; x=1743516283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR5ujn7AjLMQZFopFo7J/ncF6+SQ7YPLcWumbPW8qZ4=;
        b=U45yd4G34no8Q1MJ+D7Q+PY4SWQGNp4SdFLgZBWhC8pHrS0N4xpwF/6A3n6SrKki7h
         /xNSDdyymtz0/dd+NH5Li3VLP8VUuUnpR1x4xHp/L+mr2kTC6DLBdsZDSJcmh42Se9+G
         V9A52PG6RCiuaT8hKmKIi8xjeF38fOoUwF8BfFrqU5i0lqrGcK35eCsrt57PkvR5jqJH
         zUjkVYZdybfQ40XyHqD3s+0BNcGzZ+019+mE2AoNJ9SJcVsNHmxmbScSP+j3TIixsnLo
         osdwGtIFfXj4qJduSH9bHDtjEjhkNw2UoY3T4BxFGBaSVbK1Rc5Qg3/KLbMZS33qsPFg
         9EqA==
X-Forwarded-Encrypted: i=1; AJvYcCUZgngMAQJwSlDsB33R0MW5333DX8GkByPTQT6y37bhE0gsLQBJ3FZ7MsUlnLygIs6gHJqdaVNhcgWn@vger.kernel.org, AJvYcCWLDDO9xkYQdP0MgsimnSOjVqn8ePx5N++uQC8otWQK4ZvGP8fDZx6BRoaj4L8XkmEhRmza/Es3klf8+9iL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7XIINzzEcYe33SwdiJ8uGTA46RLpFRGe1wLNYYA0mAlzp6Rg
	PNYL4FEiOP9W9tp7Y3h01/oi2Sc0zPv5OgsBw54+MGfp3BKXJ7RQ0hmu8GHS
X-Gm-Gg: ASbGncv7rHSvJBucubCXIneTmaMsaAH6OKDRfWGY1Rc9BWNjYoXF0JqyEGgsJFq30XB
	FeMPWmJVNuyjbtBI+/yNUfGNrjXwo7qkOlNRMWijqAPSAkupmivUD99dHJ+5/k32YfJeofNiUbf
	7ZJVQJyUvTWZagb9qS2btVQmJxMZv2x2OvIPa3gPLicNvhoKg8V/SlZxL8YhObU5pSWN7Zm1I7+
	fL8/h/pJ+O8L20A0P8EcqOQ/QVVo3EBvLsaHB97F7XWM+cjxkeLncZSTsqF3WiH3F2dB7PZa+VT
	wqvK0omrF07SHahPx8hptYmfcZ5OooOd2aXDE4irM1pHRML/6QNr5P7qbflIxIL0UOlQaBrfnp0
	qGcrp3Q==
X-Google-Smtp-Source: AGHT+IG3vk5aFfvxYlBEnnsNJ8xlqwT5drWZzNV8Q3gYkvwhRoJfBqYWpFpPBoZTRvzyouJNQu2Jkg==
X-Received: by 2002:a17:907:2ce3:b0:ac2:9093:6856 with SMTP id a640c23a62f3a-ac3f257b566mr1557114466b.54.1742911482303;
        Tue, 25 Mar 2025 07:04:42 -0700 (PDT)
Received: from [192.168.242.77] (mail.ultratronik.de. [82.100.224.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac696678277sm422700966b.174.2025.03.25.07.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:04:42 -0700 (PDT)
Message-ID: <aeb4a980-1b92-48e7-97bd-ed98d5ed7845@gmail.com>
Date: Tue, 25 Mar 2025 15:04:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Ultratronik
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325110409.2323611-1-goran.radni@gmail.com>
 <20250325110409.2323611-2-goran.radni@gmail.com>
 <08246305-b59d-4924-8421-805764f60d9e@kernel.org>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <08246305-b59d-4924-8421-805764f60d9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

thank You for the advice. Tag was not added because I have forgotten to 
do that. I am still learning the process.

Best regards
Goran

On 25.03.25 12:33, Krzysztof Kozlowski wrote:
> On 25/03/2025 12:04, Goran Rađenović wrote:
>> From: Goran Rađenović <gradenovic@ultratronik.de>
>>
>> Ultratronik GmbH is a German electronics company:
>> https://www.ultratronik-ems.de/
>>
>> Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>
> Best regards,
> Krzysztof

