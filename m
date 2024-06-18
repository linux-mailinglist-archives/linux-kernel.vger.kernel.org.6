Return-Path: <linux-kernel+bounces-218992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15090C884
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AB528636F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DDA1586CC;
	Tue, 18 Jun 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O63vmcAW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950D2074D9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704386; cv=none; b=BtFF6wTcxQgfm/o5dzJ+NZ/PkjjnA84s8yvTMcIG2FU1GF0L7pBkIVGP06f+aqh0dknFxyy2eDXW8clPO9NT3BXUsp2NOf7yOJR5YUrDAz9FwCn+m8ZpTPAOCKKda40fkE08gXxPGHw8JYvynLWJ0WOsWlj1kL2JHkfjF6djujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704386; c=relaxed/simple;
	bh=cBbNMMYud9L5amoThpnd/2WU49Vb3yaA8V0zVZ5T8To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLT3cT6JTVJEZfOfnOr5Iyk8I8voTcNlHAmbL2YwvTSS6eUYVbFqN0Q0Uimx5W4vEZWVk/wD2Bn2nqRLaz/aswrXZMOH1h/FbKStJQdzaYQqbZHQ07W0Zy/Yov0zruuCEf3tiK63TlY9xkCx+aMasUgk4PxYZ/bIKrjTgg4eLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O63vmcAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718704383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2N0a4BszAoqgNo9ZsqGd5QMLUc2K6SmyxO8xgmzNle8=;
	b=O63vmcAWnKD52DrepPJZ4Gj3cZg2P03qWaWMHfDnlneaTWGTXo70I4SkzI+pD/pK5hAs/z
	mDBErgEmIXkVmF6GCRPmZuEN7TnMhWrp0IjXjWQX1XFGnhQlerPILqyGNOxv1OWgNXzVjj
	7HLaHBdiblBnKYAqHJ76gfVpv/tf8Us=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-IEAREzW_Na2b_tVfPC8_3Q-1; Tue, 18 Jun 2024 05:53:02 -0400
X-MC-Unique: IEAREzW_Na2b_tVfPC8_3Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421739476b3so47222075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704381; x=1719309181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2N0a4BszAoqgNo9ZsqGd5QMLUc2K6SmyxO8xgmzNle8=;
        b=fjxApKboAQFLpuMhkW7SDVFcmUwwdWMAL7GWa2mRLFJzudRT6wVFLXXxxcL0lEMX+m
         U5XCYGXhwNjJ14R0GH82oRrpXS35wP/g6d3kNwqh0TdsSaT7bra/mwGgUEFtagD6GIIO
         wAlUE7eYeAngd9NdRL7KLmdrRyub23GVVEStSFuxsd3kw1Cc8A24ijow0swrKBFyQS/X
         jTn+AXOoYsRYuAx7q9VSXmE7xPdAKE4hNxRYAxGLTv0LFREKKOwjoukXhcP0OrVUTBxT
         FOMm1MovS2b3Fb3gqy0RJOij8gc1ixm6HY6pHD6tMaK/+d+bshdujQuNyxXP0d6MFS8W
         2lmw==
X-Forwarded-Encrypted: i=1; AJvYcCWdqkQdU3pI9Cdlu3xqyodAPK8i4AfberwGUmPgc2JoILnfX6nWOWuZNSkeBtU7xb0AnXyOpVU3JcudKHafa9COUZfYYJq23/H5CzXu
X-Gm-Message-State: AOJu0Yw0EFIyzkH0Pbh3UR6ZuU+vYlh0dSPvxqWzTKm9Y1xc2a2eZKIM
	a14L02R+GvlrAKLAb7LMZFMAxzLRDZ5sWkh3kOpEcBdzwoNGVU95LsigFioyArG4JiC6LTheNs0
	S5RPa1YljI+0Lydx78B/fsNxmNijTfRKYTOTk8ZHk1AK93lb1rGte20JK+CA+7A==
X-Received: by 2002:a5d:65ca:0:b0:360:7139:ba28 with SMTP id ffacd0b85a97d-3607a783459mr10410719f8f.53.1718704381308;
        Tue, 18 Jun 2024 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlwhdqgHufbBfheC1mBS73YIXrTINHvtfnfuxMG1Q8gMC7p7r80LI+W5FHLRj5Jy3ckI2eGg==
X-Received: by 2002:a5d:65ca:0:b0:360:7139:ba28 with SMTP id ffacd0b85a97d-3607a783459mr10410692f8f.53.1718704380820;
        Tue, 18 Jun 2024 02:53:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad2cdsm13793819f8f.61.2024.06.18.02.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:53:00 -0700 (PDT)
Message-ID: <03d08299-40d3-41c6-99f2-15cc3d589311@redhat.com>
Date: Tue, 18 Jun 2024 11:52:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: extend rmap flags arguments for
 folio_add_new_anon_rmap
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
 <20240617231137.80726-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240617231137.80726-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> diff --git a/mm/rmap.c b/mm/rmap.c
> index a3c99ac63155..2b19bb92eda5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1406,25 +1406,26 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
>    * This means the inc-and-test can be bypassed.
>    * The folio does not have to be locked.
>    *
> - * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
> - * is new, it's assumed to be mapped exclusively by a single process.
> + * If the folio is pmd-mappable, it is accounted as a THP.
>    */
>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> -		unsigned long address)
> +		unsigned long address, rmap_t flags)
>   {
>   	int nr = folio_nr_pages(folio);
>   	int nr_pmdmapped = 0;
> +	bool exclusive = flags & RMAP_EXCLUSIVE;

One nit: Make it "const" and move it above "int nr ..." to maintain a 
nice reverse christmas tree we all love ;)

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


