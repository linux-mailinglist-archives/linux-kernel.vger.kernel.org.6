Return-Path: <linux-kernel+bounces-406303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5AF9C621F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A9B2BDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CA20513F;
	Tue, 12 Nov 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSvDRmH1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA01B81B8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428525; cv=none; b=RGvTyFc/1yG7e4cjUmBCYagIMEXhAOAb/gIyCd7uE3OfDHcWKlN48bgM9FkmbfD55TRN90cW3aLfdvrsz+BD2T9XKDhOYef53+U03TsPCk8k0C1P3rC/t6XW0szPZ1FpXPLJC76OttPdc1JotLkKrHdxP2BbIqQ6Acy06mPQGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428525; c=relaxed/simple;
	bh=f2Hx4MslkMtUDBXQ/4zIbsyudmcbgA5Ak18oOO4BnPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jr+QjOfBKHOOaMjSsXdxYkWF+LmwZVyKh6nCjkrl52ge62bDVbqiSZJarVdvXYFP7CCYJN4NLWUeghTGxeU9/jKUb2XUfcfR0xlyRlRqXoaKOOHBqjXMnFrU6mXrsj150jg15GMKtriQUwt4KQFU2xT3Kg55XY0oscbnHY//xEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSvDRmH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731428521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TvpJuJjPw1WD4k1hZ/W3RXwcyzSl2e50htx7m1tPNM=;
	b=FSvDRmH1jnAs2mY7Q/Nz66wLzj1HMVsbTlwnRzYCA1yeeojNhBpEPQRvN6eGpeMi0vdHqf
	S9Vd9T2qvoe5xS/J74hC8bMrpy1EYtlKH+ZM9ZGjwO1WAWCVi6Tx52a4/jyF5tWuLIyGVp
	T6S5TDozyA3pxIvif4w/iaG8xu/FK2I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-nK_TaLyDOgKgmkXfRpVIFw-1; Tue, 12 Nov 2024 11:22:00 -0500
X-MC-Unique: nK_TaLyDOgKgmkXfRpVIFw-1
X-Mimecast-MFC-AGG-ID: nK_TaLyDOgKgmkXfRpVIFw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so41524815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428519; x=1732033319;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+TvpJuJjPw1WD4k1hZ/W3RXwcyzSl2e50htx7m1tPNM=;
        b=LtHwy815dBpcrFffZs/M/vMVJFX6IHMtnSKozLO1O4m0Xn6LI1M1JdgYeXe/JZViYn
         BnkocHBTkOq4ehj8X8AmR7pvjVXhVByZSK9zYR36zWdHvyDaeIUTRrgxLoQtKdoyoU8x
         52d7M6Br7hAyb4g9CwfOGmIOsln4yTO0kRC34Yi6n0/K+7WWcR4gf8CuIzJYUu6GKOin
         N84tbrijjbfoLThULAGDQk7E/W2SlAzGPZ1gpyfd6N14qTOLoroUqne9Dk2kOwpltvTI
         F8FoFYkZS32rc4tlp2s3wAM0xvmKUCgndufqfoe0fBCfzH8XFurx3j5Pnp0unlbx5xkj
         rnYA==
X-Forwarded-Encrypted: i=1; AJvYcCVPM0RaWMxEtk/z6bBN/r/DzLEdkALtW6eIzGAx9y3F+vPA8fGhcVpIwrZVdTvSrDzyf35Y6UVnHPGFGX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2uL0mlpUs5OhVHDTfuHZerXreelM6CrTSbPrF2ZDVzX5L7k0
	fN/bKcPjIlW+lAWqEpTqdtGGOOGy/Rn8hLI33vWBraGmdY45w8J1nO86+dMiOVWjIO27H5QR/sI
	oWFxXWUBIhHWGrPX4b1fq89AzTWxvbsjF1nuwJbQ697EAIWiLK7h0DPCFiaVsWQ==
X-Received: by 2002:a05:6000:1ac5:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-381f1847299mr13299278f8f.48.1731428518769;
        Tue, 12 Nov 2024 08:21:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcuwdrmkTQadmPP89GAdAxq/Ds+KFC4GpuRx/4a99SD6spCp9GBST++M3sOPywZ47Q2d2loA==
X-Received: by 2002:a05:6000:1ac5:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-381f1847299mr13299259f8f.48.1731428518337;
        Tue, 12 Nov 2024 08:21:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda03e42sm16074764f8f.89.2024.11.12.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:21:57 -0800 (PST)
Message-ID: <d1812c17-0036-407f-9ac3-207705341d5e@redhat.com>
Date: Tue, 12 Nov 2024 17:21:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: shmem: add large folio support for tmpfs
From: David Hildenbrand <david@redhat.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
 <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.24 17:19, David Hildenbrand wrote:
> On 12.11.24 08:45, Baolin Wang wrote:
>> Add large folio support for tmpfs write and fallocate paths matching the
>> same high order preference mechanism used in the iomap buffered IO path
>> as used in __filemap_get_folio().
>>
>> Add shmem_mapping_size_orders() to get a hint for the orders of the folio
>> based on the file size which takes care of the mapping requirements.
>>
>> Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
>> with other file systems supporting any sized large folios, and extending
>> anonymous to support mTHP, we should not restrict tmpfs to allocating only
>> PMD-sized huge folios, making it more special. Instead, we should allow
>> tmpfs can allocate any sized large folios.
>>
>> Considering that tmpfs already has the 'huge=' option to control the huge
>> folios allocation, we can extend the 'huge=' option to allow any sized huge
>> folios. The semantics of the 'huge=' mount option are:
>>
>> huge=never: no any sized huge folios
>> huge=always: any sized huge folios
>> huge=within_size: like 'always' but respect the i_size
>> huge=advise: like 'always' if requested with fadvise()/madvise()
>>
>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
>> allocate the PMD-sized huge folios if huge=always/within_size/advise is set.
>>
>> Moreover, the 'deny' and 'force' testing options controlled by
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
>> semantics. The 'deny' can disable any sized large folios for tmpfs, while
>> the 'force' can enable PMD sized large folios for tmpfs.
>>
>> Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>    mm/shmem.c | 91 +++++++++++++++++++++++++++++++++++++++++++++---------
>>    1 file changed, 77 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 86b2e417dc6f..a3203cf8860f 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -549,10 +549,50 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>>    
>>    static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>>    
>> +/**
>> + * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
>> + * @mapping: Target address_space.
>> + * @index: The page index.
>> + * @write_end: end of a write, could extend inode size.
>> + *
>> + * This returns huge orders for folios (when supported) based on the file size
>> + * which the mapping currently allows at the given index. The index is relevant
>> + * due to alignment considerations the mapping might have. The returned order
>> + * may be less than the size passed.
>> + *
>> + * Return: The orders.
>> + */
>> +static inline unsigned int
>> +shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
>> +{
>> +	unsigned int order;
>> +	size_t size;
>> +
>> +	if (!mapping_large_folio_support(mapping) || !write_end)
>> +		return 0;
>> +
>> +	/* Calculate the write size based on the write_end */
>> +	size = write_end - (index << PAGE_SHIFT);
>> +	order = filemap_get_order(size);
>> +	if (!order)
>> +		return 0;
>> +
>> +	/* If we're not aligned, allocate a smaller folio */
>> +	if (index & ((1UL << order) - 1))
>> +		order = __ffs(index);
>> +
>> +	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>> +	return order > 0 ? BIT(order + 1) - 1 : 0;
>> +}
>> +
>>    static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>>    					      loff_t write_end, bool shmem_huge_force,
>> +					      struct vm_area_struct *vma,
>>    					      unsigned long vm_flags)
>>    {
>> +	unsigned long within_size_orders;
>> +	unsigned int order;
>> +	pgoff_t aligned_index;
>>    	loff_t i_size;
>>    
>>    	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
> 
> We can allow all orders up to MAX_PAGECACHE_ORDER,
> shmem_mapping_size_orders() handles it properly.
> 
> So maybe we should drop this condition and use instead below where we have
> 
> return BIT(HPAGE_PMD_ORDER);
> 
> instead something like.
> 
> return HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 : BIT(HPAGE_PMD_ORDER);
> 
> Ideally, factoring it out somehow
> 
> 
> int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 :
> BIT(HPAGE_PMD_ORDER);
> 
> ...
> 
> return maybe_pmd_order;
> 
>> @@ -564,15 +604,41 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>>    	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>>    		return BIT(HPAGE_PMD_ORDER);
> 
> Why not force-enable all orders (of course, respecting
> MAX_PAGECACHE_ORDER and possibly VMA)?
> 
>>    
>> +	/*
>> +	 * The huge order allocation for anon shmem is controlled through
>> +	 * the mTHP interface, so we still use PMD-sized huge order to
>> +	 * check whether global control is enabled.
>> +	 *
>> +	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
>> +	 * allocate huge pages due to lack of a write size hint.
>> +	 *
>> +	 * Otherwise, tmpfs will allow getting a highest order hint based on
>> +	 * the size of write and fallocate paths, then will try each allowable
>> +	 * huge orders.
>> +	 */
>>    	switch (SHMEM_SB(inode->i_sb)->huge) {
>>    	case SHMEM_HUGE_ALWAYS:
>> -		return BIT(HPAGE_PMD_ORDER);
>> -	case SHMEM_HUGE_WITHIN_SIZE:
>> -		index = round_up(index + 1, HPAGE_PMD_NR);
>> -		i_size = max(write_end, i_size_read(inode));
>> -		i_size = round_up(i_size, PAGE_SIZE);
>> -		if (i_size >> PAGE_SHIFT >= index)
>> +		if (vma)
>>    			return BIT(HPAGE_PMD_ORDER);
>> +
>> +		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
>> +	case SHMEM_HUGE_WITHIN_SIZE:
>> +		if (vma)
>> +			within_size_orders = BIT(HPAGE_PMD_ORDER);
>> +		else
>> +			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
>> +								       index, write_end);
>> +
>> +		order = highest_order(within_size_orders);
>> +		while (within_size_orders) {
>> +			aligned_index = round_up(index + 1, 1 << order);
>> +			i_size = max(write_end, i_size_read(inode));
>> +			i_size = round_up(i_size, PAGE_SIZE);
>> +			if (i_size >> PAGE_SHIFT >= aligned_index)
>> +				return within_size_orders;
>> +
>> +			order = next_order(&within_size_orders, order);
>> +		}
>>    		fallthrough;
>>    	case SHMEM_HUGE_ADVISE:
>>    		if (vm_flags & VM_HUGEPAGE)
> 
> I think the point here is that "write" -> no VMA -> vm_flags == 0 -> no
> code changes needed :)

... and now I wonder about documented "fadvise", because this here is 
only concerned with madvise?

-- 
Cheers,

David / dhildenb


