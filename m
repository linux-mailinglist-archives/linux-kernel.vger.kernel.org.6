Return-Path: <linux-kernel+bounces-401540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8F9C1BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CEAB22219
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D931E32A6;
	Fri,  8 Nov 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syARXpyE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC5322E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064440; cv=none; b=lOihtX8qIoKTYA69NBrzJyW5mbza6UJOLcQ+AwuCSl55fh/PWjkfmG6G2uCNWao4EofDcQG/nTwYaGQdNGT/TqIWkHBj4rt+yDRi/fjcEVALOdXkcU7h4IzKrcs3QlXc1JruOCmcyUnAk80m0hKJsLP5MGqpZT2VS3cwzBaSRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064440; c=relaxed/simple;
	bh=1FhJu84u9EjD4n9ZYuFTjA/Zg6uULvqxMlu3C8byu9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l9Xxl8VIt86rkmD9IxUiBtFmLLvajesZodPJpkJTHtR7E+gwz7vE8EFT4pE7MoSZjQRUqJIEd1HI0j+e7jDni/f4OuuzOmaCdcVT3XgvXykY106zGdXCHbQ0+PQAThLYabvcWuGI3Drz9Kl3J0e7xqNiCjXEWQ3tvseONiewNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syARXpyE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so183186f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731064437; x=1731669237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpKPj8SjhbwkBn42AczmN4c1ljluVubEaU7nZ5+f+GQ=;
        b=syARXpyEYCu+bmxTzq1KOinoCXjyi0cb07FyPbL1BXvQUhJOKmXA16DdqC1wYfKeDH
         koDkA957izqOG+zsndCTVT7Skkv2RNfHuIzQjbkBOqd8bLXxRqOLJ1W5Ze4j47ljSg+1
         KrybuJBWQhyrpFvikkYCaVU6KXcHqZfX4DBM/+AgtJz4Nzxq9xTwgnNUQS60+IUD+LL8
         vl6kSqFO+5K3Nucijys5ZI4LQEGCpgW0Ot/laaywvf01g7FVXC3W1IHPwoDZsyazqsAy
         VIDlzLkXL6Ia76PKyub8EEbn9Tkjz+RKfu+q4OteuDPUgAx5Amguwbo7Cf8iP+KUZhO3
         rYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731064437; x=1731669237;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpKPj8SjhbwkBn42AczmN4c1ljluVubEaU7nZ5+f+GQ=;
        b=LRFmVNndy3PzfkrqQH3VYsxoDsdbr+Bhb3EYMU9qyFq+jEEw3JtPMIsE5f0Ln+CtSu
         yfiuD7c9SE8sL5zr78FpGMXtTU7yS2Ufc9YJAWSVOJcWHVWQb5B9nPZlxu5gp7/B/lKX
         WuJdpkGponJvwsxPPvAORNQ7nago/Tptp3dGkOOlXxKKzed58iw1DXQdJsOv468FniMH
         YQxYzMNe3LFSJD0PDG/PvXG4PfI3TRjVGt5+gVm+K5A+F0IdRiIDqhu3CqycsuK8l8il
         TCRUzlKd67R2023iqULIrzf2qGxNj+91xy2PrF7OC2yXMYB/9ql9uKtivhuXLMP0uVLM
         EXfw==
X-Forwarded-Encrypted: i=1; AJvYcCXOvVzbe0YkwBCm6500hsIbNiKlVo9rB7eLczV096LvEr1L0CDWJyn7toL/l4rNWsJ0cScN2KWf+bsuwPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Aelrz5J3Vat6t1CL0ouq0HgMS/9ruVM7d0lN2WCdDcFWeF2y
	vJB5Hq2k40b9jOjioLGRaRbJ5ZzEXtI3HevRHr+uak/k1Rmkw9PPOgRLHGThmEk=
X-Google-Smtp-Source: AGHT+IGcKLBGhPChakVileqX8c+Uvu5bTSyx9WN/j0Z86QZwqy72MEiAUASNL/d2y51b+uW3cGQH+Q==
X-Received: by 2002:a05:6000:2a2:b0:378:955f:d47d with SMTP id ffacd0b85a97d-381f1822854mr935921f8f.11.1731064436787;
        Fri, 08 Nov 2024 03:13:56 -0800 (PST)
Received: from [172.16.24.83] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bb8c3b15sm172055e9.2.2024.11.08.03.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 03:13:55 -0800 (PST)
Message-ID: <6ee09986-054a-4a84-a0f1-6b6424135182@linaro.org>
Date: Fri, 8 Nov 2024 12:13:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: ocelot-serdes: Fix IS_ERR() vs NULL bug in
 serdes_probe()
To: Jinjie Ruan <ruanjinjie@huawei.com>, vkoul@kernel.org, kishon@kernel.org,
 florian.fainelli@broadcom.com, colin.foster@in-advantage.com,
 davem@davemloft.net, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241101061145.2282501-1-ruanjinjie@huawei.com>
 <ee6521c6-9038-ab16-0773-c9425aae54fd@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ee6521c6-9038-ab16-0773-c9425aae54fd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2024 02:27, Jinjie Ruan wrote:
> Gentle ping.
> 
> On 2024/11/1 14:11, Jinjie Ruan wrote:

After seven days? Really? Limit is two weeks but anyway better relax,
and help out by reviewing other patches on the mailing lists in order to
relieve the burden of maintainers and move your patches higher up the list.

Best regards,
Krzysztof


