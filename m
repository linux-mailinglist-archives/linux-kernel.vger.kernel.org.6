Return-Path: <linux-kernel+bounces-312524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4769697C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5889C1C2319D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102A1C769C;
	Tue,  3 Sep 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjlBDYAz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B31C7685;
	Tue,  3 Sep 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353096; cv=none; b=KiIqD1LxAyaaPZvP4fKJUwOfmUUZabnNwtdjgA1wGG1v34oTObEWMZFqW+PtkjdqA7QKzew27b7Rhkue4pdf2VoXZmfj4l0ormmgm3l2BlKlBgOOUi7shlK+I3wgFEnWOOUT1i/+v5xRKDWzOqI8cbakGyEWpcF5E8ic2vHiUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353096; c=relaxed/simple;
	bh=3xB3ztwj0gMpVSIrxypG9nmuOvlqkoexcBQdprbAobY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT+r0x+4rkoBNhwcSoERnnIP0n/aDJpOhaIykdn2E6IywRN9aHBx/NWPCzY2Ljy2Y+EQddpOVhzuZRmCGwbavpxRodpZMVZt/If8s+OZkamjGohd850BMqajjG/55d3D7efQGzd0Ote8Vp4iCX9xlxRk5xNMgCuMWbJflKtOMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjlBDYAz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725353095; x=1756889095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3xB3ztwj0gMpVSIrxypG9nmuOvlqkoexcBQdprbAobY=;
  b=MjlBDYAzyTSrwImB0WPDx2yYzIt0H4rowXayawf8Y9dWo0aBP+AA8SgE
   o7PjX2IGb/pOKtB+uZsDX8fDTicUjfZGzXLPFpxRwFepL3p8u2R5wLaIH
   DKtjMFRR/ckRIflVUMyzbLGwC6RoEVpsqJgI1qarD4VecWX3tPbFtrdjO
   hU2tkLEUVuRVpO3Cnj3mfRs5IVNFYVRca838z66zVHu0kalXLZaRC2As7
   JzuL4IPT2y75zVLGN1V+GiXqKmR9lO6skCRrGMTzUyyt+om3DCFJELq1+
   /rt9TNFx9JJAOCfSb893GJzpIqYFaAEgdpayW7xkAZTBi00W036vt+DAz
   Q==;
X-CSE-ConnectionGUID: oWaDnofBR+6RRugglRioZA==
X-CSE-MsgGUID: X4NWet46SQ2Xs1YAFZcLLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="13340547"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="13340547"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 01:44:54 -0700
X-CSE-ConnectionGUID: eyhj1E5rSHaxevCr/gM+9Q==
X-CSE-MsgGUID: X/xG8AjRS/WND4b1Mr78AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="69477026"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Sep 2024 01:44:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slP9d-0006QI-0P;
	Tue, 03 Sep 2024 08:44:49 +0000
Date: Tue, 3 Sep 2024 16:44:05 +0800
From: kernel test robot <lkp@intel.com>
To: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Pavan Kumar Paluri <papaluri@amd.com>
Subject: Re: [PATCH v2 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <202409031656.SS8NsjIN-lkp@intel.com>
References: <20240903003511.1530454-2-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903003511.1530454-2-papaluri@amd.com>

Hi Pavan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a85536e1bce722cb184abbac98068217874bdd6e]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavan-Kumar-Paluri/x86-KVM-SVM-Move-sev-specific-parsing-into-arch-x86-virt-svm/20240903-083803
base:   a85536e1bce722cb184abbac98068217874bdd6e
patch link:    https://lore.kernel.org/r/20240903003511.1530454-2-papaluri%40amd.com
patch subject: [PATCH v2 1/2] x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
config: i386-buildonly-randconfig-001-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031656.SS8NsjIN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031656.SS8NsjIN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409031656.SS8NsjIN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/sev.h:16,
                    from arch/x86/virt/svm/cmdline.c:13:
>> arch/x86/include/asm/coco.h:28:18: warning: 'cc_mask' defined but not used [-Wunused-const-variable=]
      28 | static const u64 cc_mask = 0;
         |                  ^~~~~~~


vim +/cc_mask +28 arch/x86/include/asm/coco.h

1c811d403afd73 Ard Biesheuvel     2024-02-03  22  
b577f542f93cbb Kirill A. Shutemov 2022-02-22  23  u64 cc_mkenc(u64 val);
b577f542f93cbb Kirill A. Shutemov 2022-02-22  24  u64 cc_mkdec(u64 val);
99485c4c026f02 Jason A. Donenfeld 2024-03-26  25  void cc_random_init(void);
b577f542f93cbb Kirill A. Shutemov 2022-02-22  26  #else
e4596477100706 Nathan Chancellor  2024-02-02  27  #define cc_vendor (CC_VENDOR_NONE)
a0a8d15a798be4 Kirill A. Shutemov 2024-04-24 @28  static const u64 cc_mask = 0;
e4596477100706 Nathan Chancellor  2024-02-02  29  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

