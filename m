Return-Path: <linux-kernel+bounces-235567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D291D6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FAF1F2307A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D529CE6;
	Mon,  1 Jul 2024 03:41:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6B182D2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805297; cv=none; b=HJTvBQ3vU1rl7OHkkuZylwAqkVhFfQNKmHdjTXN92myUPNb+15zbR01L9gqWJ6AB7kJ14CqAoFIR2ui5vIN0Ck5pHflvF8vSB9F4JMD9iX/vVW+vF568e5Z0AKxmzlwiv63y2ig54EHg3loMMa6ib6LrC/ngtLgATUwNSuz+5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805297; c=relaxed/simple;
	bh=y3WnovNNW3Z+2WUTkJVPMku/QUpINyrdhika/pXn5WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I73ZCEOp0D07C7o7q+FVNmpgvCALGIKF4eTNAs/eTN1DkvLUx+6y3nvt1f1xsvFFIAdc1RZ6bEMlF42L+VWP8Rs0ezxzop4JvxN88l5+0P9L1SojYPQsfWRjSCV2rk1noVa/VfzPaIQCoE43UBJCR1Fsy5KpvRs4RZkjT9f0TmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5b985cc375b11ef93f4611109254879-20240701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b4ced21e-6492-4fc9-aedd-e54a5c760c26,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-39
X-CID-INFO: VERSION:1.1.38,REQID:b4ced21e-6492-4fc9-aedd-e54a5c760c26,IP:0,URL
	:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-9,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-39
X-CID-META: VersionHash:82c5f88,CLOUDID:a7ca31e2781213daf043e2d3116a8573,BulkI
	D:24070111381932D88IRB,BulkQuantity:1,Recheck:0,SF:43|74|66|38|24|17|19|10
	2,TC:nil,Content:0,EDM:1,IP:1,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_IBB,
	TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: c5b985cc375b11ef93f4611109254879-20240701
X-User: zhaomengmeng@kylinos.cn
Received: from localhost.localdomain [(123.150.8.42)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 925970037; Mon, 01 Jul 2024 11:41:17 +0800
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
To: akpm@linux-foundation.org,
	yang@os.amperecomputing.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: gup: add forward declaration for try_grab_folio_fast
Date: Mon,  1 Jul 2024 11:40:52 +0800
Message-Id: <20240701034052.9988-1-zhaomengmeng@kylinos.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_grab_folio_fast() was used in gup_hugepte(), while itself was
defined after gup_hugepte(), so add a forward declaration to eliminate
the -Wimplicit-function-declaration warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407010039.D3sIu3fu-lkp@intel.com/
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 7439359d0b71..222b83a87d7d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -488,6 +488,9 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
+static struct folio *try_grab_folio_fast(struct page *page, int refs,
+					 unsigned int flags);
+
 /*
  * Returns 1 if succeeded, 0 if failed, -EMLINK if unshare needed.
  *
-- 
2.33.0


