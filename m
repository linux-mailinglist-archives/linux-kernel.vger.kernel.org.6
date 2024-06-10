Return-Path: <linux-kernel+bounces-208240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69D9022BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8894E282088
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88A7CF18;
	Mon, 10 Jun 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geDeJaHi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01B1E489
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026479; cv=none; b=B69uZUOAHCMU0LTu5uD2AUkCMXvF0bfPY+Ldfhpe0K3MDB31hn/5G3/riPgFj+1k9uX6HoE0ICm6CTa7p7OzVJIAW0EmNRvBrjrzCgESz80py40jhM++KstJffwUxAyXtmlWHNYoKwnQDFYQhTFysdYCvbfIkHu/Qjb9AoOYQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026479; c=relaxed/simple;
	bh=pBvR9McWmov7Rp1pdAQ23EgPGal3SUA9rAXjWP/q4hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9HuElV88PPi8Fai/U0nI7uD8ya9rpnrU3HaKiXh0CMoU8YuiYOPvr+2diKwnG+N3OXR/5ox2ygG3LVP5a2xrRgLQwTCR8GhNOtvk6cI27zW7ewd5x2Qz+VobMyEpC/RNSBdb4NVFO0Qw71omOS1XWCPdWyWOCaAMdMn5fl6SEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geDeJaHi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718026478; x=1749562478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBvR9McWmov7Rp1pdAQ23EgPGal3SUA9rAXjWP/q4hI=;
  b=geDeJaHir/XCeEBJm7OFl3PNJf1A+lSsBEGGITVGd0XCHSNpVc1zljxZ
   NKGiIVmAPj3BS/M0tfCILvKy2zMzYxgBJWgzpQTGSzRqTxPhLICx4bLCp
   BQy/h96AtSOw+tmd8HJdjMQ+AbogsP9nbQdDCBETITysFkXwXuXHi+nu3
   KzObExr7Ka6HRDMDbdkbWHtWPjW97+m1vCzBE4BXfenPKWEIV4oflYpES
   al8MRY87X6Sn0kFrTBaRN3VrGza7tk3srMIYHl3C05kv3ldMsaGy4sa3m
   s7MZuMTr/Xw4fl2fkkR4xdg/e+O1WGgSR3ojKQfXwuETWNWO+zcOUTt3e
   g==;
X-CSE-ConnectionGUID: 6ygCGE+OTRSPu+UF0S4fyw==
X-CSE-MsgGUID: 4n7JtOhERXCXU8rprEH98w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14858569"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14858569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 06:34:19 -0700
X-CSE-ConnectionGUID: O5yUHhQhS7CSCilTyKpjfw==
X-CSE-MsgGUID: dsZ5qsK+RWa+0bz7LZirEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43503465"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jun 2024 06:34:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6C95A1FD; Mon, 10 Jun 2024 16:34:15 +0300 (EEST)
Date: Mon, 10 Jun 2024 16:34:15 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Message-ID: <b7bz3ix3yqmc5xla7ldnxu3lsvvqzlxigq2po2dqkoejucppj3@fbaw37ilwpkr>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>

On Tue, May 28, 2024 at 01:09:19PM +0300, Kirill A. Shutemov wrote:
> Currently, attempting to perform MMIO from userspace in a TDX guest
> leads to a warning about an unexpected #VE and SIGSEGV being delivered
> to the process.
> 
> Enlightened userspace may choose to handle MMIO on their own if the
> kernel does not emulate it.
> 
> Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS
> instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

