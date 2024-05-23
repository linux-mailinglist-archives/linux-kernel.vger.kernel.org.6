Return-Path: <linux-kernel+bounces-188089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B968CDD01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA51F22B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB784DF0;
	Thu, 23 May 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuPIVDUT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF182D9A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504537; cv=none; b=VbhmcQHJ5kQ/XYxUkn/7SIrpPRUOfrCeyYR8OetCNhuBpY2QSbeWs/P7/a/YXgqrBc+6qVtoZysCRxQUCfuW8PXFyu6avO1W9KxQCDo21xT27VfRpysQOOm1JnlIDG8XvWNXt8ndDViJW4X1LzyKbOZ5WfeEFT8Qsms6wrySPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504537; c=relaxed/simple;
	bh=qsX7T6TNeCWxtC73uYx4+Y0M9wwyBKi0rKeNgH8XJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RF0HC1Iaw6ShdM54Tk38dnLxTEGhnWcl/zBLNg9g/ZWlQd2uqJG5s/7Iou6r85JC8S9nuFvw4T6SuwpzOWCyqSl5UcfUp+mB5rdQTtVi4V2Wr6N2UXZ7gk91yhPFfzFwJr/rBfEdzqkuU94jxtuWQxGowEIJcFwPaoohlL6pyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuPIVDUT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716504536; x=1748040536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qsX7T6TNeCWxtC73uYx4+Y0M9wwyBKi0rKeNgH8XJ2Y=;
  b=iuPIVDUTVTa7WyRLUG7pcUjc2avsnT3eoEm3p0JR1u2y2D0HUVZJ/QMw
   y2bqDkhJ/nQbYenCThZb8ay1Nq9tDSB8fE50Vnxd6KWXUjFa2KL0KKkj0
   MTtuT/FUw6SCD4v94YVcLC+w3O5+I8bPVwQSgktz6138xRsOz6MHXFXkj
   J1Z9EBfyS+V+hf37ja/fstPNChFqiTa2cg33bvROvJrqJNSJHQK+4MHa8
   jIK8Pj6ahNp09MczUCK+ReCfS+YIh8emsacuhGyh5u9hlPdpAXyhBYWj0
   YawbkDBbZPxxYrHBhoAFp12A04uwET1rY+Og+Up+GKAr50AIfyRE/NHh8
   w==;
X-CSE-ConnectionGUID: ylcelNyzRIusfcakv8wrhQ==
X-CSE-MsgGUID: lCyAK4DTSgyjx+dPuNbmKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12976809"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12976809"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:48:55 -0700
X-CSE-ConnectionGUID: V/mEecQKQcWFcaxPSx9FTw==
X-CSE-MsgGUID: +LcLLkFWTfu2pQ98pNB34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33806851"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 May 2024 15:48:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAHEw-0003az-0y;
	Thu, 23 May 2024 22:48:50 +0000
Date: Fri, 24 May 2024 06:48:26 +0800
From: kernel test robot <lkp@intel.com>
To: David Gstir <david@sigma-star.at>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202405240610.fj53EK0q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d69b6c12fce479fde7bc06f686212451688a102
commit: 2e8a0f40a39cc253002f21c54e1b5b995e5ec510 KEYS: trusted: Introduce NXP DCP-backed trusted keys
date:   2 weeks ago
config: arm-randconfig-r112-20240524 (https://download.01.org/0day-ci/archive/20240524/202405240610.fj53EK0q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240524/202405240610.fj53EK0q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/keys/trusted-keys/trusted_dcp.c:206:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] payload_len @@     got unsigned int @@
   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     expected restricted __le32 [usertype] payload_len
   security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:     got unsigned int

vim +206 security/keys/trusted-keys/trusted_dcp.c

   179	
   180	static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
   181	{
   182		struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
   183		int blen, ret;
   184	
   185		blen = calc_blob_len(p->key_len);
   186		if (blen > MAX_BLOB_SIZE)
   187			return -E2BIG;
   188	
   189		b->fmt_version = DCP_BLOB_VERSION;
   190		get_random_bytes(b->nonce, AES_KEYSIZE_128);
   191		get_random_bytes(b->blob_key, AES_KEYSIZE_128);
   192	
   193		ret = do_aead_crypto(p->key, b->payload, p->key_len, b->blob_key,
   194				     b->nonce, true);
   195		if (ret) {
   196			pr_err("Unable to encrypt blob payload: %i\n", ret);
   197			return ret;
   198		}
   199	
   200		ret = encrypt_blob_key(b->blob_key);
   201		if (ret) {
   202			pr_err("Unable to encrypt blob key: %i\n", ret);
   203			return ret;
   204		}
   205	
 > 206		b->payload_len = get_unaligned_le32(&p->key_len);
   207		p->blob_len = blen;
   208		return 0;
   209	}
   210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

