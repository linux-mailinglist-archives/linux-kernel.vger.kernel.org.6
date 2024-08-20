Return-Path: <linux-kernel+bounces-293481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C691958058
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D281F23CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10158189BA3;
	Tue, 20 Aug 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nzh0uQdR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663618E34F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140404; cv=none; b=SpgD1nOtchKs5af0GsFFK9NcMPCx02TGbe9bmKrtaGkCgR/ebb4Q0t4maNyRX1v7SWz44D177WGpYMYd94vBNRb/UyKRgrETiYkFlPEcs+2jOkQ8rP2NXUW5iMEfNx2XG6ZQUn56OWa3lIQNDhU7HsZcXFWZLO8ZHQFxm3ILock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140404; c=relaxed/simple;
	bh=A5G4Rm8XWmASjBtaXl7G/exvpQUT51QQSe7/4IRC0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6tkhAe06Sj0UfRbepQLfBSSfPN7M1ej8uOFkdA5jwZ4lA26FQdjI3XOpOKENNDW3b1TMype52o0xrjEgK3imKxgvlWumiPTTnEHGs4f5vxk/5D2IXoU67qi8xE4SEYFbJq7zsQoA4gswxthNs1t58yGLvNERbiXrKj5OGry1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nzh0uQdR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724140401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJ/f2InT+rIdlvMsba4cZ0b6wvEJfFILppiqtiUQSE8=;
	b=Nzh0uQdRgW0pOkz1FvHLslqwB712v5AkaCzv7Tahic15v0in6oNr7rQGPXOpj47HRywG+D
	uuTKUt1U2mLR2iMkqxT+VabdREwQHo6Vt9wKSufCT0kozNk2NqkxqnMkqJ//ygSJZs5lgR
	eYMGs79I2tZhQ9WYiBoNo9evXnMxw/g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-aH8bUSEbOvGW7vqcZfCbug-1; Tue, 20 Aug 2024 03:53:17 -0400
X-MC-Unique: aH8bUSEbOvGW7vqcZfCbug-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so41455395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724140396; x=1724745196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJ/f2InT+rIdlvMsba4cZ0b6wvEJfFILppiqtiUQSE8=;
        b=JxwODq+j2138RyR66ZtL6H0OWttVmLKbb+Zv1Z0FlaTdXt4x26rJRAMl1wF5UuEJqX
         OdrOsiSjRW41bwkKqWxiN0L+7bJDkF+8//24StAYfnHiOI8m5pgvqPkDQ2PD1QAKd5G5
         FAPP+Nm2OBpe7hz+LyQTPfo+zL0Xsk42G3mBiS41TrWC7RTmaGPVxd4kFjUjsRT3zJDJ
         a0KqkooCmtwDW1NUUoKdAoCc04KOqT8vnZTlEBvdkbkCoUgvzc05adtxeck8trOCY00p
         RSVRBLnE4pvNIimoFJ2wb21L6fcCV5JJHewqWK3+2kxnTSoq7Tkkbw9KFrzzpMT5Zg01
         SzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgAuduqLNui4sgjwQd106U8FUkyk6hy7mh2sPs+VVo//1bxsEdvqhWgW9PtfqMqil8gPO04urMaIPL98g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeYjTEGvR7BU1Sad99H8kXs6pkfMswhvZVKKmrWWlvJ0FSPR+
	CXZgW1V4FkQ1415oXXAYbB7TMhH9XnlYRtk2PQBZS8ZUpeg3DbTMveqtgTNmuRS9Otv9vEvLAqY
	5v4ry/nu4w8F7ipWoaJihhBOE47DT2J6trqAAZg52GBseqD05eIW8nDwzChnbMg==
X-Received: by 2002:a05:600c:310f:b0:426:5b21:97fa with SMTP id 5b1f17b1804b1-429ed7e432cmr110396245e9.29.1724140396462;
        Tue, 20 Aug 2024 00:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKF9tbs3TxyVLawmP6xbfPrLvS5chViXYaWgcFNPtLJq/kkxt8HYBLAltrhLoOL7Ja2XgKTA==
X-Received: by 2002:a05:600c:310f:b0:426:5b21:97fa with SMTP id 5b1f17b1804b1-429ed7e432cmr110395855e9.29.1724140395510;
        Tue, 20 Aug 2024 00:53:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed? (p200300cbc74b0e009c12cdf2bf1cb8ed.dip0.t-ipconnect.de. [2003:cb:c74b:e00:9c12:cdf2:bf1c:b8ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36051sm186115095e9.24.2024.08.20.00.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 00:53:14 -0700 (PDT)
Message-ID: <e36e4157-ba42-432f-aebe-7c2c36917e57@redhat.com>
Date: Tue, 20 Aug 2024 09:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baohua@kernel.org, baolin.wang@linux.alibaba.com, corbet@lwn.net,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com
References: <20240817045516.58037-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240817045516.58037-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.08.24 06:55, Barry Song wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Add thp_anon= cmdline parameter to allow specifying the default enablement
> of each supported anon THP size.  The parameter accepts the following
> format and can be provided multiple times to configure each size:
> 
> thp_anon=<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>
> 
> An example:
> 
> thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> 
> See Documentation/admin-guide/mm/transhuge.rst for more details.
> 
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Lance Yang <ioworker0@gmail.com>


Acked-by: David Hildenbrand <david@redhat.com>

Some nits:

> ---
>   -v5:
>   * collect Baolin's reviewed-by and tested-by tags, thanks!
>   * use get_order and check size is power 2, David, Baolin;
>   * use proper __initdata
> 
> .../admin-guide/kernel-parameters.txt         |   9 ++
>   Documentation/admin-guide/mm/transhuge.rst    |  38 +++++--
>   mm/huge_memory.c                              | 100 +++++++++++++++++-
>   3 files changed, 139 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f0057bac20fb..d0d141d50638 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6629,6 +6629,15 @@
>   			<deci-seconds>: poll all this frequency
>   			0: no polling (default)
>   
> +	thp_anon=	[KNL]
> +			Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
> +			state is one of "always", "madvise", "never" or "inherit".
> +			Can be used to control the default behavior of the

s/Can be used to control/Control/

> +			system with respect to anonymous transparent hugepages.
> +			Can be used multiple times for multiple anon THP sizes.
> +			See Documentation/admin-guide/mm/transhuge.rst for more
> +			details.
> +
>   	threadirqs	[KNL,EARLY]
>   			Force threading of all interrupt handlers except those
>   			marked explicitly IRQF_NO_THREAD.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 60522f49178b..4468851b6ecb 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -284,13 +284,37 @@ that THP is shared. Exceeding the number would block the collapse::
>   
>   A higher value may increase memory footprint for some workloads.

[...]

>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   					 unsigned long vm_flags,
> @@ -756,7 +757,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>   	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>   	 * constant so we have to do this here.
>   	 */
> -	huge_anon_orders_inherit = BIT(PMD_ORDER);
> +	if (!anon_orders_configured) {
> +		huge_anon_orders_inherit = BIT(PMD_ORDER);
> +		anon_orders_configured = true;
> +	}
>   
>   	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>   	if (unlikely(!*hugepage_kobj)) {
> @@ -941,6 +945,100 @@ static int __init setup_transparent_hugepage(char *str)
>   }
>   __setup("transparent_hugepage=", setup_transparent_hugepage);
>   
> +static inline int get_order_from_str(const char *size_str)
> +{
> +	unsigned long size;
> +	char *endptr;
> +	int order;
> +
> +	size = memparse(size_str, &endptr);
> +
> +	if (!is_power_of_2(size))
> +		goto err;
> +	order = get_order(size);
> +	if ((1 << order) & ~THP_ORDERS_ALL_ANON)

Could do

"if (BIT(order) & ~THP_ORDERS_ALL_ANON)"

> +		goto err;
> +
> +	return order;
> +err:
> +	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> +	return -EINVAL;
> +}
> +
> +static char str_dup[PAGE_SIZE] __initdata;
> +static int __init setup_thp_anon(char *str)
> +{
> +	char *token, *range, *policy, *subtoken;
> +	unsigned long always, inherit, madvise;
> +	char *start_size, *end_size;
> +	int start, end, nr;
> +	char *p;
> +
> +	if (!str || strlen(str) + 1 > PAGE_SIZE)
> +		goto err;
> +	strcpy(str_dup, str);
> +
> +	always = huge_anon_orders_always;
> +	madvise = huge_anon_orders_madvise;
> +	inherit = huge_anon_orders_inherit;

Should we only pickup these values if "anon_orders_configured", 
otherwise start with 0? Likely that's implicit right now.

> +	p = str_dup;
> +	while ((token = strsep(&p, ";")) != NULL) {
> +		range = strsep(&token, ":");
> +		policy = token;
> +
> +		if (!policy)
> +			goto err;
> +
> +		while ((subtoken = strsep(&range, ",")) != NULL) {
> +			if (strchr(subtoken, '-')) {
> +				start_size = strsep(&subtoken, "-");
> +				end_size = subtoken;
> +
> +				start = get_order_from_str(start_size);
> +				end = get_order_from_str(end_size);
> +			} else {
> +				start = end = get_order_from_str(subtoken);
> +			}
> +
> +			if (start < 0 || end < 0 || start > end)
> +				goto err;
> +
> +			nr = end - start + 1;

This only works as long as we don't have any "Holes", which is the case 
right now.

> +			if (!strcmp(policy, "always")) {
> +				bitmap_set(&always, start, nr);
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +			} else if (!strcmp(policy, "madvise")) {
> +				bitmap_set(&madvise, start, nr);
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&always, start, nr);
> +			} else if (!strcmp(policy, "inherit")) {
> +				bitmap_set(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&always, start, nr);
> +			} else if (!strcmp(policy, "never")) {
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&always, start, nr);
> +			} else {
> +				pr_err("invalid policy %s in thp_anon boot parameter\n", policy);
> +				goto err;
> +			}
> +		}
> +	}
> +
> +	huge_anon_orders_always = always;
> +	huge_anon_orders_madvise = madvise;
> +	huge_anon_orders_inherit = inherit;
> +	anon_orders_configured = true;
> +	return 1;
> +
> +err:
> +	pr_warn("thp_anon=%s: cannot parse, ignored\n", str);

"cannot parse, ignored" -> "error parsing string, ignoring setting" ?

> +	return 0;
> +}
> +__setup("thp_anon=", setup_thp_anon);
> +
>   pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>   {
>   	if (likely(vma->vm_flags & VM_WRITE))

-- 
Cheers,

David / dhildenb


