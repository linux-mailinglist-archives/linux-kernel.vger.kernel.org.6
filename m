Return-Path: <linux-kernel+bounces-547647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118DA50BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2394E1895003
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3FF254AF4;
	Wed,  5 Mar 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDQSPgRP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5324C07D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204518; cv=none; b=iTvKt5Q2ynVMvyxr1KaoQydz/SWBnWKREd/Qcwtc7Cp6ZOxU4ELCNY4ApTLL8tSMQilj2p9548b9Y4Vdjfbf8nM3R+7CQL5pv5wrm6YGezg4e5ACGaK02ZA718dt1xOXTG29NYPj+40JE3XIKONp5eFjw8lm718fU8EUPt/VdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204518; c=relaxed/simple;
	bh=uumqQ+IyHtbLUhITXc1Ykqm3Ltsx4eHZUpLGyo4DodM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqBIXzAoXWgjQeBNSz4o83viBOU19rhpumoWjNiXmqWuFM9Kj9FM8jTUZ3KOi7qfgZitsEYNWc0xyoCB+9c1jh03q75t1a8iOolXlbn9CC+RTEwQqQypY7YcVfGXreXwAjZRFZJup0lteveou+zcwhr/aX66NmZSGe6+6pN02Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDQSPgRP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394944f161so8811725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741204515; x=1741809315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UMAJWiMuRcuVhpch+2OnnhMpVy7qID/b1S408w6N2LU=;
        b=qDQSPgRPTZjMpPjkB/zDd53N+atYlFUywhTjCT9pbNJOxvcs95AaUG9mHLtIxZX0Jr
         M2hTYd7dftJPApUI2V7ytliqABD5VDwemfLbRm8mrVs0/99WT7yXlPe/w3GtPTXg8wfU
         v6eNPdsnvctchno+jS0BV0wa+BXuX/5FrkACJzCQ5AM9Hj7APEtjL7yL2YXiTTAwxiFi
         EktW27oyx8Gbk7Dk4N3r9YSbPArQX5vDU5ozG5FYnWwe6FlEf5CfGgZrQeeoOJpXjESE
         YS8LNp/rsvx1Srs++4FRQJSpaAvLw09SJkpD81RHhIlvyp0LDs36/MCu7l9lTWFlZttn
         iZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204515; x=1741809315;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMAJWiMuRcuVhpch+2OnnhMpVy7qID/b1S408w6N2LU=;
        b=Zn5NG7qqu3KjeYAq5TOnmpbo2sNvtmG6jdipGRedSzuMMD7QIXKUiSm7TxRnijirH7
         npKO5Y5b4hWOCZ8KM25VAP6tclJHeBETwYl5JPm3x9fx9XFwNNfzqvh4qqU227exF7KU
         x9n+5JQAbbZEafbvx18yVlK3+IFWh6NhcrcL/6myrBlfQHA/Gnpl6kGvzfidCjDUA5dn
         Q5gjW1UtqhuzAFWiZGANJF/bgwGPfyf81aQ7S1WfHD1nOTiU5dF45FH5zT2qdmplQIs8
         5GFQoEB6MG9+YfLNfsGVyH4+Imi8YGUaN/qbbWdPKuXR1CuF1fr7+yBSOOulWowIPIyy
         awqA==
X-Forwarded-Encrypted: i=1; AJvYcCUeN4zLnAgesXvgUxsHO+2SwrW+3DCozbc9aPrda0qP8Xzlb1oqhT++qAp97SRyAtD0WXrtLmh8KZmqKjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDJ+p9x643cWEhRiHi7xYk9gEgMwnxQK79ER0TH7WIJlByLA2
	IB/EjIIFZ8g4dmaVjz/GP7B9gs4L88i1VDh0pIikgHFfLDPKxg7t72J+Gw2LNAg=
X-Gm-Gg: ASbGnctLV0BtPBnFMLHHCfRP55vwbkdimUGUUQ/agsgk1lE1Oy8xoXNUN2u+7xPsyCS
	GCKUYxPEIPXqvkUMHgUrT/k57BUvG9pWwJdgpYUTX+IN7jSS9IyffbjKDfhgAl2xjYLgHcrEA+6
	Ho96nhQ6Kvk9wX2szKFIfZuPw1dHDFrWmU4kegdwZ8thRJGL/FefQkaQAH7dA/u7qbcPYWB32VR
	xQdCPSXdNozPLzrnzwaBm8zFfZ+sADBLLxjm5TPsMVS/r8oB85txXn9PPaMzOaC+dAygW31DtJX
	7fLj9zJKNsoEL3lRzRDJVHIIRLR8HL91UhWkfaHgJxuJYYPbs8FGbgSyjdB1Oiwa
X-Google-Smtp-Source: AGHT+IE0NblaMrSIYQ6RV1u6tLH1ebczgqKb1OnbHqFj2fqxAWv9+kcdqezhM25t+RydtJS3TOc8lw==
X-Received: by 2002:a05:600c:3b9e:b0:439:9595:c8f4 with SMTP id 5b1f17b1804b1-43bd2893cc5mr14788055e9.0.1741204515115;
        Wed, 05 Mar 2025 11:55:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435c6f4sm26418675e9.34.2025.03.05.11.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:55:14 -0800 (PST)
Message-ID: <56487b08-d4ae-4eb0-88bc-9c65ae866508@linaro.org>
Date: Wed, 5 Mar 2025 20:55:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: samsung: Add missing mod_devicetable.h header
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
 <20250304-clk-samsung-headers-cleanup-v1-1-81718e38246e@linaro.org>
 <9063abd1-b417-4623-b44d-fcb18f3c71b7@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9063abd1-b417-4623-b44d-fcb18f3c71b7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 15:23, Tudor Ambarus wrote:
> 
> 
> On 3/4/25 6:45 PM, Krzysztof Kozlowski wrote:
>>  drivers/clk/samsung/clk-exynos-audss.c   | 1 +
>>  drivers/clk/samsung/clk-exynos-clkout.c  | 1 +
> 
> drivers/clk/samsung/clk-exynos2200.c can benefit of the inclusion too.

Yes, this was reported by Stephen and I was waiting for reply from the
author.

> 
>>  drivers/clk/samsung/clk-exynos3250.c     | 2 +-
> 
> drivers/clk/samsung/clk-exynos4.c too

I missed it, weird. Thanks.

> 
>>  drivers/clk/samsung/clk-exynos4412-isp.c | 1 +
> 
> drivers/clk/samsung/clk-exynos5-subcmu.c too

How did I search for of_device_id...

> 
>>  drivers/clk/samsung/clk-exynos5250.c     | 1 +
>>  drivers/clk/samsung/clk-exynos5420.c     | 1 +
>>  drivers/clk/samsung/clk-exynos5433.c     | 1 +
> 
> drivers/clk/samsung/clk-exynos7870.c too

Same as Exynos2200. I guess I will fix it, instead of authors.

> 
>>  drivers/clk/samsung/clk-exynos7885.c     | 1 +
>>  drivers/clk/samsung/clk-exynos850.c      | 1 +
>>  drivers/clk/samsung/clk-exynos8895.c     | 1 +
>>  drivers/clk/samsung/clk-exynos990.c      | 1 +
>>  drivers/clk/samsung/clk-exynosautov9.c   | 1 +
>>  drivers/clk/samsung/clk-exynosautov920.c | 1 +
>>  drivers/clk/samsung/clk-fsd.c            | 1 +
>>  drivers/clk/samsung/clk-gs101.c          | 1 +
>>  drivers/clk/samsung/clk-s5pv210-audss.c  | 1 +
> 
> drivers/clk/samsung/clk.c and drivers/clk/samsung/clk.h too.

Indeed.

> 
> With that:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks

Best regards,
Krzysztof

