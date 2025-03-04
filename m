Return-Path: <linux-kernel+bounces-543697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFAA4D8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39181892AA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD1201266;
	Tue,  4 Mar 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPjPO728"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B01FC7C2;
	Tue,  4 Mar 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080793; cv=none; b=PoAZGndSiL2EHoJqRASna2eEEi49QvW61fN96GJUvU9/ltj2JMeP5/4AEr2EHms1krIt2jysViF85Dtczikxj9F9AIdgINbN06Rfd3TiLkJz6pH8i+Qj2p/ymhCTsAJ3rEVSRmpEh2A6AzS0DbwKruBXEBE3wi0a6vRJKk89fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080793; c=relaxed/simple;
	bh=qdRvwp2jiMda3Te2OCgP160WD3D/MfERmLF+KG8hFK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROz5uNq8r2WVsfbZbqueRzgd1fSBW5ItM5Wy7KN+pgwVRGPsZn9MXrcTWYPu10+ZxxcChlbCZ0Lw2T500gUDvIfT76iqO8u/Rr3anlKtNwLaD9v7UkmkL6xW2UqcW5okWkzEuYZY93pSz0gI8lEigIacoUj1UvK9lO7giGuipG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPjPO728; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E54DC4CEE8;
	Tue,  4 Mar 2025 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080793;
	bh=qdRvwp2jiMda3Te2OCgP160WD3D/MfERmLF+KG8hFK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPjPO728RC8LQvA6Wiyf4TegFs2+e2krYP7wmVWZqgvl1Q449m2PfkYEU7PjvioN/
	 BrXWaoZ/e4meAM/vO2iavpQ7QMK2IeUS/ATI+wPNBqmQAH6t9WMUPLMy9cQUPtpBZB
	 rQ3aUnXID96RoI4/m8Hjfocq5bsyXe4/7ZCJn55Gg5MNRLWYKEFt9GqQUFd73zc9Z3
	 RO+kGsWtez8YGVIJrZBEMTYIYC0JShaT0FVFJYaI71VUL8i4luasT7vbqBSlbAUIOO
	 Bnepf7NkX7TYRg6SOD01YKc3yE2p725KPKsRfBaB5ZJ1gMuM/l/jl3LkZzUba3xhFn
	 csl+U8ZzFriKg==
Date: Tue, 4 Mar 2025 10:33:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/40] x86: Leaf 0x2 and leaf 0x4 refactorings
Message-ID: <Z8bI1JwDDI3JhpxP@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Ahmed S. Darwish (33):
>   x86/cacheinfo: Validate cpuid leaf 0x2 EDX output
>   x86/cpu: Validate cpuid leaf 0x2 EDX output
>   x86/cpu: Properly parse leaf 0x2 TLB descriptor 0x63
>   x86/cpuid: Include linux/build_bug.h
>   x86/cpu: Remove unnecessary headers and reorder the rest
>   x86/cpu: Use max() for leaf 0x2 TLB descriptors parsing
>   x86/cpu: Simplify TLB entry count storage
>   x86/cpu: Remove leaf 0x2 parsing loop and add helpers
>   x86/cacheinfo: Remove unnecessary headers and reorder the rest
>   x86/cacheinfo: Use cpuid leaf 0x2 parsing helpers
>   x86/cacheinfo: Constify _cpuid4_info_regs instances
>   x86/cacheinfo: Align ci_info_init() assignment expressions
>   x86/cacheinfo: Standardize _cpuid4_info_regs instance naming
>   x86: treewide: Introduce x86_vendor_amd_or_hygon()
>   x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
>   x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
>   x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file
>   x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
>   x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
>   x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
>   x86/cacheinfo: Clarify type markers for leaf 0x2 cache descriptors
>   x86/cacheinfo: Use enums for cache descriptor types
>   x86/cpu: Use enums for TLB descriptor types
>   sizes.h: Cover all possible x86 cpu cache sizes
>   x86/cacheinfo: Use consolidated leaf 0x2 descriptor table
>   x86/cpu: Use consolidated leaf 0x2 descriptor table
>   x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
>   x86/cacheinfo: Separate intel leaf 0x4 handling
>   x86/cacheinfo: Extract out cache level topology ID calculation
>   x86/cacheinfo: Extract out cache self-snoop checks
>   x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
>   x86/cacheinfo: Introduce amd_hygon_cpu_has_l3_cache()
>   x86/cacheinfo: Apply maintainer-tip coding style fixes

Meta spelling comments for the entire series:

Please capitalize acronyms and names consistently in titles, changelogs 
and comments alike:

 s/cpu
  /CPU

 s/intel
  /Intel

When referring to headers, please write out their canonical names where 
appropriate - for example:

   - x86/cpuid: Include linux/build_bug.h
   + x86/cpuid: Include <linux/build_bug.h>

Thanks,

	Ingo

