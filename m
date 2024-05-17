Return-Path: <linux-kernel+bounces-182218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B18C8835
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892BDB213CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315779F5;
	Fri, 17 May 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAn/xIrt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F91A2C2E
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956873; cv=none; b=tZySEISI7s9miDofFPujimMMMEYml0zaQvcxciLOoFxFHZnqUAWnfdCez+1EP2frCLOeKUaAf9gy/zkwAKFClpSD9YRCFdIcEbodDTFREP81iMUFAd7kd9b8Q7tv/HiKIUHeOscf4akWRp5jQXw8PEOk/UtQn9lVuAUL8UVAq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956873; c=relaxed/simple;
	bh=rW+AcPY2tzXirbdA/kRmX80I2r8guayIOpJV3BkKouw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB8xTap4mFRbB8vHyYFoBwrjuQmuLb2pzWxKImse3DvaFVrhPEZZy65VmwTgDZsv9JdvP2k7bYmUElLeptlSFYlCtsRx6m53noYmBRkA2SO+TU+cE8/DfxOf7hl9FNGwjNeDuc/ull4+erpPLRBkrv1BfElJFTQ/fp2DIywH5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAn/xIrt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715956872; x=1747492872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rW+AcPY2tzXirbdA/kRmX80I2r8guayIOpJV3BkKouw=;
  b=FAn/xIrtf2Y5HSbGGR5Bxc2aq8zam+W9yH1Wlw0LpUj2MdeJTOY02TrV
   CgMH6X/VG/kibsGEd52uGNW86ZlL7rWkGv2AvSIiyeHIZp/hhFxnkIDBp
   TwfcR4eTBM0u/E+WZ7RrNd2B9qt1KrafVehJn7GsY+h+3Q8oxfkYyhE6H
   igH9nUZUhk1OAglsPHn57nxWvAOlRWd3DSerqpuDAak3ylKCvk3vYKXu1
   vkgDabx6NyulxOADeYUOPfCpRdsPapCz3WJQbYX5xaU9okRwLlgY1OIk+
   6laQUEHm0yH2TcS2nedYyDzJfJT8ZvdBo1pj7sUEZCRAxIkFv71GU1acb
   A==;
X-CSE-ConnectionGUID: ybGnZyB5TRSFBfFrKLHaxg==
X-CSE-MsgGUID: ++KG4bqcRiCS6brARPXAXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11575324"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11575324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:41:12 -0700
X-CSE-ConnectionGUID: 0Uv71e+2R3Oe3+tlO1mslg==
X-CSE-MsgGUID: rHDQmHarTUaby29111YBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="63014232"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 May 2024 07:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2693819E; Fri, 17 May 2024 17:41:08 +0300 (EEST)
Date: Fri, 17 May 2024 17:41:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Message-ID: <756f73joovi4i4mwn2r2cfhvxhsbejj4ymz653mi6djkyhzxts@mcnzn2amuunr>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>

On Fri, May 17, 2024 at 05:39:51PM +0300, Kirill A. Shutemov wrote:
> On Fri, May 17, 2024 at 04:08:03PM +0200, Juergen Gross wrote:
> > On 17.05.24 15:55, Kirill A. Shutemov wrote:
> > > On Fri, May 17, 2024 at 02:14:50PM +0200, Juergen Gross wrote:
> > > > While testing TDX host support patches, a crash of the host has been
> > > > observed a few instructions after doing a seamcall. Reason was a
> > > > clobbered %rbp (set to 0), which occurred in spite of the TDX module
> > > > offering the feature NOT to modify %rbp across TDX module calls.
> > > > 
> > > > In order not having to build the host kernel with CONFIG_FRAME_POINTER,
> > > > save %rbp across a seamcall/tdcall.
> > > 
> > > There's a feature in TDX module 1.5 that prevents RBP modification across
> > > TDH.VP.ENTER SEAMCALL. See NO_RBP_MOD in TDX Module 1.5 ABI spec.
> > > 
> > > I think it has to be enabled for all TDs and TDX modules that don't
> > > support it need to be rejected.
> > > 
> > 
> > Yes, I know. I'm using the patch series:
> > 
> >   [PATCH v19 000/130] KVM TDX basic feature support
> > 
> > which I think does exactly that (see setup_tdparams() and tdx_module_setup()).
> 
> Looks like the check is broken:
> 
> https://lore.kernel.org/all/46mh5hinsv5mup2x7jv4iu2floxmajo2igrxb3haru3cgjukbg@v44nspjozm4h/

Err.. I think I confused myself. Please ignore.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

