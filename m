Return-Path: <linux-kernel+bounces-337988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069969851E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891E11F254F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342FE14B950;
	Wed, 25 Sep 2024 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qlt+fVWp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31E1494B2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237341; cv=none; b=O7/fccVHHTutDooV7NS2a1TfXFdJDEegw2wGko4H6HGOw0kPZQ6nUIP7q4veyG5YtTWst/LXbUawm2ysn42ek/34CBFp5bCD7A9de/Vt2b+7RST9GKLe+vKCDJt0I6a3r5Q3tAFxlpSr8iYjq+m/6EV/lH/CXwXnaAGgnlnqr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237341; c=relaxed/simple;
	bh=3BOMAtP8PlWKySgPuchMZreV7N4TNixAq4sTN5Y0kX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I6pnpt9I+NbfXdSlDL4zs8/3TUvnPpNNkyG1rqYevVx8KnS3EVYQfc68PHAA2n+DU7iCXtzuD7HHE6TGc+SIiypl4i8ptgsjTri9fk43no8KyhT0zYa4anhB6t2+5THNya7pSGfxKruDVbfZDQwfLZLcMpVpFnWvoNZdJF0OVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qlt+fVWp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727237339; x=1758773339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3BOMAtP8PlWKySgPuchMZreV7N4TNixAq4sTN5Y0kX4=;
  b=Qlt+fVWpGahhCl4c5SLTFpKjaCan8LuwBGUepSCkyg1WmUoCjj+ohtOd
   m2uf3lPEB3uSPEzXSHxE6PmUnboiOMGzCN3Wyi6cWFrUCBSOjcjDBtH6Q
   ac92aSw1fTOJWjmj+KMNrNkmnDSrJxwddtDf8OZaVW0LTGzG5i4qxByrg
   cqMezgR9cPcUnuKGRuPNv9eXPdoZFBTwkNFQ2x3knD8GO2diU9LEsRgee
   Hbcd9uWPyEXgginJcVor8lz00BOSR16OM150HvOR3FfUgvWfAL957SAld
   xUTgeEmdTdWV9vLh+yVe9ppB6xvCqdLUvYPV/1/bpCSltbeA7rM/1Izjv
   w==;
X-CSE-ConnectionGUID: 3xULWaBPTHWkIdrMf9Q9Mg==
X-CSE-MsgGUID: SzbLtjmVS1Gs5gB0yK+AqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37642288"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="37642288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 21:08:59 -0700
X-CSE-ConnectionGUID: XRAT1GceR9Smk2lxfUbBHA==
X-CSE-MsgGUID: osHNa+i1QLmMKNsAaTBQqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72093803"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2024 21:08:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stJKg-000J7V-2k;
	Wed, 25 Sep 2024 04:08:54 +0000
Date: Wed, 25 Sep 2024 12:08:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Niethe <jniethe5@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/powerpc.c:1732:52: error: implicit declaration of
 function 'kvmppc_get_vrsave'; did you mean 'kvmppc_get_sr'?
Message-ID: <202409251137.1cRB00WD-lkp@intel.com>
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
commit: 7028ac8d174f28220f0e2de0cb3346cd3c31976d KVM: PPC: Use accessors for VCPU registers
date:   1 year ago
config: powerpc64-randconfig-003-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251137.1cRB00WD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251137.1cRB00WD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251137.1cRB00WD-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/powerpc.c: In function 'kvmppc_set_vmx_dword':
   arch/powerpc/kvm/powerpc.c:1061:9: error: implicit declaration of function 'kvmppc_get_vsx_vr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1061 |         kvmppc_get_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_get_sr
   arch/powerpc/kvm/powerpc.c:1063:9: error: implicit declaration of function 'kvmppc_set_vsx_vr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1063 |         kvmppc_set_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_set_sr
   In file included from arch/powerpc/kvm/powerpc.c:25:
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_get_one_reg':
   arch/powerpc/kvm/powerpc.c:1729:52: error: implicit declaration of function 'kvmppc_get_vscr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1729 |                         val = get_reg_val(reg->id, kvmppc_get_vscr(vcpu));
         |                                                    ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/kvm_ppc.h:412:29: note: in definition of macro 'get_reg_val'
     412 |         case 4: __u.wval = (reg); break;        \
         |                             ^~~
>> arch/powerpc/kvm/powerpc.c:1732:52: error: implicit declaration of function 'kvmppc_get_vrsave'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1732 |                         val = get_reg_val(reg->id, kvmppc_get_vrsave(vcpu));
         |                                                    ^~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/kvm_ppc.h:412:29: note: in definition of macro 'get_reg_val'
     412 |         case 4: __u.wval = (reg); break;        \
         |                             ^~~
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_set_one_reg':
   arch/powerpc/kvm/powerpc.c:1780:25: error: implicit declaration of function 'kvmppc_set_vscr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1780 |                         kvmppc_set_vscr(vcpu, set_reg_val(reg->id, val));
         |                         ^~~~~~~~~~~~~~~
         |                         kvmppc_set_sr
>> arch/powerpc/kvm/powerpc.c:1787:25: error: implicit declaration of function 'kvmppc_set_vrsave'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1787 |                         kvmppc_set_vrsave(vcpu, set_reg_val(reg->id, val));
         |                         ^~~~~~~~~~~~~~~~~
         |                         kvmppc_set_sr


vim +1732 arch/powerpc/kvm/powerpc.c

  1701	
  1702	int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
  1703	{
  1704		int r = 0;
  1705		union kvmppc_one_reg val;
  1706		int size;
  1707	
  1708		size = one_reg_size(reg->id);
  1709		if (size > sizeof(val))
  1710			return -EINVAL;
  1711	
  1712		r = kvmppc_get_one_reg(vcpu, reg->id, &val);
  1713		if (r == -EINVAL) {
  1714			r = 0;
  1715			switch (reg->id) {
  1716	#ifdef CONFIG_ALTIVEC
  1717			case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
  1718				if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
  1719					r = -ENXIO;
  1720					break;
  1721				}
  1722				kvmppc_get_vsx_vr(vcpu, reg->id - KVM_REG_PPC_VR0, &val.vval);
  1723				break;
  1724			case KVM_REG_PPC_VSCR:
  1725				if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
  1726					r = -ENXIO;
  1727					break;
  1728				}
  1729				val = get_reg_val(reg->id, kvmppc_get_vscr(vcpu));
  1730				break;
  1731			case KVM_REG_PPC_VRSAVE:
> 1732				val = get_reg_val(reg->id, kvmppc_get_vrsave(vcpu));
  1733				break;
  1734	#endif /* CONFIG_ALTIVEC */
  1735			default:
  1736				r = -EINVAL;
  1737				break;
  1738			}
  1739		}
  1740	
  1741		if (r)
  1742			return r;
  1743	
  1744		if (copy_to_user((char __user *)(unsigned long)reg->addr, &val, size))
  1745			r = -EFAULT;
  1746	
  1747		return r;
  1748	}
  1749	
  1750	int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
  1751	{
  1752		int r;
  1753		union kvmppc_one_reg val;
  1754		int size;
  1755	
  1756		size = one_reg_size(reg->id);
  1757		if (size > sizeof(val))
  1758			return -EINVAL;
  1759	
  1760		if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
  1761			return -EFAULT;
  1762	
  1763		r = kvmppc_set_one_reg(vcpu, reg->id, &val);
  1764		if (r == -EINVAL) {
  1765			r = 0;
  1766			switch (reg->id) {
  1767	#ifdef CONFIG_ALTIVEC
  1768			case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
  1769				if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
  1770					r = -ENXIO;
  1771					break;
  1772				}
  1773				kvmppc_set_vsx_vr(vcpu, reg->id - KVM_REG_PPC_VR0, &val.vval);
  1774				break;
  1775			case KVM_REG_PPC_VSCR:
  1776				if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
  1777					r = -ENXIO;
  1778					break;
  1779				}
  1780				kvmppc_set_vscr(vcpu, set_reg_val(reg->id, val));
  1781				break;
  1782			case KVM_REG_PPC_VRSAVE:
  1783				if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
  1784					r = -ENXIO;
  1785					break;
  1786				}
> 1787				kvmppc_set_vrsave(vcpu, set_reg_val(reg->id, val));
  1788				break;
  1789	#endif /* CONFIG_ALTIVEC */
  1790			default:
  1791				r = -EINVAL;
  1792				break;
  1793			}
  1794		}
  1795	
  1796		return r;
  1797	}
  1798	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

