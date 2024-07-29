Return-Path: <linux-kernel+bounces-265646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526093F400
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7730C1F2295E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FEC145FFB;
	Mon, 29 Jul 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QNpG3twY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9CF145FE1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252395; cv=none; b=QkTvDNfTVZekWMYL31zVqyv1z9avcv3MsutuUxmADtKknImFZ5srytFGAd/bs4uxGiHymvX7bmBdzqArFz3j3ABsBJFbgFSwBl8tGz2uzJMI4O9wB6WXAwuIsL/vF1j5pIjJ/Knh2s19r0VCYfLyVJ1CSQ7ZEaAKNHN+wTgqtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252395; c=relaxed/simple;
	bh=8MkwynnXFVbjdZHNToOy7lnR3zTzpWQbyXZtkGx7KBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmHZdl2r5FCX97pHg0keMegzaOU2Q6err74W4OESGC3iYUkAB+UEN756DokAMk27n8WyofRgrkSUtIRL28vGk5NEtUMKVpcvWhZI5LMJAuN2tDmt3koZxYFdZ6KbcuXq5FGV8KIMB8O4LySYtCQZ0FKnpNlT5DJkQ0VqqaCz2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QNpG3twY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D693B40E0205;
	Mon, 29 Jul 2024 11:26:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iqTEXWE2H-NC; Mon, 29 Jul 2024 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722252386; bh=GuDXkXCGhTX08yqWrA8jRr3VoIg3kntTZ1rboi0IwCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNpG3twYuf/Au+We0UtQefoCXFOMzuv5h4fOhlZV3k/5xGO0ArNOYwOjWnodKcAqY
	 plpt1iCwkcnW5dlCaGFcSqILaNCZJydbAFlsMDJ2hXcpWbD24pl+MzplicWIH8N+b9
	 9AKD2ORo3DKAS1Pf31lg4eILQHzo3uw2wFd5RGaPHHv2ZtAcZRBcTGn6qAkKj2j6u/
	 NfBfJoL5JZq7kxoD7aJLghMOe4NZVvwNqYq1iG4F4YB0T1liWlJpWYB/1sCtoZLlRT
	 DasnnEfffqVWD+RJjZGsXM/NAw4ugWptzqTk4whR2TbPJCjTnZmPQR+0F7RIR6xZTI
	 DI4trQIqQbg5wB8pjYPggvhL0L1ti7M0z+9h4NDnybmWMjcZPhBwrvCwI2AFj6mZ75
	 c6SbLHDykOfX6ytldGk1UymhHvBBt4P71yxr2q1cLqHHeNkNGjIYgKGP6UU2JWqEiT
	 fbzTIfezXx5iLfZbyVY4AZo4qdD8KSBBvHQC0+zlfjKpJdtKiGxe/slqPHBC7E9WH2
	 VPf8yEIC1w5jc+8H6HQ5HkUxbXWIEr9OlrUfAzDxQaQ+GDamvfarQBclNm8mhO+2XI
	 B9C1L/rc4vn/+2kn3fOaG1s0PmgmDMDJkXH6dtrk8aVZnrINbpcoLjW3yhj4GZpE6x
	 lBbrh4YQspFC0afybKHLAnJY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4DEA40E01BB;
	Mon, 29 Jul 2024 11:26:19 +0000 (UTC)
Date: Mon, 29 Jul 2024 13:26:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/microcode 1/1]
 arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>
References: <202407291815.gJBST0P3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202407291815.gJBST0P3-lkp@intel.com>

+ Nathan.

On Mon, Jul 29, 2024 at 07:04:51PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
> head:   94838d230a6c835ced1bad06b8759e0a5f19c1d3
> commit: 94838d230a6c835ced1bad06b8759e0a5f19c1d3 [1/1] x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID
> config: i386-buildonly-randconfig-001-20240729 (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>      714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/cpu/microcode/amd.c:720:31: note: uninitialized use occurs here
>      720 |         return cache_find_patch(uci, equiv_id);
>          |                                      ^~~~~~~~
>    arch/x86/kernel/cpu/microcode/amd.c:714:2: note: remove the 'if' if its condition is always true
>      714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/cpu/microcode/amd.c:706:14: note: initialize the variable 'equiv_id' to silence this warning
>      706 |         u16 equiv_id;
>          |                     ^
>          |                      = 0
>    1 warning generated.
> 
> 
> vim +714 arch/x86/kernel/cpu/microcode/amd.c
> 
>    701	
>    702	static struct ucode_patch *find_patch(unsigned int cpu)
>    703	{
>    704		struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
>    705		u32 rev, dummy __always_unused;
>    706		u16 equiv_id;
>    707	
>    708		/* fetch rev if not populated yet: */
>    709		if (!uci->cpu_sig.rev) {
>    710			rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
>    711			uci->cpu_sig.rev = rev;
>    712		}
>    713	
>  > 714		if (x86_family(bsp_cpuid_1_eax) < 0x17) {
>    715			equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
>    716			if (!equiv_id)
>    717				return NULL;
>    718		}
>    719	
>    720		return cache_find_patch(uci, equiv_id);
>    721	}
>    722	

That's a false positive, I think.

clang can't see that equiv_id is used in cache_find_patch() ->
patch_cpus_equivalent() *only* in the

	if (x86_family(bsp_cpuid_1_eax) < 0x17)

case.

And that case is handled properly in this function.

So, unless I'm missing something else, it's a good thing this warning is
behind a W=1. Keep it there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

