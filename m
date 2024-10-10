Return-Path: <linux-kernel+bounces-358284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A166A997C98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC21F22A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37C19DFAB;
	Thu, 10 Oct 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6UEIkZm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17019178372
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539109; cv=none; b=mpaKPHYetAf+bWJh4kQojsHT0RC+oTsdXQT87BRRcfwVAkmTfYSHqayBZ1vjmWDtiqe0p7hs2wzxnnbDdQdBhAUCaJpBlwLT9EmOFc+beMO615FJXWBWqyOoMLjLYth8HDrHHoSwNm8k6WgIuhgR3C47BIl6ODz2fycLTTuIjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539109; c=relaxed/simple;
	bh=4voK2BG7ZlRsehGcdrLuR9bp2FiZUiWWe+faR72xa0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfLANRIFsJiOeFqRNkrtZgh250fSJ9wrmmWT6seJkHxGuk31Keb9KZg0lr/dRMFwiZrnxW5rDGbxwZ/+4fCsJxjIwFrQX7gIipqFEH7bEPHcjSENVTsD1ygCb2UiQOzmA+NFH5zGCFbmvx6zUihAGbk7tFOs/3afI6ukRNhEcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6UEIkZm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-430549e65a4so845375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728539106; x=1729143906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2cSgPSBQfx6w1lc+UXgsUVeVE3xnb6EO5Xgsdr6UaM=;
        b=j6UEIkZme89d5IWUwoFQUVJvpsCXMePOUZpWiCLvVFgNt5xa8G7e1LeWhliVpPSmzj
         ZcJHQT1Mm0N8daOX+9YqxZkhArnR+/2vk0CGJ2Jnrs7/asICGg+mJGW9sxvSUJ2MlsfO
         VJ8a2AmhYsmYCa1zrxhIEv4z4wjtJYb1LGol/pnrfIu2hgXihaLwEwGQiU4blAJ01M88
         VaexsY8x1BFvmb1Msn+Of9xt9a087e32KEFz6Jc/Wnj7U2QMLgXr/eBFyJ5jCPRO6pnF
         meFh0flC0sED8jZYpT1Gz0hXDxgoK67VdYdz6j3toctyYKkv2nqr7H2lzt1JicTMUyyr
         PD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728539106; x=1729143906;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2cSgPSBQfx6w1lc+UXgsUVeVE3xnb6EO5Xgsdr6UaM=;
        b=RsZYYXFwgLf+X+5ZQLZ3ds8CZUUR2EPgMuLC1LbzX/nC3XFoTTRZBKJG2k5di5mJ6C
         eJ5fMtG4XcEs3KNUoB3VQFWVCLkAfC58s7qoT7n7hIxLLh046YAdi/hLqHC6G1VWYEMn
         m6aihqZZScJaG4HL0rgay9pLbKbrWG6mweHrGcH8yYEIBgujXvP1jRrIoB8qxuyp80S0
         Hb7415/fzHn0YgJaPVqQJCBjU9r/IVl89RuqBM+uemyH8vg3/sZcGp3962FCY5OTGDl/
         kxqs4necl/cXWIIhLuJ+WtLzXgT+JxsAguyUYZrY+BlVYWF+ArHpK4OOJgSyi3iPF1vJ
         Fs1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwuQN0EtTMT9qJzr5wxoPV8QjUQZ3cCHhTChQBGxg0IPOexvp3iNkv4sHneZ0LsHEu3RiYCDnZIywBuDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSEmJJrxn9FcyfUDVRXkRWWeqMmiryZilo2ccpgG0hxA4RigR
	p/rbO/R7dfetZBItVTiRtUYDWT1TNSq7axva96OdP2YVKQK0h0NiawUj2oJnK05uTgZEGjef+6G
	+
X-Google-Smtp-Source: AGHT+IHq1jQw5Kx6C09T3KDtI8DfF4cOfd+/VPc/tvZXIa51gDxIpRP9wrbFqiGAQW3KOwUIGLxiFQ==
X-Received: by 2002:a05:600c:4f14:b0:42c:aeee:d8ee with SMTP id 5b1f17b1804b1-430d7491a5emr19117045e9.8.1728539106426;
        Wed, 09 Oct 2024 22:45:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183565b9sm5200995e9.29.2024.10.09.22.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 22:45:05 -0700 (PDT)
Message-ID: <638a44fc-c693-4270-8643-7cd75a3c6ba6@linaro.org>
Date: Thu, 10 Oct 2024 07:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable WCD937x driver as module
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 quic_rohkumar@quicinc.com, kernel@quicinc.com, srinivas.kandagatla@linaro.org
References: <20241010052646.2597418-1-quic_mohs@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241010052646.2597418-1-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2024 07:26, Mohammad Rafi Shaik wrote:
> Enable Qualcomm WCD937x codec driver as modules
> since it is now used on the QCM6490 platform.

QCM6490 is an SoC. Which company? That's a shared defconfig, you must be
here specific for which product you are making it.

Which upstream board uses it? Name it (fully) here as well. We add
things to defconfig for the boards, not for the SoCs. You cannot boot an
SoC.

> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Reviewed-by: Rohit Kumar <quic_rohkumar@quicinc.com>

No one will pick it up... You must Cc your SoC maintainers and mailing
lists, so they will see it and have in their queue/Patchwork.

Run get_maintainers on the SoC you are interested in.

Best regards,
Krzysztof


