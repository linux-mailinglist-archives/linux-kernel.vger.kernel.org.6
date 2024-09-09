Return-Path: <linux-kernel+bounces-320697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2D970EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBE1C21EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E361AD9C5;
	Mon,  9 Sep 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg1OTe5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76391AC45F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864777; cv=none; b=FMWb0ozJLropvPBbrlrXr5O2+p9UEZ8csP8Nv4xiYJWaDxlHutqwoJUguHk/9Ez8IRrMX4uN1F+sxFuceZJiVLLBjb+0JqX8hCqVPgRQuftcSj5sqATYpgls2VcCxQzbPTBsLnvFnVVVxlnpffRFuiuCIEHvQcIs1y7aTX16GzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864777; c=relaxed/simple;
	bh=9b7fqe9jkGO2HNBo7w084akMZNA6QrDWPar/37Wp64U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7ORhqJ4/Y7CoJmMBMMCw9eRWFBg5Dd6rR2JG9kFQHmrpT1KmoB9kbPSBSzxWO7vAQTVqGFARTM1jV5qlWA7es/58VFPqrjufatOfP8uWWB7iw36LYhK4Xaxf/tQkv9/YoN7YtfEbTzzCBrhr+OuT6mVns+ZsujPJg+W3i9xYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg1OTe5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725864774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6ldlxIUIxz9PMwIPuRGbJke4NEJrcBKYGMDTWZ+d5PI=;
	b=Sg1OTe5HoeLSPDXyI9dRtWvoCCaLMgR5hlyaaG4wQVoQqGb652DvNv0WFjkj/mU1YtYggb
	y/BQnDwCHP9a87XkPrMMtTTKg63Lrbdo27TDsNsupy9ZlaKRSoFhr0+sSvFwu+WpusJTWN
	BMNzd4PV5YgswYm5dVlmcwK4u9HyWeg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-rPL-eJGYOhW37_Zp4MDomg-1; Mon, 09 Sep 2024 02:52:53 -0400
X-MC-Unique: rPL-eJGYOhW37_Zp4MDomg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c25d886aso1891821f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 23:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864772; x=1726469572;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ldlxIUIxz9PMwIPuRGbJke4NEJrcBKYGMDTWZ+d5PI=;
        b=uawqUFvhzIsXYUBDK7AgK/f776lPKOwpOUzIIc9oIiahLaVrCYFksBkzHrISmkWlK6
         5ODX+g/sr0nMN/1QOb0FKiB+n+ktlDIDGykbqsdJU9LjjksxT0vmDEYLx/EgW8jYMSde
         8geKmmfT3CJfqaZnNZWvhS6a1spsxvaZyCFC5O72eA7JOgy+rALERuzg56EbuDcHOnG3
         IGu3J6HjmMQ2PVZH73haBGdvJ+YGe7kOmyyCVSJ9xIf5pHeip1X3Mua8P/AOdKgZLnUd
         bNxGLl+SKigH94Xf9P47aJ7yYyKvYs7dmz6oeUBNVQZGvWwNLREw98mhIBxbGa1ZN5w0
         CMXw==
X-Forwarded-Encrypted: i=1; AJvYcCUV5uqzGLNKfbRCgAfmcmvKQDkzeR+czi97rd0cRMO718ry7Y9NfuKh17TiKr+aTgsLSl+NSad5Cz/umRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqk+EZaI68WAMQ3mBcrd5a2Q/PtZHm2tIhqI6cirDqiJcEPNGe
	xXOlkSSwdX4rkGlOU3awZdxDsxHr+HhTghwRfA3lcjRtxgxT7OUIhmOmTOVuZU8SgwLUmWLNmQn
	C5CVfLBzIVFnaR3GTF31+sfJyokPp2lx/lBOKimrfwebImcfylNkOFhu97SsG7A==
X-Received: by 2002:adf:f345:0:b0:374:bf1b:1c20 with SMTP id ffacd0b85a97d-378895d5070mr5933145f8f.23.1725864771853;
        Sun, 08 Sep 2024 23:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeEKW7DI+Z07LQyu6RTLl3cS3isjixZwTR6/NCxMk5ZrCmTgto7iVTVDZ056KFYKGSKNHOIQ==
X-Received: by 2002:adf:f345:0:b0:374:bf1b:1c20 with SMTP id ffacd0b85a97d-378895d5070mr5933130f8f.23.1725864771221;
        Sun, 08 Sep 2024 23:52:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee? (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de. [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf33e9b2sm65306325e9.14.2024.09.08.23.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 23:52:50 -0700 (PDT)
Message-ID: <6e02b962-14e2-48d3-ab26-d6de38dd9eda@redhat.com>
Date: Mon, 9 Sep 2024 08:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix khugepaged activation policy for shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <7c796904528e21152ba5aa639e963e0ae45b7040.1725600217.git.baolin.wang@linux.alibaba.com>
 <58cf63c1-25e5-4958-96cb-a9d65390ca3e@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <58cf63c1-25e5-4958-96cb-a9d65390ca3e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.09.24 10:55, Ryan Roberts wrote:
> On 06/09/2024 06:28, Baolin Wang wrote:
>> Shmem has a separate interface (different from anonymous pages) to control
>> huge page allocation, that means shmem THP can be enabled while anonymous
>> THP is disabled. However, in this case, khugepaged will not start to collapse
>> shmem THP, which is unreasonable.
>>
>> To fix this issue, we should call start_stop_khugepaged() to activate or
>> deactivate the khugepaged thread when setting shmem mTHP interfaces.
>> Moreover, add a new helper shmem_hpage_pmd_enabled() to help to check
>> whether shmem THP is enabled, which will determine if khugepaged should
>> be activated.
>>
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Hi Ryan,
>>
>> I remember we discussed the shmem khugepaged activation issue before, but
>> I haven’t seen any follow-up patches to fix it. Recently, I am trying to
>> fix the shmem mTHP collapse issue in the series [1], and I also addressed
>> this activation issue. Please correct me if you have a better idea. Thanks.
> 
> Thanks for for sorting this - it looks like a good approach to me! Just a couple
> of nits. Regardless:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
>>
>> [1] https://lore.kernel.org/all/cover.1724140601.git.baolin.wang@linux.alibaba.com/T/#u
>> ---
>>   include/linux/shmem_fs.h |  6 ++++++
>>   mm/khugepaged.c          |  2 ++
>>   mm/shmem.c               | 29 +++++++++++++++++++++++++++--
>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 515a9a6a3c6f..ee6635052383 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -114,6 +114,7 @@ int shmem_unuse(unsigned int type);
>>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>>   				loff_t write_end, bool shmem_huge_force);
>> +bool shmem_hpage_pmd_enabled(void);
>>   #else
>>   static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   				struct vm_area_struct *vma, pgoff_t index,
>> @@ -121,6 +122,11 @@ static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   {
>>   	return 0;
>>   }
>> +
>> +static inline bool shmem_hpage_pmd_enabled(void)
>> +{
>> +	return false;
>> +}
>>   #endif
>>   
>>   #ifdef CONFIG_SHMEM
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f9c39898eaff..caf10096d4d1 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -430,6 +430,8 @@ static bool hugepage_pmd_enabled(void)
>>   	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>>   	    hugepage_global_enabled())
>>   		return true;
>> +	if (shmem_hpage_pmd_enabled())
>> +		return true;
> 
> nit: There is a comment at the top of this function, perhaps that could be
> extended to cover shmem too?
> 
>>   	return false;
>>   }
>>   
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 74f093d88c78..d7c342ae2b37 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1653,6 +1653,23 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>   }
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +bool shmem_hpage_pmd_enabled(void)
>> +{
>> +	if (shmem_huge == SHMEM_HUGE_DENY)
>> +		return false;
>> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_always))
> 
> question: When is it correct to use HPAGE_PMD_ORDER vs PMD_ORDER? I tend to use
> PMD_ORDER (in hugepage_pmd_enabled() for example).

I think the HPAGE_PMD_ORDER thingy originally was introduced to detect 
code that is supposed to handle THPs, but really cannot handle them 
properly -- e.g., no arch support, not enabled in the kernel config.

My take is that we should start removing this HPAGE_* stuff.

-- 
Cheers,

David / dhildenb


