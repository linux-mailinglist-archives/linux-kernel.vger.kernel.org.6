Return-Path: <linux-kernel+bounces-355320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C99950A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB5BB23F04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E71DF736;
	Tue,  8 Oct 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg8os5FL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D91DEFCE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395454; cv=none; b=BeYiycfnLuCCLSXxFM0diDlSFf7CgvYIwIds5dLHgyceHddQCzxMQEv6OKax3tFoyvpwknj6gebsCQIb/PVFzcUW50CAjdaguZ2q43Siw07RS0I8viWgSclTEUbC9tR3noVbbBXiUNnGFrk8+eBaqVyHSPdfFA0m6SUObslZpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395454; c=relaxed/simple;
	bh=2Q881oEYQ7ZV6hSU8xV3IZKfRiq5SeWTUt7vPXV3M5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNRSkTVvt4ly6ZQ47Bp8xYc2iJjLdT1Ls2sz/QbnrUzkOiHawBf6gx08tCK8+bLlvOUdBOyv6N2m8n+Rlb0rvVadO7UOONcefTBDyuoj8TANQvJI6ZQxfXWzhFl8YxDCaNw/tNZLgHpM9dDjDc4DYICXYeLIR9XkcidzsjPPgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg8os5FL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728395452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MT0bxc5ocflF2NBeIeTPIzdqx+Na4ZpQOoABhBBbK7M=;
	b=Xg8os5FLqBzZ48CSkE61khYDZGj0A+yWA4TrPOYsH6xRJkp8GQHIJCg8bOXjnaSfvSFMYk
	m6tULvyQdZXBAQyv6aThoGA1g0EHBfKAsf8fpqx6qk+ns7gVDD9QWtSaz5Xxr78oUDMgsx
	WEcM48lKJgz7cJEHPjXVHYlgRdnoQz0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-zwpenxdVN8e1ScQT7OFTig-1; Tue, 08 Oct 2024 09:50:50 -0400
X-MC-Unique: zwpenxdVN8e1ScQT7OFTig-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37ccc57613eso2299727f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395449; x=1729000249;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MT0bxc5ocflF2NBeIeTPIzdqx+Na4ZpQOoABhBBbK7M=;
        b=eyk6KGCD+5ObtyC2LGXZiqI7/nsV2SjJsyixst2mQ2YfcQJ6pRnseLJPlVDq3S5H02
         qvrbEFt989RNw/cgW3tuVqkiSIoM4KsNiTVFaLK6A+viy3z2+fHDVqKiRQbmteJQy6se
         Ha2Z/1LPD5gVGmvP0sJgoTu8sRO+Bno/ennvUyZNdEDLjjMcw7VGMfcDpNS3cR+RSvJ4
         9oaIn7+ETqZf9ANYqQdYmIsiZVh2jU/YYQ/y3j8GXj06c8XXKpxYdYTGzeWjXhC1Wapk
         k2QR2APJhHfbKzRblJ9r02/UqfOI5mYmfCUgSvOqxlODBhSFHcrjRlLjdzuTsdUxGmz4
         LttQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtP6pCqXto4FvHuNTu7D9yOXQ9bJ3l3XTjbggyCQxkqb+E4ADU/O/IPSrU3mllXWMogc/fnPUTXPVYllE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4q2/MzOCnKHC3IDCglJyplFT3Kd2/IYj/fHxCDFNIXTtIryDZ
	5CUweoYlluyU35jfuDUmEq8iBxE9WbCT0WQqnzLa0psIS2lhh9LN9A+4lW2TfjYVsbF/6ykt2B/
	nbMHhhNiIHjAjsTDX8SdcAtWZSmIMP7GOkYwbxqixO2ekYXvB0T6R2itBZx9aJA==
X-Received: by 2002:a5d:5f88:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d0e6bc9f8mr10618940f8f.12.1728395449022;
        Tue, 08 Oct 2024 06:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPGcuh7LT/fL7mV+LBdDFv+cetxVNFifhM9W983OFP8K5hhjwy2yDaqbTm0hLUmw/qyAhdkw==
X-Received: by 2002:a5d:5f88:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d0e6bc9f8mr10618915f8f.12.1728395448532;
        Tue, 08 Oct 2024 06:50:48 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2353a.dip0.t-ipconnect.de. [79.242.53.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4304efc0460sm20598045e9.1.2024.10.08.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:50:48 -0700 (PDT)
Message-ID: <83eb128e-4f06-4725-a843-a4563f246a44@redhat.com>
Date: Tue, 8 Oct 2024 15:50:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] cma: Fix CMA_MIN_ALIGNMENT_BYTES during early_init
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
References: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 15:27, Ritesh Harjani (IBM) wrote:
> During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
> since pageblock_order is still zero and it gets initialized
> later during paging_init() e.g.
> paging_init() -> free_area_init() -> set_pageblock_order().
> 
> One such use case is -
> early_setup() -> early_init_devtree() -> fadump_reserve_mem()
> 
> This causes CMA memory alignment check to be bypassed in
> cma_init_reserved_mem(). Then later cma_activate_area() can hit
> a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
> area was not pageblock_order aligned.
> 
> Instead of fixing it locally for fadump case on PowerPC, I believe
> this should be fixed for CMA_MIN_ALIGNMENT_BYTES.

I think we should add a way to catch the usage of 
CMA_MIN_ALIGNMENT_BYTES before it actually has meaning (before 
pageblock_order was set) and fix the PowerPC usage by reshuffling the 
code accordingly.

-- 
Cheers,

David / dhildenb


