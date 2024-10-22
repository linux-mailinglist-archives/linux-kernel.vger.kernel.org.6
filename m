Return-Path: <linux-kernel+bounces-376241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808859AA202
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E6281090
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806019C56C;
	Tue, 22 Oct 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XncRKz3h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA6146D78
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599520; cv=none; b=bejeSSGgcBHawrC0VmeMduDUJkgCA0nmBTeLObXIUmK1jnoOBpm/Ccn6dnrPhAdJd++qgAUapL9b3CZ2qeNv25PIeqTKDbtawsZP/rwMnzuV5OB83D6SI86W0yNNc9b6vza0z0K5+UmnYSAwUNr1UnqQgkrRZ/B0b0Y3dIgtQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599520; c=relaxed/simple;
	bh=SXeVUfAlj7hbKusjdOmca52nvnTR1J2o8DeVLgBTJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QGCf+YwjzC98t1Yxx0E5fiYyzqmRlHqpHptUMFH+9GsOapQCXSDmp/3xA8a3V+6LPcK/j4a462ETeTZw6oLr5JT/rotvBVNQuaCJWJeASxAKLMzxM40lZR/vkpkonv90d1b0SBf8SYcS1A73BS8z1i+LARN9cT/XZijx6dUDQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XncRKz3h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729599518; x=1761135518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SXeVUfAlj7hbKusjdOmca52nvnTR1J2o8DeVLgBTJhs=;
  b=XncRKz3hEmb8yvVo6Rj2i77XyU2iFgJjjLL53Uj3eNlQm8G02LdBIMCg
   jdxLAC/KZWzQXluX/HAPS2kH3pR28CyaSlDkmlCa4pw9xNNlJIz9i8ZS9
   giijWcdmMpeURYAcCO/mzFlC8dTwVQyJBCyaRoRzxj7C7ozqIQJeZ8atu
   W2RQmF/GyRGamsXC9Xz6B7nCv07l3o6K1y62AeKaD3l6nEt4kE9ZwKf2p
   ZXb7bZtzGFDqKNFwsptBkWEv/YV3aaYe0VtO7I7K0IlVCpccjT8km7Und
   wk2gpG+Eu9JifARcqM4oGXHgVy25VCCWHnKIi5Pig7MKBq5EbQebreWAE
   g==;
X-CSE-ConnectionGUID: xF7CJyUnQtS3F4Yqbd/6Zg==
X-CSE-MsgGUID: 1kDj+2L/R1GebOfemVscRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32940156"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="32940156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 05:18:38 -0700
X-CSE-ConnectionGUID: wEVM4qEcR/GEgCPChR7LHA==
X-CSE-MsgGUID: w54+uPc6T5m3H2v+ehz+Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="117287590"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Oct 2024 05:18:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3DqL-000TYk-28;
	Tue, 22 Oct 2024 12:18:33 +0000
Date: Tue, 22 Oct 2024 20:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Simon Horman <horms@kernel.org>
Subject: drivers/net/ethernet/broadcom/bnxt/bnxt.c:5333:6-25: WARNING:
 atomic_dec_and_test variation before object free at line 5336.
Message-ID: <202410222004.wyOjgwYT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: 1f6e77cb9b328f2ec145e73be97cab6fec838678 bnxt_en: Add bnxt_l2_filter hash table.
date:   10 months ago
config: arc-randconfig-r052-20241022 (https://download.01.org/0day-ci/archive/20241022/202410222004.wyOjgwYT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410222004.wyOjgwYT-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:5333:6-25: WARNING: atomic_dec_and_test variation before object free at line 5336.

vim +5333 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  5330	
  5331	void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr)
  5332	{
> 5333		if (!atomic_dec_and_test(&fltr->refcnt))
  5334			return;
  5335		spin_lock_bh(&bp->ntp_fltr_lock);
> 5336		hlist_del_rcu(&fltr->base.hash);
  5337		if (fltr->base.flags) {
  5338			clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
  5339			bp->ntp_fltr_count--;
  5340		}
  5341		spin_unlock_bh(&bp->ntp_fltr_lock);
  5342		kfree_rcu(fltr, base.rcu);
  5343	}
  5344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

