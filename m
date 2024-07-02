Return-Path: <linux-kernel+bounces-237810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9182923E69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA12831EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3C19D8BC;
	Tue,  2 Jul 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZVPu2EP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD716C440
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925776; cv=none; b=lFlf3sYUsWJRpZZH+CCDiCI10RvQsAP/HrnFjTxARCKd8UfoEgxHUahFngQMWH+mVytPeUhRs2SoYdYWPkT6do+yXKsyMbZLn7o+8Ut38SRcNKU3wYrfOuVIvY0f5Y+vsuBg3FdnsSrEvyKxYFWWEDYa787W6dUXjlAuTDtkcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925776; c=relaxed/simple;
	bh=8keV/pZ9nP1gtGLFXfiQKS1ttVGtnW+3nueOmMpK4cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK68TGJeukU6gvmVYLc55QpldLrWAd8XDD06JIMzuVca5LTQeO7583zlLecMVDgOGmTiyZF65VMFBXopVGqIoSAY17w8bpL58QsSdG/iKEoXeFwH2anSltstloBsIZancZOiwf+U7yNqf96/zty039xUXMDtKKx2B6WQE+HvrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZVPu2EP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719925774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yGUSClHeMzg6nbPRrAvX7VyagP9LdEEerfHwKxYR08g=;
	b=IZVPu2EPlwVKcczBxLBwCbRGo7SwCNcH1Z+OmPG/htKfYOKD/z6ZXKHw60U39HIDzE4TBN
	UaTXYByy+uZt9I7wOC/AOPOTXKfpoHrQqAgckgTYrHHrwXgoG4faIb9ak+C0oaaZOZwaLO
	KyIc+3h6nLzDIKKAvTrb9dfVAUnC/ik=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ZXinpeeLOlOiE83pPhXsKw-1; Tue, 02 Jul 2024 09:09:32 -0400
X-MC-Unique: ZXinpeeLOlOiE83pPhXsKw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ecb37356edso33008521fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925771; x=1720530571;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGUSClHeMzg6nbPRrAvX7VyagP9LdEEerfHwKxYR08g=;
        b=Vb6EgC/xnwrdqanXQQsooVxRVzGK/ggz6qcwsYfokcF9Q8d9roFKCm97+CdfLzW2Zv
         Wgt/qQlYPYPEaTPlfQtctvD9MbDWZ1w32Vlm8KFdTuyc1Y2vPBHDafWJfmnf3H2xPm6o
         NEBgyBKpr/Z0yTT19jslYJ3evW/7VAACfJozqYuFnCKR6X2R68swRWZ5z+kMEaPaGHWY
         cDuXN+UUl44b4gw31DRPJ2vwLVOU0j3ANr/5Kii+Brk2UXSuDsp1q7X6LWkpmNpIWHbf
         Wsbwv8wFbHovhWZLFDoPWYfz8xiaiOetQ/oGWOwkoN8Vz/qwFQSqbzGQenI4+2Bsq14B
         hZBA==
X-Forwarded-Encrypted: i=1; AJvYcCX3dS3xJs133VGt6n4Xq2NNZKGXdlh5avfrpb5tv4m5ZWD1760zVrSoQinpv4/XUI9PRlV2TzDME8dekzNvyiww9PA6IsmwVWqxXzh3
X-Gm-Message-State: AOJu0Yy1YklOIsFsDnyHtg2+Vq/fjIHNhECjgCCuKDU5ZDq9H2j57tGz
	jpLU3BrP3mnoCNgsHyzgKZD7pUeo8zXWWbNzQR6NaOj26y+nwpJzRqEydPfBWdYRYdQPX9RYx11
	fWsSOfjeufbW0bFdI1S4F19ARS4voMogWj66uynSiHLko1kSOURi9gRuoaHdLAg==
X-Received: by 2002:a2e:b52f:0:b0:2ec:5a85:66ec with SMTP id 38308e7fff4ca-2ee5e6f53e0mr52093211fa.48.1719925771129;
        Tue, 02 Jul 2024 06:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElp/GUCQIPCGUan1vDspIbGqVIvT/w73lPBqY8eNvOW5s0aY67EApd7i7oGUnP2lLKZ783BQ==
X-Received: by 2002:a2e:b52f:0:b0:2ec:5a85:66ec with SMTP id 38308e7fff4ca-2ee5e6f53e0mr52092681fa.48.1719925769680;
        Tue, 02 Jul 2024 06:09:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b06377dsm199222015e9.28.2024.07.02.06.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 06:09:29 -0700 (PDT)
Message-ID: <fcf036e1-d65c-4a4b-9280-19024bb4da1b@redhat.com>
Date: Tue, 2 Jul 2024 15:09:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZoPz14fYSqVyvRTw@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 14:34, Catalin Marinas wrote:
> On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
>> MTE can be supported on ram based filesystem. It is supported on tmpfs.
>> There is use case to use MTE on hugetlbfs as well, adding MTE support.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   fs/hugetlbfs/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index ecad73a4f713..c34faef62daf 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>   	 * way when do_mmap unwinds (may be important on powerpc
>>   	 * and ia64).
>>   	 */
>> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>>   	vma->vm_ops = &hugetlb_vm_ops;
> 
> Last time I checked, about a year ago, this was not sufficient. One
> issue is that there's no arch_clear_hugetlb_flags() implemented by your
> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
> initially tried to do this only on the head page but this did not go
> well with the folio_copy() -> copy_highpage() which expects the
> PG_arch_* flags on each individual page. The alternative was for
> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.

This would likely also add a blocker for 
ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP on arm64 (no idea if there are now 
ways to move forward with that now, or if we are still not sure if we 
can actually add support), correct?


-- 
Cheers,

David / dhildenb


