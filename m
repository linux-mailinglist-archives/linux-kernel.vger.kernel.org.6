Return-Path: <linux-kernel+bounces-325905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDB975FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCBB21A47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2C126C16;
	Thu, 12 Sep 2024 03:25:15 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADC126BF6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111514; cv=none; b=lyNocQDuO2L0CdovxVBSR27kkLoDhRk19ZOvwvawv8Y3SEQLwCu92RCR14YmQ16pmvLPRHQDxQibYCdL+mtVPKv7/GDcKvTr8BdwwlplBIvDKuhcMhrm9Ta/Rcyep0eHdf0AR80YEq0w7CZChBmiNMEtxKLsDh2MLYtugW5c0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111514; c=relaxed/simple;
	bh=Aqcrtx0P9a8SB9pGyM4IIOJ9Osi4d17R+7VbCAR0tjM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZM3NjdfCsuPdoFUJBOLgs7Z4zf4qHATccDZbpSj3mpDy+0OloAhRUvgcXJVpjGf65Bju6pSu+DpKT4pv2WEHdnJI7VzTDYYpgL12l+tsKd3gOxptYyzu51QxLV74k9NRALtyVFnTR0XmikioJy5xvYmezQNCbCB4yBuZV78G5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966e25f0a437-2a43b;
	Thu, 12 Sep 2024 11:25:01 +0800 (CST)
X-RM-TRANSID:2ee966e25f0a437-2a43b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166e25f0ceb5-fcb7b;
	Thu, 12 Sep 2024 11:25:01 +0800 (CST)
X-RM-TRANSID:2ee166e25f0ceb5-fcb7b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] tools/mm: Use calloc and check the memory allocation failure
Date: Wed, 11 Sep 2024 20:24:57 -0700
Message-Id: <20240912032457.2780-1-zhujun2@cmss.chinamobile.com>
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




