Return-Path: <linux-kernel+bounces-318518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D796EF18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC8E1F243D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057F1C8FBC;
	Fri,  6 Sep 2024 09:25:05 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EBE1C7B9B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614705; cv=none; b=DhRKVZA2Ofd6zrWIquONvDX2wySKO8u9VabNJ/KOZYBmiaad1QT6tOHoyPaPbtksxo8iFMByKzOCKHvhmqlKKUehK8+nWwP2hOV238xI+gqK9E+zzMt6EVni5Q19xZIFE4TVewaMdRfsmSC1ZNmmYcKyMj0PtyMlyMKtIwXXKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614705; c=relaxed/simple;
	bh=Aqcrtx0P9a8SB9pGyM4IIOJ9Osi4d17R+7VbCAR0tjM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZjslEV0qFt3EZmnsqZKz2YBwkrSETe+TAnHr45U6/+lK9OrrFCqZqFgym3JI0DmWpyx28IdqvWnapYe9NzluxmOauffla5z2kjhgnpdnmW+KnpKCyydv+eDYkk8d3ut7/asdypw49PbxX06nMieO7B0fMvSWVLtUy3xfuTUsV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766daca68d6a-f7d70;
	Fri, 06 Sep 2024 17:24:59 +0800 (CST)
X-RM-TRANSID:2ee766daca68d6a-f7d70
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566daca6ae10-a2d31;
	Fri, 06 Sep 2024 17:24:59 +0800 (CST)
X-RM-TRANSID:2ee566daca6ae10-a2d31
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] tools/mm: Use calloc and check the memory allocation failure
Date: Fri,  6 Sep 2024 02:24:57 -0700
Message-Id: <20240906092457.11581-1-zhujun2@cmss.chinamobile.com>
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




