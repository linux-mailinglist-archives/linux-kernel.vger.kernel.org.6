Return-Path: <linux-kernel+bounces-532842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D7EA452D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5268E18992D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBC20B21C;
	Wed, 26 Feb 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3dw8Qjk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662419F13F;
	Wed, 26 Feb 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535760; cv=none; b=ZX4l/+pSY8/aVw1Zn0XZj6CZMMY5ERspTmIya5QnNAV3TTQrtaY8Wte5k9AyULTO2inuN6t5r2iQr7xRDwXaDSkw3hXqEbqRYO7T/wYOXi1Rrt8Kbk1Bx7Z0gGHQKdGPeXUCt54fdxQZzxdkwNMV9CdjZEHZWWAfJAIAwTg1Um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535760; c=relaxed/simple;
	bh=IEbds4yphJOI94QKHcQ3WECEM4kLPwgihOa8v/Lflno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5+HWgNQEtbyy75yZjvx7CBuhf/vSD6ry8UUrc86vgJ9ox00A/uNAs0c4jWJVB6FN3y5tLuNMTr7G7oU02g6DxmS/r4XZsEsjnLX9sSpi+yWV6VKlyMKwQCN+aSsmigyVevxDRmO5Rri1r9bx9BC2MRaOcvD+fU7GLp070Fne10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3dw8Qjk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso9519627a12.3;
        Tue, 25 Feb 2025 18:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740535757; x=1741140557; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNDX0bDy82gk9QmnrN58DpzxWTxMxMF4PEgthtYO/y8=;
        b=L3dw8QjkDEd+mikXhB0AoirPeK6EdAFYgTb3OIJ0Ni+JAkRwQE27xAl+McP/yPQDKg
         x3Tz3YWoZXW8b8FCBAYyac5eCAXfx4IeKdeXzZLmiwkKf/IBKRc9fboEB/zJtXIeYnwk
         O7HmnqVLVUlxaTtj//PQvrFodTlQgKydcWI2hNcB4kEnArA3x+TwcQ0P6QmBrERxl8RQ
         oEVi1jgP55SdvFH8kk0Z+YMpnP7x2P2p3yvcw/s4gJOVo4sJh8GYE+RqJ5vEVH5XmXDo
         S0TUKsu5AX8lzjb104uVn/lHYZ2DqBQNI72yafS0fGnr/0cFUhYkLhjhNLV1bnjCc4tg
         x2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535757; x=1741140557;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNDX0bDy82gk9QmnrN58DpzxWTxMxMF4PEgthtYO/y8=;
        b=FtfPvIa13dVGCioIZ7B2QkqM4HTp0XwhM0114NWkxSHZM4ZYXnjYsCjLwYEfm4xnaR
         Gl4mR4jySKXZfPU15bvbJHGpSr+ntHL9bCk33gXOjfyYPtNLQi7KmQeBvbAQMT0IVP/0
         909PVzQd5Zc6GXhRcriJgZ1LP+dHhmQLg/DhVDF2YcXkIr5OC7+Cy2Df+D8blsMtfO+m
         FxBGX8SGlcVO4LVNrwuU/fQ5WNAcIwYIRDijjRq/7mZ55Ru0Sa7hv9avPwH+Xs0kTvvC
         yK33DbnfMoLcslugiyz3UoMxWOkHown1Yh3iwrwhdR89QcTAgfyMn1DjEsv4+Xy80XGw
         JWqw==
X-Forwarded-Encrypted: i=1; AJvYcCUIEgSQfW9HxW6Sn0D10B2IJbAda7YFs5NQMn2s2MlQQIGxtjWXMLX07iTbMZTGo48IIjtRQjD2FNzb@vger.kernel.org, AJvYcCUoAohxHfwkuRxatq5H5zatDdDea9pvX+9DJlSzN+uDFdS5ig0Bd2gCayZ0BMHe32OdHf/XgK7FWi5+QC0n@vger.kernel.org, AJvYcCW7bW6EUZK7CtA6/gjkO5CoPTgH+ZATbw76hjXSPd7LrH4Klu+5ABWrHqU5Bygvrki/kmr+hmMJ2hOc@vger.kernel.org
X-Gm-Message-State: AOJu0YxJf54fckw4ADKwmeC3SztW1K9w32f/jX6AyFM887Hzm9a2VOY2
	FgNJ7QVvc6iizJOvGhTfCnjuk38bv6KUAmHQPdu+5SyP++HPhqn1
X-Gm-Gg: ASbGncuxuVIYpuH1dfTUw/H5X5ooynFZYoHhc+2Jv8banW1O+YvN+xmdTMgP+z4HOFn
	dUw4q8TkY7qzQmNGmLnDrq10/VJUh2BmZ84q6Sf2HKTcRHEVtAIM/2JTHtxRM0PHMuipzdX4lyr
	FSeW/G8k3GqbemwsY+wmROEtC9kzcrYvJcpi1nn3Cx+QwOPUxcB05GkR1n9JJZtzfvOS9fHwG5t
	TVzF0YPicsPqOEAgvAEhXKVOUL8Dd5mxzaQ3PQ5m0JMvShL8xT7Xoavn6Z7xPqnQBkpnpJLQNV8
	2L8vXfo3xX4EDHhyMgARcnfiXA==
X-Google-Smtp-Source: AGHT+IGRtYD7rWXN/Sb7N5YCwL4iwg6Gy2cLXak4su8dMR+fikHn63505aewDuiYmopReDoTjLpqLQ==
X-Received: by 2002:a05:6402:5508:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4a0d71d15mr1703278a12.11.1740535757056;
        Tue, 25 Feb 2025 18:09:17 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e461f3e675sm1976282a12.72.2025.02.25.18.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2025 18:09:16 -0800 (PST)
Date: Wed, 26 Feb 2025 02:09:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
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
Message-ID: <20250226020915.ytxusrrl7rv4g64l@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z711VP45tjBi0kwx@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 25, 2025 at 09:46:28AM +0200, Mike Rapoport wrote:
>On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
>> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>> >Hi,
>> >
>> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >> >
>> >> >to denote areas that were reserved for kernel use either directly with
>> >> >memblock_reserve_kern() or via memblock allocations.
>> >> >
>> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >> >---
>> >> > include/linux/memblock.h | 16 +++++++++++++++-
>> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >> >
>> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >> >index e79eb6ac516f..65e274550f5d 100644
>> >> >--- a/include/linux/memblock.h
>> >> >+++ b/include/linux/memblock.h
>> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> >> 
>> >> Above memblock_flags, there are comments on explaining those flags.
>> >> 
>> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
>> >
>> >Right, thanks!
>> > 
>> >> > 
>> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> >> > again:
>> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> >> > 					    flags);
>> >> >-	if (found && !memblock_reserve(found, size))
>> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> >> 
>> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> >> correct, the reserved region's nid is not used.
>> >
>> >We use nid of reserved regions in reserve_bootmem_region() (commit
>> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>> >know the distribution of reserved memory among the nodes before
>> >memmap_init_reserved_pages().
>> > 
>> >> BTW, one question here. How we handle concurrent memblock allocation? If two
>> >> threads find the same available range and do the reservation, it seems to be a
>> >> problem to me. Or I missed something?
>> >
>> >memblock allocations end before smp_init(), there is no possible concurrency.
>> > 
>> 
>> Thanks, I still have one question here.
>> 
>> Below is a simplified call flow.
>> 
>>     mm_core_init()
>>         mem_init()
>>             memblock_free_all()
>>                 free_low_memory_core_early()
>>                     memmap_init_reserved_pages()
>>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>>                     __free_memory_core()
>>         kmem_cache_init()
>>             slab_state = UP;                                          --- (2)
>> 
>> And memblock_allloc_range_nid() is not supposed to be called after
>> slab_is_available(). Even someone do dose it, it will get memory from slab
>> instead of reserve region in memblock.
>> 
>> From the above call flow and background, there are three cases when
>> memblock_alloc_range_nid() would be called:
>> 
>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>>   * If it is called after (2), we don't touch memblock.reserved.
>>   * If it happens between (1) and (2), it looks would break the consistency of
>>     nid information in memblock.reserved. Because when we use
>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>> 
>> So my question is if the third case happens, would it introduce a bug? If it
>> won't happen, seems we don't need to specify the nid here?
>
>We don't really care about proper assignment of nodes between (1) and (2)
>from one side and the third case does not happen on the other side. Nothing
>should call membloc_alloc() after memblock_free_all(). 
>

My point is if no one would call memblock_alloc() after memblock_free_all(),
which set nid in memblock.reserved properly, it seems not necessary to do
__memblock_reserve() with exact nid during memblock_alloc()? 

As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
patch.

>But it's easy to make the window between (1) and (2) disappear by replacing
>checks for slab_is_available() in memblock with a variable local to
>memblock.
> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

