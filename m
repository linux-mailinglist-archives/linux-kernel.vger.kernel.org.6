Return-Path: <linux-kernel+bounces-269683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAB9435BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930C1C2190B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213D48CFC;
	Wed, 31 Jul 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHzV9ntq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97E76034
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451320; cv=none; b=FaeOppGTOAUnc64kCMMPO4CtrnpfgKNudqqvDhyHTqURhxigXRCSS+e5CTx72Pi+ns0HDDCaoVzF52jBrBPx1woIZKc3P1ueD6haAO4QeAqy7acjCnq3oki7FzFtwbw/VjEtJP5TxJlOuzSPcj39UWBvp/PYHRsF84m8oXLUhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451320; c=relaxed/simple;
	bh=+XrSOlhqSZXfwy/y1oqNKf8gyh+vYiUrF9apse13BZg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZiMpR3WGC4sIpqg10sFpzYr1AS8TKucK1NSOyQ1KVIpoHN8x11whCNigO1W9fYlmfO4ktikQa+RgMTFDEHvK0qZE6gUB/4HAP+wVFOCJl5cd3eCZbaSrKczP/IMfStu7ntaNBRA+sPXAKxX2nh7Uup04Ivq7VKMBqXGaxmZW14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHzV9ntq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722451317; x=1753987317;
  h=date:from:to:cc:subject:message-id;
  bh=+XrSOlhqSZXfwy/y1oqNKf8gyh+vYiUrF9apse13BZg=;
  b=KHzV9ntqKrAIdl9DpLye+DUmmVJhKWY2v9dHlD6bn/84nXtYWCaB+pOF
   p3OElVM72J5rguCXeTnYLafPaB6eTuAGig7XUfKsumArSEb5vAtC6DiEa
   Os0ulLQK4YFUXXCDiIrepXKm2fD1j7IZvtPT9iZrNk9dMw/TS3rZsAWqw
   HStsiT22DBxO1525O2JwxhJkm6lKStdJsirBIs7/s1ws7iFBCxp2hDKFJ
   WNixD4CxFa0aRZpopRAGacZNRCCy/Ju8Dhe0J7OgKxhF7Em4gjYn/KW5/
   lOAOIh8W7gvTYht23qYNQ9/wCKKa8da+d9qYM3TxWiPPcEUA92Ed4jfth
   w==;
X-CSE-ConnectionGUID: Mb5tZkSgR4W7h1MX1F3wrQ==
X-CSE-MsgGUID: 89SmxMyrSfuJjCWxzEtO6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="30986013"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="30986013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 11:41:57 -0700
X-CSE-ConnectionGUID: 3aYvF0OsRxSK95TM6TDR2A==
X-CSE-MsgGUID: FziAILrbSoeoRSUiDZDuJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="58910088"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2024 11:41:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZEGn-000uiS-2z;
	Wed, 31 Jul 2024 18:41:53 +0000
Date: Thu, 01 Aug 2024 02:41:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc] BUILD
 REGRESSION 303f7de5e5f60dfc378b9a32a201110936b43d83
Message-ID: <202408010259.DDXDYo57-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc
branch HEAD: 303f7de5e5f60dfc378b9a32a201110936b43d83  perf: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407310719.KIRn0GjQ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407310922.Mkw2WfT2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

./usr/include/scsi/fc/fc_els.h:1131:15: error: unknown type name 'offsetof'
./usr/include/scsi/fc/fc_els.h:1131:52: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
./usr/include/scsi/fc/fc_els.h:1131:63: error: expected ')'
./usr/include/scsi/fc/fc_els.h:1132:15: error: expected declaration specifiers or '...' before string constant
./usr/include/scsi/fc/fc_els.h:1149:1: error: conflicting types for 'static_assert'
include/linux/stddef.h:16:33: error: expected declaration specifiers or '...' before '__builtin_offsetof'
include/uapi/scsi/fc/fc_els.h:1131:14: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
include/uapi/scsi/fc/fc_els.h:1131:15: error: expected ')'
include/uapi/scsi/fc/fc_els.h:1131:15: error: expected parameter declarator
include/uapi/scsi/fc/fc_els.h:1131:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
include/uapi/scsi/fc/fc_els.h:1132:15: error: expected declaration specifiers or '...' before string constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- arc-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- arc-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- arm-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- arm-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- arm64-allmodconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- i386-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   |-- usr-include-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   `-- usr-include-scsi-fc-fc_els.h:error:unknown-type-name-offsetof
|-- i386-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- loongarch-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- loongarch-defconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- m68k-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- m68k-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- microblaze-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- microblaze-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- nios2-randconfig-002-20240731
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- openrisc-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- parisc-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- parisc-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- powerpc-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- powerpc-allyesconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- riscv-allmodconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- riscv-allyesconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- s390-allmodconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- sh-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- sh-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- sparc-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- sparc-randconfig-001-20240731
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- um-allmodconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- um-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-allyesconfig
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   |-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|   |-- usr-include-scsi-fc-fc_els.h:error:conflicting-types-for-static_assert
|   |-- usr-include-scsi-fc-fc_els.h:error:expected-)
|   `-- usr-include-scsi-fc-fc_els.h:warning:type-specifier-missing-defaults-to-int
|-- x86_64-randconfig-014-20240731
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-076-20240731
|   |-- include-uapi-scsi-fc-fc_els.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-)
|   |-- include-uapi-scsi-fc-fc_els.h:error:expected-parameter-declarator
|   `-- include-uapi-scsi-fc-fc_els.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-161-20240731
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant
`-- xtensa-allyesconfig
    |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
    `-- include-uapi-scsi-fc-fc_els.h:error:expected-declaration-specifiers-or-...-before-string-constant

elapsed time: 1463m

configs tested: 166
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240731   gcc-13.2.0
arc                   randconfig-002-20240731   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                   randconfig-001-20240731   gcc-14.1.0
arm                   randconfig-002-20240731   clang-20
arm                   randconfig-003-20240731   clang-20
arm                   randconfig-004-20240731   gcc-14.1.0
arm                        shmobile_defconfig   gcc-14.1.0
arm                           tegra_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240731   clang-15
arm64                 randconfig-002-20240731   clang-20
arm64                 randconfig-003-20240731   gcc-14.1.0
arm64                 randconfig-004-20240731   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240731   gcc-14.1.0
csky                  randconfig-002-20240731   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240731   clang-16
hexagon               randconfig-002-20240731   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240731   clang-18
i386         buildonly-randconfig-002-20240731   clang-18
i386         buildonly-randconfig-003-20240731   clang-18
i386         buildonly-randconfig-004-20240731   gcc-13
i386         buildonly-randconfig-005-20240731   clang-18
i386         buildonly-randconfig-006-20240731   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240731   gcc-13
i386                  randconfig-002-20240731   clang-18
i386                  randconfig-003-20240731   clang-18
i386                  randconfig-004-20240731   clang-18
i386                  randconfig-005-20240731   gcc-13
i386                  randconfig-006-20240731   clang-18
i386                  randconfig-011-20240731   gcc-12
i386                  randconfig-012-20240731   gcc-13
i386                  randconfig-013-20240731   clang-18
i386                  randconfig-014-20240731   gcc-8
i386                  randconfig-015-20240731   gcc-10
i386                  randconfig-016-20240731   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240731   gcc-14.1.0
loongarch             randconfig-002-20240731   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-13.2.0
mips                           ip22_defconfig   gcc-14.1.0
mips                         rt305x_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240731   gcc-14.1.0
nios2                 randconfig-002-20240731   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240731   gcc-14.1.0
parisc                randconfig-002-20240731   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                     mpc83xx_defconfig   clang-20
powerpc               randconfig-002-20240731   gcc-14.1.0
powerpc               randconfig-003-20240731   clang-20
powerpc64             randconfig-001-20240731   clang-20
powerpc64             randconfig-002-20240731   clang-15
powerpc64             randconfig-003-20240731   clang-20
riscv                            alldefconfig   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240731   clang-20
riscv                 randconfig-002-20240731   clang-15
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240731   gcc-14.1.0
s390                  randconfig-002-20240731   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-14.1.0
sh                    randconfig-001-20240731   gcc-14.1.0
sh                    randconfig-002-20240731   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-14.1.0
sh                            shmin_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240731   gcc-14.1.0
sparc64               randconfig-002-20240731   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240731   clang-20
um                    randconfig-002-20240731   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240731   gcc-13
x86_64       buildonly-randconfig-002-20240731   gcc-13
x86_64       buildonly-randconfig-003-20240731   clang-18
x86_64       buildonly-randconfig-004-20240731   gcc-13
x86_64       buildonly-randconfig-005-20240731   gcc-13
x86_64       buildonly-randconfig-006-20240731   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240731   gcc-12
x86_64                randconfig-002-20240731   gcc-12
x86_64                randconfig-003-20240731   clang-18
x86_64                randconfig-004-20240731   gcc-10
x86_64                randconfig-005-20240731   gcc-13
x86_64                randconfig-006-20240731   clang-18
x86_64                randconfig-011-20240731   clang-18
x86_64                randconfig-012-20240731   clang-18
x86_64                randconfig-013-20240731   gcc-7
x86_64                randconfig-014-20240731   clang-18
x86_64                randconfig-015-20240731   clang-18
x86_64                randconfig-016-20240731   clang-18
x86_64                randconfig-071-20240731   clang-18
x86_64                randconfig-072-20240731   gcc-13
x86_64                randconfig-073-20240731   clang-18
x86_64                randconfig-074-20240731   clang-18
x86_64                randconfig-075-20240731   clang-18
x86_64                randconfig-076-20240731   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  nommu_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240731   gcc-14.1.0
xtensa                randconfig-002-20240731   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

