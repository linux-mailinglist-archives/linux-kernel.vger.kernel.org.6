Return-Path: <linux-kernel+bounces-282730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6D94E7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7AB1F23C90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A816726E;
	Mon, 12 Aug 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uJE1VEiW"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494C15C135
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448552; cv=none; b=m4lVSuhGDoMbRgs8VJmL/2l08GjrLc3DDmCBYd56ZxuNtyHkoEEKt5bnspxOVRlYLOBDdDKsw1Qjs7zMDRKo29rkSYmrnYLsODFQNvTJulWBedZH+r/KNOlCew3v3JVQvD3oM2AEqXw8KX4wCWYknI4qA9JPdeWefHiHspaANN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448552; c=relaxed/simple;
	bh=dSE5A1i/0Mslp7rR8GV63PP8IIVhz1+IlrL/SE1zme0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiFTor0d/Mr3eltB2oiBHoFTlGn6y1ik+GIBVH+JIjF5Pr2B9txvGoWeu6BBLvtjj9CshUAvDfhDt7Hvrx/CY1+cywJZ8KmstGffqoj4S9qEUyCUdSDgjFQR+2L+RjHcHjuv0SAAafxJ5hBGicXueuPDyOFHOueFM1mqp3e/kCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uJE1VEiW; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448542; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2cIcVzSoLVgPRYlybE3t8RKibMfrcxZj8JgqApi1OSo=;
	b=uJE1VEiWOPfMo9lqgitzw/Rv0cBMkRqrhdPbbiH+ks7VCoMITHmKKgGzpUK0PndssJsJbGpQNVWalpYTu3GN52Qnlr3XpGUhtbP1gHhMdwlkpFfe328GrLMmXsMrmQKbMgKIbVAbyTxpV4VfX9QlaOsTyeRuVYkmegBi6Isudw0=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCazOhr_1723448539)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Mon, 12 Aug 2024 15:42:03 +0800
Message-Id: <60b130b9fc3e422bb91293a172c2113c85e9233a.1723434324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support shmem large folio swapout in the following patches, using
xa_get_order() to get the order of the swap entry to calculate the swap
usage of shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 22cdc10f27ea..02fb188d627f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -890,7 +890,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
-			swapped++;
+			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.39.3


