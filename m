Return-Path: <linux-kernel+bounces-180823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F718C7397
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785EA1C22967
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69058143743;
	Thu, 16 May 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N5vEn36G"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183682576F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851053; cv=none; b=lRs9fWTsLqalU/xVSI1bloy/W0XhMUG8dICLbgvws9gVvHd4HJcZr3Ye5yf6YsQ66Z1Pih9kWpor83RgGY1sM0b/ifiZfgFmiGSMln66FpCZnbZkAT3lxhXzoxn8sEIhkXKGNAtCpvH33Sapu/idFHxnZtTttPaG6DCCqFDkomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851053; c=relaxed/simple;
	bh=ZadexFFezC3w9+jlqieXCACzwn6JSoQIVLbDQKIm/g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMEfvBeYZAUhGnoHYwL4xJZRLD7cjZzY3byjT0zDBmFk7OUldU6pXcygmc68FPosM/DO9lsXROQZ/GyPQwZnjG8uhRUpU174/g9+vlJ1oTxqBk2cv0GF0lVMPSPVK6CZfpEZztc0o0l5x485sXf5+OpW6hfz27cLR6YRPotLr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N5vEn36G; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715851048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JE4ANZQwE+LW47rs3NXLBhGDGN9Arjfv7ogeqT4+iU=;
	b=N5vEn36GlKUMXfEFhLxYmSLhiJ5sNAFUYZpNcga0tulb+2RCQZJ0wf3bNNQAxUkGhTtVeE
	jDP0ROS9MdNnejnkjno2qknnYtavFvNGmrEOswmM0mxCgGTRrFEPBurLBTn5AmLFZinxcw
	dVzQCaKmbRu0XWc9P2y9zSw1j/kGaPg=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/cma: get nid from physical address
Date: Thu, 16 May 2024 17:17:01 +0800
Message-Id: <20240516091701.1527002-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The nid passed to cma_declare_contiguous_nid() may be NUMA_NO_NODE,
which is not the actual nid. To get the correct nid, we can get the nid
from physical address.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..be6cdde32944 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -361,6 +361,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		kmemleak_ignore_phys(addr);
 		base = addr;
 	}
+	nid = early_pfn_to_nid(PHYS_PFN(base));
 
 	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
 	if (ret)
-- 
2.25.1


