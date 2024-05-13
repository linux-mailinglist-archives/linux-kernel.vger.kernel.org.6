Return-Path: <linux-kernel+bounces-177664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC928C42C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6351C22F93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40C153BC5;
	Mon, 13 May 2024 14:01:47 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B9153586
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608907; cv=none; b=VJ0yffESzTpwJ4pLvLMQRQBUwHbKkRvfqf6OwuwxwIvnpFJ1KTZuwRntJNO1qIat5EIbRApD7akpobEz8gl7Z1ycrW6+3IMNv3a2FFEVrf3duQDmv9fC2ozhdyaIbAJafLP+bgcMkCb4DrynpNIQARDGx/PdEFDFxoebJRiBY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608907; c=relaxed/simple;
	bh=1YcYToi5JryAKQRSRBtTOb92FRyQycH6cd6PbcD9ong=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsrrAPXV0Lnv3NfUkBipcPxjID5bdyBnkGLvH0hx6RGvwB2Jzk3yO18cVGLkZuzM8NdO/gqnkEWr7PU73WKm4qpMMgPmcjfoDOUluzJlEt0MRcyXSku/6y8yCphjMThOSXMwIL022taVn2A0OS/6RjNACjJUx/SR2HIiJtHkp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VdLgR1dffzPkNn;
	Mon, 13 May 2024 21:58:43 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 90CE01800B8;
	Mon, 13 May 2024 22:01:35 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 22:01:34 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Aaron
 Tomlin <atomlin@atomlin.com>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao22@gmail.com>, Wenchao Hao
	<haowenchao2@huawei.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] workqueue: Increase worker desc's length to 32
Date: Mon, 13 May 2024 22:01:15 +0800
Message-ID: <20240513140115.3892827-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240513140115.3892827-1-haowenchao2@huawei.com>
References: <20240513140115.3892827-1-haowenchao2@huawei.com>
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

Commit 31c89007285d ("workqueue.c: Increase workqueue name length")
increased WQ_NAME_LEN from 24 to 32, but forget to increase
WORKER_DESC_LEN, which would cause truncation when setting kworker's
desc from workqueue_struct's name, such as usage in process_one_work().

Fixes: 31c89007285d ("workqueue.c: Increase workqueue name length")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405131400.sEYZHYk2-lkp@intel.com/
Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..72031fa80414 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -92,7 +92,7 @@ enum wq_misc_consts {
 	WORK_BUSY_RUNNING	= 1 << 1,
 
 	/* maximum string length for set_worker_desc() */
-	WORKER_DESC_LEN		= 24,
+	WORKER_DESC_LEN		= 32,
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
-- 
2.32.0


