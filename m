Return-Path: <linux-kernel+bounces-187607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35C8CD52A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469D31F21A31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB3114D282;
	Thu, 23 May 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TpKVo3id"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74D14C580
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472705; cv=none; b=oIwJUxf2Tdd/tXZ1ykFRmeUFtZf614q7vS+/Fs4Ypzp3Qqa85ck7FxPCKcfDu7CZwmKFNwDc9Nz/KQHZ2JLS3hIOIlJQ8gkSoJ9CpI/8x80K10L+XHFrddxuiFOds8pntFJOrjlp5ViebcaedzIgcvcTTc7htzimJZSKWxJbnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472705; c=relaxed/simple;
	bh=212Gl8h1rXjBVeHBEMErcUaBPXisMBYH41rMSxPPewY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk2nsln7KYtmaGPN6JbPrj7Q5W62is2lkiRVi0OgNFk805WVHJ9pTN4ydUh6Luz6QZtkOsrnd2ewKboGmtNoB7yGStS4/+NHf8Via8qSAaD/rfPxNTEJow8uGtg6XRx78sCmo2KMFnhIb0RXPcVo/htPgMiKCk9AyOS68aKTfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TpKVo3id; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e716e3030aso57962671fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716472701; x=1717077501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8AP4zKFyYxQSiWmyeAqfHSQQwp0NPir9RZByqHMOI=;
        b=TpKVo3id8vT24INgd3uJnDMY2Vi2suMTB02Ionl/ztdow4nIH9AebxuK7odxD6aNZM
         BOH9BVLYLfsTEHPvE18PdrGzEUe1H8x5BOd/23cd0hgV09ZjElAfXiUqClDt5buE/OR6
         hnmjyOedi/lHrWOJO9B5WYikLfj8FQv7v82YCgIBo6nxmIdzn54QsjoBFKH7+z41a0+X
         tEdO/rgtPn3Zcr6LzoOb7PX5rS0/zDagQ3V1p8uptMXHlTQTzwQoET4YbSFLydVh522P
         npe3L2vlmjlRU5uv83JJ0USh19x7a/5graMPIPJzDm9MzOym/gVsfvR3wYnBfUTV88dW
         dbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716472701; x=1717077501;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8AP4zKFyYxQSiWmyeAqfHSQQwp0NPir9RZByqHMOI=;
        b=tU+tnFYZAcirNj0lMDnRpeZXdMO04VqFgvgYBDa7OvmoJif2aVCTg0Irde9+NjTaAf
         M5ssxyOBYm0taB9nwM77LlROXuulPCKT+Ut9tt6S0bYwW6VJkxw+3Kx7n66WXThvn43y
         ZUaC3+Z34IZdR5xvM6VkrV8oRvQKyN8BIy1UCvajPoRSNhO/Z2QR93WUL/yx3Mr0Y4pj
         8mqYiO4GG7dqLXmT3SbzUdRBZaUFo3NNbE00F8NDEGgqr/Sgimsdp1c2E8OTy6CRDjah
         r9oDGoQTn/HVQFfVb9dlZ/j99L1MWnDKDbvvkIvVVU4h7AwQ0epL2S8l9rbwjzKeadsF
         Xybw==
X-Forwarded-Encrypted: i=1; AJvYcCXXtzLHpipPzUpOdfRIM5iv50ITX+K/OoDl6mxe0dJcfQkZqp81wdlKFLgnmIcqPm62GaX9UEVxbkGnejd4pgor2kkrNLmxN2YnVnvA
X-Gm-Message-State: AOJu0Yxoj0VRkv5WV7UhWJO7tpAO0vTw2lL5HhBkUyiPyvOn4k6gS6QP
	lw3bRLl4WswlkFSUMkXU4cWyEp63xUURuukGsXsAgDegH9W+z8J5bTZPxA9Pp/w=
X-Google-Smtp-Source: AGHT+IGJG5E+2H4z+LjeMsNRuleOZIOXJ6BQDgFSOsKyk8u1N0Hs+3dPnKJWldfjS23hay4d530Ewg==
X-Received: by 2002:a19:f50f:0:b0:521:6c38:6949 with SMTP id 2adb3069b0e04-526c0d48addmr2970750e87.45.1716472700965;
        Thu, 23 May 2024 06:58:20 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781e97bsm1925536266b.32.2024.05.23.06.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:58:20 -0700 (PDT)
Message-ID: <01e1183c-46c3-41ca-8b47-d008747c164a@suse.com>
Date: Thu, 23 May 2024 16:58:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in
 set_bank()
To: Vegard Nossum <vegard.nossum@oracle.com>, cve@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <2024051943-CVE-2024-35876-d9b5@gregkh>
 <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
 <a7bc8570-4001-43b6-902f-d45de27fcb02@oracle.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <a7bc8570-4001-43b6-902f-d45de27fcb02@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.05.24 г. 16:54 ч., Vegard Nossum wrote:
> 
> On 23/05/2024 12:24, Nikolay Borisov wrote:
>> On 19.05.24 г. 11:34 ч., Greg Kroah-Hartman wrote:
>>> Description
>>> ===========
>>>
>>> In the Linux kernel, the following vulnerability has been resolved:
>>>
>>> x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
>>>
>>> Modifying a MCA bank's MCA_CTL bits which control which error types to
>>> be reported is done over
>>>
>>>    /sys/devices/system/machinecheck/
>>>    ├── machinecheck0
>>>    │   ├── bank0
>>>    │   ├── bank1
>>>    │   ├── bank10
>>>    │   ├── bank11
>>>    ...
>>>
>>> sysfs nodes by writing the new bit mask of events to enable.
>>>
>>> When the write is accepted, the kernel deletes all current timers and
>>> reinits all banks.
>>>
>>> Doing that in parallel can lead to initializing a timer which is already
>>> armed and in the timer wheel, i.e., in use already:
>>>
>>>    ODEBUG: init active (active state 0) object: ffff888063a28000 object
>>>    type: timer_list hint: mce_timer_fn+0x0/0x240 
>>> arch/x86/kernel/cpu/mce/core.c:2642
>>>    WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
>>>    debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
>>>
>>> Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
>>> does.
>>>
>>> Reported by: Yue Sun <samsun1006219@gmail.com>
>>> Reported by: xingwei lee <xrivendell7@gmail.com>
>>>
>>> The Linux kernel CVE team has assigned CVE-2024-35876 to this issue.
>>
>>
>> I'd like to dispute the CVE for this issue. Those sysfs entries are 
>> owned by root and can only be written by it. There are innumerable 
>> ways in which root can corrupt/crash the state of the machine and I 
>> don't see why this is anything special.
> 
> I haven't looked at the issue in detail but it sounds like this
> potentially breaks lockdown (which is arguably a security feature) so

How exactly does it break lockdown ?

> "requires root" to reach is not really an argument against this having a
> CVE assigned.
> 
> 
> Vegard

