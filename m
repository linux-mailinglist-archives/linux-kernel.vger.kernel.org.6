Return-Path: <linux-kernel+bounces-337908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6F9850F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C926A1F23655
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959C1487FF;
	Wed, 25 Sep 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN3xEllf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF9146D6D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727231214; cv=none; b=sZ2HPfODQd+BnKPkg79j+uTc8PwW/LqPvotFKJpUgXVlGtDRfDfbkcsldeQcnNnHcPSnBXYm/rUKiwJk+ONNgijm84e3Z972vEkvvYl1bhpRFNrI14oqUsH2iLTd+wrr2sLf94JO9MoAuLQ3uLr8OTZZW1AdSgf15lTdWwWR3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727231214; c=relaxed/simple;
	bh=pEWOrktOGnCbbhf6OBJ1o1HnR3IqH6UPbtw8+H4xnG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lFVDqzSARd76dc+AQDnBI8lfSIr8tchQ0Euj6xEEaCNc8B1zcqIruzTh3i16ZbibCa5TFRe2Vuw2MmaFLQUFjjohmbnAN0KoWY2bTW3CZMMlZYSQVQS7WJorI4Ktyb/y9y8bzjCXolMcAWaXuFdWoqN73aTNAfLVMQ6yQmyWmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN3xEllf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727231213; x=1758767213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pEWOrktOGnCbbhf6OBJ1o1HnR3IqH6UPbtw8+H4xnG4=;
  b=TN3xEllfd7shBhIVFw54rXcZCrrR+07bQCD9HwBDhW9WAiDTf4nQlxa3
   7HLGrtUD6gPaXd94O6Pm1a8VQb+xKwszc1OLcjL7jVq6awJz3UBpxCJBO
   khJlYsHTxNjabo9OIsoUTsM2fBnwuoHuWVuZXmHJLnFPkVmQjI44kQGw0
   vJqBHTdiGubeOksZgrYdTtcsWha9Ayqf7RomIRacQKUEkkDhp8OnZYC3p
   zWriBs84R7AIDLreFCZrouzidRM3zG3FFYE73eLMNxtdUQnrg5uxzM6rW
   z5gOFd4A6FbzOPmc43TSmoFbOiBc1PadEA4qeqa7tTgudmUM/esxm1EtZ
   g==;
X-CSE-ConnectionGUID: SVEeN3ufQSCP3ajlTKie7Q==
X-CSE-MsgGUID: ghx9HzwgSk+9OOLSws72mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26352974"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26352974"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:26:52 -0700
X-CSE-ConnectionGUID: MAm77GodT7SBxwYiVWxNVg==
X-CSE-MsgGUID: /NFH4r5rQXmMdyf1aIPzlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102437841"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2024 19:26:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stHjs-000J37-2k;
	Wed, 25 Sep 2024 02:26:48 +0000
Date: Wed, 25 Sep 2024 10:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Niethe <jniethe5@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gautam Menghani <gautam@linux.ibm.com>
Subject: arch/powerpc/kvm/powerpc.c:1061:9: error: implicit declaration of
 function 'kvmppc_get_vsx_vr'; did you mean 'kvmppc_get_sr'?
Message-ID: <202409251011.k4Av657k-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
commit: 52425a3b3c11cec58cf66e4c897fc1504f3911a9 KVM: PPC: Introduce FPR/VR accessor functions
date:   1 year ago
config: powerpc64-randconfig-003-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251011.k4Av657k-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251011.k4Av657k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251011.k4Av657k-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/powerpc.c: In function 'kvmppc_set_vmx_dword':
>> arch/powerpc/kvm/powerpc.c:1061:9: error: implicit declaration of function 'kvmppc_get_vsx_vr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1061 |         kvmppc_get_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_get_sr
>> arch/powerpc/kvm/powerpc.c:1063:9: error: implicit declaration of function 'kvmppc_set_vsx_vr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1063 |         kvmppc_set_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_set_sr
   In file included from arch/powerpc/kvm/powerpc.c:25:
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_get_one_reg':
>> arch/powerpc/kvm/powerpc.c:1729:52: error: implicit declaration of function 'kvmppc_get_vscr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1729 |                         val = get_reg_val(reg->id, kvmppc_get_vscr(vcpu));
         |                                                    ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/kvm_ppc.h:412:29: note: in definition of macro 'get_reg_val'
     412 |         case 4: __u.wval = (reg); break;        \
         |                             ^~~
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_set_one_reg':
>> arch/powerpc/kvm/powerpc.c:1780:25: error: implicit declaration of function 'kvmppc_set_vscr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1780 |                         kvmppc_set_vscr(vcpu, set_reg_val(reg->id, val));
         |                         ^~~~~~~~~~~~~~~
         |                         kvmppc_set_sr


vim +1061 arch/powerpc/kvm/powerpc.c

  1048	
  1049	
  1050	static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
  1051		u64 gpr)
  1052	{
  1053		union kvmppc_one_reg val;
  1054		int offset = kvmppc_get_vmx_dword_offset(vcpu,
  1055				vcpu->arch.mmio_vmx_offset);
  1056		int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
  1057	
  1058		if (offset == -1)
  1059			return;
  1060	
> 1061		kvmppc_get_vsx_vr(vcpu, index, &val.vval);
  1062		val.vsxval[offset] = gpr;
> 1063		kvmppc_set_vsx_vr(vcpu, index, &val.vval);
  1064	}
  1065	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

