Return-Path: <linux-kernel+bounces-543270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B3EA4D3AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247B11893D89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF891F55F8;
	Tue,  4 Mar 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWsOxRny"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89F152E02;
	Tue,  4 Mar 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069217; cv=none; b=eRVGUpmDiZ8zDfw0+Dj31hIySpYVeHavaJV0odGXbUen3aHy+GuZmCMgVFZ+eeXrWxrUsepqDEp0+NWvsVbygsb3EMrIckq0aY52+iHj4c/KqPl37+tr9N/gfHNfaGpEjyCIaINRQrFFEqAZ4ByUrflbdfemIa7XI/x6q6BHV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069217; c=relaxed/simple;
	bh=SKTfUxiDVoQrUXmMNuNlIric4cD5/FdL5HKEoC1ByIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEHSUSqGmBIERW/mW4adhGIPf1us2OLTg8ZbjdOLE8XZuhq7kvrcn6YUIZA15LfOGe/tf14VcGWKbhm+P0NB1ufVwia03kP5fXvrKNjue8x4nt+EhkgXuDQZ+LOtB4bU2RMhHLEIsniqF8H2TtX55ZOWx5iIqSNOfP21+wa9Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWsOxRny; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741069216; x=1772605216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKTfUxiDVoQrUXmMNuNlIric4cD5/FdL5HKEoC1ByIc=;
  b=FWsOxRnytkXFDEggYcRMaKrJ3QA9DFcAmh3G1ZQPFU6KFXFumjDKq2AW
   kA6U/M+UWzjx8VR+/U+OohhpwOreJQxO702nXh5PcuvTXh1tWz48hzqy2
   a++4F91Ar4ahlSf9O5KQ7eLTfnW3rlsDogXumdGAsSFJ+bU/jHb4F8pfg
   kD6vIphMaeLT6VZNQPerqqY7NKvzmYg5JfTF+MDau8HdBq2Sis6RrxqEW
   fyHCnnqITdWTQwlQ1Nx699oucfCRuy/xs8g0vfCOeoiOGo54G3Y4XHRhw
   hkaDqk38nlU+f/wxp0ZhADFv0xRgvLThOaHYDmJ13d/XoHVoVPmHUFakK
   A==;
X-CSE-ConnectionGUID: H/kmhRfxR6CIaRMjhXFBzg==
X-CSE-MsgGUID: aw6TnQeRRm2SMwgQKK53lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42164581"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42164581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:20:15 -0800
X-CSE-ConnectionGUID: oofMHzU/Sm6Dh61WCLy3SA==
X-CSE-MsgGUID: i+lX7EqAQaO6sGJC3ohPkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118260140"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 22:20:13 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpLdS-000JLK-35;
	Tue, 04 Mar 2025 06:20:10 +0000
Date: Tue, 4 Mar 2025 14:19:56 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Mangold <oliver.mangold@pm.me>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
Message-ID: <202503041325.UnOn2m7a-lkp@intel.com>
References: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>

Hi Oliver,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Mangold/Rust-Implement-a-unique-reference-type-URef-supplementing-ARef/20250221-160625
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A%3D%3D%40protonmail.internalid
patch subject: [PATCH] Rust: Implement a unique reference type URef supplementing ARef
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250304/202503041325.UnOn2m7a-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041325.UnOn2m7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041325.UnOn2m7a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: docs for unsafe trait missing `# Safety` section
   --> rust/kernel/types.rs:546:1
   |
   546 | pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_doc
   = note: `-W clippy::missing-safety-doc` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::missing_safety_doc)]`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

