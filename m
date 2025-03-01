Return-Path: <linux-kernel+bounces-539926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3266A4AAEC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1D8189713D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04141DF25D;
	Sat,  1 Mar 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcK9hWMq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839371DE8B5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740832130; cv=none; b=NWI7rRHfIWccfvcbhNSA8/NqcViYv0fTxOgUWwTSst6M7rnqjZ2ktdOmrm4S7FMHgyqhx9SWqFcewt3q40Y8a9qLlabP4et36HVji/0qN3m1NLj3MS7ySCV4zYfPxFx6jHTvvOlnCIiqwNjSFx+0JcRcQaKY7kItV9LUI2tDRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740832130; c=relaxed/simple;
	bh=BtHaaJAKdO/dx9C3I30hhoUrqtfLoE3YIVIlzcRuiDk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tcr0Uoli2WHWzS2lbeCmPT1PqoRXWILNw1c1o6Thg5tQE7T7TxL7Y4mNjPkFH5xuoD6NkOajI+zCC3cyC97tOCO7oLDvHMVedltSsv2Zk+IGf2wsqYipYDGkHspG3+p6WxKa9bQFxOtuNg5hbFFi0cCkI7Xszta/envizQwg/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcK9hWMq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740832129; x=1772368129;
  h=date:from:to:cc:subject:message-id;
  bh=BtHaaJAKdO/dx9C3I30hhoUrqtfLoE3YIVIlzcRuiDk=;
  b=gcK9hWMqIQjCjtImhy9PzBnTDPgzw2vFpMQ++ZonpbOQpcr3OcCdocNA
   4N6bs6fM9CcJVYhUlQU03BU2srH1Vr7OzBZqGoWLEPvCJ4Yi6pWE11NLM
   erZKcmNNUXnXNrQjEUDXZALoN1nkdZc53welHNJELWFGcEySe1Ze3XmPq
   11l1D0KNBPz5+lyRJZPV/0KpKi1F1RpmzKH7wvzSzZ4wgVjpb2XeiMdCd
   hdyUPVNrSnsuF8uf0naHVykxFKPk/VEZErb08d2fxYhMHsz3v1J6plmok
   PkXOqUS1qZpvO4sGz5cOwzcOxAHFNwuyqlAb2AbijwezGKmJZNtA+jcci
   w==;
X-CSE-ConnectionGUID: nXmJmueCRASNs8wMhVSsQQ==
X-CSE-MsgGUID: guBDqYnJR92+40GHcyxNyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40993077"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="40993077"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 04:28:48 -0800
X-CSE-ConnectionGUID: lBftC68kSTaqvcTOAnrp+A==
X-CSE-MsgGUID: epJTWfqBQYWy2JJUiWfOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117763955"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2025 04:28:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toLxQ-000GEQ-2W;
	Sat, 01 Mar 2025 12:28:40 +0000
Date: Sat, 01 Mar 2025 20:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 b8ce25df2999ac6a135ce1bd14b7243030a1338a
Message-ID: <202503012017.F4rYD7Y3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: b8ce25df2999ac6a135ce1bd14b7243030a1338a  x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds

elapsed time: 1458m

configs tested: 12
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250228    clang-19
i386    buildonly-randconfig-002-20250228    clang-19
i386    buildonly-randconfig-003-20250228    gcc-12
i386    buildonly-randconfig-004-20250228    clang-19
i386    buildonly-randconfig-005-20250228    clang-19
i386    buildonly-randconfig-006-20250228    clang-19
x86_64  buildonly-randconfig-001-20250228    clang-19
x86_64  buildonly-randconfig-002-20250228    clang-19
x86_64  buildonly-randconfig-003-20250228    gcc-12
x86_64  buildonly-randconfig-004-20250228    clang-19
x86_64  buildonly-randconfig-005-20250228    gcc-12
x86_64  buildonly-randconfig-006-20250228    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

