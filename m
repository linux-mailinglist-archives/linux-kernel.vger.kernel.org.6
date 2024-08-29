Return-Path: <linux-kernel+bounces-306500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A97B963FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD1E2874AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0F18CC19;
	Thu, 29 Aug 2024 09:21:55 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD636189F37
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923314; cv=none; b=HTFs4Qmv1E9tL3sSE+OEJKV4lASeUj5YuzYeloIb1Jtov/ZxddwQmaSTdBFm7dd//ZVq+ScHkdhyENXmW+J62Knw04y8Ks4MWN0qMbTZXxiRCU16Kr2otfftJCTJQ8urFHnlGJjkbWnegZRuWbSH4v1VnFNDzxkQ2stu18df3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923314; c=relaxed/simple;
	bh=uk/sN2oD5Xg9EyWhsSB3shw+FdMfEN/0V6yjCpD/qwY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VGUpe7WY0AqrKp4KZke7QCmxBXODuAUg/xFi99WJvKbSkjGT5t4HqGck6FEgGXx2NQ60L6kb7555YFtLAu8uGBRX7N0DRTkZ97o/DZfUn8Tzlsp+gBJaX6XftpRSIfKYjqCrsYoQG14JDB7hKYGy/pI/2slzpFLnMAeyVQoLO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d03daaf1f-8581e;
	Thu, 29 Aug 2024 17:21:46 +0800 (CST)
X-RM-TRANSID:2ee166d03daaf1f-8581e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d03daab3b-9c796;
	Thu, 29 Aug 2024 17:21:46 +0800 (CST)
X-RM-TRANSID:2ee366d03daab3b-9c796
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] tools/mm: Use calloc and check the memory allocation failure
Date: Thu, 29 Aug 2024 02:21:44 -0700
Message-Id: <20240829092144.5851-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Replace malloc with calloc and add null pointer check
in case of allocation failure.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
v1->v2:
	modify commit message and delete fprintf line

 tools/mm/page_owner_sort.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index e1f264444342..8c78265cef67 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -368,9 +368,10 @@ static __u64 get_ts_nsec(char *buf)
 
 static char *get_comm(char *buf)
 {
-	char *comm_str = malloc(TASK_COMM_LEN);
+	char *comm_str = calloc(TASK_COMM_LEN, sizeof(char));
 
-	memset(comm_str, 0, TASK_COMM_LEN);
+	if (!comm_str)
+		return NULL;
 
 	search_pattern(&comm_pattern, comm_str, buf);
 	errno = 0;
-- 
2.17.1




