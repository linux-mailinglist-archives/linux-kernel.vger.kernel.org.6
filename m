Return-Path: <linux-kernel+bounces-412655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878B9D0C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58EEB239F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DE1917D9;
	Mon, 18 Nov 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPgUOfRA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F522083
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922991; cv=none; b=XQXc2kGkJMe2iKxqmmBLgPbNpY9Kr05VMnh0/ZxSLqu8p0pWpo3N3mp+goRkocveWn+iZ1BkDnp6L/tj88c7T361YzqH5sbfO1zFcJgP0XZOwM4hzI7GaJunSEu26Ci191AJ9v7rQTBDQzjhrc48dJbOnHZsKVWRXRKCyue2uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922991; c=relaxed/simple;
	bh=2m33SZvlePmlt6YGusHzLVJNac4WE8TIk+QuRV1Woeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l45LCrBtRHAPMXLXoVx9HMzIlne+cC4Xvd/wHJ90IiJRKE2UQCq6abjN4IaQ0OPidkq1GnikgprZb9/UBKP+myqFqYzjlR0fhTT74v5m0UVZg9nixPzH+K1SuuX963mp0TKEW0Nhf5n0BC7wyltTUx3chWo8SRwCg3vdnwzK4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPgUOfRA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731922990; x=1763458990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2m33SZvlePmlt6YGusHzLVJNac4WE8TIk+QuRV1Woeo=;
  b=bPgUOfRAK8hcDEzYjRpu6YrzqF/iW2VI1V1QM/tJ8fxtDOU63y5Q1oIW
   6wd45wF4HBYaIVxuLNDWQoO8BIViB6Ax5wh6Wh/fPL9mEQN4gdD5G9cJJ
   V6As0oy/Co59Ld9xLk7aYdCSOamxlWFb0dDQAYbbeoHV8yxb9cqdCevEs
   53WKV2XADm58uo5gedn2GkceOaHZ6PEtVUxfxnva/Uda9f/1dHtJrpUN2
   FBOdWzqpUYLoJvmXQbnTeCftAQXr68EqqfQOa72d8A5CQoQJFH1mSrZvL
   MJpAobLA+SKtC8WtmXVGoaY2/TWkMh+g4ICVL6865BAsJ308H43n5nt8A
   A==;
X-CSE-ConnectionGUID: 5c+DW0SmS1mSYrtvQE86Cw==
X-CSE-MsgGUID: XqJbrynIRrWPyvLy1QC2Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31246883"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="31246883"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:43:09 -0800
X-CSE-ConnectionGUID: 47+CdCU3R/Kuq822McxOBw==
X-CSE-MsgGUID: jI1nU6ebSQmW/RTXAG2Z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="93996397"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2024 01:43:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 30C9F277; Mon, 18 Nov 2024 11:43:02 +0200 (EET)
Date: Mon, 18 Nov 2024 11:43:02 +0200
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
Message-ID: <oh7zs7c4drl7i35dt3bxunqhlefrmcej7yd2bjxvdzpnqgtyk6@qkl6vvipa54d>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <j54jizfjzubkejbkobyryl33i4ejhoek4ynshtethkiidkx7le@2p22g3fxxedz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j54jizfjzubkejbkobyryl33i4ejhoek4ynshtethkiidkx7le@2p22g3fxxedz>

On Tue, Oct 29, 2024 at 05:11:26PM +0200, Kirill A. Shutemov wrote:
> On Mon, Oct 21, 2024 at 01:57:21PM +0300, Kirill A. Shutemov wrote:
> > Make memremap(MEMREMAP_WB) produce encrypted/private mapping by default
> > unless MEMREMAP_DEC is specified.
> > 
> > It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.
> 
> Ping? Any feedback is welcome.

The patchset fixes crash. Please consider applying.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

