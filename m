Return-Path: <linux-kernel+bounces-298563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7095C8DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7DA1C21B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75374149E05;
	Fri, 23 Aug 2024 09:10:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E97F486
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404235; cv=none; b=UGNizjtv2wsWAKgp/5NZ0QWHIVCPi8QEfLRZ6yqHEB7vf6hsuUDV1BkFIc3TqzPeqgGZLPIzwiEZyMkJWNQ/VtU1BmnuT8ex76p5Vo8e0WKMN1I7HdQ018snReWAGm6MMojpUZI7Mz/8p9r/u0s0e4AFLUWwNodN4e6CsG+EtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404235; c=relaxed/simple;
	bh=verS6Q6ybnhk3Ow9LlHSviHyjL0VdMQaHKsEKUEhUTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etbcyc4BAlM8bA9FZHAIxzj+IGaTzNk0++p7cW1UQxuIaZgaFm83b8ceXB2wvVn3sSKdksVamfFqRj3w0A1CBYD2SVzC1nMDStY+63Sn5xbdMCgwxBZNqQHfHswGat8XnLSKlLcrmH3fjWdgevKQpqVHpozay6GXh0lkwNeuUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqvPS1TSPzhYBK;
	Fri, 23 Aug 2024 17:08:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AE4EF14011F;
	Fri, 23 Aug 2024 17:10:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 17:10:29 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] kernel/trace: Replace printk and WARN_ON by WARN
Date: Fri, 23 Aug 2024 17:18:03 +0800
Message-ID: <20240823091803.2953933-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use WARN instead of printk + WARN_ON as reported from coccinelle:
  SUGGESTION: printk + WARN_ON can be just WARN
Let's fix it and simplify the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 833e7d654325..5f385c55499f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2138,9 +2138,7 @@ static int run_tracer_selftest(struct tracer *type)
 	/* the test is responsible for resetting too */
 	tr->current_trace = saved_tracer;
 	if (ret) {
-		printk(KERN_CONT "FAILED!\n");
-		/* Add the warning after printing 'FAILED' */
-		WARN_ON(1);
+		WARN(1, "FAILED!\n");
 		return -1;
 	}
 	/* Only reset on passing, to avoid touching corrupted buffers */
-- 
2.34.1


