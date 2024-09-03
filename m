Return-Path: <linux-kernel+bounces-312779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EFE969B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C671F23ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240F1A0BFE;
	Tue,  3 Sep 2024 11:05:34 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873E11B12CE;
	Tue,  3 Sep 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361533; cv=none; b=bAdm0BpyXIoMCotWb2WxeNWZSk+ASJRI3E672/m3abbr7EXjncHE93X8Z5mTHpKC2AnmSY8UI5n2eT/4hY+RXm7xeK80xbNwXYd6Ywp9mWlSyLnhNSynBE/duGLFqmYjZzGEnKvYjZUF7A4UmIic0TPkYLg2bK5k01+ef3h2N18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361533; c=relaxed/simple;
	bh=/HrgOADb6OiA/YGSfLWC8PnWAlpI6HRsaA7qw7t5ywI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HoigeIyHcrxN2RnugP1LaIhmbcAQMut41WT0TofrJKDVOzXzALXTeWX6gLWDv7fJSCnCg+PSr42ON5/oG0YBbyKXHD+HrjR+sib7ofFHeOwdJSRXr5+5WXy5U720T36gxRDrCKbq6GanUgcPLP0Lmn4RA/I5Ia93o6KoWuVh7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766d6ed70d63-dcd69;
	Tue, 03 Sep 2024 19:05:21 +0800 (CST)
X-RM-TRANSID:2ee766d6ed70d63-dcd69
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d6ed70bf5-e10df;
	Tue, 03 Sep 2024 19:05:20 +0800 (CST)
X-RM-TRANSID:2eea66d6ed70bf5-e10df
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] perf namespaces: check newns before free
Date: Tue,  3 Sep 2024 17:12:08 +0800
Message-Id: <20240903091208.7152-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Since newns can be NULL, check it before free

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/perf/util/namespaces.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cb185c5659d6..49e20e0a567a 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -135,7 +135,8 @@ int nsinfo__init(struct nsinfo *nsi)
 			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
 
 out:
-	free(newns);
+	if (newns)
+		free(newns);
 	return rv;
 }
 
-- 
2.33.0




