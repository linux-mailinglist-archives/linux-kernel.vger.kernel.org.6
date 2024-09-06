Return-Path: <linux-kernel+bounces-318566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816796EFE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A0B1C2447E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476731C9DEA;
	Fri,  6 Sep 2024 09:40:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63471CB15F;
	Fri,  6 Sep 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615645; cv=none; b=Yk183szsWh9XeGRTR6JR+g+dg1iwWKJIh7QFlNjX9NVnASSVDJVvUQmXk/McuhH8QmwIVZmT5lR7/y2XWRhePPscaQfMSEz2s9Cx2H0J8JNIzCAJfbIN6Xb+xW5Rgvs4WZer9JiZu3xZeJ18aDE3WlMuEE4ja0WamDPORLodwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615645; c=relaxed/simple;
	bh=WoeHAFI+m+cfBvuAIt59Qr63ZjbXK3RvoR0ZVRfDLsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=maYrhcuTOvAyxAAf0MqGJrg7zUiTllS7IVlUNXNEoG2InfVykkEZldpvh2ImtExHpa2gDY3Nb68uWY94xl9Ms7oTz8tD3bQHgSU7qfqydC+YrMJyznH5ttKdhOQkWTIFcR2Keg14hHFiWNMdSKoP2mGsVY/Uv7qDRf+tx/pg+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0WLJ2NTPz20nb6;
	Fri,  6 Sep 2024 17:35:36 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 89A841402E1;
	Fri,  6 Sep 2024 17:40:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 17:40:35 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Bugfixes and one improvement
Date: Fri, 6 Sep 2024 17:34:35 +0800
Message-ID: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

This is a series of hns patches. Patch #8 is an improvement for
hem allocation performance, and the others are some fixes.

Chengchang Tang (2):
  RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
  RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Feng Fang (1):
  RDMA/hns: Fix different dgids mapping to the same dip_idx

Junxian Huang (3):
  RDMA/hns: Don't modify rq next block addr in HIP09 QPC
  RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
  RDMA/hns: Optimize hem allocation performance

wenglianfa (3):
  RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
  RDMA/hns: Fix cpu stuck caused by printings during reset
  RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

 drivers/infiniband/hw/hns/hns_roce_cq.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   6 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  26 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 156 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   1 +
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  32 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   4 +-
 8 files changed, 148 insertions(+), 85 deletions(-)

--
2.33.0


