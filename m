Return-Path: <linux-kernel+bounces-408807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F319C83B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C94F2847E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A3F1F76B8;
	Thu, 14 Nov 2024 07:07:10 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A71EE018
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568030; cv=none; b=aOZCxMTrbarbx4xe9cvQZ1tRiZtpqP4Io5dvS10LhsNo+JyfjScXRhfm7mCxh3s+QBQKDSkgpa5+XYoFZB3U1yRoz5/G9Phr16f5ESIiUS0KTovERfK3W7h6rhq/ByZRFENZ+tQDrI9xe1hNOm9OCpv6Jl0XhnISNx4tck++L7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568030; c=relaxed/simple;
	bh=ESrCvpea853I8B6ZTdRbTsRPr6kBJdJr5LPOoid2TeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rhfZORoLgLIwG19/wRWcuucpzZhAmR4KEY0ExO/r8DFaWPec/JAN36YXHKQrAooCaO1XzuNdinmISFycmKlbCa80esJR64Qk3cRADnzHm+8sTP8f3qSrqEwzQoeXbg/6zMom4nzxtMFhKGf3+Q4x30JwBiPi4WCShvb03VHMVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.184899675
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 04725A04D;
	Thu, 14 Nov 2024 14:57:24 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
	by gateway-ssl-dep-6977f57994-b9pvf with ESMTP id af35d07d8d6244b58a90bd5fd21cc166 for baolin.wang@linux.alibaba.com;
	Thu, 14 Nov 2024 14:57:28 CST
X-Transaction-ID: af35d07d8d6244b58a90bd5fd21cc166
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From: Qiang Liu <liuq131@chinatelecom.cn>
To: baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuq131@chinatelecom.cn>
Subject: [PATCH v2] mm/compaction: remove unnecessary detection code.
Date: Thu, 14 Nov 2024 14:57:20 +0800
Message-Id: <20241114065720.3665-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is impossible for the situation where blockpfn > end_pfn to arise,
The if statement here is not only unnecessary, but may also lead to
a misunderstanding that blockpfn > end_pfn could potentially happen.
so these unnecessary checking code should be removed.

Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
---
 mm/compaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a2b16b08cbbf..baeda7132252 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (locked)
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
-	/*
-	 * Be careful to not go outside of the pageblock.
-	 */
-	if (unlikely(blockpfn > end_pfn))
-		blockpfn = end_pfn;
-
 	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
 					nr_scanned, total_isolated);
 
-- 
2.27.0


