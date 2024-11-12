Return-Path: <linux-kernel+bounces-405325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41469C4FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BC6281BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FD20C31B;
	Tue, 12 Nov 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wYjKhkeq"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B41AB6DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397562; cv=none; b=T5OgaRY2TXTUibBEGzX5UgPlThEtJx5lRageYu+BbwC0zBlm2599ukNm4sy9aYtKHcFdBO193YvmjTBtvS9WhaT2RqTgMQ+cUm6IgHOxgRVhIF8ASuNBRu44sDE0e1O7n6o/Tc7qmUnWQK4BuBmPgK2PuigjuPit+JI4OOZVEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397562; c=relaxed/simple;
	bh=VCB0HQSqkQ/50UPtCxNi5c10rWwfbTyk4/8wNX7JF7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g48hgIt9nEkgTJJrLRciUSB9mz3ghG0CnwEFrH0UsPwBu8LVCs5+H8cHiitjuBms9lyg0+dWnFUU4fbDZZFY+g4GERhKmXBZVBRCUdK4LleVoqksvSN0oJIe5pcDqkmlVmlKIrUNb6FQBY66irIO/LJPaiBn5gOacKIOfv/GcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wYjKhkeq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731397557; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1SJuihJYAFsIthe48Yp7PlQqFbbRscF0mbHdHErE/Xs=;
	b=wYjKhkeq8/+I1kjCLIVs9e/KnVLWp+PFKid+1SqkOdru0vsvHQdI2XOSxJaf/rG3AjwVbw05Iq4LZfIIY2NAdZHt/U8Gn63pbKFwkHTtghmgATm7oPg/toqZX4w6JbwSgbd21mkiIJOxkVAs+rANKHyDzJDuA+0sTKzm92eQqWo=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGDWme_1731397555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 15:45:55 +0800
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
Subject: [PATCH v2 1/5] mm: factor out the order calculation into a new helper
Date: Tue, 12 Nov 2024 15:45:48 +0800
Message-Id: <582997bd09b17a292124ea47dabc2ea5642daade.1731397290.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
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
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


