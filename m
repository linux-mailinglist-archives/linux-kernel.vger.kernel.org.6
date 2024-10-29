Return-Path: <linux-kernel+bounces-387180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F6A9B4D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3261928696E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C5192D73;
	Tue, 29 Oct 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmP88U1v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F649192B7F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214696; cv=none; b=sw8gggDspC+CVhbLFbEdaItGoorhCN0JVWgmmWBB4laEyd1PcIVC5KhNxYtbXLKtkkyL9HbHe/cNfi4Bx7Lb4hfCGzZGhkioVDRlipYBhBpGrdLtuevV7sRS03DdU3EYBHcT4J0/pKg4UdmN8tWTYn7HOfpqDLEX3S1TC0BMclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214696; c=relaxed/simple;
	bh=2q5KKYy4yeTF3GakiePokmKgbkxH6oTt+zSdu1gzpXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP5o7J9hKvGd87xOOK5yg9S78Erl4MNjVPfjuYOjUXTZMcz650dUUUM+LGnqvp0AhcXnRCJPX/TxkbZYoVjAQMNmamcx8d68Nj7tfG2JSjqIoBC1naIma+RdO/Bd1R0zawLJOYT1gg4+A5GfmgQu3X/0BcPNjYIUYK+VLm/DrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmP88U1v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214696; x=1761750696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2q5KKYy4yeTF3GakiePokmKgbkxH6oTt+zSdu1gzpXg=;
  b=kmP88U1v2b4/12KwJ97fB2yRhKt0poHrnHRq+0TxXxiBCoq6QhGXKQ8M
   F5uV01zecvducd8JtcZSAFWf9DAbGEuaGkf9ttOeIUJjSy2Ng4L5h8b1+
   U6d8+2JInu3RCvzgMqmHLmKLgeqcx7L/H3QtW+Vf3ESY4X/8aj7PulYgr
   9D2B6sdgvkySolESiy8dLN1SnpXprwb6cyNsUicB6Q0jwGYJ6ynMOMkwh
   Eqqgr7xiqVlaL1i+ViqNp5TziYiPeEjYvmbhF+swvLSIJYna02Kcu3nIV
   GhcUfL9/Rks3BX9JzbaYJidVMpGGL06/+b0yu9+a7rUFUER/dGtjdcdYZ
   A==;
X-CSE-ConnectionGUID: Qf7aCX5xSXGzIl34bIi7yw==
X-CSE-MsgGUID: +0N4a7lKSUWotjdoaFSeRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30000443"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30000443"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:11:34 -0700
X-CSE-ConnectionGUID: MT3LfDL/SCukJ7cmlaApYQ==
X-CSE-MsgGUID: pXGasDdnRNiq0RtrfeDzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82058303"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Oct 2024 08:11:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 22FF526B; Tue, 29 Oct 2024 17:11:26 +0200 (EET)
Date: Tue, 29 Oct 2024 17:11:26 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Chan <ericchancf@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Samuel Holland <samuel.holland@sifive.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCHv2 0/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <j54jizfjzubkejbkobyryl33i4ejhoek4ynshtethkiidkx7le@2p22g3fxxedz>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>

On Mon, Oct 21, 2024 at 01:57:21PM +0300, Kirill A. Shutemov wrote:
> Make memremap(MEMREMAP_WB) produce encrypted/private mapping by default
> unless MEMREMAP_DEC is specified.
> 
> It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.

Ping? Any feedback is welcome.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

