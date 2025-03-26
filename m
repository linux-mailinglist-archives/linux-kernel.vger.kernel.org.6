Return-Path: <linux-kernel+bounces-576443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C7A70F50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7B1188DF81
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854A15ADB4;
	Wed, 26 Mar 2025 03:13:50 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3113C682
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958830; cv=none; b=PR46O3cSsMhaxyWPVZ9tbfvr2LnsDLi5Ol0IzRzPj1yGkY+agN4nBV9aRKC2wjuJFURYy5tuQkv6AbsNC5Q1d9j0tAcZDT91b6QwugO/VICq/IRv8cl8a49DDMHmwkktZTatJTfywMHGMtuY+lPR/zbWg1aMuyH41Fz/cL8/LlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958830; c=relaxed/simple;
	bh=70vbRTzit+6BL+xOUjpuD0cSQSVS4Z1KKdbALHxhdvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SC/YZf7HkJp0tc+02fivxOspLWd5H7FeqAb+9Ix9EnWCy1emFEL3AvNtDMT4lDa5jXQfo+78dguIjgO/P27l3gbfnrxka2YP6tNppYjA4PdXd1Uk2gxOPwxDsj/89MQrny/yL13uElOO4a8U/N1R/RL/aZgmBC2qZhgkfN8EEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201605.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503261112314780;
        Wed, 26 Mar 2025 11:12:31 +0800
Received: from localhost.localdomain (120.224.42.190) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 26 Mar 2025 11:12:31 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <akpm@linux-foundation.org>
CC: <mhiramat@kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, wangchuanguo <wangchuanguo@inspur.com>
Subject: [PATCH] mm: migrate: restore the nmask after successfully allocating on the  target node
Date: Wed, 26 Mar 2025 11:12:18 +0800
Message-ID: <20250326031218.487450-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025326111231d56feec8dbe32f716dcd6ffc18fa9dce
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

If memory is successfully allocated on the target node and the
function directly returns without value restore for nmask,
non-first migration operations in migrate_pages() by again label
may ignore the nmask settings, thereby allowing new memory
allocations for migration on any node.

Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
---
 mm/vmscan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..9467b2acef28 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1026,8 +1026,10 @@ struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
 	mtc->nmask = NULL;
 	mtc->gfp_mask |= __GFP_THISNODE;
 	dst = alloc_migration_target(src, (unsigned long)mtc);
-	if (dst)
+	if (dst) {
+		mtc->nmask = allowed_mask;
 		return dst;
+	}
 
 	mtc->gfp_mask &= ~__GFP_THISNODE;
 	mtc->nmask = allowed_mask;
-- 
2.39.3


