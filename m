Return-Path: <linux-kernel+bounces-563752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAFA647A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DC8188CB41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D2622422E;
	Mon, 17 Mar 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLIMWfPn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA102E3373
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204332; cv=none; b=WJLPwrpBZS67NEWqpe8Geshl5Uh4ge8nM8ck2e0mCAL/OzvApOLk5OXx3yjUcM6T6vXJGkidm2pBeWNjMelLPRb78qj6f3fn3dutw4BvQxeyJFKS8wWmc2I32vpbvmkxnt0sLM6+tIdaoW0MtwEXCg/38HJ+9mUvvceaS6+5H4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204332; c=relaxed/simple;
	bh=+qrWDbAJm/iqBdAe2aaLbmX+xfHnHLSa4gWCQ4lNyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPCLTybwjTnOLkF9BxneWzxeg8YJ38hKOXFUxwriHBq0uisGW3ojlXs2+9KgWPblyQD29Ju2UPzOu0llNMJ82DT/mTuWUYGdD0RWbvM9OgQ9Ah/J9Re90nOyqzIhGJ8CylhVYVdJvQHy6hEVLOSoRin3Eb0tEqQ+Atxq66oQHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLIMWfPn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742204330; x=1773740330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qrWDbAJm/iqBdAe2aaLbmX+xfHnHLSa4gWCQ4lNyNk=;
  b=NLIMWfPnmZ3iMNHl6J79EqQdIhaIudIMnBeIZA0DimkC0T8bVkRKJRMV
   l58ILRt81UqQk8hWN6uCL0fbu8wP9Kxy9E6BCljEmukPpabTfYTcPa7r0
   dav7XkZ4KYUyHudrD/lcRkjcGrRyV+gOlaionGOKbXFjQAfWEETrtV3oQ
   x0RuiCu/z2lTL9rkt7AM0TEt0BBBdOcQo28gOOZ5bijEo7+pSHAjLJIKG
   Gi6mEUXrvMHNYL3d91nkeRvu5iiV/1lITRiiqIL5d6fUCyD3XVXQOYNtu
   GJ1zPahp9DZbYgjioLjV4RqOs6MPqM6A9qdJeFPt95TvrK9FHJXXUU4Xw
   Q==;
X-CSE-ConnectionGUID: u0RSTSvWTguov5tPAzdnhw==
X-CSE-MsgGUID: ahz9kUZBReitHHA2EP0fSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="68648372"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="68648372"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 02:38:50 -0700
X-CSE-ConnectionGUID: E9s02y1DRiOglzuhXdD+tg==
X-CSE-MsgGUID: +muwr0WRTi+4njrsnJEGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122840143"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 17 Mar 2025 02:38:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 24C071D8; Mon, 17 Mar 2025 11:38:45 +0200 (EET)
Date: Mon, 17 Mar 2025 11:38:45 +0200
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Gladkov <legion@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Alexey Gladkov <alexey.gladkov@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Joerg Roedel <jroedel@suse.de>, Juergen Gross <jgross@suse.com>, Larry.Dewey@amd.com, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 1/3] x86/tdx: Make TDX metadata available via SYSFS
Message-ID: <nvnjhx235xbsrnq3t6zbkgogsdizbigrlgqyx6muyj6k2g34gq@zzn6bqvoha45>
References: <cover.1741952958.git.legion@kernel.org>
 <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
 <67d4bee77313a_12e31294c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d4bee77313a_12e31294c7@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Mar 14, 2025 at 04:42:31PM -0700, Dan Williams wrote:
> Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> > Expose the TDX module information to userspace. The version information
> > is valuable for debugging, as knowing the exact module version can help
> > reproduce TDX-related issues.
> > 
> > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > ---
> >  arch/x86/Kconfig                  |  1 +
> >  arch/x86/include/asm/shared/tdx.h |  2 +
> >  arch/x86/include/asm/tdx.h        | 12 +++++
> >  arch/x86/virt/vmx/tdx/tdx.c       | 74 +++++++++++++++++++++++++++++++
> >  4 files changed, 89 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index be2c311f5118..516f3539d0c7 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1986,6 +1986,7 @@ config INTEL_TDX_HOST
> >  	depends on CONTIG_ALLOC
> >  	depends on !KEXEC_CORE
> >  	depends on X86_MCE
> > +	select SYS_HYPERVISOR
> >  	help
> >  	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
> >  	  host and certain physical attacks.  This option enables necessary TDX
> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index 606d93a1cbac..92ee9dfb21e7 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -18,6 +18,8 @@
> >  #define TDG_MEM_PAGE_ACCEPT		6
> >  #define TDG_VM_RD			7
> >  #define TDG_VM_WR			8
> > +/* TDG_SYS_RD is available since TDX module version 1.5 and later. */
> > +#define TDG_SYS_RD			11
> >  
> >  /* TDX attributes */
> >  #define TDX_ATTR_DEBUG_BIT		0
> > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > index e6b003fe7f5e..95d748bc8464 100644
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -31,6 +31,18 @@
> >  #define TDX_SUCCESS		0ULL
> >  #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
> >  
> > +/*
> > + * TDX metadata base field id, used by TDCALL TDG.SYS.RD
> > + * See TDX ABI Spec Global Metadata Fields
> > + */
> > +#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
> > +#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
> > +#define TDX_SYS_UPDATE_FID		0x0800000100000005ULL
> > +#define TDX_SYS_INTERNAL_FID		0x0800000100000006ULL
> > +#define TDX_SYS_BUILD_DATE_FID		0x8800000200000001ULL
> > +#define TDX_SYS_BUILD_NUM_FID		0x8800000100000002ULL
> > +#define TDX_SYS_FEATURES0_FID		0x0A00000300000008ULL
> > +
> >  #ifndef __ASSEMBLY__
> >  
> >  #include <uapi/asm/mce.h>
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index f5e2a937c1e7..89378e2a1f66 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1869,3 +1869,77 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
> >  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
> >  }
> >  EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
> > +
> > +#ifdef CONFIG_SYSFS
> > +#define TDX_SYSFS_ATTR(_field, _name, fmt)				\
> > +static ssize_t _name ## _show(						\
> > +	struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> > +{									\
> > +	u64 value = 0;							\
> > +	read_sys_metadata_field(_field, &value);			\
> > +	return sprintf(buf, fmt, value);				\
> > +}									\
> > +static struct kobj_attribute _name ## _attr = __ATTR_RO(_name)
> > +
> > +TDX_SYSFS_ATTR(TDX_SYS_MINOR_FID, minor, "%lld\n");
> > +TDX_SYSFS_ATTR(TDX_SYS_MAJOR_FID, major, "%lld\n");
> > +TDX_SYSFS_ATTR(TDX_SYS_UPDATE_FID, update, "%lld\n");
> > +TDX_SYSFS_ATTR(TDX_SYS_BUILD_NUM_FID, build_num, "%lld\n");
> > +TDX_SYSFS_ATTR(TDX_SYS_BUILD_DATE_FID, build_date, "%lld\n");
> > +TDX_SYSFS_ATTR(TDX_SYS_FEATURES0_FID, features0, "%llx\n");
> > +
> > +static struct attribute *version_attrs[] = {
> > +	&minor_attr.attr,
> > +	&major_attr.attr,
> > +	&update_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group version_attr_group = {
> > +	.name = "version",
> > +	.attrs = version_attrs,
> > +};
> > +
> > +static struct attribute *properties_attrs[] = {
> > +	&build_num_attr.attr,
> > +	&build_date_attr.attr,
> > +	&features0_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group properties_attr_group = {
> > +	.name = "properties",
> > +	.attrs = properties_attrs,
> > +};
> > +
> > +__init static int tdh_sysfs_init(void)
> > +{
> > +	struct kobject *tdx_kobj;
> > +	int ret;
> > +
> > +	if (!hypervisor_kobj)
> > +		return -ENOMEM;
> > +
> > +	tdx_kobj = kobject_create_and_add("tdx", hypervisor_kobj);
> 
> So this "/sys/hypervisor" proposal is clearly unaware of some other
> discussions that have been happening around sysfs ABI for TEE Security
> Managers like the PSP or TDX Module [1]. That PCI/TSM series discusses
> the motivation for a bus/class + device model, not just raw hand-crafted
> kobjects.
> 
> My other concern for hand-crafted kobjects is that it also destroys the
> relationship with other existing objects. A /sys/hypervisor/$technology
> is awkward when ABI like Documentation/ABI/testing/sysfs-driver-ccp
> already exists.
> 
> So, no, I am not on board with this proposal. There are already patches
> in flight to have TDX create a 'struct device' object that plays a
> similar role as the PSP device object. For any potential common
> attributes across vendors the proposal is that be handled via a typical
> sysfs class device construction that links back to the $technology
> device. That "tsm" class device is present in the PCI/TSM series [1].
> 
> [1]: http://lore.kernel.org/174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com

Dan, could you elaborate on what is actual proposal? I am not sure I
understand what 'struct device' can have info on TDX module version be
attached to it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

