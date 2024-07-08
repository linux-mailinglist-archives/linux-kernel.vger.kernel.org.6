Return-Path: <linux-kernel+bounces-244188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F251892A078
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F632895B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C478C6B;
	Mon,  8 Jul 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz0x9RTn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324C17721
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435600; cv=none; b=Q8GXot1WnxLsCoTEOds7K/hm5EU9OIlinnjMjas950w5pdMqj8ikflD3bW7pzwQ6lBMv6WSfkSZzGMZaX+wTA3AgKSNIA/aJO26q+8R7cvnJUJttZIwe0BlYWQHUlKRkpw7lsRalveQt0Oq1fNDkk18Iv+OKAFNKkQKqP0XWF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435600; c=relaxed/simple;
	bh=IGz0H0ejmbpuQYPOvUgeiC1fBrQQEFDPZp/NdopND0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3JPLFNpisT3FptuqL9umFZpjOC2k1FB9q6LLEMf8tEK4iKO46XhgC4FgAQjqdA78ogdRlv+IuE2g9qdNX6RWCiz2W4gIvL/jedZtHTrI3SFJYyL9VaV9tVD7nmwTf65uUprvgXpyOvTStO0Z5Vh6F7AIh0kdzJPSlRhVsKyGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rz0x9RTn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so8735565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720435596; x=1721040396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IVILljSb9x9qkP7jWklTsmAiZWD+eaDZZkSqNjXUOF0=;
        b=Rz0x9RTnD7mTCRPEQdPb/1ozB9u4lKY+HQ6taecK0lx+OKsJzC9bYOOG0vr3SM/Gxd
         WBq1a2JwViVYqX/AAdx4ZqBLAwBQmXbEIvXm0LUHbPcGqXu7k1lcLM0Xgu+JwSsqo/yO
         Z8XE9v1zA0WGp5YPmcKPM0a90vnALy0/f0SDnjDcRN67j77mjMCAhRyDddpTY/2Nf85A
         fUUCOPeorbJY+VS/3+emJ8WLXpYkGGwIBnxCIMOS57ynU1qW4yns+o6eaj/gz22/wN8P
         iIzw5SuAMFjmkwwGcU5jjgn7PHQRwVsvyoGMMHp+0G1Xu98uekIQhidMOqRil5yAo7aX
         M6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435596; x=1721040396;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVILljSb9x9qkP7jWklTsmAiZWD+eaDZZkSqNjXUOF0=;
        b=DJJB3JmoY5l9Q7hbXqhFUGyRmXMNb40j+aKeZFGrxzvskarEK95br+4zwhQ7hT4mAK
         oI4apx9UIbnqSBC8YY13wdUz6q27Sgn89eS5/yGAyGfIoGOq2gXBFSJoHvogNN4tC10O
         k6069Jrtri9eFthenBgTGabLj/LV2ywHj7MO2OtaU9uQygYrMTlKal9pw2LCQhklHcan
         uksrO/2Lt/Bev+gI6J5adkLLqt+HzR7yWrBBZJup3qcV1DQuJQud4lYP6nsjLKpamgI/
         5D5tXtwjTzOY64lTyS11ztccCpetkhRoo28ttQ+SeBbGD6oDW8RdMLgG4rz3GHUmoSDa
         vb/w==
X-Forwarded-Encrypted: i=1; AJvYcCVLtfBNJhO06kDtpyzKvyKpY+ywaqYbWj9eolllwD+MVP/aGF8POn8YO/YdHO0+jOPnM+WkxcPu4+F39OY6LahdOrYtO0duc/L9BLJB
X-Gm-Message-State: AOJu0Yy+2S+E8KXxsnl9Rsyzki8NbbM14prgj37WH0mbXm6LLKlE4MTA
	szCsCv3HQGFL9FqU5y6U4CEtw4H4lNA2R0M6KkJ0Ncda9pSlSr0+bO0EqNR9E7BY9msuUsX2VQp
	N
X-Google-Smtp-Source: AGHT+IHPD3sUGOjkgnjW7Se/uaST289CjzpIdzf+NHWpDnL0L7U3y/2m9im81/Zj8GzzJZwhHx4OWw==
X-Received: by 2002:a05:600c:6544:b0:426:629f:1550 with SMTP id 5b1f17b1804b1-426629f17a4mr30916805e9.9.1720435596095;
        Mon, 08 Jul 2024 03:46:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42659fc902csm110192695e9.5.2024.07.08.03.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:46:35 -0700 (PDT)
Message-ID: <1764670d-0248-46fd-b0ce-03bcbcd6977b@linaro.org>
Date: Mon, 8 Jul 2024 12:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
To: Benjamin Hahn <B.Hahn@phytec.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: upstream@lists.phytec.de, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 14:14, Benjamin Hahn wrote:
> Add a devicetree overlay to disable ethernet for boards where it is not
> populated.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v2:

That's some old kernel you are developing on, right?

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.
</form letter>

Best regards,
Krzysztof


