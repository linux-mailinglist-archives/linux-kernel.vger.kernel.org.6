Return-Path: <linux-kernel+bounces-272239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D806945914
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A3AB21586
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE251BF306;
	Fri,  2 Aug 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df3/4zhh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D04482CA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584486; cv=none; b=DVOOnJUwHiMrA8TS1AqbcnnsMC/hsA4hTe0z5LPxOKUkDCwNwJrobmnCnDnCtgfRwA50i+ondP0+IQdPNDI6v77RxyUq3/dQAJW9dC1oglAZIunEuTzqyM8Z438mT0vQgn8IUwK1Geu/95UGeeSLqsgBVEXLnaO9ZxUCdPu9rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584486; c=relaxed/simple;
	bh=lWIiKgnb7HkD/XfNp5unduL8AgOpKEyW/X7I3xwLQDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZu1ifSfdROkAWGFR+uUISAiiIXCFIyn31uOaHALXe5Cfl7B+LOevWfV0WRCMcui/XuPOovXMhlx7EcJ0vncSb+WKxgykpliU5B1GzibZLL00AMvK/H7ZqOPDBo2eYZleCE8QU1wuzwFPpBsuSv2Trz5PTSP+o8Ah/4HvBojR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df3/4zhh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722584485; x=1754120485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWIiKgnb7HkD/XfNp5unduL8AgOpKEyW/X7I3xwLQDo=;
  b=Df3/4zhhmgtzCk8GXi4+Qdc3PfeP8bk+uXrTnGSrHtL8rL6ZtGMDWYyL
   02APNjZVDrWi7wGEZeqDiQ+q9c9pH+OAfv9YkN9QQrK25P6FKJfOsFENF
   z/qrw6C0c/xxhbkKpFfRl68NPfXrUbKPsRmjCQxaLpRkNmpT9P6uA3ZV9
   AfdaY6KfNt4/BYtO3uChnBzuEum1Fz1m1pAE0yRlaXe3fWhtEniaG3L9S
   KUVOfqXI1QTCSjv7PRay9GsTsawvGQiJNiVBuLp21fa40nZHxdHa03EI7
   qV73RWCY0DyYR7hUvfw7ANhMCCWOdzB3d1EF8MwtyQnT/5J1x+4agDOO/
   w==;
X-CSE-ConnectionGUID: uhcZND14SlujH5W6U94lnQ==
X-CSE-MsgGUID: owvbDoKfQvipIWLayL0Hpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20172557"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20172557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:41:24 -0700
X-CSE-ConnectionGUID: L1CWsx85QJGZnI8jSN05lA==
X-CSE-MsgGUID: 43k7dbOpR4+KzcUA1F/hrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55239840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2024 00:41:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 165ED1F2; Fri, 02 Aug 2024 10:41:18 +0300 (EEST)
Date: Fri, 2 Aug 2024 10:41:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Alexey Gladkov (Intel)" <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v1 2/4] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <mnncaxyk6jsbtlxk6xo5jvs7mzirp3ituyf7anequxy6xjjijm@ogkxlksd4gi6>
References: <cover.1722356794.git.legion@kernel.org>
 <855a5d97f0e76373e76c5124f415d3abd7ae3699.1722356794.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855a5d97f0e76373e76c5124f415d3abd7ae3699.1722356794.git.legion@kernel.org>

On Tue, Jul 30, 2024 at 07:35:57PM +0200, Alexey Gladkov (Intel) wrote:
> +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> +			unsigned long vaddr)
> +{
> +	phys_addr_t phys_addr;
> +	bool writable = false;
> +
> +	/* It's not fatal. This can happen due to swap out or page migration. */
> +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
> +		return -EAGAIN;

I think we need big fat comment here why these checks are needed.

We have ve->gpa and it was valid at the time we got ve_info. But after we
get ve_info, we enable interrupts allowing tlb shootdown and therefore
munmap() in parallel thread of the process.

So by the time we've got here ve->gpa might be unmapped from the process,
the device it belongs to removed from system and something else could be
plugged in its place.

That's why we need to re-check if the GPA is still mapped and writable if
we are going to write to it.

> +
> +	/* Check whether #VE info matches the instruction that was decoded. */
> +	switch (mmio) {
> +	case INSN_MMIO_WRITE:
> +	case INSN_MMIO_WRITE_IMM:
> +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> +			return -EFAULT;
> +		break;
> +	case INSN_MMIO_READ:
> +	case INSN_MMIO_READ_ZERO_EXTEND:
> +	case INSN_MMIO_READ_SIGN_EXTEND:
> +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> +			return -EFAULT;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

