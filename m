Return-Path: <linux-kernel+bounces-388473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77B9B6027
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FE9B216A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574CA1E3770;
	Wed, 30 Oct 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgzygzOJ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9851E2016
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284332; cv=none; b=XB0fL6p7bAd29zZ62McN6q0WktskuxAguI2Yv9I7Lioy0UtitXlTAS27x/tGDCVYo+z0FwvxdAvQyeJhbKQAKjolLatFVN6nmTjmvC3zBUkIPMkjsbOCiMcrZsXrSgojyd4xruc3eH6nVldGTkppjPOu5pGI+anpRh39l+FkUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284332; c=relaxed/simple;
	bh=CU1cu24+i45K2ONyDBFElC17mZkV4BvGmiF2jOuAeeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVd8Bj+5OsSnSAG0LfUjDu7pa7sIxBXtzrIwxpmBXSVFkF6Y7kk1Irmg8OycsuuqFOdM/+FTrfI599hugHt7lVt69JpfG4AVWen90ogkM0kUBMPTxpE4A0Hy/N4C2joF2zn30IAmpuZSUZjUFruqPGNXY78LHLkn1v8KNUqv9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgzygzOJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so63941911fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730284329; x=1730889129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e62zABhJgu0xsmWlRUsEgJ/DIZADPy+MDY7G9xqvTM=;
        b=mgzygzOJcIWje4b2Bs50E75/j68lD9kPzL+Pqb3r17f5wXtsuBzZIC1ROZEeFONqRU
         39c30p1hqmGWer+wsufR0oQkX81CaEyUL5sEDXHp/WrhX33+T2XXm6EUfCzKq21WwJQb
         P27/JjoQEBZ6r+5pdbf2bH2jj/15J2nP+4WsLXwO5hOpvvEaEmi1vD5zeRFQEVr3sqdb
         CdF4PwQLuyAvBaLYH0Aqp4FBiO6SqWrtt6w6wg+k1lsP7p3uDjDR3JrT8fALD304kMOG
         W9MFs80PC2bdPPH0i/NBZGzqrhVJK0fQ6oWGK5ykWFYopkTYwV0+aeuYoBZq7zisM233
         NFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730284329; x=1730889129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e62zABhJgu0xsmWlRUsEgJ/DIZADPy+MDY7G9xqvTM=;
        b=mMQpYdD6UeiBCKsyrlt9LBVYSot7WoVsHww3RjFP9Ly6PI+aF3SPpP2jNWZ8JJhyUt
         QiuRyI/GJeKPwBmVIEkQDKvbIUlhpPP00fn3U5+M4hzn7oFhVqE9LIUKvZdxwYYnzP71
         nfts36QsW+yqKoL+vUtbi8v5ztDzqeGZJWCsmrM76dnIeAcVV12I9vfQuSePHxE8jrj8
         kvv9VYqLse9ffCZdGQiDByrLCdWoiZYjAYARztYtVfNgfb74x61UQWgrnvZ7rh0B5bkM
         INZ1IUueX4n48w2C7/4yK5MuU10KJ77EpYbJxDh8n2KAgjByIKGY1umxSoFli1vjK3iN
         0qnQ==
X-Forwarded-Encrypted: i=1; AJvYcCViKrNSVqw4T/dz4mIXBqbAGHpb1IsydsmV6mRYdK4W2VTLyNK4G+UWGCqfpWhlLtktVmG9CAtDqoBzu5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRI+rTHNm/JlfHBJvLPr9deFk1DLbN95l2oKHz22QH5XNviBh9
	cLJfCT7f9JMnRcdyYhtoIiUgfRi/ZSmrDCaqEvtQxYu82CG71vrfi+/nIWMj7uw=
X-Google-Smtp-Source: AGHT+IHN0Q+Mdq7fYa0Zn8cYYpDEzpyE0X1QlkitrR+30fjLy2hEruXPOPZRkaCk7IohqcOaFpkJEA==
X-Received: by 2002:a2e:bea5:0:b0:2fa:dcb6:fa7a with SMTP id 38308e7fff4ca-2fd0590bdc8mr13523571fa.11.1730284327314;
        Wed, 30 Oct 2024 03:32:07 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca747sm17059915e9.45.2024.10.30.03.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 03:32:06 -0700 (PDT)
Message-ID: <c553db69-6bb8-44f8-b571-21c631fcaee8@linaro.org>
Date: Wed, 30 Oct 2024 10:32:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] scsi: ufs: exynos: add gs101_ufs_drv_init() hook
 and enable WriteBooster
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-8-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-8-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> Factor out the common code into a new exynos_ufs_shareability() function
> and provide a dedicated gs101_drv_init() hook.
> 
> This allows us to enable WriteBooster capability (UFSHCD_CAP_WB_EN) in a
> way that doesn't effect other SoCs supported in this driver.
> 
> WriteBooster improves write speeds by enabling a pseudo SLC cache. Using
> the `fio seqwrite` test we can achieve speeds of 945MB/s with this feature
> enabled (until the cache is exhausted) before dropping back to ~260MB/s
> (which are the speeds we see without the WriteBooster feature enabled).
> 
> Assuming the UFSHCD_CAP_WB_EN capability is set by the host then
> WriteBooster can also be enabled and disabled via sysfs so it is possible
> for the system to only enable it when extra write performance is required.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

While reviewing this patch I noticed few cleanups can be made. I sent
them here:
https://lore.kernel.org/linux-scsi/20241030102715.3312308-1-tudor.ambarus@linaro.org/

Feel free to include them in your set if you're going to respin. Or not,
if you don't want to tie your head with cleanup patches. I can respin
them on top of yours later on.

