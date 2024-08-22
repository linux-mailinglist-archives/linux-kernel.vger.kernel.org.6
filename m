Return-Path: <linux-kernel+bounces-296884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A795B024
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C011C22D50
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAA17E00B;
	Thu, 22 Aug 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAI+5WPm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFC17DFFD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315040; cv=none; b=odFzudb/nt+cmEfXTlA6X/k9RBw6pPf8ncWERF1UDsvmkppaQhC8DTtWyvch1kJBRMMxFG7uNfQHPfVIPqsHtRc65ALAUq61vJHs1SUIT1lmm9ZxobDnntR8zjKZUxFK+9sNpe7C5ChCKYiVtpKo6eKJpU4rPQ35/QJq26ardWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315040; c=relaxed/simple;
	bh=sYCHdpz8M4L6MyN5KErP3mVpTu3bPU/dknkxRceGXXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cImo7I0Iw9sOhqeMJHt3642axVIKHv4hHFBij03KhgEFc+nPYWGB72+/qgf05JT/1wOGlSukc5+nfXuw8XEWz24IQxw2LBN3vMhAd+5nSIvCKW4iibmzkfjmFga+w7q7HcUOSMrNwlqgDHwk0hY/cifZEScIxB7Hlx73jkh1hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAI+5WPm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724315040; x=1755851040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYCHdpz8M4L6MyN5KErP3mVpTu3bPU/dknkxRceGXXw=;
  b=mAI+5WPmvzVAM6NnMGgagBIgGhHPlkEiI5BUsnX1cYrw37spvjw728Jv
   ANN+vn1uz1Ax9WabmUv0TACvQ87yeNCCV/RhON23D4d+1ukkbyBbSGWmD
   ZzTs40NfLcUsAwcEvPjp2mWnw8aX2oviIqw5hKo3CGj93iBYBpMmJFzQ4
   KCMn++opSFmwCgtcYiMd8UuIXRHJSdkqEYj3kJBs7clOHn4YMouvu/HhU
   PK+84KxlfE7gPYkVYJ/yq64hONV5k3jtoc9jStCiSBmUNUT4E93YMSQUN
   ii+MEB8LnQ0Gh2oHnLupRwgWTkoWwhP6/2uQk9pd4UPGL0YP4odlRScHn
   w==;
X-CSE-ConnectionGUID: ANX5oafNSd28w73HoN/BMA==
X-CSE-MsgGUID: ocqAOf3HSASd5PK7Jk3hwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45237511"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="45237511"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:23:59 -0700
X-CSE-ConnectionGUID: KuFpyoNjRH2BfIVK41BwBQ==
X-CSE-MsgGUID: 5ScxYsNcRs+GUa49tD9RuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="92161595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 22 Aug 2024 01:23:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9E0E443E; Thu, 22 Aug 2024 11:23:52 +0300 (EEST)
Date: Thu, 22 Aug 2024 11:23:52 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v4 5/6] x86/tdx: Move MMIO helpers to common library
Message-ID: <raojr7elewc6npsph7j5kibeyznsb6ulfid2ksz7i52nldrnu6@uxmdfqoppyef>
References: <cover.1723807851.git.legion@kernel.org>
 <cover.1724248680.git.legion@kernel.org>
 <125b648888ea976e3b8d10df70e40f03a9ca35d6.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125b648888ea976e3b8d10df70e40f03a9ca35d6.1724248680.git.legion@kernel.org>

On Wed, Aug 21, 2024 at 04:24:37PM +0200, Alexey Gladkov wrote:
> @@ -124,3 +125,127 @@ void memset_io(volatile void __iomem *a, int b, size_t c)
>  	}
>  }
>  EXPORT_SYMBOL(memset_io);
> +
> +int __get_iomem(char *src, char *buf, size_t size)
> +{
> +	/*

This comment (and comment for __put_iomem()) has to be updated to be less
SEV-centric.

> +	 * This function uses __get_user() independent of whether kernel or user
> +	 * memory is accessed. This works fine because __get_user() does no
> +	 * sanity checks of the pointer being accessed. All that it does is
> +	 * to report when the access failed.
> +	 *
> +	 * Also, this function runs in atomic context, so __get_user() is not

It is not going to be atomic context for TDX case.

> +	 * allowed to sleep. The page-fault handler detects that it is running
> +	 * in atomic context and will not try to take mmap_sem and handle the
> +	 * fault, so additional pagefault_enable()/disable() calls are not
> +	 * needed.
> +	 *
> +	 * The access can't be done via copy_from_user() here because
> +	 * mmio_read_mem() must not use string instructions to access unsafe
> +	 * memory. The reason is that MOVS is emulated by the #VC handler by
> +	 * splitting the move up into a read and a write and taking a nested #VC
> +	 * exception on whatever of them is the MMIO access. Using string
> +	 * instructions here would cause infinite nesting.

#VC is SEV specific.

> +	 */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

