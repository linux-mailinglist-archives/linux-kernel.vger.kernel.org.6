Return-Path: <linux-kernel+bounces-352430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF2991EFD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6035283392
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04B13665B;
	Sun,  6 Oct 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BfMbgGke"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5A4C74
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226099; cv=none; b=lQcFR1ktd/X0f/PemLVeeKNFL5XK3+qV/CClhohtk7mX4i4A0kUz1yyysRcBXmLQzMcMwzsuYvkYsNEDI4m1anvmCz/B1z2WQCJxvcm8VqWXwiadsW/CO5uN0PQshH+9WJ23ktJJYYDfPwpcjtnAZKogWmKdVS211zskjc9AnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226099; c=relaxed/simple;
	bh=3Qh9J1EhE/23UWza+yADuw2U64gBESq0jupH48J5HCI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=NXaGiaRBgxjV2vMJeEH3yRX6nXMQYqRGYq9qyVdDXmuqT6qUta9i7IN994W4HxqHoFtWTwFR+WSqHEk68GdqIldFnzLT+gplH7hF+WIXrbPakreNFL/tMgd729/cJHo3PiLlC9xCHXp8O8OEX2kMk18WsHg2F9PFjfD0XCkMLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BfMbgGke; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yc4W8h3d+Io5SHrgtOHGv7AxCebdp+fLZFZDnX4QqIQ=;
  b=BfMbgGkeLQ1/L8q++n6VuSf1+mKace8VmQyKb2IJ/trjWtF+6ilFxq81
   Szw/aDWPfDACASI9j4fmi4ZFw3L4q73Kzc/e4ENv0rq7dmas2AFmJ7JkN
   jDNv6HZN5KtQARRzE/mNR8LReEaF49NDfNktL6W26x74n/3Eu4rP9eo7t
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,182,1725314400"; 
   d="scan'208";a="98328767"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 16:48:08 +0200
Date: Sun, 6 Oct 2024 16:48:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jinjie Ruan <ruanjinjie@huawei.com>, Paolo Abeni <pabeni@redhat.com>, 
    Jacob Keller <jacob.e.keller@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR: invalid
 reference to the index variable of the iterator on line 7890 (fwd)
Message-ID: <alpine.DEB.2.22.394.2410061645380.12182@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please check the test on line 7895.  entry will never be NULL.  If the
loop reaches the end of the list, it will point to some offset from a
list_head node and entry->free will at best be some random value.

julia

---------- Forwarded message ----------
Date: Sun, 6 Oct 2024 22:28:12 +0800
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
head:   8f602276d3902642fdc3429b548d73c745446601
commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
date:   1 year ago
:::::: branch date: 16 hours ago
:::::: commit date: 1 year ago
config: x86_64-randconfig-r062-20241006 (https://download.01.org/0day-ci/archive/20241006/202410062237.zvQc58MX-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202410062237.zvQc58MX-lkp@intel.com/

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

