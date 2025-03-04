Return-Path: <linux-kernel+bounces-543531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB876A4D6D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6884E16C8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934521FC7F5;
	Tue,  4 Mar 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVPanEih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1B1FC108
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077724; cv=none; b=V00Aq17Z3+hJnGXTa3+RPsss6WkZZb/h8arbDdl30La8Tz7XEeQ3+TZq6O/R4YKje+H5P29ePHiAjyZfTURGSmOw2S0KupcE+zS7FyY7goj/hegfcy4MM8K8x0j+BWhQVrMGoa7NcqkYZDcTjSJX1SbczIfJPuJz30qgMh3HkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077724; c=relaxed/simple;
	bh=Wn3ovzB8+lKMg6uUVvb3SxMyjW6zOQiHk1e5vDW0fpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7XQKFZShteDkVU3oAkcOG7DoqMOOq9VnuF+H/L2oRsn66/uKlhjji2FAtHnXQHZnMgpPoXqhzdcie1cEN++qOkVYph/QCWJLVEND7VN/sEbBpLg0ujuWl6ZXr9v0ub7TSD8+1dQVHLiFsU2LiKYue3dy1ZkJzSdwBkd8p86iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVPanEih; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077723; x=1772613723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wn3ovzB8+lKMg6uUVvb3SxMyjW6zOQiHk1e5vDW0fpA=;
  b=cVPanEihFlZjNMwzOKaCWp8Ez36AuhR8pBTF3nwtwnHdYS7GR9MTH1FK
   jKsD3b70SzpwhOCXCIz4aB5X9pUryq9s1fatrAm62U1xXyaZ7EHioVJeT
   +QwEaDiqvo/A4lg1v9h7TNClgEItIdYnuPG62vvMXjN+a4H7gNmAtxXic
   27OTRzKDogA10ewHuRekeU4qGcOrUHREGidVRkv6xLDS9mFPXG+i6I2uY
   v9bSiwWgLgbJjcNAXbjROH4bJkarfH93RlJ9w6KITPzmv9R1rmPBo//+M
   vBRC3QNQYhqbDc6RGwmpeXl20j19kkbZcD1RYg5jMn29NgMO8MXsbpYTn
   w==;
X-CSE-ConnectionGUID: QbWfu/FnTbSTLPMU/C8P8Q==
X-CSE-MsgGUID: q1sENlm8RyuhR1U/Gfs0Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41161491"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41161491"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:42:01 -0800
X-CSE-ConnectionGUID: nlHEYB1VQ9Wkf2hsrxMr0Q==
X-CSE-MsgGUID: vyhwHtlQRaOAWtMhBkM9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118040854"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 04 Mar 2025 00:41:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 75EC718F; Tue, 04 Mar 2025 10:41:56 +0200 (EET)
Date: Tue, 4 Mar 2025 10:41:56 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Baoquan He <bhe@redhat.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
 <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
 <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>

On Fri, Feb 14, 2025 at 08:20:07AM -0800, Dave Hansen wrote:
> On 2/14/25 05:46, Kirill A. Shutemov wrote:
> >> It sounds like you're advocating for the "slow guest boot" option.
> >> Kirill, can you remind us how fast a guest boots to the shell for
> >> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> >> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
> > I only have 128GB machine readily available and posted some number on
> > other thread[1]:
> > 
> >   On single vCPU it takes about a minute to accept 90GiB of memory.
> > 
> >   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> >   it doesn't scale past that in my setup.
> > 
> > I've mentioned it before in other thread:
> > 
> > [1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm
> 
> Oh, wow, from that other thread, you've been trying to get this crash
> fix accepted since November?
> 
> From the looks of it, Eric stopped responding to that thread. I _think_
> you gave a reasonable explanation of why memory acceptance is slow. He
> then popped back up last month raising security concerns. But I don't
> see anyone that shares those concerns.
> 
> The unaccepted memory stuff is also _already_ touching the page
> allocator. If it's a dumb idea, then we should be gleefully ripping it
> out of the page allocator, not rejecting a 2-line kexec patch.
> 
> Baoquan has also said this looks good to him.
> 
> I'm happy to give Eric another week to respond in case he's on vacation
> or something, but I'm honestly not seeing a good reason to hold this bug
> fix up.
> 
> Andrew, is this the kind of thing you can stick into mm and hold on to
> for a bit while we give Eric time to respond?

Andrew, Eric, can we get this patch in?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

