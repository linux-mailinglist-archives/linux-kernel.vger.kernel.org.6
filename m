Return-Path: <linux-kernel+bounces-196559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C28D5E07
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BCF1F26049
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F998768EE;
	Fri, 31 May 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q9wU3dHf"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9C219E0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147023; cv=none; b=aHz1TkqSyLCOlI71OuSlqRe9xCNVwBpgIhUDLLTchK6PRR5PXfiiMBOZZq7CE3n8vNA0Og2FlEAHPlrDTUTx/Pnacw8xjnP0wcyicoIELAQtQceSRVpGiI1zrOsOYMnm/OyQ5TCVi+akh4dOFq+j1rXADNDhNuBdFAOAwIPXuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147023; c=relaxed/simple;
	bh=ga8xlJ50EjCZk3NCeaXWFZ1iuZTpf8TMYwOh7vCcsYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duoeZ4/bQ2fzIxwQt95wdvucTFFJE9cRu3ZtpR7ympzWQNZgXyu8pE8H+L8RXENpK5Fkb9m5HNALTxCZ3Y415WfXpp4ZYGNQAzsCOLCU3VnlyMP1izCQ6hkfOUgEPmOknpFVpwucVh4IzJMAkKBwz4wUc1geeYl7GDPNfzkO6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q9wU3dHf; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717147012; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QxHkEYftDlz/KeEpN4FX7pbniR6z89NxwWd3eLvuSoc=;
	b=Q9wU3dHf+tdA/dZt+i0IhlHCuem5FtuFhmITSD7+TojUK1PKjPFdV41QBTUNKzU8AHcXGRu2IOl/2Ohxs2kcFlR/oNyxwLT7eMyuxrDKLVYoSsAo5uY1V4H+Elv7+ccw/+lsMAoW//radMx4FiFlR12rUYBNiYt8S21Ge5qblIU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7ZLw8K_1717147005;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W7ZLw8K_1717147005)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 17:16:51 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm: userfaultfd: Use swap() in double_pt_lock()
Date: Fri, 31 May 2024 17:16:43 +0800
Message-Id: <20240531091643.67778-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

/mm/userfaultfd.c:1006:13-14: WARNING opportunity for swap()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9266
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/userfaultfd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index defa5109cc62..5e7f2801698a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -995,14 +995,8 @@ void double_pt_lock(spinlock_t *ptl1,
 	__acquires(ptl1)
 	__acquires(ptl2)
 {
-	spinlock_t *ptl_tmp;
-
-	if (ptl1 > ptl2) {
-		/* exchange ptl1 and ptl2 */
-		ptl_tmp = ptl1;
-		ptl1 = ptl2;
-		ptl2 = ptl_tmp;
-	}
+	if (ptl1 > ptl2)
+		swap(ptl1, ptl2);
 	/* lock in virtual address order to avoid lock inversion */
 	spin_lock(ptl1);
 	if (ptl1 != ptl2)
-- 
2.20.1.7.g153144c


