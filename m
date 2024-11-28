Return-Path: <linux-kernel+bounces-424342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAA9DB33A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3F828214F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08B148FF0;
	Thu, 28 Nov 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eYIlcs7R"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086F146590
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779662; cv=none; b=uzD2dIBJkHqmbJMmiThWC62MesqvERJRufzPSf6XcNbYZoPodP4RB++j0WIjgy8JtsX2C2LuNJ7hJpg82WmESmTMflZVrDGxeu0h8op4D8KhyY25fBDxzYvS3Q0o1Z1mGBEgGTxsDGfpe79cMSQT4PwBEmhUoaRf0A3NHOE5x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779662; c=relaxed/simple;
	bh=7YSYlAef+/pzjy7kccts4JkWzj5g+IQasfwFXPdQXMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJrhwL8Mt8qC0hOp5BL4MoAc0dr3yN1hoOmrOtbXQAXx6bmyeMp4U24hgCwRR21Z1f8PLWRHm8xZi5kDDH3PjuoqNXYw3fgXQc8o609lrHITNAODWzIh/rKDanAGCYLQ6b0PX2Xooz7uxwrrwxZ3RB1ZzLxHnoV3BQh5beDwN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eYIlcs7R; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779657; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0V6hY79A/2+E7HEAAM4p9j6HrltNCMws+8O8dcahOFU=;
	b=eYIlcs7RWD17JIYC1eaHR4T6dRSLr5s1M4+5TP3RRus1/DlSLoksuCswGkJMO9a0sHx/x6hfhUpBLkqLiQVr2UycUzhVGT/Vz1z5cjRZIMHOrNdpQ1D+d24J3CJdVUCy8AYCy9w8SE+mBBi52+ARsoh8iDBoTkBkeoHqM5msCAs=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKOx1pU_1732779654 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:40:55 +0800
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
Subject: [PATCH v3 1/6] mm: factor out the order calculation into a new helper
Date: Thu, 28 Nov 2024 15:40:39 +0800
Message-Id: <5505f9ea50942820c1924d1803bfdd3a524e54f6.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
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
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
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


