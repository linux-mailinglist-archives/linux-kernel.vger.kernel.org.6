Return-Path: <linux-kernel+bounces-576119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BEA70B29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550AD19A0E97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA31265CD5;
	Tue, 25 Mar 2025 20:07:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98A266B45
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933272; cv=none; b=puDhl5r1VO0JFX0VrEeL7NT3T2/de0yIjZhnJi+NpwaYRSISXTjI/XX5xixRxFD8Rqr2riDPrfTVSQz8mjOw5pF+6dBKfh4y1wA8zuBVLwu/bg2WbUlSXBm9txVJ2ZBqZqcKJbkBDXVvdElK/TeggpyRfDmpkXG3xSS8WdADpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933272; c=relaxed/simple;
	bh=p1AaJqjpxD88lQPGM+UmThHulkdUHE4v6doWlWgXbHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ql5ButIfJ93gInxdfRZ2tuTP6a5nAO8HNDwie3ffYp5e7i06LUPFJq+7s/1j+CQQheiGIUy45DKE2E1u+Ydcn9Xg4yeBe1VzLiD5jEi7DiY+0tN5pgn7Qv6EhGDVian99rgp6y0s/2a+j7XKTKbyvnXHhfySgU7TWfBRp4ZABRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1txAYp-0006v1-AK; Tue, 25 Mar 2025 21:07:43 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jens.wiklander@linaro.org,
	sumit.garg@kernel.org,
	vbabka@suse.cz,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tee: shm: fix slab page refcounting
Date: Tue, 25 Mar 2025 21:07:39 +0100
Message-Id: <20250325200740.3645331-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Skip manipulating the refcount in case of slab pages according commit
b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").

Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- Make use of page variable
v1:
- https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch@pengutronix.de/

 drivers/tee/tee_shm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..35f0ac359b12 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 {
 	size_t n;
 
-	for (n = 0; n < page_count; n++)
-		put_page(pages[n]);
+	for (n = 0; n < page_count; n++) {
+		struct page *page = pages[n];
+
+		if (!PageSlab(page))
+			put_page(page);
+	}
 }
 
 static void shm_get_kernel_pages(struct page **pages, size_t page_count)
 {
 	size_t n;
 
-	for (n = 0; n < page_count; n++)
-		get_page(pages[n]);
+	for (n = 0; n < page_count; n++) {
+		struct page *page = pages[n];
+
+		if (!PageSlab(page))
+			get_page(page);
+	}
 }
 
 static void release_registered_pages(struct tee_shm *shm)
-- 
2.39.5


