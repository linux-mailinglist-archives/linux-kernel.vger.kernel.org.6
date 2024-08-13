Return-Path: <linux-kernel+bounces-285154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B159509E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A061F216B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0391A0AE6;
	Tue, 13 Aug 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euvXxtYb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44331A0709
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565588; cv=none; b=k0CCwKMD1LmEPwTFgLBA8bSRVO4kLP2doFFSBNdP4aBvSo+5vYsWrdkH68lNhmyGAUV2/0dyw/uhSlJEMLvcYSQLYJXi3zm51YrGsN/RTpFy5BGzbph1568Fk9O0U6IeataH/KBj5ws1kStnI06TOyOYfiyaBfDZoUXbkHhgyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565588; c=relaxed/simple;
	bh=b83S4Czwn/5oYGYSbzkAyPNNMyrTt1b8Jzeoi8OsR+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQFr1b4uaho/132mJWNbNE/4pRbwKg/lYbtUnaAuqy/TlP4g4AzED5j+XLKtvDmk7iTt5HMm0MK9LQgRmak2B1v1K5YqWgFLW5h1hDAln/+BG/eyAX4ymBN3tIp0VTAkoRtHHXlzk7tBcz202lQ/R6zc2opNFx7zly6Bxj5pi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euvXxtYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723565586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uzgG8ve08NJGLjWOCLCismVrD3Vjyv1VtcddLsQzOz0=;
	b=euvXxtYb3Z+GSnql3Rode7nr9jsY2B52CvUDuiKmy58E6G4xTZeqy83en2yhFhkbnMjkoC
	EZEhuVXxoahgjnV0aQ0XZoFZYS/FDv7YliPesdSPFck0Wj08HZHwluivPeOLY9d2Iq/2b3
	RzUxRTlTjDJV8jkUBld41vn6UGw5tA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-TQ_kEASnPe2Uumqy-9MQlA-1; Tue, 13 Aug 2024 12:13:04 -0400
X-MC-Unique: TQ_kEASnPe2Uumqy-9MQlA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808efc688so41864965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565583; x=1724170383;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzgG8ve08NJGLjWOCLCismVrD3Vjyv1VtcddLsQzOz0=;
        b=aY1QB5lVnNMoSVjDVhQrNqVUm0sgLQkIBlvvQ3o3DZZxaDFScBNAQsz+bL4VK8XqOr
         UynCabEbB10OgemBm2/nCNj1dS2uLacNp/ah//AvCKrRdQ2ilyQXi00SC7IWBczcxe/I
         ONh3wB8H2W74bBlru27DIow24jMlHgXFd/ZuV84mflMeaPgKPOGtSX6OUbUH7/tPspAY
         Tsn1mf5wFM9gN/xl0JFd+ErbgrdV/uAkoOyOMgeLD4ZGTeZw3Gq/5Q6bf27uik7kmvjU
         cWqzv0WGdErtu8pphkqoZrqvWWVAp0T1rad1PF6awN10Pl++FTMOVS0e9/yuMXGKOXNC
         u9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtnyXTvalbhVVKy/3HjhM8onWBUFcL1Za4ilhZcdAV1lckOlkcfwlL3q9sGTEbYwLcNREzjE3+edx6xeN6RyzWpu9Vm70xaLF4GC6+
X-Gm-Message-State: AOJu0YwJaANDinWSlufMPpCHtS3MlPk0KrruhxfxBThUylpm0ow0lNBs
	h8JI5qSj1xmWIu1WxFtxxSEp0JdpflDnLN8I1GZSeHEvdrzMiie93iEIt1bvu+u1yZBZqMzaOUM
	tcBIPSqdUXff/ky+LtSmq2YaUhgbZliGQwY/lsZ2l0h119Yz7JaY+KJrB+8ZnEQ==
X-Received: by 2002:a05:600c:46cd:b0:427:985b:178b with SMTP id 5b1f17b1804b1-429dd23b760mr174035e9.16.1723565583539;
        Tue, 13 Aug 2024 09:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtA7ioWQnHXwZZZnRwSH3TP8a8jUevCiDYxIsFY1mSEVdOVWHxVvRZBtwESmsGVGx62G1vgg==
X-Received: by 2002:a05:600c:46cd:b0:427:985b:178b with SMTP id 5b1f17b1804b1-429dd23b760mr173745e9.16.1723565583053;
        Tue, 13 Aug 2024 09:13:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm238744585e9.37.2024.08.13.09.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:13:02 -0700 (PDT)
Message-ID: <3c227f55-613b-4acf-a6e4-b054c8b54277@redhat.com>
Date: Tue, 13 Aug 2024 18:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: ryan.roberts@arm.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 corbet@lwn.net, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240812102445.162087-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240812102445.162087-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 12:24, Barry Song wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Add thp_anon= cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
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
> ---
> -v3:
>    * support formats as below, Per David's suggestion
>      thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
>    * document the relationship between transparent_hugepage
>      and thp_anon better, Per David;
>    *
>    Hi Baolin,
>    I am taking your Reviewed-by because the code has
>    changed quite a lot.
> 
>   .../admin-guide/kernel-parameters.txt         |   9 ++
>   Documentation/admin-guide/mm/transhuge.rst    |  37 ++++--
>   mm/huge_memory.c                              | 112 +++++++++++++++++-
>   3 files changed, 150 insertions(+), 8 deletions(-)
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
> +			system with respect to anonymous transparent hugepages.
> +			Can be used multiple times for multiple anon THP sizes.
> +			See Documentation/admin-guide/mm/transhuge.rst for more
> +			details.
> +
>   	threadirqs	[KNL,EARLY]
>   			Force threading of all interrupt handlers except those
>   			marked explicitly IRQF_NO_THREAD.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 7072469de8a8..528e1a19d63f 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -284,13 +284,36 @@ that THP is shared. Exceeding the number would block the collapse::
>   
>   A higher value may increase memory footprint for some workloads.
>   
> -Boot parameter
> -==============
> -
> -You can change the sysfs boot time defaults of Transparent Hugepage
> -Support by passing the parameter ``transparent_hugepage=always`` or
> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
> -to the kernel command line.
> +Boot parameters
> +===============
> +
> +You can change the sysfs boot time default for the top-level "enabled"
> +control by passing the parameter ``transparent_hugepage=always`` or
> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> +kernel command line.
> +
> +Alternatively, each supported anonymous THP size can be controlled by
> +passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
> +where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
> +``madvise``, ``never`` or ``inherit``.
> +
> +For example, the following will set 16K, 32K, 64K THP to ``always``,
> +set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
> +to ``never``::
> +
> +	thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> +
> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
> +not explicitly configured on the command line are implicitly set to
> +``never``.
> +
> +``transparent_hugepage`` setting only affects the global toggle. If
> +``thp_anon`` is not specified, PMD_ORDER THP will default to ``inherit``.
> +However, if a valid ``thp_anon`` setting is provided by the user, the
> +PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
> +is not defined within a valid ``thp_anon``, its policy will default to
> +``never``.
>   
>   Hugepages in tmpfs/shmem
>   ========================
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1a12c011e2df..e8eeb8111f6e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>   unsigned long huge_anon_orders_always __read_mostly;
>   unsigned long huge_anon_orders_madvise __read_mostly;
>   unsigned long huge_anon_orders_inherit __read_mostly;
> +static bool anon_orders_configured;
>   
>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   					 unsigned long vm_flags,
> @@ -737,7 +738,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
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
> @@ -922,6 +926,112 @@ static int __init setup_transparent_hugepage(char *str)
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
> +	order = fls(size >> PAGE_SHIFT) - 1;
> +	if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> +		pr_err("invalid size %s order %d in thp_anon boot parameter\n",
> +			size_str, order);
> +		return -EINVAL;
> +	}
> +
> +	return order;
> +}
> +
> +static inline void set_bits(unsigned long *var, int start, int end)
> +{
> +	int i;
> +
> +	for (i = start; i <= end; i++)
> +		set_bit(i, var);
> +}
> +
> +static inline void clear_bits(unsigned long *var, int start, int end)
> +{
> +	int i;
> +
> +	for (i = start; i <= end; i++)
> +		clear_bit(i, var);
> +}
>

Do we really need atomic set_bit/clear_bit here or would 
__set_bit/__clear_bit be sufficient?

Also, could we use bitmap_set/bitmap_clear here?

-- 
Cheers,

David / dhildenb


