Return-Path: <linux-kernel+bounces-434959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6139E6D71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51D2280C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4261FF60B;
	Fri,  6 Dec 2024 11:34:34 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D23D6A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484874; cv=none; b=fPV5dVtabL88YsJ7BqxOj2Jcv4wBxJBrsQJcCQrB/CQ+KeVyiVPj4RzpA9d4RDRwPy7lKmTOYz8sXMcEnoP8nRs78UjwrP0x5MLKJ76mJ2x7NPPGE35MZ2+XPrzLvWnyAWUdXpdgYFEuc465724HyN3mqnIEEhPYUbDRpqE0xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484874; c=relaxed/simple;
	bh=ixfvE+E8VcaiLUg8NUmRfk7NXyxqqhCYPo+laKyJB5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMtyJ3U0q7GhMHhpRYA2OMCtRPrVJDJuJ/AGOaKMhokbm54EBrv2/zD8s2bZjRjtwaQx0IjOejt1ol5T5HwATcxVCa0Mv/Q3y46EQiP7+7ph213DcbeeQmwPu+2N8i7gTp5eEytyzSEXGtwyazQMYNbEPshDGzAqlcaK2mLrhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y4Tcm21Kgz1T6WC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:32:08 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E6921A0188
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:34:28 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 19:34:27 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <xuwei5@hisilicon.com>, <lihuisong@huawei.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 0/2] soc: hisilicon: Add power control support for kunpeng HBM
Date: Fri, 6 Dec 2024 19:28:10 +0800
Message-ID: <20241206112812.32618-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Add power control support for High Bandwidth Memory (HBM) for Kunpeng SoC
platform. HBM devices on Kunpeng SoC can provide higher bandwidth at the
cost of higher power consumption. Providing power control methods can help
reducing the power when the workload does not need use HBM.

Zhang Zekun (2):
  soc: hisilicon: kunpeng_hbmdev: Add support for controling the power
    of hbm memory
  soc: hisilicon: kunpeng_hbmcache: Add support for online and offline
    the hbm cache

 MAINTAINERS                              |   7 +
 drivers/soc/hisilicon/Kconfig            |  23 +++
 drivers/soc/hisilicon/Makefile           |   2 +
 drivers/soc/hisilicon/kunpeng_hbm.h      |  31 ++++
 drivers/soc/hisilicon/kunpeng_hbmcache.c | 136 +++++++++++++++
 drivers/soc/hisilicon/kunpeng_hbmdev.c   | 210 +++++++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbm.h
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbmcache.c
 create mode 100644 drivers/soc/hisilicon/kunpeng_hbmdev.c

-- 
2.17.1


