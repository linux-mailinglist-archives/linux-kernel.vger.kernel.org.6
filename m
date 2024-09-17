Return-Path: <linux-kernel+bounces-331254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66D97AA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85624289E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50447C6E6;
	Tue, 17 Sep 2024 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABZbuAzd"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9355896
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539042; cv=none; b=k519P+qYaH6eNvd1xh+O1shA0yD4RbIyVfQIYDlExgQuz4dROSvE69HZDdAU6DvOf3SZze4DXqWQP30L0ToPZF1oGD4tR8e8dILukY1NyKzjlFoqRLxWdLqUGwBcUk64vWBjkrZ/XzAePgVh97Ddv2y8e+hMssWzHc+yhjj8wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539042; c=relaxed/simple;
	bh=zhr17HUYcfU86krIL8CZe49IVeJYIRYESXrjqhMNHgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPr3B7pjlS3dhISDAt4qkNkeHnALzKRYb6VFXmEyMhNcgw4V6qp1apQ8SSYe5s0CwM/zbraJie9oXSRTTuOz7PUmPzzwp6vLdmwrj92pDqJ5yCr+gbRoRFhqRQhqjvyNjWBQPbL0wQ6A6A8wchZZztx+LObQZHR2TQmGAJx1CFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ABZbuAzd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db4f323b12so1111951a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539040; x=1727143840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1LTK3ltYk3gaQ1Vi7PN62/nvHKdNc9jyl2jkjdvFYI=;
        b=ABZbuAzdFrtETETMaD+QqFaKP1jjBzbW3Pm6bxXPvHYFE/fU8aAu1MXOCvDY1r6SPX
         DO8lPNsbD9b7x5AcBKx8+Zc+SwHeu+V7P2++ECmNG6SSaLQT6q/wRRTqwut5UpIHFiag
         +GjpI8PgR15FfFrJbWcScb7/LOkYUjMb9+b2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539040; x=1727143840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1LTK3ltYk3gaQ1Vi7PN62/nvHKdNc9jyl2jkjdvFYI=;
        b=tA4yue3OjRpFgPB3OcP/GmqMFimx+RhKLQAYL8j3is+CicqeNFwLz/Wiq9eDvIPvwy
         m75vNgszERLizG4KFXPPWy1q7B6AA4TKry3ooYbVH+qYMTsHSHqH9fm/TZ9FF4Bkz+m0
         I67YSkRjOzZrB0DyqbOPrPOS1eRzJXXM1oehZFNkldDczeP0ng0qHHYImcPONlCtwaQa
         s94Ul5F4VOKFlIaBNHxf1QYwLdvwUZbjNOJsW/gov3aq1SrprN1OU8LqxzpRfZUDdl1Y
         dKB/tCAszI4upI46XYebI5NOtBik4Ll8/jZiGKhOZsF2AHJAnWtcy2Rg6QCEDnHuEQHk
         H5AA==
X-Gm-Message-State: AOJu0YzczFZelbMu0QAN3Z7IkWsTWhQJacCCRYOYNuCQTXabzHRz2Rpp
	LFzrLJInYdxLuJ4S7XMvWtM2IQNEmJXdzFr8jjKIH3H96WukMC0TaE0TAKhNkw==
X-Google-Smtp-Source: AGHT+IFAeK4YGCqZpKr44hbfcgl2ZrRa2/PgseZ1YlmEhrarbBcDYBGp0r3tbRSXffjQjZHwatcFkg==
X-Received: by 2002:a17:90a:2f64:b0:2d3:ce76:4af2 with SMTP id 98e67ed59e1d1-2db9ffee48amr19368053a91.18.1726539039904;
        Mon, 16 Sep 2024 19:10:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 5/7] zram: do not mark idle slots that cannot be idle
Date: Tue, 17 Sep 2024 11:09:10 +0900
Message-ID: <20240917021020.883356-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240917021020.883356-1-senozhatsky@chromium.org>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
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
2.46.0.662.g92d0881bb0-goog


