Return-Path: <linux-kernel+bounces-264122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2193DF22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9AF28124C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01826F2E0;
	Sat, 27 Jul 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMeV99EI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B24CB37;
	Sat, 27 Jul 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079293; cv=none; b=hCbxi4u2rtiEUEpdR4yaaBYrmlaigX3MvKu6ViJ1Qg1+1RYMmyzCkgIKMZTspTVplKh2ZxEx2HoIQYVxUhgIhwFpL79Q0KqXYToXlmQOqpa4y8sedMR1AlF1Tvd9FuG5lTdvGbQorgbMW3Dy4gHu5wyAUQJgE2z3uGcJaQkd5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079293; c=relaxed/simple;
	bh=Np9BXsfpZ4ED8CIWS5ZU5lyVIGmxSf2WKXevqzEFx4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq/lHkgcz9vjQ+v4toRGEuAnMGz7EpbvucBc7iiR3jGtTVDTBQDJpzr1yo63q/xfUFQzXNdoErQynfalV3C098TyOTJyT23xtJrAXnspRQuVnki5hHsBaeLNhd3AtxZG7mFGkuZKqq2YNnhbYfmk8lPHl4TNVYJs60vPMs2euN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMeV99EI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722079291; x=1753615291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Np9BXsfpZ4ED8CIWS5ZU5lyVIGmxSf2WKXevqzEFx4s=;
  b=nMeV99EIfyCjf7mO0bDqM5qrjGX13uaIBLWnaTOwaMqyEAkNNHERKdzG
   2D1sVjw7s/UbRoM3B19Uj6U/hAIy/0q10Hi+z1QAYsioor49U7EHXuvIk
   YlRcMcHO/Gkhy3yxgqOUzCyhW1NA7dwcuH9HGECnpR2v1+50jNts89owe
   yhlwpSR9z2C/0QgMpQJARNDFtUk4RGEis6KKvNL65JPf0dckSg+Vtzk/e
   f8lrdIyZQc/LwdITo7VenxYWBBKFw48jsm7WNTJu5Ci4Qv4ccON45mEt3
   2UfbH9SUmJ+uF/Lp711i+1IJLLyMnlKptLw/WsVICRLky5ZwcbRX66GOk
   w==;
X-CSE-ConnectionGUID: FuNlzBKfR2qf03hgYgEEOA==
X-CSE-MsgGUID: 8N64uqquRqq6lUfDLrRtbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="31259288"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="31259288"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 04:21:31 -0700
X-CSE-ConnectionGUID: uMFzfeUtQD+UFOZTZFeGgw==
X-CSE-MsgGUID: dwocBO3IR5yf8fF7fPZ1IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="58315801"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jul 2024 04:21:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXfUI-000ptc-2e;
	Sat, 27 Jul 2024 11:21:22 +0000
Date: Sat, 27 Jul 2024 19:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: sync: Add IrqSpinLock
Message-ID: <202407271842.ujYe0mc0-lkp@intel.com>
References: <20240725222822.1784931-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725222822.1784931-4-lyude@redhat.com>

Hi Lyude,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240725]
[also build test ERROR on linus/master v6.10]
[cannot apply to rust/rust-next v6.10 v6.10-rc7 v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyude-Paul/rust-Introduce-irq-module/20240726-064926
base:   next-20240725
patch link:    https://lore.kernel.org/r/20240725222822.1784931-4-lyude%40redhat.com
patch subject: [PATCH 3/3] rust: sync: Add IrqSpinLock
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240727/202407271842.ujYe0mc0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271842.ujYe0mc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407271842.ujYe0mc0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: mismatched closing delimiter: `)`
   --> rust/doctests_kernel_generated.rs:4097:34
   |
   4097 | let b = with_irqs_disabled(|irq| {
   |                           -      ^ unclosed delimiter
   |                           |
   |                           closing delimiter possibly meant for this
   ...
   4100 | );
   | ^ mismatched closing delimiter

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

