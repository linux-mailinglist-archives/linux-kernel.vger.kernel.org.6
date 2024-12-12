Return-Path: <linux-kernel+bounces-442452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B19EDD03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64030283548
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974154F95;
	Thu, 12 Dec 2024 01:20:26 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2432C85
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966425; cv=none; b=UpwseiK1UfhofhZb4HRaLaHcLq/TaLzZxONOtnsLk5cnFRqXTbcOOcreRnh1+Q0+e16WiBoen0scw33/pW1UxcaaPgJjSM+AAPP+W1GuDmM2tshM1RitKOXtnZS0gVILcIaDvgOC9KMEHNb8k642d2Woodv1wr7oqkXLuO6qn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966425; c=relaxed/simple;
	bh=Ci7EZQO9kHYiX5WxBfEiOLQLfrqjq9Y5QgAw+/BRYKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QwhXhuh391BNnB/E5RB686pCQEiaCqcdxtCvHBvm3qGdPBBxOii+J3v4LUZ1VAFwLEOhYKd1261YIR8X06MZpsxQXQPvqID27/CvAbf/niXkY3X8Zza9y9JeHxjL5lM/fvc3sY7iwXznGh6fQmVtPVaO4l5p8ZOQkJZ3pUTv6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1675a3a4b958-dc27b;
	Thu, 12 Dec 2024 09:20:12 +0800 (CST)
X-RM-TRANSID:2ee1675a3a4b958-dc27b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2675a3a4b1fa-50747;
	Thu, 12 Dec 2024 09:20:11 +0800 (CST)
X-RM-TRANSID:2ee2675a3a4b1fa-50747
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] mm/x86: Redefine pgd_clear
Date: Thu, 12 Dec 2024 09:20:09 +0800
Message-Id: <20241212012009.2147-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Do not use the 'void' type in conditional expression.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 arch/x86/include/asm/pgtable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10aabd45..c149e47122b8 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -74,7 +74,10 @@ extern pmdval_t early_pmd_flags;
 
 #ifndef __PAGETABLE_P4D_FOLDED
 #define set_pgd(pgdp, pgd)		native_set_pgd(pgdp, pgd)
-#define pgd_clear(pgd)			(pgtable_l5_enabled() ? native_pgd_clear(pgd) : 0)
+#define pgd_clear(pgd) do {						\
+	if (pgtable_l5_enabled())					\
+		native_pgd_clear(pgd);			\
+} while (0)
 #endif
 
 #ifndef set_p4d
-- 
2.33.0




