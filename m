Return-Path: <linux-kernel+bounces-534323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027DA4658A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBD188AF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9B224B06;
	Wed, 26 Feb 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsC51dH/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A44221DB5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584574; cv=none; b=MYSoX9/J/rT0SAr+hmi0OQdjHkC69qX56lwNHySumkJO3v8eTtlmMB8zo8obmkyHEWbGxSglfSh6RSGS1aROP7efcLNeTU0T0j2dYSW3K3sY9kMUzIzcl6TpaLXL2ozOzwHKSx0QzcRrykEXcVp1ErBkOkEGKazDTaJKthGP5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584574; c=relaxed/simple;
	bh=POU8QNJ9X/te7g6dCobHnwovQlMSESoeY5rZ+D0LycY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKhgZA/WJpecZqZjNzXB2ZGgQ7+PCAMmRkoCqQNGMkzfMZPsqMGysL81e8pcuXxDTHlqTIYGn0HJnOrV1TauMJDL1878VxbvnlFZiozebmlACRcDCV6CbQigetvLsgY2cgHdjXf0WlpWULDuUvEjQc13HAE5SrG80/e0Fv5PvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsC51dH/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740584571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ct1usEIE5mCrQ0cI4Z5Fw7l48vyi/uJCgaNsySRiXLc=;
	b=NsC51dH/oZTQ0mvKHrTT/TyHEwY2M1qgPxPHrNlgX4gIBh+YIJZ53OFYFB1YKVtG6/p5r+
	F0EBt8FgAEH394pTHdi6vH/I5rZ3T7916NW7e62FaI++sJBTHboBOqtzvx8riwzch8+/NT
	DJEZgZ7A7jIrFp7J9b/Xz/3jmFPQ4as=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-el2Sxee3OEaBikQj-aDbwQ-1; Wed, 26 Feb 2025 10:42:50 -0500
X-MC-Unique: el2Sxee3OEaBikQj-aDbwQ-1
X-Mimecast-MFC-AGG-ID: el2Sxee3OEaBikQj-aDbwQ_1740584569
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso4647470f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584569; x=1741189369;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ct1usEIE5mCrQ0cI4Z5Fw7l48vyi/uJCgaNsySRiXLc=;
        b=sYScW14BS+QLtn9L3nKapgtOWuNyZwnxps21U+b76THAuTOxGKRB7YT7oIWqMPMOTv
         eQIuBQkDqp6RaQdla6TNBkgHZaKGvkNNh2KRL6g3A9YPJjOfkmf/NXvcJEGH2TF2Ig6m
         diLBD0DNh7pfADdXXmCYjQjuCAUq7Wi+7lxxjuY/4/kzbKENMFu70SOqBz+pBNZ1jFTf
         jsOL5cKP46au2MljReCgZAFEqYLc1X9y7eynM0jWrXpYkknyZWratHfILTU3CQARRfiH
         Bu90rFPWOvPs/oV6TyUYvTzStmAXPv0MEtUmow8zdzB+Y/2d2XDJMUhby9FOzzvNV/cf
         gJNA==
X-Forwarded-Encrypted: i=1; AJvYcCWBNUxnKhwN1OPgoL+1Aatu11AwC90VbpfkjYI3zTwGPL78uAT+No7rGjifO5jXkEsHxh/RNHUzs1paH5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfIupBhSlgo2nD+rTflRJxrg7N/fb75RK8F86IO17n81ll1In
	ofsdT9if/xmWl5bR5uaMQQXcV77Ijvq5C4SQKCMDgaEGZAaQvoy5aX4OIcxoQmaM0ej0DJvUoM5
	sMwQkMwVSFI9xdQuxozjbkIf6L1bmq2u1dDkb6/UX4CgIU+NTroK1f/7uzvGZfw==
X-Gm-Gg: ASbGncsTyjDw/YXY8LoutY1ZdcEsLCe+utSDPI/ZrUJVdx/4GDgIUkavCdKhDaJTxtE
	eQRw2nAsLfYg583/oPoc0o0VxfEHp61JUQXnsVyVnAyafMU6aQ2g2NyR9TLbuJqNfhHIz7LVyZQ
	O/gfRUubkf6jHJq/hqQWILDvFdKin6OcclSW2JRIfh3TxhLEWfhKq0yj53AEqGRmKFKdZQ1QRCz
	5WWCj4JOy9wTHWqfeawq5qb40XcPaM28Qr43gXXCjup/LPIcP6NplVC1ISvcEE875L18p1JOeEE
	Yg2xoiYaNLKJ7s3zDDLd6QOu7NBaLAoCG9Nr2P2hrJq6+0zDnjqIyjTCqE00FGfLWLcH4TekR6+
	YIWl4OQVmTZgM1/FzNWWznj4Rh7JjWc82LeThpJsrsgA=
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr3418214f8f.41.1740584568845;
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc5f9sSVXsb/drkwgCC3GgZAvsBZeyAI1Ocx1CUODtH/g4ViRNzrq1fZFuXosu2Ho0LLxVFA==
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr3418195f8f.41.1740584568465;
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcca2sm6029159f8f.96.2025.02.26.07.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
Message-ID: <121abab9-5090-486b-a3af-776a9cae04fb@redhat.com>
Date: Wed, 26 Feb 2025 16:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Matthew Wilcox <willy@infradead.org>, Brian Geffon <bgeffon@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
References: <20250226114815.758217-1-bgeffon@google.com>
 <Z78fT2H3BFVv50oI@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z78fT2H3BFVv50oI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 15:03, Matthew Wilcox wrote:
> On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
>> When handling faults for anon shmem finish_fault() will attempt to install
>> ptes for the entire folio. Unfortunately if it encounters a single
>> non-pte_none entry in that range it will bail, even if the pte that
>> triggered the fault is still pte_none. When this situation happens the
>> fault will be retried endlessly never making forward progress.
>>
>> This patch fixes this behavior and if it detects that a pte in the range
>> is not pte_none it will fall back to setting just the pte for the
>> address that triggered the fault.
> 
> Surely there's a similar problem in do_anonymous_page()?

I recall we handle it in there correctly the last time I stared at it.

We check pte_none to decide which folio size we can allocate (including 
basing the decision on other factors like VMA etc), and after retaking 
the PTL, we recheck vmf_pte_changed / pte_range_none() to make sure 
there were no races.

-- 
Cheers,

David / dhildenb


