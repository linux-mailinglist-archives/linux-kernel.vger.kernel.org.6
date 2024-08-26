Return-Path: <linux-kernel+bounces-301040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF095EBCA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEFB1F21158
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447311422DC;
	Mon, 26 Aug 2024 08:21:03 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A413DBB6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660462; cv=none; b=ONsvW9GVKbPUVa26AsYAI/c73hZNR66hneh2YTokSjjwP8vvZgbTCb3FcyW6+M29Hgboe8lb3dx8BN2M3CLrjdNE9fhwvsXOzlBbgNNhIQU1a+rXDlwTIF9p+G2d/DcungAAnAJi00lxnXZtoWqtMj8b/CvG6x5Ip2Z+Rz7Aol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660462; c=relaxed/simple;
	bh=/b5nxf8TwGGTKFF2ttwaStE+X2MLcmnAfsUr9iqgwuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YV5nGlNfiLuhISTdwsbDI2asX3z4762ycNsXxsry3vQOqk3bgoT52nNQyR9Arphj+iWkbEGCRMQGpEeYASN6iUTGMJhKrKnHH8n8yXLLuuLtwPY1rZMihZc7p45+X9rTyG3XjBnXp4xF2CM/wyWZDn27x8RMeF2SfywUbs3w7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsk9N2yhpzpTc3;
	Mon, 26 Aug 2024 16:19:20 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B2D21800F2;
	Mon, 26 Aug 2024 16:20:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:20:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 00/12] mfd: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:35 +0800
Message-ID: <20240826082847.2591036-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Jinjie Ruan (12):
  mfd: max77620: Use for_each_child_of_node_scoped()
  mfd: qcom-spmi-pmic: Use for_each_child_of_node_scoped()
  mtd: rawnand: arasan: Use for_each_child_of_node_scoped()
  mtd: rawnand: cadence: Use for_each_child_of_node_scoped()
  mtd: rawnand: pl353: Use for_each_child_of_node_scoped()
  mtd: rawnand: marvell: drm/rockchip: Use
    for_each_child_of_node_scoped()
  mtd: rawnand: rockchip: Use for_each_child_of_node_scoped()
  mtd: rawnand: meson: Use for_each_child_of_node_scoped()
  mtd: rawnand: mtk: Use for_each_child_of_node_scoped()
  mtd: rawnand: renesas: Use for_each_child_of_node_scoped()
  mtd: rawnand: stm32_fmc2: Use for_each_child_of_node_scoped()
  mtd: rawnand: sunxi: Use for_each_child_of_node_scoped()

 drivers/mfd/max77620.c                          |  5 ++---
 drivers/mfd/qcom-spmi-pmic.c                    |  5 +----
 drivers/mtd/nand/raw/arasan-nand-controller.c   |  5 ++---
 drivers/mtd/nand/raw/cadence-nand-controller.c  |  4 +---
 drivers/mtd/nand/raw/marvell_nand.c             | 12 +++---------
 drivers/mtd/nand/raw/meson_nand.c               |  4 +---
 drivers/mtd/nand/raw/mtk_nand.c                 |  7 ++-----
 drivers/mtd/nand/raw/pl35x-nand-controller.c    |  5 ++---
 drivers/mtd/nand/raw/renesas-nand-controller.c  | 12 +++---------
 drivers/mtd/nand/raw/rockchip-nand-controller.c |  5 ++---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c          |  7 ++-----
 drivers/mtd/nand/raw/sunxi_nand.c               |  4 +---
 12 files changed, 22 insertions(+), 53 deletions(-)

-- 
2.34.1


