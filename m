Return-Path: <linux-kernel+bounces-298193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA195C3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C31F2463F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A16A332;
	Fri, 23 Aug 2024 03:21:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A56BFB5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383263; cv=none; b=S77gTQbreqNJU35Ru6vyRyZ5ByoQMbm0JLfz2RNuaC7YK3jSNVKa127pm82h1D8whPH4Mu3CDX/802WZuYdNjeOurkK3mzvToMYQWKt/qe4pGt4Jt7/UFkH/3YYOrVivGxDq89BKbX9D7vHii6Rpi1i1ST2wZTt9fmOa5q2BWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383263; c=relaxed/simple;
	bh=2zteYi6AAjceDwUZM5OU/96cSIPFNIzqUT9CKX/9NM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eb9JWl3Qu+LxN8sY+kJGGkS6eT/MsYl/R6L9FG4Cap/p+b1ZXoyzXJiBOF2agFLMVBLECFcdCBjP7aTkWLqaR5Sl8o7Zzl9peDsU3+44n1E0uxvTtaEH1VkJOaBgrlZfXrENMxGngDgwYSUP3kmUC/ozjalZo6Bf1uvQ8rK/ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqlhK3xQjz1j6gR;
	Fri, 23 Aug 2024 11:20:49 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id D04DF1402E1;
	Fri, 23 Aug 2024 11:20:53 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:53 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 0/6] Add some features and bugfix for kunpeng_hccs
Date: Fri, 23 Aug 2024 11:10:53 +0800
Message-ID: <20240823031059.32579-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240718071134.31155-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)

This series are intended to support the low power feature for specified
HCCS and add used HCCS types sysfs. In addition, fix some bugfix and
enhance some codes.

---
 v2:
  - remove "this patch" words in commit log suggested by Krzyszto.
  - use for_each_set_bit to replace the cycle scanning all HCCS IP.
  - add a patch to rename the 'lane_mode' to 'max_lane_num' to make it
    easy to see.
  - add doc description into the code patch.
  - rename the name of the low power interface.
  - adjust the increasing and decreasing lane interface description.
  - do not create available_inc_dec_lane_types when no HCCS type support
    low power.
---

Huisong Li (6):
  soc: hisilicon: kunpeng_hccs: Fix a PCC typo
  soc: hisilicon: kunpeng_hccs: Return failure on having not die or port
    information
  soc: hisilicon: kunpeng_hccs: Add the check for base address and size
    of shared memory
  soc: hisilicon: kunpeng_hccs: Fix the 'lane_mode' field name in port
    info structure to 'max_lane_num'
  soc: hisilicon: kunpeng_hccs: Add used HCCS types sysfs
  soc: hisilicon: kunpeng_hccs: Support low power feature for the
    specified HCCS type

 .../sysfs-devices-platform-kunpeng_hccs       |  45 ++
 drivers/soc/hisilicon/Kconfig                 |   7 +-
 drivers/soc/hisilicon/kunpeng_hccs.c          | 516 +++++++++++++++++-
 drivers/soc/hisilicon/kunpeng_hccs.h          |  33 +-
 4 files changed, 582 insertions(+), 19 deletions(-)

-- 
2.22.0


