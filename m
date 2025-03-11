Return-Path: <linux-kernel+bounces-555913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3789A5BE49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C31166F73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED962512E4;
	Tue, 11 Mar 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az+H71Zi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC55250C1D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690546; cv=none; b=e29Uw17yVJfQ0pJx/M7tG5pTJWLemnY2JA3s3GVdO0BipIQVnlJLwk3sFvxGcM4TPrihi4Yn8I/GiooERCrYs1x04oauXNLDx+OYy9cP9kTOBvzdY7Q28sNkmZnzRWH+085+bzL/FRaIstYT5MgADFogrzNM4VDEklIyrGz+dpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690546; c=relaxed/simple;
	bh=IjNTjqkw5oTvy1k555EaaZOMIULDGxe8al3uPK+UkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE7IM0nb+cqVnXv8zvkpeUV59jEzly7lVo26+vmNe2Qu2XNkNsp4DOssKxrWvARjLi1LLWyXPFhsKWqufFRXPOs8vb2Wb1nSDKY0iY4pLAOYqbCstDDGrN/TEoN9BlCSyt/20X0+CwO0yk5PfSxFw25RBl05KY12ziEFqvAWUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az+H71Zi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741690545; x=1773226545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjNTjqkw5oTvy1k555EaaZOMIULDGxe8al3uPK+UkjE=;
  b=az+H71ZirNmp9AJbkmybpvvUvfDKbxsED+XSMD/XAjBa2EAHlQZuBLxb
   suPDnL9LSnx0vOwcouEoLvsdtWFF0xh8ZGwJHbzQnLXiAjXLn4hKaUJo/
   7pEAB89qo5V/AQDJS7A81tLCJoWg3rvmQBEFRAct3lbDdS3z5QzW4s90Z
   8JgYCvP53YEjpE8HWlxeeyCbGIhrAroEjbaGAMqKvKiPqXi24jPpmDFzw
   jrXB6XTqrNGoyiQStjuS5BcPxjgwciU7O0k5xusO9YnctWos3hJG2NuOx
   ukIe7zpY+acFlj/6YlejtoUtfIdeaX9Y2wQMYqKTkp0Srz/mWoNJ0GZKd
   w==;
X-CSE-ConnectionGUID: ODSx8oSCTFONvTHHEr34Kw==
X-CSE-MsgGUID: dhsA37c+QzCM5/igqUkitg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54104456"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="54104456"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:55:45 -0700
X-CSE-ConnectionGUID: Ilrx/7mKQdmiInFFZk2PDg==
X-CSE-MsgGUID: a7vhmVQKQqKX9c65EamYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125493807"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 11 Mar 2025 03:55:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DE9E81E0; Tue, 11 Mar 2025 12:55:38 +0200 (EET)
Date: Tue, 11 Mar 2025 12:55:38 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Juergen Gross <jgross@suse.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86: coco: replace static const cc_mask with a
 function
Message-ID: <qlgpflicsfcwtr3jpya26arz25jhqjq6254madvjx4yl7diibx@4yyyzscorxxr>
References: <20250310131114.2635497-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310131114.2635497-1-arnd@kernel.org>

On Mon, Mar 10, 2025 at 02:10:59PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When extra warnings are enabled, the cc_mask definition in asm/coco.h
> causes a build failure with gcc:
> 
> arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
>    28 | static const u64 cc_mask = 0;
> 
> Add a cc_get_mask() function mirroring cc_set_mask() for the one
> user of the variable outside of the coco implementation.
> 
> Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> --
> v2: use an inline helper instead of a __maybe_unused annotaiton.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

