Return-Path: <linux-kernel+bounces-357978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C29978B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49466B22139
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64D18E357;
	Wed,  9 Oct 2024 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJfy9KZm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1138DD6;
	Wed,  9 Oct 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514198; cv=none; b=gFgxzg7hIHkmi0pDTepPqXGuiiUu4JsGZv7ERh+N8a6AbbNcSBI0u3h88KmvHbh6K7RwbilpGGee27NzSROR/yFaq2IQg99KVrasMqN33X2oKH3qQmLbn5nr+ZgoowAcVPdgm5iZ6A5lPBb3bxh52HAmyGl8Jmgj9cJZtU7QuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514198; c=relaxed/simple;
	bh=nnKhiTwhrqvQYFpTidsGVlvlfsjbATVtPhWeAvKUamc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPxei3rQRvnnAJqQKTq9uIYKpXPf9rLeicEb+JR0I43Xh97y36FrqTzCrkYwL57UeO5G/J+K0UofHLL8AN4d0qXN8ustucL2JE6mebsvwBiCE20HsTyVRqiH5F2I//YYHePcdtUYy+L5RuVBlfCRV1Pmm++vG4RVfQeT+iqiF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJfy9KZm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728514197; x=1760050197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnKhiTwhrqvQYFpTidsGVlvlfsjbATVtPhWeAvKUamc=;
  b=kJfy9KZmJNFk4S0EGR5bvId7+quKjuNUpiRndJRyZACFAA2snrOc2nbE
   DBVTrs51J+GFZG4X/2hDBkqueWqrxnx8kTDefi54lWwvEw6xM1/ezP0vx
   E8B8skvP4yzSHgOIvXaLGpsWJVpLTsPE8g8SUmC3g1V1RpMy3VlvjHjvQ
   oolUMvtuJEu2vQunlnbMfFb0ajpPIRGqvNPT3jV8l66dprc5L+xxWir38
   OHlXS+yi5D8cV0f//a6df6lX9mLensSV0rOZcdSLqaBDmCZAM1Xeu6O52
   +Up8qk1b/1bmeVChesWL/17K8yhLh0gx9IIx9jBCrNv+mhIgyGMa1j72g
   w==;
X-CSE-ConnectionGUID: NVZqPxy5RimtY1lMdTuaUA==
X-CSE-MsgGUID: W3x7mm6aQNWgWD6ut7tVrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27796598"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="27796598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 15:49:56 -0700
X-CSE-ConnectionGUID: 24G4knOcRTKqwkgXjy4biw==
X-CSE-MsgGUID: bmuFdtb4QCGJQq+vFTnbBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="107245887"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 15:49:55 -0700
Date: Wed, 9 Oct 2024 15:49:53 -0700
From: Tony Luck <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Message-ID: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>

On Wed, Oct 09, 2024 at 12:39:33PM -0500, Babu Moger wrote:
> +"num_mbm_cntrs":
> +	The number of monitoring counters available for assignment when the
> +	architecture supports mbm_cntr_assign mode.

It's not obvious (to me) how these counters work. When I create
a group with both local and total monitoring enabled, does that
use up two counters (even though I only used up one RMID)?

Are the counters multi-purpose. E.g. if I disable local counting
on all groups, are the freed-up counters available for use to
count total bandwidth on some additional groups?

From the examples it looks like if there are free counters
available when user does mkdir, then they will be assigned
to the new rdtgroup. If only one counter is free, does it
get assigned to local or total?

Thanks

-Tony

