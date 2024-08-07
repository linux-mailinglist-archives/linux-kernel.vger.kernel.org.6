Return-Path: <linux-kernel+bounces-278206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E804594AD6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AD21C21C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3B12FB0A;
	Wed,  7 Aug 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4GzKEvT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31684D12
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046029; cv=none; b=Gr1wBjKUGUen4K72m+FiPlYkJXDD+GjcBAe02/tZtyywrYkFoDz8UmT1fJ3PzLHykD+v1lWoN6pJw0kh33n2DyvjmUimn9FiVQPNbF9x7wYfLCYuiU2syS4WZIzYSy0Rl/CWjO6Qd3KiWLIkrzcqaadxU0wTHcihMEShGpj56y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046029; c=relaxed/simple;
	bh=inIBk8JOoLRNz6nCpNeEjAb7+0szPkLfyTa4Z9Iqb7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCNU0ug9ZsDWMA8c96rc2Pr3SM4xffTm/Td5qPVrPRreQ8P8xflidaSvugXTEfRxLbpHbe9ML/FoIj1rMhq4BJgXiNLQsQhtK2nPVLG+BcYXUxsuXS46h69dD9BSMXEunuZyIx6h7dYVgK/jUB+zc/7s4AMrHaeonnB76Az7OWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4GzKEvT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723046025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WC5nLMSiDzPv7LpELiuhNQy9y7ZDibENKwBeHwE2dW4=;
	b=D4GzKEvTzSY37JZKCfUMRrVigNP1rTb7ODbdsTa+jzWwNFcJo1fUnYCDpbTRUesjQYaXas
	RmzZik1JV+oEO6iLSURX845qlTpJ6NIe9wBXzzV05p3J23t3X2DFfuWZWK3ZEl/pJlPYH8
	RxPyI3VMQppQFRg0Xi352S2uC5Rgw/w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-5is6rt_pOkOkx-TLdnpqeA-1; Wed, 07 Aug 2024 11:53:44 -0400
X-MC-Unique: 5is6rt_pOkOkx-TLdnpqeA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42816aacabcso147055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723046023; x=1723650823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WC5nLMSiDzPv7LpELiuhNQy9y7ZDibENKwBeHwE2dW4=;
        b=B3z4+GDJ4HXdQ4O996C+a0w3StbzHVl/fuOcFvZWZcYodHdbLA4t+nd60aGRclEk8h
         asb8ONL0MPTvOXJ+mSGzvhULlRtId/Q4sKxAkX6ky7XGzC/xbFn0IOrwc5ZqWEQJN1AB
         Je7IZU+WdtEJw4nfVCRC8rkWuXU0+e1AueX/rWBW0XfsrNEI2zJjwdksvYRRkw7i0XgN
         xDHdQc7S0wXmczfAyT594cHeyhu1LrcQU8vaR5uaBYXq8+HYGEq1BKDy8guHO5wNKFPx
         b6WdtUUYzmfqjDIwrP2FwX0mhhZl/9C5M90QTtuiF7QqsG3OShUAwV8HXEf5HOSK5ESA
         3yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6Hpl524kU4KUgAV6Jc1aWWbpk16Q4ymvhJDi0nceb2sVg+x9qAILSdR+gYRt2/BdmRo4JZYLV+D2ihqoASLaH/nuQfbtK2dC4MV2
X-Gm-Message-State: AOJu0YxyfwxJuw0lW1rYJxqFcKAodf+pITperIMsHCb1OPcbmrZx0GoP
	d8dGy64PiZyE0g40mLwR0elo+IFFzQ9HcZ/x9dMiw93K1rB58GQ92hnN5VRqMEKxxhCaBZZruQA
	UTuDvjsbSXNGj9g9xbB5sSdRQ74pJGlmgZoOOkRtZlSfzz0agE5RZQn2rigPCog==
X-Received: by 2002:a05:600c:a43:b0:428:16a0:1c3f with SMTP id 5b1f17b1804b1-428e6b83288mr149191855e9.32.1723046023476;
        Wed, 07 Aug 2024 08:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPQ7I8BuW675AX0gE+IIKufCaufCr9hyFq0aG6OZXTWIjxigLCwSP7zWxCYI6LbaH7dL09JA==
X-Received: by 2002:a05:600c:a43:b0:428:16a0:1c3f with SMTP id 5b1f17b1804b1-428e6b83288mr149191625e9.32.1723046022826;
        Wed, 07 Aug 2024 08:53:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm36688145e9.23.2024.08.07.08.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:53:42 -0700 (PDT)
Message-ID: <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
Date: Wed, 7 Aug 2024 17:53:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting shmem
 large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
 <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 09:31, Baolin Wang wrote:
> Page reclaim will not scan anon LRU if no swap space, however MADV_PAGEOUT
> can still split shmem large folios even without a swap device. Thus add
> swap available space validation before spliting shmem large folio to
> avoid redundant split.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/vmscan.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 31d13462571e..796f65781f4f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			}
>   		} else if (folio_test_swapbacked(folio) &&
>   			   folio_test_large(folio)) {
> +
> +			/*
> +			 * Do not split shmem folio if no swap memory
> +			 * available.
> +			 */
> +			if (!total_swap_pages)
> +				goto activate_locked;
> +
>   			/* Split shmem folio */
>   			if (split_folio_to_list(folio, folio_list))
>   				goto keep_locked;

Reminds me of

commit 9a976f0c847b67d22ed694556a3626ed92da0422
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu Mar 9 15:05:43 2023 -0800

     shmem: skip page split if we're not reclaiming
     
     In theory when info->flags & VM_LOCKED we should not be getting
     shem_writepage() called so we should be verifying this with a
     WARN_ON_ONCE().  Since we should not be swapping then best to ensure we
     also don't do the folio split earlier too.  So just move the check early
     to avoid folio splits in case its a dubious call.
     
     We also have a similar early bail when !total_swap_pages so just move that
     earlier to avoid the possible folio split in the same situation.


But indeed, pageout() -> writepage() is called *after* the split in the vmscan path.

In that "noswap" context, I wonder if we also want to skip folios part of shmem
with disabled swapping?

But now I am wondering under which circumstances we end up calling
shmem_writepage() with a large folio. And I think the answer is the comment of
folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.


... so if shmem_writepage() handles+checks that, could we do

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a332cb80e928..7dfa3d6e8ba7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
                                                 goto activate_locked_split;
                                 }
                         }
-               } else if (folio_test_swapbacked(folio) &&
-                          folio_test_large(folio)) {
-                       /* Split shmem folio */
-                       if (split_folio_to_list(folio, folio_list))
-                               goto keep_locked;
                 }
  
                 /*

instead?

-- 
Cheers,

David / dhildenb


