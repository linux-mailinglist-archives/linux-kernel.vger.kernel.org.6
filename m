Return-Path: <linux-kernel+bounces-418152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EBE9D5DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D6F283F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A11DE2C0;
	Fri, 22 Nov 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuJmY8+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41C1DE2AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273838; cv=none; b=FcSi+aosHKyxaiiJ9VUEuAlbkqUJ0/wogyBDvK1qzaMAVoHjg1wlsXNUlGxKo5iSWIpCP1OYs+JCBAPAJvwgDgHxajmI9IXepLA8vR2toTyizxLoZ7YF+oWzur7L2kxdNYTOjLlId+DbAlov98070GDpPj1VSOWXNbHAIEG4a7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273838; c=relaxed/simple;
	bh=D0i6duhLs6p0YnTrBRTz/Rv5gj1/m94f/UPx7vBBFwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSulGIHimVV+yUkYj/CdrfdYWwT4FK5aL+axLkfQfCYQTYrLXrE0A8uBmhBpQGIVUFAE7PCG2j8pzpkir+l11AYhLtPrzqidUud71NrjYrRHr8xkvNZZT1dEIVtxnYqSF1EX6OgqiwohZhW0OXvcewAm8jYO4OixP1UZPQis2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuJmY8+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjuvFzSNk1HRpi+DS7yr7jLFl3FSsGwM1+OucgYZlwA=;
	b=MuJmY8+QBvXKzpKCfVrZ7H7zMz5GXb/BwqmY0/H2KvHczUjzKSIUro+7q88bsJRYBobM9V
	sCTVpDovX/48BcgOEkT3sL6ZzpNJ/4syAN/Fwc5bBJVJShGksXwca7Drfvk9T37YaLbRPO
	WV3YukO8h8Fb26PVs3+Kik+YaaawlBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JmpcYZWiMjm0L8Uv8oZAaw-1; Fri, 22 Nov 2024 06:10:33 -0500
X-MC-Unique: JmpcYZWiMjm0L8Uv8oZAaw-1
X-Mimecast-MFC-AGG-ID: JmpcYZWiMjm0L8Uv8oZAaw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-432d9b8503cso16051115e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273832; x=1732878632;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WjuvFzSNk1HRpi+DS7yr7jLFl3FSsGwM1+OucgYZlwA=;
        b=u6FhhMKp+zm6GDd3REfeHQpecOsFXFDQYRC1qWTti958N1fi+gF8e58HRUG8jTG79S
         xANRFYLc3edDrLeuZnD32+pyG4Y5ufMemv/s/fKanbFOdwOgzOYN7Sl3yFhQy67cxXKj
         rc4/fvY8WGMi0Mu48Yzcd8LMKqyeB5jJB8zOo5V8uy7loUK1FoU2LCT/EO5BIiSX9Ol5
         hD+0lW4kEncbO2PgpMCQd4PGMDhZYH5u5IkC+6DzlfEfnTXqZO04K8Au917Y9laDk4Cu
         epvef2pF6ux2B4b48U/y5ohLNqADZPKtL9i+ZeqOoiH6x6wnnWHlhpON+ijT9uNB5Wjd
         uJpw==
X-Forwarded-Encrypted: i=1; AJvYcCXcrfMhx1rfrwtQfSHOXn83hNycFQo8GuM06KUg+2vw0VsgMdFAbhnDYmOlCoYJrc3+aJXzCjzjFUiqr1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxpeipmpmRp6hAhzVPXH22NRYWU1fTp83MUfIfnN7R0fggVBE
	LB0kwik3CtVuMC08TTGW18KzJXoRTZekLPLY3HOdzag/WPDBAIv33rbktPSc6enhhrZfuCRTYrr
	PikjLXOMQVl6uhS6NXCbyhcAvLykTVucW5M+ipbXsw8OWcRMm16bmw0bon5QnKg==
X-Gm-Gg: ASbGncuSX9EQAeRpYgP0IYfH7dTCOUHTpouBX266iiVkE4LLz0tmMFuqhfhupdx26NC
	wN3sFEIoeZaYfYu8FR9h7he7+9pitutHLSDpJt0vtr7NX4UtXosgtc/kgcmN5wKp+dcoVTtOPt4
	6Cco/LEk9IhJL/GPp5ibb06F80+uqiosvmXw6fWWyFuEYLkr1vPD/GrvFvoUb1MpFTLLVs2Ry3E
	T7+GWrnlJV0r8j0l2Y9e4AMai5pkm3aAA56Kvfw3bNjCPYevIL2xvu5//ZJ1zjQMChCrBo179D0
	gR5K387DIWYsqXTpNi6REuFIg411z8vu9J+Cr7D2noUNmMO4lob1Hahx/32KV8aBXOAuRnddSMo
	=
X-Received: by 2002:a05:600c:917:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-433c5ce57d3mr59075795e9.15.1732273832719;
        Fri, 22 Nov 2024 03:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeYMDb7+3fkk7/17y2EpOUO4usDkj+WgYyjOGc/JOqT/cbixRvnDnT5jJtPNoIoj7vn6Vy2g==
X-Received: by 2002:a05:600c:917:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-433c5ce57d3mr59075515e9.15.1732273832391;
        Fri, 22 Nov 2024 03:10:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8c6casm23630315e9.33.2024.11.22.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:10:31 -0800 (PST)
Message-ID: <46aa36f0-64a6-4aee-8134-0ec93f62e59c@redhat.com>
Date: Fri, 22 Nov 2024 12:10:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] seqlock: add raw_seqcount_try_begin
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
 willy@infradead.org, brauner@kernel.org, oleg@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
 viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241121162826.987947-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241121162826.987947-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 17:28, Suren Baghdasaryan wrote:
> Add raw_seqcount_try_begin() to opens a read critical section of the given
> seqcount_t if the counter is even. This enables eliding the critical
> section entirely if the counter is odd, instead of doing the speculation
> knowing it will fail.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Applies over Linus' ToT
> 
>   include/linux/seqlock.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5298765d6ca4..22c2c48b4265 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>   	__seq;								\
>   })
>   
> +/**
> + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> + *                            w/o lockdep and w/o counter stabilization
> + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
> + *
> + * Similar to raw_seqcount_begin(), except it enables eliding the critical
> + * section entirely if odd, instead of doing the speculation knowing it will
> + * fail.
> + *
> + * Useful when counter stabilization is more or less equivalent to taking
> + * the lock and there is a slowpath that does that.
> + *
> + * If true, start will be set to the (even) sequence count read.
> + *
> + * Return: true when a read critical section is started.
> + */
> +#define raw_seqcount_try_begin(s, start)				\
> +({									\
> +	start = raw_read_seqcount(s);					\
> +	!(start & 1);							\
> +})


In gup_fast(), we simply do

seq = raw_read_seqcount(&current->mm->write_protect_seq);
if (seq & 1)
	return 0;

Should we be using that there as well?

if (!raw_seqcount_try_begin(&current->mm->write_protect_seqs, seq))
	return 0;

-- 
Cheers,

David / dhildenb


