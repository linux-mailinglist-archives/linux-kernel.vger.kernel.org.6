Return-Path: <linux-kernel+bounces-370529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE729A2E15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F8E1F22FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A51DFE2A;
	Thu, 17 Oct 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA9jGwzv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4071C1ADA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194888; cv=none; b=s7vFY+t9j2Mu+sC/8JeKvj1pFD4cGOk7paDW2Pq4RFnMkuf9O5sraAmzZMLM3rDH8/XGhAmWqX9n4oSlQAv8s9UffVsoKcw5ZFsF+DZtX316BEuWmYDlhqtFR1OOTNS9A8/TqZdwslA08k8LVL6WTbvOk+AfR+s77v5qszsXaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194888; c=relaxed/simple;
	bh=inf6oEVpQu7kYPHpuVZYWdX0dPiFU3NRzNLHStlAXCg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mb0LLcMM3F+OKi3hu4OwYihB/msZcFwtF7rRpX+HICpuXr/yZ593fenCBgiudZBTfXRYFBPuljLH/+gzQex1jVCi7HUFwlBsHopRQbvQ6+5/+TKVoINt1fQVu8qx0F6KqA/28mc+5k49ntjSIL3VmKqubRNXEncnyPZE8LvFehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA9jGwzv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729194887; x=1760730887;
  h=date:from:to:cc:subject:message-id;
  bh=inf6oEVpQu7kYPHpuVZYWdX0dPiFU3NRzNLHStlAXCg=;
  b=aA9jGwzv/rscu5IxqsGztCPds2WKG0Qm+nV4LlS4ocaEKJICrqZ5clKT
   Y8GL86slWeA8iBH0zZpqO/1+DnRThK6/pgs2WJ/ER5EXhn1+MsT8N+xe/
   A38HJAd2W+APhjOYGx0Gr+zD8VHxillQKiD35vn66uYoJmWPkWKlPC9kC
   L7q3e66Msqk/W5KzR45geeGn8fK8BOnPsPWm+8R4TfJfzc84sZMPdFtiE
   Cvs97hjFTQKTZvd/rSMkSz+s4D5udt2utPGO3y/a7GThiVXX0cFc5euy7
   rsSebZiY+8i4VK6s3IVVANrQODHLLxvWcXE+N4Z8iubgnFqEN9VjRyKNO
   w==;
X-CSE-ConnectionGUID: 06YcGk2PTyC0zcb1EkFMQw==
X-CSE-MsgGUID: SY6C+P3vQX2eGwJ75khYCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28856652"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28856652"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 12:54:46 -0700
X-CSE-ConnectionGUID: Aj2fD4IDT6evV/EQIbrtTQ==
X-CSE-MsgGUID: QTxIa1irRFq4Ig+Mhuz7kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83209248"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Oct 2024 12:54:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Wa2-000Mqx-2t;
	Thu, 17 Oct 2024 19:54:42 +0000
Date: Fri, 18 Oct 2024 03:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2] BUILD REGRESSION
 41fe8a04339b3781dca5a8ba323ba77022acc441
Message-ID: <202410180306.jXlxlTRO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
branch HEAD: 41fe8a04339b3781dca5a8ba323ba77022acc441  uapi: net: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410171308.VlSadp8v-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202410171314.IhaS4oSI-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202410171407.Vjuq5QX1-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202410172103.ZqzfeZN1-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202410172107.g265uYlG-lkp@intel.com

    drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:2: error: call to '__compiletime_assert_1076' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
    drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to '__compiletime_assert_1077' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
    include/linux/build_bug.h:78:41: error: static assertion failed: "struct member likely outside of struct_group_tagged()"
    include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_854' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
    include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_855' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
    include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
    include/rdma/uverbs_ioctl.h:643:1: error: static_assert failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)' "struct member likely outside of struct_group_tagged()"

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-002-20241017
|   `-- include-rdma-uverbs_ioctl.h:error:static_assert-failed-due-to-requirement-__builtin_offsetof(struct-uverbs_attr_bundle-attrs)-sizeof(struct-uverbs_attr_bundle_hdr)-struct-member-likely-outside-of-stru
|-- hexagon-allmodconfig
|   `-- include-rdma-uverbs_ioctl.h:error:static-assertion-failed-due-to-requirement-__builtin_offsetof(struct-uverbs_attr_bundle-attrs)-sizeof(struct-uverbs_attr_bundle_hdr):struct-member-likely-outside-of-s
|-- parisc-allmodconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- riscv-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256
|-- sparc-allmodconfig
|   |-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256
`-- x86_64-randconfig-123-20241017
    `-- kernel-bpf-core.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-base-types):

elapsed time: 1464m

configs tested: 2
configs skipped: 0

tested configs:
x86_64     kexec    clang-18
x86_64  rhel-8.3    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

