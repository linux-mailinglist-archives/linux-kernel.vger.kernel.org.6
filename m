Return-Path: <linux-kernel+bounces-242991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDD3928FF2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1425D281236
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C06FC2;
	Sat,  6 Jul 2024 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk8p0qNW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FE53A9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720229290; cv=none; b=XSwJQDOmmmifnFsZxGoLsr612qlwZEziA8wmLE5QzaUd2Z+02+IwqP6Y5F3vxTqv+pgSPeadXQgM1kkdHssMr83Nb4HX5LDHY3UYin9u7WFvJDOAuzfpNyD+eV7DEIymNEyJ5T6oK3vSSpUO4jPIKoSiNorDT4xl4oyPU5W/HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720229290; c=relaxed/simple;
	bh=ZSXGwzTpr6iZoY3k7f8rEQagtZtDgjwYnn46OJ6AqX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeIXE1tXFKFh4nw9gndQrNDFzcz+YvyoHzF8wN2TTov/sCbUrjOzP5+lK63VnLAgIornrSJXfspAISuFby4MbF27Ix2I+OUXgwqva6ip3cKifu2dHlsEovdgaJMh8Jpg3ZLAaDf699vz8syUGD7R1Z0FkSYf/OnWEFL/GiZGvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk8p0qNW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a728f74c23dso255589866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720229287; x=1720834087; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dezBeZYBfU1/Z8rbV7e63ypFbBRAlUgUO3szpvjxTnk=;
        b=Jk8p0qNWT3psy6qVcls+rua4Kb8zpNBNT5SkRACZ6of7XecIr6w+UoXqSTT7gAlqea
         SXSWaEJr9RYMd8V1tDXxwIlZb4bszZtEeBjO9i9WwMzOI5QM3FuclmHTIBisGO+Qs1Vr
         QlQ5Nk14Ztby610eX07u4oz2oxnHpY/+ldzrQO5H8wiszoWJvDmVeNxtJysEFwHx4Zox
         goNBzH9rXJWvq326Oi5TZAiUcFAOSBU3eyRY/Bom120tCn8YhdvyR4npJYOkn6TrtfsV
         YUC/zYANxtLH3D5si00+tEB1Jl8vThNtNwvfQkqjFVJX9eX0uyT8XtVs3dQQ9NhWSIVc
         F92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720229287; x=1720834087;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dezBeZYBfU1/Z8rbV7e63ypFbBRAlUgUO3szpvjxTnk=;
        b=GgEQk3XbzFkY3EpJYJtwcsJ9dcz89vrAEMZCNwOtYMmMl2FgoeLR3BfiT7kaW1qyzU
         hfYDYZn96xXRC8BmVzeekgywM0oNBBsZlSTCWlFrXjffBo90iGbUdpOFGi9RcdxrBgP9
         mbggj+uNk95hgzAWZusnSyFPOdSBuWcMyQuz+Z2G9tai0Zvw5kOjw5ujjnBwGU7brMMp
         lrE++Vi5WgTe6kOp/fRI1w/d1E+jP5Ghcq1ZtHRt/B2uF/0CEauDZd3D7xdEQVGTW6+b
         Z1/aMKtJ0bV0Kwkq3oyeRcGBpgnysDcs/OSXO1j4M2tP3J0Vvpv52XX+ruyHw7HvFtf6
         BPnw==
X-Forwarded-Encrypted: i=1; AJvYcCXM1avRuJTlPb8Lz+aeETJpJtpIQ6ykt5wU/JyvqieY17+dCJsIRhjqH8P/kiNOgetn+C+fsRUAembYdM14PFaVJbCHuwT0jOjEXY4i
X-Gm-Message-State: AOJu0YwDVB3tOmB+Mp/1OOBuT9SWln2LbPxp/fhlP4fBN1xaglGUWpuY
	RRwTgWDJvx6Cd/8/0e9+pKra0Vq4kAfUf4sD0I3+vvUAaeOK6LNV
X-Google-Smtp-Source: AGHT+IGJL2ZXApYLOQQK50g7hYRvGqRO6fAVuvhBD7w9sgnqw2wDu83cJkm1L62jaCQwTV7JQxMZqw==
X-Received: by 2002:a17:907:97c8:b0:a72:6b08:ab1a with SMTP id a640c23a62f3a-a77ba711897mr498694466b.46.1720229286635;
        Fri, 05 Jul 2024 18:28:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065651sm720670366b.126.2024.07.05.18.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2024 18:28:05 -0700 (PDT)
Date: Sat, 6 Jul 2024 01:28:05 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	brauner@kernel.org, oleg@redhat.com, mjguzik@gmail.com,
	tandersen@netflix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
Message-ID: <20240706012805.uuvysz2qgapgqj6p@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoe4XN-gKJnjJtzi@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jul 05, 2024 at 12:09:48PM +0300, Mike Rapoport wrote:
>On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
>> Instead of using raw memblock api, we wrap a new helper for user.
>
>The changelog should be more elaborate and explain why this function is
>needed.
> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  include/linux/memblock.h |  1 +
>>  mm/memblock.c            | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>> 
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 40c62aca36ec..7d1c32b3dc12 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>  
>>  phys_addr_t memblock_phys_mem_size(void);
>>  phys_addr_t memblock_reserved_size(void);
>> +unsigned long memblock_estimated_nr_pages(void);
>>  phys_addr_t memblock_start_of_DRAM(void);
>>  phys_addr_t memblock_end_of_DRAM(void);
>>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e81fb68f7f88..c1f1aac0459f 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>>  	return memblock.reserved.total_size;
>>  }
>>  
>> +/**
>> + * memblock_estimated_nr_pages - return number of pages from memblock point of
>> + * view
>
>This function returns the estimate for free pages, not the number of pages
>in RAM.
>
>How about memblock_estimated_nr_free_pages()?
>
>> + * some calculation before all pages are freed to buddy system, especially
>> + * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>
>I'm failing to parse this sentence. The return value here won't depend on
>CONFIG_DEFERRED_STRUCT_PAGE_INIT.
>
>> + *
>> + * At this point, we can get this information from memblock. Since the system
>> + * state is not settle down and address alignment, the value is an estimation.
>> + *
>> + * Return:
>> + * An estimated number of pages from memblock point of view.
>
>                            ^ free
>
>> + */
>> +unsigned long __init memblock_estimated_nr_pages(void)
>> +{
>> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>> +}
>> +
>>  /* lowest address */
>>  phys_addr_t __init_memblock memblock_start_of_DRAM(void)
>>  {
>> -- 
>> 2.34.1
>> 

Thanks for review. Is this one looks better?

Subject: [PATCH] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()

During bootup, system may need the number of free pages in the whole system
to do some calculation before all pages are freed to buddy system. Usually
this number is get from totalram_pages(). Since we plan to move the free
pages accounting in __free_pages_core(), this value may not represent
total free pages at the early stage, especially when
CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

Instead of using raw memblock api, let's introduce a new helper for user
to get the estimated number of free pages from memblock point of view.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: David Hildenbrand <david@redhat.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40c62aca36ec..7d1c32b3dc12 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+unsigned long memblock_estimated_nr_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index e81fb68f7f88..00decc42e02b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1729,6 +1729,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+/**
+ * memblock_estimated_nr_free_pages - return estimated number of free pages
+ * from memblock point of view
+ *
+ * During bootup, system may need the number of free pages in the whole system
+ * to do some calculation before all pages are freed to buddy system. Usually
+ * this number is get from totalram_pages(). Since we plan to move the free
+ * pages accounting in __free_pages_core(), this value may not represent total
+ * free pages at the early stage, especially when
+ * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
+ *
+ * While we can get the estimated number of free pages from memblock, which is
+ * good enough for the calculation.
+ *
+ * Return:
+ * An estimated number of free pages from memblock point of view.
+ */
+unsigned long __init memblock_estimated_nr_free_pages(void)
+{
+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+}
+
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.34.1


-- 
Wei Yang
Help you, Help me

