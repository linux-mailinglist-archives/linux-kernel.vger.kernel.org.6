Return-Path: <linux-kernel+bounces-244336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4416592A2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC561C21125
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2A78C73;
	Mon,  8 Jul 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cL/b5PO0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5C80624
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442081; cv=none; b=WLuBxVkYwAU9lAJ+JFr4mU6XFWyngARd0heihDqQlCap5rDK01fA8I4VLF+6kCm+CuEDrdBvFP5a2Yrb+BgVX1VoAwQI70BnzZuCS/WfOBKaZsTb+YCTmmsIdEy/9oaDwG0WdShYWgctNmmmkQJsf5yTN41DKhTQkLtmSACPH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442081; c=relaxed/simple;
	bh=WMj07N05UMWmeIXTX/HCnph9LPCAByFEaqK3k+OW6BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES7sfPTms77HLTGIKpkdvOE6N9tUZR57Pt6BjaA28UYXuZ+aFy2PraWkPJau8IyEHHM9FaNSftNVNwWJew2eAMLEfBDlMnk0f7uBvcXKEMRdjMmvFPVYbWYAZb0CEX+2kQcCMYOSfpHZ43ggiNgAyXwmcU2L5MO4S/e3vx1Hh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cL/b5PO0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720442079; x=1751978079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMj07N05UMWmeIXTX/HCnph9LPCAByFEaqK3k+OW6BE=;
  b=cL/b5PO0CRuVYilLBrdF33dl+Fh5lq+Q0uvye/je3OusnOMnZ9h6v+6F
   tDdOkPZR+Zn5m9PsLgNtbszKHNF9Ep78ANyG579EtZXSQ7VqPlg+2nFFk
   ynw1KIe7bIcsEHdlYMeb0zXCpSlxHFHsI/nMK6ikdY7vEMARxKR2Rhz2V
   JXT7JtRBAhKnZlC2zJd9nZ+DB+5DMUaHRavjERdPy+f6Ym5Kt2CIOKqC9
   Wis3zxylUXOnFi2/RAASOBDYD5G+nQoKCifZ355OF7jcULWCdymEOaG8r
   5NiEupfXhx5kTvD1inW2R1ugyVzXQhOHiUIva7KuHRfWAtBNh8oT+6Y78
   g==;
X-CSE-ConnectionGUID: eniXV3gGSu+xt5ATB+6xKQ==
X-CSE-MsgGUID: AtPQ7Fz+T/mQbExJXWXdRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17781148"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17781148"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:34:39 -0700
X-CSE-ConnectionGUID: WqXTWIFRQj+MsUiEOfvuvg==
X-CSE-MsgGUID: mJLbFBfISW6lNqfPSZ3eBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47367020"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 08 Jul 2024 05:34:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D5F4E1AC; Mon, 08 Jul 2024 15:34:34 +0300 (EEST)
Date: Mon, 8 Jul 2024 15:34:34 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>

On Thu, Jul 04, 2024 at 02:48:49PM +0000, Dexuan Cui wrote:
> > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > [...]
> > > Hi Kirill, Dave,
> > > Do you think if it's a good idea if I post a new patch that combines
> > >     e1b8ac3aae58 ("x86/tdx: Support vmalloc() for
> > > tdx_enc_status_changed()")
> > > and
> > >     your patch "[PATCH] x86/tdx: Fix crash on kexec"?
> > 
> > Yeah, IIUC, that's what Borislav wanted. After proper testing.
> > 
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
> 
> Hi Kirill,  
> I tested the 2 patches for a Linux VM on Hyper-V and all worked fine.
> 
> When you finish testing, please let me know so that I can post
> a combined patch; alternatively, it would be better if you can help post
> a combined patch.

Go ahead, post the new version.

Borislav, could you drop the original patch from tip tree?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

