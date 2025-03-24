Return-Path: <linux-kernel+bounces-574071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E223AA6E046
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FF8188A577
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD05263F40;
	Mon, 24 Mar 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOvDH16j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE6263C90
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835247; cv=none; b=Mtp+Esl7Zuxqb6P6Cn5NDUhNTTz1R+XowadK4/Cezv4eCVMeIGsWZKdvXwylHqGsp+8a4TQD7lObcPszRix5ALZItHZ8QcKoAhkYkgc+nVKhXrRtG3C4y6Idg+FwKiWpl+NjPBPztiBGS4UC13aEhoYxKrnvrKvST+nccFnm+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835247; c=relaxed/simple;
	bh=dE6Zd6Ph+/ryHeQLLazfSBwNRaC6LfUCJ2aoR2M+tDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj+etPcAE6ybJpxJLsuSZkQO8T8boaHVOCfw7t19At5Y9nUX5uAuhK4qj+RuTPpUlkG3reX0cYRq6gByzkQj6vAQTnUi061zxPteYazOwh4+EKwnhZx/eAMM5m5+WNQ7YokNuAIhcC5vCrLbJ2G/XQD3dgDDsgV8UFGPUl9GGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOvDH16j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742835245; x=1774371245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dE6Zd6Ph+/ryHeQLLazfSBwNRaC6LfUCJ2aoR2M+tDQ=;
  b=gOvDH16jr2iiMGMUCzZCYKYqwWooj+/+9L3vM8DztEC1vSRnJ78Aaw9r
   LaOvqOZmJq7nuloKxeFrS70GTVwrw/C+m1lzJeetX67LUjlUu07c4+m56
   cMc0mfW9ik07uccUMcB24rS/qHM+meH5lhKo42byDup3k6BgzqNa0DbY+
   9TKuItvyzBIla/CDyGu/yk11RCOneqUlPAuePDjQgrWOdt52oW44U0nhV
   d9iSbWHDkbgPMUn2G58d2Gomv/SOf8LhbNxw++AKRKrwLxOCjyGR4i2x5
   P+yPIZzwGq2n62bkAcWc+hSVGnlMrma02z1VLpFjE6OKHaWaUkIFOG+NY
   A==;
X-CSE-ConnectionGUID: 2qZ8KKxKTNOQZkZKeani5Q==
X-CSE-MsgGUID: f18EW38RQ+CiJS3Ti9xf2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61444866"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61444866"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 09:54:04 -0700
X-CSE-ConnectionGUID: y2R8TjF9T0uyVt27GhllBQ==
X-CSE-MsgGUID: cDQOi4IQR9e/FuSVLgSLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124891128"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 09:54:05 -0700
Date: Mon, 24 Mar 2025 09:54:02 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v13 2/5] arm64: add support for ARCH_HAS_COPY_MC
Message-ID: <Z-GOKgBNxKWQ21w4@agluck-desk3>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-3-tongtiangen@huawei.com>
 <Z6zKfvxKnRlyNzkX@arm.com>
 <df40840d-e860-397d-60bd-02f4b2d0b433@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df40840d-e860-397d-60bd-02f4b2d0b433@huawei.com>

On Fri, Feb 14, 2025 at 09:44:02AM +0800, Tong Tiangen wrote:
> 
> 
> 在 2025/2/13 0:21, Catalin Marinas 写道:
> > (catching up with old threads)
> > 
> > On Mon, Dec 09, 2024 at 10:42:54AM +0800, Tong Tiangen wrote:
> > > For the arm64 kernel, when it processes hardware memory errors for
> > > synchronize notifications(do_sea()), if the errors is consumed within the
> > > kernel, the current processing is panic. However, it is not optimal.
> > > 
> > > Take copy_from/to_user for example, If ld* triggers a memory error, even in
> > > kernel mode, only the associated process is affected. Killing the user
> > > process and isolating the corrupt page is a better choice.
> > 
> > I agree that killing the user process and isolating the page is a better
> > choice but I don't see how the latter happens after this patch. Which
> > page would be isolated?
> 
> The SEA is triggered when the page with hardware error is read. After
> that, the page is isolated in memory_failure() (mf). The processing of
> mf is mentioned in the comments of do_sea().
> 
> /*
>  * APEI claimed this as a firmware-first notification.
>  * Some processing deferred to task_work before ret_to_user().
>  */
> 
> Some processing include mf.
> 
> > 
> > > Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
> > > that can recover from memory errors triggered by access to kernel memory,
> > > and this fixup type is used in __arch_copy_to_user(), This make the regular
> > > copy_to_user() will handle kernel memory errors.
> > 
> > Is the assumption that the error on accessing kernel memory is
> > transient? There's no way to isolate the kernel page and also no point
> > in isolating the destination page either.
> 
> Yes, it's transient, the kernel page in mf can't be isolated, the
> transient access (ld) of this kernel page is currently expected to kill
> the user-mode process to avoid error spread.
> 
> 
> The SEA processes synchronization errors. Only hardware errors on the
> source page can be detected (Through synchronous ld insn) and processed.
> The destination page cannot be processed.

I've considered the copy_to_user() case as only partially fixable. There
are lots of cases to consider:

1) Many places where drivers copy to user in ioctl(2) calls. 
   Killing the application solves the immediate problem, but if
   the problem with kernel memory is not transient, then you
   may run into it again.

2) Copy from Linux page cache to user for a read(2) system call.
   This one is a candidate for recovery. Might need help from the
   file system code. If the kernel page is a clean copy of data in
   the file system, then drop this page and re-read from storage
   into a new page. Then resume the copy_to_user().
   If the page is modified, then need some file system action to
   somehow mark this range of addresses in the file as lost forever.
   First step in tackling this case is identifying that the source
   address is a page cache page.

3) Probably many other places where the kernel copies to user for
   other system calls. Would need to look at these on a case by case
   basis. Likely most have the same issue as ioctl(2) above.

-Tony

