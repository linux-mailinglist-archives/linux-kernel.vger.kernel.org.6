Return-Path: <linux-kernel+bounces-176881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2F8C368B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 14:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535312820F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5C20B33;
	Sun, 12 May 2024 12:42:40 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1A18054
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517759; cv=none; b=XWqEvfkbE4kzMfeBMkw60tp2oMWuMPSuYV7Jd530LS+lBhWQRDCQOBmDJAgQEsrkFx4V5NO6aA+me90450X3IFqu+hEve0KM6qKQ/mzhdaGwG+iFtFqBZ1KjWUUKtqCslcYOVujFNrNU4KVyEtH7fxWxtoOL2wcATUXFGAsNjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517759; c=relaxed/simple;
	bh=qqF2JEgZLqgXAyfl3PpmMOuAHzmp/Mg8MXHLhjsJg2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muGTfitYZNd/d9FWh7ObMWm71PAv48/T2mB8o0avKGV63LovbQxcmZ+GkyA/aWi1hRgoVh1ciOt4cxop9bf+L+5mGDMk7Wf4q2/u3kCneBsqySqcedBc+lNGXBDThEMSGmz54IshchqlDl9GR/GH1w7FbGCOE2Q8LwQV7W6Vyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:14399.1573931882
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.84 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id F35339BCE7;
	Sun, 12 May 2024 20:36:06 +0800 (CST)
X-189-SAVE-TO-SEND: chentt10@chinatelecom.cn
Received: from  ([36.111.64.84])
	by gateway-ssl-dep-7f596d7dc-5nwtg with ESMTP id d7e17b3c31254085a3111d9a6febed44 for akpm@linux-foundation.org;
	Sun, 12 May 2024 20:36:12 CST
X-Transaction-ID: d7e17b3c31254085a3111d9a6febed44
X-Real-From: chentt10@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: chentt10@chinatelecom.cn
From: Chen Taotao <chentt10@chinatelecom.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/rmap: optimize folio_move_anon_rmap()
Date: Sun, 12 May 2024 20:35:55 +0800
Message-Id: <20240512123555.8358-1-chentt10@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a folio belongs exclusively to one process after a COW event,
folio_move_anon_rmap() always moves the folio into the anon_vma
belongs only to this process.

However, if the folio already belongs to the anon_vma of the this
process, we don't need to move it again. In this case, we first
check if the folio already belongs to the anna_vma of the this
process, and only move it if it does not.

The above changes may improve the performance of vm faults in some
scenarios, because the performance loss caused by WRITE_ONCE() is
much more than the performance loss caused by add a judgment.

Signed-off-by: Chen Taotao <chentt10@chinatelecom.cn>
---
 mm/rmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 3746a5531018..5720cb78162d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1216,12 +1216,15 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!anon_vma, vma);
 
 	anon_vma += PAGE_MAPPING_ANON;
+
 	/*
-	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
-	 * simultaneously, so a concurrent reader (eg folio_referenced()'s
-	 * folio_test_anon()) will not see one without the other.
+	 * If anon_vma != folio->mapping ensure that anon_vma and the
+	 * PAGE_MAPPING_ANON bit are writtensimultaneously, so a concurrent
+	 * reader (eg folio_referenced()'s folio_test_anon()) will not see
+	 * one without the other.
 	 */
-	WRITE_ONCE(folio->mapping, anon_vma);
+	if (anon_vma != folio->mapping)
+		WRITE_ONCE(folio->mapping, anon_vma);
 }
 
 /**
-- 
2.27.0


