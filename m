Return-Path: <linux-kernel+bounces-258450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4C93880C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C333DB20E80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05E15AF6;
	Mon, 22 Jul 2024 04:22:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EF107A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721622139; cv=none; b=IILsjv76ea/FeYoOObic7Zb40DC4J3Xb19p/pGugak2xwrZJka1cy20L6ZXWIVTkSLMznBxYt+94Kje13s1pQule4KX2g33BbPXXrUIgjEMRHyVVyj6MtCL9H32Qxm6VSN1XlvWkqKhnG++RJoapXIWG6WsTs0kHTMaTEKv5WLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721622139; c=relaxed/simple;
	bh=CIdA4fQA5z6QtGa9EosPPpNk2YWKcLz9OOlBkgr1yUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ahs7L6ZXAtO/oTIX0EXgcTBxDxgZOWNwjEk6TN2ehTAD2Hm49aYCzz8WNQvLvc9dLZV1OPR+uWzQRXYVYJKfPL1DZpGddlEeP6S6tUELMb375kO7kzW+YPGsxtU2MJVI1LCap65K0H3ts/v74lMFWIlPXOYg71MPfaujaAuEYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WS65r0m15zQmZg;
	Mon, 22 Jul 2024 12:01:20 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id C87A41800A2;
	Mon, 22 Jul 2024 12:05:28 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:27 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 0/4] arm_mpam: Fix several minor issues
Date: Mon, 22 Jul 2024 12:01:17 +0800
Message-ID: <20240722040121.515021-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After completing the necessary software adaptation for the local chipset,
the MPAM function is successfully enabled. After related tests are
completed, some issues were discovered and here attempt to fix them.

Hope to get some suggestions for modifications, if I miss any rules should
be followed, please let me know.

Zeng Heng (4):
  arm_mpam: Correct MBA granularity calculation
  arm_mpam: Fix the range calculation of the implemented bits
  arm_mpam: Correct the judgment condition of the CMAX feature
  arm_mpam: Fix typo about mbw_min controls

 drivers/platform/arm64/mpam/mpam_devices.c  | 8 +++++---
 drivers/platform/arm64/mpam/mpam_internal.h | 1 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

--
2.25.1


