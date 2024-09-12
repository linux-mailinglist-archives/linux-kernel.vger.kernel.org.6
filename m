Return-Path: <linux-kernel+bounces-326069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D597621B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC221F23E51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B518F2CB;
	Thu, 12 Sep 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqXcIgSZ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E718E047
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124677; cv=none; b=O728whVRsm9V8N+ppZ8+3KtrCcpFajNldx3P4J8Y5W7lza9BpUzUBsNTkdpadZA+Y3JbgouKrubcKc/XtxV6TBn9DpHQWWhDG5QJxZP5PwZfezB9W2mIXuqivFA8GA6EOesAigaSKJuOJ9p2OPzBBebKspFttpPqqOd5YBPNw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124677; c=relaxed/simple;
	bh=I+kuo6MDSFh1Bhzr51TroqFkgroBeul0T3itlQe+qCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIt0I0/68Pe0HoNu22B8+cvtzb4MKYiAaPFJfQH/DPaWjBHU6LM5ESh/2JC+jzloMvutKl+UDjdk2nxFEPGpaleePzJKds41hZybOGBYDFH1tdxsXTBDrdQ7zr8Yp/lbsd5nzLE9JAwgECeI8GJ6jmcMSNrnwAR53AAI/2kEWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqXcIgSZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso405593b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124676; x=1726729476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GFCqjG6t4HanjxEsiLCHQQ2pA5kAkIPxQoDQLNprJM=;
        b=RqXcIgSZxPOonklYNgILlIqCEcolsR4UebiC07cbEnKY3U7M0i9+uqvuhOcV0zJWN2
         wKTPiGdJ8X1pCz+6lXJznap1UEftOVKiRW3KlT2pLouw2VqQ/iTrzbZd+T7wqyjlWOSd
         ryoW9EJi184JTqeMhi8e5aA9S/FurEpsuz/UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124676; x=1726729476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GFCqjG6t4HanjxEsiLCHQQ2pA5kAkIPxQoDQLNprJM=;
        b=woU2vIn2kiO6kbtueDzu6vK/giqfkyymCWR1L/8IMDFIKu9OkCd+gg1kNogcO5MrBr
         UCOFBx+uvlJFPV6WWMzNHeJTI5lpFkS/2BbVEAHTGTQmXYk1Y4/jMSl5MBmc8rotYSOH
         GCcWHP1hj6t0izWjjYcQbww6ZX8ykHbmzr+QaKJ6ISqGKV5fC3pT1VaOvU7V28ryvl1R
         u+zdO0tkoTSOUk796Ezkx6gsJPY6eOI3NdGiBDBJy+0h+7upRiZ9pX3ABBWGBQSKoFzA
         3+w7V0q/0KeRLmiEHXDMH/srzIvc8zFQsx/MBJL50LAFesfAw9jDiHFjPHCpyF+V+DDs
         7b8w==
X-Gm-Message-State: AOJu0YxneiFsDoWXe+keDtor+wo0lJ4yvTQ85swrxFbls0zCALLRwuZx
	tTDV4S+M/ppzEC2wiQYUB2DOrj/2ipU9zPYhearx/vK/ix3J2TIAp9tDTl4BR3phJsNUU2sdZLG
	9Og==
X-Google-Smtp-Source: AGHT+IEaKcYVQXn74aOSr6pjLq105JrvxJyT1w4oVchYDkTP4Fh4o5Pz/q6SBVXlcd94V2F5VeDrbQ==
X-Received: by 2002:a05:6300:404c:b0:1cf:4491:b6b7 with SMTP id adf61e73a8af0-1cf75e79c7amr2271175637.3.1726124675929;
        Thu, 12 Sep 2024 00:04:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 5/6] zram: do not mark idle slots that cannot be idle
Date: Thu, 12 Sep 2024 16:02:20 +0900
Message-ID: <20240912070413.4179924-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912070413.4179924-1-senozhatsky@chromium.org>
References: <20240912070413.4179924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZRAM_SAME slots cannot be post-processed (writeback or
recompress) so do not mark them ZRAM_IDLE.  Same with
ZRAM_WB slots, they cannot be ZRAM_IDLE because they
are not in zsmalloc pool anymore.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8ba994a5f30e..e48e2deec685 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -392,17 +392,28 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 		/*
 		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
 		 * See the comment in writeback_store.
+		 *
+		 * Also do not mark ZRAM_SAME slots as ZRAM_IDLE, because no
+		 * post-processing (recompress, writeback) happens to the
+		 * ZRAM_SAME slot.
+		 *
+		 * And ZRAM_WB slots simply cannot be ZRAM_IDLE.
 		 */
 		zram_slot_lock(zram, index);
-		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+		if (!zram_allocated(zram, index) ||
+		    zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME)) {
+			zram_slot_unlock(zram, index);
+			continue;
+		}
+
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-			is_idle = !cutoff || ktime_after(cutoff,
-							 zram->table[index].ac_time);
+		is_idle = !cutoff ||
+			ktime_after(cutoff, zram->table[index].ac_time);
 #endif
-			if (is_idle)
-				zram_set_flag(zram, index, ZRAM_IDLE);
-		}
+		if (is_idle)
+			zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 }
-- 
2.46.0.598.g6f2099f65c-goog


