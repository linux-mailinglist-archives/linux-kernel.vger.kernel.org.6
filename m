Return-Path: <linux-kernel+bounces-395430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D79BBDC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7ADB20DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59F1CCB46;
	Mon,  4 Nov 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HReNF6hZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4761CCB2E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747335; cv=none; b=H3TPmqwxP9s/Jh3/PoU5HpDaNbIMNS1IitmCJzi73O1YSXJbRTFCgJ9qXZb7vdkrbogRaOBH4NO3Ci6qLkaSqmI8eCjSIA0EwHxFSQ70Wm9QMtGcrOPeF/1Q91aCtYyRym8eHE26HcbSVLE+cUzIfLpfeRfLqFIuNTAMle6QxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747335; c=relaxed/simple;
	bh=Ne9gWDmy9+oIDf7AHAPV+xcMNiOkpbnCzokN1TXM4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPjvB48gioIPCnmm9dbieOVS88q9q8zMist4reQYBLJRo5dVn9vOLdNPJPejhCvTpAG6VQh3CfnHmEL9fPLx0omRWm9tf1AdFDEw8XclkjV+U1xMqUfWhER7EdjbzC7cpF+yI6Y5lsNBybJKobyiS9lscT1wP/Mrdje58y5+W/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HReNF6hZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730747332; x=1762283332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ne9gWDmy9+oIDf7AHAPV+xcMNiOkpbnCzokN1TXM4JI=;
  b=HReNF6hZxM1aWeQDUq4dAd9mzZFjJkXAZH0xoq5J9oyqPNFzB+vI2S7t
   dTXGpnJPBk788UVt0kxQlgNFDf7NmxtosIot7xPlUQ7DJ+oA6WhtGDgPT
   mKZ6++lWo6DrUbV+z94gJT82o4ryDhupAs9OSyFtuiuYawJGvH0UapzwS
   4onSpI+L6BAhrLbFHHKkMI2QpMULWxefXhl+inzUQ1LOJAOqmFQsAUlZF
   +0SuiEjrDAoIYpfl9HqELoyeJHaHEzGaQI7NoGFpLRRIQXskZtuvj3z81
   PXcsIvqlk6jalZqWbFqWP0/KPIWGtm4hqUXZxWeeMBzGtXwcM7tZuumWS
   w==;
X-CSE-ConnectionGUID: wGhiWn6ZTPeUrn1cNRFZ9A==
X-CSE-MsgGUID: hBvDwaLITc2TlTdSKh/g/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55864285"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="55864285"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 11:08:52 -0800
X-CSE-ConnectionGUID: XbfzRKTqT6uAqthkuuxYCQ==
X-CSE-MsgGUID: y/iiAJh1TFS2unUJJXzOJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="121224533"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 11:08:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t82RR-0000000BA8O-1MJr;
	Mon, 04 Nov 2024 21:08:45 +0200
Date: Mon, 4 Nov 2024 21:08:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/1] x86/reboot: KVM: Guard
 nmi_shootdown_cpus_on_restart() with ifdeffery
Message-ID: <ZykbvVZ32FKCRT_q@smile.fi.intel.com>
References: <20241008191555.2336659-1-andriy.shevchenko@linux.intel.com>
 <ZwbazZpTSAn9aAC7@google.com>
 <ZwcT149jx-iOmEfl@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwcT149jx-iOmEfl@surfacebook.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 02:37:59AM +0300, Andy Shevchenko wrote:
> Wed, Oct 09, 2024 at 12:34:37PM -0700, Sean Christopherson kirjoitti:
> > On Tue, Oct 08, 2024, Andy Shevchenko wrote:
> > > The nmi_shootdown_cpus_on_restart() in some cases may be not used.
> > > This, in particular, prevents kernel builds with clang, `make W=1`
> > > and CONFIG_WERROR=y:
> > > 
> > > arch/x86/kernel/reboot.c:957:20: error: unused function 'nmi_shootdown_cpus_on_restart' [-Werror,-Wunused-function]
> > >   957 | static inline void nmi_shootdown_cpus_on_restart(void)
> > >       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Fix this by guarging the definitions with the respective KVM ifdeffery.
> > > 
> > > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > > inline functions for W=1 build").
> 
> > Heh, I tried fixing this too, and have patches to clean things up, but I ended up
> > not posting them because I decided the W=1 warning was less ugly than the resulting
> > code in nmi_shootdown_cpus().
> 
> CONFIG_WERROR=y is the default (at least in the current defconfigs for x86).
> My goal is to match what ARM builds survive (to some extend?), i.e. W=1, so
> may one apply either version I provided or yours?
> 
> > If we're willing to take on a bit of weirdness in nmi_shootdown_cpus(), then much
> > of the #ifdeffery can go away.  Patches attached (lightly tested).

So, what's the status either with the proposed change or with what Sean shared?
Can we somehow move forward to fix the issue?

-- 
With Best Regards,
Andy Shevchenko



