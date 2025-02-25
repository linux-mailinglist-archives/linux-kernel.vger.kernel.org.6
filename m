Return-Path: <linux-kernel+bounces-531916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95730A44672
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CDE7A3DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFC1991C9;
	Tue, 25 Feb 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diYv6aAv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6C194A6B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501587; cv=none; b=mx3QbPjXSDXkJ7CRA+Q1V7Zls6qt8+07suCsR1YehvCafWLe+AqUvPztUzDmTVSulCStXDJ4KWWUpZSd40+i4Hh1dkHGaKlMqvZFXFvX0RTuUQwNcY6qX258rGlfp9SCCOKyHiQIj+43+Sj87nU2GVSz6Wlf8e561qRq4wsvZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501587; c=relaxed/simple;
	bh=zJVPGZDau45lRLZCMSA1pScSSffsI75RYvRwKgkjVCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEPIMQqWqzjHTRsQdv0vgkKeA9TqSqZ20+xJUq69LOjwtOqYuAxNeh69ysfK7tHwwHT1cyTht3w0lxOLuMvNqqtMSaIGlp1mHEFD1tZvAKiuS/MhS4NhvCvOu8kdhYVpkb5o77xfixomdc67em0eEAtzo1k9eP9vWYrTO02m0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diYv6aAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F9NsP8HkYSfBFB5fmrghW4I46Gs5TR0sX8AHCHPv1Rs=;
	b=diYv6aAv7jTs5QuQWXfuAfQ/CA2i12+403bYxicZA/VmoTx/ONWHU09jd9DPoCm7IEJrOe
	UH3d8jY6LhI7j4HE+lFTUYTStX3Dm6J9eEMkct4AnNMlzNolsP9fsVxrxy9dUse+za8Kz3
	Sj4RIJcEoMzYrxfAxXvGecXFrBwneKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-OamqC6xjM52QupBNxDrenw-1; Tue, 25 Feb 2025 11:39:43 -0500
X-MC-Unique: OamqC6xjM52QupBNxDrenw-1
X-Mimecast-MFC-AGG-ID: OamqC6xjM52QupBNxDrenw_1740501582
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so29977965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501582; x=1741106382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9NsP8HkYSfBFB5fmrghW4I46Gs5TR0sX8AHCHPv1Rs=;
        b=hrh0qzSC6vAj930W4IAkvAr0w7+gW1HchTSTyZ8YjIARhYluLI5J3pctRZIjbrS1VT
         YPPH3vU1xWWp8vogZfV8lLssZOV7YKFqTJHG4nt9QPu6icib3yvyINxlildrROGcbeEJ
         BEqaVcXTcVX8MzilkE4OWIXDuNq2NrFrxRhnb3QKtaPirCHZ5QQPZl5RDzA/T88+39Zv
         6rIYB0IOxFleCmJm1du8dCYFumSwVYFP9YabR/jMGGiLp9RYhklNVJb9o46Em+m+MN1x
         +mMZ1EPloNAF5WVKICZAbvJRYNj4uiHWQxxVdKEN8PwNcdxj8nOy3L967mdJxR7fwJRx
         oYlA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8Mk0vJ1YfVZ839eMcJ/c0wDHp2p7mpOdQomre+5Nc8OvdGgqfbVprDgOJ7L3Dg0u65zo+WNGIh/B2HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7c/+MdCHmXIJkkBRTnjAfsYfd4SRg4ksOHFueDiTVyZ3yBdtA
	K6t1AHk6bHSiMK0Qc8cE7SIVm88C4JUP2PiHRF7DcIbVDmJfsn+qlbhwZU30rPfarjpdS/SYQpq
	54BuAah49UYJyWtKXjuvmz/AGfFlsuCb+zgAPHUAwDxjoKrzhG5OosMquTATB9w==
X-Gm-Gg: ASbGncv5pDlmk3SfL9tPAGBAMH99q7R/69NMhJk82QZ9A8W8Qp9E2g1SbXQ8FTQ2AG+
	MYffCFp6oRRnSJP4bR5au2rjUcG9ybmp6lXTyFhlpuETskMSJeh78oq7VWx5kkvegp4yf1wL3Tx
	6miHKdpRJawGyBrn2d6EEIXMeAdoayKNOd1PXvG4eeU/a2QNJVDb4Yz/Gefjv9sgA3CLkv+W97A
	ygkNpP2rp3lk2OhPoWBblJklY6pZfvcbu6w5k3QvG/m+ZnapM8uySnWJg0gbZUzFg5Z8zMas3+m
	3UPJ/On/0irs0cbGQHbT3FseWrY+4AlpWBz7+b6FBQ7BVvr7kZIzbuj/VZH3dWgINh8Ev/tict5
	hbXxxke/f6GMDyhFeYcDNus4JiVqLlPs+yKds/3Ld4p8=
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr169353765e9.14.1740501582477;
        Tue, 25 Feb 2025 08:39:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2i5Ain9HqZn6+kP3VP0s7r7NwO593cNceHJrsfDZtISITkhnTGvVWYfMNCJK8RjZPb0nHWg==
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr169352755e9.14.1740501580605;
        Tue, 25 Feb 2025 08:39:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1546f22sm31965995e9.19.2025.02.25.08.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:39:40 -0800 (PST)
Message-ID: <3d45f4b1-83a3-4fb0-88cc-9cca5df26320@redhat.com>
Date: Tue, 25 Feb 2025 17:39:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: page_ext: add an iteration API for page
 extensions
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1740434344.git.luizcap@redhat.com>
 <08aea5d87f5419f4c7033c81d97645f940f87f7e.1740434344.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <08aea5d87f5419f4c7033c81d97645f940f87f7e.1740434344.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:59, Luiz Capitulino wrote:
> The page extension implementation assumes that all page extensions of
> a given page order are stored in the same memory section. The function
> page_ext_next() relies on this assumption by adding an offset to the
> current object to return the next adjacent page extension.
> 
> This behavior works as expected for flatmem but fails for sparsemem when
> using 1G pages. The commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for
> gigantic folios") exposes this issue, making it possible for a crash when
> using page_owner or page_table_check page extensions.
> 
> The problem is that for 1G pages, the page extensions may span memory
> section boundaries and be stored in different memory sections. This issue
> was not visible before commit cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP
> for gigantic folios") because alloc_contig_pages() never passed more than
> MAX_PAGE_ORDER to post_alloc_hook(). However, the series introducing
> mentioned commit changed this behavior allowing the full 1G page order
> to be passed.
> 
> Reproducer:
> 
>   1. Build the kernel with CONFIG_SPARSEMEM=y and table extensions
>      support
>   2. Pass 'default_hugepagesz=1 page_owner=on' in the kernel command-line
>   3. Reserve one 1G page at run-time, this should crash (backtrace below)
> 
> To address this issue, this commit introduces a new API for iterating
> through page extensions. The main iteration macro is for_each_page_ext()
> and it must be called with the RCU read lock taken. Here's an usage
> example:
> 
> """
> struct page_ext_iter iter;
> struct page_ext *page_ext;
> 
> ...
> 
> rcu_read_lock();
> for_each_page_ext(page, 1 << order, page_ext, iter) {
> 	struct my_page_ext *obj = get_my_page_ext_obj(page_ext);
> 	...
> }
> rcu_read_unlock();
> """
> 
> The loop construct uses page_ext_iter_next() which checks to see if we
> have crossed sections in the iteration. In this case, page_ext_iter_next()
> retrieves the next page_ext object from another section.
> 
> Thanks to David Hildenbrand for helping identify the root cause and
> providing suggestions on how to fix and optmize the solution (final
> implementation and bugs are all mine through).
> 
> Lastly, here's the backtrace, without kasan you can get random crashes:
> 
> [   76.052526] BUG: KASAN: slab-out-of-bounds in __update_page_owner_handle+0x238/0x298
> [   76.060283] Write of size 4 at addr ffff07ff96240038 by task tee/3598
> [   76.066714]
> [   76.068203] CPU: 88 UID: 0 PID: 3598 Comm: tee Kdump: loaded Not tainted 6.13.0-rep1 #3
> [   76.076202] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.0007/Mt.Jade Motherboard, BIOS 2.10.20220810 (SCP: 2.10.20220810) 2022/08/10
> [   76.088972] Call trace:
> [   76.091411]  show_stack+0x20/0x38 (C)
> [   76.095073]  dump_stack_lvl+0x80/0xf8
> [   76.098733]  print_address_description.constprop.0+0x88/0x398
> [   76.104476]  print_report+0xa8/0x278
> [   76.108041]  kasan_report+0xa8/0xf8
> [   76.111520]  __asan_report_store4_noabort+0x20/0x30
> [   76.116391]  __update_page_owner_handle+0x238/0x298
> [   76.121259]  __set_page_owner+0xdc/0x140
> [   76.125173]  post_alloc_hook+0x190/0x1d8
> [   76.129090]  alloc_contig_range_noprof+0x54c/0x890
> [   76.133874]  alloc_contig_pages_noprof+0x35c/0x4a8
> [   76.138656]  alloc_gigantic_folio.isra.0+0x2c0/0x368
> [   76.143616]  only_alloc_fresh_hugetlb_folio.isra.0+0x24/0x150
> [   76.149353]  alloc_pool_huge_folio+0x11c/0x1f8
> [   76.153787]  set_max_huge_pages+0x364/0xca8
> [   76.157961]  __nr_hugepages_store_common+0xb0/0x1a0
> [   76.162829]  nr_hugepages_store+0x108/0x118
> [   76.167003]  kobj_attr_store+0x3c/0x70
> [   76.170745]  sysfs_kf_write+0xfc/0x188
> [   76.174492]  kernfs_fop_write_iter+0x274/0x3e0
> [   76.178927]  vfs_write+0x64c/0x8e0
> [   76.182323]  ksys_write+0xf8/0x1f0
> [   76.185716]  __arm64_sys_write+0x74/0xb0
> [   76.189630]  invoke_syscall.constprop.0+0xd8/0x1e0
> [   76.194412]  do_el0_svc+0x164/0x1e0
> [   76.197891]  el0_svc+0x40/0xe0
> [   76.200939]  el0t_64_sync_handler+0x144/0x168
> [   76.205287]  el0t_64_sync+0x1ac/0x1b0
> 
> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


