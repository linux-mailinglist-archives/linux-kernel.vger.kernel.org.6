Return-Path: <linux-kernel+bounces-368134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6479A0BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97192B26B54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848E208D87;
	Wed, 16 Oct 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h92MIyki"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D6205E3C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085837; cv=none; b=VMgQIjyhKnNyHbiHekrByj0JDbDiXQ5ot6I5ecSwi099JfAIEsKtwG08p4237zVpZylwz/chX5TKAkj2N0f96FSBPFcjztDPGhO01n/2nFMsvB+xu9shG8jb4rud2mki6EnVo5jKi09h9U/SoaCLWss8qt6mUb7d99NQyJ3p5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085837; c=relaxed/simple;
	bh=JFwFNnHmS7s8bI7F5EXCKljTy+ZAeAWmJ/x4IijKr5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0TG17Y5u54DaIKtcjaG0YpwEWGKrciYFzndzZSYdoU/b9/td2t+taK/RjvZZjUq7UJb/QZXaWU0ZQOqFssyy/EAuYKGkmNh2uqQGrfilrE9ERxDK69SOn6yCNb+Uc6SUUTfBP8ioZU/GR5W76A+g2/AZJB5jRJ+0NKXvWGi7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h92MIyki; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729085837; x=1760621837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFwFNnHmS7s8bI7F5EXCKljTy+ZAeAWmJ/x4IijKr5E=;
  b=h92MIykijyJXKPrdUPcwvZowmt3eEVtPO0uF21AYqHCKLqaDyEjvWw3d
   nukuGXWxfYD+tELnSVnqZ3naqEUVUkgSIlfVOKwCdrDxdekXCcdeeCtLw
   9RJqMk9JPP/tbvuXU+R0vEj11u4hA1O6x88zVDn+LX2uU1IA4zUDyNEDG
   Lp5/UP5MXKBva+HUVAkT6sRvrl4w5N1zZL3u4aREJXyXrDtKYrdo/N6Pe
   MDLVU1TrJb8rMhMvOw4VxwNvqMETsWuuJFcFQJW4Icow0VmxB4ODxP2G0
   VbTd0ZrpatjcH3M/FxzSvI6Y8wgAZFiXcKEQxwqJ8Kdw6zaniMsnI5WWc
   g==;
X-CSE-ConnectionGUID: tcG1EGxkTROEhFPc5srL0g==
X-CSE-MsgGUID: E1G1FTurQBWFLIXEAWnbzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39653156"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39653156"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:37:16 -0700
X-CSE-ConnectionGUID: ixRenLdxRDiACbEG3QpFiQ==
X-CSE-MsgGUID: yyCqa2tJTXWG8C2jzpTpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78670833"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:37:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t14D5-00000003mB7-47D0;
	Wed, 16 Oct 2024 16:37:07 +0300
Date: Wed, 16 Oct 2024 16:37:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
Message-ID: <Zw_BgyXkyGov4MA1@smile.fi.intel.com>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 08:03:56PM +0300, Andy Shevchenko wrote:
> When percpu_add_op() is used with unsigned argument, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> net/ipv4/tcp_output.c:187:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>   187 |                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   188 |                               tp->compressed_ack);
>       |                               ~~~~~~~~~~~~~~~~~~~
> ...
> arch/x86/include/asm/percpu.h:238:31: note: expanded from macro 'percpu_add_op'
>   238 |                               ((val) == 1 || (val) == -1)) ?            \
>       |                                              ~~~~~ ^  ~~
> 
> Fix this by casting -1 to the type of the parameter and then compare.

Any comments? Or can it be taken in?

-- 
With Best Regards,
Andy Shevchenko



