Return-Path: <linux-kernel+bounces-570420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C5A6B023
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323DF3BE929
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFF22A4F8;
	Thu, 20 Mar 2025 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHJklZCd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307B21D59B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507193; cv=none; b=NqTDNyG2yLC6vH0dKSp/bBf2N/9eTdkQXhBm6//ZdOMQEd+KkRA5bUYu5y6snRNAkuQ77ok/vKXJE3Z1z8rxW0O44AjPnPSkzjukTvNEKHjRmK8Sik4zeUVg8l85BboqeRUnDSRkC2RsipSB3hh26/eYGXjldedoUFMKAghcY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507193; c=relaxed/simple;
	bh=fG6ALNWknG0HB6n9+duDH0Qkh+TNCnyz7MyjxbEtwuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fsVQMQjs4sxeZKtSoQIP2tUOkm9qpn7u6oGHTa7Glq+XS4Xu0/MQ3MrjZD9uLLoIA9BpRQ0WEPyGU9DhKHQHlQy8IQNj90E33V6Wis5w22cre7fCifCilZbxXtWn3XjbWkOm+s8alswSbR6CczTAZlDtXDbD6Gqy9hrrCsg6+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHJklZCd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742507192; x=1774043192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fG6ALNWknG0HB6n9+duDH0Qkh+TNCnyz7MyjxbEtwuw=;
  b=FHJklZCd807Q6toCVqkM8uiWnO6H06JiErGhfn3MN3O/3NdW06JNSM+q
   yDAg5vGKaliOVYhVd1ktn8x6qbMu9TJ2rbeHoti2w24XKr2lPwi6Td6c8
   6OBt/trOQ1tqYLBrmuYXdBCf2kATpOE/KsbxNp93MCC01f4HMdjyEtAGh
   n6tVX5GCofrks71rZ0oFzsp+v61jvhUNttdzaU4cFz8Lgw/l6r/n/g9Ne
   dcFJWhRhKfR5BTkLGd+VBuLusYK83NfM8D9/3alI8Lqil/tFoQGZySKiw
   Yr7hPR6m92B5ve3wshKAkm+DDJCHVjItrUUkWzt4pPxomwnpoAdVkEyYL
   w==;
X-CSE-ConnectionGUID: W8piFuBcSXe/9daxE6/0sQ==
X-CSE-MsgGUID: PIru6bTTSWOXbYvrR0jQUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="46517514"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="46517514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 14:46:31 -0700
X-CSE-ConnectionGUID: OsqT4JVtQGqk2/ZBqE/ETg==
X-CSE-MsgGUID: aCil67QeQCu+MRqe8eUexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="160449884"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 14:46:29 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvNid-0000nP-09;
	Thu, 20 Mar 2025 21:46:27 +0000
Date: Fri, 21 Mar 2025 05:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>, Rong Xu <xur@google.com>
Subject: (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26
 against `no symbol'
Message-ID: <202503210518.c0mKdawI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5fc31936081919a8572a3d644f3fbb258038f337
commit: a412f04070e52e6d6b5f6f964b9d9644de16bb81 openrisc: place exception table at the head of vmlinux
date:   3 months ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250321/202503210518.c0mKdawI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503210518.c0mKdawI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503210518.c0mKdawI-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/openrisc/kernel/head.o: in function `_dispatch_do_ipage_fault':
>> (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   (.head.text+0xa00): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_dtranslation':
>> (.init.text+0x21bc): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_itranslation':
   (.init.text+0x2264): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   init/main.o: in function `trace_event_raw_event_initcall_level':
   main.c:(.text+0x28c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strlen' defined in .text section in lib/string.o
   init/main.o: in function `initcall_blacklisted':
   main.c:(.text+0x6f4): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strcmp' defined in .text section in lib/string.o
   init/main.o: in function `trace_initcall_finish_cb':
   main.c:(.text+0x818): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x83c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x87c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x8a8): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/14.2.0/libgcc.a(_muldi3.o)
   init/main.o: in function `do_one_initcall':
   main.c:(.text+0xec0): additional relocation overflows omitted from the output

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

