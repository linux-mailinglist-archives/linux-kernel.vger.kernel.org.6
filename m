Return-Path: <linux-kernel+bounces-515798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453ABA36933
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A187A30B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260F1FCF6B;
	Fri, 14 Feb 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdCXgJ9q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB571922DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576921; cv=none; b=sijZeEdt9gFXNNfpYZkzTmmFKxMQmO4FL+Xma7T9uOvgwAQqKOm+07/q9IuiRgtS/Dq1c4QGD0jM6vxBEUvwqUBWwz+tXag6DegBRBUsAlkl4699jZEc9jfnPIU8vB7iQfSrNIAEaFXzQorSJ/kAV3RKNkYfcW2IUF3Iw/y1trY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576921; c=relaxed/simple;
	bh=lU6MCr83qCliOY9hkMkH1qOFULy82nHtvyDv+uQ9Ulg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3FqhzfLQDFB2sMSpzjgAK7ZPSlIKZWBs9clv+PAgLuGu9Z0ae69Mbxus2bzxHDDXjAOvi0IE8DpcBW7JbVhhHxhojHyHZHpagy2sbBscEcESTdP/zj3ZS4ZCmwlFVROFQRimsHQG1yYO+jJnTGV6IfI+tDRodxnYDX8QFXWqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdCXgJ9q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739576918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6phXu4+Pf0qom22NaynRbMF2gFKCZhD3gI+zjKxLEs=;
	b=NdCXgJ9qnwt8q9RHnxoG7dT289GCtQwPEEoedZRJ3GEi+9RnSoCtlJGY5UWPEYytvHjyV3
	OrCT9u7sfqSH5kJGvj7iukSKGmLWcCV3RZlEuxXB/rmiX0bm+rbBmyfQGzS0OvjSBts8m1
	GzKHftjFB1r3LVCAu4zILjSSAwM+gDQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-033WyHN0OrGe3Nlhh7PqfQ-1; Fri, 14 Feb 2025 18:48:37 -0500
X-MC-Unique: 033WyHN0OrGe3Nlhh7PqfQ-1
X-Mimecast-MFC-AGG-ID: 033WyHN0OrGe3Nlhh7PqfQ_1739576917
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220cd43c75aso92657995ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739576916; x=1740181716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6phXu4+Pf0qom22NaynRbMF2gFKCZhD3gI+zjKxLEs=;
        b=F8lnFOPbvb4ql1D7H/8gXefklcqY7YPcj8cQLO5mZMoVYtA5mXyhcJKBHQYc8eFGC7
         edP3ru4Kp9/dTe9j60xnJ7IYvnxrC/IvyUcY9YaRjqx1oqxBIO2fHBt/J8rjeUq4Z+y4
         satPQSmVAWsmCxeLYAPnJh+IeAq/AmXCf1xNG/Fp1QU1EGQNttqCxifm3fMTdu4GPTDc
         uETIJkFNLLYSpjNA4Ixeh4erttWGcuMkqvVBkr+oHcstbILEntt1b1lAprOvkhxSzAv8
         8EkOKyfulKMGnlEWusYkJMm3Pm6x1q1S56evWUph/Zz5ljDJuDf5YnXHV2Yl5jnf+Sk2
         nLPw==
X-Gm-Message-State: AOJu0YxacgRuyhIKTJaQMsFKD8yB08kYZhMjEhakkTB5DnyeZEUU3hAe
	j5rWsZIulMCxvQMZDlqnR/PFAJ8iWw/59NlSPSepdbZ3ZifjPoQ7jI9A7NKdMmIdZ9nv2G6HNa8
	GoeN+h7Qv3WDXVdclZfmkLfCAOHP3f1r17nk+MpCpupUuuR55h6JRcPz9GqETrw==
X-Gm-Gg: ASbGnctUE+FZA4tJaVpcnp1peQaqtYTqhrbHT+NdNuo+pSaF8j4PJWRtk4jWCi6R0he
	bk2F69P9acOoCMH/uY9DVk+CW3+xDVqSjgE3rdsHcNrlkRwp5Xpbmr9i85z0dgfo1HZSVQc2oLO
	PyUvBKtOgFLgK1lLZLFpbUmsxk+FVYIu9YA5GzLvEAjxZV/OUfWfLT5hINEprFOEy48Ut4dkhcc
	tZDIhjT73dXqwzPFtq65rk6XOCf3vR6ZwayGdan0zh0xKAqV5ZLyD/hXRvdp8ffB9He+9W+Ix8q
	Vq3p2w==
X-Received: by 2002:a17:902:d542:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-221040bc31bmr19217805ad.41.1739576916722;
        Fri, 14 Feb 2025 15:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRyGtDSqzej/ErHH5h6imPG+tPqnBrUyq+pULBF1AEJ4qdGua+o5pwJZME07H5eRAbT6hSGA==
X-Received: by 2002:a17:902:d542:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-221040bc31bmr19217475ad.41.1739576916420;
        Fri, 14 Feb 2025 15:48:36 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558ee0bsm34340145ad.236.2025.02.14.15.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 15:48:35 -0800 (PST)
Message-ID: <7d9d0ba9-a503-4009-8dd9-ded51c620128@redhat.com>
Date: Sat, 15 Feb 2025 09:48:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/memory: Simplify add_boot_memory_block()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 akpm@linux-foundation.org
References: <20250214063504.617906-1-gshan@redhat.com>
 <20250214063504.617906-2-gshan@redhat.com>
 <bfad9746-689e-4275-9d68-f8d062526412@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <bfad9746-689e-4275-9d68-f8d062526412@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/25 5:53 PM, David Hildenbrand wrote:
> On 14.02.25 07:35, Gavin Shan wrote:
>> It's unnecessary to keep the variable @section_count in the function
>> because the device for the specific memory block will be added if
>> any of its memory section is present. The variable @section_count
>> records the number of present memory sections in the specific memory
>> block, which isn't needed.
>>
>> Simplify the function by dropping the variable @section_count. No
>> functional change intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/base/memory.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 348c5dbbfa68..208b9b544012 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -822,18 +822,17 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
>>   static int __init add_boot_memory_block(unsigned long base_section_nr)
>>   {
>> -    int section_count = 0;
>>       unsigned long nr;
>>       for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
>> -         nr++)
>> -        if (present_section_nr(nr))
>> -            section_count++;
>> +         nr++) {
>> +        if (present_section_nr(nr)) {
>> +            return add_memory_block(memory_block_id(base_section_nr),
>> +                        MEM_ONLINE, NULL, NULL);
>> +        }
> 
> Superfluous set of braces for the if statement.
> 
> Not sure I count this while thing here as a "simplifcation" -- the code is IMHO easier to read without the nested return in the loop body.
> 
> No strong opinion, though.
> 

Indeed. I will use for_each_present_section_nr() as Andrew suggested. With it,
one level of the nested if statement can be avoided. The point was to avoid
counting the number of present sections in the specified block since the block
will be added if any section is present.

Thanks,
Gavin


