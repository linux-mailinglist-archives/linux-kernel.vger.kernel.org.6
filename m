Return-Path: <linux-kernel+bounces-334339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A997D5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B061F22787
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA316C695;
	Fri, 20 Sep 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCAVcUxi"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4D166F00
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837162; cv=none; b=u7kS5iAa2K/QqYjSHOqgplfUyErEFF4z/T/yh1RNUihRcvv2c4uEZ7vsSb+3NhYZp6pLF+KVllDQ3nF+OqoTro7qg/S/FE8p9HTl+lzB4d/+X33RVXL20oFfKpZ/ETTk4Pu5b6DnYepeblXjL67+N0e3oRh5CVzikLVPSL/13+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837162; c=relaxed/simple;
	bh=7Hnn1zpKWTHy+QSIa9H8bCbOoQngQFoFIPK4roLpd/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5gqsESrvKfETIOxJTnNw870C87gh0xgsCoH2P+zCPXb+LbI4GeYvfoIx+5eYbPaxZZCF4JFdgAXRMPZ0svZ9e0rFarM4POalPPRDlBDJMKr7K3vk4dkuNLIy6q69lBQ29e8pG0RUetyU7tSbwCEvKV8piJ/PubKDwXmF3ivxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCAVcUxi; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-829f7911eecso94573039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726837160; x=1727441960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0hP89T635eug0SQzdhHFuUzTKbWOKYLiIcD5q3T0mM=;
        b=MCAVcUxikZCfmAXeVIb5iBJHuECg7CBM2mY1HurldzwwHyoTzxZN5sbeHdjKrRr9G3
         upaROjxnwrqotTJFarUBLvplxRRymj0E/vIOkuo9aD4zdGJl9U8RVCmwth9s79jlXord
         J8EMSyvhfDwcu06Jz65tBjxTAwyLk2t+7sNE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837160; x=1727441960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0hP89T635eug0SQzdhHFuUzTKbWOKYLiIcD5q3T0mM=;
        b=tiB2OGpuFOMhiR9KKGjgqJnGqMhljN+RZnt9ylb7H0hYJNR6+hwTzJfk0dnoMQTsSw
         c9zC4qxN+8vo2WEV4+YF+gc3IbD65vfPGjZst2qVIjp6/ivxNY5SihVBH9rUBWKwyNvt
         S/di0PLLCvY8Oo/eN4IaB+B8mBsQ+pQhYsaR8oPtXnX2k7cgEvXDCCdIUcC3BT9bQEbU
         r/N0dW9zV/dvAscUg+2LzTXZGuDqWc0/J3u9199b1VNv7V3iTFTuXU7uNaPtaP9MyRRO
         j8XjiEy4VHgxY68R5/1TxMbxoIS6dRK50K/jWtlvOXzq2hJ/rhrU/1M8dOWzON7XiLvs
         32HA==
X-Gm-Message-State: AOJu0YzbvzwiSQGQ5UEXulqV/C5Sc1JmPg6Y/3EEpeH5xdOjYDITlHCv
	UB4l7GLc9uorXNk92DhJmkmadIHHK0Ps71EyfKTzHVL32DTrTYyhU87aKCHIj30=
X-Google-Smtp-Source: AGHT+IGF6z+FwKs6Ow9z55WL2jKZTmbVonx4GKN4imUz/2x6f8q9f1nEgxtWtd14C01WEykOqTVEbQ==
X-Received: by 2002:a05:6602:341d:b0:82d:79b:ee8d with SMTP id ca18e2360f4ac-8320b2841femr233896639f.4.1726837159804;
        Fri, 20 Sep 2024 05:59:19 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d49338509sm382912439f.34.2024.09.20.05.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:59:19 -0700 (PDT)
Message-ID: <3d89dd5c-549e-4f40-8d5d-3ef71b1f58d8@linuxfoundation.org>
Date: Fri, 20 Sep 2024 06:59:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mempolicy: fix comments for better documentation
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anupnewsmail@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240914151801.4388-1-tanyaagarwal25699@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240914151801.4388-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/24 09:18, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> - Fix typo in mempolicy.h
> - Correct the number of allowed memory policy

You don't need to say 1/1 for a single patch.

Please write changelog in paragraph form. Also mention how you found
the problem and include putput from the tool to find the problem.

> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
>   include/linux/mempolicy.h | 2 +-
>   mm/mempolicy.c            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 1add16f21612..ce9885e0178a 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -47,7 +47,7 @@ struct mempolicy {
>   	atomic_t refcnt;
>   	unsigned short mode; 	/* See MPOL_* above */
>   	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
> -	nodemask_t nodes;	/* interleave/bind/perfer */
> +	nodemask_t nodes;	/* interleave/bind/preferred/etc */
>   	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
>   
>   	union {
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b858e22b259d..613fdb73c404 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -8,7 +8,7 @@
>    * NUMA policy allows the user to give hints in which node(s) memory should
>    * be allocated.
>    *
> - * Support four policies per VMA and per process:
> + * Support six policies per VMA and per process:
>    *
>    * The VMA policy has priority over the process policy for a page fault.
>    *

With these fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

