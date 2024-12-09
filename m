Return-Path: <linux-kernel+bounces-438088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEF9E9CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038281886F37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DB14F9F8;
	Mon,  9 Dec 2024 17:09:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EA143871;
	Mon,  9 Dec 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764159; cv=none; b=niiyLoH9SfL2hm6vTIh3ejU6erG6aJVdCms0xd1+W2ffnck1PIzVwZZsLeVy3mmA8d0nxxdLtyDD2C0rmnUUp8QNIBZ8qIuIVaqPDo6+I28M8tAcDDY/RwPE5LnRrSaeKsA4iRulytuhBEJubhcDgzhUXXh/fjA8S2FbCiUgv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764159; c=relaxed/simple;
	bh=SMJhPdGNVxyVAtXdF/r3y6UqQbvyhAed0k2tzpkNYJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVmN/alUVWpSn1X/sSbSdcqE/aCgGNjN4m/o1Jl+zsALtoEsyuO5Ox3fvcL52WT3PMa8irNTM/x/EBqYU8U+FuOpvx2Y5RoWTPl11vOVRy/IgzYJqrzmN4ZUVzgmM/jnqqiCwND6C6cickVAAi9WsOaIKWQzhb7GV/XoAsrp0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C016C4CED1;
	Mon,  9 Dec 2024 17:09:16 +0000 (UTC)
Date: Mon, 9 Dec 2024 17:09:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
	Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on
 EXECMEM
Message-ID: <Z1ckOoPMSXfNdrXd@arm.com>
References: <20241209031251.515903-1-anshuman.khandual@arm.com>
 <202412092048.tTzJ5szH-lkp@intel.com>
 <f492ac51-9dad-4b18-8cd4-81dc236b3162@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f492ac51-9dad-4b18-8cd4-81dc236b3162@arm.com>

On Mon, Dec 09, 2024 at 07:43:32PM +0530, Anshuman Khandual wrote:
> On 12/9/24 18:06, kernel test robot wrote:
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on akpm-mm/mm-everything]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-execmem-Make-ARCH_WANTS_EXECMEM_LATE-depend-on-EXECMEM/20241209-111533
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20241209031251.515903-1-anshuman.khandual%40arm.com
> > patch subject: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on EXECMEM
> > config: arm64-kismet-CONFIG_ARCH_WANTS_EXECMEM_LATE-CONFIG_ARM64-0-0 (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/config)
> > reproduce: (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202412092048.tTzJ5szH-lkp@intel.com/
> > 
> > kismet warnings: (new ones prefixed by >>)
> >>> kismet: WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE when selected by ARM64
> >    WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE
> >      Depends on [n]: EXECMEM [=n]
> >      Selected by [y]:
> >      - ARM64 [=y]
> 
> Although above mentioned config here has CONFIG_ARCH_WANTS_EXECMEM_LATE=y
> and CONFIG_EXECMEM=n (actually absent), could that really happen though ?
> 
> Tried making CONFIG_EXECMEM=n (rather deselecting) but that did now allow
> setting CONFIG_EXECMEM=n, it always remained set. Reverting this patch i.e
> the current behaviour is also the same (CONFIG_EXECMEM always remains set).
> 
> select ARCH_WANTS_EXECMEM_LATE if EXECMEM
> 
> Above statement seems to be selecting EXECMEM as well but the intent seems
> to be a dependency check instead! OR arch selection for a config brings in
> all its dependencies as well.
> 
> If the selection is always, should this change be like the following ?
> 
> config ARCH_WANTS_EXECMEM_LATE
>  	bool
> 	selects EXECMEM

This is wrong. What ARCH_WANTS_EXECMEM_LATE means is that, _if_ EXECMEM
is enabled, the arch code require its late initialisation. Currently for
arm64 EXECMEM is selected by KPROBES, BPF_JIT and MODULES. So if you
don't have any of these on, you don't need EXECMEM either, no point in
selecting it above just because arm64 wants a specific behaviour (late
initialisation) for EXECMEM.

If you do want a patch for this, I think for arm64 we simply need to
select ARCH_WANTS_EXECMEM_LATE unconditionally. Not much use in having
any dependencies really, it just adds to the clutter. And don't change
the core Kconfig either.

-- 
Catalin

