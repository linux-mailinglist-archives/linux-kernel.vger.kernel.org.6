Return-Path: <linux-kernel+bounces-217012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7612890AAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C637FB2DE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C693192B88;
	Mon, 17 Jun 2024 09:34:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72752190053
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616855; cv=none; b=aNiM9SbfldsVQEUveSdwlbr1lgJKnhh3xg7fVDFn04Bioy0gfwg290F4+vKuEmppJSigZaEpotd0notBPB+CqSn1XFJL5ZSeXhlxgjrN2yi/ySJ4iVxUVqDEp3hV7Fa0ygfcQCn2fraa9SqcVjBcOLk1kFUBMH3Uy+EjDz39rxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616855; c=relaxed/simple;
	bh=qS5RzhPz6VyWFGttWg4LdfawHxBIpGLXRgp4PWSNfVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIArYGqVkIk1ufcHkQRJ80C8BajgXnwp749Ouone2CBOjuAMvTMJ0EQW/2DfASozG12DNy1x6cJm3W7/1+mDY2HGgpKo97p9AjcNv6i5JkoBY/sKvjdBpccNtYGZguRqKZPZhK4AmsTv1lW5dqVXTEzaYqZJ4uZXlS7LZNOe+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BDDFDA7;
	Mon, 17 Jun 2024 02:34:36 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A5E3F64C;
	Mon, 17 Jun 2024 02:34:10 -0700 (PDT)
Date: Mon, 17 Jun 2024 10:34:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop ESR_ELx_FSC_TYPE
Message-ID: <ZnACqAtt549JXGD-@J2N7QTR9R3>
References: <20240613094538.3263536-1-anshuman.khandual@arm.com>
 <86y179jdbx.wl-maz@kernel.org>
 <ca66f7ac-97d5-474d-bec4-d0ff79c08eaa@arm.com>
 <87cyoj3j44.wl-maz@kernel.org>
 <45ace175-9b59-4ba2-91b8-b96151c03c05@arm.com>
 <86iky8j9ow.wl-maz@kernel.org>
 <cea3ced2-b8b3-426b-8c40-a47881a5bff6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea3ced2-b8b3-426b-8c40-a47881a5bff6@arm.com>

On Mon, Jun 17, 2024 at 02:09:27PM +0530, Anshuman Khandual wrote:
> On 6/17/24 13:13, Marc Zyngier wrote:
> > On Mon, 17 Jun 2024 04:15:40 +0100,
> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >>
> >> Does the following re-worked patch looks okay ? Earlier set_thread_esr() changes
> >> can be dropped from arch/arm64/mm/fault.c and also the original commit message
> >> still makes sense.
> >>
> >> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> >> index 7abf09df7033..6cd13ac61005 100644
> >> --- a/arch/arm64/include/asm/esr.h
> >> +++ b/arch/arm64/include/asm/esr.h
> >> @@ -121,6 +121,13 @@
> >>  #define ESR_ELx_FSC_SECC       (0x18)
> >>  #define ESR_ELx_FSC_SECC_TTW(n)        (0x1c + (n))
> >>  
> >> +/* Status codes for individual page table levels */
> >> +#define ESR_ELx_FSC_ACCESS_L(n)        (ESR_ELx_FSC_ACCESS + n)
> >> +#define ESR_ELx_FSC_FAULT_nL   (0x2C)
> >> +#define ESR_ELx_FSC_FAULT_L(n) (((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
> >> +                                           ESR_ELx_FSC_FAULT) + (n))
> >> +#define ESR_ELx_FSC_PERM_L(n)  (ESR_ELx_FSC_PERM + n)
> >> +
> >>  /* ISS field definitions for Data Aborts */
> >>  #define ESR_ELx_ISV_SHIFT      (24)
> >>  #define ESR_ELx_ISV            (UL(1) << ESR_ELx_ISV_SHIFT)
> >> @@ -388,20 +395,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
> >>  
> >>  static inline bool esr_fsc_is_translation_fault(unsigned long esr)
> >>  {
> >> -       /* Translation fault, level -1 */
> >> -       if ((esr & ESR_ELx_FSC) == 0b101011)
> >> -               return true;
> >> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
> >> +       esr = esr & ESR_ELx_FSC;
> >> +
> >> +       return (esr == ESR_ELx_FSC_FAULT_L(3)) ||
> >> +              (esr == ESR_ELx_FSC_FAULT_L(2)) ||
> >> +              (esr == ESR_ELx_FSC_FAULT_L(1)) ||
> >> +              (esr == ESR_ELx_FSC_FAULT_L(0)) ||
> >> +              (esr == ESR_ELx_FSC_FAULT_L(-1));
> >>  }
> >>  
> >>  static inline bool esr_fsc_is_permission_fault(unsigned long esr)
> >>  {
> >> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
> >> +       esr = esr & ESR_ELx_FSC;
> >> +
> >> +       return (esr == ESR_ELx_FSC_PERM_L(3)) ||
> >> +              (esr == ESR_ELx_FSC_PERM_L(2)) ||
> >> +              (esr == ESR_ELx_FSC_PERM_L(1)) ||
> >> +              (esr == ESR_ELx_FSC_PERM_L(0));
> >>  }
> >>  
> >>  static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
> >>  {
> >> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
> >> +       esr = esr & ESR_ELx_FSC;
> >> +
> >> +       return (esr == ESR_ELx_FSC_ACCESS_L(3)) ||
> >> +              (esr == ESR_ELx_FSC_ACCESS_L(2)) ||
> >> +              (esr == ESR_ELx_FSC_ACCESS_L(1)) ||
> >> +              (esr == ESR_ELx_FSC_ACCESS_L(0));
> >>  }
> >>  
> >>  /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
> > 
> > This looks better indeed.
> 
> Thanks Marc.
> 
> Hello Mark/Ryan,
> 
> Could I still keep your tags for the patch, or it's better to just
> drop them as there are some new changes being folded in. Please do
> advise. Thank you.

Just drop them for now -- we can easily reply with new tags (and I
probably will, as the above looks sane to me).

Mark.

