Return-Path: <linux-kernel+bounces-401998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352F9C2219
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F8B1C21608
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61044192D6A;
	Fri,  8 Nov 2024 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiLx2LkU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DE187FE4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083400; cv=none; b=gOWv7fz2e4uMJP6tW/ZaOl7RyVB3ZK2moEvls7pjlulPOqtLy7pFm13Rl16vI9KF8+A3rZF146R3wnjhFqqzesz3ZypDVPQx+3eFo16cATRk61YmzMwC62Z6L/Auh5Geipl/lB98gswXR/K2jwCm67MEtldRzK5jMarJyumrizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083400; c=relaxed/simple;
	bh=SaOr4hp+maWcyvllSAtTmYFhvLifPTPx6E7yvEC4rVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNUPfauRcYCRMIFtN40QI6fqKo2f8fM9FK193GR+HbPFQIlOpni62a1Tw8XfMjiijyvIF8ZrdHMhtdlCeIYKbwzFT+NJlOhiZ2MLSK5uOP6M7WPRu7hNwo6TWSZcBQaW8PpJGdNvYaSMyWhGW0JoAg1qaQlKotsKpeO+vfofS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiLx2LkU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731083399; x=1762619399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SaOr4hp+maWcyvllSAtTmYFhvLifPTPx6E7yvEC4rVM=;
  b=JiLx2LkUyLNn41o7NdWjlH0xj2mqjF01ygMFF03YAwK2L9LWb7r1s6rN
   CnqYTHENHdAde/yA0j1m5AmXYlV8WmeGAiYX4a0s/YhxAlP8Ugu2rI1rs
   cIpelAvqa3NmqVzFyQYSxp5hjRTaxnwBMGmQTkHCspo5NxQAPuBuWiUJ3
   JDiEmZPB1e1NQldbFz3WOokYQ4HYjZV40mtMES1/1hPUSDnCTMrtuaxO4
   r46RA7LgusvZVUn/WIagP32DJ7o8mwVipN19t0AL3br4w3DTzx0xGCavE
   7B37iHXi6M50M7haanmrKvTldyrupVd87THkNtMajU/NCQmcitjS2X32N
   g==;
X-CSE-ConnectionGUID: utmU6VzHSbO866xAZa91Aw==
X-CSE-MsgGUID: 49FNtmtCRAq/VTgSAcPy3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="41588253"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="41588253"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:29:59 -0800
X-CSE-ConnectionGUID: VfJai/4+TcSPohGf+9zlDw==
X-CSE-MsgGUID: 1PYI/YoJSAyUh01C3dEPsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="89590072"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:29:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9Rrs-0000000Cfw2-3JZZ;
	Fri, 08 Nov 2024 18:29:52 +0200
Date: Fri, 8 Nov 2024 18:29:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v5 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <Zy48gBu81i9bY0Qp@smile.fi.intel.com>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
 <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com>
 <Zy4xHC3MCtAqlSxy@smile.fi.intel.com>
 <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 08, 2024 at 04:48:16PM +0100, H. Peter Anvin wrote:
> On November 8, 2024 4:41:16 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Fri, Nov 08, 2024 at 04:35:17PM +0100, H. Peter Anvin wrote:
> >> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> >> >inline functions for W=1 build").

^^^ (1)

...

> >> But another question: why the hell does clang complain about an unused static inline function?!
> >
> >Does (1) shed a bit of light to this?
> 
> How on earth is that supposed to work?! We have static inline functions in
> headers all over the place that are only used in certain circumstances.
> 
> Is this a good thing, really? Or is it noise?

This is a good question and IIRC somebody else already asked something similar.

Clang people are Cc'ed here, I leave this to them to comment on,
I am not an expert here.

-- 
With Best Regards,
Andy Shevchenko



