Return-Path: <linux-kernel+bounces-372003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1489A4327
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527741F243AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D3201101;
	Fri, 18 Oct 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWaXebQs"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54D133987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267359; cv=none; b=ttljRIchF9SctJs0Ul762xxNEcAG2eIWfqZcNhDBENVi6nkRzDX7DFB+LAzgnrtxlbcM3TOVr83hjmWMXTjh0/bgS6YBjwPA3ShUUIOn1dlk2OMg83dOp/3QRYKvccmH9di4DsNi8zE3CFlFricC1Mg/uDZlSZEwY/RqfT6fM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267359; c=relaxed/simple;
	bh=Wge7ZEOCQ2IkTBi/6WCTmTeRk0hxyerDO50wi64lZlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RALJ11JDmb3rGhmLC+NMdMzgl3hlfpDmzCgJiJHwE4BYckevujzig/kOGG9MjBS/vg22oJuZA5ItDBc+aL0QKPo5U0S0G0t9NGXLdnvdJtka8XHPt73JIb7NHaJV7zkIXHIfrVnL/pYaL743W4WJoOsbaw4jyy29XD5iuR+nw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWaXebQs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c452180so23111095e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729267355; x=1729872155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nd17O4fpO5j20mo2wH2yb2B43nMIbfwJaafaQQs4iII=;
        b=XWaXebQs1k6KrTdnPLo1MMiNiojU47Q/T7EdRn/lSPzm7N3WSsY4ERmNDHrgMRQxBT
         VzJ/VkNvbGSLrEyjKg0bzi/vW6co4eNAMaUsisWhHR7OjB4R2Vj1vlYasB9JULCIYNcz
         iYIaCosJogfkMa2yEN6oGs4AvtElZPBOwTyldCJxMjlUGwFq2A6vqEotwAhJYUidWBgR
         VoKogI29nfoW45qBUa+13OELjO8uUU8zLV0zcAWccSJrpIBE2UqbTxikPxukwUeB43Qe
         sLKfUhUQ+f3KPURosA37LJILxNzbxywU5Yogx0Gxhmd4T8EYhQlwhxRsNaUqiWBXfXhJ
         WC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267355; x=1729872155;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd17O4fpO5j20mo2wH2yb2B43nMIbfwJaafaQQs4iII=;
        b=ijhIogwnhFIQVY4Chb/GvCgsW18M2id0ElfMtoO8Y+w7wbt5yIMgH4cpuq/CjthDjB
         xdMYfqz7REM0j/8ll+M4VOn2a8QHnpoNGTAHl/iFByjGcFop12hOMTA0dlBixtYzvVBH
         lxWqsKEIYgRyBGRRnyc5DsV5iUeAesvNrZE6MA+tmZejX8LqHZyvR138GoqCJENwK2ad
         um4it1qr26ZWKiCy7olTga2GuJbaF5br80QWr8pLWvD0Hh0HD+iMnDV62IXHyllrtffi
         JCc730mJtgHLBCU9Z7/oYs76+NCAK8itZ7mggF0TG1bKxbclIc+nBWqe7vXYdVKw0kO5
         iE3w==
X-Forwarded-Encrypted: i=1; AJvYcCXRmvJZ25QFJ4GFMwOrkNDdzMi3G9EXGc2L2flKpfYmN/tNUdIU+wOMcdtJf83UQVxv5kUx+72YZAVTxzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0y//xKsnRBdB2TlgR8+xb2gh6XepY4YOu7LToLKhfOvh6vdGP
	3ULp/aKhDTXdcBNHsXsEOo00APePxCXsWnOvalxhYnSCfvwGUOHjaZxYCg6VQGc=
X-Google-Smtp-Source: AGHT+IFmVVvmsQuZ4sFOjMH5I6+9IlVji1a5uYYQsKyQxE2A2myJSfSOVJxFraPEB7Mb0dKt43wMGQ==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr2195252f8f.29.1729267355456;
        Fri, 18 Oct 2024 09:02:35 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.66.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027bd3sm2280257f8f.22.2024.10.18.09.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:02:35 -0700 (PDT)
Message-ID: <1520b33d-b490-468f-8759-f6b39653401d@linaro.org>
Date: Fri, 18 Oct 2024 17:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To: Zhen Lei <thunder.leizhen@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20241018140858.711-1-thunder.leizhen@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241018140858.711-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/10/2024 3:08 pm, Zhen Lei wrote:
> Function devm_kzalloc() returns NULL instead of ERR_PTR() when it fails.
> The IS_ERR() test in the return value check should be replaced with NULL
> test.
> 
> Fixes: 39744738a67d ("coresight: trbe: Allocate platform data per device")
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")

I don't think the code that this patches exists in 3fbf7f011f24, but it 
looks ok for 39744738a67d.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 96a32b213669940..93fe9860acf16bd 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1266,7 +1266,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   	 * into the device for that purpose.
>   	 */
>   	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> -	if (IS_ERR(desc.pdata))
> +	if (!desc.pdata)
>   		goto cpu_clear;
>   
>   	desc.type = CORESIGHT_DEV_TYPE_SINK;


Reviewed-by: James Clark <james.clark@linaro.org>



