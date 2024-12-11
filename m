Return-Path: <linux-kernel+bounces-440727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F89EC362
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AB51887A40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274E20DD60;
	Wed, 11 Dec 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GE/aW2v0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F186F073
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888305; cv=none; b=dVhut4kXtV3QPv208fVE+6jsA+3WTwwqYETYVrFsqrzQlD/2It2uyDO5rqwjJymS+dprrDghFiQfWr2hjGA31JM58yJgriCy60cJ0NEjKGxSHV32H/QpNdsVsEsMp+jTPxQDRRf/9S58z2pvZWrDqsVq5ct9fI0bIIqvyMFeRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888305; c=relaxed/simple;
	bh=jcfySY+U3MqIkiFsB1y5SqVlWq6DyDBCIMMJSImQk38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tjpmkwpc8cgkrdG4sy/Q8ENZhaEFzdUhwXKPIBpc0r2qCnWqJ+dtBfq0n3VBGiJBJsHTrPW3dkbv6E5fYKJv/anxjCItWmpL4FMDGAQ+Y29BT1gBH49mgXYtUQlZxOopPmakyy94XM16gxXheAST7f0SxxJ0qM1Ce2jTzFcaIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GE/aW2v0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733888304; x=1765424304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jcfySY+U3MqIkiFsB1y5SqVlWq6DyDBCIMMJSImQk38=;
  b=GE/aW2v0Eu1gJan7HUnhM4ctnFLf7sttab27N4D3yNrpe9nc9TiheH7+
   r9+4dvwtUTEqx9WrbL5sqe0ltos6Q5RZjv3SyRme6Xu3FQgEDwvjyhCBq
   TRGqU71TNfdEJEqotyGgWa/f9RhlwVC7wJzNZZwM2TNhAl0JPp9JACjAT
   Wkx2buONOa5u60HrSCZCXdnmXFHQ+3xjOOuTbSLEGADw9NEJ9VDomJGhY
   pUIjiAy1hlCRebNs1it91d07GvvYEmb8wfrc2ZgARKxbbZYx5pIMQ4ms/
   lmedMkSGxy4qJ4eJlqgOu1WbYDipYowoNTOSEtKvWhlNF18pkLTryPRm5
   A==;
X-CSE-ConnectionGUID: q/oMAGyXT9S4/DYAA4Y/Aw==
X-CSE-MsgGUID: aGQ5+LlPSJSCvUoi55jcyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34395461"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34395461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:38:24 -0800
X-CSE-ConnectionGUID: 8naVvrPEStWgg9sXD9s15Q==
X-CSE-MsgGUID: Lg2LVxaNRsePYP/Wb8PURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100460776"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Dec 2024 19:38:16 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLDYD-0006ET-0T;
	Wed, 11 Dec 2024 03:38:13 +0000
Date: Wed, 11 Dec 2024 11:37:24 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Simon Horman <horms@kernel.org>
Subject: drivers/net/ethernet/broadcom/bnxt/bnxt.c:5333:6-25: WARNING:
 atomic_dec_and_test variation before object free at line 5336.
Message-ID: <202412111151.G84SK1aw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7cb1b466315004af98f6ba6c2546bb713ca3c237
commit: 1f6e77cb9b328f2ec145e73be97cab6fec838678 bnxt_en: Add bnxt_l2_filter hash table.
date:   11 months ago
config: sparc64-randconfig-r061-20241210 (https://download.01.org/0day-ci/archive/20241211/202412111151.G84SK1aw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111151.G84SK1aw-lkp@intel.com/

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

