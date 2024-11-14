Return-Path: <linux-kernel+bounces-408684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44ED9C8248
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B9E283449
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8E1E882F;
	Thu, 14 Nov 2024 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zqyh2QHO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE89817
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560678; cv=none; b=SMpyqnbl94LhaxCqzbch/AUb1DbvPg8MCgI9iz8nVltW9fnjcOZTivotpVTcR+daBxnNLc7Z8FePESMd8n0a9Fq3dSZiJs/TFjIgSgScN4IjcGOSN7Dkfo8hiC6/y2O52aC1ALslmL73cejwT1Btczm0eyJYBDb8YKd03xfyFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560678; c=relaxed/simple;
	bh=EqT0RwQdSa9c1ikrX/Ykegp480cTsU4IDBL5lJni93A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av0+XSjCThYJsO5zpv+Ic/OenLSu9dM/U/1nuSyFLtuJXX6HdRaLdRihO6jC2h6wYKhmWgBl3oQnw1CqaOGL+Tnh+aqTJ1I19TfM4ujHKLrcCGYDIVr23ZF15SZmuUpSuHN0oaR5yG9iy17tK2jKQsAsS9owPCeTiM72j1s7TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zqyh2QHO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731560677; x=1763096677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EqT0RwQdSa9c1ikrX/Ykegp480cTsU4IDBL5lJni93A=;
  b=Zqyh2QHOJ3kK2mOZg8ntfXpyw8/hyftjGvJHevBhoNYkcCP4SGvmK97u
   KLK5hRh1gu6txA2fTSa0q5QMSjlwAXbb2/cGoH6l5lI+8ev4SH4z2Hlq3
   6bftMZk3PfLnF2gBBykPgQ52N/Zeygor1jwxa2kYOD+RReJZj/8ATa1g8
   OLvt0iXqHYmYAzJBsmNP1QIDT51i+k80lURzPXm+3shH6/nuuNansl6+1
   6WYovcnEHJ7IH32GL3N2kK4Wo3tZmAf4H5KtHbFxwitgYFJYshplNhH81
   kPx6dzs4bB2EPPFnXU0RKuoPVJPAdZ7HUbD0E9TwgnwKfyJEZDn2IcXik
   w==;
X-CSE-ConnectionGUID: Qj2hLk/RS7ayt0487LHnsA==
X-CSE-MsgGUID: Gic1QMv1SV+4X24RbrQTZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="34345332"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="34345332"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:04:36 -0800
X-CSE-ConnectionGUID: KKKyFaBnTia6gaDMNgY9Mg==
X-CSE-MsgGUID: LrAYBMiLT8uwbIIlM6WfEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88479317"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:04:35 -0800
Date: Wed, 13 Nov 2024 21:03:58 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/35] x86/bugs: Restructure mmio mitigation
Message-ID: <20241114050142.s6gjtna2dnsevnfp@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-7-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-7-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:26PM -0600, David Kaplan wrote:
> +static void __init mmio_update_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
> +		return;
> +
> +	if (mitigate_any_verw())
> +		mmio_mitigation = MMIO_MITIGATION_VERW;

Same as TAA, UCODE_NEEDED can't be set irrespective of microcode.

> +
> +	pr_info("%s\n", mmio_strings[mmio_mitigation]);

This should be in the 'else' part of below condition, otherwise they can
print conflicting mitigation status.

> +	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
> +		pr_info("Unknown: No mitigations\n");
> +}


