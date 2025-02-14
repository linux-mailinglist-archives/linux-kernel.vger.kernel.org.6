Return-Path: <linux-kernel+bounces-515070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71663A35F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D3168BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40F262D23;
	Fri, 14 Feb 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9phvzEj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAB15199D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540773; cv=none; b=DYUh4+peeUiXR+e90+n/F+nq7Ycg5QAAfRv77YT5EaTcWuFQ/bw3ZQE905/wd2YXRMqEfe+8j9xCSV5lFUg7+V8QR1jyVSXTM0pNuQnj3LfqnoSp/HpZvyl3m8AtA4sJTMK1jwyi3tcid5dR03NhsES8sMhC56p8Y7I5zkF797A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540773; c=relaxed/simple;
	bh=PY9/mlFqHwOVMJ7UOaepQH+2dg6cERDBN0/nyE1KoxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnBcoc/a1ksK1A50rGYf9ulN56iUd56eFUvD7kJ33fCAaYXJ9mhR7gwX0YYXnFNcJL6mfqVkoVcZ0MDPemYBhcYUtFs5gsAEqP8MxIJ5edzx0QIuEzTW76GsAEwgsByzTg5v5wHA7f5eqX8xAYNB2DWWT2U1S/99IiM3EfklZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9phvzEj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739540771; x=1771076771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PY9/mlFqHwOVMJ7UOaepQH+2dg6cERDBN0/nyE1KoxY=;
  b=W9phvzEjvQUEFpD6jeqKKDeUCXJQqUKKxc4Htti+zsx5B/vSfsr6jf7R
   Qj4L1jm7EiQp/H6xSSsF5pZC+CIfGszOzM6b7fnKWk3g0f8ZH+kzMlHYs
   /ghzFwRB05PITsc8DSB059B28w8Qmvi5KzOfbcXycF1WcbENagEhIU4UR
   DCuo1/Txa9X2T7u5I2ieETct8ERENT/ITFBHzQxdToVW3htSdGRdsnU02
   mO4MCvbXus1IZcDW+5yGS9zYZiOUjibVmmGenguC1FRAhE2wWGY8IzJlq
   VNciwpYt0GvIiSjhz3/MtlyWVsE+IdxV8mAqc/+2BCR29xhfmxpo0aVnl
   Q==;
X-CSE-ConnectionGUID: HutkckisRW2m28u0nfZdqQ==
X-CSE-MsgGUID: gTjnXsW4Tmi/dlOcKPs86A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43126934"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43126934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:46:11 -0800
X-CSE-ConnectionGUID: tVeG+U/QTpm59KusxwXGrg==
X-CSE-MsgGUID: 6CjZHkbRRJmRgIf+bHyq4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117588180"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 14 Feb 2025 05:46:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6F87E33D9; Fri, 14 Feb 2025 15:46:06 +0200 (EET)
Date: Fri, 14 Feb 2025 15:46:06 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	akpm@linux-foundation.org, kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>

On Thu, Feb 13, 2025 at 07:55:15AM -0800, Dave Hansen wrote:
> On 1/13/25 06:59, Eric W. Biederman wrote:
> ...
> > I have a new objection.  I believe ``unaccepted memory'' and especially
> > lazily initialized ``unaccepted memory'' is an information leak that
> > could defeat the purpose of encrypted memory.  For that reason I have
> > Cc'd the security list.  I don't know who to CC to get expertise on this
> > issue, and the security list folks should.
> > 
> > Unless I am misunderstanding things the big idea with encrypted
> > memory is that the hypervisor won't be able to figure out what you
> > are doing, because it can't read your memory.
> 
> At a super high level, you are right. Accepting memory tells the
> hypervisor that the guest is _allocating_ memory. It even tells the host
> what the guest physical address of the memory is. But that's far below
> the standard we've usually exercised in the kernel for rejecting on
> security concerns.
> 
> Did anyone on the security list raise any issues here? I've asked them
> about a few things in the past and usually I've thought that no news is
> good news.
> 
> > My concern is that by making the ``acceptance'' of memory lazy, that
> > there is a fairly strong indication of the function of different parts
> > of memory.  I expect that signal is strong enough to defeat whatever
> > elements of memory address randomization that we implement in the
> > kernel.
> 
> In the end, the information that the hypervisor gets is that the guest
> allocated _some_ page within a 4MB physical region and the time. It gets
> that signal once per boot for each region. It will mostly see a pattern
> of acceptance going top-down from high to low physical addresses.
> 
> The hypervisor never learns anything about KASLR. The fact that the
> physical allocation patterns are predictable (with or without memory
> acceptance) is one of the reasons KASLR is in place.
> 
> I don't think memory acceptance has any real impact on "memory address
> randomization". This is especially true because it's a once-per-boot
> signal, not a continuous thing that can be leveraged. 4MB is also
> awfully coarse.
> 
> > So not only does it appear to me that implementation of ``accepting''
> > memory has a stupidly slow implementation, somewhat enshrined by a bad
> > page at a time ACPI standard, but it appears to me that lazily
> > ``accepting'' that memory probably defeats the purpose of having
> > encrypted memory.
> 
> Memory acceptance is pitifully slow. But it's slow because it
> fundamentally requires getting guest memory into a known state before
> guest use. You either have slow memory acceptance as a thing or you have
> slow guest boot.
> 
> Are there any other CoCo systems that don't have to zero memory like TDX
> does? On the x86 side, we have SGX the various flavors of SEV. They all,
> as far as I know, require some kind of slow "conversion" process when
> pages change security domains.
> 
> > I think the actual solution is to remove all code except for the
> > "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
> > code.  At that point there are no more changes that need to be made to
> > kexec.
> 
> That was my first instinct too: lazy acceptance is too complicated to
> live and must die.
> 
> It sounds like you're advocating for the "slow guest boot" option.
> Kirill, can you remind us how fast a guest boots to the shell for
> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.

I only have 128GB machine readily available and posted some number on
other thread[1]:

  On single vCPU it takes about a minute to accept 90GiB of memory.

  It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
  it doesn't scale past that in my setup.

I've mentioned it before in other thread:

[1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

