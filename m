Return-Path: <linux-kernel+bounces-539434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7123A4A437
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83603A862B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF7279347;
	Fri, 28 Feb 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfFIn91K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC404202981;
	Fri, 28 Feb 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774045; cv=none; b=aSLVzjtqLbbBlVY92gA7V1Em10FTkJab+8b/dJQMbCxJWzqWs7hTspGlwGW6/eV52ECwEscIcEiNBdkqTmDXu1R5HQahEbhvSH5Qrwx3gUlpg08L2I09gWdUtj9Yh5QMyZfxmJM/14bdv1yLSbXDkkQooYemoIpv6oLKMU+9IAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774045; c=relaxed/simple;
	bh=bbzE7bwrYKBUNI91akgimXhe+iLOXIRvjnh9wKEiBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLE6wZqFMjSWG+2pp5iL0WexeayMOC1rEdwEhkG0cMAzc0Mhob6fNqJKR/LSkavyByQSBErm48ChG4qtWCVipZWt93UHVT9Hf8Xp97K/Ys0ic8HbMDJmhwwI72/YlJOSKPDQ1qWRTP/+YdMFvLSIIVSdLzCbEvVO1sAjIysHQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfFIn91K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A39C4CED6;
	Fri, 28 Feb 2025 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740774045;
	bh=bbzE7bwrYKBUNI91akgimXhe+iLOXIRvjnh9wKEiBG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfFIn91KSNHhn07yKT9l2oOU8euWhSQeLxxD1+CP5Lmkt8N8i6O/Zn9pEs4NGiCJj
	 qJEjrvhzqZMOIYECg3O0McklsQMWurW5bICaO6Eqlily54ppx+yXiPrIfcDSkbmmEy
	 mgA+RTO662SeKhJ/BeytWpw2yGPCMjmkdX2P8FuJVAKh+rj8Ay73HcAZ8F0mxABP/0
	 t/Etv53LQUPDT8LDrOxXxcp5ZTSXxggaTWVIPD4REQMGOIcj+m3X88aLIXEmmDQWmj
	 830FksBD61RtpQPNDjonn0bpZ2XqD0baA3+sDkYSi8hDY+Sf6kIPnRC3EZcEYLP+NU
	 hO0vT2n2HTtbg==
Date: Fri, 28 Feb 2025 22:20:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
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
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z8Iah6FgrhSzApwf@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <mafs0cyf4ii4k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cyf4ii4k.fsf@kernel.org>

Hi Pratyush,

On Wed, Feb 26, 2025 at 08:08:27PM +0000, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Thu, Feb 06 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Hi,
> >
> > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> > just to make things simpler instead of ftrace we decided to preserve
> > "reserve_mem" regions.
> [...]
> 
> I applied the patches on top of v6.14-rc1 and tried them out on an x86
> qemu machine . When I do a plain KHO activate and kexec, I get the below
> errors on boot. This causes networking to fail on the VM. The errors are
> consistent and happen every kexec-reboot, though fairly late in boot
> after systemd tries to bring up network. The same setup has worked fine
> with Alex's v3 of KHO patches.
> 
> Do you see anything obvious that might cause this? I can try to debug
> this tomorrow, but if it rings any loud bells it would be nice to know.

Thanks for the report!
It didn't ring any bells, but after I've found the issue and a
fast-and-dirty fix.

The scratch areas are allocated from high addresses and there is no scratch
memory to satisfy memblock_alloc_low() in swiotb, so second kernel produces
a couple of 

software IO TLB: swiotlb_memblock_alloc: Failed to allocate 67108864 bytes for tlb structure

and without those buffers e1000 can't dma :(

A quick fix would be to add another scratch area in the lower memory
(below). I'll work on a better fix.

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c26753d613cb..37bb54cdb130 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -623,13 +623,13 @@ static phys_addr_t __init scratch_size(int nid)
 static void kho_reserve_scratch(void)
 {
 	phys_addr_t addr, size;
-	int nid, i = 1;
+	int nid, i = 2;
 
 	if (!kho_enable)
 		return;
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_scratch_cnt = num_online_nodes() + 1;
+	kho_scratch_cnt = num_online_nodes() + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_scratch)
@@ -644,6 +644,15 @@ static void kho_reserve_scratch(void)
 	kho_scratch[0].addr = addr;
 	kho_scratch[0].size = size;
 
+	addr = 	memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES,
+					  MEMBLOCK_LOW_LIMIT,
+					  ARCH_LOW_ADDRESS_LIMIT);
+	if (!addr)
+		goto err_free_scratch_areas;
+
+	kho_scratch[1].addr = addr;
+	kho_scratch[1].size = size;
+
 	for_each_online_node(nid) {
 		size = scratch_size(nid);
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,

> -- 
> Regards,
> Pratyush Yadav
> 

-- 
Sincerely yours,
Mike.

