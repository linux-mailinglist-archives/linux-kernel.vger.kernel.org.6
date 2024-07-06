Return-Path: <linux-kernel+bounces-243020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58639290A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501481F2250F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB196134D1;
	Sat,  6 Jul 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3wu35Pe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79982BA4D;
	Sat,  6 Jul 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720238433; cv=none; b=SIexvU+jc29vYnMoOSv/JJPKn/DlJsn1G0R/Bgn5autVVR9xmHLSRfpIB47q07uZSy9YEmhm21GWFqpDBh5Ubgw2KyQJCuYnkt6nc01XotLE4p9BzVa/rqTOk8zTQ/brLmueh+MpihhPCRLBoiMsNed0+l1Fc/y++1UTRBcyveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720238433; c=relaxed/simple;
	bh=tL0HpoCPbOh7JohmFkRuaLDytaWHjSmVWu8yOhp2tq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngdc09wHXU/DFDDp8C4jNXIcWvCWH91JO+Z1GZEcVVQyZLyiJ8dUl3ntr5rgq0AvxVDGYiKWRv80xSlqoNhkLX16/SUu3e8Hamyn49dzHJhAkV84gdCXIlhK1eL31VlObtVJCvHp2exYwRMhfteCEKllAg5jxr9yBH5Azz7WU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3wu35Pe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720238431; x=1751774431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tL0HpoCPbOh7JohmFkRuaLDytaWHjSmVWu8yOhp2tq4=;
  b=c3wu35PeG1rICJ6calmq9NMxVGGhNd/c20n3bAOmN7oU0YN30m7wjTLf
   G1zKr5+xMTbJQyjj7zU+Gg78bju0TFmNQYm0g4o00cz3NAO6fLC0+xSeo
   GVMeaMdQZE8FRaJ8clvxY3uUNbCP2aeUPZ9GI/kiRWgRNfu98YK9v+O6I
   oO4/eXmb2mr5VuyB2Rp7p1xfJ1fMgcqberJzB8b2ZNASIR3PnHQjQnrq4
   c82vOrsVDz8EX4CqB7ennDzYnt2mh9JaiXehHjFufloGlLCEL9e+BNjAs
   illiL+2owX2jsuWsR6ByJ/o0sA+QkJpNW+bzqMDIkAbB9yLMEsH8A8StA
   w==;
X-CSE-ConnectionGUID: jH3I1mC0TUGU5O0+s2K0+A==
X-CSE-MsgGUID: 7Gy2eNB1RbqiAbnHIgMTnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28910667"
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="28910667"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 21:00:30 -0700
X-CSE-ConnectionGUID: MMc13cwyT/2G7WFvgxK13Q==
X-CSE-MsgGUID: QWHHvSaNSyuuVw2zi3Rw9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,186,1716274800"; 
   d="scan'208";a="47004640"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2024 21:00:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPwb1-000THw-18;
	Sat, 06 Jul 2024 04:00:23 +0000
Date: Sat, 6 Jul 2024 11:59:33 +0800
From: kernel test robot <lkp@intel.com>
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com
Cc: oe-kbuild-all@lists.linux.dev, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH 20/20] kbuild: rust: remove the `alloc` crate
Message-ID: <202407061152.YNTsL28i-lkp@intel.com>
References: <20240704170738.3621-21-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704170738.3621-21-dakr@redhat.com>

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/rust-alloc-add-Allocator-trait/20240705-155308
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240704170738.3621-21-dakr%40redhat.com
patch subject: [PATCH 20/20] kbuild: rust: remove the `alloc` crate
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240706/202407061152.YNTsL28i-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061152.YNTsL28i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407061152.YNTsL28i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unresolved link to `alloc`
   --> rust/kernel/alloc.rs:3:25
   |
   3 | //! Extensions to the [`alloc`] crate.
   |                         ^^^^^ no item named `alloc` in scope
   |
   = help: to escape `[` and `]` characters, add '' before them like `[` or `]`
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

