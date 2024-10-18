Return-Path: <linux-kernel+bounces-371348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2689A39E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B6D1F268B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC051E570F;
	Fri, 18 Oct 2024 09:23:36 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B615666D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243415; cv=none; b=RihSRnoySFaz9HNvKQYlbirm8wKJCCXzhbmN1ldTpYZbuvNnqmhhy7btA5GLLtl10oJRHhEu9NWR1D63GAhkeojTxaDjMMgxpKh9p9bc6/FeKid3hGDwOYmR8z0gorDMZ10jT52VtuWc9yHea0/8BUl2I/HDRjPD0bTQFeyIMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243415; c=relaxed/simple;
	bh=rITi4fZfWn4ZLkNq3OpKgBDejqUodmYeIPt7kZz/KqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOfgK7eOTkdAUdMjaGo9zLUOvm8mIdTrtOddtuquWooKOMjGvdOnA9NvCQn5qAfz2v609Ts35ue6xb2sFO6fyMxuzlbiB2fO/cLnq5YwK3q0AoDvKyS6mtIpvRaMzvQgnX9/CiQT1kWNbIQ9OfpKQbQbbEeswfA0tghPwLcMz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiloview.com; spf=pass smtp.mailfrom=kiloview.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiloview.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kiloview.com
X-QQ-mid: bizesmtpsz11t1729243358tlgl0f
X-QQ-Originating-IP: ioRXDddZbMOXfGalJPOREc2DCfuCqIe19gos57pGRoI=
Received: from kiloview.. ( [113.240.218.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 17:22:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10716753238939013540
From: Luoxi Li <kaixa@kiloview.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Luoxi Li <kaixa@kiloview.com>
Subject: [PATCH] mm: Remove unused has_isolate_pageblock
Date: Fri, 18 Oct 2024 17:22:35 +0800
Message-Id: <20241018092235.2764859-1-kaixa@kiloview.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:kiloview.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: N7h1OCCDntujfT+Fe22ySOgRaoaZQOX+cj5x7DtBx6CAtwTQ3zrgR8to
	TUNYVdWD+zi6uflB0JyJhQNTFIxnwrotzGaZZ+VeuGSPW6a7Gq2RzjBjvzxVKUEWBzGUOQg
	9rfFXPURaoWOjbbZQfllq5fH4cYn8n/unpSFeBUA7gpYxlAD1XQUdvNJbaM3EtW2zu0ZJvj
	pbqORW0o2nrhzF0sTy+gAkCQVxx+LmMIS5Q86NYjiCJbo4tB+DFNsubVwc5Nf2Q8aPiRBUx
	Xvki5tk3WjKHhiOx4oFLTLEBxCy3nF6q0aJmLoRq1s+Sfw59cDVdbf6Prm6Wqn6nYWNTCdp
	g67k93uOjRpzKQ3rhCdnNjv6vx0zGyMnD0T4Nz+JNLN2eRQ3SHHP25JCC1LKeKsKJtzeCED
	WOHT+EkwXS/St6V0GSEGZA83fAKA8bx9ra/nC0t+zw1BZIOacej07YLKWvfVyC4IlivJoUe
	wO5vikzXQmbb4ortT346bwxLvVewawjyEsvZEb6NP2bkHZQRzg6WrHrsgrL1lqpqZnHyOyG
	8r0bRSchR+cASzwEpVRw3k0kgvVTrytSfFIgotfaWAEqH5kY4yJyYMVXHnLenB9S1pr2Lpe
	fbbA95KjNpGybDiRXeUirMOV+YYbn+H+zSC5p+HPZrmJrkKTsT6T4bl+4M3jI37/5hB/ZQO
	ysXCGiR8Bn6XDXcAwzyUkEiJT58WxLraaSrVyb8xvb4njMp2RUjY53vhuP9TdI2G4A1AzPW
	27qSEOUnHaekQquuMr8+E5heaVf0ybL4wEz40jerWHIbVzcacLkF1tZb9Hzu7zHCQuIHPqw
	JFf30zztBiOAZef3mRkwSDlrKg8QVfYP18JFU6p0aib7d9Jm1gtRtQjeV302+ZPo8+8TAiq
	5Ntj/INzGjCq3vjUr//v6gdmwVIGi3ys/C8abQYYVz2mbpNn7fdZp9FjW7CdNcdVWflOvMY
	Aw6oU4Gx0QaezOdmPmhyMSWzPjadoGPT8lTJHojGdC0zs+4wLm6AaJ1JWyy8gY5FLkJSxNn
	DXI8oaow==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

has_isolate_pageblock() has been unused since commit 55612e80e722
("mm: page_alloc: close migratetype race between freeing and stealing")

Remove it.

Signed-off-by: Luoxi Li <kaixa@kiloview.com>
---
 include/linux/page-isolation.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index c16db0067090..73dc2c1841ec 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -3,10 +3,6 @@
 #define __LINUX_PAGEISOLATION_H
 
 #ifdef CONFIG_MEMORY_ISOLATION
-static inline bool has_isolate_pageblock(struct zone *zone)
-{
-	return zone->nr_isolate_pageblock;
-}
 static inline bool is_migrate_isolate_page(struct page *page)
 {
 	return get_pageblock_migratetype(page) == MIGRATE_ISOLATE;
@@ -16,10 +12,6 @@ static inline bool is_migrate_isolate(int migratetype)
 	return migratetype == MIGRATE_ISOLATE;
 }
 #else
-static inline bool has_isolate_pageblock(struct zone *zone)
-{
-	return false;
-}
 static inline bool is_migrate_isolate_page(struct page *page)
 {
 	return false;
-- 
2.34.1


