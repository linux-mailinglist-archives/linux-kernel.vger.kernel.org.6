Return-Path: <linux-kernel+bounces-312424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2A969674
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320C61C231C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A091DAC5B;
	Tue,  3 Sep 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUSx9+3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097781A302B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350661; cv=none; b=uYPJgMG6SiU1CtEJCz/7F2x4jGjvyfFqfZxvKPefe+AyUnjMYbfyyRmRWIdR2BaKdjPoJY4Y1N4TRh4FK3APKdfJz37CrtXPy0FGsAtNobBRKY5eU5LQF+17Jb5OQtLPnilzg7y2CCXXB01cTw2hy8m8nVyjmokJm3MykEyZeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350661; c=relaxed/simple;
	bh=tpLmDw+Zq6B8rZmhv0xqgHfHY5i5IjC2+F1RnzZHD+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNrCMUmBE32IbytKPbo+3/Um5r9pJnOZ2ty6XUpxYXUPxLdsQubY8MRtiIo2Nv7qQjzS5q/brnBErx4YoYXb6wEXW0SUk91lm1Gria9MLuePvtVFKgreH8oXLS92yhiyvWLW6Yg5ZZUT4LdTjoWFUg7wdJaw7O58g4x90YckHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUSx9+3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725350658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qrp/RvZ192NqDrbtjuR1VciCLXUiq7qA8oQqJn5gI08=;
	b=bUSx9+3vkp/RDovRmyw395QFA3W/GLHsMBTa6h3MrDLquuM01b2Ol0y6KPWYYWLTuc8NzF
	Kbd1dT+7O037EdrYT93taUde5SiaGK79HTmdXSpZ3qgkG2ESYWjC0m9PGoyZ5gTBLDBDE2
	CJhl3u10uhbR7F+ao/AzdnRC18r20FQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-5zyRm2fLPtKIJJb-giR9EA-1; Tue, 03 Sep 2024 04:04:17 -0400
X-MC-Unique: 5zyRm2fLPtKIJJb-giR9EA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bb1e931cso1455392f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350656; x=1725955456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrp/RvZ192NqDrbtjuR1VciCLXUiq7qA8oQqJn5gI08=;
        b=uKf4M2JGUw6tm0lsb+KHeajihfC1KvZrZZA3bQKBLO/tI8WMdTuxkKj0XFjhicNDS0
         oIsKQLqZBEBWFkdPnFXY+RG45B4iH5gvcxiwPmqVDWZBytIFaFuW45Lt0FPnLtDWJRuy
         tlWuG6EV95o1sR6RFz/ztB7v/4AASsTodC1Rx9NSIv+avst6RehmuC7rcWARjGaWb30W
         s0xmUiV+p2TVYuZKKdaa3GTkDFKzYw6SKMGEN66Mmkflc0d6YV9YQM7h5r79hTOpanlr
         Xu7ATmbMAYBxGIq7+lSq9z+voupuoD3qXFFFg7uk1V82fHhu6BLpaUl1PyNY97BysfUJ
         09Xg==
X-Gm-Message-State: AOJu0Ywut9PeZ0sxkzWwbB3FWgbexltvXWrCVA5zbgfvCC7Ef+lX7dWK
	zfKZQnU7CPZlcgJFlljMMqUDqlumD5NBa8/Y3q263YPFNU7sMfLnyIv9WD8VAvzyRgDPTMNpbND
	KjdxLxu2BYcSRP43vSinSxrfPaVrWFBDpPTXlkDkV2ZNgrsJYwypaJ7/hZez5wQ==
X-Received: by 2002:a5d:5f43:0:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-374c21a9fd5mr7371133f8f.20.1725350656552;
        Tue, 03 Sep 2024 01:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAhh5CwVo0GmSzBeU4raR66+OGdIsAguVVHiBTtvBGGs27U/Q3YHjKt024GJ5kdjlnUuf9AA==
X-Received: by 2002:a5d:5f43:0:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-374c21a9fd5mr7371094f8f.20.1725350655880;
        Tue, 03 Sep 2024 01:04:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:7f00:8a04:4c6f:a761:af60? (p200300cbc7097f008a044c6fa761af60.dip0.t-ipconnect.de. [2003:cb:c709:7f00:8a04:4c6f:a761:af60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm13527299f8f.50.2024.09.03.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:04:15 -0700 (PDT)
Message-ID: <cec0ed06-b5d0-45aa-ad2b-eaca6dd7bacb@redhat.com>
Date: Tue, 3 Sep 2024 10:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ksm: add ksm involvement information for each process
To: xu xin <xu.xin.sc@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 shr@devkernel.io, hughd@google.com, xu.xin16@zte.com.cn
References: <20240901043525.16831>
 <20240903042754.1776245-1-xu.xin16@zte.com.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240903042754.1776245-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.24 06:27, xu xin wrote:
>>> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
>>> KSM_mergeable and KSM_merge_any. It helps administrators to
>>> better know the system's KSM behavior at process level.
>>>
>>> KSM_mergeable: yes/no
>>>      whether any VMAs of the process'mm are currently applicable to KSM.
>>>
>>> KSM_merge_any: yes/no
>>>      whether the process'mm is added by prctl() into the candidate list
>>>      of KSM or not, and fully enabled at process level.
>>>
>>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>>> ---
>>> Changelog
>>> =========
>>> v2 -> v3:
>>>           Update the KSM_mergeable getting method: loop up if any vma is
>>>           mergeable to KSM.
>>>          https://lore.kernel.org/all/bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com/
>>>
>>> v1 -> v2:
>>>           replace the internal flag names with straightforward strings.
>>>           * MMF_VM_MERGEABLE -> KSM_mergeable
>>>           * MMF_VM_MERGE_ANY -> KSM_merge_any
>>>
>>>    fs/proc/base.c      |  4 ++++
>>>    include/linux/ksm.h |  1 +
>>>    mm/ksm.c            | 16 ++++++++++++++++
>>>    3 files changed, 21 insertions(+)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index 18550c071d71..45e12560e698 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>>            seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>>>            seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>>>            seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>>> +        seq_printf(m, "KSM_mergeable: %s\n",
>>> +                ksm_process_mergeable(mm) ? "yes" : "no");
>>> +        seq_printf(m, "KSM_merge_any: %s\n",
>>> +                test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
>>
>> Inconsistent "KSM" casing .
> 
> Excuse me, could you be more specific? I didn't get it

Everything is "ksm_" and you add "KSM_". Better keep that consistent.

-- 
Cheers,

David / dhildenb


