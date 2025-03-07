Return-Path: <linux-kernel+bounces-551076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30DA567D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC773B2467
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB714A4F9;
	Fri,  7 Mar 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO2lp9Sl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8931E1E0E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350667; cv=none; b=W6wl/Hmg+LKsGosaTfL9FxWH+1i+43C/u8Q++iQxcarcfj9vsVS7RirSPuxZ4blkJSLR6S2Oyx4t4eX6J1qWVGcAOQm/BhRyVR3B2c3JSBQLCFC74A05Ek8oErFEzdHgOUZmOYvSOp/mp7RlbGDN3k3PcbytppvqCBo4WKpkXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350667; c=relaxed/simple;
	bh=ECOcLhGkw6rj6v+sR3MqFlw9AGZjBZIx+Y5eWBgmrZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UB6vYqqFa1JsuQON8w6lDvL4Za3RyhNH1vYycEiTsdgo1BPtI1SBneq50PlZaQcCr/rqi9K1Jn5Qf8crPU/cBl06t5oapjGqzQ4AVem83ZdCgoxxFVLaGzBT9aObboeM/XRh8wA8lQTRFKbcef2o4qS+G2qin7i+HJe5K/5uhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO2lp9Sl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741350666; x=1772886666;
  h=date:from:to:cc:subject:message-id;
  bh=ECOcLhGkw6rj6v+sR3MqFlw9AGZjBZIx+Y5eWBgmrZM=;
  b=fO2lp9SlUGeyoYpRxT0tWAv2f4SWwc2GzJ8sQO2Ea3mZRs0zbnSX6uVj
   gn6zFhIloJ/SNVEchx6DnJuVn93tJ6zV9npZOvNQw3BVWTxEf0DJh/wau
   cDYD+Ol/KoIy7HjFvaJFIa8DgbdYbc1PkepSzG/A7I653Nyi8yrK7tAwo
   oMb7w/VB32r7agyF7vwWsVjKZkhVdwutJkWmTeCO7ArvJid4jmrcyz1cB
   knRGDe1U49oHqEotrdPpXEHy6u5+w+IRW/gJur2lfcwXMHmZhU2GGjGBU
   v99/jkoJZQ8V8uNFNUOD9ShO+N/gj5gb7GpMWL09+Jn9BcUXtKTQS9MCM
   w==;
X-CSE-ConnectionGUID: hgRPMa3eTPGhc9JJ64i7Jw==
X-CSE-MsgGUID: BphSXZX5SfirE80eJoabIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42274945"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42274945"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:31:05 -0800
X-CSE-ConnectionGUID: rcuE+NZHRxCtHnlkfNTAHg==
X-CSE-MsgGUID: ANVnMwByRx+1ka/5wZ03bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124230494"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Mar 2025 04:31:04 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWr0-0000Sz-0F;
	Fri, 07 Mar 2025 12:31:02 +0000
Date: Fri, 07 Mar 2025 20:30:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 c85391793f4ef47ba5275c57aea7653ead92632f
Message-ID: <202503072051.oTDxo8KJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: c85391793f4ef47ba5275c57aea7653ead92632f  x86/split_lock: Fix the delayed detection logic

elapsed time: 1453m

configs tested: 14
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250306    clang-19
i386    buildonly-randconfig-002-20250306    clang-19
i386    buildonly-randconfig-003-20250306    clang-19
i386    buildonly-randconfig-004-20250306    gcc-12
i386    buildonly-randconfig-005-20250306    gcc-12
i386    buildonly-randconfig-006-20250306    clang-19
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250306    gcc-11
x86_64  buildonly-randconfig-002-20250306    clang-19
x86_64  buildonly-randconfig-003-20250306    clang-19
x86_64  buildonly-randconfig-004-20250306    clang-19
x86_64  buildonly-randconfig-005-20250306    clang-19
x86_64  buildonly-randconfig-006-20250306    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

