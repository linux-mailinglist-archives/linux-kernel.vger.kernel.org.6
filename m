Return-Path: <linux-kernel+bounces-563954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB1A64B16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB9C3BA3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BB2356A8;
	Mon, 17 Mar 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RteWM9GS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA0EED6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208531; cv=none; b=WfQpBZQmSNiWoDjY9Pixzr1wOi8eD3KcA5diBYu7oN9RxDyLUuun4SNNLMnltAWZbJjX3ZPY1PqXHDNBhNX+X0YLIGKX5iBEaLJxDn+RDFgkmDdrx+VeSOgwDXxCfD38BlI19HdRO8m7nW4MrBImp4CWq4XydvM1a2T+8L+Sq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208531; c=relaxed/simple;
	bh=p75LrdmcmOCqHM4SAzLua2uSyJuWodBI95URCCVuJys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SOwxowIO0OyIFI2rnzsOhNdafxNAD2+ycuOA0dXlXlV414ldsjx8vERlfG9DQocXzdopiTDrUeWBlTZjpXhfwWHzBJyhEkjmGLn1X6gL98D+T425Dy4eMY4QUy5//3fsfAX+zokSY4p2/bRYdHuVAz6VOi5uhlqH1bYw+WRcJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RteWM9GS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso12386185e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208527; x=1742813327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eycY61Wk6wfvZBg4chYuMAQviSFft2VvOnLfN3NdZe0=;
        b=RteWM9GSXmh66sH+f4L8W7ou2imnpeAJAp9zhYl53WO+NYMq1AdTy0nZmyD5+8iwcx
         ov/c2f5iyfNBVU2g0Lm1mn6YjeJNMg+TGT5x/hN0ta8pMjWwVlHhajRrPw+wiOngx61+
         I+hGykruscc68XCUKTbE4gHg8ABFORxzjBbu+SUkpbVGWtEdLj3oer7u8zK/wMRBwEu9
         vjzQk+eKsSe02rH+YekUtCjf8hTJh0Q96vLR4ypyFBc5FboYrUNYYvWB6U6QLFTas3mN
         rtYWKsLL8mnkPZcCIEAMODKLBM1jTWQ09HvtzGfEsuXPLaTqXJzyimAkXM5+3+BgK92x
         WhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208527; x=1742813327;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eycY61Wk6wfvZBg4chYuMAQviSFft2VvOnLfN3NdZe0=;
        b=Rx6nsH1i3loCRRBE3p0lV1mrX2VFgIcNRR27X5FVyOufWZssSi2xfpsJ63ykfs7tWn
         DxdU9oTJwYpCaNziMoClV8Z/Elwzn18g1W33qBJbNCZSb3wu/IKTM1qa0Q39QypPkxLo
         yJAyVCQ4IpaY/tvN40iki13A+z0w1A4nD58CBwijVEBrVG0w6n5KG5fLU6RCVetRRTMS
         ORcAmEE7NrVGWncsEMC3fAvxGzii9jjgrZ8b9HvbfedFB2t2IHn9FjO/WT3ka/4gZ2yR
         Z4usxu/z/WD4oAZJ+ChlxAoUCaHoY+PHT0eZGAB4rutTiUdsLm6lS0mpuZ30wjuxRyA3
         ZR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkC7boo2xqI9IlwAYR/v1Brh7EkWa4nCPAKhfM7d4VEu0qXSudDQaPwvriEsjURa2PRZN08r3dKs2kUcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBsO+r3hpdv4oZZ902TkKuYAycYWpOaTNeLJvP4m49M5FYynw
	0a6kDDhOtwtc7m3RuFz4pnHojGJNicvDKAo/XMzAz5pAD75CzJoxph7U7xTbkps=
X-Gm-Gg: ASbGnctibqT3TNJvWNaaiu8yW04xr9ugAXAI7BTP6Aq9jYV9j49lBfAEPV5/jI0SB1x
	GlRRX/7qTse6PUEDLIyhIgQ6KPu/ItipTjWA+F8UC+to+NZ0gTTKG1YZHiVSTNUHls/xkn0ie5A
	TI+DHKr6YmshTz37qrGwnHi9p6xzqTUpmtzZ4lGjusoW22mw+Ya96+52qr5HSetd78nJ2m+UXBu
	2gvNJvmGhyPQfzR2zLxwuC9d1vGcHQGU6YR+gm3leYaAcdpCskAXzNdAL+3nhRjZyn+QNkKZbDb
	q2uK3NnKwaAXun4KexbjvZ+vZ10CYGktDDZ7paPqW0NZD+UBbuEMq4uVIc16SebatMGKA9N2usS
	CZh681M1iuSKVKcgYbw0=
X-Google-Smtp-Source: AGHT+IHwbJoYZqGiwb6co2hREAgWTQOaf/s4YEZo96aCVG79kC6hdFtxQajN7lHob6EAvFbTP7K5bA==
X-Received: by 2002:a05:600c:3592:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43d1ec86200mr141007775e9.14.1742208527614;
        Mon, 17 Mar 2025 03:48:47 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:900a:ff00:eb98:2c37:6a77:39? ([2a02:2f04:900a:ff00:eb98:2c37:6a77:39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609a2sm100628115e9.30.2025.03.17.03.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:48:46 -0700 (PDT)
Message-ID: <d2e162cd-b12b-47e2-9190-2ecce3489b9c@linaro.org>
Date: Mon, 17 Mar 2025 10:48:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: exynos-acpm: silence EPROBE_DEFER error on
 boot
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
 <20250314-acpm-fixes-v1-2-ab03ca8e723f@linaro.org>
 <638cf070-9fd1-416e-8172-75f189ab0dfe@linaro.org>
Content-Language: en-US
In-Reply-To: <638cf070-9fd1-416e-8172-75f189ab0dfe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/17/25 10:26 AM, Tudor Ambarus wrote:
> 
> 
> On 3/14/25 4:40 PM, André Draszik wrote:
>> This driver emits error messages when client drivers are trying to get
>> an interface handle to this driver here before this driver has
>> completed _probe().
>>
>> Given this driver returns -EPROBE_DEFER in that case, this is not an
>> error and shouldn't be emitted to the log, so just remove them.
>>
>> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

I see you kept the error message though for of_find_device_by_node()
failure. You either get rid of that too, or maybe transform all to dev_dbg?

