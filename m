Return-Path: <linux-kernel+bounces-534154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB0A4637A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A25189F2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294122370F;
	Wed, 26 Feb 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S64eu0v7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1A2236EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581226; cv=none; b=dwuJS4Wpu14aLXlo3bR+Nm5iKtjvrZluOoSuu4ZD0Ve3olhh6U7wBm8Wq2wppqAAAh2kdz+u3k+s3sr8v1Kj8TTlRQPTdwlhRv/KaW20obbixAZ2ppibp77DpN5fTvU36F/ynu5rsuXhyKi6YSgcIh7ck7/DfvmN+J9J59Oh4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581226; c=relaxed/simple;
	bh=m/XdZhhvS6FYiXUcwXOJ1LLkTXVWffO1oF02DIV7wEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZAGDO6UiS20MrkhN2VM3PuRc5XfcKMcD205HPGyeunYWz4H+uEJg9uX78UEU39YxQqdcUjn4GUJ5cAERk7IkuSgbc1D6mu6krOPjaqFwYnEDZOHYC7SIo4vJpbHL+St3KxCtJgK0Qmr+qRg1TtMsNKT+LtPVaTrOS+vCUT3Fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S64eu0v7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43998deed24so66131535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740581223; x=1741186023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pOyW28UvUKwTgBKlyrzwQ8HJbMn+0BIuk/+k9qJPJw=;
        b=S64eu0v7kcYJRl94NyQejbkOgpNvivDTCue5bJsmUbKgycmp10LRfYgw2JK0jIeSSR
         2HxeVGcDCrNiVEB8c1g1Y3HLuA4xnRL8LF8oLpzlopCa1RWX4wLlfvCtdZzJkjCr2PBM
         mt/Fu+3LJiR4x8/Ei7BDgZQE7nUNar9ULoklm11wS3Ruibktvj8Gyr1D3x5oVTGqooL0
         V0Bkg/OdQ2AOec5Tz6THR4ygE06twnjFcKpMbOt3mI6knb2Nzgk7w8+ogdmeM++L0OZH
         RfWidhzjrLo5xZyl/lII2rgRiBkASRlsQTllTBQcO43wUlD8ff/uqraX771hn1o+Xu+m
         7xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581223; x=1741186023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pOyW28UvUKwTgBKlyrzwQ8HJbMn+0BIuk/+k9qJPJw=;
        b=s8xdi/NyTN8vX+S45RqBrnX9FXs4fc1I0A5mKbwyaI/TRZLw1odRHjvdr9+p3yV4b9
         MP6OwmSGlO5HqSGHoPyuDC6wXg17zIKC/KGaNFOudcchz6vaTdLrNI5AGkCvX+FELDba
         MZiy8xoBTe6ZJuzKHwjqrQ5PmMGNucbI2vAEO9izEq+8bglGFojGfKl4SG9uj1nH0PXZ
         jXmmex3XiCypm7LGKU+nz06EOdvY7LlEtMT0uJp8jbokP1ImdI+oMQvoTA+Ps3OM83/O
         wfuQfQK7x2uk0P9hyEWtSJAMJ0JtoGhE8iiSdcE5+e9qskLoPlkN36SGQ5ROMnrEpoic
         Rshw==
X-Forwarded-Encrypted: i=1; AJvYcCXpbGVL3JqWg4qk/QBIW7sHpEx4xYAkRkIQfBfZ8Zs7JXxwQQ6xZZUbhu7I+hAm3srcXk8gNsruFqgbXX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0rNuwfnMrgjtk/4vv6QjPkbP/AQ0pObmq1lDgy3uFKM5fNxS
	jisNHzWmPzz0R0xl9fHUGCMKMR6wc1arjLCwAXC0qkPLTXdGeTV1+x9RnhQHr8U=
X-Gm-Gg: ASbGncsLBKNkt6LI1Hdhi16tnpnwdQ1Wl9k35FZCW/ivjh5fUaSozQ7TVAz2t/u7880
	Omj4Io03+PL2nt26RUGLgivS0us1fqnEhrc7w1AbxtLxgHBxb7gIhgdWyhmeO3tYkEn24hZlHtz
	l5mLveK3wQDBqt0NQ9SEy7kDCG9mvUvsbmCuMP91aQPmvBoaPLIVtwxH75cu6A3OWdc1Swfnztm
	8BTdeu9QMRewnONFu0ks665xFd0VDk/z63vqVgRJDYAn4y/gCH9h1BclEEoqVZSwt5T7dCf9Ec6
	6a9T2PhIXvtgQP9afNVeD+tw12tlLQdHWMfMENVTEZEYfZCZ4hcZDcJaoH+mksI4Erk=
X-Google-Smtp-Source: AGHT+IHNRfpULJPxhQY9HtJFoLDR0d9T57OoOlmyePOM9Y/l+ILE+lMCUBjbQM1hxPRcUu2S6ET/Lg==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38f70854e1amr17780733f8f.47.1740581223249;
        Wed, 26 Feb 2025 06:47:03 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbb5dsm5716850f8f.84.2025.02.26.06.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:47:02 -0800 (PST)
Message-ID: <eb06daf1-3cc3-4b31-a0bf-bc450cd0f041@linaro.org>
Date: Wed, 26 Feb 2025 14:47:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Some small preparations around CAMSS D-PHY / C-PHY
 support
To: Luca Weiss <luca.weiss@fairphone.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Barnabas Czeman <barnabas.czeman@mainlining.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, David Heidelberg <david@ixit.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <D82FU3SIX5RZ.1Y525GJO0UOAA@fairphone.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <D82FU3SIX5RZ.1Y525GJO0UOAA@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 14:13, Luca Weiss wrote:
> Hi all,
> 
> On Mon Dec 9, 2024 at 1:01 PM CET, Luca Weiss wrote:
>> Since the hardware blocks on the SoCs generally support both D-PHY and
>> C-PHY standards for camera, but the camss driver currently is only
>> supporting D-PHY, do some preparations in order to add C-PHY support at
>> some point.
>>
>> Make the dt bindings explicit that the hardware supports both (except
>> for MSM8916) but also add a check to the driver that errors out in case
>> a dt tries to use C-PHY since that's not supported yet.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Luca Weiss (2):
>>        media: dt-bindings: media: camss: Restrict bus-type property
>>        media: qcom: camss: Restrict endpoint bus-type to D-PHY
> 
> This series is still pending, both patches got reviews and no pending
> comments from what I can see.
> 
> Would be nice to get it in for 6.15.
> 
Yes this should be merged.

Thanks for following up.

---
bod

