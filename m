Return-Path: <linux-kernel+bounces-318349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67496EC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797561F2346A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF71552ED;
	Fri,  6 Sep 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB0wo8oG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CA14AD3A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608342; cv=none; b=M8XOQxfGrogyd2s1r/FCRuwmQagzkZJJm9Mx1yM75If/EhamnYhhgpow/PRBN4QoMnM+JgSdZh1BOKnRnrS+8nMVMNumcbOt/81Oh6afBKGcy1f9xjEuq/VZtipLjy0i++k4++yjEfHsl3XFe6cQ0yxOz22eN0SZtT18yKBEubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608342; c=relaxed/simple;
	bh=/VfN5TZBKFESX0ktdJnLpkP+3s1XJrbvW7+e2JjstSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ5h8++mAUtwdrQkNaZlMULbYpQS8KGEio2z/dVCsMXkePXrJw4F5wGtrRaRBzHzkdedXbm2iJcRag1WuQvkMs8Qc7eCHhMXgWmjGXfanH0jGVqwLW9w4AjZWludGTLUm27ebJrh6oyj0bmqYsryFLLE9m4afiUsX11MdotFwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cB0wo8oG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c180d123so901020f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608339; x=1726213139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=cB0wo8oGQ4gkqzsJUvwKF2bKsP3JPyJcvK8bOlIjlrk+jEwF2DTaekiQ5x9nIxU/UZ
         HaCsFa7RX/okxuGsDJAAUa9wIbIqORlQfJwHEEqjhATDZFBZXnh4K0gjB8TM9nBNytTH
         Lpx4ZaujIBV1Y4PChxe/m+H3cnhkvFDulli0meNFfyNDTGKB6IYEnbfb+WZVDITwgwyf
         Mtg9oW5A2dL3K3TxhVhVOTy8lY0hnWAOlVabsmGFF1FagxFC2iQ5AdRCVdjFdzQ4DQI1
         aRafG/lG6ZWwZAaCW2b0/DfSRhZ0jDCKGlajtSZAp+/RjNDaPd4p0xjNgqps9c0zsTCp
         8UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608339; x=1726213139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=DylK7oETD/IoSULwZ+233TuCtbbWPFNtmGexgs8AO604RIko2fVfTj+uv3i14+imxQ
         i6IWHcXvjCoBptdCoWcFAswlGsgUcd9G7d/9bpoOskLHNTsBQUflchVVgvX+RVgivU/K
         pycMul8j8PjJMukkH0N64/lINovvKF1UsyxRW/HaCZIZvGVdf/shGHVAMR2tgq/DpZG/
         k+kiTG0EIQY3mSsK4HOa4LSbyZBZSVz6+D5GiA35Rkp2CpBLQflW/VNowKUWJJWtWoxA
         r0swyB5l8XIb628zvHbtre9ZsobiuvlCTv+5b190WE0e29I82wAFz8LI+0kWxgz9ROOB
         QRow==
X-Forwarded-Encrypted: i=1; AJvYcCUVXl8Cj26skAVuYw5zlwQMngaAHpnYqkShYQQRtwjxNWX6VPgybcR8Z9jtcQWmN2CuHR/g6Ct5YQsRKeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayQIRumwSgAYuL3dlgUaNxuKdZn8aE78iIwp8WAXB5y0wKUcy
	YNFndC4ZMdVYYolhGI6Th1to3GT5BBd2g3volFe1LMEkvO0LtyFeEu1oah4O7Hs=
X-Google-Smtp-Source: AGHT+IGFHwFQ99mHOKHLLsrCtuLnOv+VrrxaTcWgKFCATGwuZhLv7Zk5Z474pGF9RhYDinH0QTPZug==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr16000044f8f.22.1725608338871;
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21002351f8f.62.2024.09.06.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Message-ID: <64758ccf-7ad4-4490-b938-864ade9ae74c@linaro.org>
Date: Fri, 6 Sep 2024 09:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] dt-bindings: thermal: tsens: document support on
 SA8255p
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org,
 cristian.marussi@arm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 wim@linux-watchdog.org, linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 kernel@quicinc.com, quic_psodagud@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2024 00:02, Nikunj Kela wrote:
> Add compatible for sensors representing support on SA8255p.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

