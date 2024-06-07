Return-Path: <linux-kernel+bounces-205573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCD8FFD9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86761C223A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00C15A87A;
	Fri,  7 Jun 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+B6uDyD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3D502BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746997; cv=none; b=oOVsIRZ+nK54OgEwlyFc/sI/HzhN+/GfNO6d0gmv1VjTNS7GImhgqJbDWMcG0KRyPQMaPvs8JA/iT+L1aUHN2Qm1nHv7SBqoWQPSoS9Q+5fhmu2/JSotGsGVhv71IxovEPkxnjYZv8vk+KEMkeD1MBuF0LCoMxXEpzfxws9HKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746997; c=relaxed/simple;
	bh=5zVmGjHBqLnjcaTGlEL5mdgTvSgP4QWH8vYRTo7p86w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLF8trL5xTf+Rmrxz7/EOeBn3N734m7HY6Pfr63tZ8EAxWfv3Fsraur/y5kKp5AmzW4Qd+4ZRAFFAK65Fe5YrZnNnkOn3YsxUKGIZlVLfAPpqNy9SiTY8w7BIg8GRzblaATSrzX2QmjT06F8zqcF5yO3qX2Yx+ofu982KBH4pi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+B6uDyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717746994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TNkZu6aJTtLcPXJz8WKuRL3A8ThYfTKc9Xpr4uCW+bg=;
	b=D+B6uDyDhD1pEtpA8e4C4NK+fAO9UNcVr2yWO5ivNUSNdhDF9p7EjSgRuI6qnvb+joR5ke
	OKI89/tVRXdrx0xCM2ymHiUE3/AjqmYyXx9dH3sMXme9RCb8s1SlVYfDMdGKWr3HBzKvzb
	aQ52uqQeHSSLSr9nk67/PeD8kxcKSBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-uLVbwKRUM2-WNY8rMbaywg-1; Fri, 07 Jun 2024 03:56:31 -0400
X-MC-Unique: uLVbwKRUM2-WNY8rMbaywg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215a04220eso17408835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746990; x=1718351790;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNkZu6aJTtLcPXJz8WKuRL3A8ThYfTKc9Xpr4uCW+bg=;
        b=Yj+haWP0WqGXUABrgIEMDx0g5hAGM085JjuQvp4H8PbGvLCEKG23THD+c5XdAoyeW1
         pXYeHrK/Any6byiRxNybpZUB9eKjoSZAvx/q/8I+p1HEt7eXBzOxh7Z448ERDBcaZEQ/
         MKFifipCUsQeiTMt7qbkY8KEJOQ1N8vd4gmrkKWe2mDnxr2PUg3Hu0UBT9Iddlv15mOa
         zgnAeL4okgJitj0f0UAGBv+W2pnS89V2Df5GqVB94SMxtmUcfH1XqV8mEPKUPjbkzGOE
         FjsBpoRpVpP0dfNeuOSTdwh5PmMIJW/FfRojktprnMQkIfKo+6llXSqshQUkLFZRe13N
         tacg==
X-Gm-Message-State: AOJu0YxLNT92GEvdphxyVj/2epbwZxfR3J+KdWfhXLlEoPtit+tlGAef
	JEMzsARjD5aFKC3YksA043FH2yfz6Hh/uzrvtyjCGjWqhCuHp1SOmakuEpQnL+u3Fy0sev7Scef
	Zp7ylTRnaM71Zgqoe4PgwXwhT7tA63oqhbvcxXjSRuphEVlL8r6iP1Wpw34M9pw==
X-Received: by 2002:a05:600c:154d:b0:421:54d0:5123 with SMTP id 5b1f17b1804b1-42164a44574mr22421825e9.34.1717746990308;
        Fri, 07 Jun 2024 00:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWeGXiJbrqo/myILHAwIRCtkynMU+u745hJ8p+7jN+ji1qGUr2ZckZCgebiS5P/XoJvVvyHQ==
X-Received: by 2002:a05:600c:154d:b0:421:54d0:5123 with SMTP id 5b1f17b1804b1-42164a44574mr22421575e9.34.1717746989935;
        Fri, 07 Jun 2024 00:56:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d13esm76418435e9.24.2024.06.07.00.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 00:56:29 -0700 (PDT)
Message-ID: <3a861b0d-ba01-44d4-aa6b-63675a8f8e4c@redhat.com>
Date: Fri, 7 Jun 2024 09:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: xu.xin16@zte.com.cn, ziy@nvidia.com, v-songbaohua@oppo.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 11:42, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But the test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.
> 
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, so
> (head[i].index >= end) is always false. shmem_mapping() is not called.
> 
> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> for anon mapping, So we can detect the wrong use more easily.
> 
> THP folios maybe exist in the pagecache even the file system doesn't
> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled, khugepaged will try to collapse read-only file-backed pages
> to THP. But the mapping does not actually support multi order
> large folios properly.
> 
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
> 

Smaller nits:

> +	} else if (new_order) {
>   		/* Split shmem folio to non-zero order not supported */
>   		if (shmem_mapping(folio->mapping)) {
>   			VM_WARN_ONCE(1,
>   				"Cannot split shmem folio to non-0 order");
>   			return -EINVAL;
>   		}
> -		/* No split if the file system does not support large folio */
> -		if (!mapping_large_folio_support(folio->mapping)) {
> +		/* No split if the file system does not support large folio.

/*
  * No ...


> +		 * Note that we might still have THPs in such mappings due to
> +		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
> +		 * does not actually support large folios properly.
> +		 */
> +		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +			!mapping_large_folio_support(folio->mapping)) {

if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
     !mapping_large_folio_support(folio->mapping)) {

>   			VM_WARN_ONCE(1,
>   				"Cannot split file folio to non-0 order");
>   			return -EINVAL;
>   		}
>   	}
> 
> +	/* Only swapping a whole PMD-mapped folio is supported */
> +	if (folio_test_swapcache(folio) && new_order)
> +		return -EINVAL;
> 
>   	is_hzp = is_huge_zero_folio(folio);
>   	if (is_hzp) {

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


