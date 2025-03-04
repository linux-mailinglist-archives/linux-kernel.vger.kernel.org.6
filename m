Return-Path: <linux-kernel+bounces-542995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0741A4D05C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2F1785AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA71DED79;
	Tue,  4 Mar 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mszjm+Dg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD578F54
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048829; cv=none; b=n3SGRjNOVGUElAToI56pwHbIaRl3y6Dr0xsfoMqSFBJF4mo5W36iBTZfQl06V+MYev0b1h1Pn6USXy8kZpW30qUq8KeiQJErHGwiAJYi+VqTyo0XDxOiBRXdT4TbKkWWzzlwNqPX0KD8n3SN5ssa2MpruhPINyBsVYiFP7NVwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048829; c=relaxed/simple;
	bh=r5OmB/oGFpzkb2dqd2CRR5EyfRUbGc89WXIyZWFse/Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qDMk+QS7TSiNfadzUrKmZTq58ADtHqHFOpt8V7AEbEq5epgCvslHnTxdMW8/ZtChOk4XoJ1GsOUjWxxbFrvV/86wvltJbgQ/AR/DhaZiJauPhCZzguoJCpthgL8PluGl20y3Y+4DiyI1FkLwD+sZtDwOtU2w9ryJ9s/Wmcrwlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mszjm+Dg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741048827; x=1772584827;
  h=date:from:to:cc:subject:message-id;
  bh=r5OmB/oGFpzkb2dqd2CRR5EyfRUbGc89WXIyZWFse/Y=;
  b=mszjm+DgJKkpLEhDXwk4pM0G3n1DnKb9+ISNb08axW2zw85ji+azUu2l
   +IZ0QcJ2ZqiNawSC3F6byQMzWXN7yz4F0Ef8JTK4nVvB1Tk5Egs9lLrmj
   Ogs8vDq/08UE9CI+EX097kXL+QVI2TX6n6QC2/Irji6+MbM9av6LMQ9dO
   jfThqdmufX3qMkCTFUpgQcgg6EeLXWQ1tdsBggKCRcWN8YnZLAaNaPNEb
   Ow2sU//D7jgUEC1IIude2EVR7F7Q1XIWwpwfXn44TVpCz3Jk5R5ew1Tv4
   sCj8cOrVxmeU3N7dcZl9C1QSr56oWwV6NL7f1ZUjI6xjfteSGunzs7gOW
   A==;
X-CSE-ConnectionGUID: dzk3zOHGTomQUOn05+pfBA==
X-CSE-MsgGUID: 886iRU9ITrKEVEaIq7kmjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41800932"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41800932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 16:40:27 -0800
X-CSE-ConnectionGUID: wyUcR1fuQ76N61cEar38aQ==
X-CSE-MsgGUID: IGg/m7ciS/2OzpWZ6/4jkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118206216"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2025 16:40:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpGKd-000J5S-2z;
	Tue, 04 Mar 2025 00:40:23 +0000
Date: Tue, 04 Mar 2025 08:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9af9ad85ac44cb754e526d468c3006b48db5dfd8
Message-ID: <202503040820.b0bpT6a2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9af9ad85ac44cb754e526d468c3006b48db5dfd8  x86/speculation: Add a conditional CS prefix to CALL_NOSPEC

elapsed time: 732m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250303    gcc-12
i386    buildonly-randconfig-002-20250303    clang-19
i386    buildonly-randconfig-003-20250303    clang-19
i386    buildonly-randconfig-004-20250303    gcc-12
i386    buildonly-randconfig-005-20250303    gcc-12
i386    buildonly-randconfig-006-20250303    clang-19
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250303    clang-19
x86_64  buildonly-randconfig-002-20250303    gcc-12
x86_64  buildonly-randconfig-003-20250303    clang-19
x86_64  buildonly-randconfig-004-20250303    gcc-12
x86_64  buildonly-randconfig-005-20250303    gcc-12
x86_64  buildonly-randconfig-006-20250303    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

