Return-Path: <linux-kernel+bounces-282845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56A94E961
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C628490A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4A16C84D;
	Mon, 12 Aug 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBMJ3f8A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F716C856
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453809; cv=none; b=YGMYCuzrW+LewSojBAyAuJMl3eDwLXfrz9inUdJ1MbulxQpcKsRisr+feG0bXwUN4oG8Vh2EnZy1/d67izsojcLyPq9/p5c1/77gyerIe9g8Mt6HIqhQna7VOs7vSQDDjohiWA5v6ijFJBxOXlEf/wFrw4PK9R2r2yXlWZydkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453809; c=relaxed/simple;
	bh=VLmv1Pd3V6r/4kk3EOWZH7Kegpbm1cdTDLPk7lb7UnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIls6f6fK0ORXfpyk4+/0N7iNEMTbrZjmRwfYhURnqSzPO/clYGSlwHz/WEq+kFhoe/6Xmn+8qscAzsv+X/23CAIi7AgwYy8lxkV9Z2xR2Fvw3V8cOLGyZMayJBRTJLgMXj7t+/SPnOIy5TP2xwCK1NPyUBJ2kDKkIVuzuPc+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBMJ3f8A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FKDCFHvqU1QMsr+kDDQ9HGdx4X9K9oDm5CBSJt6Me6k=;
	b=fBMJ3f8A3LNcu8FV7I9hJJ2KU1b67D1eMsvijo3Mw6l6EPooC7VlJKUnmCiX+GrWqeQrLv
	CepnbpoOdscc+/yxYaBz7eW0BJ0ush7k3yHjWe3I2qWHrs40S3U9VV9YqBFvih+B+YLNnw
	n3UanxJeOSn2G8hnlKdG04F3qPts+y8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TsUHfpJrMRGEKD-I6fT7-w-1; Mon, 12 Aug 2024 05:10:05 -0400
X-MC-Unique: TsUHfpJrMRGEKD-I6fT7-w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so28324255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453804; x=1724058604;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKDCFHvqU1QMsr+kDDQ9HGdx4X9K9oDm5CBSJt6Me6k=;
        b=qqeguknFK4D90yTG2ep93ci1lbTEl0IPnItotypa9UJT9YyVSqejSNGSruFQ86vf3t
         Doqvj40wJiqlJvEfEmZQ0tSGst1Ggc8X01DXgB5M2j/YDOLtz5+C7bUXrCOBCSQ/jfg4
         z+H5Ru4QpjabJB5VWhfNkqWFDqcqTFAIh4HEQK6rJOPQ9TaDJ7xpvRWGkQxfU6LME0F9
         zKv9eqeCVVMGFqLUs474PexE3qHzILqf6DfgJzWEgzudn+DmNPciR2UQMA23q2elply+
         L66lSPfl1kA0TFurgdy7JrETa1OB2fEfqVOOMm+YpNRFgIC2uPygsNqawofjRig2pnPB
         +uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvERaACjrsjpPRsa0vTD8eNmEvS10P4NAuN/LWimgn2mNgd4WbrKsXkqc0otK7M7wXR7twZD+a5Xxmcvss4HgpUrzsWk2VrmcPHC4W
X-Gm-Message-State: AOJu0Yylz13sEIVXPQbHDsjjI3bjtagW6cHNzE56gqAclLq/A3hMAh0A
	1YtpTYY/PNbvPdSVPfNFq4RkMtsD9rYs4hIvIYpMc0y8ajjOZIgTA6kLPhVzjJt8WK2D+cpOpu6
	GFgmu0zDep/x3+7/TC5e7axoGGaV6AHEWhErA4UhkyPpvPkvcG5aI927L+gjISw==
X-Received: by 2002:a05:600c:450b:b0:428:10e3:a000 with SMTP id 5b1f17b1804b1-429c3a5a146mr59588545e9.37.1723453804263;
        Mon, 12 Aug 2024 02:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGItqvTpuEGF/eI/+IinN4QTYQu4hI46eBdsVU+jmMkSbv4885WMTfZHu3bPyL9SL/L5zFcrQ==
X-Received: by 2002:a05:600c:450b:b0:428:10e3:a000 with SMTP id 5b1f17b1804b1-429c3a5a146mr59588315e9.37.1723453803762;
        Mon, 12 Aug 2024 02:10:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ceb6d8a5sm49353455e9.1.2024.08.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:10:03 -0700 (PDT)
Message-ID: <8e987e3f-6899-41d1-9ba4-c49cb91f7815@redhat.com>
Date: Mon, 12 Aug 2024 11:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/swap: take folio refcount after testing the LRU flag
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1723270558-31674-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1723270558-31674-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.08.24 08:15, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Whoever passes a folio to __folio_batch_add_and_move() must hold
> a reference, otherwise something else would already be messed up.
> If the folio is referenced, it will not be freed elsewhere, so we
> can safely clear the folio's lru flag. As discussed with David
> in [1], we should take the reference after testing the LRU flag,
> not before.
> 
> Link: https://lore.kernel.org/lkml/d41865b4-d6fa-49ba-890a-921eefad27dd@redhat.com/ [1]
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/swap.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 67a2467..6b83898 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -226,12 +226,10 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
>   {
>   	unsigned long flags;
>   
> -	folio_get(folio);
> -
> -	if (on_lru && !folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> +	if (on_lru && !folio_test_clear_lru(folio))
>   		return;
> -	}
> +
> +	folio_get(folio);
>   
>   	if (disable_irq)
>   		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);

Ah, "mm/swap: remove boilerplate" reduced them to a single instance, good.

You can throw in a

VM_WARN_ON_ONCE(!folio_ref_count(folio));

before the folio_get(folio)

so we would realize when something very unexpected happens.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


