Return-Path: <linux-kernel+bounces-565204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CAAA6632F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C79173B20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896E2063E7;
	Mon, 17 Mar 2025 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="OkJO5ngE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D31F5852
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255569; cv=none; b=rYu7Ib7j7dXjS4oom/6lsa698jWqigHXabE+LlfIMg8XroDxnv0zCAJmqijw0KjFkHCslmirFrrOJE4Q75wvFN4b8kc6PFdG79+Gf7sF/BQD408qmeEV2hvTzPz6m7E9l2L4xlTLUVIxwmhsU/UU9yfZbG3edj+I+XxPtJDMJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255569; c=relaxed/simple;
	bh=Ogyi3PaR6JS124w27xF2PQSoyynE0cZMbp5AlEE0Wrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCBQoGKxaejn6VTlhJhINVSdGoijU8FqFdgfwNPrSfjh487fxgMwGH4Tu8Mqf71BDZt/lE5YQieOQ7VdISiTTTp0qQs085VA3Fg//6jtuETjQj8nJzsf1twNyL6WzJdj9ySpop9pixLyHt6REZXKDYNCq9bn8a7D/Pk4Mh5ETQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=OkJO5ngE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224100e9a5cso95944635ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742255565; x=1742860365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxmDLHNz0YKCNn7QowjgfshGeZoAAPDlOKgnwh1cfXM=;
        b=OkJO5ngE2QI7abPqCB16hyBnhdfVns9QJN7s3MWyZVYc9anguyuidCF7bGnawRXi8v
         UAvgl4qcE+b7UKtVciRKfS4IrsC1aS3kIEjWqhJGMcnQcCchILg1MAowJSlCUTJLThAy
         0vVwdN3XTsPR8kOyMAva8m5LvMf6CQn1rNkC0qZN46nXveyBkIRqnYPq+So1TZrnUdgj
         f6Q8m1RrE9iAexlQzkgJCr8KKUqrFYjE9HQTDicozI/Sxr3P+Z8JaNLEIEtoQXt4z/8N
         42HAVoCmRMLZek1La/d0+yNweZV/nSsfZ3GD0PdkBTHdRa9+ztKhk4lIZ3oqMaGwrrmw
         GU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255565; x=1742860365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxmDLHNz0YKCNn7QowjgfshGeZoAAPDlOKgnwh1cfXM=;
        b=lrOBWfxRgrsuwYXwH7yqmAplsjr5NP2gkpWgvbe2wAS7vIKqBjlfRnO/ey1g9OHE3Y
         FDd1dgD7Pv9ur5PlpmlTcE6zV31nJO2tK9Al/xht7g2p0tYNIU8yYAAIYPzFlVrULqDm
         mreshNaAwGEaODFofM6BAeJqZ+3hIiG2WbNfskOKAQQtSj/pHwvHfJhF5Ig8oJ6W//zH
         iFjN6RrXX4SASLe4j97YMnWw2h/q80DaquTdPuCIAASC/TB6HODc2b5B64AGuhxJuKtp
         6nwDE1V9zqcpZcmqKZJHP20zA7mZaDRwqYLbIsIsDMVQtCWw3aZfaHaDK35YGnAIbSXA
         qYBA==
X-Forwarded-Encrypted: i=1; AJvYcCXy/v+t50ZmPUTYampfzsZQAjxgT3/vK8yKQ4g3nVnFP9zGwI4Gof6fmxWJpDy9lIIJ4EmWmFqbppRK7qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNtqL1qVXaoeXe4nfhEPxrkUU/k+92bmR1/RnjwsI6DIQtZ9Q
	H93YmkaOAtMGZHIDN68fdN7U4nruXheY852d2buuUYiLpIxgoC8qtKLnQSGXhQ==
X-Gm-Gg: ASbGnctRazl6Yk2CWtxgYy2HsJYvvO6LEN+0bU5e4vHpnPQmeoPx62dvd8rkRZwTcHR
	Jxpz3nSTlJMBMc/y4FoRoHgKHWxzqzPtvglH8Iv27uJZ2nnJfEGPMigI8kocBdkkVVnZtp8GIiz
	4hkPjA3bgALO+1WtKRgVYYOnDBfVHIiXmAzc+lcMVlls71NsYaroIOFEb+mVi5baNuSoke99XCi
	oQvxYmbqZwPVQviZVz3/lGZv3N00StRsXq/o6guNsruk7MO6t3DDMR+7nsY0QPp+RjbK6BM8kUy
	BsRZWho3GFQlQxOzBWUz9fhST6oJg/eGv/Kemyq2iMrAjKsDIrdYvULhzV1owNQncg==
X-Google-Smtp-Source: AGHT+IHEaWFQPJgATLqlBvt+CrmK5I3xjJbeWq+yPmOIb1jAsrVlkN08/4lnKJV9n6F8WYuZ0znVBg==
X-Received: by 2002:a17:903:1c7:b0:224:160d:3f54 with SMTP id d9443c01a7336-225e0a9860dmr158406905ad.31.1742255565320;
        Mon, 17 Mar 2025 16:52:45 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167da28sm8235760b3a.89.2025.03.17.16.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 16:52:44 -0700 (PDT)
Message-ID: <ac5b93be-5b9c-4d39-bce6-a78032e43fbf@tenstorrent.com>
Date: Tue, 18 Mar 2025 10:52:39 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3 0/4] riscv: uaccess: optimizations
To: Ben Dooks <ben.dooks@codethink.co.uk>, Alexandre Ghiti <alex@ghiti.fr>,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 charlie@rivosinc.com, jrtc27@jrtc27.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <4f6c83c0-39f6-467d-83c6-13d37440fb20@ghiti.fr>
 <5a81a72d-550d-42b4-8549-176f2b27ffc9@codethink.co.uk>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <5a81a72d-550d-42b4-8549-176f2b27ffc9@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/3/2025 12:49 am, Ben Dooks wrote:
> On 14/03/2025 13:28, Alexandre Ghiti wrote:
>> Hi Cyril,
>>
>> On 21/02/2025 01:09, Cyril Bur wrote:
>>> This series tries to optimize riscv uaccess by allowing the use of
>>> user_access_begin() and user_access_end() which permits grouping user 
>>> accesses
>>> and avoiding the CSR write penalty for each access.
>>>
>>> The error path can also be optimised using asm goto which patches 3 
>>> and 4
>>> achieve. This will speed up jumping to labels by avoiding the need of an
>>> intermediary error type variable within the uaccess macros
>>>
>>> I did read the discussion this series generated. It isn't clear to me
>>> which direction to take the patches, if any.
>>>
>>> V2:
>>> I've taken on this series as there isn't any response from Jisheng. No
>>> significant changes other than build fixes.
>>> - Fixes build breakage in patch 3 to do with not having used 'goto' 
>>> keyword.
>>> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr 
>>> in the
>>>    macro.
>>>
>>> V3:
>>> Significant commit message rewrites.
>>>   - Corrected the justification for patch 2
>>>   - Better explained/justified patches 3 and 4
>>> Minor code changes for legibility and more comments.
>>>
>>> Jisheng Zhang (4):
>>>    riscv: implement user_access_begin() and families
>>>    riscv: uaccess: use input constraints for ptr of __put_user()
>>>    riscv: uaccess: use 'asm goto' for put_user()
>>>    riscv: uaccess: use 'asm_goto_output' for get_user()
>>>
>>>   arch/riscv/include/asm/uaccess.h | 205 +++++++++++++++++++++++--------
>>>   1 file changed, 152 insertions(+), 53 deletions(-)
>>>
>> Following up on Ben's comment here https://lore.kernel.org/linux- 
>> riscv/ b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk/
>>
>> The problem that Ben mentions is caused by the use of *macros* which 
>> used to make the evaluation of the parameter inside the user- 
>> accessible section, and since this parameter could be a sleeping 
>> function, we could schedule another process with the SUM bit set, 
>> which could be cleared by this process, which would make the first 
>> process fault when trying to access user memory. I did not find any 
>> macro using unsafe_XXX() functions which could cause a problem right 
>> now, but I may have missed one and new could come up later, so we have 
>> multiple solutions here:
>>
>> - suppose that a macro using unsafe_get/put_user() and passing a 
>> sleeping function as argument won't happen and then do nothing
>> - or save/restore CSR sstatus when switching processes
>> - or simply check that SUM is not set when switching processes
>>
>> Let me know what you think.
> 
> I'm on the save the flag side, for these reasons:
> 
> #1 sleeping functions can happen more often when various checks
>     get enabled in the kernel (this was why the original fault
>     was found).  Adding larger sections is just going to make
>     the fault pop up again at some point in the future.
> 
> #2 the save/restore is a small addition to the swap registers
> 
> #3 saving SUM over a regs swap is always going to make sure we
>     never see this gremlin turn up again
> 
> FYI, I think I may have posted our original test thread at some
> point, but I could do so again.

Yes, after Ben pointed out the issue I came to the conclusion we 
probably want Bens patch which saves the bit. Apologies if I didn't 
express this thought in email.

I'm happy to take the patch and put it on the front of this series, 
although perhaps it makes more sense you to revive the patch since 
you're still around Ben?

> 
>>
>> Thanks,
>>
>> Alex
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
> 
> 


