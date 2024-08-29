Return-Path: <linux-kernel+bounces-305987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC199637AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246941F22A60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076B1BC4E;
	Thu, 29 Aug 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="FdJMWzzn"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EBDDD9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894682; cv=none; b=Azm1b7iwbL85FrpX2+zSW7eHjSzBh6KXJr8uDZQK9A97TEJ6LBgrQUgOuOjTF3NVVYthTyC/CRTQOky8VumnDeA09iOv+Ypx6u0ivGHrAJ82rtlc6W/zz/Q5u62Mxw8XL4dXcTs4krHAo8O7pys3yl58+ErYofOwzKsf64v5VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894682; c=relaxed/simple;
	bh=XgeREWHRuiqTR+ZlXfIFi+cI7njGT6IJRiY7NdQKYHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLMk+aeedzKCzVR74G1Q84JXPVdGwVsa3XcJ+2V5SF6W6zv96TssgvU2hzlTA6CzZM0lUBXx6l1nwlvVMIB5rSd2wpoVwwu7dX5ws4rxQYfsTTVBG3fDZQKm2zKbO2HMCrSZcN+u353pIcAAc7Jo5Ih62pZbvf/9lCARe8aZ9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=FdJMWzzn; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8278b0ba494so6781539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1724894679; x=1725499479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4602eoQt/s+125QmPR7iwEJsjffvNIMKQir7NGd7id8=;
        b=FdJMWzznLndMCOy6I6FSpDWHZYaAxcmjz0McAvV6iSmsR5RfSEqEzbPEii5P7QP9Ag
         L9I7oO6hRmtKRSNvE+KnUxxybdtwtaEFO+Q35TMo+hdJG2A5JHnON0iDDpn1nvB1DQRM
         HEb0HN+noZ6g0hoozoihqFoHHFanxGKVIQ/YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894679; x=1725499479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4602eoQt/s+125QmPR7iwEJsjffvNIMKQir7NGd7id8=;
        b=M6i76jU3+Mu6HUpw6/BE1mrz+h9ytGkE4DIrre3RqLWSunxIAElHWrGCwq+JXTFq71
         Fuf8+jzjL5plyiyUw+amitR9zQcchU30L8kT3lKZ/UT0aRd8MWf0d37npach60KN/z9J
         bYTYnWULKe5LS5F9U/T5uU74ivED7rjGxR+RtfQKlk4IEnUU84eLtqqD0olmN5Uup8Jm
         ExWz/8k0PRO0SUq1KF4LYI20atZ6Mu12HCbULxTvGUoONYzwaor1RDJCWyq79oQPia1a
         6OehbnrjUZVYHEQGeKhLnF7aYdUvtT2FpkWXJvS6y6W6MqyznPNp2XPjK9zCrqaZSTx2
         hEfg==
X-Forwarded-Encrypted: i=1; AJvYcCWWIt/uEW9tMcrilrstvwvNAiHx0uE1PmA86H2NHnrwqfS3sc5SEm2az+C7dPIIM01DibLu2ekbD5m/TTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBmE89bJyghlDn0ioyDeamvBW/YwYS/9gxmCulNpLGDEmODT9
	NrIQ1d4n5SxYiyWXdv5FqZRjRGLxdyq9qQbiu7yzJPWh6o5TydcKuSKaNLRtFg==
X-Google-Smtp-Source: AGHT+IGDy79LRhQxFBS4gO7+Dae7DlrtxwUBZUldOvFlPjvgUWzBlgBeP0c/8/PJnP6RLMziWT1HEA==
X-Received: by 2002:a05:6602:1483:b0:825:2f0:9f74 with SMTP id ca18e2360f4ac-82a1108d3acmr162421839f.16.1724894679000;
        Wed, 28 Aug 2024 18:24:39 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-82a1a498a75sm4122739f.42.2024.08.28.18.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 18:24:38 -0700 (PDT)
Message-ID: <cc975da7-c2cc-4ed1-8931-0260c0023145@ieee.org>
Date: Wed, 28 Aug 2024 20:24:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
To: Yuesong Li <liyuesong@vivo.com>, elder@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240828084115.967960-1-liyuesong@vivo.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240828084115.967960-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 3:41 AM, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>   drivers/net/ipa/ipa_power.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
> index 65fd14da0f86..248bcc0b661e 100644
> --- a/drivers/net/ipa/ipa_power.c
> +++ b/drivers/net/ipa/ipa_power.c
> @@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
>   
>   	clk = clk_get(dev, "core");
>   	if (IS_ERR(clk)) {
> -		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
> -
> -		return ERR_CAST(clk);
> +		return dev_err_cast_probe(dev, clk,
> +				"error getting core clock\n");

This looks to me like a simple replacement with equivalent code.

Reviewed-by: Alex Elder <elder@kernel.org>


>   	}
>   
>   	ret = clk_set_rate(clk, data->core_clock_rate);


