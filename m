Return-Path: <linux-kernel+bounces-252806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736493184D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F6B1C215DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157371CAB3;
	Mon, 15 Jul 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4LA6Xlj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C391CD0C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060008; cv=none; b=cfIUh0/8kuX9+Iv1U45LhUoDjN6gLHXO4MA2DZ8BPznM+KKSbcB2TUn/+lQVCtpRmU/bpSmvxnsMvZ+N0mHaMAKdAoukmVgVJSgJ9el3MgoqpGGLF2GnjGxynjY9DvJ58uJAz1CwXkIiKPo7rMYQPJLVCaQy3qtou8pYP4S8tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060008; c=relaxed/simple;
	bh=uFG7cks4+8rIYWcWkztdf5fexMFjSjhJlAj9WO/mMcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnUdVOXksz52QrJqvytztp0W6oC9KncxGZQN0HA7f9ebt8LMzc4MCtEBWuPGyOXsn3ubxZk5pbtvag/FlTIGYSyTsSi0Olrm+RKmbYox8BZ/DU/Jz7U41VZjgMBTkEtUPrj60D8u0Dg1o/TJYB66cvpK+THdjQA1LgVA3gJDhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4LA6Xlj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721060005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eMQDoOvPaudwg87cd/MCmAjG7MuyuOwLJH3IIe8WBJ8=;
	b=T4LA6XljcIXZiZThIh1MNrmPv9beR7lPxlk3Gck9vwmo6H1iiAop5Z04wSqFMYA1Jvpm74
	k0206MduEs81i5fJKSs/3eiw8IZmD6QfgCF6CeIZIKyfMDq+yZySDC7lRG/Q2q8YGJ8ThV
	Vxl9BnDhq2y+DCoGSUaxmFqNshwpXjk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-IyY05gfDO2WY5B62nKYYRw-1; Mon, 15 Jul 2024 12:13:24 -0400
X-MC-Unique: IyY05gfDO2WY5B62nKYYRw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426d0bead0aso33385975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721060003; x=1721664803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eMQDoOvPaudwg87cd/MCmAjG7MuyuOwLJH3IIe8WBJ8=;
        b=PGZH3IqTG0iYi6wfH2DX85sX6FUZXa5qP6sJYz7eitY7p5tspfLcFKEYt6VPZCh+Ij
         VjNM8BvDcUBbQdpWKvCobJCnGeZyeSHMZhoIO9y2FkILp4yMiKJd0UcBxP99UXNLrucx
         ytGOKHEF1VPEmM+/bdvB7+UO7V4lwlEoRQrvryZxb/iH7zC//wAxsJ8zm03VLCS7RHcE
         iJ5Uc6eyeD3s+r+W85cFbxyFiuS49G2pusFk1tbChk7voHZKSnGypd44MJl3v37eJzhV
         XtLO7/Xmc7KmKNsAMX2AGqCYqSvGbyn/cVLc45iBapARwAhCoATjHmbmd3R4RYfW3MuK
         WBbQ==
X-Gm-Message-State: AOJu0Yyxnx67RGSZOu0m2guWqYvPD8A/G3SGT0TPSCYOdbA7aMC3vui7
	PbXle6l5vHU7muWGCmAXoxAzkRCXnorkmeoOA3hEU7nO7jmCK3hD82jfqcL9m+VMid5hMdWvt8w
	c9D8wm2Wsz5OO7uc1HllV/Cm0vN/FggqgQYhtV9G3o1otw+UqruaORmjtrt7wPQ==
X-Received: by 2002:a05:600c:524a:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-427b8891044mr919625e9.13.1721060002985;
        Mon, 15 Jul 2024 09:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQjwYkzdJSfx95XkYjFANBsRchdvLjh8+4GPYb9A3EiFNIrWgmU1j6VXyHmDh6mAZ9Fu7Hrw==
X-Received: by 2002:a05:600c:524a:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-427b8891044mr919485e9.13.1721060002622;
        Mon, 15 Jul 2024 09:13:22 -0700 (PDT)
Received: from [10.0.229.2] (ip-037-024-227-121.um08.pools.vodafone-ip.de. [37.24.227.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d6ef8sm126339895e9.39.2024.07.15.09.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:13:22 -0700 (PDT)
Message-ID: <2c3a5213-ca64-48fb-845a-78aae3e8f15f@redhat.com>
Date: Mon, 15 Jul 2024 18:13:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: Avoid PMD-size page cache if needed
To: Ryan Roberts <ryan.roberts@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, baohua@kernel.org, peterx@redhat.com, ziy@nvidia.com,
 william.kucharski@oracle.com, baolin.wang@linux.alibaba.com,
 ddutile@redhat.com, shan.gavin@gmail.com
References: <20240715000423.316491-1-gshan@redhat.com>
 <ea673fe9-beed-43fd-9a54-c683b0c800ce@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ea673fe9-beed-43fd-9a54-c683b0c800ce@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 12:41, Ryan Roberts wrote:
> [...]
> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2aa986a5cd1b..c73ad77fa33d 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -72,14 +72,20 @@ extern struct kobj_attribute shmem_enabled_attr;
>>   #define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>   
>>   /*
>> - * Mask of all large folio orders supported for file THP.
>> + * Mask of all large folio orders supported for file THP. Folios in a DAX
>> + * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
>> + * it.
>>    */
>> -#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
>> +#define THP_ORDERS_ALL_FILE_DAX		\
>> +	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> Appologies if this was already discussed, but if changing _FILE_DEFAULT to
> advertise all orders 1-MAX_PAGECACHE_ORDER, shouldn't we also change _FILE_DAX
> to advertise all orders 1-PUD_ORDER ? Or is DAX literally limited to PTE/PMD/PUD?

It's limited to that.

IIUC, it's simply some physical memory area that can be interpreted as 
small folios, PMD-sized folios or PUD-sized folios, and someone (fsdax?) 
makes the decision "how" it is interpreted/setup these folios.

These folios can only be mapped entirely (single PMD/PUD) or via PTEs, 
so PMD_ORDER+PUD_ORDER is correct.

Thanks Gavin!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


