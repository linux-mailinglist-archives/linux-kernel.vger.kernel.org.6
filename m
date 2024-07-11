Return-Path: <linux-kernel+bounces-249524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0492ECCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383C31C21A42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706216D326;
	Thu, 11 Jul 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUWnO56v"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A916CD1A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715554; cv=none; b=qc3M1n2x6O8koE9ir4KlLn3Ahe4nIgnH/2JYUSjliHbA7FcdUz8NKGjc8VAEru1ohrug6jZib5+mfTt0OExFv/ifyKKvPbIiv9j+OdEnqhC+y6P6HAiIH97hAwF0ONZ3YjbfoKnqNWOOy53MOM3oKJTYbF9PvQMCJhsevJ1wwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715554; c=relaxed/simple;
	bh=26qL51uoahcNHPT1l9WKbg1Ih95sXbEPmhFJ69O7LU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=amHs1QZZrtUH7pl+P068L4K5jUh/rsKKhyaGat2yTGI+ux5bKye9g2QhuTRIfQR8AaKVAHl63uPX0D4Bqi80EaeT056qIX56WFLeFtMVHHY6iC/YX99E+m4K9KTmMZUjaLpTjC5N5kV2RlhPI4MsJIFJYgkbwf+8Xz17Ld8rtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUWnO56v; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7611b6a617cso817693a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720715552; x=1721320352; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knRYc6x1wBrdcZgoYzGzvvoqSpAROkSsvaUc1PqkKTs=;
        b=MUWnO56vvkqvy6jey74x69ktE1P6zxAA+FcgWFog1+YT/RBZjOGTsCV/afzqwF1quJ
         rre4AVS/bi1RTXuONoxBp4GWvgj/5WAY2wFsm1gAwoJq+UI2m8F4zeZEatbQSkCn6lR9
         R+R1sPQdOhYOKcragRYb5yPyTjKlW9OV/Jhkruq8pSbNPmohMZnbGtE0+um5FX2d+M99
         av74pX+RgJol512RUHIU5EGtB4+5XPEggBRdHYCdDdNUGLy9dUHoL2dcQvAGuM/08nyd
         pR31d4wfmCmH+ElJ0UzN+TrsdOF8qxE1ueaFmPrSzBrAqXN/S7ffJZ27loBDEXSJk3fX
         W94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715552; x=1721320352;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knRYc6x1wBrdcZgoYzGzvvoqSpAROkSsvaUc1PqkKTs=;
        b=Ege4hbhQcDtU9NUz404nm/BiRMcrEWFn/+38HvHBz/C7Q851EqAC4UTlGKi320hp6Z
         ITcoXHMBGqYR6EXCnBC52cy9yfVSthCXbepHeiBOV3MSeR+ycUTP5hM67MMw7/3ZkyQs
         yeSMqeWg7TlTUoLwjkI3UXTsueJshg1JuDlTVlBgsBjj8d603vYhw1svaj158PPnjc5d
         qCKjxFAr81XGf5acdQF/OjqNONVfx3Wu2zeDzxozoAD803xVlELce/PJUFdilF8AKwYa
         cnsgXKWqQ2Ov0i/MRBy2Wpm4CHvb+z4I6B4jjWdi70RT0X9x/SqKxBEXL2bBJxMyOZYd
         8YNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaV7bBXyBGSeJRvYh9FY97yQhIvsmavHFNdu68lNMHi8Vn4THIjAvgnpsRw/CJaai4Fd9jvpE5qbfTVb151M0Eae44LhJk1JW/pLJS
X-Gm-Message-State: AOJu0YxQrsJ0jXXUT6kPWcWTw81chs+1YyOzit5aHWUCMCvX/iJCiC4g
	iZSxn7watQKVoL4FzQPnXq0lSqvYSo1tdERHyFeuVimLOJtfglOVcIC8pg==
X-Google-Smtp-Source: AGHT+IFu3WuoWkraVD3aRrqr4yqWat1WaGyvP6d5wxA4VielGLmxMh0DYuQBeX1wCHjB5GPgPyO0lg==
X-Received: by 2002:a17:90b:1090:b0:2c9:7e98:a4b8 with SMTP id 98e67ed59e1d1-2ca35c71f09mr6707140a91.24.1720715552086;
        Thu, 11 Jul 2024 09:32:32 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352bfeb9sm5826887a91.39.2024.07.11.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:32:31 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Thu, 11 Jul 2024 09:32:30 -0700
Subject: [PATCH] mm: Ignore data-race in __swap_writepage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-bug13-v1-1-cea2b8ae8d76@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB0JkGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0ND3aTSdENjXTNjk7Q0E0OLFEMzAyWg2oKi1LTMCrA50bG1tQB8N92
 xVwAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+da25887cc13da6bf3b8c@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720715551; l=2466;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=26qL51uoahcNHPT1l9WKbg1Ih95sXbEPmhFJ69O7LU0=;
 b=mqg3Pk5oOKGaaZAmXmQ6yjUdtca4/MspG+hW0X7NiQM7UtzPLAcZL8qPv13l7iGKmtN63j+dY
 Vu5oBst0sshAVUgF9pd4oT32V2irgSgxku0uFky7yP2AYfJAfqsRB9z
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

Syzbot reported a possible data race:

BUG: KCSAN: data-race in __swap_writepage / scan_swap_map_slots

read-write to 0xffff888102fca610 of 8 bytes by task 7106 on cpu 1.
read to 0xffff888102fca610 of 8 bytes by task 7080 on cpu 0.

While we are in __swap_writepage to read sis->flags, scan_swap_map_slots
is trying to update it with SWP_SCANNING.

value changed: 0x0000000000008083 -> 0x0000000000004083.

While this can be updated non-atomicially, this won't affect
SWP_SYNCHRONOUS_IO, so we consider this data-race safe.

This is possibly introduced by commit 3222d8c2a7f8 ("block: remove
->rw_page"), where this if branch is introduced.

Reported-by: syzbot+da25887cc13da6bf3b8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da25887cc13da6bf3b8c
Fixes: 3222d8c2a7f8 ("block: remove ->rw_page")
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
Syzbot reported a possible data race:

BUG: KCSAN: data-race in __swap_writepage / scan_swap_map_slots

read-write to 0xffff888102fca610 of 8 bytes by task 7106 on cpu 1.
read to 0xffff888102fca610 of 8 bytes by task 7080 on cpu 0.

While we are in __swap_writepage to read sis->flags, scan_swap_map_slots
is trying to update it with SWP_SCANNING.

value changed: 0x0000000000008083 -> 0x0000000000004083.

While this can be updated non-atomicially, this won't affect
SWP_SYNCHRONOUS_IO, so we consider this data-race safe.

This is possibly introduced by commit 3222d8c2a7f8 ("block: remove
->rw_page"), where this if branch is introduced.
---
 mm/page_io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 0a150c240bf4..15be678259a5 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -384,7 +384,12 @@ void __swap_writepage(struct folio *folio, struct writeback_control *wbc)
 	 */
 	if (data_race(sis->flags & SWP_FS_OPS))
 		swap_writepage_fs(folio, wbc);
-	else if (sis->flags & SWP_SYNCHRONOUS_IO)
+	/*
+	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
+	 * but that will never affect SWP_SYNCHRONOUS_IO, so the data_race
+	 * is safe.
+	 */
+	else if (data_race(sis->flags & SWP_SYNCHRONOUS_IO))
 		swap_writepage_bdev_sync(folio, wbc, sis);
 	else
 		swap_writepage_bdev_async(folio, wbc, sis);

---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240711-bug13-634ff418d160

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


