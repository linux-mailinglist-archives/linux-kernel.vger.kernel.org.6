Return-Path: <linux-kernel+bounces-341410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73969987FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C121C22F68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264017ADE7;
	Fri, 27 Sep 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uh/0mpnG"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE817BB25
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423148; cv=none; b=Kp+DJ3DgZ5nTt3UrDV0VEDphj7OARURNiDsKNc3njqcF1MhZtTqRi0T+2gt36A/DLf0JH4iz12fUknArKHJ/Y5hX8JWwFw1ub0NLfzNxqfcy9acoKSGtQASGUKJw23mPcHGVdLTW20A+ozouBsJR7FSgx0eT+eihkG7eZIp0AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423148; c=relaxed/simple;
	bh=30VL0B6J658aAI1BZFx4ueBxAI+EoTmJNVz+c6irajo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EbSi3crBTitsIQNRXXjunIXex9men//n/iGgB3U6/HrkFVkGTfBO91QuwppG9yd/62WdCAMG0/fjWlh7HCGMrTLmvQzuy7XCC54Ap/7HTt5Bk1akcVhvkd8eZDjGDQdL95H9JMS+iVZ7/2ruzLE8RFZ4OdQYxsiKu0lE8gRcSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uh/0mpnG; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727423143; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+uKA/3Anne8NzqGyUdHub419eOd1luCIHOLfaDwabwo=;
	b=uh/0mpnGYqWVqTPEIsMWzv6/fiq/gFZit9bJAUtKNDpiNcoZw2+P8zgzyr9Fgjm8MFP49A3PBCEiBXoPq/jtJK9omM40ubWwsaaIuU6st4gMEO2ooLINetbOeC7HPHgGJNh16kiafBh021HX584KvNDHY9qZNqSm3Vw1k1hggJI=
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0WFq-3Ro_1727423142)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 15:45:42 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] device-dax: Correct pgoff align in dax_set_mapping()
Date: Fri, 27 Sep 2024 15:45:09 +0800
Message-ID: <23c02a03e8d666fef11bbe13e85c69c8b4ca0624.1727421694.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pgoff should be aligned using ALIGN_DOWN() instead of ALIGN(). Otherwise,
vmf->address not aligned to fault_size will be aligned to the next
alignment, that can result in memory failure getting the wrong address.

Fixes: b9b5777f09be ("device-dax: use ALIGN() for determining pgoff")
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
Tested-by: JianXiong Zhao <zhaojianxiong.zjx@alibaba-inc.com>
---
 drivers/dax/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 9c1a729cd77e..6d74e62bbee0 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -86,7 +86,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 		nr_pages = 1;
 
 	pgoff = linear_page_index(vmf->vma,
-			ALIGN(vmf->address, fault_size));
+			ALIGN_DOWN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
-- 
2.43.0


