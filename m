Return-Path: <linux-kernel+bounces-403498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EF9C3684
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C995C1C20A48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4F481B3;
	Mon, 11 Nov 2024 02:26:08 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5431F931
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291968; cv=none; b=RYRKKJCqE9yITAWEyUtfMRh8PZgkCK+ekqCz/Nu6MvpgbZtFvymo8cFH0WcJD5mbZBDluieIcHA912HjxR8YQUTuFYhmelwQKQk7OKalj12AZYxoTWzYCuL+8BkqFpx+6yLZqTB6nfdB729Mpg04UOWh8KStKf4rLKJyZoXsi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291968; c=relaxed/simple;
	bh=QrJuPuDz6xNB0eOvjEyjCm0f1/SWI21InHD1cqNLq/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GuaJoNM7qCqq/f0a/4Goi1Utv0TTOaUjv8iVEt+UQaRQxgUwppE+0j2T3AxEwLxQ/DFQY2iERA3h8ZlUf4N0319nt/ms8d+zKP1QO0yl8B8PzgGQGgJhSGfq+lCFy73eX7gubQsxaola6IZkKLACbNoK2JAB0taMRhYlP4Dzn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.888087250
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 124659F5D4;
	Mon, 11 Nov 2024 10:19:33 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
	by gateway-ssl-dep-6977f57994-mvlbg with ESMTP id 2ea6ac7329234ca1b6bed43548054357 for akpm@linux-foundation.org;
	Mon, 11 Nov 2024 10:19:37 CST
X-Transaction-ID: 2ea6ac7329234ca1b6bed43548054357
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From: Qiang Liu <liuq131@chinatelecom.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuq131@chinatelecom.cn>
Subject: [PATCH] mm/compaction: fix the total_isolated in strict mode
Date: Sat,  2 Nov 2024 20:16:21 +0000
Message-Id: <20241102201621.95291-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the last cycle reads bogus compound_order() and blockpfn > end_pfn occurs,
it is possible that total_isolated will be less than nr_scanned. In this case,
strict mode should return 0, but the “if (strict && blockpfn < end_pfn)”
statement cannot recognize this situation

Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a2b16b08cbbf..6009f5d1021a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -699,7 +699,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	 * pages requested were isolated. If there were any failures, 0 is
 	 * returned and CMA will fail.
 	 */
-	if (strict && blockpfn < end_pfn)
+	if (strict && (blockpfn < end_pfn || total_isolated != nr_scanned))
 		total_isolated = 0;
 
 	cc->total_free_scanned += nr_scanned;
-- 
2.27.0


