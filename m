Return-Path: <linux-kernel+bounces-308121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7B965792
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E4D1C2248D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5F1531D4;
	Fri, 30 Aug 2024 06:24:28 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88514A0B6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999067; cv=none; b=SHl/X/N+6H5fbs5bXi8BpROjWMoJrpKhfXWUPpEaEs7a7w8941iQniRiP64KloU6TzBFL540P/ClqRpe2+dPySaxgJU4fqXkH7VWfoN9mTEES+tYBRCinN8I3LUXzA3ND1cuZLKwuAQsXUp98+U3ofPlQeMK2yLu+89P2ZbMJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999067; c=relaxed/simple;
	bh=0/aKtq6DVhNpyWnEeUcnJz2hwZwjEWX9C6TxaOrhxaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDu+BLAvUdeTDckMvId0wqeNQf7HSMLAqmfb1s7iM8oXcLnxmq/xw7d9ob0e2Rd+oEwRIUI0rvLb/VTMBpW1BmLfkYMq2tx9DY7Twk5YBvuubKKofeHyHXu79qHDz2zWCYNpAei1/CuXfmahR/1Gfp1f2fRAsNQaYkFGwTobaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ww7NZ5Rjwz1xwPk;
	Fri, 30 Aug 2024 14:22:22 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3841B14011D;
	Fri, 30 Aug 2024 14:24:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:24:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/4] soc: ti: Simplify with scoped for each OF child loop and dev_err_probe()
Date: Fri, 30 Aug 2024 14:32:24 +0800
Message-ID: <20240830063228.3519385-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Changes in v2:
- Rebased.
- Split from the whole soc patch set.
- Split Simplify with scoped for each OF child and dev_err_probe().
- Update the commit message.

Jinjie Ruan (4):
  soc: ti: knav_dma: Simplify with scoped for each OF child loop
  soc: ti: knav_dma: Use dev_err_probe() to simplfy code
  soc: ti: knav_qmss_queue: Simplify with scoped for each OF child loop
  soc: ti: knav_qmss_queue: Simplify with dev_err_probe()

 drivers/soc/ti/knav_dma.c        | 16 ++++--------
 drivers/soc/ti/knav_qmss_queue.c | 45 ++++++++++----------------------
 2 files changed, 19 insertions(+), 42 deletions(-)

-- 
2.34.1


