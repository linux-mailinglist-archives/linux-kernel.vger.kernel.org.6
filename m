Return-Path: <linux-kernel+bounces-283014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DC94EBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D2282738
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D34176FA5;
	Mon, 12 Aug 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hBt59s0Q"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FF178374
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462759; cv=none; b=D194WuxoXpHEHmvyhhyHVQgUZR1phx7IDxH+EOUoTSh/GTmBw5b+L0VdHjdEzwQPTRtY1RoMBXylN+Ldn1OImZ4vqZmup/ZQyxqYpsDfEumegbxzYYgbhM3iGeaZyVVYLRazXG34Ge4DKtWmDwYCGio9EHldlbevH8hqMMiHSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462759; c=relaxed/simple;
	bh=DVrEkYxMT1Oi+emR1OnzP7j9iK/Z2/UTvAK+h8e4PMY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tdy97merLmVKaj1PDTxGumTA4I5UYajP204GpquGbouHaqWBEMpC809AqxhgDt+jD1L6csmpAzGQYtckDY1qhRiV6XsocDE4Jjsnyp//ctbaC9DPX40MCDnLMUqZH091CZ258eeo02q4ZFGAv6X4cq4oPTWeDp9NHoHBNIeMt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hBt59s0Q; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/KCDaGayguIyv7wyA6
	Oo5OBqacUsg/QIQhHO9iUM0eg=; b=hBt59s0QQNCyGROplKSQSIbNNY2EjvKuaH
	DENQoX1DAx9Q0SrXGSiu5t9dA1+sJYl/8Xs27e/zQt8pgQ2Hi/G78AN29IUc6wOJ
	XosZKsJfYK6UvUEF7Id3nzj+i2m9zBvaxCGkvTc1Oi8YcwibvQhIoanlLF0l5apB
	H1UlGb/KU=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnF3pY8LlmoNaoAQ--.25519S2;
	Mon, 12 Aug 2024 19:22:02 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH V2] mm/swap: take folio refcount after testing the LRU flag
Date: Mon, 12 Aug 2024 19:21:58 +0800
Message-Id: <1723461718-5503-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnF3pY8LlmoNaoAQ--.25519S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw4UArWfWw4rWw47uw4DJwb_yoW8JrW8pw
	48GwnIgrZ7Gw1jy3W7Zwn8A34jkFWI9r48AFWfCr17uF15J3ZFkF1xtw4jvay5uryxWF18
	ZFZ5tF1kXF1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRkhLnUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhQ5G2VEyJkENQABsM
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
 mm/swap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

V2:
   Add sanity check suggested by David

diff --git a/mm/swap.c b/mm/swap.c
index 67a2467..c048659 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -226,12 +226,11 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
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
+	VM_WARN_ON_ONCE(!folio_ref_count(folio));
+	folio_get(folio);
 
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-- 
2.7.4


