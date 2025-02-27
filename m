Return-Path: <linux-kernel+bounces-536005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66080A47A67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5435D1892570
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6922A7FA;
	Thu, 27 Feb 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae2u9Q8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CB22A7E8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652492; cv=none; b=MR/XYsM+EqEiTdsRMmzKelluVaiRLF/aFGZ3T8BQ5Lmmw9KAFrghKyC28BWm6bbchPEoIuK73uY3igo8s4aFzupvLa74EdD0o8zie/XQdPNdSb9fgyKgtubVIXSH+RpDpoTk8nP6cI1+UGFZmYOMEIzHWSpvqFM8VrPP9fnbrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652492; c=relaxed/simple;
	bh=Xac24VrsdrBYAfE9ybZ7Brx1MyS7wGqE7VM58B4MrVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPbY/W8Gu7yrPW7QU7Hkyu4YaIKBUrPUvJaX8BWk8k+/5/Nl14XX7sGLglwzh+/O8RwD2Y+TShxC5pVWpJYoyRhINs0j+my6quHWon8203mPGqa743nG5yiPA15T3hcdd4eFWheUcDC5/kKFD+XpmZ/POtCfxNotbuqH/5i/EfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae2u9Q8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A938EC4CEE4;
	Thu, 27 Feb 2025 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740652491;
	bh=Xac24VrsdrBYAfE9ybZ7Brx1MyS7wGqE7VM58B4MrVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ae2u9Q8FXGE2QeIA24n/SV3p5ziIrf2/Uddd6wY5t8MZyal8x8IETd4YKjX218c/L
	 ENpjTugDAuff6a/WUKa1XFnq/48LKaxhCoc33JH7My+t2TUw6yFijYIraWRAZA9c1L
	 isWwP9imucaSrItoYP9E+HfRSoiJZBtdn5Cb9FcJEctwhBanxbhZyD1APla1F256dk
	 fKaUGcV0rR/UMnaBVo5MmWJsalwXA+tBI0nfuX9Ig9BC/l176kCexJoNJi3Tu9f4Yk
	 xYfKbl3cQbsmBarn1f5joGkUbLrwmTZGfxLoWOwk13GUY0E0MguFp9hCq/U+3LG5pj
	 OH0p+9U5xPgAw==
Date: Thu, 27 Feb 2025 11:34:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 00/10] x86: 32-bit cleanups
Message-ID: <Z8A_wAbpavm3Ydab@gmail.com>
References: <20250226213714.4040853-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>


* Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> While looking at 32-bit arm cleanups, I came across some related topics
> on x86 and ended up making a series for those as well.
> 
> Primarily this is about running 32-bit kernels on 64-bit hardware,
> which usually works but should probably be discouraged more clearly by
> only providing support for features that are used on real 32-bit hardware:
> 
> I found only a few 2003-era high-end servers (HP DL740 and DL760 G2)
> that were the only possible remaining uses of HIGHMEM64G and BIGSMP after
> the removal of 32-bit NUMA machines in 2014. Similarly, there is only
> one generation of hardware with support for VT-x.  All these features
> can be removed without hurting users.
> 
> In the CPU selection, building a 32-bit kernel optimized for AMD K8
> or Intel Core2 is anachronistic, so instead only 32-bit CPU types need
> to be offered as optimization targets. The "generic" target on 64-bit
> turned out to be slightly broken, so I included a fix for that as well.
> 
> Changes since v2:
> 
>  - Add a patch for EISA
>  - keep PHYS_ADDR_T_64BIT enabled for PAE kernels
>  - drop the Kconfig.platforms and CONFIG_X86_64_NATIVE patches for now
>  - improve changelog texts
> 
> Changes since v1:
> 
>  - Don't include patch to drop 32-bit KVM support for now
>  - Drop patch for 64-bit Silverlake support
>  - Drop 64-bit ISA level selection, only fix default
>  - Rework MID patch based on comments
>  - Add a patch to reorganize platform selection
>  - Add a patch to add -march=native compilation
> 
> 
> Arnd Bergmann (10):
>   x86/Kconfig: Geode CPU has cmpxchg8b
>   x86: drop 32-bit "bigsmp" machine support
>   x86: rework CONFIG_GENERIC_CPU compiler flags
>   x86: drop configuration options for early 64-bit CPUs
>   x86: remove HIGHMEM64G support
>   x86: drop SWIOTLB for PAE
>   x86: drop support for CONFIG_HIGHPTE
>   x86: document X86_INTEL_MID as 64-bit-only
>   x86: remove old STA2x11 support
>   x86: only allow EISA for 32-bit
> 
>  Documentation/admin-guide/kdump/kdump.rst     |   4 -
>  .../admin-guide/kernel-parameters.txt         |  11 -
>  Documentation/arch/x86/usb-legacy-support.rst |  11 +-
>  arch/x86/Kconfig                              | 156 +++---------
>  arch/x86/Kconfig.cpu                          |  97 ++------
>  arch/x86/Makefile                             |  16 +-
>  arch/x86/Makefile_32.cpu                      |   5 +-
>  arch/x86/configs/xen.config                   |   2 -
>  arch/x86/include/asm/page_32_types.h          |   4 +-
>  arch/x86/include/asm/pgalloc.h                |   5 -
>  arch/x86/include/asm/sta2x11.h                |  13 -
>  arch/x86/include/asm/vermagic.h               |   4 -
>  arch/x86/kernel/apic/Makefile                 |   3 -
>  arch/x86/kernel/apic/apic.c                   |   3 -
>  arch/x86/kernel/apic/bigsmp_32.c              | 105 --------
>  arch/x86/kernel/apic/local.h                  |  13 -
>  arch/x86/kernel/apic/probe_32.c               |  29 ---
>  arch/x86/mm/init_32.c                         |   9 +-
>  arch/x86/mm/pgtable.c                         |  27 +-
>  arch/x86/pci/Makefile                         |   2 -
>  arch/x86/pci/sta2x11-fixup.c                  | 233 ------------------
>  drivers/misc/mei/Kconfig                      |   2 +-
>  22 files changed, 66 insertions(+), 688 deletions(-)

Sweet! I have applied your series to tip:x86/cpu with some minor tweaks 
and a conflict resolution for pending work in x86/mm. Let's see if 
anyone complains about the removal of these obsolete features.

Thanks,

	Ingo

