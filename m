Return-Path: <linux-kernel+bounces-329152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F7978E22
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D47D1F2413E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3E147772;
	Sat, 14 Sep 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RPz6skDU"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB74437
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293467; cv=none; b=TSNWgOKWcOMIIwWUW+Xe5VBH12r7Tu02MKJ2xr2gziQpCAVEVywOaqVcfMhXU1EBO4b69L+9aePXyQmuwxdVC1LnvvhDNiDPfBFOM1HwXwdgK/zLZxAKq7rw+OsStAaLMHxSB/5s4YUHYvTSf7cgttW6hYigNNGJ3it9T2deM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293467; c=relaxed/simple;
	bh=yrxyEG+7h1OUZv+xEB0fzKoqpnFZveTpJbp5Nli51Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pykPgVsQmo1eGa0z9H87UW9QoA9dbNhUVoqCt3kyJ9XeORFHutfDLTGqmY0GJkcPe3BgTuZGflKEcI8G2W6bU1W8CO3q0yF60zI29kMmHEH5QmghRszEQ3OXEUXoTmhFqWpDr90rFS0Z/p2grlmGaLopfbA745YKyoN/OjxgQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RPz6skDU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a90188ae58eso318604866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726293463; x=1726898263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj7BI1d/P05L4yR+fUrwV54+pcNt/eQNbd1AyE1f2W0=;
        b=RPz6skDUX6Gwn6/RbgsTRHDxBQ0GEZv/qn2k/4zXVdbR2zChH0KHY9x6ZvtGr5HiQV
         g4hisVL8BucDXhbiJKBDX2N0BfbheQrSTSJzqzIcVMiSMG9HRY5IHzHUSjleX0Flnjvd
         Fx0hYu+NVa8zgGBJcXbyRrzTn36MFrPFP4BOxKLnB7etAUgWWuzmcl+yY0jTGiO7z2eA
         7vPqxVHwuPmWyv9gnK9QzERp7CboIQFoJxmGryqXAXAnooZxkfZnCtI8v01dpXqIlcIr
         UEDoVP2x1lno011SfRQ0gy6B8uv5Ck/YzX943ZuuBwALv/DgG9+SPjpLD5rW2DFbaEt1
         37TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726293463; x=1726898263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj7BI1d/P05L4yR+fUrwV54+pcNt/eQNbd1AyE1f2W0=;
        b=VJJirKhvzQrxE14j2bm6r3GzqcDKYNsitm92PfqyfbmBhy60s7lhF9GYsrSShipU1O
         oOxfgAbRi6ftf8s893Chof+oneWTE3+viHaIJJMj6g1VCcaFGKto+2xiRGF5MC9aILGE
         wzv+FbpyjbjMoVueX+i8hMyXQVvIw9v+Sk8xsnZUlByyjFdofmfW5Q4wQqyOpPZYdSUx
         D+rwzY9ysjV/BUCKXttasbZlu7KdGibhG4k7BpuGiPhnmCYT5d90dYIStqmf1dm84yMw
         tyJPgQC6JTSIbIFstIzOEp4Ts08eIsrZzmVJy+DX2Fzznrv8/xawdLDzMZ4sZzZqLcGq
         BI9w==
X-Forwarded-Encrypted: i=1; AJvYcCUUHqUyhoEXzmIoX4gSqqE4qsxElxng7+zyI0qaspj4qcuHhFNA9394KvjGZJnMrGQXqCMKnxhNCSwmxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQtFiHAnze3/juFYdrXzLupSHLdcBvGl2/yd9/cYzt6GQ2P6D
	NJH46vKrzr2j1RfjVfURdjxvoEvFQnDSihqxKq6OLCoGu7+j0/ELmu7154XYCQ==
X-Google-Smtp-Source: AGHT+IHQRdOpdMJ4Y1cJj+samNp4BzlrRh+uCRWFfdK6L+8JVEJRsNx51Bj2WAtb1ztXOUZFBjsz3w==
X-Received: by 2002:a17:907:94d4:b0:a90:34e8:780f with SMTP id a640c23a62f3a-a9034e87ae4mr673589866b.63.1726293462430;
        Fri, 13 Sep 2024 22:57:42 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966ccsm37044366b.45.2024.09.13.22.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 22:57:42 -0700 (PDT)
Message-ID: <e5a05e0a-ce58-4779-ae7e-c3803af82d3a@suse.com>
Date: Sat, 14 Sep 2024 07:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: add alignment check for dma buffers
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240913145655.10076-1-jgross@suse.com>
 <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
 <alpine.DEB.2.22.394.2409131728420.1417852@ubuntu-linux-20-04-desktop>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <alpine.DEB.2.22.394.2409131728420.1417852@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.09.2024 02:38, Stefano Stabellini wrote:
> On Fri, 13 Sep 2024, Jan Beulich wrote:
>> On 13.09.2024 16:56, Juergen Gross wrote:
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>  {
>>>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>> +	unsigned int order = get_order(size);
>>>  
>>>  	next_bfn = pfn_to_bfn(xen_pfn);
>>>  
>>> +	/* If buffer is physically aligned, ensure DMA alignment. */
>>> +	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&
>>
>> Why this check? xen_swiotlb_alloc_coherent() guarantees it, while
>> xen_swiotlb_free_coherent() only checks properties of the original
>> allocation. And for xen_swiotlb_map_page() this looks actively
>> wrong to me, in case that function was called with offset non-zero.
> 
> I understand xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent
> not needing the check, but I think we might need the check for
> xen_swiotlb_map_page. At that point, I would keep the check for all
> callers.

Whereas I would be inclined to suggest to put it in the one place it's
needed, not the least to avoid the abuse of the function (going just
from its name).

> Unless there is another way to detect whether the mapping needs
> alignment specifically for map_page?
> 
> For the offset, in theory if the device needs alignment, the offset
> should be zero? If the offset is not zero, then there should be no
> alignment requirement. The way Juergen wrote the check, we would take
> the fast path if offset != zero, which makes sense to me.

Hmm, right.

Jan

