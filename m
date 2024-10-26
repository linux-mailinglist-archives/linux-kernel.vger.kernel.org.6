Return-Path: <linux-kernel+bounces-382880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5A9B1469
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084961F22999
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305B15C139;
	Sat, 26 Oct 2024 03:57:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F01DFD8;
	Sat, 26 Oct 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915066; cv=none; b=l8GJykl5/FUwxAtWOmvDi5qf31GxTwF6eaaNZH4m3yphtqfnAFpSN0kvIy4oFJJm/EsbdByvpxSPjPr6AuSXLWBM7i/bGx/lqGuPcSumE9f/mBHCfA+hhL89PFOJFAK3r2iJ+SViTO5YzRbxwVwGTelg1cP7K9krdnooG3tL7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915066; c=relaxed/simple;
	bh=MfjRLEEH73Bx7axO85yFCiYfX5F+trhTGwga2ALtTK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2+kerVxGq20lzRdai9G3/i4IkwttCH8/0L/4ZKL1VPUSLPbFkgJZsVBxWESyR9Q9TSVGfnuuGEU7ny/wf0fgh3bwE9MyRbceg/0HsCx6uxdocw5H4nzZ2KUQ+wYHWuNSot6CqpKI2VQiZRNqc5MfpMHav207fpikuIEc8gZ+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xb5SH2D2wz20qjm;
	Sat, 26 Oct 2024 11:56:47 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 066D51A0188;
	Sat, 26 Oct 2024 11:57:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 11:57:40 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v4 net-next 0/4] Fix passing 0 to ERR_PTR in intel ether drivers
Date: Sat, 26 Oct 2024 12:12:45 +0800
Message-ID: <20241026041249.1267664-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Fixing sparse error in xdp run code by introducing new variable xdp_res
instead of overloading this into the skb pointer as i40e drivers done
in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
commit ae4393dfd472 ("i40e: fix broken XDP support").

v4: Target to net-next
v3: https://lore.kernel.org/bpf/20241022065623.1282224-3-yuehaibing@huawei.com/T/
    Fix uninitialized 'xdp_res' in patch 3 and 4 which Reported-by
    kernel test robot
v2: Fix this as i40e drivers done instead of return NULL in xdp run code

Yue Haibing (4):
  igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
  igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
  ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
  ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

 drivers/net/ethernet/intel/igb/igb_main.c     | 22 +++++++-----------
 drivers/net/ethernet/intel/igc/igc_main.c     | 20 ++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
 4 files changed, 34 insertions(+), 54 deletions(-)

-- 
2.34.1


