Return-Path: <linux-kernel+bounces-296783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324695AF24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865B21C22CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B41531E1;
	Thu, 22 Aug 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGMeVz68"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6114F9DA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311051; cv=none; b=fbu5lseMCpVG4SLZkTBJS/XoMUM2sBH2/Nz/8B9W8SsRKyivJAtHvc4wMeRdJi1sl6quLv1XcAJKX/SfivYt0jLiK3hiH5ZDWumDIkvF3y7Mu1ViYoaQcenQIqJ6aa+rKO5cUnDYib0xS0a0QcfMwUr0mJSQzdZPtPaaFuKfG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311051; c=relaxed/simple;
	bh=ww0uDpEVuacHer6fVn8p1enrb1h0DCf/XeLTZ5kfw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHcLScHWG8rnOR5y9soRf73t1n9rS+40WAxH8ah7jmcxwnf0FGXOq5AC16NffFa32xPunaYg0UBF4qVOR1QpFMeV6AVb0VwDGRfDeLVDJpRXtXSUzBl1P8aDODDs8VGVcj5Gj/QcLj0JhAEkD3Lbx97TrX9j2z9jtRKlqQuzfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGMeVz68; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724311050; x=1755847050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ww0uDpEVuacHer6fVn8p1enrb1h0DCf/XeLTZ5kfw/0=;
  b=RGMeVz682miB5DHtLtIkgnobC72Y0TXIKzVfFSmvz0L2kh5Zz2ZysVG6
   QA8UiF6DJT/S1ULdtpyNxgHaDZ65wIUhT1wPtsyuSn05myeioNQDTQUf9
   PIn6H3J5LkGKkPBZqR7OdCxyFNGUr2LGSua5OuDwQtNYpyPUBv2gBzrmy
   N+EgttmptAagauPFa1Aausjn7L+tR2T77SMvsdBU53nBSELTPsfGygbch
   bRaGWQRWrCHH6EV8zmDzfhsfgcCpeN5Z7FY+PTePk/q4f/0RCRGgV5/9z
   Y8XGlpAVfIkIlnUEuIXH+pCsINzppnespP65uzSPpw5jUCy7KQnYwmgMj
   A==;
X-CSE-ConnectionGUID: 78zYjYOrRdK89c+0lh9P5g==
X-CSE-MsgGUID: xmkGzp5+TZmOztu64wtP/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22860944"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22860944"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:17:15 -0700
X-CSE-ConnectionGUID: VJHzCY3SQRmU2H0XNum8Iw==
X-CSE-MsgGUID: awJnlqw2S/2ypnGxaQCtjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66293044"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 00:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 26EF043E; Thu, 22 Aug 2024 10:16:58 +0300 (EEST)
Date: Thu, 22 Aug 2024 10:16:58 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v4 2/6] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <hyszoppvgphu5ogk6imqjvgwz4et7wlptanxizx4djayuugacy@2o32v5iih235>
References: <cover.1723807851.git.legion@kernel.org>
 <cover.1724248680.git.legion@kernel.org>
 <a71d13bcdd1f5980195a37abcc8d891cfd09dca2.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71d13bcdd1f5980195a37abcc8d891cfd09dca2.1724248680.git.legion@kernel.org>

On Wed, Aug 21, 2024 at 04:24:34PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> Instructions from kernel space are considered trusted. If the MMIO
> instruction is from userspace it must be checked.
> 
> For userspace instructions, it is need to check that the INSN has not
> changed at the time of #VE and before the execution of the instruction.
> 
> Once the userspace instruction parsed is enforced that the address
> points to mapped memory of current process and that address does not
> point to private memory.
> 
> After parsing the userspace instruction, it is necessary to ensure that:
> 
> 1. the operation direction (read/write) corresponds to #VE info;
> 2. the address still points to mapped memory of current process;
> 3. the address does not point to private memory.
> 
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

