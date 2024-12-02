Return-Path: <linux-kernel+bounces-426956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04409DFA8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77160162CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FCD1D5CF9;
	Mon,  2 Dec 2024 06:00:16 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F470810
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733119216; cv=none; b=PiHkWtluD8qlR0qi9aF1hk0jMBytnAlnxv9El8qzTY4tUkbvHK8qpc5nRHRZlS5fPklku7J4Uv82KGVZ07mpL+sHRNwEuGgEveOJvee63Na0r6SKQfrD6R9ZHGIaO1I5vhLmbopIyeWZkoUaPmVgOf7ZVM6s5FXRS3N1jMFu9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733119216; c=relaxed/simple;
	bh=biTsgyQatqlY3TCbCqwTzn9DkF2IHYJZezzNswg4+ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnwOAcx+9W1M0Sj/3+9hkBTA+wXAWpnYDV5AVcMLFe545kmkrbia9cHVXeniDcgh20T2FpMhyRpXsn2/DULhnyi6H0To5eRIdYS2WNziiSl1cEhFDIzuVlD9IYrix5WPwmNichaHLB7VjrjCINmG2QUsege/yg/8y6cc2GrsZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9674d4ce41db-bb1f2;
	Mon, 02 Dec 2024 14:00:04 +0800 (CST)
X-RM-TRANSID:2ee9674d4ce41db-bb1f2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5674d4ce3ed0-da589;
	Mon, 02 Dec 2024 14:00:04 +0800 (CST)
X-RM-TRANSID:2ee5674d4ce3ed0-da589
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jpoimboe@kernel.org
Cc: peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] kbuild: Fix the wrong format specifier
Date: Mon,  2 Dec 2024 12:11:26 +0800
Message-Id: <20241202041126.3563-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The format specifier of "unsigned long" in printf()
should be "%lu", not "%ld".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4ce176ad411f..9c36bb519cf3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4934,10 +4934,10 @@ int check(struct objtool_file *file)
 		disas_warned_funcs(file);
 
 	if (opts.stats) {
-		printf("nr_insns_visited: %ld\n", nr_insns_visited);
-		printf("nr_cfi: %ld\n", nr_cfi);
-		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
-		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+		printf("nr_insns_visited: %lu\n", nr_insns_visited);
+		printf("nr_cfi: %lu\n", nr_cfi);
+		printf("nr_cfi_reused: %lu\n", nr_cfi_reused);
+		printf("nr_cfi_cache: %lu\n", nr_cfi_cache);
 	}
 
 out:
-- 
2.33.0




