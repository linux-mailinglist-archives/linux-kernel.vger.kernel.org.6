Return-Path: <linux-kernel+bounces-222403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA379100F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB85A1F22624
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7E1A8C0A;
	Thu, 20 Jun 2024 09:59:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562981A8C0D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877541; cv=none; b=qAEMoSvfobx1B/48/CLRPJLASKWW1nERoJwwPf4FZ+sShXF9GWleNV6jSjSTul++U83oI9FCYkn9ea1xbrOkocIFvT/oFdJPPXhCAPbwC6Nv5mtKSNlK/F2HVCSVDlnBwFMruEe+qAvlX7PDfrP3KHYKW4+TvXAhiJ4a8zXIAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877541; c=relaxed/simple;
	bh=CTZVU7ivd8ZTYFpMsPW/pyVMY2ia7yu9BEAjSpmmrl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5IQ13dGBZ9PHdzS9LHgrvtNpgeD32yWcvKk+DCK3JkV6UXs/jPKFnYi65qctY9dGfgxPn/tbHLDbIcfr1SS79336+nDEYrgqDR60lHCyT0TWHfUciQhWT6TbL/IjZqyVdTJQEiV8YC2GjsygxklF4zvPs0hJR2XjaN5w01pXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D39FDA7;
	Thu, 20 Jun 2024 02:59:23 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E10D3F73B;
	Thu, 20 Jun 2024 02:58:57 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:58:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Stop using ESR_ELx_FSC_TYPE during fault
Message-ID: <ZnP9XNrz6L47Lhk1@J2N7QTR9R3>
References: <20240618034703.3622510-1-anshuman.khandual@arm.com>
 <d29136e9-6c63-4e4f-81bb-488edcac587e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29136e9-6c63-4e4f-81bb-488edcac587e@arm.com>

On Thu, Jun 20, 2024 at 09:45:38AM +0100, Ryan Roberts wrote:
> On 18/06/2024 04:47, Anshuman Khandual wrote:
> > Fault status codes at page table level 0, 1, 2 and 3 for access, permission
> > and translation faults are architecturally organized in a way, that masking
> > out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.
> > 
> > Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
> > out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
> > code as the kernel does not yet care about the page table level, where in
> > the fault really occurred previously.
> > 
> > This scheme is starting to crumble after FEAT_LPA2 when level -1 got added.
> > Fault status code for translation fault at level -1 is 0x2B which does not
> > follow ESR_ELx_FSC_TYPE, requiring esr_fsc_is_translation_fault() changes.
> > 
> > This changes above helpers to compare against individual fault status code
> > values for each page table level and stop using ESR_ELx_FSC_TYPE, which is
> > losing its value as a common mask.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v6.10-rc4 and still leaves behind ESR_ELx_FSC_TYPE for now.
> > 
> > Changes in V2:
> > 
> > - Defined ESR_ELx_FSC_[ACCESS|FAULT_PERM]_L() macros
> > - Changed fault helpers using the above macros instead
> > - Dropped each page table level fault status discrete values
> > - Dropped set_thread_esr() changes in arch/arm64/mm/fault.c
> > - Updated the commit message
> > 
> > Changes in V1:
> > 
> > https://lore.kernel.org/linux-arm-kernel/20240613094538.3263536-1-anshuman.khandual@arm.com/
> > 
> >  arch/arm64/include/asm/esr.h | 33 +++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> > index 7abf09df7033..3f482500f71f 100644
> > --- a/arch/arm64/include/asm/esr.h
> > +++ b/arch/arm64/include/asm/esr.h
> > @@ -121,6 +121,14 @@
> >  #define ESR_ELx_FSC_SECC	(0x18)
> >  #define ESR_ELx_FSC_SECC_TTW(n)	(0x1c + (n))
> >  
> > +/* Status codes for individual page table levels */
> > +#define ESR_ELx_FSC_ACCESS_L(n)	(ESR_ELx_FSC_ACCESS + n)
> > +#define ESR_ELx_FSC_PERM_L(n)	(ESR_ELx_FSC_PERM + n)
> > +
> > +#define ESR_ELx_FSC_FAULT_nL	(0x2C)
> > +#define ESR_ELx_FSC_FAULT_L(n)	(((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
> > +					    ESR_ELx_FSC_FAULT) + (n))
> 
> I think the only real argument for parameterizing it like this is so we can
> write "-1" as a parameter rather than "N1" as part of the macro name? Other than
> that (marginal) benefit, personally I don't think this approach is very
> extensible because we are devining a pattern from the encoding that doesn't
> really exist. If we ever needed a level 4 or -3 the encoding would have to be
> discontiguous and we would need to rework this again to accomodate. Perhaps the
> chances of that ever happening are small enough that the problem can be ignored.

FWIW, I agree, I had preferred the spearate definitions because that
matched what was in the ARM ARM and didn't infer a pattern that could be
broken later.

> TBH, I didn't really follow Marc's argument for keeping the "type" macros either
> since ESR_ELx_FSC_FAULT does not help to identify the type of a level -1 or -2
> translation fault - the encoding is completely different. But I'll take it on
> faith that Marc is correct and I just don't understand ;-)
> 
> Regardless, the implementation looks correct, so:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Likewise, either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> > +
> >  /* ISS field definitions for Data Aborts */
> >  #define ESR_ELx_ISV_SHIFT	(24)
> >  #define ESR_ELx_ISV		(UL(1) << ESR_ELx_ISV_SHIFT)
> > @@ -388,20 +396,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
> >  
> >  static inline bool esr_fsc_is_translation_fault(unsigned long esr)
> >  {
> > -	/* Translation fault, level -1 */
> > -	if ((esr & ESR_ELx_FSC) == 0b101011)
> > -		return true;
> > -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
> > +	esr = esr & ESR_ELx_FSC;
> > +
> > +	return (esr == ESR_ELx_FSC_FAULT_L(3)) ||
> > +	       (esr == ESR_ELx_FSC_FAULT_L(2)) ||
> > +	       (esr == ESR_ELx_FSC_FAULT_L(1)) ||
> > +	       (esr == ESR_ELx_FSC_FAULT_L(0)) ||
> > +	       (esr == ESR_ELx_FSC_FAULT_L(-1));
> >  }
> >  
> >  static inline bool esr_fsc_is_permission_fault(unsigned long esr)
> >  {
> > -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
> > +	esr = esr & ESR_ELx_FSC;
> > +
> > +	return (esr == ESR_ELx_FSC_PERM_L(3)) ||
> > +	       (esr == ESR_ELx_FSC_PERM_L(2)) ||
> > +	       (esr == ESR_ELx_FSC_PERM_L(1)) ||
> > +	       (esr == ESR_ELx_FSC_PERM_L(0));
> >  }
> >  
> >  static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
> >  {
> > -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
> > +	esr = esr & ESR_ELx_FSC;
> > +
> > +	return (esr == ESR_ELx_FSC_ACCESS_L(3)) ||
> > +	       (esr == ESR_ELx_FSC_ACCESS_L(2)) ||
> > +	       (esr == ESR_ELx_FSC_ACCESS_L(1)) ||
> > +	       (esr == ESR_ELx_FSC_ACCESS_L(0));
> >  }
> >  
> >  /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
> 

