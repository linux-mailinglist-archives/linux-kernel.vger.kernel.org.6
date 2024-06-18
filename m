Return-Path: <linux-kernel+bounces-218817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFB90C681
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFC2283E06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469818E771;
	Tue, 18 Jun 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iHZ44Cf4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A413DBBB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697171; cv=none; b=sIYwdlvgRwMpqa12BZtD054m06ioWvsNV9Vo4ojPqC5XmjH4g6MQTODc7X0qiBXDNmkxIWYSrIVcB5DZm2Y4z77eXEbE2ZsVd4cEMR/MWXhewuojViuffJ77epYaNDDZSylPHEAZtdePBUZBWp4zatUQUTj9bK2GzbdunG8ahPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697171; c=relaxed/simple;
	bh=gtLfGbmu1dv5/UFNtlOlU7oZuoBYid6ItDlSEHq17tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9KJ8mTYL3DIIzTP5/3CPgzFFvdSXUHNDuv/m3qJ12MbZeW1AeTXduDdyq1yUa7gvKmYebN38I54Y+vqOoL2Z2vEVRQQh+iwdGeSqbZNznEIPO9kq17EmHDnY7r1JNThADhvjUxbpq+Yk2cbxumSEs4jOHB9oQsA7sLhao33HyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iHZ44Cf4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70617179564so30079b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718697170; x=1719301970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkGza3lrDUwy26WxbN6WWsJfW0E1pSkyds/zsLevD44=;
        b=iHZ44Cf4lFwRTcNfAJtnmX4WCsi+O1V+6jXuFjjjQm/QJH0fZ5Ol8aBQ57OMErG7PP
         mGtEnmBuhhhcZfOevtRJu6DmrRlYXkEp1+VtXZy/BHi++GHN9K0MIPF2b4PCKm+aSzN2
         fpRKDLdh8qs006XKnTRkD5K0wZcir447i8H8tIlhl4bJsvYz6fKJJ16hMwogqGqvxMPW
         nlkkBvn2gQa1bv0MoFuFIpf/eBWzowcBnYRvHXEeBX4BdG5jxFyVogXppRHoVsh9dUSw
         T/oEsBlMarQvkYdPRRKfF2YUrX7P4tfLGSKCV1nvXQTYjksYGVu70G0dZ56L4oH4lgzQ
         Z3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697170; x=1719301970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkGza3lrDUwy26WxbN6WWsJfW0E1pSkyds/zsLevD44=;
        b=rkPXeeQGlk5xXmni+TiOTScqhcoYoYUKIcu0neK26UsApE0qyAz4eAITq3c7f9sQXD
         uNNzsi/iKVlT1bzwRKxZ0HIkvv1A+5SDRoL1WxSK237n5R0baaQqnIe4F4+TjH/X9jOA
         I8TYXaJ4Gno/XCNfPjcjvqtKeSw3/2H3s8xYx8LhCd2qHpuaY3mGol3wuAZvOwt6/O2W
         HAorj84Rh8KySaJtm6yX/6Bur8xnumo3GTsZJlFZoit0uGtq70e9vI4jvUHgnGWAj39o
         zF/MCeOECI6VqSCA9OXVsQbIkRA9GQuO71swR67PY2cAtGW5Fae+O2PpXlyNw1FXXULg
         0IfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFpKN7vBgTUIN4MPoPUnyL0tw9LFPqQIMq+Yryda+sJ09479Zyz1BwyI5F2MOWlNEn4Fqyv/uUipc3JrnLSl/WsZ8RcHt7EXgElz8W
X-Gm-Message-State: AOJu0Yyz3Vltk5t4fpr8PRvIszcCAuEIQ/gquF8MuexmOyKUp9DFLCr3
	7dyqa65MX3rK3owfZQIeCF6oXTKoDDwruBnXLB5qRoBp6t4VPp/usPhXD/fxF18=
X-Google-Smtp-Source: AGHT+IEuQI6PvfkQeZZnq13ZJm37mQj3yi0/8ecDXpx8xflGzFdJnEC4WUxlBgr+HfCTJxpUGhjLow==
X-Received: by 2002:aa7:831e:0:b0:705:d50c:2564 with SMTP id d2e1a72fcca58-705d71d73dbmr12119494b3a.3.1718697169766;
        Tue, 18 Jun 2024 00:52:49 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8d9a1sm8434984b3a.186.2024.06.18.00.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:52:49 -0700 (PDT)
Message-ID: <a98fe84d-1fa9-47b7-824a-fc612d94d564@bytedance.com>
Date: Tue, 18 Jun 2024 15:52:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <24480cd6-0a13-4534-8d64-4517e73f0070@bytedance.com>
 <fbd652ad-2f3f-4fa7-9a4c-96e0876b6397@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <fbd652ad-2f3f-4fa7-9a4c-96e0876b6397@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/18 01:51, David Hildenbrand wrote:
> On 14.06.24 05:32, Qi Zheng wrote:
>> Hi David,
>>
>> How about starting with this:
>>
>> a. for MADV_DONTNEED case, try synchronous reclaim as you said
>> b. for MADV_FREE case, add a madvise(MADV_PT_RECLAIM) option to mark
>>      this vma, then add its corresponding mm to a global list, and then
>>      traverse the list and reclaim it when the memory is tight and enters
>>      the system reclaim path.
>>
>>      (If this option is for synchronous reclaim as you said, then the
>>       user-mode program may need to start a thread to make a cyclic call.
>>       I'm not sure if this usage makes sense. If so, I can also implement
>>       such an option.)
>> c. for s390 case you mentioned, maybe we can set a CONFIG_FREE_PT first,
>>      and then s390 will not select this config until the problem is 
>> solved.
> 
> CONFIG_PT_RECLAIM or sth. like that, that would depend on 
> CONFIG_ARCH_SUPPORTS_PT_RECLAIM.
> 
> Then we can start with what we know works and was tested (e.g., x86).

OK, will do.

> 

