Return-Path: <linux-kernel+bounces-309808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EC9670A2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38ECC1F22ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DDA179206;
	Sat, 31 Aug 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCt0zEhQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B4193
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098361; cv=none; b=RtDmYMMTImluK03NCY9gbQqQPeCAZrjwNqgb74ZVw9DrCRUFjtciRpZYbZVhHvGjlZSA1QmUlRQPgQHHaXVUvVxbByAKBDW+noLwCKwMBK0iflY6lJTkTThmFUKtSJLWAh9WBLsuyKz47lXWG2gTc8eufIy4fRq9wdhT7QHV8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098361; c=relaxed/simple;
	bh=/kBelvnlK4oVahu2u7Dwy0LluzclmSqF8xNrMoNFvKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdkhDcGdIDWCYGAu1LWYs1LHIw5ygKbCyHZzdJ+I9bcy5QTgUG4pFfgDe1MOiQ5jMXiT6Djxwt7K8CKkkVVPa0FK4de/p1Zr/X4B1px3zzoKVkfCiZ0KnYI8iBsWGyFmlSNxsouGXtwEUHeQB4RqmGSM9tIApHazqxRq2PcxMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCt0zEhQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725098358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfsjbEfJljHMpD0NefJwLeOn/o4rMIrXMtQeAR4mYCE=;
	b=eCt0zEhQsxtt7A0zN+Ol0n0fvCQ3rBIwH4vQ8nM2fDSpSJSeRWz7Q/Tq/M31oS5NL/y8tH
	seUxyCJaM+/AASLZn6ulYuCBhomvigtWze1yNXs2mvm8p/4VVfleP3sN93w9lxHaFvhkf5
	xSAySEJtj7B0ckQnfWDzlw1pVnesvO4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-iXahiKEfNYO6qxH9VNMx3g-1; Sat, 31 Aug 2024 05:59:16 -0400
X-MC-Unique: iXahiKEfNYO6qxH9VNMx3g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37193ed09b2so1979961f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098355; x=1725703155;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfsjbEfJljHMpD0NefJwLeOn/o4rMIrXMtQeAR4mYCE=;
        b=EYjGmWocacKKse4YmCYBn55KWMMWe4p6W1eSYpuBuB3dJ3JNNLSgrFGfaPYTY9XBUi
         H8SH2rhZU29RdfbwstoMpJ0UpiQd1kqg5sPvuKn0jRkAqBalw83HecfVqVMd3bBF60je
         VpnTiTed4o4LKsIeR+eXg/2L1QHAbBXHis+V3bW53/DMxFsFQ+80W2AhLMjj5GOjI9Om
         esqe52xRFG/kWyuXqE1JVz/p71C78EELp7ZJn7JTKbt5il5tJ87t69pgdgb8kULblFSw
         SgW6zGORlmfbQW75xXvtMfmAFNCp8e5jtzDYpp/JDfgwEwbWMTVJeXP6YMUqKbC2Y0Ys
         W/HQ==
X-Gm-Message-State: AOJu0YzFKDsLoBXi/58GLUhK4s7wrYCPPLLcnIFFUDp5lTf85t11IXfc
	zJFrRH0UdnlyvfU50ho22//3J4GipRxhBxWM7aSFolvsZhsvMwTtId81laY+XW9HZ1eeRt4t/Cs
	BW7svQC97SGLM1IgdzIQLSyzPnYoiPzhggTVQ3/cUb9TJaaMONs8QmJf/ayTrQg==
X-Received: by 2002:a5d:53d2:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-374bd000df0mr1153666f8f.3.1725098355283;
        Sat, 31 Aug 2024 02:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk9N1/6t/rnDKFN7ZnKmstgku8GZKXhPdH9YiVvZlsPeJGsgj+FUF+/Ynw2O3ynygwaL4wRg==
X-Received: by 2002:a5d:53d2:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-374bd000df0mr1153649f8f.3.1725098354432;
        Sat, 31 Aug 2024 02:59:14 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6ee6.dip0.t-ipconnect.de. [91.12.110.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639643esm106955475e9.1.2024.08.31.02.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 02:59:14 -0700 (PDT)
Message-ID: <c0f79761-f753-4df7-9d02-3bbcbfbd902f@redhat.com>
Date: Sat, 31 Aug 2024 11:59:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240831092339.66085-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240831092339.66085-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +		idx = folio_page_idx(folio, vmf->page);
> +		folio_start = address - idx * PAGE_SIZE;
> +		folio_end = folio_start + nr * PAGE_SIZE;
> +
> +		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
> +			return false;
> +		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
> +			return false;
> +		folio_ptep = vmf->pte - idx;
> +		folio_pte = ptep_get(folio_ptep);
> +		if (!pte_present(folio_pte) || pte_pfn(folio_pte) != folio_pfn(folio))
> +			return false;
> +		if (folio_pte_batch(folio, folio_start, folio_ptep, folio_pte, nr, 0,
> +				NULL, NULL, NULL) != nr)
> +			return false;
> +		if (folio_mapcount(folio) != nr)
> +			return false;

BTW, you're not checking against the refcount (and it's all a bit racy 
on concurrent unmapping!). So you're re-introducing the vmsplice 
child->parent attak.

-- 
Cheers,

David / dhildenb


