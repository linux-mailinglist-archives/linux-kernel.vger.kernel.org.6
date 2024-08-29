Return-Path: <linux-kernel+bounces-306168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3867963A23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312541C20EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DA171E70;
	Thu, 29 Aug 2024 05:56:32 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBB166F11
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910991; cv=none; b=PXTXaaOWSnaApPOENYCo6o2pNy+5cRGZm52YT5OmdQbRJIx7PNK8bWIG0N5f3yDIgrcgXf7XU+xnKMWrjNo6ANipHTUxJCDh6uATMKA73ghrtLCjJ4LWra6BeTTG8+GkruRWixoDEs7LEghz8Ow0Nbxls5xypHDOgQs3Efkqj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910991; c=relaxed/simple;
	bh=MFg+ITjK7BXdRP6IrxNH4jBB6eGK0jmaSr5cqf/2EZM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q7m9S0VX7ES+e28Z0gIZieuvEKnaGYSFCqDYke/3Cd4+LzNR8lDPfDd0OExtYICB1u5NbhmxqHQhGYs1YV4IbKidnQveee88Zw3YZouDQK60l5Wrb3hrOb0JUEC2Kr5P9Orhj+NLEiJneuOcJgEM+yb9Pl5WfApN1z/G5+J8wso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766d00d85eef-b2ef3;
	Thu, 29 Aug 2024 13:56:24 +0800 (CST)
X-RM-TRANSID:2ee766d00d85eef-b2ef3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d00d86c6c-914a4;
	Thu, 29 Aug 2024 13:56:24 +0800 (CST)
X-RM-TRANSID:2ee766d00d86c6c-914a4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] tools/mm: Use calloc and check the potential memory allocation failure
Date: Wed, 28 Aug 2024 22:56:21 -0700
Message-Id: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Replace malloc with calloc and add memory allocating check
of comm_str before used.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/mm/page_owner_sort.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index e1f264444342..4e2329831810 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -368,9 +368,12 @@ static __u64 get_ts_nsec(char *buf)
 
 static char *get_comm(char *buf)
 {
-	char *comm_str = malloc(TASK_COMM_LEN);
+	char *comm_str = calloc(TASK_COMM_LEN, sizeof(char));
 
-	memset(comm_str, 0, TASK_COMM_LEN);
+	if (!comm_str) {
+		fprintf(stderr, "Out of memory\n");
+		return NULL;
+	}
 
 	search_pattern(&comm_pattern, comm_str, buf);
 	errno = 0;
-- 
2.17.1




