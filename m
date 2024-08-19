Return-Path: <linux-kernel+bounces-291999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C779A9569EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DD71F23F13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38DE167296;
	Mon, 19 Aug 2024 11:53:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14F166F36
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068384; cv=none; b=a8OMhCb3vK60KJdMpF658mON9f1+iIpMJst9hi/5L4ZZVdGZWN6E1+0/ageYSrsnfsn6htojWTOtb6P1w3wF6plJZMc1p6N3DXvKZ/pjrI3HPkG7+kgYmWQF8TsJrftDa1JhEwJkNRx9/ZRtMeCtTuLrfWjlzH2dFddLYJAbwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068384; c=relaxed/simple;
	bh=k+OARink3Sd5ABEWoXoLiOg6VmZ93CyU7zwPnPNIfFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOk3NHQsr9jhgEkdP9E8ikZ/RnTNlptKaCQg1pVUsRxGepz1/kug9yJSTDRWQGzqLO0Zbn26M5znLvlo2+zoq+uh9KO5vWtPC9h0QJJHwacHV4SHdddAOTCF+2v0IGet+3bhCm6HwerIRZUGFizGMVqE5lGeWSF6gwrThTgT+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnWDR692JzyQ2M;
	Mon, 19 Aug 2024 19:52:23 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8294F180064;
	Mon, 19 Aug 2024 19:53:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/8] nvmet: Make nvmet_debugfs static
Date: Mon, 19 Aug 2024 20:00:20 +0800
Message-ID: <20240819120020.3884893-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/nvme/target/debugfs.c:16:15: warning:
	symbol 'nvmet_debugfs' was not declared. Should it be static?

This symbol is not used outside debugfs.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/nvme/target/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index cb2befc8619e..220c7391fc19 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -13,7 +13,7 @@
 #include "nvmet.h"
 #include "debugfs.h"
 
-struct dentry *nvmet_debugfs;
+static struct dentry *nvmet_debugfs;
 
 #define NVMET_DEBUGFS_ATTR(field) \
 	static int field##_open(struct inode *inode, struct file *file) \
-- 
2.34.1


