Return-Path: <linux-kernel+bounces-520985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EBA3B24B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70251897408
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514E1C1F05;
	Wed, 19 Feb 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtKBbQaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579C1BBBC6;
	Wed, 19 Feb 2025 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949895; cv=none; b=IY20pb/nVNCAIyFVWgLOJhyjfr9eLoytOCa/yxuxY8tJRTMW2mOQUj+g788ACR8HXEbjGjnP6Fo7QQrAwyVp7w75nbuFKMho6nm38EOwvINLm7hn+4MK2vmVQ/iYL8U2w/eC8CvZz3lCVZ4FsD3GAKryeKbHjBrg12fub34wHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949895; c=relaxed/simple;
	bh=SRqj9MZLCV8OPtw+RLc/L0/R3k9RqsqUSw55QX9OOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtPfqFmnY540fizjQvdMLKzY79uMEwbWgyoG8nP+AUei+W+bc5edInd9RytkY6rzc1GKTBjx3X7VwX16g1q+TBSyli2yvA9ZX/jamMqH5+LqF7X8A8FGtlAq+4eb1nXbxChMd7OQf6e21q/X50HcHruXH4B/XLp5p5MnoGtejwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtKBbQaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1235C4CED1;
	Wed, 19 Feb 2025 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949894;
	bh=SRqj9MZLCV8OPtw+RLc/L0/R3k9RqsqUSw55QX9OOlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtKBbQaYTslR+0p7SefBILIuS73xk2HkHE9X1wi3f1RYXdzexSpsyIrHcPKNtZYjL
	 BvKiLvIz6tiQbKcH9IhyUrzpRPaTkQMGYuEz3o1+LwRY6+cXJ2ZdV6QYVU7JbUtlYQ
	 05YBQSpFJ0o9+4PFttNGG2I4B8gyRtwm24/vnas8DwL/rcu9i5Hz/rxhmWxht1y1Dw
	 wkLpe3ZZgtmacfwPN46ynU8iy+ypPSs9dwF5Tdr7KWenmjNUChafxZkv2PmgFVMNfi
	 6mdnd8DQM0qYd4dN8GiXu45YvQUX49U1bZ45kTkOBpF0wvbKLl80gJxVUX5K2raMUR
	 MM9jdOERGv5AQ==
Date: Wed, 19 Feb 2025 09:24:31 +0200
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
Message-ID: <Z7WHL_Xqgoln9oLg@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218155004.n53fcuj2lrl5rxll@master>

Hi,

On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> >to denote areas that were reserved for kernel use either directly with
> >memblock_reserve_kern() or via memblock allocations.
> >
> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >---
> > include/linux/memblock.h | 16 +++++++++++++++-
> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >
> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >index e79eb6ac516f..65e274550f5d 100644
> >--- a/include/linux/memblock.h
> >+++ b/include/linux/memblock.h
> >@@ -50,6 +50,7 @@ enum memblock_flags {
> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> 
> Above memblock_flags, there are comments on explaining those flags.
> 
> Seems we miss it for MEMBLOCK_RSRV_KERN.

Right, thanks!
 
> > 
> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> > again:
> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> > 					    flags);
> >-	if (found && !memblock_reserve(found, size))
> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> 
> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> correct, the reserved region's nid is not used.

We use nid of reserved regions in reserve_bootmem_region() (commit
61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
know the distribution of reserved memory among the nodes before
memmap_init_reserved_pages().
 
> BTW, one question here. How we handle concurrent memblock allocation? If two
> threads find the same available range and do the reservation, it seems to be a
> problem to me. Or I missed something?

memblock allocations end before smp_init(), there is no possible concurrency.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

