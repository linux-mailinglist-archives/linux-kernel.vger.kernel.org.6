Return-Path: <linux-kernel+bounces-328521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C7978536
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63989B26F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06826BFC7;
	Fri, 13 Sep 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U39A5VgJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091E4F883
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242819; cv=none; b=QMaFyTvkNYgLlZfcbXTRZvidxR5UdhALq7zQhsXpfB8Rjvi6M08HP8olqdZlqRgXV7Le0P69hSTPOJUJBaK2y1tLUvQtR2+stMcy5wpe8QaV+Emf7f71x7LFSCEmNU+4mo7ccMZE1UXccqmU1wYTmjLbGbeYMNTaLl86NmpQBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242819; c=relaxed/simple;
	bh=jkW48gG3KB5s68m7xCQu7Fd9vmkiEiCdQvjxpzLLclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL9geKJ5CbT+5fi9kG6mvZJ1K4yn1PlrBbA93FMxetAXBeU2CG+Bosa/pNvwOm6CNT+5D6VqC3XwtVCVeBL62/oQ+BqzRdjNgdPgHizKjFlw2vg3fkdW1kGwom5ri6ssmuIlDT5qf7efeh7THDdkRGoOwd4OY1xcbVMBvgf5s3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U39A5VgJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726242818; x=1757778818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jkW48gG3KB5s68m7xCQu7Fd9vmkiEiCdQvjxpzLLclw=;
  b=U39A5VgJ9PKNzRMn0iIgYM5Qt3x/p9R1S8hzogBspygc/sLpWcstR1Un
   W3zhmd45cCuAuU731qgQYEkdVEhTtBOI8AOuowZpyukIaZcAkquVFjjVI
   XaLwXyLll4jBaMeqy9N9DAmIEU+gpk8PlZy1KkUi2WQkt1TJUScqSMU4u
   Y/57XpWI9TIf0ztVFFLvIInXbVnRIcjHJSh42ynUhNugbdOB3Q97QokTy
   Zdbsfx1B6gnK1Xi/2v609no6YEm5nXaJdz4QmtNWUtKqOSKB2OW3zbjyf
   R9LTTsk1FeJ6YyQBzDWJ0UnoBsZbg02tSYlOt3F+TCcYl1i3PfhE2l/eH
   A==;
X-CSE-ConnectionGUID: A7h5IoA9SfmQnshpqblA1g==
X-CSE-MsgGUID: P0qJ/UH0RRWVgGzvUp/FCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35815808"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="35815808"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 08:53:37 -0700
X-CSE-ConnectionGUID: EdWqKmH4SvmyF3NcoNCfGg==
X-CSE-MsgGUID: 6R0Rn12TQL+80vgwJU/xEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98942853"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2024 08:53:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BA42F334; Fri, 13 Sep 2024 18:53:31 +0300 (EEST)
Date: Fri, 13 Sep 2024 18:53:31 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
Message-ID: <2v2egjmdpb2fzjriqc2ylvqns3heo5bpirtqm7cn32h3zsuwry@y5ejrbyniwxq>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
 <ZttwkLP74TrQgVtL@google.com>
 <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
 <ZuHC-G575S4A-S_m@google.com>
 <h5gp6dgcfazm2yk3lorwqms24c2y2z4saqyed6bnzkk2zhq5g2@rf3lj2a22omd>
 <039bc47c-9b5d-41f3-87da-4500731ad347@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039bc47c-9b5d-41f3-87da-4500731ad347@intel.com>

On Thu, Sep 12, 2024 at 08:49:21AM -0700, Dave Hansen wrote:
> On 9/12/24 02:45, Kirill A. Shutemov wrote:
> > On Wed, Sep 11, 2024 at 09:19:04AM -0700, Sean Christopherson wrote:
> >> Yep.  Based on the original report[*], it sounds like the userspace program is
> >> doing a memcpy(), so it's hard to even argue that userspace is being silly.
> > The kernel does MMIO accesses using special helpers that use well-known
> > instructions. I believe we should educate userspace to do the same by
> > rejecting emulation of anything more complex than plain loads and stores.
> > Otherwise these asks will keep coming.
> 
> My assumption is that folks have VMM-specific kernel drivers and crusty
> old userspace that mmap()'s an MMIO region exposed by that driver. They
> want to keep their old userspace.
> 
> Once we're dictating that specific instructions be used, the old
> userspace doesn't work and it needs to be changed. Once it needs to be
> changed, then some _other_ new ABI might as well be considered.
> 
> Basically:
> 
> 	New ABI =~ Specific Kernel-mandated Instructions

If we are going to say "no" to userspace MMIO emulation for TDX, the same
has to be done for SEV. Or we can bring TDX to SEV level and draw the line
there.

SEV and TDX run similar workloads and functional difference in this area
is hard to justify.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

