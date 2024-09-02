Return-Path: <linux-kernel+bounces-311205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D39685F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC04E1F220C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940D184551;
	Mon,  2 Sep 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBHNaLk6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CB140E3C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275700; cv=none; b=WEJyXThKmoLfbDF2ygCGZnwWcPpef8H+9bsp2f1z3xHJQkxpOd0Kc4gRuv535e3ZtO6+rD/srwztUIEhz0Lmy+/sVZiG7W2Z4CUcoGGAXNuaMcfaQPocQud1QZGkx34jrXLOa/LirVMJh9DhyzGaaS7pDpQVWEkIavbx2q/qLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275700; c=relaxed/simple;
	bh=BwB7EJqrguz3OW/W0gMuXAL7awu3Vv5nG3F/7m+Lho8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0rdXgKZXDwthUdsaO42ES3RumvqZZyBHgga0YttNn7a7gBacCRI2Np3S3ULUsGuvIzRB32DoyFheynELdhVhXqyjIw4GRypfSIXx8P7UeVhC1BqSkYBbyohUrkT7LcR6eKNAIL2zsiHn0NsU9sjknYaPoIzp/vw+F/Hl+6bc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBHNaLk6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374ca7a10d4so521419f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275697; x=1725880497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dL64J3/4J/U2Is2oHltSDzO0dbgcPsVdgpAb39i+MU=;
        b=NBHNaLk66LCXScRPlkCmORo/RHleKLywFwT+vZLcyimgEwrQzxNI1ku0dWEmogejaz
         ixaEE8cjefU8umAaMKG0gt915101Jlqc4cm9mjX1LrFe7askzXvjVsOh8eTiWVEkCmWW
         puzBG5mNXByJR7m1WidKvEVtYl13Vb1ugU5PHJ4lyhsGll+RD1YVds1zKPfNDuwvoqMg
         ofiYAI87XlDRrQ7M1tuCsdj3C/sO1xmWuwrTI8esqs56KOimS8FgUuhmYbD0UEOcf9HR
         i3od7KMQl6t8TYNn2H2mOLZS9q/EIQXItDDDD2DPXsTMSCyFMtr4CwmF9Nr9rBPKDo/o
         e99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275697; x=1725880497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dL64J3/4J/U2Is2oHltSDzO0dbgcPsVdgpAb39i+MU=;
        b=hAFfwFspkjVhH9dIpAHdZX8v+F+/NSMfm1DhQdjNfmtXFfp2jf+ebgl1wuPqXMqTCB
         NzKqjvkUIj9RX6KSV3R/7gNbSNRyRann/Ge0nRtAptPJFZmQIIUITZbcFEbAWPoLbfos
         wIwD6J/PTiNIUVHfHYOO815yP51fBbiV2Jr59DiKC9L6kbwe6DRLKO9eLoJIt6NGvub7
         RBuGe6vkfvtGpqU9BXNo+ER3Y23Km28jZwUcB+7FpT4S4WcX+PGVDtLSHZB1MmSAM0ft
         +hoQhn3ryasVtElB3wMUS8qm4C9qJBaDAaxOkcpllzCydL7NouqjgdE6KOKr9Bgq9Fr9
         n2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjotzj7dfa+GYzgkVqDqDRunknY+8W5S7fDsWnKPxMV4UtVtMdYt3mEaRq/RKu1ZouHx5MT3MC6/osKYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmxQzR4DiyNaErJoT6qU2qLVzE1pofNGUjmndRGWyA+MC6wN/
	mrBD/KDCgd2DDC9AtDt/SdEjCRqL5CWhcZNY0lkwCPi/E3IFoLTrNPMRG03GVpNU7fZuZNTwPWt
	0
X-Google-Smtp-Source: AGHT+IEOw/rLbV89LRpF/tcrYR5VbN5Zxq/Z90HtFp7vG8AmUo+4reN5RoDLT34Y5rJ7B0KP4P7TNQ==
X-Received: by 2002:a05:6000:402a:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-3749b5497edmr13173204f8f.22.1725275696292;
        Mon, 02 Sep 2024 04:14:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374c90c6c06sm3388725f8f.84.2024.09.02.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:14:55 -0700 (PDT)
Message-ID: <c63ac4eb-14eb-40de-84f8-09768d6293b3@linaro.org>
Date: Mon, 2 Sep 2024 13:14:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820094450.101976-1-link@vivo.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240820094450.101976-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2024 11:44, Huan Yang wrote:
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

