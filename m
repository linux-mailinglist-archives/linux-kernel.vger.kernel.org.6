Return-Path: <linux-kernel+bounces-401860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2A9C203A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463871C249BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA88C2022F6;
	Fri,  8 Nov 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKTNM4ft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE02003D5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079115; cv=none; b=AXVTTmAwRwXGTQYG43HQUfoZ5pbbNsyHfBr6VbsOVZeQFLV2qFHq9b2G96839ON1hmP6IFTgYWALCDh9l3DSfPRYse9FXcSw8KdiiX1W1udRdjXr+Kj+Da4y2LnnQpRVvan6FlRzenEbJpMfGxqj5wSxmqXuXAK3IcZkPIPjbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079115; c=relaxed/simple;
	bh=6CyNBow/ikiCq4DVbqLUJoxugAdW1qE9b6hF+ci4Cc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7BxZx09q5LBu+Lb/isxNPO8pMXKlDwNDkr2DPGBfXSVZXYEjTbDrE41S7hSEFKKaoDuQ1ij5x9aTT3bYMxCX9qCZ43twmSGTm6EAMvlk0AG+P127eybUvnkwuIOOtKsa28AZdkFxwNIc1YJdYo5U//UPgnTjhx4AxIKtBgCL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKTNM4ft; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731079113; x=1762615113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6CyNBow/ikiCq4DVbqLUJoxugAdW1qE9b6hF+ci4Cc0=;
  b=CKTNM4ftPVXlyhINz5eMW7rFXeoCtMdwM3eDl0hlAhq+q7/v3gV76rB2
   vFHgfDeh2iFcmoId5vv3+nH2oC7gj7TN/kfmMyKY24CMyLxRqvv2am1ND
   KcEhpYSSpeJ9P9l568KSeOfLhQxD4smfFl2fRmT68kxq4gpMpZvrZZ4iU
   y9RxjiP25IBRNBUlY8AiFe7qbOccxNnxwuHU2dxWcqr6sjy2EqpyMXj6n
   h6YrIynxRq9mt3ktiDumkn8fniFyv42FB54pQAUpGvlCiVhyMixo2IRtY
   OaxAJKuYMPK9tC523PnkaCEKGq2I92vmrEcITxiRWpPbeOynJ76eAX6bs
   w==;
X-CSE-ConnectionGUID: AKjIHA6yS56iP0OzYfu2ew==
X-CSE-MsgGUID: Z1mw3aL9Q1OiezDnJPujMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30820127"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30820127"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:18:33 -0800
X-CSE-ConnectionGUID: FkU38R7cSUS3vUhsPL65cw==
X-CSE-MsgGUID: 9cDQF4RuTHinr33EgfiAYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90716779"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:18:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9Qkl-0000000Ceiq-1gYg;
	Fri, 08 Nov 2024 17:18:27 +0200
Date: Fri, 8 Nov 2024 17:18:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <Zy4rw-yx0JL7_-lk@smile.fi.intel.com>
References: <20241108141235.1456557-1-andriy.shevchenko@linux.intel.com>
 <B7F5B222-2982-43D5-87A5-7510EDCCB4DF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7F5B222-2982-43D5-87A5-7510EDCCB4DF@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 08, 2024 at 04:13:05PM +0100, H. Peter Anvin wrote:
> On November 8, 2024 3:11:46 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >When flag_is_changeable_p() is unused, it prevents kernel builds
> >with clang, `make W=1` and CONFIG_WERROR=y:
> >
> >arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
> >  351 | static inline int flag_is_changeable_p(u32 flag)
> >      |                   ^~~~~~~~~~~~~~~~~~~~
> >
> >Fix this by moving core around to make sure flag_is_changeable_p() is
> >always being used.
> >
> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> >inline functions for W=1 build").
> >
> >While at it, fix the argument type to be unsigned long, although it currently
> >only runs in 32-bit cases.

...

> It's good that you are changing the return type, but we need to be consistent
> and change f1, f2 to match. At the same time, I suggest changing the return
> type to bool.

Ah, that makes sense!

-- 
With Best Regards,
Andy Shevchenko



