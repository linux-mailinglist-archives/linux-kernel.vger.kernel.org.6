Return-Path: <linux-kernel+bounces-515066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF20A35F56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59447A205A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4F264A8F;
	Fri, 14 Feb 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aj2t/PmA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC353594C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540277; cv=none; b=uUkPtiRg6nVRZAE/Qh69W0lJAeOJCNxxOVW6BRKZx2LFBaEeszMw+8g/MefTTrhAtkLFbO3XPDoqgP/sGtBl5sGuce70fRQI3PDcUpSG6lanCQCCRXByDlCcyJKYA1qw0RlGcft3HVYZ3W/Tudas6sntxNReYLDkpqih4v0fV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540277; c=relaxed/simple;
	bh=2Vn39/Rq51zcgHvhj8EEw+qofBX8yop9IUhvBSHBKF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSGqTyJ3Ba05gLpKf5+/P1mfKaxCJRIsoDJoNZVS8LBNZuE4WNjx1fXgi9f2l2qTs3AoVfuO4aOkTOEWhFQyzFvB0/cjp6S0OO9UL2nfJ3T2SpEyIxhbAIZ4YTOZ6PBCYYOs8LefM90jIodxohqsKqWI8AuSxgqfqRkK4cDLPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aj2t/PmA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739540276; x=1771076276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Vn39/Rq51zcgHvhj8EEw+qofBX8yop9IUhvBSHBKF4=;
  b=Aj2t/PmAgNRirNiSJ2EVBW6oaptgIKaqf2QUIi1LYOyLBAn2vNCVPYdq
   vICdY3Z9RhlfOABXncypFmfooNvTOb96KxoGw7/YGvCqpjtSemAXNAJtV
   zuTqGLR/2C4Nf3cWdYdtcJqhffDkIME4ffkyglyE7P7rgS8wAlT+ObEgc
   eKTupP+eNnPbet6xsvVhf2Bc5pH+g8kPVsuV3SWKxvMg2bJ1B8qoOi2Fn
   CzQvDCXw/hYDcUixXHAALpLziNyxb7oRY+EDFJr5WMypNK5Xb9HEJVW6z
   nGe877AkuH9q6jvU6ImbKkAdtVYmnY9Y5PBZlowm5zPV4DBqNtC1w6XpM
   w==;
X-CSE-ConnectionGUID: cFuFH+gZQkW5IP7rXzstkg==
X-CSE-MsgGUID: ZY5Jw1N+TrSytRWZ7ganRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57819772"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57819772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:37:56 -0800
X-CSE-ConnectionGUID: CFOgtk3WSHe9cthpWGjLng==
X-CSE-MsgGUID: Br3FgHXFTriCryF1gvYm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150635321"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Feb 2025 05:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A0A8F32D7; Fri, 14 Feb 2025 15:37:51 +0200 (EET)
Date: Fri, 14 Feb 2025 15:37:51 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, ebiederm@xmission.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	x86@kernel.org, rick.p.edgecombe@intel.com, bhe@redhat.com
Subject: Re: [PATCH v2 1/1] kexec_core: Accept unaccepted kexec segments'
 destination addresses
Message-ID: <uszziotbygfz3i5u6bcpczbcu7xhqmbec4p7eqjjhlgdcgtnxj@fm7ycfwhx3bu>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <20241213095449.881-1-yan.y.zhao@intel.com>
 <69dc7277-7aa8-4091-8993-ff1195ef4c3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dc7277-7aa8-4091-8993-ff1195ef4c3a@intel.com>

On Thu, Feb 13, 2025 at 07:50:42AM -0800, Dave Hansen wrote:
> On 12/13/24 01:54, Yan Zhao wrote:
> > +	/*
> > +	 * The destination addresses are searched from system RAM rather than
> > +	 * being allocated from the buddy allocator, so they are not guaranteed
> > +	 * to be accepted by the current kernel.  Accept the destination
> > +	 * addresses before kexec swaps their content with the segments' source
> > +	 * pages to avoid accessing memory before it is accepted.
> > +	 */
> > +	for (i = 0; i < nr_segments; i++)
> > +		accept_memory(image->segment[i].mem, image->segment[i].memsz);
> 
> The "searched from system RAM" phrase both here and in the changelog
> doesn't quite parse for me.
> 
> Also "System RAM" is the normal phrase that I use to describe the memory
> that mostly ends up _going_ into the buddy allocator. It's not just me:
> 
> 	cat /proc/iomem  | grep 'System RAM'
> 
> I think a more useful comment (and changelog) might be something like this:
> 
> 	The core kernel focuses on accepting memory which is known to be
> 	System RAM. However, there might be areas that are reserved in
> 	the memory map, not exposed to the kernel as "System RAM" and
> 	not accepted by firmware. Accept the memory before kexec touches
> 	it.

If kernel compiled with CONFIG_UNACCEPTED_MEMORY, EFI_UNACCEPTED_MEMORY
is part of System RAM. It translates to E820_TYPE_RAM. See setup_e820() in
EFI stub.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

