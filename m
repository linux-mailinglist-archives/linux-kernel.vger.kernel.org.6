Return-Path: <linux-kernel+bounces-191876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6188D1571
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF01F219A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811173470;
	Tue, 28 May 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUWuTtid"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D773447
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882227; cv=none; b=GC0s7kyQI5nRuKnvX3ML7sw55AdS2Pf8v+9WhUjZmdL/ISyaegIRUG87L/wZwfz/OWfSLs9frk8Zwf0bwu7rs/I9hFzR7Dw8/wurVMLe4HcXh3clR8GuZTH2g4kCYllcm9FFlOByj+NOI6qPz5aiZhy5zkt5iZoGXLO1wOrBB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882227; c=relaxed/simple;
	bh=Ze0C8ZZPqtt/t1xyZayQh6LuGP+VHLULOICCJ7Dbowo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvvCBG0n5EDN5Iv8ndc/itPuhyBiCoOmOVCW2F1R+of7C80G9AYEH4xzkQuCTQbycYZg1FoGKNvEfY4I01J4ZQfCo1G/VmtOVdw3/aRr71wwSilC+55TpCP1kEzk+bXJoZZsGkMIaSoGS5Qd8rFzVdJejknUW05bvFQ/MCqIO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUWuTtid; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716882225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlYH/skdvPZBpSXPZaME8NdBvlZ6QuaFWdBuSnU2HNg=;
	b=LUWuTtidjzECG0TH6XDXITbCBPJBgJoBi+0EedmfbPavTNd+tsPgpQuMdk5u48uCQqd7Nx
	I03p8EDss+5DQ9ZdwRQyFxoDhuvULopE6VWsPTOwSKtGLfDCOOBLRoKFgRIPNuEV/tVckC
	BxVHKI9yBhgMJrjXhDCGrZP9Z4enkgk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-T8OYAUTRN7eNl4WvldoE4Q-1; Tue, 28 May 2024 03:43:43 -0400
X-MC-Unique: T8OYAUTRN7eNl4WvldoE4Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6269ad7288so24750266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716882222; x=1717487022;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlYH/skdvPZBpSXPZaME8NdBvlZ6QuaFWdBuSnU2HNg=;
        b=pyJD6naHZXIRFBH7aDqSTDVV92OigI2xFoPh5ThIZlrwRZBzInQW+uiIH/fgFS8SOr
         C9QXo+rSF/e9AVvJe9pzn+jW8NK7aP+lRhokthVFVdbt07HczviKu2YCgOOa/Vlqy0W9
         X3akpWzofzmPrGiArpCAgUuwWRSqTeq9uoen8A+7K3NAIXTNq4cwd33i+6yR6DNnr2+y
         onRBxJILoffsF4H2iIfgPOcy/N6X33HP1Kc4Y7VGH4RKqJ9UHRqydEmp8HhUXIp3hWwG
         0pIsKoZnKBpOjbeCJ5ICO6i5OAalyEcW2xtSMT1GdnU4hJRffnyYUSwq0fS9gnoyJdaj
         SExQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQH1V4nJp6w8nI4tcrDzYW6dMqu6js5r5AK7cfeWIil9UmeFcjUJr++/OMLoq9chEfoGIZzMADi2I0A7+YXc4kSOG7RRS3aw4/WLfx
X-Gm-Message-State: AOJu0YyaAoiXS3rpPbrnbwR8xHeMF0cvhzLk0sOilRzwmYvmdFKaKShb
	qCRNOagARgStHYbaobpHjGcVJBCTZXhQpsomGOk9vp4ZH/YEkSpoFXpO6t54Me3iAaFS/zgK2+j
	/wopU1kj4c4OsuFbUiQ90kCnnk9aDJwg45C32t/xhkArKMd2nqtiP9cjG0oczeA==
X-Received: by 2002:a17:906:408a:b0:a62:bc74:a883 with SMTP id a640c23a62f3a-a62bc74a9aemr473698566b.21.1716882222086;
        Tue, 28 May 2024 00:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/TBxPqJ+AxHlEy/X81c9ePzyGnghsIq5S1S5T3yXRoQDlv2KLbRtG+H9BBjIc4/qTw2EHQ==
X-Received: by 2002:a17:906:408a:b0:a62:bc74:a883 with SMTP id a640c23a62f3a-a62bc74a9aemr473697366b.21.1716882221615;
        Tue, 28 May 2024 00:43:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm582682866b.62.2024.05.28.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 00:43:41 -0700 (PDT)
Message-ID: <8aba80ed-7b3e-4c8c-99e8-d8a2e0b112fc@redhat.com>
Date: Tue, 28 May 2024 09:43:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] d99e3140a4:
 BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report
To: kernel test robot <oliver.sang@intel.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <202405281431.c46a3be9-lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <202405281431.c46a3be9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.05.24 um 09:11 schrieb kernel test robot:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report" on:
> 
> commit: d99e3140a4d33e26066183ff727d8f02f56bec64 ("mm: turn folio_test_hugetlb into a PageType")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      c760b3725e52403dc1b28644fb09c47a83cacea6]
> [test failed on linux-next/master 3689b0ef08b70e4e03b82ebd37730a03a672853a]
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5
> 
> 
> 
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we noticed this issue does not always happen. we also noticed there are
> different random KCSAN issues for both this commit and its parent. but below
> 4 only happen on this commit with not small rate and keep clean on parent.
> 

Likely that's just a page_type check racing against concurrent
mapcount changes.

In __folio_rmap_sanity_checks() we check
	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);

To make sure we don't get hugetlb folios in the wrong rmap code path. That
can easily race with concurrent mapcount changes, just like any other
page_type checks that end up in folio_test_type/page_has_type e.g., from
PFN walkers.

Load tearing in these functions shouldn't really result in false positives
(what we care about), but READ_ONCE shouldn't hurt or make a difference.


 From b03dc9bf27571442d886d8da624a4e4f737433f2 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 28 May 2024 09:37:20 +0200
Subject: [PATCH] mm: read page_type using READ_ONCE

KCSAN complains about possible data races: while we check for a
page_type -- for example for sanity checks -- we might concurrently
modify the mapcount that overlays page_type.

Let's use READ_ONCE to avoid laod tearing (shouldn't make a difference)
and to make KCSAN happy.

Note: nothing should really be broken besides wrong KCSAN complaints.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202405281431.c46a3be9-lkp@intel.com
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/page-flags.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b1..e46ccbb9aa58 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -955,9 +955,9 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
  #define PG_slab		0x00001000
  
  #define PageType(page, flag)						\
-	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+	((READ_ONCE(page->page_type) & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
  #define folio_test_type(folio, flag)					\
-	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+	((READ_ONCE(folio->page.page_type) & (PAGE_TYPE_BASE | flag))  == PAGE_TYPE_BASE)
  
  static inline int page_type_has_type(unsigned int page_type)
  {
@@ -966,7 +966,7 @@ static inline int page_type_has_type(unsigned int page_type)
  
  static inline int page_has_type(const struct page *page)
  {
-	return page_type_has_type(page->page_type);
+	return page_type_has_type(READ_ONCE(page->page_type));
  }
  
  #define FOLIO_TYPE_OPS(lname, fname)					\
-- 
2.45.1


-- 
Thanks,

David / dhildenb


