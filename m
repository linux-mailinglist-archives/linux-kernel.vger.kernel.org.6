Return-Path: <linux-kernel+bounces-534962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A8A46D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B865B18881C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D12222C6;
	Wed, 26 Feb 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFiDEgAe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CB15852E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604904; cv=none; b=h01SYVgTgHnBWq6ZMRsjBFYdAICrMM6UzvXBEfIAomztouKL61WE26V8yZEtMIkn1J1fc+eJrxEPy5d77xhN+4Ia3cJSe8mIsI+EFadayW9ebC2SghH4OWoVyEjvWiJRO7CXf/q9vcveFZ+H3WkcRIptCiffDCUeP6gfU5JLPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604904; c=relaxed/simple;
	bh=Zi8pJH3QTazH85ANnQIVe4F5EIRPpihKsWCVbY/Rcno=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IhL+vLF/mm3sHBeHpp8ADJrM141yT2SKPvfcMGpuBJ8z9P7fT+dD78Gsh7OdKSKArLdwW2w5Kj7BQ8TpjgFdjkIBQfT8FXVDRLALb/qFiI66R2ToxWH/NtOU156gb6ZI+SGLpp17PkEJNpgtzJvlyaMbFYkHuChi2rP3ZLL3Mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFiDEgAe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740604902; x=1772140902;
  h=date:from:to:cc:subject:message-id;
  bh=Zi8pJH3QTazH85ANnQIVe4F5EIRPpihKsWCVbY/Rcno=;
  b=QFiDEgAexpXXOMNXxfVEa1CuZIl6VIroCbuaOnGaHR7LTYiKXDeChm2h
   sRsb/wcQpwA3ehMnfvQ9SmqcUbKYVbTKTwG6Pcbi49LM3HbuQY65Xwaqp
   IKyyAtExrUgW5dCG30Cm25BBwlZ/3vw6tWl2HLcA1AYeiHjVgpuQ/eojV
   MPN3y12Qv289zFMVt8wWD3/0nsarFNwnCi50A9qLzRMTyqpfW51UbEjc3
   sbDxDJT7VEcfYhvq3XmXTqQDykKVLDLtXw9V8WcqhTseKZ+vAjkBYzszi
   hAsht6XW6JLI5gm0yrkBkGIIO2UZAM6rw04kqzGuOI4X8PzzZPaXza4/s
   g==;
X-CSE-ConnectionGUID: MVvYDVpRSQ2Nc4ZmbRZVVw==
X-CSE-MsgGUID: 7a6rhbc4TSul4r52aTSnzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="44300978"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="44300978"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:21:41 -0800
X-CSE-ConnectionGUID: 5hjPv8t+THeG8BNsaWVnuA==
X-CSE-MsgGUID: 7RuGmn3KR4O7dQZ6PD2YNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="121766445"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Feb 2025 13:21:40 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnOqY-000CT0-2Y;
	Wed, 26 Feb 2025 21:21:38 +0000
Date: Thu, 27 Feb 2025 05:21:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 e451630226bd09dc730eedb4e32cab1cc7155ae8
Message-ID: <202502270514.PAnvGfcy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: e451630226bd09dc730eedb4e32cab1cc7155ae8  x86/build: Fix broken copy command in genimage.sh when making isoimage

elapsed time: 1446m

configs tested: 12
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250226    gcc-12
i386    buildonly-randconfig-002-20250226    gcc-12
i386    buildonly-randconfig-003-20250226    gcc-12
i386    buildonly-randconfig-004-20250226    clang-19
i386    buildonly-randconfig-005-20250226    gcc-12
i386    buildonly-randconfig-006-20250226    gcc-12
x86_64  buildonly-randconfig-001-20250226    clang-19
x86_64  buildonly-randconfig-002-20250226    clang-19
x86_64  buildonly-randconfig-003-20250226    gcc-12
x86_64  buildonly-randconfig-004-20250226    clang-19
x86_64  buildonly-randconfig-005-20250226    gcc-12
x86_64  buildonly-randconfig-006-20250226    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

