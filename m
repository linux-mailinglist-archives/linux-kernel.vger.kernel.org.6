Return-Path: <linux-kernel+bounces-218620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A822D90C29E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860AF1C21367
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00944375;
	Tue, 18 Jun 2024 03:55:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026254C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682921; cv=none; b=iUxyLf+ZLyLjg3FwTPtmuGDhdgorhlu7CwmIjJG/ePbGgvbrJm0kQ2Ylf1KadYfhDJmqANAy8x3efcEXn1k4DH98AV7tARSrVazIV5mNtDhq7ftN4MvYe4p7XqmjFozWP4DqwpHJL4Y7rEU8JNIj+a8sLkeLGnV87sM4kYFeNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682921; c=relaxed/simple;
	bh=VeEQ2LLw0AnrCnhN7XVkzjGjzXezS7uhaf2Ca31ZvNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1yzzT8aWOTGQLXLEd/PdpPHwG/EKGiQJM2QYSAdmiQiBFuv7XtjetCzCRz4uahxYTyQHTMKk5u8HUO2lGSJmyoBXlfKWfboTxPaejlwbx2PxqlGpvZ5DgOz9aOBvbP61BcSyfcfgEopAiGjXi5HsciyP3I4XiZQ9bWqb5pjKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W3CTk63rfzxRvh;
	Tue, 18 Jun 2024 11:51:06 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E0BB1402C8;
	Tue, 18 Jun 2024 11:55:17 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 11:55:17 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm/hugetlb_cgroup: register lockdep key for cftype
Date: Tue, 18 Jun 2024 03:47:23 +0000
Message-ID: <20240618034723.2122429-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)

The commit e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on
template") has changed the cftypes from static allocated objects to
dynamic ones, so the cft->lockdep_key should be registered proactively.

Fixes: e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on template")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406181046.8d8b2492-oliver.sang@intel.com
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/hugetlb_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2b899c4ae968..4ff238ba1250 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
 			cft->file_offset = MEMFILE_OFFSET0(offset) +
 					   MEMFILE_FIELD_SIZE(offset) * idx;
 		}
+
+		lockdep_register_key(&cft->lockdep_key);
 	}
 }
 
-- 
2.34.1


