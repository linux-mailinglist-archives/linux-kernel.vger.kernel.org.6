Return-Path: <linux-kernel+bounces-306911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF057964550
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8AA28B640
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9C1B81D6;
	Thu, 29 Aug 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIEacCcL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9C1B7915
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935503; cv=none; b=eaGi58cCd9LeXYf0EG5z5WXwBp5jQ0N6n5dfpTutDGwu5FDUxtJXrSbEkrBZ3GwwRcK8fJhYNRpf1xHihi4tr31Ud2a+5LDZH2AvLVf7y77nHRb+tMYXgyhXwkmbSM3Cy3xuD2Tc1JcxxGIff5eRUQOM/15i3miuaQ5MfHwODHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935503; c=relaxed/simple;
	bh=DY9/1cVv26pG2cP3fISCj+C0nDsRZeSSuABJcI/vO6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1OFOBQB2uVmbGsLDS7euKWHUERs3QiH3eDHHpW2mPT130G67/OKh4ZvLfIIIauElh9qW4JwhhFeWmdU1D9O3jhZEa2bD/Y6mZnLwGKQbPUD+DSE4lQzu75Kwyjl94bDJo4zoVw3njU661I1+B/DNgW7AXo6Zm1mAC1KJSFiveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIEacCcL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935502; x=1756471502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DY9/1cVv26pG2cP3fISCj+C0nDsRZeSSuABJcI/vO6w=;
  b=HIEacCcLCedJ0AEhVMvgcOmtd7YQRvRtJU1H2x+EBPG28buRdZxENs0g
   k5j+kKf7zhgmsH2vVdAkCJHG9SZvo2cJCjiTaWmngnx5v+U/dvoIuyO8X
   n7xZ3x8WMz6Q/EZdVmQbY758uxUqgJ7ULXHhnymu6w1bR1PqVsiTa86j9
   AVbKiyAvHSTIfwtkU9g8GYYRFq40+bAQePYxos+HANF7cOeFRsS9XJ8JN
   5wGrXRwOgfAiiIMYAnnsBSuOGnnOcxov/bqA6m2h6r2d9JS2rRK3pdN1k
   /Dcc+I86d0gM2I6CRRzBpJs8AA8OpGel22rxOT9PC35gmHYYL37J3cz2+
   A==;
X-CSE-ConnectionGUID: 1fSWaklMRVqMG8Ky/SCB9Q==
X-CSE-MsgGUID: bEQWyPPWSxS2cWBkJswEcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23476127"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23476127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:45:01 -0700
X-CSE-ConnectionGUID: niHST7EoSAmr0pwY6BH+Pg==
X-CSE-MsgGUID: HP9sOHBVQ5WEBtkCT3BMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="67946059"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 29 Aug 2024 05:44:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F3273170; Thu, 29 Aug 2024 15:44:55 +0300 (EEST)
Date: Thu, 29 Aug 2024 15:44:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v5 6/6] x86/tdx: Implement MOVS for MMIO
Message-ID: <6n6tn2t4tabiclau7cpav6b7kisuotqwg246wp5lxgfngoyyl2@674snretgst5>
References: <cover.1724248680.git.legion@kernel.org>
 <cover.1724837158.git.legion@kernel.org>
 <86af46ade7688c9f4216da51573b6f74b7c53143.1724837158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86af46ade7688c9f4216da51573b6f74b7c53143.1724837158.git.legion@kernel.org>

On Wed, Aug 28, 2024 at 12:44:36PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> consists of dividing it into a series of read and write operations,
> which in turn will be validated separately.
> 
> This implementation is based on the same principle as in SEV. It splits
> MOVS into separate read and write operations, which in turn can cause
> nested #VEs depending on which of the arguments caused the first #VE.
> 
> The difference with the SEV implementation is the execution context. SEV
> code is executed in atomic context. Exception handler in TDX is executed
> with interrupts enabled. That's why the approach to locking is
> different. In TDX, mmap_lock is taken to verify and emulate the
> instruction.
> 
> Another difference is how the read and write instructions are executed
> for MOVS emulation. While in SEV each read/write operation returns to
> user space, in TDX these operations are performed from the kernel
> context.

It looks like SEV only returns to userspace to retry the instruction after
stepping on failed __get_user()/__put_user(), unrolling back to
vc_raw_handle_exception() and handling page fault there.

But I'm not sure what happens with #VC inside vc_read_mem() and
vc_write_mem(). Can the #VC exception be nested? Tom?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

