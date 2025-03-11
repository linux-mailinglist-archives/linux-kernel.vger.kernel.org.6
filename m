Return-Path: <linux-kernel+bounces-555492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B0A5B884
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6691894B93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CA1EE01F;
	Tue, 11 Mar 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAHpdUKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B01E9B36;
	Tue, 11 Mar 2025 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670865; cv=none; b=X6kHiJVNCkMETPquYj/huoBxdI1KdxXqqtxC1PFWOz+2EtDYg8I++jwEir3vNThzfiu5M3DAMjLjmJjm81jgj2gW+fET2Ga4Kqay4y5NkH6zDfrFPLznYpaPJq7V8QA2CISSqSKW9uKX21ILkVnGEQUd1lCqEI4fZBq/vkXvFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670865; c=relaxed/simple;
	bh=6FrJToULI5AieC/xcPkMqRkdPc73MU/g7qUb/+Gf2LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPdHR+VcMpP0/xLzNbTVaQP1+BMnPpVWa2+eCjR+/LLomqNS3d6Fo5o5JGHqHN5Ow6rbVeH+pCXvr+izPnMRJZPlnc3X08+kdkk+K6RTagmH0Qyx5VmZHRGS5zpok4LHXrwCFCys8QWmBKJyCKT0IpLBVoCj8m69+Kr0pnIYe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAHpdUKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB76C4CEEC;
	Tue, 11 Mar 2025 05:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741670864;
	bh=6FrJToULI5AieC/xcPkMqRkdPc73MU/g7qUb/+Gf2LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAHpdUKSmv1QM82YGoNX6ldSWprWPtoQeq7oZVYRSenmRL5V3mQA0Z/8J1J7rkbXY
	 DCZ1PolWSm96XtMjC6zHeV/4BIYLkdQBd+2LSkhUUHx/NvSeQhtKi3xVRFBvvahBI6
	 Fgecu8QW9SZnOgCJFzyGzUd8oW5EhoPWaTHjItebVqj/yACpIkHUi3606UEwiKBAbx
	 3YfDwolecrwr/CHlFMVtqpXQ8QtwdePj5lo049ABQgMlHqkjpQCaCVHGRbh/9KJaaJ
	 GKa8u7BRKr01NRTAB8Jp1oImuXWXsRmL8WzrwbdwZpVY+aPZzBz/SBsDbDXNSbRoaJ
	 K0Cd6UgpZbrJA==
Date: Tue, 11 Mar 2025 07:27:23 +0200
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
Message-ID: <Z8_Ju0p63GBCdSG9@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310095124.pa7dwgqhxglqrfes@master>

Hi Wei,

On Mon, Mar 10, 2025 at 09:51:24AM +0000, Wei Yang wrote:
> On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
> >On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
> >>Hi,
> >>
> >>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> >>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >>> >
> >>> >to denote areas that were reserved for kernel use either directly with
> >>> >memblock_reserve_kern() or via memblock allocations.
> >>> >
> >>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> >---
> >>> > include/linux/memblock.h | 16 +++++++++++++++-
> >>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> >>> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >>> >
> >>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >>> >index e79eb6ac516f..65e274550f5d 100644
> >>> >--- a/include/linux/memblock.h
> >>> >+++ b/include/linux/memblock.h
> >>> >@@ -50,6 +50,7 @@ enum memblock_flags {
> >>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> >>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> >>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >>> 
> >>> Above memblock_flags, there are comments on explaining those flags.
> >>> 
> >>> Seems we miss it for MEMBLOCK_RSRV_KERN.
> >>
> >>Right, thanks!
> >> 
> >>> > 
> >>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >>> > again:
> >>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> >>> > 					    flags);
> >>> >-	if (found && !memblock_reserve(found, size))
> >>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> >>> 
> >>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> >>> correct, the reserved region's nid is not used.
> >>
> >>We use nid of reserved regions in reserve_bootmem_region() (commit
> >>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
> >>know the distribution of reserved memory among the nodes before
> >>memmap_init_reserved_pages().
> >> 
> >
> >I took another look into this commit. There maybe a very corner case in which
> >will leave a reserved region with no nid set.
> >
> >memmap_init_reserved_pages()
> >    for_each_mem_region() {
> >        ...
> >	memblock_set_node(start, end, &memblock.reserved, nid);
> >    }
> >
> >We leverage the iteration here to set nid to all regions in memblock.reserved.
> >But memblock_set_node() may call memblock_double_array() to expand the array,
> >which may get a range before current start. So we would miss to set the
> >correct nid to the new reserved region.
> >
> >I have tried to create a case in memblock test. This would happen when there
> >are 126 memblock.reserved regions. And the last region is across the last two
> >node.
> >
> >One way to fix this is compare type->max in memblock_set_node(). Then check
> >this return value in memmap_init_reserved_pages(). If we found the size
> >changes, repeat the iteration.
> >
> >But this is a very trivial one, not sure it worth fix.
> >
> 
> Hi, Mike
> 
> I have done a user space test which shows we may have a chance to leave a
> region with non-nid set.
> 
> Not sure you are ok with my approach of fixing.

Wouldn't it be better to check for a change in reserved.max in
memmap_init_reserved_pages()?
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

