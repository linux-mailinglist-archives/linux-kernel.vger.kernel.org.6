Return-Path: <linux-kernel+bounces-320999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDC97132A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A3D1F252DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903501B3750;
	Mon,  9 Sep 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+zCZ8Du"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978921AF4FB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873486; cv=none; b=KQBQUeP9aJapeC7hV1jeiNON+jYxvMpIAGCNuHrac6cEZpLUZs4TRJrNF3EGluYLgTR/Ev9ZUSqS14tL5yZNmQs1+NWXQ9s7shjEkXuB1AHRuQEvUufpJRINdui/1qtfXTcOPDUED1BBMG5ppCl+/Z8pOp2Whysigwv2LAp7j7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873486; c=relaxed/simple;
	bh=li8VAch4QC6vYLi5Nc30moLDoI4kWXTy4wjW81EVcv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxCuM/092FJIgIvhLLMFV7lTeamKqCzfaa9iCHeex7EHIQOqFwOztDxM6Q15Yo5Jw8/lTQpIueFm9/JdEE2UCU2nqRzDpjucZiSu0jwJuT4I8DVZYIv2m9k2UTYQNH0VsFq5aipvpTxK5I6M3G1Mk3CoK5v2cEeTJgh2N56+Xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+zCZ8Du; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725873484; x=1757409484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=li8VAch4QC6vYLi5Nc30moLDoI4kWXTy4wjW81EVcv0=;
  b=F+zCZ8DuRdtmKPbdXBH/g91ljKB9kekpmqAV9P6WVR8QP6oPZg8w+V5Z
   3wvq7dUDQRWMkgzp393/UZBBP/GavaWcBwVDx8hLyf5axh0y2tea8rhnQ
   BYgvsAEL3GuH4Ok0QdsZ/ZQrvFidOHZtmV5akHXuus73wr0gwfMuAQZHO
   KzRIt6Y0M8wdiXPc7/46Jsc+8673YMB46Yz6b6DqRAs9fFBnQO3Iu7W6n
   rFjxnc8AJ8dHpdzizpHu0TJswSVzd3nMYwPvFFkFZKBnJEzyZvFGoDJcV
   T7i8Rw9Uf3APcU9zg+2xOGEbCKFf7Xg2AUnAxtkjdt+U6v0jOLxKsye+M
   w==;
X-CSE-ConnectionGUID: z/fCVDK2QXGT/klE7PqypQ==
X-CSE-MsgGUID: fFHItXuwSKyDjTg3k0qOqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24716880"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24716880"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:18:04 -0700
X-CSE-ConnectionGUID: 35moar7cQTy9IwiIKU3hdA==
X-CSE-MsgGUID: 0XTrNxGES3udTdVqws0k9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66321872"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 09 Sep 2024 02:17:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 37821297; Mon, 09 Sep 2024 12:17:57 +0300 (EEST)
Date: Mon, 9 Sep 2024 12:17:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v5 6/6] x86/tdx: Implement MOVS for MMIO
Message-ID: <46n5ndiam2lwoleggdlecsbxuklyi4pg32i7tanwqgd2qgmrjg@bejdnb3vnfse>
References: <cover.1724248680.git.legion@kernel.org>
 <cover.1724837158.git.legion@kernel.org>
 <86af46ade7688c9f4216da51573b6f74b7c53143.1724837158.git.legion@kernel.org>
 <6n6tn2t4tabiclau7cpav6b7kisuotqwg246wp5lxgfngoyyl2@674snretgst5>
 <ZtDAuDAyGevAhSj-@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDAuDAyGevAhSj-@example.org>

On Thu, Aug 29, 2024 at 08:40:56PM +0200, Alexey Gladkov wrote:
> On Thu, Aug 29, 2024 at 03:44:55PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Aug 28, 2024 at 12:44:36PM +0200, Alexey Gladkov wrote:
> > > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > > 
> > > Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> > > consists of dividing it into a series of read and write operations,
> > > which in turn will be validated separately.
> > > 
> > > This implementation is based on the same principle as in SEV. It splits
> > > MOVS into separate read and write operations, which in turn can cause
> > > nested #VEs depending on which of the arguments caused the first #VE.
> > > 
> > > The difference with the SEV implementation is the execution context. SEV
> > > code is executed in atomic context. Exception handler in TDX is executed
> > > with interrupts enabled. That's why the approach to locking is
> > > different. In TDX, mmap_lock is taken to verify and emulate the
> > > instruction.
> > > 
> > > Another difference is how the read and write instructions are executed
> > > for MOVS emulation. While in SEV each read/write operation returns to
> > > user space, in TDX these operations are performed from the kernel
> > > context.
> > 
> > It looks like SEV only returns to userspace to retry the instruction after
> > stepping on failed __get_user()/__put_user(), unrolling back to
> > vc_raw_handle_exception() and handling page fault there.
> 
> In vc_handle_mmio_movs() if regs->cx is not zero we return ES_RETRY. The
> vc_handle_mmio(), vc_handle_exitcode() return it as is. In
> vc_raw_handle_exception() if vc_handle_exitcode() returns ES_RETRY then we
> just return true. So, the ES_RETRY is not further visible.
> 
> Or am I missing something?

You are right. I didn't see this codepath.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

