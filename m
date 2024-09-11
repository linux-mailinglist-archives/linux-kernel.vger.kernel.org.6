Return-Path: <linux-kernel+bounces-324399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C1974C01
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6FA1C217CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A56558BB;
	Wed, 11 Sep 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2AHZcme"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C814D449
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041713; cv=none; b=oedXRaDpcm2puYtL05TIIUlt+qYeASFLJsoM1TK8ry7gGmIzD3I1qWXjYkh6bybvJx45gKtP1pgx6SEbI/Dx+fzcakmSJUlVrY5Df8XUam/7zj9lzcSzCbHE12du2xu+AXEQWRxosg9DfpP6c51y4PwFy/v1lBlFnVI4lQ0tXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041713; c=relaxed/simple;
	bh=GpbrAqihpqrGMi6LxZW46ippumBmrcz5UgvWIdCU938=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIpLtpLI4/f1DNEpPgo7duErXRhWA2NvGR1eDwQwsviIFqjNl0ZuERCi6/cn7b8Q2Qvul0B8k3uu83jn7Plhw7bwUG0FGeJZzELe2W1vYDaNJymlZDodhYtLcXSLflt2K2Bk49Mqc9DHyLwXrLkF9egi0zPmnIIUOEKWGMFtJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2AHZcme; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20551e2f1f8so64719425ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041711; x=1726646511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaaLSaGPvJKGOCkhBt8xB5aM+xySGaG4M/bL3WuizSU=;
        b=S2AHZcme0hZMjg0UL+X3eed+uffkX12rm2iz5Nt24rPqdSJjoR4eXX1uV5DlCVn13l
         /zYnXU3GTcldtdeKCIfKzy2uvPmcfRpJvFYJVQ8HOvOXCaGMUWxVQ1mNhcHWXYFp7FoS
         KPVDpnSay+k/s1dODCDK+9wZEcz3wACvzE9rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041711; x=1726646511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaaLSaGPvJKGOCkhBt8xB5aM+xySGaG4M/bL3WuizSU=;
        b=CuMlIpO9HSc7YVHJnsZbVLH2eaPGKGZRFT7AT99Ily4eTG5jFQj7rMhLXVcjpH+pah
         EF4UtenQ8h8Suv8RN+lYkCwwLFgwShIY83wWlI22Vmd6cKV+dk3aDF+oGnWJufNA+1jA
         rdgxhLSrkVZ32I4OJE/Zd9DSH8Z8o77BzNqXArltFLbyg7ygjet1t29LRXAATUWp4nsN
         23SJn8W7MSpnUfHujJLBdo3mv4kojtUBCIt/KLUJOcmavPhrh31KnzxIekFsBas/5UVr
         Fe30wFtjAh8RO6uHbMIzsmesJ0djQM1jo+d/NI/y5RivxsUCAqz9RQPUZrn01YS6a6ra
         jeFA==
X-Gm-Message-State: AOJu0Yy/IlYq5JHYlGAnB/PGJQh5tqFg2YbQYkuaMv06rp/gkSQ2d1Ym
	KczftbmbWitycgPPvkz3kjYLvGk+Y7JXT5E209u/aRBjWEATR1ZIcdDLZS8wE3ApHMmj1s8BiPO
	Yxw==
X-Google-Smtp-Source: AGHT+IE/bz2N+M2Pe9WuFvbt+SPPxNYz4eZuwSwr7zTnfxfL6Q8toZHreXBRHLqsu13aIIBX2b2Q7Q==
X-Received: by 2002:a17:902:ec8e:b0:205:4885:235e with SMTP id d9443c01a7336-2074c70dac2mr41119555ad.39.1726041711425;
        Wed, 11 Sep 2024 01:01:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 5/6] zram: do not mark idle slots that cannot be idle
Date: Wed, 11 Sep 2024 17:01:13 +0900
Message-ID: <20240911080130.3766632-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911080130.3766632-1-senozhatsky@chromium.org>
References: <20240911080130.3766632-1-senozhatsky@chromium.org>
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
index 52cfd36769a6..dab5f306af32 100644
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


