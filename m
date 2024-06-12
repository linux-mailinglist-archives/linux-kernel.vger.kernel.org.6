Return-Path: <linux-kernel+bounces-211296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB01904F98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E5C283C72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644D16DEC8;
	Wed, 12 Jun 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg5U1lky"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC415BB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185864; cv=none; b=CbN4cmkZGPWQSWsdCnSiIGHZdMNU6b2TIKYZu8bAacd5T3qEqLDQwjXuSRF/jXB9N+b7/RjeHjE6buCqxSMncLgS77vweEWyjVyE84CWwgrYqAqJg8ZB0lDUTTtWR+qIR5wUXxCzXiumAqH/Ys/lBkLIv7TA2GpKX1XfI3E9mWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185864; c=relaxed/simple;
	bh=EHuBceC3NjDWceIKSIK6pbNtuCAqnM4qibuojYESsl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqSKOQixhXtLu3jfnPh8/PabBdXRl1Uh8Q5y755uo9O2nimDmk39MhGYe7Mml4oSF6i1f1PrezGHeKEAo+zDla+l2VigK48Cjmx8umKR9mz4YLuZMe0wWi1A04XmWTkqEAzZr772PohwlK2KoO42tH8KeD+h/pJmJq7TPa+T+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg5U1lky; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718185863; x=1749721863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EHuBceC3NjDWceIKSIK6pbNtuCAqnM4qibuojYESsl8=;
  b=Rg5U1lkyGG0MmdYOEhCI7+ijTzMrDarIDBQRi9uvamLUwCvtRqgv6OEh
   7XKeafDC0JyUwT66yRyieXsk4yLj2+4LqCxTv0v9Yq+SPUnSlcqp7dc0i
   8kZoZ0nNapNCUSz1F/r05cGJImxwMPFNbeyYin+UWOdgf+6ABx2DEWoPr
   dFmfjFeE61qI2XAD0h1eXQ7yP40lkUe4RCPwsrTIWhY5ixVQF2BSA0/fy
   r60hssLLYjYtl0uBjyEbJw3RIxo0mIS6OcJYIYR/L+vuMJYz39NNCw893
   5EO1YYB9af5hy4IeeoGs85L5pnIEAX6vvJzzujfyutJfNl31mC4LXujsF
   Q==;
X-CSE-ConnectionGUID: Io3P2i3xSDaUhyFDSvVCmA==
X-CSE-MsgGUID: tzC4uUiGRNCD1D11v9C58g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25515636"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="25515636"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:50:47 -0700
X-CSE-ConnectionGUID: qT6IuxotQDGhM6T4gjLDlA==
X-CSE-MsgGUID: r20d6CkzRe6xjmst9jHkWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="44643649"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2024 02:50:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4E81C193; Wed, 12 Jun 2024 12:50:43 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:50:43 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com
Subject: Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Message-ID: <mpbfcnfnqthq32rsn57ge2ypkhzpa3kqxpr2u3rqodxur66voy@zsavzwkxqkhz>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
 <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>
 <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>

On Tue, Jun 11, 2024 at 09:16:13AM -0700, Dave Hansen wrote:
> On 6/10/24 06:55, Dave Hansen wrote:
> >> Enlightened userspace may choose to handle MMIO on their own if the
> >> kernel does not emulate it.
> >>
> >> Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS
> >> instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.
> > Is any userspace _actually_ doing this?  Sure, SIGBUS is more
> > appropriate but in practice unprepared userspace crashes either way.
> 
> I also can't help but wonder if there's a better way to do this.
> 
> Just thinking out loud.... Ideally, we'd reject creating a potentially
> troublesome VMA at mmap() time.  That's way better than, for instance,
> panic()'ing at some random place in the middle of program execution.

I am not sure I follow.

panic() is only for catastrophic cases: VMM pulled memory from under us or
we mapped unaccepted memory into userspace. It should never happen.

We have the same check is_private_gpa() in virt_exception_kernel().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

