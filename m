Return-Path: <linux-kernel+bounces-517492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F38A38190
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DB3188A403
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11A217678;
	Mon, 17 Feb 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HiZPfpGk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB41A3A80
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791261; cv=none; b=bzBngmkJQMLtnNhuG1H4J/a8aLukurB+PZvb3kEpc/h/ItsQhrRX8xWKAGxtsUsjTCBa4rKfAMiZx/89fqQswykpEYyiwxFpe21VjlG2RJdZPkEhWduPQl7KhKhT8aIimuKzYnDzK+ohZhQ0Q6RAQW83l1+HuoHV1Z0++pEVVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791261; c=relaxed/simple;
	bh=1n2eB6hBnOb875pnEF5ZBhFr6NZgeDsE46jchXBSZm8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gXBp62eVnMF235EwYjVB9c9v3wlMXvzYNMbpkMwFu4JUmvDBOkwaN8vo31odtEWr8LSCVUBkjyllNf1f3JXzT9sGC4lnWYx7MvfJ/YTXkgcsV/6nFFiUxQ5w44iBy+2epdhOIQsYf2RxgHZmKIWYVFq+qgJncOhuTec6NuLfBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HiZPfpGk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so453805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739791257; x=1740396057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nopaozdgbvfuOiInh0oViYBn1SDaHhKKkxlYfy93oZY=;
        b=HiZPfpGkjcnTGc5+t9p+4SVWMHZoEk8iAY8YhiDbXzbDXOqigwcFAyNrM+iAw+vIqE
         pXqaRHUcXzGTPvnLadc1nVVKWUankYx7OvCOpcy8D1P1DrpQf8aYMW5zNZA58eg/AxpJ
         YhCV9Lynony6m6vfwnkBff+ElubzYKP25Z//ygx7H4i6S332Yt/8W3E+4LfUnoumTUou
         eqdeSsA3QC8itBgSiJkWYBb7saOUs1+iw8Z1FwgXLJU5X68iuvbIBKC3imRPnkrgetEJ
         pdyx3a4mLQfcnB5fd+nrZeR1kFJxef/qsT/ai2qEhfj+SN8MC4Izg46UoAL40hyVwd8W
         jCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791257; x=1740396057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nopaozdgbvfuOiInh0oViYBn1SDaHhKKkxlYfy93oZY=;
        b=o1mBJKbHN2v/y2BiYmRYxBdAvP2C6P3Z3t1XhFy16QFEvknZJ5NHLvopHNUkp3jt4I
         bIu+kiOLreuyeqevhjaap+BB5/Nxac1OORjGhhtsDs7+QK4+tByb5ZhCDwUvZwNz8598
         b+Y7cTv5vK70ebgxy0He2nR3W6UfRTEweEA22QCTg7u8E1nRGgWIPoimO9T4NbM+GPpU
         raq7D/uecpEFcq6UaBmavczOf37mJ2DJ8mi9lXvLnTlqz4WHUggcFP1I1QMSZWdoIAzf
         3FYLAZdtO7vBofJo1mKVotowT2tPm6KiZ2Er1Rj6BAW/9xbwAlx8aj0dsXA7Fgj7SFlb
         pMOg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUlr8dGXE3kFREe6LzHHtiWXGODQ+xBeNUiHu62cUWUQiT9vzMofqr3REt0aYbwskOEZigoHm3FqSOlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+71DnGb9lTMrSyLUWLXiLVxCV3L+SOjd7aEmPwg343+fI5dal
	Csi4d8xyVEem/0xZlHyixOqMu9QxJu27LkCvHGcGYmrLum/Ood2FmPwKKl/A5a4=
X-Gm-Gg: ASbGncvwrDX8CID7LdPaRcgPwJzvMS+vC1g/JqXaoX69hz734f27gETa5BeRpErQPLn
	HqU4+KxZiNpOWruzMo39BIsKotj5mH0Ab2JecFaUwUqwv9Y3DH0wE5qTUTFrH7bi8bP8i3vm2lM
	jcn3nouVJfSkEGZVSJ1h7JUZFNmxgagt5Mkrw9Ww2zNtKEgfFLp63ORHpjphOJANNzDXeA0BWn5
	DkxIB3V3SwyhtPtdsPkd1lJLHIM+ARJ8Ve/8+e/vg5bBcbVDf1aanJK9CqSfWAqNBWvqipBTweT
	CrYfrp2cWPcjbzDVHR4xo2JPIPhbX42i/LhvOic5aQ4=
X-Google-Smtp-Source: AGHT+IHyPVwfGCkgI5ziVhPsNbJMnB0fVpsFzKhhL0yCAbwX2o9VtwmhRjOoFKhA7Zne2pC7qgFZRA==
X-Received: by 2002:a05:600c:46ce:b0:439:5fbd:19d2 with SMTP id 5b1f17b1804b1-4396ec7c92amr79251915e9.10.1739791256790;
        Mon, 17 Feb 2025 03:20:56 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm151129585e9.27.2025.02.17.03.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:20:56 -0800 (PST)
Message-ID: <ff06575b-079b-4016-9a28-5b439beb0ff5@suse.com>
Date: Mon, 17 Feb 2025 13:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
From: Nikolay Borisov <nik.borisov@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 tony.luck@intel.com
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
 <8cce2725-9efe-44e8-b071-f921874d7649@suse.com>
Content-Language: en-US
In-Reply-To: <8cce2725-9efe-44e8-b071-f921874d7649@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.02.25 г. 12:01 ч., Nikolay Borisov wrote:
> 
> 
> On 16.02.25 г. 18:10 ч., Borislav Petkov wrote:
>> On Mon, Feb 10, 2025 at 05:47:04PM +0200, Nikolay Borisov wrote:
>>> The call is actually a noop because when the MCE is raised the early
>>> notifier is the only call site that correctly calls mce_notify_irq()
>>> because it also sets mce_need_notify. Remove this call and as a result
>>> make mce_notify_irq() static
>>>
>>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>>> ---
>>>   arch/x86/include/asm/mce.h       |  2 --
>>>   arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
>>>   arch/x86/kernel/cpu/mce/inject.c |  1 -
>>>   3 files changed, 22 insertions(+), 25 deletions(-)
>>
>> So what you're looking at are the remnants of the old soft-inject of MCE
>> errors. And it seems that we lost some of that functionality along the 
>> way and
>> no one has noticed because, well, it seems no one uses it anymore.
>>
>> In order to understand how this thing was supposed to work, checkout
>>
>> ea149b36c7f5 ("x86, mce: add basic error injection infrastructure")
> 
> 
> The original code in  ea149b36c7f5 was setting the notify_user bit via
> 
> raise_mce()->machine_check_poll()->mce_log(),
>   mce_notify_user() - consumes notify_user set in mce_log above.
> 
> 
>   subsequently in 011d82611172 ("RAS: Add a Corrected Errors Collector") 
> you factored out the code from mce_log() mce_first_notifier, where the 
> bit setting remains to this day, but since it's been removed from 
> mce_log() it made the call in raise_local() defunct.
> 
> 
> Considering that no one complained about this after all these years and 
> that the dev-mcelog is deprecated I think it still makes sense to make 
> mce_notify_irq() private


Actually there is no loss of functionality since after an MCE is injected
the early notifier will correctly call the usermode helper. So I
think the following change log better reflects the situation:


     x86/mce/inject: Remove call to mce_notify_irq()
     
     The call to mce_notify_irq() has been there since the initial version of
     the soft inject mce machinery, introduced in ea149b36c7f5 ("x86,
     mce: add basic error injection infrastructure"). At that time it was
     functional since injecting an MCE resulted in the following call chain:
     
     raise_mce()
       ->machine_check_poll()
           ->mce_log() - sets notfiy_user_bit
     
     ->mce_notify_user() (current mce_notify_irq) consumed the bit and called the
     usermode helper.
     
     However, with the introduction of 011d82611172 ("RAS: Add a Corrected Errors Collector")
     the code got moved around and the user mode helper began to be called
     via the early notifier (mce_first_notifier()) rendering the remaining call
     in raise_local() defunct as the mce_need_notify bit (ex notify_user) is
     only being set from the early notifier.
     
     Remove the noop call and make mce_notify_irq static. No functional
     changes.

> 
>>
>> and follow what raise_mce() does and pay attention to notify_user 
>> which is
>> what mce_need_notify was called back then.
>>
>> Remember to have fun :-P
>>
> 


