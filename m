Return-Path: <linux-kernel+bounces-226624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C48914139
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5941F22C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46CDDDC;
	Mon, 24 Jun 2024 04:42:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB761CA64
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204168; cv=none; b=C7j/5hRdD73pAnH5nktJHYbAceZ+zf9KptGQ+l4lfZl64YAmi2aSnEbyPd1xgyAaXxpy9b/knjbO5FXf7X8s1xh+omFjw74fGhPabTJ0neNPLbSijAwt7GKAXs4hFG2sXgWjGlmmU1btZuT3/xTWeCyiHzA0/naQjFFLTcLArhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204168; c=relaxed/simple;
	bh=VO6rn1iRJpsezuy47uDlROc9yR1Lzf670tKqqbjH2JY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVfZn72a3mnIaMel9t0GlSBnaACpQw5jm72m8kZWgk9Hg42szVglYwt1JDJfRZ/Uf0MfdtWfqDRlJCYTUKvWI/Mv45LyJbw/QHXoUwfjTSToIq1+oZbO6OOPs6k6QD6i8lHDT1WGW/Syv2wzYpGjQ4iGl4XfNLnjJ52PcXAFCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b68c9dc31e411ef9305a59a3cc225df-20240624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:53c491e2-b8da-4ec8-862d-4f50d5d39a69,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:45
X-CID-INFO: VERSION:1.1.38,REQID:53c491e2-b8da-4ec8-862d-4f50d5d39a69,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:45
X-CID-META: VersionHash:82c5f88,CLOUDID:728743b82fceb780fd9822236738bdd0,BulkI
	D:24062412423347W5T7XY,BulkQuantity:0,Recheck:0,SF:19|43|74|66|25|72|102,T
	C:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2b68c9dc31e411ef9305a59a3cc225df-20240624
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lizhenneng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 923631648; Mon, 24 Jun 2024 12:42:32 +0800
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] migrate_pages: modify max number of pages to migrate in batch
Date: Mon, 24 Jun 2024 12:41:40 +0800
Message-Id: <20240624044140.117196-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We restrict the number of pages to be migrated to no more than
HPAGE_PMD_NR or NR_MAX_BATCHED_MIGRATION, but in fact, the
number of pages to be migrated may reach 2*HPAGE_PMD_NR-1 or 2
*NR_MAX_BATCHED_MIGRATION-1, it's not in inconsistent with the context.

Please refer to the patch: 42012e0436d4(migrate_pages: restrict number
of pages to migrate in batch)

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 781979567f64..7a4b37aac9e8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1961,7 +1961,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 			break;
 	}
 	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
-		list_cut_before(&folios, from, &folio2->lru);
+		list_cut_before(&folios, from, &folio->lru);
 	else
 		list_splice_init(from, &folios);
 	if (mode == MIGRATE_ASYNC)
-- 
2.25.1


