Return-Path: <linux-kernel+bounces-284540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B777E950224
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23DAB225E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD221802AB;
	Tue, 13 Aug 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="NiF98jKQ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D9E433B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543843; cv=none; b=n/Mda9d4BSrhAzq4JiGc5xJT4YD0Ly+kt2bOFesfIcXfNItIdqRdIodLJS9np1a8LFGTeLBifqNj83SF58BDCiCM/BJ6a54N48iAyN5f/iEoSEDOagrSJZH3AbM7DWNhxhi0XBgLxcAZ/wmThoyZQqolEo4ob8VVxCeK+hPcW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543843; c=relaxed/simple;
	bh=Fm8/euYCfWWqgzcvP+2t87/Xho9IV+3e5yXpJvIVYtk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LpHgcC1PxlbOxi9Mck17/SfGOXiXmH2UH8mpoVNtmDsZPGUa4Bi6jO2A2NJ3TAIfvt93/9Ys6RuzVKe0rxbs/TghTBlJnr5zhXO2Y6/Wrrc1Vrvi0aGsCk/7EB5wBWCQ0lh4TjuVjGS8zJsgfC/cJGh7HAb78tnUd8CL/kLUd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=NiF98jKQ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ceKwBoKd8RVMvMUYur
	+j2OhO2faLi4b/XH1H8WSU8E0=; b=NiF98jKQMaecPZhVLOEYG/Dy32TH9s8OLi
	cf+I0LzwwumfUiUHYsx2psycghMKhGppxqAWxYYwe4Vu4JbNLcC3v7JdcBLmq1PW
	rYXLgEh9MzIFzYHKowXxs+po1qZSXWtYBLhjIykbpOBBEk7L1dcO6TEySsoum56/
	wRSV5rpVQ=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnT3XaLLtmUKKJAQ--.43172S2;
	Tue, 13 Aug 2024 17:52:28 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	yuzhao@google.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH V3] mm/swap: take folio refcount after testing the LRU flag
Date: Tue, 13 Aug 2024 17:52:23 +0800
Message-Id: <1723542743-32179-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnT3XaLLtmUKKJAQ--.43172S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw4UArWfWw4rWw47uw4DJwb_yoW8Jry8pa
	18GwnIgrZ3Gw1jva47Zw13AryYkayI9F4UAayfCwnruF15JwnFkF1fKw4UZay5CryxWF48
	uFy5tF1kZ3ZFvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58n5UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhM5G2VEyJ36hAADsC
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/swap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

V3:
   Remove sanity check suggested by Yu
V2:
   Add sanity check suggested by David

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


