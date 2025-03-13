Return-Path: <linux-kernel+bounces-559406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A208EA5F37D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BECB3BA066
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56389266EE9;
	Thu, 13 Mar 2025 11:52:45 +0000 (UTC)
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF45266F01
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866764; cv=none; b=RdtfQbyeFHJjVfQ0Jrt9cDmj5Z+QexW4cIxfT/+4pmfCUNeEIRAwyzXpO+z2yG77s4MNqk+o7SQrh/vohh5eDLo94PGo2FChxjpu2fB62Rfvfr2ruU1DJWd8tbsz5zrLKKMal3rWFhoFWhHiacz8cMH6IkZm9c1NtIv9x4d0w8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866764; c=relaxed/simple;
	bh=jMfGEardadq5VhaxruCsipbVkj4VSamJ5hIDyKVyMiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzE73vZ3acLrYYChmo0j5wWSaaWHCzOragJauhhYc4sCtopY6V8MKLZtPEFfRQE45Xzrpvc+rrIu8cLEGajAfzP+C3KBev92qNWgtMJHjs1oESyKHzROG9SyALatAp1gbnwXyfWT3hkVs61RyOHEHoJC2SbGbe62E6hf5lpLBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 726901F95A;
	Thu, 13 Mar 2025 14:52:30 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 13 Mar 2025 14:52:28 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ZD5TR0Dl2z1h0Bc;
	Thu, 13 Mar 2025 14:52:26 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Minchan Kim <minchan@kernel.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] mm/zsmalloc: prevent integer overflow in obj_free
Date: Thu, 13 Mar 2025 14:51:45 +0300
Message-ID: <20250313115147.47418-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191738 [Mar 13 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/13 08:11:00 #27754998
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

The result of multiplication of class_size and f_objidx
may not fit unsigned integer. Add explicit casting to
unsigned long to prevent integer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bfd093f5e7f0 ("zsmalloc: use freeobj for index")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6d0e47f7ae33..96e0b04ff278 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1421,7 +1421,7 @@ static void obj_free(int class_size, unsigned long obj)
 
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
-	f_offset = offset_in_page(class_size * f_objidx);
+	f_offset = offset_in_page((unsigned long)class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
 
 	vaddr = kmap_local_zpdesc(f_zpdesc);
-- 
2.43.0


