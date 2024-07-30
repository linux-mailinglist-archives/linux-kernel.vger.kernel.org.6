Return-Path: <linux-kernel+bounces-266695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F094057C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396FE1C20E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE61465A2;
	Tue, 30 Jul 2024 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFSsQzuI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C24286A8;
	Tue, 30 Jul 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307643; cv=none; b=OBX4KJr5fdpCbOVkGhFII1t5QDGa6la0fGc4n1oYLxPV3H5rORpecM9Ov4kZPoUvovFB9mUI9hw3hy93F6XSfoMUyxdzjPtvhSYn8Z0Q4h+xBPm1iKGi1gztv9xktsJJfthMGKLOkHuCL1SEQpaWq/BovU5lQxovP3Vbr+Khca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307643; c=relaxed/simple;
	bh=Ua8ABAlBdaz+fPYZynUWSDCTK92pYZqE92LoOz5qxyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTK1N3uHwqfphejjCL1GEOwE8SyU2guUn+w1Q0vuO/VY7FWVCWpxQoXU+tVH+opPDh5OVvVtn5b2Y8oaNekhwW+HfrZTnSMpcI8osTIQ1kt9v9VJFtahIZJR6JobqtUV1UdmtcCbQ+Jh5qPGNfMGC1k/GLYNOc9OIlIjKEIyaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFSsQzuI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722307642; x=1753843642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ua8ABAlBdaz+fPYZynUWSDCTK92pYZqE92LoOz5qxyU=;
  b=gFSsQzuIlzJXmgx00nPxZ3kUw0DB0/1Gf6yAdatmViP2+k1Q+S7/th/o
   lmuN9yaDK5e56h57z7kSPZWQ/P0vR3nSd/Y9LFZ4ClYCi3JeMHakPDd35
   fQeWSdP/Co+nwDgqE0kt8xbFz+6fbBgjqsOA8P+7X+FFYrsN8IlCgoqcH
   vNi+FlG/PxD1kr39MMS2kVn7BYU17PyKXFZ+8tOYR9vSgqqSflbFzJB3A
   jRN1D25yO9+LWlkYjCibEA87y4JcZHfXdmujI0ZdaokUPprJNcHscci8g
   tlndzLpoxpRI0aLEK7t9jbM4nFLx3+/KGyOUusYuSnrXALQNZJu+gLAD+
   A==;
X-CSE-ConnectionGUID: bDYzhakHSji95PQRE9somw==
X-CSE-MsgGUID: oi9Mf5EHQiuRMIltJuIgrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30729835"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="30729835"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 19:47:21 -0700
X-CSE-ConnectionGUID: s1Sv3a57TVqMtsYZZJFHKg==
X-CSE-MsgGUID: vp3oUUF+QwCkYjYBk7DHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54099244"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Jul 2024 19:47:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYctP-000sOU-23;
	Tue, 30 Jul 2024 02:47:15 +0000
Date: Tue, 30 Jul 2024 10:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v1 32/36] soc: fsl: qe: Add resource-managed muram
 allocators
Message-ID: <202407301027.RZ0iwoYW-lkp@intel.com>
References: <20240729142107.104574-33-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729142107.104574-33-herve.codina@bootlin.com>

Hi Herve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/soc-fsl-cpm1-qmc-Update-TRNSYNC-only-in-transparent-mode/20240730-001631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240729142107.104574-33-herve.codina%40bootlin.com
patch subject: [PATCH v1 32/36] soc: fsl: qe: Add resource-managed muram allocators
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240730/202407301027.RZ0iwoYW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301027.RZ0iwoYW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301027.RZ0iwoYW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/fsl/qe/qe_common.c: In function 'devm_cpm_muram_alloc':
   drivers/soc/fsl/qe/qe_common.c:217:14: error: implicit declaration of function 'devres_alloc'; did you mean 'kvrealloc'? [-Werror=implicit-function-declaration]
     217 |         dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
         |              ^~~~~~~~~~~~
         |              kvrealloc
>> drivers/soc/fsl/qe/qe_common.c:217:12: warning: assignment to 's32 *' {aka 'int *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     217 |         dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
         |            ^
   drivers/soc/fsl/qe/qe_common.c:224:17: error: implicit declaration of function 'devres_add' [-Werror=implicit-function-declaration]
     224 |                 devres_add(dev, dr);
         |                 ^~~~~~~~~~
   drivers/soc/fsl/qe/qe_common.c:226:17: error: implicit declaration of function 'devres_free' [-Werror=implicit-function-declaration]
     226 |                 devres_free(dr);
         |                 ^~~~~~~~~~~
   drivers/soc/fsl/qe/qe_common.c: In function 'devm_cpm_muram_alloc_fixed':
   drivers/soc/fsl/qe/qe_common.c:277:12: warning: assignment to 's32 *' {aka 'int *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     277 |         dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
         |            ^
   cc1: some warnings being treated as errors


vim +217 drivers/soc/fsl/qe/qe_common.c

   196	
   197	/**
   198	 * devm_cpm_muram_alloc - Resource-managed cpm_muram_alloc
   199	 * @dev: Device to allocate memory for
   200	 * @size: number of bytes to allocate
   201	 * @align: requested alignment, in bytes
   202	 *
   203	 * This function returns a non-negative offset into the muram area, or
   204	 * a negative errno on failure as cpm_muram_alloc() does.
   205	 * Use cpm_muram_addr() to get the virtual address of the area.
   206	 *
   207	 * Compare against cpm_muram_alloc(), the memory allocated by this
   208	 * resource-managed version is automatically freed on driver detach and so,
   209	 * cpm_muram_free() must not be called to release the allocated memory.
   210	 */
   211	s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
   212				 unsigned long align)
   213	{
   214		s32 info;
   215		s32 *dr;
   216	
 > 217		dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
   218		if (!dr)
   219			return -ENOMEM;
   220	
   221		info = cpm_muram_alloc(size, align);
   222		if (info >= 0) {
   223			*dr = info;
   224			devres_add(dev, dr);
   225		} else {
   226			devres_free(dr);
   227		}
   228	
   229		return info;
   230	}
   231	EXPORT_SYMBOL(devm_cpm_muram_alloc);
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

