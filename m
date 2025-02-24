Return-Path: <linux-kernel+bounces-528028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D78A412A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9072A16FE31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C36E3B192;
	Mon, 24 Feb 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYhXnwmq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047D79D0;
	Mon, 24 Feb 2025 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360696; cv=none; b=c0e4lBoQJqgmdS48d4n4WXXH8f4cgTGIAAbDZLk72B4GHmGhKKF7SlGpqZ7RM8STS1Stk8BMyt9j0GRE0jYycfTPbB9tRnIFwqzMFAIQlM1ZrSb+kfgVvNxtqJNGbEvZqn5Fv0RdJyM7QtGCLGLdVl9oN9FHUgipDdin1Ll6D3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360696; c=relaxed/simple;
	bh=HH1VhpeXUzaXQ0Tnx3JnZiaBDP06XYWOmRyOevkR9Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQSVjpokG1XDXwkibfY5cp/UMfRMxq9INdvuLeP94TX2EGSdrtEH39XTE/3GECH/SKBLIZEW8z1c5WomMI59pWwmLKYrvsKiT9D568yf9hSevBjgGTtfgTzXQIKLwWN7w12w3s4v27YGfAMVfo8OprD7sJLhVIGd7ZvMNMOmlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYhXnwmq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so7371941a12.1;
        Sun, 23 Feb 2025 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740360693; x=1740965493; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4GvaqVIL/hNKQlnj0DT9cN3mMKxJVdcE+NJpBmVvb8=;
        b=ZYhXnwmqvccmxL4PYtSvsHUQnN5yCaoi/1tWm1UvDJTLOhMEJ7zXUZ2hlCDl7mK0ne
         X9RpZhN3Gzdx3HGrZD2BlENhtSuxntoL83lBc1s6Yj1izNgFeJbp/wCGYXZb64IoUhe1
         jetaWzEu291HaUMPlpaaSn01jNIS3lw+fF4kEigg8hwqrgGQrc24AogbQy0IpkKBel8W
         o7W4PHgElVIkTUwVaVYGKqTZ9kUbx4c49Dv20FpSTYrfQY3fvv8HNohzgGu3GuCPkBNL
         4e9RFqyraZ+gWolgGfK2tZiJr76sqCjTILggEQC/RKeP4+CKgjbkmyhbdUCei2wXmK6C
         vYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360693; x=1740965493;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4GvaqVIL/hNKQlnj0DT9cN3mMKxJVdcE+NJpBmVvb8=;
        b=aCOgw8/uvOfEFHjFU7TTbTWfO+zA704LAyK+JVVOb4MElYm/vrtx7aJ4fhn2XbrhvN
         /IPits+ibw1zfT9GF7QZWpOe75IqPQEGnA8rzjIqs4Q+Qrb4/KZDFbNUdL9puRJ1n7dQ
         4cMNuQeE4HT7jvzeLMhpZQQpgXzKURRF2ccxVVaS6LAS+YjdwmIPV+jGCIT99zJLx0h9
         LhlzZ1uumisMDECuoK0P2nh3y1FJEKOPTAszpuaelWbhwpShY99RMH1M7HLMDOl1g8g3
         Gci6iCxWggf9H796fLVnLRljAMUCYkk5iRXR+c9GzXlE31YUxPPF99MAXC/kdsSe8jz4
         o8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUGCtHlmGsyJF9fvPQMddpiB0zdM2kPSc1b3W/Emz2vCXA6GwLNinBzWldyNA3eK8ITqr6p8IiSvqXq@vger.kernel.org, AJvYcCV2XiFA9oSkTrHRBA/qPsoyeCIaKZ1uFQYeZy+j3H/Od2+RsvPLrwbVGB7UdYn5zPoBLSDGIDfK+qjv@vger.kernel.org, AJvYcCWbP2gEv036iBpugyy6En3FSt2XLGtSrqFDUpntIjMk8016kG6vYc5p9dfKyoZWuiPltrFlc0daR4P6bSno@vger.kernel.org
X-Gm-Message-State: AOJu0YyQO3Iq/0XDDNybHuz3mZDnjs5DlxRKkKd/ad1AoRKB08oR2QVf
	hNOpa/RxguowdzL8gj8bz9rH28OQ7zo2nmdcvQZvHCYLM3P8/MbMUMHSNnAz1d0=
X-Gm-Gg: ASbGncscaQTYmqZmW6pKdqcipHp5jia6a0odAMOVZWQ7Am/bPFzLTYizmqsaxIReauz
	G43er+FthMY9ctm2LMGG/BHv62rLNqX80hmKELqR6AwDqcXLG0KxWKUBGF0AkVg2CHtRuX7bSn2
	4di2oz2SOkTVyMs21qoLYLLejyMJm8NN6HzhO3w9R3T0ouNcVMS3gZXrft/lUNBT9QDS/JoftWy
	QWV42sO/9hC9Ec8QC9SBnH3g2J3VkSLkbP3XYkv5kikDA5+HLAyd9rDcTkEPJPXyU12/EIqaV7s
	roL9RbHmf47jFiDWHgXY0UDLYg==
X-Google-Smtp-Source: AGHT+IHSNuXjvZ6j34bY7irzKgYOPZ2Pc9eRXhFT7vf6gvwUpLsnEqOodUyWWZF1htL/xJzW8ObUNw==
X-Received: by 2002:a05:6402:4313:b0:5de:4b81:d3fd with SMTP id 4fb4d7f45d1cf-5e0b70fa0efmr10728444a12.13.1740360692719;
        Sun, 23 Feb 2025 17:31:32 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c43a0sm17589157a12.28.2025.02.23.17.31.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 17:31:31 -0800 (PST)
Date: Mon, 24 Feb 2025 01:31:31 +0000
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
Message-ID: <20250224013131.fzz552bn7fs64umq@master>
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
>> BTW, one question here. How we handle concurrent memblock allocation? If two
>> threads find the same available range and do the reservation, it seems to be a
>> problem to me. Or I missed something?
>
>memblock allocations end before smp_init(), there is no possible concurrency.
> 

Thanks, I still have one question here.

Below is a simplified call flow.

    mm_core_init()
        mem_init()
            memblock_free_all()
                free_low_memory_core_early()
                    memmap_init_reserved_pages()
                        memblock_set_node(..., memblock.reserved, )   --- (1)
                    __free_memory_core()
        kmem_cache_init()
            slab_state = UP;                                          --- (2)

And memblock_allloc_range_nid() is not supposed to be called after
slab_is_available(). Even someone do dose it, it will get memory from slab
instead of reserve region in memblock.

From the above call flow and background, there are three cases when
memblock_alloc_range_nid() would be called:

  * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
  * If it is called after (2), we don't touch memblock.reserved.
  * If it happens between (1) and (2), it looks would break the consistency of
    nid information in memblock.reserved. Because when we use
    memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.

So my question is if the third case happens, would it introduce a bug? If it
won't happen, seems we don't need to specify the nid here?

-- 
Wei Yang
Help you, Help me

