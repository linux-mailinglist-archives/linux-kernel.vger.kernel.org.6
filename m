Return-Path: <linux-kernel+bounces-519772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC59A3A1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C583B0630
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D526D5D7;
	Tue, 18 Feb 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHhF5iLw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7B10F4;
	Tue, 18 Feb 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893810; cv=none; b=KfjxWgw4fKGRDJc0Bi++y+/KWWM6Q4ERweZty75TOoJMSLJ6kPnsIPnHX8B716aBBy63lbX4g2D4MgTf9Ox5QITPmwnHuipa0NED2+TVkOT6Z3OulVZn7iPNbHDOAVJr65DXPEjhgqwged2PXvFZGaR3Hz9F7FmC/D5xHxvvgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893810; c=relaxed/simple;
	bh=xXXrFshznYsks4gPtpI00/N2HBn+xfheBhzE7onIGwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aInDxjqFMAXI2hoeecKh0RBJSe8dZb2lJty5Lz+O0tugmaXgueJWvnbtsG4v2TQDwwmyRrwXLPJxAAyaukQUvFLb8l+Y9ytEI7BhRCm/EYepX78T0z0+e7+1i5BiaezvJ1GyTi+sxYPHf5hk6lI+RVV05SgARWU/visqvjMKB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHhF5iLw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso939849166b.1;
        Tue, 18 Feb 2025 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739893805; x=1740498605; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mReLmHdUalr80UPhI614ZZFtZiFvIOnOjgDKsfY1PQg=;
        b=VHhF5iLwMBrpByPLOsALBcLLDEE+fg5Hulxf2GcKD0Rf8Gnyyh1B8ClhgeL5fw8571
         o3NYyYmEP7grozRifUASKr25VCLl8ZYU9sXg4hYq9xMQi/85VpO1SiyKJ+PcD3gd3a+K
         k/WLpNz++7Okib3s5Wf1rS9KnUfrOaU6ztcPrwlFSxNq2MjI8I7APDUOUQjfhhRlZaYS
         iuPEbfCKhRWwMh1rNwF/AnKazwri+mj+7jWs29YC9Z1T6GdPG0XegotqVlkftv71Cn35
         9S52Zylka33ebdNqw5QXr/8njHqC6dXfLkWxinhx3ibNeGpt25prlD6Tjk7YTO076Irf
         EkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893805; x=1740498605;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mReLmHdUalr80UPhI614ZZFtZiFvIOnOjgDKsfY1PQg=;
        b=hk4qvJkg2GTZGythibOL2UeGldR2CrSZM7YHqqHg+H/GIikq37YnliyUM7fA3U8qbr
         0Sg0VBZSpxIklmAX3T3cTQzLtTph0NIGq7uaJkZ+XwxMQmSLS0MqI7clLSBToFRjzbw7
         DB7ExMNd5UA+r5dDuH95GEDL72XNa1OH+ftFXvSYfhyrXaz1rLgfOmXFZPmatItUc2Yj
         Iev8f/1ZReGmaGJaOYC/Or0uIqZ4eZqtgy21Sx0+kTIZSaBXlPrO0KbVisKdQ/9NpS4r
         ljcfz+TwDd9izyDxpaqeX7szdY1aKF55lnjNcMHU7xQfnOxj/l4uarmtcEjfPTTHWNh8
         9uGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPSO2pK1GbzWfUvbSjC3+QJwM5tlSpbNS63gI4pwWqFV/K0iytpvlkEMoppmQZR9mj8oVdRSYQUX1m@vger.kernel.org, AJvYcCXTI6akBOtj4F5IBMkTm5CVdmFPUfBvtCxoYqyuDVyF64QHmunC8eZJWC2K8wEn4rr1HO8Opl2+9fFd@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg9WKNZ9e5g45lgyzbeGxLFyUA8TyKguiPYrtHAstRECB2XEU
	oUvMwTuT8aZZJLO5n2bNGWng9wF0BYZ+FHkZ7eyoXWv34RXT5Yw+jUdTElUJC4A=
X-Gm-Gg: ASbGncsbvxU0cwDZxt2qoUXa3TXTof8lISjdYL319o0ZRGoo3crVJ3ZBVVroAn4QiJ/
	AleoXcP2Uaj7ptlWRGNZ0Qu9UTPlOyfqwSt2pS0K5nP447KL3VJOuF8YwORFXNhyp8sJ5OFdVIh
	YJYsoAdqKTbfxszfz0qHtxujzlaNemwqldg8rMQLcOVer7LU/wzM19706xJdh4JWXcoZKhMR6Wg
	JkXYfsX8e4JJI6AxheZniAPgWlUSbZJDJMLrLqAsPRkncvah3I5gyIR3uqqqegSP0kGm5mKZFCr
	myOdSSppNBGl1Y4=
X-Google-Smtp-Source: AGHT+IHtAyydbfoXbx9zeo04VNjwSnQ27Knmz0ItYzncGEjZUASU18pITXXeMFFJlPuU/Bj7x5gW4g==
X-Received: by 2002:a17:907:3d8e:b0:ab7:462f:647f with SMTP id a640c23a62f3a-abb70b35f1amr1476203766b.25.1739893805155;
        Tue, 18 Feb 2025 07:50:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba002f790sm351966766b.164.2025.02.18.07.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2025 07:50:04 -0800 (PST)
Date: Tue, 18 Feb 2025 15:50:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <20250218155004.n53fcuj2lrl5rxll@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-3-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>to denote areas that were reserved for kernel use either directly with
>memblock_reserve_kern() or via memblock allocations.
>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>---
> include/linux/memblock.h | 16 +++++++++++++++-
> mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> 2 files changed, 39 insertions(+), 9 deletions(-)
>
>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>index e79eb6ac516f..65e274550f5d 100644
>--- a/include/linux/memblock.h
>+++ b/include/linux/memblock.h
>@@ -50,6 +50,7 @@ enum memblock_flags {
> 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */

Above memblock_flags, there are comments on explaining those flags.

Seems we miss it for MEMBLOCK_RSRV_KERN.

> };
> 
> /**
>@@ -116,7 +117,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
> int memblock_add(phys_addr_t base, phys_addr_t size);
> int memblock_remove(phys_addr_t base, phys_addr_t size);
> int memblock_phys_free(phys_addr_t base, phys_addr_t size);
>-int memblock_reserve(phys_addr_t base, phys_addr_t size);
>+int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
>+		       enum memblock_flags flags);
>+
>+static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
>+{
>+	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);
                                                            ^ MEMBLOCK_NONE ?

>+}
>+
>+static __always_inline int memblock_reserve_kern(phys_addr_t base, phys_addr_t size)
>+{
>+	return __memblock_reserve(base, size, NUMA_NO_NODE, MEMBLOCK_RSRV_KERN);
>+}
>+
> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
> #endif
>@@ -477,6 +490,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
> 
> phys_addr_t memblock_phys_mem_size(void);
> phys_addr_t memblock_reserved_size(void);
>+phys_addr_t memblock_reserved_kern_size(int nid);
> unsigned long memblock_estimated_nr_free_pages(void);
> phys_addr_t memblock_start_of_DRAM(void);
> phys_addr_t memblock_end_of_DRAM(void);
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 95af35fd1389..4c33baf4d97c 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -491,7 +491,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
> 	 * needn't do it
> 	 */
> 	if (!use_slab)
>-		BUG_ON(memblock_reserve(addr, new_alloc_size));
>+		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
> 
> 	/* Update slab flag */
> 	*in_slab = use_slab;
>@@ -641,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
> #ifdef CONFIG_NUMA
> 			WARN_ON(nid != memblock_get_region_node(rgn));
> #endif
>-			WARN_ON(flags != rgn->flags);
>+			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
> 			nr_new++;
> 			if (insert) {
> 				if (start_rgn == -1)
>@@ -901,14 +901,15 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
> 	return memblock_remove_range(&memblock.reserved, base, size);
> }
> 
>-int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>+int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
>+				       int nid, enum memblock_flags flags)
> {
> 	phys_addr_t end = base + size - 1;
> 
>-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>-		     &base, &end, (void *)_RET_IP_);
>+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
>+		     &base, &end, nid, flags, (void *)_RET_IP_);
> 
>-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
>+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
> }
> 
> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> again:
> 	found = memblock_find_in_range_node(size, align, start, end, nid,
> 					    flags);
>-	if (found && !memblock_reserve(found, size))
>+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))

Maybe we could use memblock_reserve_kern() directly. If my understanding is
correct, the reserved region's nid is not used.

BTW, one question here. How we handle concurrent memblock allocation? If two
threads find the same available range and do the reservation, it seems to be a
problem to me. Or I missed something?

> 		goto done;
> 
> 	if (numa_valid_node(nid) && !exact_nid) {
> 		found = memblock_find_in_range_node(size, align, start,
> 						    end, NUMA_NO_NODE,
> 						    flags);
>-		if (found && !memblock_reserve(found, size))
>+		if (found && !memblock_reserve_kern(found, size))
> 			goto done;
> 	}
> 
>@@ -1751,6 +1752,20 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
> 	return memblock.reserved.total_size;
> }
> 
>+phys_addr_t __init_memblock memblock_reserved_kern_size(int nid)
>+{
>+	struct memblock_region *r;
>+	phys_addr_t total = 0;
>+
>+	for_each_reserved_mem_region(r) {
>+		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
>+			if (r->flags & MEMBLOCK_RSRV_KERN)
>+				total += r->size;
>+	}
>+
>+	return total;
>+}
>+
> /**
>  * memblock_estimated_nr_free_pages - return estimated number of free pages
>  * from memblock point of view
>@@ -2397,6 +2412,7 @@ static const char * const flagname[] = {
> 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>+	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> };
> 
> static int memblock_debug_show(struct seq_file *m, void *private)
>-- 
>2.47.2
>

-- 
Wei Yang
Help you, Help me

