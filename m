Return-Path: <linux-kernel+bounces-239465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4289926066
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA28A1C22871
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27576176AB5;
	Wed,  3 Jul 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT8dH5W2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA65143C6B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009997; cv=none; b=dxTeXYX7ZewK0rE0YlqwSpekLCwgKO/tuzGnb1C54GxmrU7QPhxQaT++udqGIdZ+pkP4M/v7xZFnmJF1DPiCwLevSV4kjpU5udKLaVciJ8Un6eAno8clhtktbvtL4NlP6E1UFQe/cEUEKlaF60z5YQeG2LIhpjQUtSpK2dXf12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009997; c=relaxed/simple;
	bh=IRmYngQr/XgUdsgiEsF8Dd45T99Ru3DiQpjGTuxdYfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmYtWvkfCxURC7li2dxMAUJIKBeK3KEtYS6mjIPO2X1VuV9khBlRRTa/Kf/LAIl5qdUx2RmRi/xrhx10zLxalcPlMHzS1AxjGiE5u8OllPQx6oevIgb9bb8zv411r9wBBRNqbAE9Oyw8iisiaT/DO3D4sxRkq+98kjY416rab+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT8dH5W2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720009996; x=1751545996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRmYngQr/XgUdsgiEsF8Dd45T99Ru3DiQpjGTuxdYfs=;
  b=YT8dH5W2ZpEYhmaU611bzaPUafXHaFhhEh0LeVDZNbMg34MjVIrhAjzp
   ZWw3hIi3xLuHOkYtzTb/6/uu7OjKlrg+2+Eq61DwhU/gdPgtxY1xfUcNv
   cz9NV8J9VTrJyg7gfyxfgO3ABPuY5aNdBwg3AOHtJYRKJg4UB5ThRnUTr
   PhOUxLs1xpc4btFmmgu12ATbUyrtrAvfGtLVakV5o8tEmMpk0CqW3uL0q
   ZV3oNnphiMHZTuq895syxVks8kYf3pLPjhOd0zGwG3cWmouuAsg8cl7o7
   5qfknRLjphSr7am0vgQ5Rb24W5PPMpYHpJ3ILgXCp6ljXqDlzoWtXixo7
   w==;
X-CSE-ConnectionGUID: rANMPbkITuaSJ7PfMpOSbg==
X-CSE-MsgGUID: ECuCmNwRRHOMl2thJQGrWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="42663283"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="42663283"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 05:33:12 -0700
X-CSE-ConnectionGUID: YpkvDHMORn6qCSfJIRRgvA==
X-CSE-MsgGUID: Gnr66Cp8SbiGVxLCtm5Dpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46019733"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jul 2024 05:33:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 36B5A194; Wed, 03 Jul 2024 15:33:09 +0300 (EEST)
Date: Wed, 3 Jul 2024 15:33:09 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 4/4] x86/tdx: Enable CPU topology enumeration
Message-ID: <f6b4wziuumuorfp3dbkrqc5kzuv3linrbreptpiw6iwnf3u2rb@ttq3rt6lxntv>
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-5-kirill.shutemov@linux.intel.com>
 <3b28af5e-1274-411e-9536-9ad964e0b25f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b28af5e-1274-411e-9536-9ad964e0b25f@intel.com>

On Wed, Jul 03, 2024 at 12:17:04AM +0800, Xiaoyao Li wrote:
> On 6/24/2024 7:41 PM, Kirill A. Shutemov wrote:
> > TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
> > generates a #VE when accessing topology-related CPUID leafs (0xB and
> > 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
> > topology. In practice, this means that the kernel can only boot with a
> > plain topology. Any complications will cause problems.
> > 
> > The ENUM_TOPOLOGY feature allows the VMM to provide topology
> > information to the guest. Enabling the feature eliminates
> > topology-related #VEs: the TDX module virtualizes accesses to
> > the CPUID leafs and the MSR.
> > 
> > Enable ENUM_TOPOLOGY if it is available.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/coco/tdx/tdx.c           | 27 +++++++++++++++++++++++++++
> >   arch/x86/include/asm/shared/tdx.h |  2 ++
> >   2 files changed, 29 insertions(+)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index ba3103877b21..f6e48119d6fd 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -249,6 +249,32 @@ static void disable_sept_ve(u64 td_attr)
> >   	return;
> >   }
> > +/*
> > + * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs (0xB and
> > + * 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID #VEs.
> > + * In practice, this means that the kernel can only boot with a plain topology.
> > + * Any complications will cause problems.
> > + *
> > + * The ENUM_TOPOLOGY feature allows the VMM to provide topology information.
> > + * Enabling the feature  eliminates topology-related #VEs: the TDX module
> > + * virtualizes accesses to the CPUID leafs and the MSR.
> > + *
> > + * Enable ENUM_TOPOLOGY if it is available.
> > + */
> > +static void enable_cpu_topology_enumeration(void)
> > +{
> > +	u64 configured;
> > +
> > +	/* Has the VMM provided a valid topology configuration? */
> > +	tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED, &configured);
> > +	if (!configured) {
> > +		pr_err("VMM did not configure X2APIC_IDs properly\n");
> > +		return;
> > +	}
> > +
> > +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
> > +}
> > +
> >   static void tdx_setup(u64 *cc_mask)
> >   {
> >   	struct tdx_module_args args = {};
> > @@ -280,6 +306,7 @@ static void tdx_setup(u64 *cc_mask)
> >   	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
> >   	disable_sept_ve(td_attr);
> > +	enable_cpu_topology_enumeration();
> >   }
> >   /*
> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index fecb2a6e864b..89f7fcade8ae 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -23,12 +23,14 @@
> >   #define TDCS_CONFIG_FLAGS		0x1110000300000016
> >   #define TDCS_TD_CTLS			0x1110000300000017
> >   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
> 
> The ID for TDCS_NOTIFY_ENABLES I read from TDX spec is
> 
> 	0x9110000300000010

> > +#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
> 
> and
> 	0x9110000000000019
> 
> for TOPOLOGY_ENUM_CONFIGURED.
> 
> Both version of them can work actually. But I'm curious where did you get
> them? just an old version of spec?

TDX 1.0 spec had the old value. Newer spec defined meaning to previously
reserved bits. The changed bits define element size and context code.
These bits are ignored on read/write by TDX module.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

