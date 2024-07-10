Return-Path: <linux-kernel+bounces-247838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424D92D54E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBB31C21229
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAAD194A44;
	Wed, 10 Jul 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HivJFRco"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9718FA39
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626525; cv=none; b=vB4XvTsjGC/6J0bnCuQhsDWTx544Rln29INedpO+EN5kX11xcFuzxHDyKiij3vySwW9dP/Y9r9LXbOw1gn+YqCejXpPpbH/CFGrCaJnBVxu9BFyIKaJ81FnfeEkRhJ8gIWqiKwrOL35fPm2/Jjpi1qkXEUQ0vTRAERT/G3et0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626525; c=relaxed/simple;
	bh=iorRHs1FfFnnoZBWAuEPvxWAQCRVQH5UaGIKV9cGMW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF7clTKa1Bj/tHma3UGUT9cYvh5Zl/I/w7K74TwfRl84qtOOfaAxz4IKsFQX32Tg7G3bc9yxOU25vayhTwLHyaaPbmUtov3IgRAGYaPy2DdbxfZ+l7aYC7HJ9xxPTfQPxpR36NEP35LbdoRW7u5A9Uzp/Bpd0deOU98fyTQmQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HivJFRco; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f906800b4cso12700539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720626523; x=1721231323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS47NwTHSzZjUEoROwPuK2RM3LnHChBCx0vrrpQXSqA=;
        b=HivJFRcoqCW6CfCANV5oggQ6h0v8dqzRWu6p7ebXznvhCaRzp++oSLMvQIhtD/BxuP
         n/BeFAgpuXrlfvXzZNolJt+6LaodzYrjT8+pIENIO9bEnzD6gVBpS+16ylb045YA8hFH
         gZqPfK7OoyI1aFEkbiDye0y92KKo1jTrFftlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626523; x=1721231323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS47NwTHSzZjUEoROwPuK2RM3LnHChBCx0vrrpQXSqA=;
        b=p5VFRHfRhR4E3df1cVPqkZo+eBYwub7L+HalsYzv+rJFeO2k/ZYv1skoBor72EkHZT
         nHuOPw3kb8vkKRa7i2zswe/d64lqGyU+oP4sz/BvLIC4/ok4sMzjbq/PUJT43NfleS9H
         2v21m/jhUzGIXuXkiKczGC2mvP0J1fpakLXuGDMM5L+f6/VGv1DYXGw8SypWRsOBEHEz
         dDr0OyS7JQk9112meKjiAQnXmoSHGHg9Kg2n2pAiPI9LI7mI6foZ+x8kVbswZf70jKrH
         qIxsX54DcBeNg8lzQs8UD+f67jnJUc2eAINAC/NTcCt8u6HHKP8fGIktd0TNMcbpUoVW
         fDUw==
X-Forwarded-Encrypted: i=1; AJvYcCWlQ6V4q/da5t9ICXmXsoaheO1y+uXk2ahU6ETwnVX1NCe2j5TqI/OndmT4OB4vGGDd71nPTXIhHL/rr4KorhviYrbeLkw2tCBuvicA
X-Gm-Message-State: AOJu0YzKQ0GjhJD5A9vmxI3Hm6rQ6SfLWWgf9ZW0jRRp+ekx9gYppIJN
	2e3CRY2dg8wtWe6i4ireapSwU+UFF5LeTHmcUlSHjMzws8TISKRSjJfruQ6TZ8k=
X-Google-Smtp-Source: AGHT+IFRD6fL3OQ1OLKpghMhlBlympGGayGAHOv8YbYdzU4CyToyqM5gp8L/0wFHUzroGW6XGt//dA==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr658795739f.2.1720626523218;
        Wed, 10 Jul 2024 08:48:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf8601sm1222131173.105.2024.07.10.08.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:48:42 -0700 (PDT)
Message-ID: <0fcefad8-540f-487e-b5b6-b78009bf5d9b@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:48:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma:Fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: chenxiang66@hisilicon.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 00:30, Zhu Jun wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 5c997f17fcbd..3fcea00961c0 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -114,6 +114,7 @@ int main(int argc, char **argv)
>   	map.granule = granule;
>   
>   	if (ioctl(fd, cmd, &map)) {
> +		close(fd);
>   		perror("ioctl");
>   		exit(1);
>   	}
> @@ -125,5 +126,7 @@ int main(int argc, char **argv)
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
>   
> +	close(fd);
> +
>   	return 0;
>   }

Files get closed when this process exits. There is no need
to make this change.

thanks,
-- Shuah

