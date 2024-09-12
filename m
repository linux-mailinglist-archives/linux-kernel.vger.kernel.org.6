Return-Path: <linux-kernel+bounces-326953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A71976EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901C7B22114
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF71B1402;
	Thu, 12 Sep 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WcELXjxV"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA013E41A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159493; cv=none; b=LLvF1pLZINU2S84gXuSN6j+JXGwCpDBKutQxILoKh64H9mhQsRb1kcsPqiikCy6ZcnTKH6wvkezE+cIB3HuvK3LdnRTzd00K3dVhfI9UJex7Y1cWii9bNXIDWxmNMOHVKp2/DrxXsm+P6VP8wCQ5gjBTBPUnakhsC/JcJ5B7M0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159493; c=relaxed/simple;
	bh=OywBXN/615TU+QFB6O6G9HCLhy16wQtwKSU6yMEnB18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgAvZqQkHg+JCl+GGp6mEQQA91/Daq0Y+mC+BdAOJ1CC6tYuSzBf3EFRHr+ES/TjV3+4MmCN/SuiELy48b+z9+0cs/31ajOSlIDvxHhVU5EaR6EaHzZevDDt6A0vxLEPi/fz10kWVhG54C5/tj+nzf6VpPNXDXfsaWAw9dWuoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WcELXjxV; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82cdb749598so57698939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726159491; x=1726764291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wo3x8YHvYS65DE5Sfp4lGYzOUb4Y2BKazjbznKZokSo=;
        b=WcELXjxVrwb8T2Iw9jTeHUCBLYw6qGpdri6se9qShhXzlnULgU33+r1iWPAL8Ybj7M
         u8I+Y5Yz2Je//745ByUSDddFvDHqaKF7zuxBzd0wPPQ3t7A9v7vExGKMgtEcrPkrakHn
         3rbFKKpOvFoA0PM7DHZbGp5bDjUglhHr+hKZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159491; x=1726764291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo3x8YHvYS65DE5Sfp4lGYzOUb4Y2BKazjbznKZokSo=;
        b=r9fIieY9B6ulCNv3EudKVo46ttPNCv1J5Paqk5XELgPNvOKbJp0ZBmtYk0NVet72PC
         VL3HG4DSJkwyL4rftbUXTzD//NcPzq04OJcoJLP1LuHDGscJjc4cEx3Sg97FNMo8d6xP
         HWznB54vh6jvwskWxXyvVv5vMBvM0PTGpL/Iu+QAbOfea7LvbmQNRNFz44sOXjUSOtod
         7FEU9JdVdB1BMryNKumCgRo/Fk2gwZ6At9IuYST2h8Zoo2MXy0m2yGCoh0prmywFS41w
         zb9+lo6zFasFCX1izm4I0T3VjsactUUdehBa2lQyXGMpZLmXBMzanzdo0wEKrM1j5e4Q
         GTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJvdlGI457RT9q4CMB2TsEmTRLjBpMppgQusezmP/ohDrdvqxxEtyV+3Jyng2ziOO+Kh7QvsYb/GKFs3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgtdt5adOYhrQqJSDctvb5uT0N6LN7z2Gdtn9ZBJztuOG8bsWS
	1PMbi5IIqTMTbUTQZamZ6maXyXW7LSvDvTqgkPkuWWSn1WHWBt4+/I5UJmaKc9Y=
X-Google-Smtp-Source: AGHT+IG8WxtLjeMTnLkX9JNP/f0ES/0H83E8EkQxcj3L6ZPvuQbDvcor09kJInQjlGBaiqWRZJJqkg==
X-Received: by 2002:a05:6602:15d2:b0:82d:1ba1:da5b with SMTP id ca18e2360f4ac-82d1f971466mr317736539f.13.1726159491009;
        Thu, 12 Sep 2024 09:44:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f56ddedsm689762173.62.2024.09.12.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:44:50 -0700 (PDT)
Message-ID: <3a55faea-5570-4a27-8625-c3f0a276907c@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:44:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Jakub Kicinski <kuba@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
 <20240912082307.556db015@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912082307.556db015@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 09:23, Jakub Kicinski wrote:
> On Thu, 12 Sep 2024 08:31:18 +0200 Anders Roxell wrote:
>> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>   tools/testing/selftests/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 3b7df5477317..fc3681270afe 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -64,6 +64,7 @@ TARGETS += net
>>   TARGETS += net/af_unix
>>   TARGETS += net/forwarding
>>   TARGETS += net/hsr
>> +TARGETS += net/lib
>>   TARGETS += net/mptcp
>>   TARGETS += net/netfilter
>>   TARGETS += net/openvswitch
> 
> Please make sure you always include a commit message. Among other
> things writing one would force you to understand the code, and
> in this case understand that this target is intentionally left out.
> Look around the Makefile for references to net/lib, you'll figure
> it out.
> 

+1 - thank you for outlining the benefits of writing a change log
which includes the details.

This patch is missing the changelog completely - change log is
an important part of sending a patch.

> The patch is incorrect.

thanks,
-- Shuah


