Return-Path: <linux-kernel+bounces-424347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF49DB340
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8008E167425
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741471534FB;
	Thu, 28 Nov 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uuBPly21"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282714883C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779670; cv=none; b=NhJ0hszQA1l6d02cXHSFV3Vg14mpqg0G7wDec13zn2PKun7hfcqODLlMCoeV9KdTNT3filkjDaOGjckUT7mztLRpP8oK91YRSQGqqZUy7Mk+/pWZqhmE4ILASNQxKEZ+e6wdRkDaZEt2qLhqblHiYxIjJYPPxo/KtJY5u1E42ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779670; c=relaxed/simple;
	bh=v2kFLgwbojy4t5dVmznn+tFKB5cqQaY5cspI40Y81Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2jiDxoEjf0VvPwODuWKv8j6L5nidwoI7fjiGUADdfoj2lLhE+xXnGUE3v9C4nmMce7QGnsAY2j0tYtso5+IcmArlylNfwxGGVCwmbC4M0Vyoecq9E6DIaNjl/dRXqAlP553ZQ8fLeaY4fXN4+nHzS/f1aMxiZ2VfScXR2nAZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uuBPly21; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779661; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YBH1XlSLL2miO3wN2ZfU4NokzBeaXtPrx3UOtdhUk6w=;
	b=uuBPly21pPYYP7xtWE1UxIwL1xTTUgLxsyPohUeGpj3L3JqaNSv9k0+vxu1akBx72qzhoZQJaLhYo0jdsTIzq5gUU2Xoc0yZmB3SdSCHDUxqtePppy4moqRmUggj0cKuWGju0J2EkqTp2Bd/fF0L6weiyNnWtzIZWOsd2Ot/6lI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKOunGS_1732779659 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:41:00 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] docs: tmpfs: drop 'fadvise()' from the documentation
Date: Thu, 28 Nov 2024 15:40:44 +0800
Message-Id: <3a10bb49832f6d9827dc2c76aec0bf43a892876b.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop 'fadvise()' from the doc, since fadvise() has no HUGEPAGE advise
currently.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index ba6edff728ed..333958ef0d5f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -382,10 +382,10 @@ never
 
 within_size
     Only allocate huge page if it will be fully within i_size.
-    Also respect fadvise()/madvise() hints;
+    Also respect madvise() hints;
 
 advise
-    Only allocate huge pages if requested with fadvise()/madvise();
+    Only allocate huge pages if requested with madvise();
 
 Remember, that the kernel may use huge pages of all available sizes, and
 that no fine control as for the internal tmpfs mount is available.
@@ -438,10 +438,10 @@ never
 
 within_size
     Only allocate <size> huge page if it will be fully within i_size.
-    Also respect fadvise()/madvise() hints;
+    Also respect madvise() hints;
 
 advise
-    Only allocate <size> huge pages if requested with fadvise()/madvise();
+    Only allocate <size> huge pages if requested with madvise();
 
 Need of application restart
 ===========================
-- 
2.39.3


