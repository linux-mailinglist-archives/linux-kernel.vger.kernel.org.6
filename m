Return-Path: <linux-kernel+bounces-207770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA9901BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D9282F40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48424225CE;
	Mon, 10 Jun 2024 07:26:10 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF181879
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004369; cv=none; b=Ta53/IM6Udh8iAL5GbQsZyTrKtJFd/bx+MRiaHUIQhDFkrYHSm1IyuwoYvbLAyM0yUhGpqAVX8btAJjG3DhZS0YvBuUKVDJZa9KB/nFM+8aNrnf0jkUmYu3CywfoJY28C+YcFgVQKlwkNwMZk1DGqP3zPZ/BXGRO9ifCRBpe/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004369; c=relaxed/simple;
	bh=Jb0GwGkDuhup0gVkAz4h+rf6cUfv4lbVSxuuUHUTECc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlOQ13EIolDQVkwGYTaV9LUSLgOo2bP00RqXY4uBCNHoxDDEkTFAiaT3W9l5fqTkBoxinZXpGYAmpsY5Oh2NnsPOC5K8fFfi1onD6UHurDnViZ+j3Hz1b9lSgUEwgpVikIZ2knOmDN27+CFUs1b6II6bjykHeBWRAnBLeLDB0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 10 Jun
 2024 10:25:45 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] udf: balloc: prevent integer overflow in udf_bitmap_free_blocks()
Date: Mon, 10 Jun 2024 10:25:22 +0300
Message-ID: <20240610072523.12002-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/10/2024 07:05:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 185825 [Jun 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2024 07:08:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2024 4:39:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

An overflow may occur if the function is called with the last
block and an offset greater than zero. It is necessary to add
a check to avoid this.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 fs/udf/balloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..cd83bbc7d890 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -151,6 +151,13 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	block = bloc->logicalBlockNum + offset +
 		(sizeof(struct spaceBitmapDesc) << 3);
 
+	if (block < offset + (sizeof(struct spaceBitmapDesc) << 3)) {
+		udf_debug("integer overflow: %u + %u + %zu",
+			  bloc->logicalBlockNum, offset,
+			  sizeof(struct spaceBitmapDesc) << 3);
+		goto error_return;
+	}
+
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
-- 
2.34.1


