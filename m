Return-Path: <linux-kernel+bounces-540889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10BAA4B61B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2CB3B0BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4FD1EB190;
	Mon,  3 Mar 2025 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N95+E9mm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B21EB18D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968759; cv=none; b=CxyIDvrlUwIRxqdYC1OT1rrVM8aBxSs1DmTk7c9VvkCn+YhHu2wsKnVXLuhyuiLHACnhBuKc+Ask/AuwrvFzKTmfln/iBP1NtqWEY8jcHKS2uxMri1WITXTgxA3YS48ZFDkFCM+Sk8whOkpd/S6HluFqSymfjoJAzUSuLpHgtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968759; c=relaxed/simple;
	bh=ke1dPd6qfbXoNkqwU7aSzkDQ+8P3AgWfJkB0cvYqPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0pzX2TFqEYI4kuHuGkOTeSeNNDnoJ85+gB6kPifnOBs94+o0d6D+cc/b2iMU0qk0vfv2eK8+lsBzWiG+TqNLG/Y2aNAZrCu67N63R41mt/yERaENP4R/3tzQlRBh8D7iwx8rSVQWgQReD8OPCPz7RCwDmjrQDRy7v1SzoerBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N95+E9mm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so8152854a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968757; x=1741573557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyo5ByX4ms7OSRp4VomEFa7attH8xkBy9eJ/3JfBMpA=;
        b=N95+E9mmnrze8GxtynAIUhw2YF+SQxOjvsBWwMYOHeBp8YEpadQF1QpQ1pKyosEUOX
         HkYb2SFVYXBF25zWJlx6eFAyn0XM/bdWUfcde5StU/1KqwUmN0ln0VoLXwG7WjTFMoRY
         3LAl96+Ga9QrTStC+6PAVPAgSlnj21feCYS1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968757; x=1741573557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyo5ByX4ms7OSRp4VomEFa7attH8xkBy9eJ/3JfBMpA=;
        b=LLZtfd8G0P5b0QPnzYAphptnaA5UjqNQnT1TK0HVNttRjrRYDWzFvLbmbUpPAssR1t
         MJXYlozecFwdD428y4V+p9IocrVuC2Ety+ZsbuwcqrsoXLcGIuaUSCu364tkRa7fY5r/
         TRMbRWQkfwd7JO1dLFL86yNbhAE3Vt3Frv5E2L2AXx5z9eoz4VDcqRjPiGTg3fKpAx+X
         mYW0lnxZRVtKnHVgiVxj91RcK68j0MgCgFISd9wky/625lo67hDOwM0O65BN9pTe+d0k
         5zgsrIjJhebeSZy8XEuj1382rIdGs9raX8337rrMW/W5gS2GJt+6+JNuMCrm7jE0haYl
         4W/w==
X-Forwarded-Encrypted: i=1; AJvYcCXmyZ6s111ex4uLjD3M5/Zf09VoC/YAKZvCOiKuJ7onEAjvc/WNIuDhDPMmodx5Lq8vFJxYui3JvwK89PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuxHdjKEvoZyKw6p0qXZKVUo3kjkmSGoRVEgIDdzEc4gYOAcd
	eqW/I7LFY403W0cC/lzpg0WVOxkkQ2Eo3bjRMUV67NH0H9YeMBzytCmws3n8gg==
X-Gm-Gg: ASbGncsj37txfRgZ6YM2+Me1ZJP01pMKNtUXLMeTAW2f/hczngmb/+Hc15QbRUEuUJO
	Nn3KbBX7aK/efC8j20u/64TNtV/jHfMTNbe4zlcYfe0MP/hRP63LqaJgP3AhW41kw/Gtw6uLOZd
	UB+Kp3T6c1LGYD0PtrWuTLshNeTO1mfEX0Z7cGWakiMyL75HRkV4wTJCv8tB6vTUixm/M6PZ1ho
	mINlCoqcC3wVu/bVcVqpaLi09zF1K+o9aBk+SS0kOFcM0dVb/SrLNe5f59zNcJQ4FRWR8/ZaVN7
	tOrX/rUXwZEZjbnVn4PxBFOI0twHjj/ZadMLgSCNWEC71pk=
X-Google-Smtp-Source: AGHT+IFJotMZFWyExSutVlC701wQGCarIM/cdTnnq47i9KiZ5lx5Nlm+Rg/03s7HRjl5+WkOajCTxg==
X-Received: by 2002:a17:90b:288e:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2febab787f0mr20378028a91.18.1740968757557;
        Sun, 02 Mar 2025 18:25:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea698f3b2sm7671186a91.41.2025.03.02.18.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:57 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 17/19] zram: do not leak page on recompress_store error path
Date: Mon,  3 Mar 2025 11:03:26 +0900
Message-ID: <20250303022425.285971-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 3f909a60cec1 ("zram: rework recompress target selection strategy")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 62aef12417a4..e50a5a216974 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2013,7 +2013,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2157,9 +2157,9 @@ static ssize_t recompress_store(struct device *dev,
 		cond_resched();
 	}
 
-	__free_page(page);
-
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.711.g2feabab25a-goog


