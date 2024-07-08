Return-Path: <linux-kernel+bounces-243767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16396929A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F6FB20D60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12834A29;
	Mon,  8 Jul 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evV4AvbY"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7236D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720399024; cv=none; b=WZcZJr+1CxWBvlOujQpOdfDWREHe82bVxMVM0h1BKan0RgajZfzPKvUu3Jm6SrAn5BuLRqPTcirTmPNs2Iep0/xYoWtFGddIcS3OBsyNwTCNrqQIJMtFGsYX8Yn1+xP9DSkgSkCMrIkVfbT1HJ9YDZhDqUjubQjLEL3ji6zDbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720399024; c=relaxed/simple;
	bh=fDwuiOF5SskQ21aQul+QOFafliGQvPvTIZY+hAzQWcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN+eKIEAypvbjcai0hokQdT0aUVvQSWPEjCtgyeqzmGOpNjZF7tj8OFjboEeTWgXWNcZ5AQvU4Wm/P653sWxGHqbAnDtVh3RdLbdBeBGUrgEg3BWv2e1QNKmm5+HVj3g+vF13E3aKf3EjZAsi1kc6z79n9mKjabxiRuNNRbZLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evV4AvbY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee8911b451so41696501fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720399020; x=1721003820; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0maobCSW8jMDbFz8GUq2aphge1nCAKz/nFEddtGsYBM=;
        b=evV4AvbYdfYc9Po2U/udNEylEsyLwJfqcH9Okbro5SRly3rXNvuhCx6pVJOMFOwIU1
         FCyCncTgt8fXA2NIV2PnBYbgrdy/rJsi47FKFmdtDeS8rJOx6jat+Lobf1PvFW5MOoPi
         FU3PnKUgRlBtddLO6hfntySUqULxY4y3P4CMuUUVj7jW2FrnduK3FcNeQHGOrriumdRE
         dqmmkb2Z1vX1+NhSvq/oTBz6bWdPt0yQZ0/NH4rlRjcxPQpbYb8dMEGDi/OG6hEv8nBU
         FpZyJ9kV96Cxf2dKMcPCjex/0fn64xssjjMngyDJUiWr0gzzw442BRNtkOu89Uy76epK
         oaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720399020; x=1721003820;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0maobCSW8jMDbFz8GUq2aphge1nCAKz/nFEddtGsYBM=;
        b=kL6bI+ZX0m5p6Tq4B04uHs4BA4iTAXmDh7YzWyn/O/8BZF+00w0K+NCdtiyP6mUGL5
         yAQXDZbCDVS0sEkozQOMUTp4kyQgddiRv3JABMBSsB2VhstORqR7gnsg8ARcKIZf5LIM
         Et5nHJrJNroPdspLtg0kf9zdn8Fen/x28dHUehOhAKC7eYw6h5pMHmIyaV2kenrV0Prw
         O9Vpx5d6NK9WLPebAwNTLF7og5NtUCsLU8csCz9dCq/6JvJkoYmWD6IeYgzvIM7Ys2Qt
         tHyqpyRRD3OnyIT7aPPTb1Cajql9oKf1MXFnl+DXSUikYEq7GxnlAnD0/CZXd/gAWRB/
         ++cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NNzbiQacEMn2gyY1m3yx/A5L3grLrB+55IZ/V2X0cySZ/q5vTKgA9N4wNFSg+tWsK56Lhrger2biyl7+GCpQjVdKAdnWP+oGUzYp
X-Gm-Message-State: AOJu0YwsQcSLacQTrE6+00OcWJNLY2KgvryEv2WOVlgm6mFnoWKwYzuW
	PAxAvFxeUz2fh1nnX4zsx097pb3qsnQ6xRzFSxyLGzAVACVt/pSu
X-Google-Smtp-Source: AGHT+IGvfoRCtahGcXgfBB0qSDli+0q4c6M0sTsmdYOaNTpy2n+v6qWfPqsOXrVP8DOoWe8kJoFCxw==
X-Received: by 2002:a05:651c:2da:b0:2ec:40cf:fa9 with SMTP id 38308e7fff4ca-2ee8eda03bamr69533711fa.29.1720399020036;
        Sun, 07 Jul 2024 17:37:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58fbfccf0f9sm3245044a12.75.2024.07.07.17.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2024 17:36:59 -0700 (PDT)
Date: Mon, 8 Jul 2024 00:36:58 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, mjguzik@gmail.com, tandersen@netflix.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
Message-ID: <20240708003658.fivcxqgwqhst4mip@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org>
 <20240706012805.uuvysz2qgapgqj6p@master>
 <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
 <20240707190304.GC11914@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707190304.GC11914@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Jul 07, 2024 at 09:03:05PM +0200, Oleg Nesterov wrote:
>As I have already said, I can't review this patch.
>
>But I am curious, why set_max_threads() is the only user of the new helper?
>Say, should files_maxfiles_init() use it too or not? Perhaps the changelog
>can explain this?
>

files_maxfiles_init() is called in two places:

  * vfs_caches_init()
  * page_alloc_init_late()

And in page_alloc_init_late(), it is called after deferred_init_memmap(). This
means the totalram_pages() here return the real free pages at this point. So
it is not necessary to touch it now.

>Thanks,
>
>Oleg.
>
>On 07/07, David Hildenbrand wrote:
>>
>> On 06.07.24 03:28, Wei Yang wrote:
>> >On Fri, Jul 05, 2024 at 12:09:48PM +0300, Mike Rapoport wrote:
>> >>On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
>> >>>Instead of using raw memblock api, we wrap a new helper for user.
>> >>
>> >>The changelog should be more elaborate and explain why this function is
>> >>needed.
>> >>
>> >>>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >>>---
>> >>>  include/linux/memblock.h |  1 +
>> >>>  mm/memblock.c            | 19 +++++++++++++++++++
>> >>>  2 files changed, 20 insertions(+)
>> >>>
>> >>>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >>>index 40c62aca36ec..7d1c32b3dc12 100644
>> >>>--- a/include/linux/memblock.h
>> >>>+++ b/include/linux/memblock.h
>> >>>@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>> >>>  phys_addr_t memblock_phys_mem_size(void);
>> >>>  phys_addr_t memblock_reserved_size(void);
>> >>>+unsigned long memblock_estimated_nr_pages(void);
>> >>>  phys_addr_t memblock_start_of_DRAM(void);
>> >>>  phys_addr_t memblock_end_of_DRAM(void);
>> >>>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> >>>diff --git a/mm/memblock.c b/mm/memblock.c
>> >>>index e81fb68f7f88..c1f1aac0459f 100644
>> >>>--- a/mm/memblock.c
>> >>>+++ b/mm/memblock.c
>> >>>@@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>> >>>  	return memblock.reserved.total_size;
>> >>>  }
>> >>>+/**
>> >>>+ * memblock_estimated_nr_pages - return number of pages from memblock point of
>> >>>+ * view
>> >>
>> >>This function returns the estimate for free pages, not the number of pages
>> >>in RAM.
>> >>
>> >>How about memblock_estimated_nr_free_pages()?
>> >>
>> >>>+ * some calculation before all pages are freed to buddy system, especially
>> >>>+ * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> >>
>> >>I'm failing to parse this sentence. The return value here won't depend on
>> >>CONFIG_DEFERRED_STRUCT_PAGE_INIT.
>> >>
>> >>>+ *
>> >>>+ * At this point, we can get this information from memblock. Since the system
>> >>>+ * state is not settle down and address alignment, the value is an estimation.
>> >>>+ *
>> >>>+ * Return:
>> >>>+ * An estimated number of pages from memblock point of view.
>> >>
>> >>                            ^ free
>> >>
>> >>>+ */
>> >>>+unsigned long __init memblock_estimated_nr_pages(void)
>> >>>+{
>> >>>+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>> >>>+}
>> >>>+
>> >>>  /* lowest address */
>> >>>  phys_addr_t __init_memblock memblock_start_of_DRAM(void)
>> >>>  {
>> >>>-- 
>> >>>2.34.1
>> >>>
>> >
>> >Thanks for review. Is this one looks better?
>> >
>> >Subject: [PATCH] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
>> >
>> >During bootup, system may need the number of free pages in the whole system
>> >to do some calculation before all pages are freed to buddy system. Usually
>> >this number is get from totalram_pages(). Since we plan to move the free
>> >pages accounting in __free_pages_core(), this value may not represent
>> >total free pages at the early stage, especially when
>> >CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> >
>> >Instead of using raw memblock api, let's introduce a new helper for user
>> >to get the estimated number of free pages from memblock point of view.
>> >
>> >Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >CC: David Hildenbrand <david@redhat.com>
>> >---
>> >  include/linux/memblock.h |  1 +
>> >  mm/memblock.c            | 22 ++++++++++++++++++++++
>> >  2 files changed, 23 insertions(+)
>> >
>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >index 40c62aca36ec..7d1c32b3dc12 100644
>> >--- a/include/linux/memblock.h
>> >+++ b/include/linux/memblock.h
>> >@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>> >  phys_addr_t memblock_phys_mem_size(void);
>> >  phys_addr_t memblock_reserved_size(void);
>> >+unsigned long memblock_estimated_nr_pages(void);
>> >  phys_addr_t memblock_start_of_DRAM(void);
>> >  phys_addr_t memblock_end_of_DRAM(void);
>> >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> >diff --git a/mm/memblock.c b/mm/memblock.c
>> >index e81fb68f7f88..00decc42e02b 100644
>> >--- a/mm/memblock.c
>> >+++ b/mm/memblock.c
>> >@@ -1729,6 +1729,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>> >  	return memblock.reserved.total_size;
>> >  }
>> >+/**
>> >+ * memblock_estimated_nr_free_pages - return estimated number of free pages
>> >+ * from memblock point of view
>> >+ *
>> >+ * During bootup, system may need the number of free pages in the whole system
>> >+ * to do some calculation before all pages are freed to buddy system. Usually
>> >+ * this number is get from totalram_pages(). Since we plan to move the free
>> >+ * pages accounting in __free_pages_core(), this value may not represent total
>> >+ * free pages at the early stage, especially when > + * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> 
>> These historical details should be dropped. "Since we plan ..." will easily
>> get outdated soon.
>> 
>> * During bootup, subsystems might need a rough estimate of the number of *
>> free pages in the whole system, before precise numbers are available
>> * from the buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the
>> * numbers obtained from the buddy might be very imprecise during bootup.
>> 
>> ?
>> 
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> 
>> -- 
>> Cheers,
>> 
>> David / dhildenb
>> 

-- 
Wei Yang
Help you, Help me

