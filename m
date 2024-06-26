Return-Path: <linux-kernel+bounces-230007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BAA917736
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035C5284176
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DE13A404;
	Wed, 26 Jun 2024 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7nzxwK6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1A33CFC;
	Wed, 26 Jun 2024 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375683; cv=none; b=dlV+ijcwlOcDcDixBDAdHcUDXoLINuJ+RMUfHlVYJaN9FIKyuzwLu+c061Pd518l/kVcVKJSRlkdkVaJzqznXM+Ni5hmPFJCwNmVQVpM1TJQZUBFK0cfjsjRR9j35cnehuC/IOWBL5RxRUw+aIUm5VQ2IUgMtF7ZY7JMSvXyjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375683; c=relaxed/simple;
	bh=Yz3MlfJG2BhYwuDYDp011mvqwoaVZRUustBqjrMx34M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/pWYmG3q7knLpTjLjCLnA21Ndx4R3+Yt0Jj3rl9Vf0OFT7dM0qC8BvdDDTvyW56eycTjWJj1EAaLlkqvoMKKABnjYVx5r6/6LMAQiIbtBuXMb+jTYdGiLmCRt9NzeRdVDkpMgweXnLvWRFS4I92TZFV2mJN+NNDjPzTD/Tgr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7nzxwK6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719375681; x=1750911681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yz3MlfJG2BhYwuDYDp011mvqwoaVZRUustBqjrMx34M=;
  b=Q7nzxwK6jK3wy6LJanHI4KmiY7ZBntpclBT2edUtcRfDrvibXarhz2Kb
   8r8L1yw/Q9QHPRfjr5zB05ntlNrMHFscuVQ+TarSRY6YxteQ2RZpy9trn
   b6dtnMept32nnELNsFN/4SaCKqIJbk4CqVmKH3MvL4I6280El4VL8tls7
   FAx6AgfmT0cPuxJAer1YuQ4x3XlfYlOA8dUQIEplJl4FqNHK7fNPAy0bc
   LB54T/HKjhubAZqNa3Oo5bsWSCXb2WCrqYRVwawbdo7eRMgpfujRymK6/
   cd0VtpEe4XQ44EnDPjuXznI/UZstU4lv99LI5GXprlQkZJ+XvpW4j997O
   Q==;
X-CSE-ConnectionGUID: jX/ZHGgZT9+UXLawmhyDJQ==
X-CSE-MsgGUID: TGcnYFxKQJ+dYWg9JIT8Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="38940396"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="38940396"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 21:21:20 -0700
X-CSE-ConnectionGUID: +8eUPmsXS3WmwCCzRKgP/A==
X-CSE-MsgGUID: HOv0waBtR8y8G+++wxQYaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48847102"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2024 21:21:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMK9i-000EyU-03;
	Wed, 26 Jun 2024 04:21:14 +0000
Date: Wed, 26 Jun 2024 12:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Ethan D. Twardy" <ethan.twardy@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/4] kbuild: rust: Expand rusttest target for macros
Message-ID: <202406261127.VzakF8rL-lkp@intel.com>
References: <20240624030327.90301-2-ethan.twardy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624030327.90301-2-ethan.twardy@gmail.com>

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a126eca844353360ebafa9088d22865cb8e022e3]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-D-Twardy/kbuild-rust-Expand-rusttest-target-for-macros/20240625-230535
base:   a126eca844353360ebafa9088d22865cb8e022e3
patch link:    https://lore.kernel.org/r/20240624030327.90301-2-ethan.twardy%40gmail.com
patch subject: [PATCH 1/4] kbuild: rust: Expand rusttest target for macros
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240626/202406261127.VzakF8rL-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261127.VzakF8rL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261127.VzakF8rL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> rust/Makefile:151: warning: overriding recipe for target 'rusttestlib-build_error'
>> rust/Makefile:143: warning: ignoring old recipe for target 'rusttestlib-build_error'
>> rust/Makefile:171: warning: overriding recipe for target 'rusttestlib-uapi'
>> rust/Makefile:156: warning: ignoring old recipe for target 'rusttestlib-uapi'


vim +151 rust/Makefile

    59	
    60	core-cfgs = \
    61	    --cfg no_fp_fmt_parse
    62	
    63	alloc-cfgs = \
    64	    --cfg no_global_oom_handling \
    65	    --cfg no_rc \
    66	    --cfg no_sync
    67	
    68	quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
    69	      cmd_rustdoc = \
    70		OBJTREE=$(abspath $(objtree)) \
    71		$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
    72			$(rustc_target_flags) -L$(objtree)/$(obj) \
    73			--output $(rustdoc_output) \
    74			--crate-name $(subst rustdoc-,,$@) \
    75			$(if $(rustdoc_host),,--sysroot=/dev/null) \
    76			@$(objtree)/include/generated/rustc_cfg $<
    77	
    78	# The `html_logo_url` and `html_favicon_url` forms of the `doc` attribute
    79	# can be used to specify a custom logo. However:
    80	#   - The given value is used as-is, thus it cannot be relative or a local file
    81	#     (unlike the non-custom case) since the generated docs have subfolders.
    82	#   - It requires adding it to every crate.
    83	#   - It requires changing `core` which comes from the sysroot.
    84	#
    85	# Using `-Zcrate-attr` would solve the last two points, but not the first.
    86	# The https://github.com/rust-lang/rfcs/pull/3226 RFC suggests two new
    87	# command-like flags to solve the issue. Meanwhile, we use the non-custom case
    88	# and then retouch the generated files.
    89	rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
    90	    rustdoc-alloc rustdoc-kernel
    91		$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
    92		$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
    93		$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
    94			-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
    95			-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
    96			-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g' \
    97			-e 's:<a href="srctree/([^"]+)">:<a href="$(realpath $(srctree))/\1">:g'
    98		$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
    99			echo ".logo-container > img { object-fit: contain; }" >> $$f; done
   100	
   101	rustdoc-macros: private rustdoc_host = yes
   102	rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
   103	    --extern proc_macro
   104	rustdoc-macros: $(src)/macros/lib.rs FORCE
   105		+$(call if_changed,rustdoc)
   106	
   107	rustdoc-core: private rustc_target_flags = $(core-cfgs)
   108	rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
   109		+$(call if_changed,rustdoc)
   110	
   111	rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
   112		+$(call if_changed,rustdoc)
   113	
   114	# We need to allow `rustdoc::broken_intra_doc_links` because some
   115	# `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
   116	# functions. Ideally `rustdoc` would have a way to distinguish broken links
   117	# due to things that are "configured out" vs. entirely non-existing ones.
   118	rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
   119	    -Arustdoc::broken_intra_doc_links
   120	rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
   121		+$(call if_changed,rustdoc)
   122	
   123	rustdoc-kernel: private rustc_target_flags = --extern alloc \
   124	    --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
   125	    --extern bindings --extern uapi
   126	rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
   127	    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
   128	    $(obj)/bindings.o FORCE
   129		+$(call if_changed,rustdoc)
   130	
   131	quiet_cmd_rustc_test_library = RUSTC TL $<
   132	      cmd_rustc_test_library = \
   133		OBJTREE=$(abspath $(objtree)) \
   134		$(RUSTC) $(rust_common_flags) \
   135			@$(objtree)/include/generated/rustc_cfg $(rustc_target_flags) \
   136			--crate-type $(if $(rustc_test_library_proc),proc-macro,rlib) \
   137			--out-dir $(objtree)/$(obj)/test --cfg testlib \
   138			--sysroot $(objtree)/$(obj)/test/sysroot \
   139			-L$(objtree)/$(obj)/test \
   140			--crate-name $(subst rusttest-,,$(subst rusttestlib-,,$@)) $<
   141	
   142	rusttestlib-build_error: $(src)/build_error.rs rusttest-prepare FORCE
 > 143		+$(call if_changed,rustc_test_library)
   144	
   145	rusttestlib-macros: private rustc_target_flags = --extern proc_macro
   146	rusttestlib-macros: private rustc_test_library_proc = yes
   147	rusttestlib-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
   148		+$(call if_changed,rustc_test_library)
   149	
   150	rusttestlib-build_error: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 > 151		+$(call if_changed,rustc_test_library)
   152	
   153	rusttestlib-uapi: $(src)/uapi/lib.rs \
   154	    $(obj)/compiler_builtins.o \
   155	    $(obj)/uapi/uapi_generated.rs FORCE
 > 156		+$(call if_changed,rustc_test_library)
   157	
   158	rusttestlib-kernel: private rustc_target_flags = --extern alloc \
   159	    --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
   160	    --extern bindings --extern uapi
   161	rusttestlib-kernel: $(src)/kernel/lib.rs rustdoc-compiler_builtins \
   162	    rustdoc-alloc rusttestlib-bindings rusttestlib-uapi rusttestlib-build_error \
   163	    $(obj)/libmacros.so \
   164	    $(obj)/bindings.o FORCE
   165		+$(call if_changed,rustc_test_library)
   166	
   167	rusttestlib-bindings: $(src)/bindings/lib.rs rusttest-prepare FORCE
   168		+$(call if_changed,rustc_test_library)
   169	
   170	rusttestlib-uapi: $(src)/uapi/lib.rs rusttest-prepare FORCE
 > 171		+$(call if_changed,rustc_test_library)
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

