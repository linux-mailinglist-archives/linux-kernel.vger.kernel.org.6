Return-Path: <linux-kernel+bounces-527532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68DA40C60
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EF4189F2BF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4179F5;
	Sun, 23 Feb 2025 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuTx8AAK"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D68C11;
	Sun, 23 Feb 2025 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270154; cv=none; b=IG/aRgCl0lDjpaCOdJO/8g57ZxqtsR1FYsPCaEx0Vn8jJaPpuIJmFBvGFYFC+g1IZGEt4ZoHeb1ZUtJgqLtrVo3fdP/4kinJOQCRYZGoKGMueHHp3jn5hneK0xWa3dbXAJ0tlD68W/fI+5QuCf/t+OuRa51McjPnPx4icS5DkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270154; c=relaxed/simple;
	bh=p8xML3GukiuPCnoSUyPn99q5PhB8z+aC3YxAEwJq8XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvyYMu+1eFlq2RRQuFy21ibrM3peiBVk6DXB9vwRo2TVp4lbIw5fg4Efx3zPJ0Nc5lPDk3va8aaTG+Y5F8khhpK9zsxK5dvN6tg0tZ1w4d87x+HT1hSCxTPl6ljwLfnXhUaE2ih5V1TDbIundlKWVodyWzF/Qe97pr7r1FLCGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuTx8AAK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so5785387a12.3;
        Sat, 22 Feb 2025 16:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740270151; x=1740874951; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6kBdqL5Mv/zHgRCB8+EQApG54lUy8sBQC0RT66qpTY=;
        b=AuTx8AAKL51padIcDj9nHxphy47IeohrMf3byFNY4/P7Zu4m0GVGtIlqicRZanTmqn
         usiK+kTBjvR7glElu54hFNPmZuelRwJtb6zy/TnEa5PUILVjne9uI6qVkaXIvKA8L2mU
         YAbUknTYPcC6PodI9RKdGneHO4kx1Tna6eN4S/39MyQKTJqf33OwTZxQ3R9o9sptz2W9
         N+d7VowYgOcnuGmXktjB0nnu3bb5JvHQT6VonD/QedBzwtb7VhN3IoHTl4wFpZdiUDmN
         EvNywI1dD35L66/WV+vR8h+r7V6WcHRTHRhcP2Plxj5+yMcfntgysNLIVozFqv3pqWAr
         VtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740270151; x=1740874951;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6kBdqL5Mv/zHgRCB8+EQApG54lUy8sBQC0RT66qpTY=;
        b=DDVVUN3P8K9v1ozzGg1t4ia8gzNQTRVxqCge7eNmcaO/HPVGAagmwXEih+QdK/HxAJ
         q7znE9jO8RHYwC99KM1hL2ANY+56rN3kcSnPjJkdXCDv6nR3t0Ob3zpYNTJqTWLwDN39
         Tf/v29lUvKmfHLP5JEJ7dSIWCdZNTAwlC0y9r2qPCGlBSLCmoip3BxcMYTr7bTLvFzPO
         A0gIhR2pxKrxx0rzcIsJ24gjkzGlEc/4Hj6dFWv+SRAH7Tx8S8vAFcVlQ+HuxCWM9I/6
         X/RHSYLPJHUlBSAsCnYWEqGyF2TL8II6MyBA7FORzO2XiNVUo+UJerhjUE0eLoSR5kca
         ejDw==
X-Forwarded-Encrypted: i=1; AJvYcCV/dfMRJ8mY2PKq3tv0aPo1AQSzSoSDf4wdq7e6SJhW1au+a+oSv9RJEqTlkilyttldp6toSqXJU4RK@vger.kernel.org, AJvYcCXUcRGxxJQtbmP7R6+lYsvvsm0gKVvV8qUq7STx2hdqQ8QY3nFN8oKGF1Z9V3TVBNY7nOdHSPjJ0sFEYJu3@vger.kernel.org, AJvYcCXoisOP42rLDmoWnKRzmFfOW3217Qxfas4yCWmkakUkc8Qu7bUnrSd2wW06LvShcejMeVoFIdwdPT5t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/NCHm73mmTw8ODRs0Xv+UnVPApBRMqjTuCLLPE0qo3tq2/C1
	zHbjRmfQhu4g0SSAQcSnKLqUZu2yiT/QG+RbxA9K1r1AZXaJiK2w
X-Gm-Gg: ASbGncs3f4+fJCSAPuyLvcIFqx2gIud4DQvZ/JBwuar3sq0niHGbQm2Q9+GEbkAyT4t
	O5QzIN7qZZ3gq+E2NGSg3SzL/N/CyqawP+Aqbh7xXA0rvT4PK7H0mCSFDeuYVVtOS+hhMx40uuE
	JSmB2NN32G7lOKCF8L99fAnNMM5/9d2O2HRZsi5kj9BH/O9dTuAMF9LAPUmjcRlA+iJQfrCywOS
	nP8KcUWSDx9w9FJdhcw+m/3ojQG2tPtm6b3sY+Tm0oEq+P8jZ6AjkUqelGWoAP79LaIqWCJpkXj
	MviYZYvXv9JlEi5nTvSGNfSamg==
X-Google-Smtp-Source: AGHT+IHi6/1q2H/JzaBPY2EM3gZK+t9ZOl1hJ37YMXiB93ksHODnJQh+Uw5lQW63dWTHlum7aHYuYw==
X-Received: by 2002:a05:6402:440b:b0:5e0:4064:add6 with SMTP id 4fb4d7f45d1cf-5e0b722d3e0mr7683404a12.31.1740270150552;
        Sat, 22 Feb 2025 16:22:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e09072247esm6510575a12.51.2025.02.22.16.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2025 16:22:30 -0800 (PST)
Date: Sun, 23 Feb 2025 00:22:29 +0000
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
Message-ID: <20250223002229.xuk6xlp23zr72hkc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WHL_Xqgoln9oLg@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> >to denote areas that were reserved for kernel use either directly with
>> >memblock_reserve_kern() or via memblock allocations.
>> >
>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >---
>> > include/linux/memblock.h | 16 +++++++++++++++-
>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >index e79eb6ac516f..65e274550f5d 100644
>> >--- a/include/linux/memblock.h
>> >+++ b/include/linux/memblock.h
>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> 
>> Above memblock_flags, there are comments on explaining those flags.
>> 
>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>
>Right, thanks!
> 
>> > 
>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> > again:
>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> > 					    flags);
>> >-	if (found && !memblock_reserve(found, size))
>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> 
>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> correct, the reserved region's nid is not used.
>
>We use nid of reserved regions in reserve_bootmem_region() (commit
>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>know the distribution of reserved memory among the nodes before
>memmap_init_reserved_pages().
> 

I took another look into this commit. There maybe a very corner case in which
will leave a reserved region with no nid set.

memmap_init_reserved_pages()
    for_each_mem_region() {
        ...
	memblock_set_node(start, end, &memblock.reserved, nid);
    }

We leverage the iteration here to set nid to all regions in memblock.reserved.
But memblock_set_node() may call memblock_double_array() to expand the array,
which may get a range before current start. So we would miss to set the
correct nid to the new reserved region.

I have tried to create a case in memblock test. This would happen when there
are 126 memblock.reserved regions. And the last region is across the last two
node.

One way to fix this is compare type->max in memblock_set_node(). Then check
this return value in memmap_init_reserved_pages(). If we found the size
changes, repeat the iteration.

But this is a very trivial one, not sure it worth fix.

-- 
Wei Yang
Help you, Help me

