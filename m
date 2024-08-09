Return-Path: <linux-kernel+bounces-281316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAB94D56F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55521C210CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28304D8AD;
	Fri,  9 Aug 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq50lTBC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1961FD8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224455; cv=none; b=d4Y6oEWuPZ4qK7f3g2U+GHMfFeM0/cgy9MqMPwVz3FvBbA/ZVxkEY/sqSxja9FBo5WZitCqF/1OVAW/1ijy674egjTh7tc7CdfrCJy7RZrlk0xcZrNoPM4EYf2247BD14iqZpCpxNTRGYKlMb74FVYBajIDAgOf81TKTEA+IvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224455; c=relaxed/simple;
	bh=E9gQQynE1Mu9KKkWoDYjTkYiniRCSxaQtivKWsI7pIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APcu46wHqVi1cf75YRTS4TO20mdZi1+jCjx2gYM8Iu674NxhL5xgui+7nq4vzpLVgjQxxN6rhfyj7s/PKfiGQsvFR1tWYJfY/ojzvJF4iOigqHuwN2654U/OHCIuUsb0JHTimYVS1EIrckABts3FGn0EZRWMsVPnl89t2zNRpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iq50lTBC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723224452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JFNIHJThdn/EJZUNURCAxg2SgRzsvo8wACtq52FCz7U=;
	b=Iq50lTBCjWqMazvwd9yM5zXq8Re8UPkDnKD6+/k8+QafesSHewZfoUodBWE6f3TMoY4aKa
	Y1fEIYDDgEwYuxMYdQNv0oCfduZAPzILZ9tPrgOGu7SW4WtqTcUI04l/H1raAbv/gZ0s28
	n2oK0DgPueljbPOjM0Ez2vVS8HoUaBo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-nlZpWB6aNwabhZsqzi7aoQ-1; Fri, 09 Aug 2024 13:27:31 -0400
X-MC-Unique: nlZpWB6aNwabhZsqzi7aoQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36871eb0a8eso1111549f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224450; x=1723829250;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFNIHJThdn/EJZUNURCAxg2SgRzsvo8wACtq52FCz7U=;
        b=ds0uSyvYcT29VFL80G3E5zZpN6Lve2bRfGd+xJ0mlpht3f6UXp+3oxoXhWaajiBgsd
         yR60WUcnirDv30T0GeAc93TwkeJBz5C7jzb3mar73raN1ThBY/o527SNa2Ey2OANp2+n
         1fDyJmC5DUgMMlmrDXbJ/DsD0GZs1eqCel7p5dYUVhI/Xl/jOv1AYZLKXqMczh0E3b6a
         SII2DRlnNoXtgx4B9i5yGuIgRYh31og+0cWis13zNbIHvQyKbhYfMm+r4SsVTV2ppn6q
         fR2utVdWMz2UrtGBPKTqOy0ITa4nYMOVw6BwwJX5IQOswvYGDN4IwhQwrdVeEny7N2li
         DvcQ==
X-Gm-Message-State: AOJu0Yzus92KM0GjX/BEYP3IDJ8/ZjbU4PZ9AuuY/1oMdluVMP0qgfP2
	ohbmMFhsKcN9b9fY6H8xO5MdvNReLgsL0OsbvAfjsnT4elNXQVBdP3+FVuL1z6eZqWctvzyoZic
	ohaFkFBCraWruBMWxTtBihtuZ2R4kev85tNLTi8EdTPvBRzcLrSAU557Gnak6uw==
X-Received: by 2002:a5d:58c5:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-36d5fe74b28mr1710330f8f.25.1723224449778;
        Fri, 09 Aug 2024 10:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXLxRrUZzvjlmGLVdQZcN8EKFgXNGqZFjusWioPPshAOh6a+lMvF6ImASQFuihelLyRztFkA==
X-Received: by 2002:a5d:58c5:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-36d5fe74b28mr1710311f8f.25.1723224449200;
        Fri, 09 Aug 2024 10:27:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfef1a8sm37588f8f.56.2024.08.09.10.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:27:28 -0700 (PDT)
Message-ID: <341acdcc-1745-436b-a3c7-26916b675175@redhat.com>
Date: Fri, 9 Aug 2024 19:27:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/40] mm/memory: page_add_file_rmap() ->
 folio_add_file_rmap_[pte|pmd]()
To: Vincent Donnefort <vdonnefort@google.com>, g@google.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 surenb@google.com
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-9-david@redhat.com> <ZrZOUaj2Kfe0CimQ@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZrZOUaj2Kfe0CimQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 19:13, Vincent Donnefort wrote:
> Hi,
> 
> Sorry, reviving this thread as I have ran into something weird:
> 
> On Wed, Dec 20, 2023 at 11:44:32PM +0100, David Hildenbrand wrote:
>> Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
>> perform some folio conversion.
>>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7f957e5a84311..c77d3952d261f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
> 
> [...]
> 
>>   vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>   {
>> +	struct folio *folio = page_folio(page);
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	bool write = vmf->flags & FAULT_FLAG_WRITE;
>>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> @@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>>   		return ret;
>>   
>> -	page = compound_head(page);
>> -	if (compound_order(page) != HPAGE_PMD_ORDER)
>> +	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>>   		return ret;
> 
> Is this `page != &folio->page` expected? I believe this check wasn't there
> before as we had `page = compound_head()`.
> 
> It breaks the installation of a PMD level mapping for shmem when the fault
> address is in the middle of this block. In its fault path, shmem sets
> 
>    vmf->page = folio_file_page(folio, vmf->pgoff)
> 
> which fails this test above.

Already fixed? :)

commit ab1ffc86cb5bec1c92387b9811d9036512f8f4eb (tag: 
mm-hotfixes-stable-2024-06-26-17-28)
Author: Andrew Bresticker <abrestic@rivosinc.com>
Date:   Tue Jun 11 08:32:16 2024 -0700

     mm/memory: don't require head page for do_set_pmd()


-- 
Cheers,

David / dhildenb


