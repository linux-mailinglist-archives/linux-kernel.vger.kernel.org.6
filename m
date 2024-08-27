Return-Path: <linux-kernel+bounces-302527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685595FFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F388D2832B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4551A291;
	Tue, 27 Aug 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmreND5J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E31803D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729399; cv=none; b=UeBLaujs7MArkxkCBKsLyiOpoKnKRjVvd3hyvSQcF6scx/eTUzSlShcyfSb/isow8c0FY1twsVe4Sn0/65HotEFGC8ViBJWyJV3+jemmqItCpQhY8c0sXy8mhZAkLhvvCqdBeTLy5/GHde9eqhT3Lea1LOZhMc2KzNFATML8tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729399; c=relaxed/simple;
	bh=nDDZZa2NUt3MBOd2plEH/XJHDllkd3y93u3Wq/0eZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUOtDojX7JnwXDhAz1frQFdR57vE3k0WNM1+QunX0h6tuoxFbhAS6rEw2YZ/TN7vzzBdPRRw4/SrxTMViKkTvHSADmlqYIJ39M0qQac8lWgaziOwKDuRlK4zaNHhP5BRxvSwIKFEtynMxrmGmFzGAxtEY3S9B0qbILKZBVHIooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmreND5J; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724729398; x=1756265398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nDDZZa2NUt3MBOd2plEH/XJHDllkd3y93u3Wq/0eZ0w=;
  b=lmreND5J1g4z6TrBebk2aDNWaFW30nmOT4H3BtwwvtfcHcfsICXgZWW8
   W1jJjYGhCnvruCbI+/xFHfjBjDZlZdCgUSPwBpPT4z8Bkat5G/QerQaE2
   6ExOVSK3OZYEZcEykb0B0pwJmJ8kvDjEcl24x66QzB7U2rAAba9Q8WXcu
   dF7uMDSQ2D6xBrmhRLgIfvVgGj/1ur6axlC4nvFKdIunSKbzffDadDKI7
   24CxBIPFdbrhOcvD5JMHaF5LJHCPE95jWnh/ZrqnwiQbxcFtzpRleofja
   mrbWBOz5f94fDK4cflSeEk5gGWR3Q+iNQLsTqCwSsdotMJeV6H8FFbFNE
   w==;
X-CSE-ConnectionGUID: J0auDqjRQQKS4cAAbHD7JQ==
X-CSE-MsgGUID: yTr9u1TkT56aODU78K41ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33847372"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33847372"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 20:27:47 -0700
X-CSE-ConnectionGUID: LTtUaULPSgmoe1IavD1cNA==
X-CSE-MsgGUID: Srw/+DRkTUS+v7mgMETgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62552107"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Aug 2024 20:27:44 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1simru-000Hqs-0Q;
	Tue, 27 Aug 2024 03:27:42 +0000
Date: Tue, 27 Aug 2024 11:26:54 +0800
From: kernel test robot <lkp@intel.com>
To: Wang Zhaolong <wangzhaolong1@huawei.com>, richard@nod.at,
	miquel.raynal@bootlin.com, vigneshr@ti.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	wangzhaolong1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] mtd: ubi: remove unused parameter 'pnum' from
 add_volume()
Message-ID: <202408271041.ttLMjF8z-lkp@intel.com>
References: <20240825083515.4074081-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825083515.4074081-1-wangzhaolong1@huawei.com>

Hi Wang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rw-ubifs/next]
[also build test WARNING on rw-ubifs/fixes linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Zhaolong/mtd-ubi-remove-unused-parameter-pnum-from-add_volume/20240826-142424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
patch link:    https://lore.kernel.org/r/20240825083515.4074081-1-wangzhaolong1%40huawei.com
patch subject: [PATCH] mtd: ubi: remove unused parameter 'pnum' from add_volume()
config: i386-buildonly-randconfig-005-20240827 (https://download.01.org/0day-ci/archive/20240827/202408271041.ttLMjF8z-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271041.ttLMjF8z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271041.ttLMjF8z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/ubi/attach.c:398: warning: Excess function parameter 'pnum' description in 'add_volume'


vim +398 drivers/mtd/ubi/attach.c

801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  382  
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  383  /**
a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  384   * add_volume - add volume to the attaching information.
a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  385   * @ai: attaching information
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  386   * @vol_id: ID of the volume to add
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  387   * @pnum: physical eraseblock number
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  388   * @vid_hdr: volume identifier header
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  389   *
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  390   * If the volume corresponding to the @vid_hdr logical eraseblock is already
a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  391   * present in the attaching information, this function does nothing. Otherwise
a4e6042f1d07307 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  392   * it adds corresponding volume to the attaching information. Returns a pointer
fbd0107f4d33be0 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  393   * to the allocated "av" object in case of success and a negative error code in
fbd0107f4d33be0 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  394   * case of failure.
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  395   */
beba9855702e14c drivers/mtd/ubi/attach.c Wang Zhaolong       2024-08-25  396  static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai, int vol_id,
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  397  					  const struct ubi_vid_hdr *vid_hdr)
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27 @398  {
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  399  	struct ubi_ainf_volume *av;
de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  400  	bool created;
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  401  
3261ebd7d4194ff drivers/mtd/ubi/scan.c   Christoph Hellwig   2007-05-21  402  	ubi_assert(vol_id == be32_to_cpu(vid_hdr->vol_id));
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  403  
de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  404  	av = ubi_find_or_add_av(ai, vol_id, &created);
de4c455b3e9f630 drivers/mtd/ubi/attach.c Boris Brezillon     2016-09-16  405  	if (IS_ERR(av) || !created)
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  406  		return av;
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  407  
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  408  	av->used_ebs = be32_to_cpu(vid_hdr->used_ebs);
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  409  	av->data_pad = be32_to_cpu(vid_hdr->data_pad);
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  410  	av->compat = vid_hdr->compat;
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  411  	av->vol_type = vid_hdr->vol_type == UBI_VID_DYNAMIC ? UBI_DYNAMIC_VOLUME
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  412  							    : UBI_STATIC_VOLUME;
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  413  
517af48c0540e61 drivers/mtd/ubi/scan.c   Artem Bityutskiy    2012-05-17  414  	return av;
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  415  }
801c135ce73d5df drivers/mtd/ubi/scan.c   Artem B. Bityutskiy 2006-06-27  416  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

