Return-Path: <linux-kernel+bounces-370517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032D9A2DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE96283437
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF1202629;
	Thu, 17 Oct 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnFSF1YN"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C51E00A7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193833; cv=none; b=gtIWZe8LpQLMndFrIeXzKodtyEk0nnCkJVBd1n9ck2WZTE/TtiwTgsV1QrSkAGUuUotJnmLU/J6Unxjida4kr/HFzruBr/4aHTGXDYldXRKKeLOQKzw/CBPqdOB9tNdg92r1ZlSBqfNNcvi+wNFrOQDjLcdGo+hlrbwDiVbtA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193833; c=relaxed/simple;
	bh=6L2ezWNP+KL59GOZ8iDTVIF/P5jFnKtwE3A7kCOMqW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDxLHQU1qvl0kH81nSa1DwsRQt7DutJo93+o4vp5LcvMbl+RBLjvNuIAbXfEGJCQgpai0wzuzRojzNZ6ZjZWeSP3hc66c3bRhyKc0NOl0JDsUdNpyM64ARXMZ27F0mAkXPT25SkwBzywqDGACPzT7uA3jjRQjs3fCfybiMSN0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnFSF1YN; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3a309154aso5071555ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729193828; x=1729798628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=YnFSF1YNhRvaF8FL4iIGaevu7KtnoK5ntetHSNcvxqkRy7KNZaeftfj9BrbbSpTBHl
         e0iFiGzwfwIzBp0b5KYlorjB8GQ4Gu29uF8T2fvjrFe1m1NM2r5R75mDDS51FIrsBv2W
         BJj5hFEhF7we+hv/j/ogxMwjaWRleiYqZQVkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193828; x=1729798628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=ekRkLbUa1DPUtlNr4i6FKWoWhJv0/o3deT/9ULfI/aV2gzfRADjSjPiZ3pepJSKfS2
         +UGghZsLDOjhJ++1AjwRzjxmivVF9xkD/Eevu2p9OjhfFI667BtEAhbYnrTR4NkiK3H+
         rlfMrvLO52zsa17qegvweyyAhmmSNR/Gg2nli0ypwCsUQSTEwffvi6A4sxDigMJiKNAT
         leeFWW5PwG8xUcN4nI9SCn+Yu9EBP22Vv8g5wK+SFLP+wmTD3XQ9EMsqlXCxXB/P28OQ
         bZBaNL2uUL1q4bqOAAZESfnAN6L+vIT5Ofi4J07B/qHLbTGcAKJcWJqihyYdQdIy0WjA
         t6qA==
X-Forwarded-Encrypted: i=1; AJvYcCULqY4q9HjrC4bdnhPj8cHCKGSMfS9opweUJ/9b/hpst/skWgK1JGlqGk6ucOdl8THtFLNwDb66lxONKJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSsylMb91utJQ8tqBfoD1OGia4+HyQ3Lv141X08egj8nN2L91
	aLmkx1r39GRAUGem0OtfBaaojA0+C5I2K08s4I9VzLDQG/LxXOh0itdWnoA6t0Y=
X-Google-Smtp-Source: AGHT+IFkoyHAtNPtcVEkmnW87sgrwm9C/4bHGNtVw7TLSwB6i4QHE4KUdS6c4sui6FUCDwQh0ZK9/g==
X-Received: by 2002:a92:b701:0:b0:3a3:dadc:12d9 with SMTP id e9e14a558f8ab-3a3dadc1780mr78958115ab.25.1729193827785;
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70747besm15386025ab.11.2024.10.17.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Message-ID: <a6f56949-7db2-4587-a3c7-3c583cba2fe4@linuxfoundation.org>
Date: Thu, 17 Oct 2024 13:37:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
 <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
 <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 11:38, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 10:37:00AM -0700, John Hubbard wrote:
>> On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
>>> On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
>>>> On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
>> ...
>>>>> 	#ifndef __TOOLS_LINUX_PIDFD_H
>>>>> 	#define __TOOLS_LINUX_PIDFD_H
>>>>>
>>>>> 	/*
>>>>> 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>>>>> 	 * work around this by setting the header guard.
>>>>> 	 */
>>>>> 	#define _LINUX_FCNTL_H
>>>>> 	#include "../../../include/uapi/linux/pidfd.h"
>>>>> 	#undef _LINUX_FCNTL_H
>>>>>
>>>>> 	#endif /* __TOOLS_LINUX_PIDFD_H */
>>>>>
>>>>>
>>>>> Then the test code needs only to update the pidfd.h file to #include
>>>>> <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
>>>>> the pidfd self tests Makefile and we should be all good.
>>>>

I like this solution. I should have read this message first before
handling the others.

>>>> Yes.
>>>>
>>>>>
>>>>> That way we always import everything in this header correctly, we directly
>>>>> document this issue, we include the header as you would in userland and we
>>>>> should cover off all the issues?
>>>>
>>>> Very nice!
>>>
>>> Thanks!
>>>
>>> I saw from your other thread the idea was to take snapshots and to run scripts
>>> to compare etc. but I suppose putting this into the known-stub directory
>>
>> Actually, I'm not running scripts, because the only time things need to
>> change is when new selftests require a new include, or when something
>> changes that selftests depend on.
>>
>>> tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
>>> here.
>>
>> This is the first time I've actually looked at tools/include/linux. That
>> sounds about right, though.
>>
>>>
>>> Or would you say the wrapper should regardless be in the uapi/linux directory?
>>>
>>
>> No, not if there is already a better location, as you pointed out.
> 
> OK perfect, I have a patch series ready to go with this (and addressing
> Christian's comments).
> 
> Shuah - if you are open to this approach then we should be good to go!

I am caught up with the discussion now. I am good with this change.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

