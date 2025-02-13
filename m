Return-Path: <linux-kernel+bounces-512884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496EA33ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C98188E1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813921D3EE;
	Thu, 13 Feb 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKp9ULP8"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D209227EBE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448530; cv=none; b=EKAFx5L9z/NaaQV/r0xfXFTUqSUYn4QcAub+dFf20zccnvdiXIfWs0uMg3H65UV/D4veWij0/+jFTqK6WhvuqaYKdfGa/Id/QE0mMNdOlnlOJOlVro/01acR/SpY9lThkflL7ykOKMDTKvGMj8a/Cs9FnYtxgyNcVqeYaoRHFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448530; c=relaxed/simple;
	bh=1E2id50uaFPfC7LT/+pAYwSJ84qVWP+x2iiRvyauSDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwZcaNqWxjnsgsSWyqtXDP39R9cNmGQh8yFHvz7m4su7k8X2LjcPVUF29HKJX7vHPyI6Cfr7Qv6zTJRVLxh0AwrzzRNSa/WbTfX/bA8kbblpijybrYyHdlS1LLyh29NTsUIxVgYI51uNOCWHEqcAx35gd4bOLKgCA8w/yuNFEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKp9ULP8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-308ea905387so442491fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739448526; x=1740053326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+OUyVkZpcEX7ghjnK0CsopW32NOBTOfeekkc+Viasc=;
        b=WKp9ULP89WDPKUsTpyJzGvK1xorCJ5aQLPg5iVZof3/os25yndzFGVrd3dOc9WUG8u
         3JuOPlaHYdxMEfOAJA9JB2JDz/AdbJgTzpK4Cn8KgK4uzludgrvWsj2OB3MFfV7uPY14
         pAaumR1pW292Ikb4AYgXxpzr0AtkFyWiChT1Dax1dyNog4lazOzQOYTB4gIIXhoHUidO
         SNGa1qUJvz37cMevPaxBM7q9W78IqD/nbeKSWi3qGwA8J8e9WhDp0TNndl23wO1xELaP
         /JCi2ezOyU9Pa5fXAx0E8VCFvzjf2Odi1F+JNDdc3ZaMxRz4yE+84LpOTcuIAumDFJXN
         kIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448526; x=1740053326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+OUyVkZpcEX7ghjnK0CsopW32NOBTOfeekkc+Viasc=;
        b=DoPQ1lmlDGGoG7k6ziEgVT1x31D5Ah36UaPjde0P++NsCUrkZkRaps+ZfydXtPqJoO
         2pqGlayh3h6IYes3iycu36sef56kt/F+ocnxNnZ8GU0SQD6ZhA57RF0pO5bxO5V/d+Hk
         aulnO4JT5rE/0GGC4qHnDo9hF2G+GknFGYxcyEX0xLZy+wOSvjb84zByOUu3XHxm88jJ
         UU36WLOHSWhfmca1NmipbYVnZDOG6rLqQJZHsUfB1mjDIAsknW+Ps1BqG4P59TxKNiOq
         8aqawau+ER3ZDCiQXEdoNJYHBKXte45RIlzQAGuyg9dJh8oeFnWOqEgfYGyAHjMea9Q+
         704A==
X-Forwarded-Encrypted: i=1; AJvYcCVvKL+H1xRBWze5B//UFKIXiI1GC1HFoPVL7NYQ1YfILMAoS3UJ72KN1rUBOYlZlPGXe8LcxBBTexunNzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSHwy/gfktzT+dL7YJTv59MFV9w+NtIklIyr5jRCeITRBDwCF
	q5T9wpIpVeMyhHiTpsAknF3IAaOaREJr5/uLyG9ji+Ru/oLOqICWybBedybiquw=
X-Gm-Gg: ASbGncsHjg/m3Frxry5QlLpztAURfmJJ4KIVNhv/BARKKtLSAbVnQbvNXzP1lXACHDL
	tN89TIFenSM4Swdltjdj3K52tGIg4RGrvW/fXuFSIif+6mHzGYE7WzksWOkBl4uSJV/BQSZC9jT
	iPeiUUiVA83g65WwpCgW93+wQahd+Qkz1TcjxOWdhSl8JGnIX2ybr3HITQ60WARjNtdnL5VHiHc
	uEtniEIy1mEJu39DCBLHP2Hu7SbJOr/VwxpvzTyNcbwrpDD36sMeXG9uufdCtjCeWlqC1rcKCxu
	WFqFO6AxeDC5aAUFZ3jFBin9sZYJwZe7F90s1AvK0EAU5rO/S1Jhd4q6EfifxwJoqFI2/A==
X-Google-Smtp-Source: AGHT+IGsPJrOcFQQnf+A25Wzl5ciCuJH/GUL3mTZ6Ip2nmGrIOQr357sCNfSXwJhOsr7Fk7zmP7O7w==
X-Received: by 2002:a05:651c:a0a:b0:308:ed4d:629e with SMTP id 38308e7fff4ca-309036d922fmr8815131fa.5.1739448526360;
        Thu, 13 Feb 2025 04:08:46 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f115ccbsm147666e87.210.2025.02.13.04.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 04:08:45 -0800 (PST)
Message-ID: <da37555d-b471-4f3a-94ea-4809fd184dee@linaro.org>
Date: Thu, 13 Feb 2025 14:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: Unexport i2c_of_match_device()
Content-Language: ru-RU
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
References: <20250213114613.2646933-1-andriy.shevchenko@linux.intel.com>
 <20250213114613.2646933-3-andriy.shevchenko@linux.intel.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250213114613.2646933-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/25 13:45, Andy Shevchenko wrote:
> i2c_of_match_device() is not used anymore outside of I²C framework,
> unexport it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

