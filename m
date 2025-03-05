Return-Path: <linux-kernel+bounces-546342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258AA4F972
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1213AC544
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9B20011B;
	Wed,  5 Mar 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHjZwvEX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9720127B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165369; cv=none; b=Fkd7ga36H11NzN3carrIToGy1zctrs2PcTmcDub97VOqVdOlOVd8/3iHSQ4PTH/ThdvHnw+q9YXiWGwQOt9w7LDyYLkdNmo51ugp9wdWO1ThM4bhY0UbWWrTlcA/gDyabw6SJDGDqbJ8VPnGpL2zCqMuTgp1nnB00yqteueTUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165369; c=relaxed/simple;
	bh=tMbrss0O9Q9l5VIwni02MAgNIswQGbYHXs5QyXp+Fv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOR/CoyOAquKgs1sc3wnce535T1wupCZNwzIzuCnOLB8lFfWV2WB0J4ssZCogcdb1P81w05iMpOHw8R6DjPzZGzzYYMxCXgudwdvA3rwStws3yprAadpCUcLMSduoxwCsxAAUFC0gfytj1Lw7b0nS0SJYscxsCHdJhQvSzuA6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHjZwvEX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741165368; x=1772701368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMbrss0O9Q9l5VIwni02MAgNIswQGbYHXs5QyXp+Fv0=;
  b=EHjZwvEXylCoyzSuw+2EfzNP5JtORPIp5HlMx50dT9f6r1JDIXZo2j4q
   GxsWbWSqLTq6RFtVNAoJ5+f0mr1ubSSfCCFeoDh7Qcc+ze1AkPS5+o1gw
   T1wSvIg2gGWS8FoE/iR/KiIfuGGyd89IZed+4Xwe03jHDUVaHzTuP1YSO
   +dfjbwgjUudjCtchoVdpu5yTLt+UiLtl192SMYx4FoNWHtxh9u+xHK6oE
   6wtyoofBinzZH3d+rTQvxKbBQsymW6keutNjEPNOfjZQZdHJLoJ4ho9Ls
   NItlAwEdiT2XRg3yHGJSKBVSUsQ+YYRg7+q5GyWKt92myB68zE8kPwcz5
   g==;
X-CSE-ConnectionGUID: 6xZomqHaR0+zjVndrAzQFw==
X-CSE-MsgGUID: bs9fJBNTTgSs9WS1OJBBFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52318517"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="52318517"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 01:02:47 -0800
X-CSE-ConnectionGUID: zfmHqCZqTvWB0bgyOYZtUA==
X-CSE-MsgGUID: 2gnJD4FFQjuw7au8jTHLAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118357932"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2025 01:02:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C51E71FD; Wed, 05 Mar 2025 11:02:42 +0200 (EET)
Date: Wed, 5 Mar 2025 11:02:42 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Message-ID: <lpkdubngmzv4vwmkykh7vl37jxwhfdnqwnahumwk3ualctv5bx@eka4www55vki>
References: <20250304143340.928503-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304143340.928503-1-arnd@kernel.org>

On Tue, Mar 04, 2025 at 03:33:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When extra warnings are enabled, the cc_mask definition in asm/coco.h
> causes a build failure with gcc:
> 
> arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
>    28 | static const u64 cc_mask = 0;
> 
> Mark this one as __maybe_unused.
> 
> Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

