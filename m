Return-Path: <linux-kernel+bounces-530664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50DA4365C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4040170DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2C2566E2;
	Tue, 25 Feb 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNF5vIXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364625A622;
	Tue, 25 Feb 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469610; cv=none; b=V2PPMehPb6IIYRXu526s7yE8uDDeLpu4rGGtBPeftMJIQ6PffDnu/B4RWCuQ4+0Mefn1HoOz1sUAeG4TcAk/w5xxofm/WZBOrQ0hRuQgAbTFBZ3mJimZTSnMctIKAsfSM5MerXH3+JgPFzNnhJiV/1XBHP13lny6XCQUK39SSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469610; c=relaxed/simple;
	bh=ufWHWQ1xjvwW0hl8NZb6j0p51Ljh1vhupp5zrhn05g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqAdddb0pFcCcve394SeNaxNYQnaBvBa4FZ9ZrtDpNXgAcPO6RSHmBAfAEOu3/OPcTWaDH53vf54nelQbOr4pWDILZFWY9zA/BznyEAgPp55xtRdSbiTKkqh+I/XIXp07WFaJ5ImwnnGEv3teya5+fLDpZJpOcLR7pew4qWgrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNF5vIXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BF0C4CEDD;
	Tue, 25 Feb 2025 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469609;
	bh=ufWHWQ1xjvwW0hl8NZb6j0p51Ljh1vhupp5zrhn05g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNF5vIXE8AI1M72/t0vxMc2XxKToFenm/PAwm6NZlyzcXaF3GjKp3p8wjKOQxZsS7
	 U5SdmrZ6BYaIYN/FwLyRn6F6fE1le5OiAG1N1ERsiHU12nBZ0Mpu+uoTJxsNcrzgL5
	 FecXJjFgXjXiQvXjfk0dv540gXmPw1NfbWIvf34KHRA1eYhDFFirjnTSuwgDS6kEOd
	 1qDcx0OgryYeV466p9C+RQAkPDKOvmVtK2XQyZFdYwXGOngf8RClrW5TVTs70NL83+
	 yvakFILGXUbl3fYUBTPeGqmiA4fnXW4OaTfniPVNR1nBcO4RYgvzzBPR4DQ+sz2u+j
	 fzz+pKVE/XpLg==
Date: Tue, 25 Feb 2025 09:46:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
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
Message-ID: <Z711VP45tjBi0kwx@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224013131.fzz552bn7fs64umq@master>

On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
> >Hi,
> >
> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> >to denote areas that were reserved for kernel use either directly with
> >> >memblock_reserve_kern() or via memblock allocations.
> >> >
> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> >---
> >> > include/linux/memblock.h | 16 +++++++++++++++-
> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >> >
> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >> >index e79eb6ac516f..65e274550f5d 100644
> >> >--- a/include/linux/memblock.h
> >> >+++ b/include/linux/memblock.h
> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >> 
> >> Above memblock_flags, there are comments on explaining those flags.
> >> 
> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
> >
> >Right, thanks!
> > 
> >> > 
> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >> > again:
> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> >> > 					    flags);
> >> >-	if (found && !memblock_reserve(found, size))
> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> >> 
> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> >> correct, the reserved region's nid is not used.
> >
> >We use nid of reserved regions in reserve_bootmem_region() (commit
> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
> >know the distribution of reserved memory among the nodes before
> >memmap_init_reserved_pages().
> > 
> >> BTW, one question here. How we handle concurrent memblock allocation? If two
> >> threads find the same available range and do the reservation, it seems to be a
> >> problem to me. Or I missed something?
> >
> >memblock allocations end before smp_init(), there is no possible concurrency.
> > 
> 
> Thanks, I still have one question here.
> 
> Below is a simplified call flow.
> 
>     mm_core_init()
>         mem_init()
>             memblock_free_all()
>                 free_low_memory_core_early()
>                     memmap_init_reserved_pages()
>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>                     __free_memory_core()
>         kmem_cache_init()
>             slab_state = UP;                                          --- (2)
> 
> And memblock_allloc_range_nid() is not supposed to be called after
> slab_is_available(). Even someone do dose it, it will get memory from slab
> instead of reserve region in memblock.
> 
> From the above call flow and background, there are three cases when
> memblock_alloc_range_nid() would be called:
> 
>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>   * If it is called after (2), we don't touch memblock.reserved.
>   * If it happens between (1) and (2), it looks would break the consistency of
>     nid information in memblock.reserved. Because when we use
>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
> 
> So my question is if the third case happens, would it introduce a bug? If it
> won't happen, seems we don't need to specify the nid here?

We don't really care about proper assignment of nodes between (1) and (2)
from one side and the third case does not happen on the other side. Nothing
should call membloc_alloc() after memblock_free_all(). 

But it's easy to make the window between (1) and (2) disappear by replacing
checks for slab_is_available() in memblock with a variable local to
memblock.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

