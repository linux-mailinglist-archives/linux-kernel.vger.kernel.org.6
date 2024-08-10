Return-Path: <linux-kernel+bounces-281770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB694DB19
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE96C1C21113
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269FA14A4F1;
	Sat, 10 Aug 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OgsJwxET"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC8182D8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723271512; cv=none; b=qyV7d0syTCO8xlFwyjpQQKL4on40wFdxZdSdQdTVprcjM97pq1EemsO7LqCLm+l3xkeNVYmiX9rWdtvrppiLVVBdveEIWKLAHcFxfdIZsRfUqKy0fQ4VWTaYXj+8nriS5n+2cuSXst/1WC+R+qdeW9SDVTt0bQf9DLPogTMCKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723271512; c=relaxed/simple;
	bh=44hefx8Mq5igjs+XonNUvlS1FT1Y2XNRHAyX2T7F860=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rFmPEsMmY7NeE5MZvgwtc9OLeg9xSlFm+wrZ92UE3JpmHrLYk2HBFeeh3oKoC8Qqq3bZa6ig/7/R1kQlQpxPYqF759EjrxNOyPDhneExzL7+jEHtIpxpa1olzxiqJh+bMXLFfuxg9KQdlcPRY3mWbHPIp9wC8mKd2sAD3DfJURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OgsJwxET; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=LIGLXSFjNXiP5pR+2/
	To2QWyASHDuTsautJcNOBg/+o=; b=OgsJwxETnr4hrNrtWZOUEs6O1nbmQKOuEU
	qhmyz/8lukp2YwFFLaITKX7m5NA98vIjr8k8q4dU5X4pZNk55yMfrJcnbX+OSKOs
	RilSt8l2RLkGH/jXfL8i7M9udsaAEQzFuCa0UW5bLiKDSzT/UVLnuYz1kg9V9I0J
	a2iSqKLfo=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnrzWiBbdmdazfAA--.16456S2;
	Sat, 10 Aug 2024 14:16:03 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/swap: take folio refcount after testing the LRU flag
Date: Sat, 10 Aug 2024 14:15:58 +0800
Message-Id: <1723270558-31674-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnrzWiBbdmdazfAA--.16456S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4UArWfWw4rWw47uw4DJwb_yoWkGrg_Kr
	48tas5Wayrtrn3KF1ft347Xr92va93Cr1j9F4xtF43Ary5t3Z7AF4kKF13uryxWF4rCrs5
	Z3yDAws8AwnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRi2Nt3UUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGAY3G2VLdFPbZgAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Whoever passes a folio to __folio_batch_add_and_move() must hold
a reference, otherwise something else would already be messed up.
If the folio is referenced, it will not be freed elsewhere, so we
can safely clear the folio's lru flag. As discussed with David
in [1], we should take the reference after testing the LRU flag,
not before.

Link: https://lore.kernel.org/lkml/d41865b4-d6fa-49ba-890a-921eefad27dd@redhat.com/ [1]
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/swap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 67a2467..6b83898 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -226,12 +226,10 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 {
 	unsigned long flags;
 
-	folio_get(folio);
-
-	if (on_lru && !folio_test_clear_lru(folio)) {
-		folio_put(folio);
+	if (on_lru && !folio_test_clear_lru(folio))
 		return;
-	}
+
+	folio_get(folio);
 
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-- 
2.7.4


