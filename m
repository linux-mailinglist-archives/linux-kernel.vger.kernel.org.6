Return-Path: <linux-kernel+bounces-413986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696639D2180
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146B1B21E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46A197556;
	Tue, 19 Nov 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cftGnOEz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6D1A28C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004475; cv=none; b=hmE0nIxAP4aBL4dDGBHbUVbKn9d0fszX2nyAh8BH3EcppFVMoUyR/QjImyWkb3xreVTcm2YG/w0jEe+bi0sqSw7RNsJPuTQlRjLYkCvgIWE0WRnJE09SKCzOm4upWLnupZJpedlG224piRGIZFhh4B5bOi4pUgO7HEaXbPirdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004475; c=relaxed/simple;
	bh=ATmfCzclHdM2YT75Oaruucbf85ygBbbHlKeZnhLFY48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZbxzGgONuixFRlucsXYSw8DCGbB1e7T/9N0qtquOHEiJFSUwXuhKI6FDiGjltsV0ArDA1sYPCKYxRdQHqQnlXk26rn4vKHSOyOwQ5XONX2y4j5lEtvbfRTY0STkPTIoH7YhYd0JeAFIx/yUFyYWJh1sELFFKv6HNdAahAlmwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cftGnOEz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732004473; x=1763540473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ATmfCzclHdM2YT75Oaruucbf85ygBbbHlKeZnhLFY48=;
  b=cftGnOEzq0/IP/9IIP9ORo7uH+T3ON5Y+DMuNQQBlmy9EERaW+rSQr58
   LfSYszLW6prp9LS/9+c9zoCjJ2PleB0wHYc0/KNO3v0qdYWIPS1dWewUN
   nROJRBw20eJWDOfXx+RD+WXxacmwVzF8IuPwL2WekeBv40m3y/0w0KWzQ
   tIqb7xZ5dacRJrHps5hRDP3dn23PrghrT306mB1D7WkcCm+iOLaJueg0/
   esW9Ay0zj1yVpf4eWYfAd52BQexqH1304fEZR9KwQ8VhPgf1/9vgEKo2/
   DTBwXsTaADiCGi54/QCMw+wWHalkRDD43owiSAmjnGCZB3Ks03CCi4dAo
   Q==;
X-CSE-ConnectionGUID: Zzl3uczxQf+daaelGsS+3w==
X-CSE-MsgGUID: h77dCUM7Syir9/1CdDvD4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42619273"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="42619273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 00:21:13 -0800
X-CSE-ConnectionGUID: LAnQUuu3QsmhihWdYaL+uA==
X-CSE-MsgGUID: SmMoEHkuRFuaFU8wofzIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89894414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2024 00:21:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EFB4B1C4; Tue, 19 Nov 2024 10:21:05 +0200 (EET)
Date: Tue, 19 Nov 2024 10:21:05 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Samuel Holland <samuel.holland@sifive.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
 <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>

On Mon, Nov 18, 2024 at 05:46:16PM +0100, Borislav Petkov wrote:
> On Mon, Oct 21, 2024 at 01:57:23PM +0300, Kirill A. Shutemov wrote:
> > It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.
> 
> Do TDX guests even need EISA?
> 
> "The EISA bus saw limited use between 1988 and 1995 when it was made obsolete
> by the PCI bus."
> 
> Sounds like no to me.
> 
> We usually simply stop coco guests from touching such legacy ranges:
> 
> f30470c190c2 ("x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP")
> 
> so can you do that too?

Sure, we can workaround every place that touches such ranges. Or we can
address problem at the root and make creating decrypted/shared mappings
explicit.

Such mappings have both functional (as we see here) and security
implications (VMM can manipulate the guest memory range). We should not
create decrypted mappings by default on legacy interfaces.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

