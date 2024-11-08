Return-Path: <linux-kernel+bounces-401041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F8B9C1550
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA991F23D91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814C1C3F06;
	Fri,  8 Nov 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BLT+bTHW"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10E13CF82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039210; cv=none; b=UaaacHrmOtIsQA935FTIzzR2Iekh/D6RoMpa/fLPXHAIMo1vdivaIfjD75krZ+PIzVZ9Y0ZpO5t94wxvojG5QaZ3fYN+n+9AGGy1bYP15yYZ7hB2E+Gqu0eupb3+4GHKom6lxateTTuBcN/qMgvyad/DtB8nGrqSK3W61aZZAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039210; c=relaxed/simple;
	bh=aW+mk2ePZEaHmiZzVO05BzffwyUJkOfhEC+jcUFwaoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzmeLenLbgd5rt0glus3IZs+3Pm+7XfLRPyyD2GsH/M3HPEHyvS86KLkFMPcQlkGB5z0kpD4R080RNZN0luJPUk8oDPBLzQDZIt4k08MYn1M5JoiFL5lukAg7nBj/0k3NMzg7yYDWAHsoscZjdSni0agYmHbo+g3yT5BevvpHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BLT+bTHW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731039205; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GjeDj7oC1iiZ/gkwEo4XJZE2Kubqr3JwCuLq6Y0HOAU=;
	b=BLT+bTHW3cS/tkPHBwAItgUH4HiKzcYqMyXkO2UGmTrI4NkzHvCenBhi0FMSRFY3kuT8WS4tORB+M+EGw6NKS3mI7t15HlziENqLRZvzzMZc23hYMpTHtrakOLXrEYRFzdOhl2GGY1lWExPYb2U5QQHsfTFW1HJ97nGYvf8bGVw=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIxXGhc_1731039203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 12:13:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: factor out the order calculation into a new helper
Date: Fri,  8 Nov 2024 12:12:55 +0800
Message-Id: <d3272b090b4f6fe92457d487c7b9f825ba72c1b5.1731038280.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the order calculation into a new helper, which can be reused
by shmem in the following patch.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/pagemap.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..d796c8a33647 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+static inline unsigned int filemap_get_order(size_t size)
+{
+	unsigned int shift = ilog2(size);
+
+	if (shift <= PAGE_SHIFT)
+		return 0;
+
+	return shift - PAGE_SHIFT;
+}
+
 /**
  * fgf_set_order - Encode a length in the fgf_t flags.
  * @size: The suggested size of the folio to create.
@@ -740,11 +750,11 @@ typedef unsigned int __bitwise fgf_t;
  */
 static inline fgf_t fgf_set_order(size_t size)
 {
-	unsigned int shift = ilog2(size);
+	unsigned int order = filemap_get_order(size);
 
-	if (shift <= PAGE_SHIFT)
+	if (!order)
 		return 0;
-	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+	return (__force fgf_t)(order << 26);
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-- 
2.39.3


