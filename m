Return-Path: <linux-kernel+bounces-177662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA158C42C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0715B286A71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01215358E;
	Mon, 13 May 2024 14:01:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64971153572
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608902; cv=none; b=mAHxmQ2+O6CJtWnm61+Ql1dWUbTshx+53K5HtjwswYiY+ZbiaOJhDAy4LNqSyAkQE2k6exxqAxnDx/8wldkavubT3ShE0/JmX5aov+4UDP1hwto7e5bR6zyYmaDR6SEBLjHFHDjq5KGx+vh1GEv6LjvNZm8Kv/s1fTkfZRUti0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608902; c=relaxed/simple;
	bh=DqqiMdOsLjKJ4i69L67ZVSd+a0rntd7ed+pxuFA1jPo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s1mXWQTLoqHRA2H8607oeSxDfc5NIkJd6/Ty6VCgW3mCOMPVVR1wcJ1UjqAfKQAW+HsFcL1XWbPyXmbtm6e2ywWfizBG46XYgZipntN1cZfNh9HUFIGyh/lAzSejTuRijr3gH2t0W+I1ie0fcFNpWwnm0G41cAUp9hA+Puc+EqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VdLfl56pXzvYJL;
	Mon, 13 May 2024 21:58:07 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E1FB18009C;
	Mon, 13 May 2024 22:01:34 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 22:01:33 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Aaron
 Tomlin <atomlin@atomlin.com>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao22@gmail.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v2 0/2] workqueue: Fix rescuer task's name truncated
Date: Mon, 13 May 2024 22:01:13 +0800
Message-ID: <20240513140115.3892827-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)

Task comm of task is limitted to 16, prefix "kworker/R-" is added for
rescuer worker's task, which cause most task name is truncated as
following:

root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]

I want to fix this issue by split rescuer name to 2 part like other
kworker, the normal part is "kworker/R" which is set to task_struct's comm,
another part is wq->name which is added to kworker's desc. These 2 parts
would be merged in wq_worker_comm().

The first patch fix the rescuer task's name truncated;
The second patch fix workqueue_struct's name truncated.

V2:
Add another patch to increased worker desc's length to 32 to fix compile
warning reported:
https://lore.kernel.org/oe-kbuild-all/202405131400.sEYZHYk2-lkp@intel.com/

Wenchao Hao (2):
  workqueue: Fix rescuer task's name truncated
  workqueue: Increase worker desc's length to 32

 include/linux/workqueue.h | 2 +-
 kernel/workqueue.c        | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.32.0


