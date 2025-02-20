Return-Path: <linux-kernel+bounces-524109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13EDA3DF54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B8B19C12AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C341FF1DC;
	Thu, 20 Feb 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgxsNBVg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D31FE474
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066553; cv=none; b=CGZOuy/xoZE5MmGi83FnBasfySDVWH1ipDJUUoulLWGgH5LjOOunOlN6o/K/e3wiFXpiukPQqSKTfnPGhk2X4Nlos4bYr2Z00arKGibhFr7sCy9MaufEjJ9SR0PCF3W9CnQ3cLem54BoImAthdrkpCQCVSCerUk9hiDYU/vhkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066553; c=relaxed/simple;
	bh=/wiSrjZFtuQCsjLxyKvkfrNWy3c2K3OtosjgT5ti0q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9qtsBqeiHd6gCyVntZCntcZ7lzVpI9mB3tijwOFjGp0BhttfT4GHU6A5vO3pUewr5nJ92DaEYkNOkOM7qNTF6MpdHr+v3gkPaMHuyhHwvALjjg3PNXdYHtIV9g0oAouYtg/bT0xW3K7BqJlvCpDtoNzGw++O+sGn095bt0TRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgxsNBVg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so1849249a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066550; x=1740671350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2E2MTvAYQWg7krEfkXP1hDGVQ7vMKcc+OhnV3fQUlZU=;
        b=jgxsNBVgkimY5fOpOqWxzmZ2yshdArNLXzx2Hy5ds56fQqm0S46ZCeKuxhSiaWS6PI
         izlgHYGl66kAn3Gb3J1eb06xVEdQmsxN8ziTd3cYF9U+S8tO6mt4mcWQwsvaahsbKgbp
         wN1FuExN/Ksoodegw0Z6MoDfsmn1/292PdUiH0ZSWo4aixLTeN+e3SGeldjhKSmXkEK+
         KsLpT9G0jXp2uNEA0ndmBLmSBNp6/JeGOJAJ3ZE8wdJBL7HOBZJwZKwV1p3sciu6x/EI
         4uzAB+fYj+jwR44lO8i7DtSYHaSDdBCCCeV0x1plINBE+NpMXelIfCcRkStObFfc42gi
         RRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066550; x=1740671350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2E2MTvAYQWg7krEfkXP1hDGVQ7vMKcc+OhnV3fQUlZU=;
        b=BFFBUk5SLpn9SXHir8qihAcxKTGSem8/lPce1/YmqYijqi/hoQYQf5Bv+wMzN03OC6
         b+5kocfZV5rXzLRr//Wwinoohp69TT85Xg6YNmlfdTWl8Nj4qIC/vg/jR52iNTK1AfVP
         aKs/eSm5jJkrCOyl2OSRc6C0RGOK41rSSxqZtPtf3S22bEKT41Hw/xlbgldnsEOPG2iG
         ANBJVhsx1IPMb1Z+jChhWnXl/EhPTWjTuzuqE5Ha0TKVV/GzEFX2joBFDMlrsdqqe10o
         Mfml+N9Ey29sGcGgp/Ha4L4smd9BV1+CNLRLWfrTkAAZHCyomAayIc4tzrOyoPJBobno
         VQBQ==
X-Gm-Message-State: AOJu0YztaK18PXxgOAWLqQDbA6id7uxzMAj8QkQ0WCdtK+1+tS2JMT5i
	Ta3wtwhyFN5Q/CjqJolYbH6hJOb1RChV5BHKdwTbA3kam2GIMIoJumdV0w==
X-Gm-Gg: ASbGncvIha57+z8amJZmnCbZXmWU2gv9/btfX6+bUVpXnFcd2ob+OgbhGtC2DBaSzu1
	6UJOyNInovQNhGjEQzryyFhjQePYw/BirphS7o/wQrl7/DrJYWtPcB8bSD7rtrjqiqmXeYPKNy2
	pJ/lENKix3sM5/+Sqtj275Lii0AWgVCD3OXQ64GDVwYHE7z/2T7UFTJg4tx4HxtbtWk5HDtWyiG
	RoCMVV8ILnM2B8sXsN2NQrXrHFvW233ZhRLM2d4zfSiPGctO8wYvyWZ8ZT+oA9L/HbWZIKA4Vwi
	lHgX19RYaR/ccNwk4DK+242vvHBFY68RXwwMDp4afwwD2CbAsNP8RGywcm10QTaV81dd5p/PYbt
	HQOGx4t4=
X-Google-Smtp-Source: AGHT+IFyTr4GZkLCpTuA2k65GDMtmNGCygaMOCQt011avMeIOZw1OH1WNoTpr4HlNT9cp+z23E6Uww==
X-Received: by 2002:a17:90b:2644:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2fcb59e5914mr12072369a91.1.1740066550186;
        Thu, 20 Feb 2025 07:49:10 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:d4e3:981c:2900:970e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13aafa44sm14044962a91.5.2025.02.20.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:49:09 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: do not use granularity control for segment or section unit discard
Date: Thu, 20 Feb 2025 07:49:04 -0800
Message-ID: <20250220154904.2698964-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

When we support segment or section unit discard, we should only focus on
how actively we submit discard commands for only one type of size, such
as segment or section. In this case, we don't have to manage smaller
sized discards.

Reported-by: Yohan Joung <yohan.joung@sk.com>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c282e8a0a2ec..4316ff7aa0d1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1661,12 +1661,20 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 			break;
 
-		if (i + 1 < dpolicy->granularity)
-			break;
+		/*
+		 * Do not granularity control for segment or section
+		 * unit discard, since we have only one type of discard length.
+		 */
+		if (f2fs_block_unit_discard(sbi)) {
+			if (i + 1 < dpolicy->granularity)
+				break;
 
-		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered) {
-			__issue_discard_cmd_orderly(sbi, dpolicy, &issued);
-			return issued;
+			if (i + 1 < dcc->max_ordered_discard &&
+					dpolicy->ordered) {
+				__issue_discard_cmd_orderly(sbi, dpolicy,
+						&issued);
+				return issued;
+			}
 		}
 
 		pend_list = &dcc->pend_list[i];
@@ -1701,6 +1709,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 
 		if (issued >= dpolicy->max_requests || io_interrupted)
 			break;
+
+		/*
+		 * We only use the largest discard unit for segment or
+		 * section unit discard.
+		 */
+		if (!f2fs_block_unit_discard(sbi))
+			break;
 	}
 
 	if (dpolicy->type == DPOLICY_UMOUNT && issued) {
@@ -2320,10 +2335,6 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
-		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);
 
 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.48.1.601.g30ceb7b040-goog


