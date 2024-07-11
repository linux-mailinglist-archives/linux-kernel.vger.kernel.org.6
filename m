Return-Path: <linux-kernel+bounces-249887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD892F12E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE262B212BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E01A01A6;
	Thu, 11 Jul 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNzKOSyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5B19F461
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733636; cv=none; b=tvoqDz2uqt+16WQDnx3Joi8XcrvvP3GmBm8mM47+AjrhqqP86eXhiDhvQy4+KMmulY1Qv7C0Z0dB6mLuxvX5LC9U0uJvuyKh0HIVQobHaS8yrAQNZkonMf7gucBT/PQUNDl1sPLXqqsr8wa8Zs6SnKJQpeqPWQr7Zd2o0l329Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733636; c=relaxed/simple;
	bh=TrvfVsxFxkfG3CbvoFQgedFk5JHpPhXLX37ab8sPnlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVTBDEP2f03TPXs+0xgAnZ4Y8JPkPXosyGnk1g9oRRXYp15BAeLB+GTpHkV5vFd2faQvJM0XxX5lNDXhhcDS6y5Sa0BhXnxK29Dc4RGW3fQ8aU/CS1be35BhBTc59ngvJUE6AhNiln61JF4p4TksTNromBJIpj7LFxsOTUv6VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNzKOSyj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720733633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=219lIAcvA7w+sSpZLZf099JtfoSJ9jRz/h7DHoP3yqk=;
	b=RNzKOSyjTriSz+2DIunQtMJRz2tbxU2BKPul0AnZVYPMpWRXv2a29vfaYs/lETGdGwIEmT
	yyBJUhxskHHQql1zR4JCFXfyZWBTB/3Remegv/2hWn7HW8lfmfpUOkXXd2FbENgKfOtbmG
	lk2OV+Uxjyr5ZlyZat6Ajqk46B9KjR0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-TwYJffRyOcCLZyd27y6c_w-1; Thu, 11 Jul 2024 17:33:51 -0400
X-MC-Unique: TwYJffRyOcCLZyd27y6c_w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70af524f6b9so1023423b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733631; x=1721338431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=219lIAcvA7w+sSpZLZf099JtfoSJ9jRz/h7DHoP3yqk=;
        b=Eqii83qBEpzeNhWQ9NLLf+H32I/lWsuiorRGfalfaAGecU1N/vZ6axHxCoZu73/gZ5
         RA3umQUquCEzhz/Ora+3BUO4wK80krgL26h+XFzrvzcgwyigKtVTYFQtY1ENzQOFTeV1
         9Ukg9OiKq9JmNwpqhz4w4vGSm/nMTEMA5kxS6EZyRinop4efVHuK2XMJ2cbmtJfJO1dB
         ups2gltLR0WD9eCXoJGXmW4LSn2ODAy3uy9XUCv0aJpqewoOpjZGX0uNvfBfVdb8UfBo
         OUlWnuwtNiyNAY5JGQwObJewZuKt1agnkHlRpJB7bFmQ3He+jnaqzd6e+2KoICaE8zc/
         Y3rg==
X-Forwarded-Encrypted: i=1; AJvYcCX9MAGIBk4bShKOTYYx20f8dwYXbpoSrIWjSxPRsEmZgOpnK60W7lnTH/g0cDtLg96Y70i4imfE5786499VvVZXf4y/786VTdNodx6i
X-Gm-Message-State: AOJu0Yw91sEdwxR5GQZ093xjTmN8ztwKiBRDnhWwq4yxH4fy/CK0Gxyr
	yeFv0OkNpJn2wNytvjtx64pwwQciZyKEHYTYFwpWKGZd30/9cLk1rHluDWnPocsnghaVQp5ypd6
	cc373fER73Q/Sk1sM7P1FJdVgT/v0mG+mczVLu40G+pR1GodYDuiTpgl4xM9xu/sHsPqgu8mm
X-Received: by 2002:a05:6a00:23d5:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-70b43538665mr10390210b3a.8.1720733630505;
        Thu, 11 Jul 2024 14:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtilW6Oy1FkkMUoO1+Zz+4/UURSKtlBsEUQhFqOcBShJGklujlaJCWSbde9Mrk6SD1Lebztw==
X-Received: by 2002:a05:6a00:23d5:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-70b43538665mr10390186b3a.8.1720733630017;
        Thu, 11 Jul 2024 14:33:50 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54edbc49sm3641353b3a.22.2024.07.11.14.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:33:49 -0700 (PDT)
Message-ID: <92a2dc30-6e48-44ea-9cde-693b911f200d@redhat.com>
Date: Thu, 11 Jul 2024 23:33:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
To: Pei Li <peili.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
References: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 07:13, Pei Li wrote:
> This patch fixes this warning by acquiring read lock before entering
> untrack_pfn() while write lock is not held.
> 
> syzbot has tested the proposed patch and the reproducer did not
> trigger any issue.
> 
> Reported-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
> Tested-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot reported the following warning in follow_pte():
> 
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980
> 
> This is because we are assuming that mm->mmap_lock should be held when
> entering follow_pte(). This is added in commit c5541ba378e3 (mm:
> follow_pte() improvements).
> 
> However, in the following call stack, we are not acquring the lock:
>   follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
>   get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
>   untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
>   unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
>   zap_page_range_single+0x326/0x560 mm/memory.c:1920

That implies that unmap_vmas() is called without the mmap lock in read 
mode, correct?

Do we know how this happens?

* exit_mmap() holds the mmap lock in read mode
* unmap_region is documented to hold the mmap lock in read mode

> 
> In zap_page_range_single(), we passed mm_wr_locked as false, as we do
> not expect write lock to be held.
> In the special case where vma->vm_flags is set as VM_PFNMAP, we are
> hitting untrack_pfn() which eventually calls into follow_phys.
> 
> This patch fixes this warning by acquiring read lock before entering
> untrack_pfn() while write lock is not held.
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Tested on:
> 
> commit:         9d9a2f29 Merge tag 'mm-hotfixes-stable-2024-07-10-13-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13be8021980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
> dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=145e3441980000
> 
> Note: testing is done by a robot and is best-effort only.
> ---
>   mm/memory.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d10e616d7389..75d7959b835b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1815,9 +1815,16 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>   	if (vma->vm_file)
>   		uprobe_munmap(vma, start, end);
>   
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> +	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
> +		if (!mm_wr_locked)
> +			mmap_read_lock(vma->vm_mm);
> +
>   		untrack_pfn(vma, 0, 0, mm_wr_locked);
>   
> +		if (!mm_wr_locked)
> +			mmap_read_unlock(vma->vm_mm);
> +	}
> +
>   	if (start != end) {
>   		if (unlikely(is_vm_hugetlb_page(vma))) {

I'm not sure if this is the right fix. I like to understand how we end 
up without the mmap lock at least in read mode in that path?

-- 
Cheers,

David / dhildenb


