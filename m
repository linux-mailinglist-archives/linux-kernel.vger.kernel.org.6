Return-Path: <linux-kernel+bounces-173307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FB8BFEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62321C22214
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47857A13A;
	Wed,  8 May 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dboGS2OY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30006E5FE
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175026; cv=none; b=Oc/gq66EZKPAki0+VOjRneT0y82smX67CfUsvzqs5UKImODBwKf0ahKBrv6nock9akQY642FRd77p8tqU69BQ8rbXMG/S2ggy+HZ1sZHSe5o+DqYCnUYn9vSBR659vTsUdnwY0Yw6EvjJ3ulSoXS+PBuwG/UoStnWsd6FRjT4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175026; c=relaxed/simple;
	bh=i48IC3C8a/IgdCCUP6DZhdFvfj9wyd/dBjr8ZN13+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGfBxBXPMQlDtzIM7fG15m77wX6EUKxkvfE4BhSycwnRjNXd/x1kbDmjMv9WZd/Vb6ePqlfxWEqROrsbU5fWLsSFqpVucEt565hrEvYsu6fNABIrOgrxdbhVpU5S9WmbRwdC2It1a2a137J/SM8KVXkDrUm8PLuTb+o6paGRqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dboGS2OY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715175025; x=1746711025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i48IC3C8a/IgdCCUP6DZhdFvfj9wyd/dBjr8ZN13+DI=;
  b=dboGS2OYe0RbVi7PLi7ztiaBbrhL0108jnX6eq+OapAPOD+2wXCt3XE2
   KSyGJqz2+5x9SXGXLmm78mlI2QYyZQjjlge5Snz3WIAFeJcu+nJ2phv+m
   O/rwiVHHwcZrUfOrE025OyqUvSBXIm73a8IIWzDE2n2Uk38vY+38BLy6I
   fpkLLKtcJ8cO3gMjUU/Xui8cqXBqau3RVQBeoN229QacBo9FOLMfqjNWn
   oJmgpEkmIB7cBdDeg/FncWuxXW/H2PB9JsraVDKGDx6GSHwpszx5OlkV6
   f3hEGJZowkd+rjcD5Ime/4gFIpO8hPqC5bMb0S095tOBqXxi+1OOSS9BR
   w==;
X-CSE-ConnectionGUID: e2yIUQnQR7eZrwNQMCFjxg==
X-CSE-MsgGUID: ngGWwBf9TwyECBIcexATqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10901569"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10901569"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:30:24 -0700
X-CSE-ConnectionGUID: ccoTqbJHROK79xfMEgo2zQ==
X-CSE-MsgGUID: 1LsSkgSZSaeYLhPn+tZe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="52096729"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 08 May 2024 06:30:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9F34311F; Wed, 08 May 2024 16:30:17 +0300 (EEST)
Date: Wed, 8 May 2024 16:30:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <6pmeqhsvkm6noue6zhg6dqu5234isfjbdgush466l2tek3elij@uw7z2ooaqy4t>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
 <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
 <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>
 <20240508120422.GCZjtqRrSuJeUyByEM@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508120422.GCZjtqRrSuJeUyByEM@fat_crate.local>

On Wed, May 08, 2024 at 02:04:22PM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 06:37:19PM +0300, Kirill A. Shutemov wrote:
> > "second kernel" is nomenclature kexec folks are using, but okay.
> 
> And the "third kernel" is the one which got kexec-ed the second time?
> 
> You can make it: "The second, kexec-ed kernel" and then it is perfectly
> clear.

Okay.

> > One possible reason for the failure is if kdump raced with memory
> > conversion. In this case shared bit in page table got set (or not cleared
> > form shared->private conversion), but the page is actually private. So
> > this failure is not going to affect the kexec'ed kernel.
> 
> Lemme make sure I understand what you're saying here:
> 
> 1. This is a fatal failure and we should panic
> 
> However,
> 
> 2. the kexec-ed kernel is using a different page table so there won't be
>    a mismatch between shared/private marking of the page so it doesn't
>    matter
> 
> Close?

Yes.

One other point is even if the failure is real and we cannot touch the
page as private, kdump kernel will boot fine as it uses pre-reserved
memory. What happens next depends on what dumping process does. We have
reasonable chance to produce useful dump on crash.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

