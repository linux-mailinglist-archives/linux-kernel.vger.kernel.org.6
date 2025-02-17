Return-Path: <linux-kernel+bounces-517288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8EA37EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553FC16BB4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F154215F5E;
	Mon, 17 Feb 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXxYqG36"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C242153C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785474; cv=none; b=GUP3eRwWT3TKMKM4mQuRdHc6NvBlQHFtpXFgoKI5vTBkzNHaBv5XK3JcMxtNvj9t/qXrXC05Nh/UdnZd0U7M+ElqdLLPsH5v+b1KklKfIkkMR6enMK8cbyAT14Ho+HvfFV/0PxvYJu3g1OE80nbWUfWlq5fXoqkbPb5hzZNNWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785474; c=relaxed/simple;
	bh=J1yePCgXsp5KdF/XMhCFbyJxvq8CaN+RODwGPnRjKak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8BcfsFZNCrufLBxAl+TCm6IsBVUSuAG0w0nVDYff5qir3JR/RIXlptsDpAStHbwj/EmPNxrkVj85lqBMTKKrAuiKpnRMGYKm+e/KHLWDUQf+Z3nWRqdd5SyfWKL2aL1nwpNqPDVOUhRoqD5nS+iIfvj1eUuV2STFUW55eIEsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXxYqG36; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739785471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqDAUvAEeGP+kauicMXsQJdKxUNLdnbFg64inWAI/Iw=;
	b=AXxYqG36q1aCMIyv8jJzL9ioR7J9vyX9AABv0ztE4NYQD4P9VWbjE0u3VrB5psRYtgXnyG
	TTDYIzHwhECJgl4oB96jJxw2Gdo540RnkaDXMdNGxjGk+l9QsaE1SKggPX5TY6nvvlWVcT
	xACLJQCkbp2LJOM2O7PTiVuC/nuA66o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-69M3RX2mMJylp_7nuN-IYw-1; Mon, 17 Feb 2025 04:44:28 -0500
X-MC-Unique: 69M3RX2mMJylp_7nuN-IYw-1
X-Mimecast-MFC-AGG-ID: 69M3RX2mMJylp_7nuN-IYw_1739785468
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso592602f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739785467; x=1740390267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zqDAUvAEeGP+kauicMXsQJdKxUNLdnbFg64inWAI/Iw=;
        b=KyyzNlTBUUBr2qd3zv5Wg5Y3qJ5JUzAcCkrDXQqrDVORyyCqd/ogd1w1T3ftmScta/
         cF/66kMeegQHhY3cUh2zY4qYZ1AgozwdcqhEouoyzsBKsh0WLa+i/bHRGj+idhRAtQEM
         lI9Rw3XdbmxZWbJiCA8HP6E2V5e3AoQmVivoxAkmIPV46+lxc4gvgr7ye7/KybDUP/ZF
         5YG4eQdRBdA8il1hLf9nQSJ1VMNC2lin+VvAakoAPb6JLdLaUW0KZvv0i4sU7PGLevc+
         tiiFAJOV8ASMYp2t4l477SLSkZIj/VXMpO/+vb4eFYm2oXrVKLrGGL6T/YGkkOM9cRUy
         pT9A==
X-Forwarded-Encrypted: i=1; AJvYcCV4koV7oKoO2fagyaG6rioPUrJXHWcMjDCqSsVL9mWPyL7Fb9otdrkp8ms1RRTS+83u6iCuqd47nB6Z6j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcivDgNN7Y/JoSBBvjzVqNHGA22l5Z1DvzP+U3PN1PonE5e/k9
	00iuHEgE+Z9f+rTbChz26rRv+LDlZWiFKbHf8rc+6VgZWq7TN9vfxXMPe/pMMAYuy71P/4v5leM
	QiY708AubB3XN2bp59vBZ3cm+Jhcu8019jwahTCSj9mWaxLDAMA496QLzdbp35g==
X-Gm-Gg: ASbGnculVb0+pYIQ35QBqsFLKNBd+fCSBEKcE4nSH1bDDgjuqWt0Y9sLTtvY04riIcf
	SDFDPLG8UYz7I1JWg8bR2/+9g1Tzuv9rmj5BB0OQTRAD/rt3797wYBPlwnVuJkvgdjmKwWMs2gJ
	mEFVq3xBKro0LS5IzK7PvgJGM95TQY9ZIJT/cJlO5um4ibcASixsouIxEMSJZCNKCuLdqf6RxXc
	tSOy4wEBIpk257u/5Hbsakt6/4sJ59Z2nObFBAXYJupwE6Y151e6l45SqYlCDVyCoySw0uwgLz7
	5GQAY8ZP2w2Vf4vXnN2OUOde6DQ27i32Qs5Pq/K4OPeyvS56pE9q43d0xP/vW6BVoPWvXuBRKc4
	y4eO1XZ68Rue69k6G1uy2xN1eeNWRhA==
X-Received: by 2002:a05:6000:1acb:b0:38d:b051:5a0e with SMTP id ffacd0b85a97d-38f33f5403emr9005236f8f.49.1739785467541;
        Mon, 17 Feb 2025 01:44:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNgLkKR19H26t5bIeaj/kdxdOHxKJk3k2pdc8bDKMxYHqeL2D6C5+H/jLNeUyyltbMVaZIzw==
X-Received: by 2002:a05:6000:1acb:b0:38d:b051:5a0e with SMTP id ffacd0b85a97d-38f33f5403emr9005196f8f.49.1739785467127;
        Mon, 17 Feb 2025 01:44:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm11538422f8f.41.2025.02.17.01.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:44:25 -0800 (PST)
Message-ID: <8c1578ed-cfef-4fba-a334-ebf5eac26d60@redhat.com>
Date: Mon, 17 Feb 2025 10:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 catalin.marinas@arm.com
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
References: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 10:29, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> The first problem is that if start or end is not aligned to a section
> boundary, such as when a subsection is hot added, populating the entire
> section is wasteful.
> 
> The Next problem is if we hotplug something that spans part of 128 MiB
> section (subsections, let's call it memblock1), and then hotplug something
> that spans another part of a 128 MiB section(subsections, let's call it
> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
> the entire PMD entry which also supports memblock2 even though memblock2
> is still active.
> 
> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
> fix similar to x86-64: populate to pages levels if start/end is not aligned
> with section boundary.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>   arch/arm64/mm/mmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b4df5bc5b1b8..eec1666da368 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1178,7 +1178,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   {
>   	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>   
> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
> +		(end - start < PAGES_PER_SECTION * sizeof(struct page)))
>   		return vmemmap_populate_basepages(start, end, node, altmap);
>   	else
>   		return vmemmap_populate_hugepages(start, end, node, altmap);

Yes, this does mimic what x86 does. That handling does look weird, because it
doesn't care about any address alignments, only about the size, which is odd.

I wonder if we could do better and move this handling
into vmemmap_populate_hugepages(), where we already have a fallback
to vmemmap_populate_basepages().

Something like:

One thing that confuses me is the "altmap" handling in x86-64 code: in particular
why it is ignored in some cases. So that might need a bit of thought / double-checking.


diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df3036..57542313c0000 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1546,10 +1546,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
         VM_BUG_ON(!PAGE_ALIGNED(start));
         VM_BUG_ON(!PAGE_ALIGNED(end));
  
-       if (end - start < PAGES_PER_SECTION * sizeof(struct page))
-               err = vmemmap_populate_basepages(start, end, node, NULL);
-       else if (boot_cpu_has(X86_FEATURE_PSE))
+       if (boot_cpu_has(X86_FEATURE_PSE))
                 err = vmemmap_populate_hugepages(start, end, node, altmap);
+       else
+               err = vmemmap_populate_basepages(start, end, node, NULL);
         else if (altmap) {
                 pr_err_once("%s: no cpu support for altmap allocations\n",
                                 __func__);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3287ebadd167d..8b217265b25b1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -300,6 +300,10 @@ int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
         return 0;
  }
  
+/*
+ * Try to populate PMDs, but fallback to populating base pages when ranges
+ * would only partially cover a PMD.
+ */
  int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
                                          int node, struct vmem_altmap *altmap)
  {
@@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
         for (addr = start; addr < end; addr = next) {
                 next = pmd_addr_end(addr, end);
  
+               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next, PMD_SIZE))
+                       goto fallback;
+
                 pgd = vmemmap_pgd_populate(addr, node);
                 if (!pgd)
                         return -ENOMEM;
@@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
                         }
                 } else if (vmemmap_check_pmd(pmd, node, addr, next))
                         continue;
+fallback:
                 if (vmemmap_populate_basepages(addr, next, node, altmap))
                         return -ENOMEM;
         }


-- 
Cheers,

David / dhildenb


