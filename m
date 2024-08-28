Return-Path: <linux-kernel+bounces-304828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1C2962568
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB42853E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879517554A;
	Wed, 28 Aug 2024 10:59:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393B173357
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842795; cv=none; b=AMCOoXAuSpyaudkFirrnaJzLh6Dxle2guDZYgGEtht0csREWheHKST6sU/KrfuVmniIeJbgM0IMx7Hj84wz55Ep956iFzYylRK7G4wwo1tG0y2UBCQv+qklOxXuUJ7ZYC1uZNcCBDAblN8AtZileaJpoq7CsyH5hQXiMHuNLC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842795; c=relaxed/simple;
	bh=xfijfmp9GTUxadCPBU/jFBju7fVqQKPZhG22qWOpdm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SZWR9t4CYieZoUTz2NDb+w+xO/T77p0v349NruLIDsPSzwl8UarQAIUp2lttCqcpwGT644ucGoKxByREe2N7SS9QpOqHODvz+hSeE7lexldQuzpFq1nwH5j6XaL6j9pbKyDaqniVv/7v/d2F4dtk/8JBRgp7mPV0BaTkmPfO9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wv1Wz5HPCzQr0J;
	Wed, 28 Aug 2024 18:54:55 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 873861401F2;
	Wed, 28 Aug 2024 18:59:45 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 18:59:44 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 0/6] Add some features and bugfix for kunpeng_hccs
Date: Wed, 28 Aug 2024 18:49:50 +0800
Message-ID: <20240828104956.20214-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
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

This series is aimed to support the low power feature and add used
HCCS types sysfs. And fix some bugfix to harden codes by the way.

---
 v3:
  - add Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>.
  - drop 'none' string print according to Jonathan's suggestion.
  - early return in hccs_wait_serdes_adapt_completed.
  - fix commit log in patch[2/6], patch[3/6] and patch[5/6]

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
 drivers/soc/hisilicon/kunpeng_hccs.c          | 514 +++++++++++++++++-
 drivers/soc/hisilicon/kunpeng_hccs.h          |  33 +-
 4 files changed, 580 insertions(+), 19 deletions(-)

-- 
2.22.0


