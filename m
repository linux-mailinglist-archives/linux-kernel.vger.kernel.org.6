Return-Path: <linux-kernel+bounces-535007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68330A46DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320393A60AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425625A34D;
	Wed, 26 Feb 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgNtw+4H"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458625B67F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606091; cv=none; b=uHOhgAKi9eicGIV3bGAbkSgzU7YZF91UbHvqVwkIWfyaXMbfG4aWWpDekf6cXAOzDCPGaIV6LFYA4Ob7oHXlEkSPM5uGLNveutt/5ostKNPo3xaIHmLniAS1K43/hs/CjB+62pkYpggCElaPteqTNVnpD95F8qfNu7SGml5rsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606091; c=relaxed/simple;
	bh=Di9FYpPtVfl7GsOFof37nEkaTPeYYC8IFNc3O29zZBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiAEnwzRWUEmPntigE32Yq8ivbOVNXdUKOslUzfLLUuvS4bhQkMMFGW13bQQgscbkUsq7udWJVh1clfYYm7ciVBVh5a3lme53sbmzRX5gKf/ukt7L0T3cxQ8LlYhfeMK55DBV8IZbJztwJ7xYU7YZxJ9vxPxfwxAO8U8ygyvwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgNtw+4H; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so2520035ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740606087; x=1741210887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=EgNtw+4HYem2fMOMePu2C/PlLFff29/G4o4Xd13ceHo70FesJOCOcdhZUdhDn6gxP3
         HB/xmEcQmsssCccSgTG4sUEWKdSLaqB/KpS1HgB2Js9dvBGtPLdMI+azSqx6g8zn7pv0
         eZRIXMZoP5MyXrHC78aogofKGm+47rgefZTtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606087; x=1741210887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=WeSOxtfBMrUyXE2SNiEQ+hn6ddgS+ZPt+/XIeU1rRdji9iAjoD+4qRQAtBHKIvLCUW
         UvIhvL0IMrev4/w2knSGTtoaMASXOq5XU5c34XGzSOSTMPFRbWoo6Cq0ltcf1QEJFOzg
         FN7R8XpOnE7Tsbr7ncROIz9ElAvROXANaz7A3+E0oAHwp7ym7uXO0yRtPVH4OPEXyFTC
         2+FdJ9UHPeaY/dJqtv9BGizZAOZ40VzkvDGZfDM1nrv6ByCZPQT4EjJ+s8DuFP7fKMpB
         qFj/hO237r/C0Vbq25nM294ecLACs7rhGR+8HgoyAfTJDL6KfyRzlhW+qesdkwqxtbR/
         Bt5w==
X-Forwarded-Encrypted: i=1; AJvYcCUbfxemRg6nixRkm1Sv+cUSVegH2chjI+jsm/QjGDDUX4SmnNI9/qAdgQO7ye7sEKhrd796P30cEh5NLEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2acN2UgmrrrohIeIiY1CnQcv5WWV11fwQB+hkDJmBFSxfOwY
	g1U/Sg7PltIpqZAbVTjU2mTAjePSNfh+0gmV2kbuQKNP572ofWJd0vNlX1Mszm8R/Z0k22/slAF
	q
X-Gm-Gg: ASbGncv3d818/RnZ3OCIfy6DzlDIx+lBQLpHONJxyBkub2bBbEt0z3xRK9VHaz/j/hg
	xXDstNwT53RLwjvc/8f2GznRJb/NwlFC4LhVZlLysFbtSwjH1U1XojciwGlHU6HVEqMmG2lFNMn
	7QDfalV32dFd32CnIU8InzKVJuVN2AGzlLHWDcLRDc7JkD4+SXVe4VE6AQAQ0NIPmRrapYo9afl
	zasTZvZOHYRwvNIWtUVx0OrimLbXLvu5/Y6dRLg9plaaO6dNG61m4gBD81FTDHe9Z/gaLrylJTR
	FZWaUrHtj1ONCihYSU7WNEphMWv7mgUDlabW
X-Google-Smtp-Source: AGHT+IGEnHXG2qu9LDh932QF8VC4PSeuGzxYdyTHYY6hisaHR02G7GnV2uKJV/Dq51cIKq8C5TdmhQ==
X-Received: by 2002:a05:6e02:1c09:b0:3d3:ce83:527c with SMTP id e9e14a558f8ab-3d3d1f140cdmr58022385ab.1.1740606087525;
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f790bcsm38180173.126.2025.02.26.13.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Message-ID: <0758d73d-98b7-4f9b-a3b2-001d69eb949d@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:41:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: Fix bad array reference.
To: liuye <liuye@kylinos.cn>, shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250206021239.51897-1-liuye@kylinos.cn>
 <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/25 18:31, liuye wrote:
> Friendly ping.
> 
> 在 2025/2/6 10:12, Liu Ye 写道:
>> dir[directions] should be directions[dir] to correctly index the
>> directions array.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
>> index b12f1f9babf8..b925756373ce 100644
>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
>> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>>   	}
>>   
>>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
>> -			threads, seconds, node, dir[directions], granule);
>> +			threads, seconds, node, directions[dir], granule);
>>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

How did you find this problem?

thanks,
-- Shuah



