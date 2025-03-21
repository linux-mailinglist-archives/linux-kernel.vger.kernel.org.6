Return-Path: <linux-kernel+bounces-571055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D269A6B890
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8853B9514
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4C1F4181;
	Fri, 21 Mar 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVyscxOn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66A1F0E37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552035; cv=none; b=HO6ICvxpLLXnTcjByM+RLuqwnqILLYCRZEj0gOeeg185lL5pZgjb15QOO1+d3H4A8jJBhwRVnI2Bd/brhHI+B2suFfH/kM85fwCV2EXASrWNLQnxXJ5BGpRhaN1dbql9kGvDP9jTPNw2ukYvT5Zoq/K64VTs64KpB6qNw5QDjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552035; c=relaxed/simple;
	bh=HxLDeFj0ktbbwerJAN/of4YEs/O3e7ixcZVvsh0Ibmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUXVVaA8lrtO5kFgJnaAayE4cSVwxTNwj8JkvWaf0VPc4YT1bzxIhrTlPFT/GaWZ0A2CkOoWxdv1jVjuGSotT7gWPPTx3zAU+HIj8jt6IDF+H4+LxhRiAi2D9x+9UQlHyGG+/ZD1KNIk9wIAD6KqOOu6IdfG4a/TXxDg2cQjViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVyscxOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742552032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OpoKiNz0zYG+MZwr0p3MfFv9/gi/iW8/9JNtqwEH8EY=;
	b=GVyscxOnqmRrbj3iffRg6ANkjOQQcQqng/ca4pkH4DK8lJqK3CbVrZjM3qXgFqx/vAsegz
	9CKQjIcCg716zYHXMUOCtcEzTCjEXSeEISL+etP9/C/zWXbbfyJVEW+rUMOJGbE/DC1f6e
	dUfWn8BSBce8lVQlkEKwKlyTR0Wt4EU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-OQJSSeUWNkq57SarS5Jeeg-1; Fri, 21 Mar 2025 06:13:46 -0400
X-MC-Unique: OQJSSeUWNkq57SarS5Jeeg-1
X-Mimecast-MFC-AGG-ID: OQJSSeUWNkq57SarS5Jeeg_1742552024
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so8698925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552024; x=1743156824;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpoKiNz0zYG+MZwr0p3MfFv9/gi/iW8/9JNtqwEH8EY=;
        b=O+ukk9O6+ZPdYfXDFuJZbyV3gnj3B189IC3O94KqWi7FoiuqOq5mzUQdHjVybH4EAw
         tbtQll6ikRx3M8ai/C27ldeVlLk1EUAwPEX9avvSB6bJdvjpnJUWd8yLeDgLyDu4OPvn
         +rDx5+rWHB6wdWmdTPilRhUY+JwiHRYiNpPUkO8rFMeWyJMW73OfnQApDtUrVx83XMRI
         3Of7fCYiKQSl1hA63v/1W1IRnpsc7IpcoaBueOvt015ar8k6yglI0uqdYEefhyK99IWi
         hl3QtJxZmwov8Bfo4gcF6HIb7WTpJnA4ZheZGKCvBlLq832k5mWeEpanGl+XZ8NETCRd
         CK8w==
X-Gm-Message-State: AOJu0YwqLWUuuk0hUwVzHcWxCoRgS65pHj7wVc/oJdQaIuAVWHfgP11W
	HGtoqMZhzMKiiykMRe51CuPekojVZKBoaHQNu9/aa9me2h3LbRUYqNAOaFFFJ1+qo0GNZbS2sZY
	yy/O1fM4rIxoBEGrHLyscMpVpHoyI48y4QZEGuQ0B6JSatr6VBsiZMhr/A5cF/A==
X-Gm-Gg: ASbGncs7M25d0ndgTIfEW36Z+hiTo+gbj9DXXvE1IQbHvMXmzilYWUfPTJPq/Il0h3d
	k7Log11LsYVdNJZCyz3NJ7F74mWu9YCfilGaLki7+ZXNrehfDFVplHhs/J1qdkqgmSNawpn0CGc
	/xHhJH0EJWG7vID4jwhBdGZPCJWJl+yh/pLf+uZLw3iLeOQVZvNJLBGQsxcUKWmnNw6jxefLWaT
	nt0L0dKoX8gANUQMyUUiZn/2etfCFoLdejURVdJHHuny7xfNkCvqsrz0rz0DkmitrXZ94qociiR
	MgupP9YlQQRa7GA78PBFlB8KtPa96+EBmcdi/j9lOzq9MlMh8j32hGgdqgOWzDl7eM/ObOLDPJD
	r9WnBRQz5TAclV25DG4o4PqocXo+7l16egA5WGRQy7Fs=
X-Received: by 2002:a05:600c:3ca5:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d509edc2emr21843465e9.10.1742552023634;
        Fri, 21 Mar 2025 03:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBP4NnEBTa8zS0JzRR4KVNM50Jg6dbKBkeZvydjC/x9TK+BLltYzF5+LQX+YUo6w3oEcYOxg==
X-Received: by 2002:a05:600c:3ca5:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d509edc2emr21843225e9.10.1742552023173;
        Fri, 21 Mar 2025 03:13:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f33242sm73565295e9.5.2025.03.21.03.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 03:13:42 -0700 (PDT)
Message-ID: <b6478ad2-7169-42be-b9ba-e703fdbbd553@redhat.com>
Date: Fri, 21 Mar 2025 11:13:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Fix parameter passed to page_mapcount_is_type()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, vbabka@suse.cz, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <20250321053148.1434076-2-gshan@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250321053148.1434076-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 06:31, Gavin Shan wrote:
> As the comments of page_mapcount_is_type() indicate, the parameter
> passed to the function should be one more than page->__mapcount.
> However, page->__mapcount (equivalent to page->page_type) is passed to
> the function by commit 4ffca5a96678 ("mm: support only one page_type per
> page") where page_type_has_type() is replaced by page_mapcount_is_type(),
> but the parameter isn't adjusted.
> 
> Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
> + 1).
> 
> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   include/linux/page-flags.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 36d283552f80..ad87b4cf1f9a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
>   
>   static inline bool page_has_type(const struct page *page)
>   {
> -	return page_mapcount_is_type(data_race(page->page_type));
> +	return page_mapcount_is_type(data_race(page->page_type) + 1);

Probably we should just call page_type_has_type() instead?

-- 
Cheers,

David / dhildenb


