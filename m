Return-Path: <linux-kernel+bounces-563997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A09A64BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7683A3EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085923957E;
	Mon, 17 Mar 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmY5iSfG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1F238168
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209427; cv=none; b=Tt4XmlCsClj4fP5KCo31JleV3cnpG+vIy2GhPviMosqlYJG97FUAyGP5ftw9gnalX+Uf5FUyYyrcettCClryECh0l5eSdS1HJ0pBscFREe88Y4Z5oSlPlc9gSWJUDESkSoqcA0ocf9UvpOetWHmi4b7OsHtRjwuniuJtieYZB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209427; c=relaxed/simple;
	bh=Ek44iPcH0mU0ldu7ybADHXzeIYNkQ+rgyIE+nEzrKO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK4nDqRJQtaqNei84/tP13nKpxfMmNalovkEjEoOc0EmBnZeS96zH4gJSA0C+c3gtjW03v2Li+NH4K12Jvo2xfd4GT9DlO0qC+knOj9xMgwM9okPQjn3DRkm0eLw323M/gvndtcY4gjEhsXxhTo6hri9k2rMGZyZewIzyOoZ35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmY5iSfG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742209426; x=1773745426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ek44iPcH0mU0ldu7ybADHXzeIYNkQ+rgyIE+nEzrKO8=;
  b=VmY5iSfG09+3cbudWOvwpzaNip2H54tf3KAmbpbLjxwoyUf85ryT0dDH
   ycKBIIOyFHrWcg52HxmFM4hhWGwrl/JGGb3pF0aKuRnOS/1PKjzoFxbbn
   nwQ0BYmyMQ1L1oD9cbezGsXxkqjYydTkHNPJD20DZcKjltaNTETLugHNA
   HO6ejZGnJQA/pamyJ3niRzdlehTbKG4jnTd69vU8wrXXi5LcpqPiQHmZ5
   3KPse7OiY2bSEoZVPIOc4k75l+6gdcM3GbT2cEESuZDrKAqwX6ALmBImH
   nl+HQ9PP+88bXYRLlOWAqZ9HicNGsSDMeEHpvP09w6UUwYWNs53GLNW2a
   w==;
X-CSE-ConnectionGUID: mOcXCD+/QJWhuam/SFI/XQ==
X-CSE-MsgGUID: dBGQeA24STKNu63v9yuNgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43401112"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43401112"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 04:03:45 -0700
X-CSE-ConnectionGUID: DY8PXfBRQJyZmyE9yjHiww==
X-CSE-MsgGUID: DJ5WOLy3THOApnBGX7AhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122647420"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Mar 2025 04:03:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0DD431D8; Mon, 17 Mar 2025 13:03:38 +0200 (EET)
Date: Mon, 17 Mar 2025 13:03:38 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Huang, Kai" <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <uchg74rtpcpwlkxgqww2n6nh23p4ouaswqc737xy7y6rqzowtb@pbf4whogx2s4>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
 <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
 <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f74db2c44ee7ef8ec127b5135ff80885c21c6836.camel@infradead.org>

On Mon, Mar 17, 2025 at 09:27:16AM +0000, David Woodhouse wrote:
> On Thu, 2024-04-04 at 12:32 +0300, Kirill A. Shutemov wrote:
> > On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> > > 
> > > 
> > > On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > > > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> > > > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > > > > > > to #VE.
> > > > > > 
> > > > > > Will we consider making it more safe and compatible for future to guard
> > > > > > against X86_FEATURE_MCE as well?
> > > > > > 
> > > > > > If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> > > > > > not be fixed1.
> > > > > 
> > > > > Good point.
> > > > > 
> > > > > I guess we can leave it clear if it was clear. This should be easy
> > > > > enough. But we might want to clear even if was set if clearing is allowed.
> > > > > 
> > > > > It would require some kind of indication that clearing MCE is fine. We
> > > > > don't have such indication yet. Not sure we can reasonably future-proof
> > > > > the code at this point.
> > > > > 
> > > > > But let me think more.
> > > > 
> > > > I think I will go with the variant below.
> > > > 
> > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > index 56cab1bb25f5..8e2037d78a1f 100644
> > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > @@ -5,6 +5,8 @@
> > > >    */
> > > >   #include <linux/linkage.h>
> > > > +#include <linux/stringify.h>
> > > > +#include <asm/alternative.h>
> > > >   #include <asm/page_types.h>
> > > >   #include <asm/kexec.h>
> > > >   #include <asm/processor-flags.h>
> > > > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > >   	 * Set cr4 to a known state:
> > > >   	 *  - physical address extension enabled
> > > >   	 *  - 5-level paging, if it was enabled before
> > > > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > > > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> > > 
> > > Nit:  Perhaps we can just call out:
> > > 
> > > 	Clearing MCE is not allowed if it _was_ enabled before.
> > > 
> > > Which is always true I suppose.
> > 
> > It is true now. Future TDX will allow to clear CR4.MCE and we don't want
> > to flip it back on in this case.
> 
> And yet v12 of the patch which became commit de60613173df does
> precisely that.
> 
> It uses the original contents of CR4 which are stored in %r13 (instead
> of building a completely new set of bits for CR4 as before). So it
> would never have *cleared* the CR4.MCE bit now anyway... what it does
> is explicitly *set* the bit even if it wasn't set before?
>
> This is what got committed, and I think we can just drop the
> ALTERNATIVE line completely because it's redundant in the case that
> CR4.MCE was already set, and *wrong* in the case that it wasn't already
> set?

But we AND R13 against $(X86_CR4_PAE | X86_CR4_LA57). We will lose MCE if
drop the ALTERNATIVE.

And we don't want MCE to be enabled during kexec for !TDX_GUEST:

https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com/

I think we should patch AND instruction to include X86_CR4_MCE on
TDX_GUEST:

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d8863e57f..f6c552a39815 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -148,8 +148,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
 	 * PAE is always set in the original CR4.
 	 */
-	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
-	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	ALTERNATIVE __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d), \
+		    __stringify(andl	$(X86_CR4_PAE | X86_CR4_LA57 | X86_CR4_MCE), %r13d), X86_FEATURE_TDX_GUEST
 	movq	%r13, %cr4
 
 	/* Flush the TLB (needed?) */
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

