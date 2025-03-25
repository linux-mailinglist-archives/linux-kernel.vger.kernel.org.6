Return-Path: <linux-kernel+bounces-576084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E87A70ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531723AF739
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436BA1F3D54;
	Tue, 25 Mar 2025 19:50:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561EC1CAA9C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932249; cv=none; b=Vjc5KGKisImTjU+Amtl8jAOEBbeauF8ze8/OtsXQjiMlTMAu1SaGTSbWnFOZTNHQV6a+Wk2ULNjGGe07Rf9vb8ulIRDn2p5DOC4xcnW7M+HdhZzERMqDVZgUaKzjDe4OC34f5MTYDM2+D1Rs59cmsu8Wvt/jpPzaVtkeDnKcgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932249; c=relaxed/simple;
	bh=APVdAU4tGhcU1S/UpfZmpYMsOYvPyiM6B+PqHMA5fJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ol8t+dr9+1rnQ7aunFiDfLWKMGaLmxKKrmEYjXD3gYDP6kF7m7p5FjWCyTLLDHF6sY/HWJ4ZYo36RvtBlF7g6vhRmx8nNxqwws40PlQcBQEve3rO5Yx+c5DU44ILAgPnEWW5rDXtbwpApnDj1s8V3xkqAu/UChkouLMwwZdnG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1txAIF-0004Iw-U8; Tue, 25 Mar 2025 20:50:35 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jens.wiklander@linaro.org,
	sumit.garg@kernel.org,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	willy@infradead.org
Cc: kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tee: shm: fix slab page refcounting
Date: Tue, 25 Mar 2025 20:50:20 +0100
Message-Id: <20250325195021.3589797-1-m.felsch@pengutronix.de>
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
 drivers/tee/tee_shm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..3d6a3077b6f2 100644
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
+			put_page(pages[n]);
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
+			get_page(pages[n]);
+	}
 }
 
 static void release_registered_pages(struct tee_shm *shm)
-- 
2.39.5


