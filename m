Return-Path: <linux-kernel+bounces-381235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA159AFC56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6C286F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D61A3A95;
	Fri, 25 Oct 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AMhUVuG9"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3B189914
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844116; cv=none; b=XjKM/edE5egKbc/bD9rja11x4V+ZaNJQ5ArjHYeTg+KiMvSoLPv6V6oiLT/1guldIWsa4CVnnyJXrzxFjnstsoDyFbt5zVK2eBiMhTXkp49l+7dFKs2i2+nTKnFiTaXsnCFdmP2Mr+gHUl19qaUjhbNhCZh83RwfSsxXrafIAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844116; c=relaxed/simple;
	bh=rCdIZUFBUepsxtg47L7aI0jPEy2MEsIoHAIcBwoOBII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hjTRZi1ygPygQu/8k6ySoCJ4lktXW3eJ3ZKEwqoPe8WvwIeLIqEy5O84Zb7WC5WzEDccdRQ6Dzp4pKJewH/Ph8TO6iObAHSaHgPkcWXxJLMQhowrJ3VbBJWjlZnyXtaSFDfcnAlcW7ut8MCRZ6ojFMTUqojWUHrrD76LExRZ134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AMhUVuG9; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729844104; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NnOa9BZeM/wEnWd4elRrQTQ+mMCnyLHDYwSylZaOzE4=;
	b=AMhUVuG90oXGuYcPT0hu3D1W1RKapogbQzWciN55IbbTHhjzfohLpr8OGOk9xE+ZMis85djAH6WNltv7S/z2gzsCLiWahxBV4wR2tK3IFyJFJniFPQ+3Oe31u8TZfv1iMArRMNGifCNibm8nl/AtyE0vTe62G1A/SMrXWj8PLT0=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WHrqv88_1729844097 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 16:15:03 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] locking/ww_mutex: use swap() in get_random_order()
Date: Fri, 25 Oct 2024 16:14:55 +0800
Message-Id: <20241025081455.55089-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./kernel/locking/test-ww_mutex.c:420:22-23: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11531
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 5d58b2c0ef98..bcb1b9fea588 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -404,7 +404,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -415,11 +415,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = prandom_u32_below(n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.32.0.3.g01195cf9f


