Return-Path: <linux-kernel+bounces-391359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17A9B8590
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320CD1C217A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F441CC8AF;
	Thu, 31 Oct 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyrkUvSx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC1E47AE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410986; cv=none; b=c430Ii8IUGF7E7rildYlp+1itfCh5zBQV6fXS4P3T/aqK7+R+KVpbLOidQf21WIK20eIwydQh/jFMOs8PxkRpiitYUkW3bV/nIVEfMeHF5I1M5VOFUa28gn98e5X1f8K/1E1X6dZXozGyH5rLx60iOMlFP3TzUOHhO6wjwlGuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410986; c=relaxed/simple;
	bh=BQrxnWwCzRy4lDmJ8wzr/YZzu2JD3V4MOJVB2u6XDI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxRaCUzo02PdTUISTgOcNWaauIkw+ZFmIH3M04mqi34D6o8EQDWXkGPlg5jeFvwfnzJbd2F82zYq83LqHn9oiRK2LS7dKprcmfoQLMh3fjGtl+zXPIMgDNDCO2PQ2DT0iD/ScTMh+iVnOns4yozibY6MyTyRVFyP3w5L1nEMbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyrkUvSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730410979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pW3XyDUHYORo6AOcJmz+XZoymRl7jo8rGbI48Wa+FPo=;
	b=dyrkUvSxS1PcgNkRKuLx/EdfpVCbURtsvTxvQCyjN01rQhukuC4cWBc3UQPkBLru/aa5VW
	p+hdUmSTDIA4qafF65f6CfVuskkZvwBEUw0FyzDbTjpR2twijqwgTRGtsIYB6jbBuBsq9v
	bAD5k+ZhZmmadkHEwsO9rKspyqMb1xc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-tqHiUnGiOGWtBQXoB8NwFA-1; Thu, 31 Oct 2024 17:42:58 -0400
X-MC-Unique: tqHiUnGiOGWtBQXoB8NwFA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so659942f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410977; x=1731015777;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW3XyDUHYORo6AOcJmz+XZoymRl7jo8rGbI48Wa+FPo=;
        b=nmNHey/UUqhWdijTIuxzMsWULNSjW36Xsy1LD0NVGbpGYLywMhe9VoMYIuhX75hJSe
         7A+XvAaGHRX352Ei0IgQJlUJIeCSf9p+XoKChF7GacS5xNkuB2GJ7GlAX6/ZXQYz9KY6
         g13+YGEIS71G5qfA9ewaJ3QAbjZ0dgGznVUO5UAe5N56uWzDEUxPdwAsqKdiTbR4iVfU
         CDVMJHU4LIiX+ZoeFTk1ts6OrHnvhdS1x6kt/4I1b4yrbZ9QCqgNeUwA6dd71zqZ8zXe
         QBQxX+auM05Eb9wyQA7PLs3ybyGIyX73QgaQPmzzpGb/KAb0PkaGATejFIVZQwQlqps+
         AHcA==
X-Forwarded-Encrypted: i=1; AJvYcCVbINfGRCT0wkGU1DVW/LXeyn9niv5/gfLU8z7Y5egWsvN/h5GmpUqmJJp5YAfAwCNAy51qRhxUi/MM6Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPrlBlc2xQ1nATbSCR6utANQl5najw+UcBCk1oSsAGzj2RUt7
	l6Anz14FoXqK1vMSGZrQq5Uakk4FZT1us3cL4785r6xPQAfzEI0dhikPQ8oh+F9AyR7Y6rUTusZ
	T6lTqWqZgPjJrcP7BDdPKcPwvcuwt4y3orDkL3kMA2UObVTzFsBBxK7exZuIrpQ==
X-Received: by 2002:a05:6000:1a8c:b0:37d:48ee:d6fc with SMTP id ffacd0b85a97d-381c7a3a486mr986757f8f.7.1730410977374;
        Thu, 31 Oct 2024 14:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTl0vDqCVIRiVOmlOSF7005qO2un/95FJm+vY3eyjJtpJUezbnd5SGBC40r81fDAMHTh6rMg==
X-Received: by 2002:a05:6000:1a8c:b0:37d:48ee:d6fc with SMTP id ffacd0b85a97d-381c7a3a486mr986742f8f.7.1730410976983;
        Thu, 31 Oct 2024 14:42:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm3196878f8f.103.2024.10.31.14.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:42:55 -0700 (PDT)
Message-ID: <3f4af429-1f60-40c3-bd7f-c8c5950ac6ed@redhat.com>
Date: Thu, 31 Oct 2024 22:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma: Detect infinite loop in vma tree
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.24 20:36, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> There have been no reported infinite loops in the tree, but checking the
> detection of an infinite loop during validation is simple enough.  Add
> the detection to the validate_mm() function so that error reports are
> clear and don't just report stalls.
> 
> This does not protect against internal maple tree issues, but it does
> detect too many vmas being returned from the tree.
> 
> The variance of +10 is to allow for the debugging output to be more useful for
> nearly correct counts.  In the event of more than 10 over the map_count, the
> count will be set to -1 for easier identification of a potential infinite loop.
> 
> Note that the mmap lock is held to ensure a consistent tree state during the
> validation process.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> ---
>   mm/vma.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 68138e8c153e..283e6bc4884f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -615,7 +615,10 @@ void validate_mm(struct mm_struct *mm)
>   			anon_vma_unlock_read(anon_vma);
>   		}
>   #endif
> -		i++;
> +		if (++i > mm->map_count + 10) {
> +			i = -1;
> +			break;
> +		}
>   	}
>   	if (i != mm->map_count) {
>   		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);


Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


