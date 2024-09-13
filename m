Return-Path: <linux-kernel+bounces-328676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A3978737
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762171F21974
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F685656;
	Fri, 13 Sep 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="MYIzwfXC"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FF86131
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249920; cv=none; b=IQUU2YBL7aV83bN5fjUlbNxeD4ijTZpN5BIp6MI/ftZXoI/8Z9YAEKhKYD2rK3JeInAW5byTB6tzzyTXidDvpm3NMGG01JQHSsw3I85wb396t2hzIV7l4Ak2qjqcazU0zOJ9hzBv278hwC6ScoUJ+eXzHr0w9lPWE0MHh2+OhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249920; c=relaxed/simple;
	bh=zvK49zvMWEnYsN5T/T0PU6C++FroTy2HLBUG4x8PoPQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=P5PwTuw1MCCkASpeJiWvQdntjLNq1Q1GPNP9gIrakqp91IAX5qZSRoNNAyFqLJgheBYtVT4jlnQXdOlmR2gnsHp+jEKjWGgafPzJIK/3z+BExxQFvVKxRHL0zOS/vggWcNLbM/aNQaLYaE7mJvC5bgStzL0KP6HFoRVZdAvWaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=MYIzwfXC; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qrs2z/urRWdAHvlvqcl0vvrtK5/O8hGQBRStCtceCf0=;
  b=MYIzwfXCcPlyWfHKXSgpmiFs8GiYjtn+ROtWLH8K/piLtG4+O7AFSGpd
   vnijrzIvpI0zR7nJhjObV7cP9Lp7Awhl7mg/loKh4bHr+FpcswhTSheNU
   QThWlD7/brJQLUzXPeXmtEFtvqiq5jykuZZVKYUxG8/nyfXUGcGESDR5F
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,226,1719871200"; 
   d="scan'208";a="183080143"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 19:51:49 +0200
Date: Fri, 13 Sep 2024 19:51:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jinjie Ruan <ruanjinjie@huawei.com>, Paolo Abeni <pabeni@redhat.com>, 
    Jacob Keller <jacob.e.keller@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid
 reference to the index variable of the iterator on line 7890 (fwd)
Message-ID: <alpine.DEB.2.22.394.2409131949580.3731@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On line 7895, entry is never NULL, even if you are at the end (which is
the same as the beginning) of the list.

julia

---------- Forwarded message ----------
Date: Sat, 14 Sep 2024 01:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid
    reference to the index variable of the iterator on line 7890

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Jinjie Ruan <ruanjinjie@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Jacob Keller <jacob.e.keller@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Simon Horman <horms@kernel.org>

Hi Jinjie,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   196145c606d0f816fd3926483cb1ff87e09c2c0b
commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
date:   12 months ago
:::::: branch date: 18 hours ago
:::::: commit date: 12 months ago
config: microblaze-randconfig-r052-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140131.Y6Qnoc6t-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202409140131.Y6Qnoc6t-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid reference to the index variable of the iterator on line 7890
   drivers/net/ethernet/intel/igb/igb_main.c:7895:15-20: ERROR: invalid reference to the index variable of the iterator on line 7890

vim +7895 drivers/net/ethernet/intel/igb/igb_main.c

83c21335c87622 Yury Kylulin     2017-03-07  7854
b476deab8f412b Colin Ian King   2017-04-27  7855  static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
4827cc37796a02 Yury Kylulin     2017-03-07  7856  				 const u32 info, const u8 *addr)
4827cc37796a02 Yury Kylulin     2017-03-07  7857  {
4827cc37796a02 Yury Kylulin     2017-03-07  7858  	struct pci_dev *pdev = adapter->pdev;
4827cc37796a02 Yury Kylulin     2017-03-07  7859  	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
4827cc37796a02 Yury Kylulin     2017-03-07  7860  	struct vf_mac_filter *entry = NULL;
4827cc37796a02 Yury Kylulin     2017-03-07  7861  	int ret = 0;
4827cc37796a02 Yury Kylulin     2017-03-07  7862
1b8b062a99dc76 Corinna Vinschen 2018-01-17  7863  	if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
1b8b062a99dc76 Corinna Vinschen 2018-01-17  7864  	    !vf_data->trusted) {
4827cc37796a02 Yury Kylulin     2017-03-07  7865  		dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7866  			 "VF %d requested MAC filter but is administratively denied\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7867  			  vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7868  		return -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7869  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7870  	if (!is_valid_ether_addr(addr)) {
4827cc37796a02 Yury Kylulin     2017-03-07  7871  		dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7872  			 "VF %d attempted to set invalid MAC filter\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7873  			  vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7874  		return -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7875  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7876
584af82154f56e Karen Sornek     2021-08-31  7877  	switch (info) {
584af82154f56e Karen Sornek     2021-08-31  7878  	case E1000_VF_MAC_FILTER_CLR:
584af82154f56e Karen Sornek     2021-08-31  7879  		/* remove all unicast MAC filters related to the current VF */
c1fec890458ad1 Jinjie Ruan      2023-09-19  7880  		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
584af82154f56e Karen Sornek     2021-08-31  7881  			if (entry->vf == vf) {
584af82154f56e Karen Sornek     2021-08-31  7882  				entry->vf = -1;
584af82154f56e Karen Sornek     2021-08-31  7883  				entry->free = true;
584af82154f56e Karen Sornek     2021-08-31  7884  				igb_del_mac_filter(adapter, entry->vf_mac, vf);
584af82154f56e Karen Sornek     2021-08-31  7885  			}
584af82154f56e Karen Sornek     2021-08-31  7886  		}
584af82154f56e Karen Sornek     2021-08-31  7887  		break;
584af82154f56e Karen Sornek     2021-08-31  7888  	case E1000_VF_MAC_FILTER_ADD:
4827cc37796a02 Yury Kylulin     2017-03-07  7889  		/* try to find empty slot in the list */
c1fec890458ad1 Jinjie Ruan      2023-09-19 @7890  		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
4827cc37796a02 Yury Kylulin     2017-03-07  7891  			if (entry->free)
4827cc37796a02 Yury Kylulin     2017-03-07  7892  				break;
4827cc37796a02 Yury Kylulin     2017-03-07  7893  		}
4827cc37796a02 Yury Kylulin     2017-03-07  7894
4827cc37796a02 Yury Kylulin     2017-03-07 @7895  		if (entry && entry->free) {
4827cc37796a02 Yury Kylulin     2017-03-07  7896  			entry->free = false;
4827cc37796a02 Yury Kylulin     2017-03-07  7897  			entry->vf = vf;
4827cc37796a02 Yury Kylulin     2017-03-07  7898  			ether_addr_copy(entry->vf_mac, addr);
4827cc37796a02 Yury Kylulin     2017-03-07  7899
4827cc37796a02 Yury Kylulin     2017-03-07  7900  			ret = igb_add_mac_filter(adapter, addr, vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7901  			ret = min_t(int, ret, 0);
4827cc37796a02 Yury Kylulin     2017-03-07  7902  		} else {
4827cc37796a02 Yury Kylulin     2017-03-07  7903  			ret = -ENOSPC;
4827cc37796a02 Yury Kylulin     2017-03-07  7904  		}
4827cc37796a02 Yury Kylulin     2017-03-07  7905
4827cc37796a02 Yury Kylulin     2017-03-07  7906  		if (ret == -ENOSPC)
4827cc37796a02 Yury Kylulin     2017-03-07  7907  			dev_warn(&pdev->dev,
4827cc37796a02 Yury Kylulin     2017-03-07  7908  				 "VF %d has requested MAC filter but there is no space for it\n",
4827cc37796a02 Yury Kylulin     2017-03-07  7909  				 vf);
4827cc37796a02 Yury Kylulin     2017-03-07  7910  		break;
4827cc37796a02 Yury Kylulin     2017-03-07  7911  	default:
4827cc37796a02 Yury Kylulin     2017-03-07  7912  		ret = -EINVAL;
4827cc37796a02 Yury Kylulin     2017-03-07  7913  		break;
4827cc37796a02 Yury Kylulin     2017-03-07  7914  	}
4827cc37796a02 Yury Kylulin     2017-03-07  7915
4827cc37796a02 Yury Kylulin     2017-03-07  7916  	return ret;
4827cc37796a02 Yury Kylulin     2017-03-07  7917  }
4827cc37796a02 Yury Kylulin     2017-03-07  7918

:::::: The code at line 7895 was first introduced by commit
:::::: 4827cc37796a02ece7097e01dad8e08f537ac815 igb/igbvf: Add VF MAC filter request capabilities

:::::: TO: Yury Kylulin <yury.kylulin@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

