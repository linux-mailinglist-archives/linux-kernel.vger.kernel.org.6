Return-Path: <linux-kernel+bounces-514363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F6A355F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737471893FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88C1925A6;
	Fri, 14 Feb 2025 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBoWgbLW"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAB1922DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508840; cv=none; b=mgxLHM/gN7xSB0ZypI/EkNP9kDjIApLqtS5TxtzlHPt7AWcgqI714tdlmLoMV7M88sDydRxfVoiHaxVGvo54Fth8/qHdw/K4Y1QUQYDsVQOKWnZFk0RKplny5lGbNIjFvoA4c25do1YKTmXhaZBXy23uWh7YCnMPESW9P/OVbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508840; c=relaxed/simple;
	bh=k/laeVohRtQCUN13mPbpDtF2OZR5zuNMWh4dlmbx9Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbXy7ELShD+hu2cEPzxhCC3tE+cMl873nbAY0dXkSJbbkgYgU2IpgKtvv3kr4dHr3sm/2GLKClCaEtus3TWR8EEy9sGgpTqLD3CBmUK78YTK7xqI4ugcCo5sf4+KvaIgr/DcrFFqIEshZQK+1KvdBsU/24tihRrMt+N4MXhD2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jBoWgbLW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f42992f608so2688034a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508838; x=1740113638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3vcsQRfcy+wCE7pS6Fz7pnfmcjhxh9cIXH2LP2gfks=;
        b=jBoWgbLWCVh1PeTlXM3acW87h4kKHGaQ8AzT/UiXWlW//Oi7Lv1LqFs9NQ29mqAbpW
         Cm+/mRtZISSWZhfILXq41oC0wbFkZWKnvcibdNH0CBIZDNlD1/uOCTRrZXwgP1OvQmgF
         7OgetVGBMMvg8Xjvh7xs60QiIDJwQu3v1oKMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508838; x=1740113638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3vcsQRfcy+wCE7pS6Fz7pnfmcjhxh9cIXH2LP2gfks=;
        b=sr7IkzVKvGKfXgAMctpOcolwNEm988x2tBg4LkTjKF4D8hgqELM/YDIIk1ZFt1N7TT
         yA+WEi/yvJMKUat9DLqNDags3SThhaiJRLQRn2JFD15cYjRayI/oPivIxXUaIq0jKmHm
         KcqczmE0W0o7gIvgEcQ3m+F8mBco7R16cKPKCpBemfv4XBfmSfw8Yt4fe91YPalJ1yB5
         uPeOn48WeXYMH8Y6vv5LkNVppCuPSjoKfpaEydTSmaQNyGJSdjlEzdqtMLs1LPoGVBD1
         hc6dCx7tFTMkExN2c8s0vgXo8et8xojsVMPrj5lRONJmxhY9Jv0rsp72Qu/ReRqbIM5t
         Jmfg==
X-Forwarded-Encrypted: i=1; AJvYcCXajCZ5DmMQzE+DvmdfYVj+P8jl4+XNTr3mNBgEf3bzvD6zcoemfwjFny72udw5heRc5rsJ+I78Rh24bMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybndzT9GVcX+NZkueB9r5K8YP6ufBR6gaijgadGxoDS6YSLozP
	eetPNUewXPQ+deGedDqGlYk9izy90zoAJL3H+vnxHp3Q/gvWnqlwjNAxTWIQaunixG95DxRUrdg
	=
X-Gm-Gg: ASbGncvuVycXzZS7/gjetHx9Fu8C2JV+I+HMohC8khA74eDeAQOKQulpT+XzxR/yTKI
	91Mah5xEjSaRz7enJMOSB8cExpQ8sktUFB3utaWGfrtHSzfodasjAnXoRm10Ug70oFZoKqNiHdR
	xkXoWYxBd9G8eIFe4zEo/V0StiGs+VUmQV2wuF/DB9p52en8l7APQxQqJTmIkvBkRTPpJ9+fllB
	i5K5fL9AFNn2YhBc4b2+9co+SPk1vMaPdgEx+8wtsuZA3+2xyBFyxvCqkfssxZgL9LjPU4+7nxN
	P2CCr6pXJJGqyjx6eg==
X-Google-Smtp-Source: AGHT+IHAcm0g7zYqkHRuT4x03coHX+AA6wb7u2m15AhzZy57LDAWmkRXZjtrdEJDwTr85W6SV3VPqg==
X-Received: by 2002:a17:90b:3c48:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2fc0ea881c9mr7990978a91.21.1739508837865;
        Thu, 13 Feb 2025 20:53:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ba6ac7sm2214490a91.45.2025.02.13.20.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:57 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 16/17] zram: do not leak page on writeback_store error path
Date: Fri, 14 Feb 2025 13:50:28 +0900
Message-ID: <20250214045208.1388854-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 330edc2bc059 (zram: rework writeback target selection strategy)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b4661de6bc29..6adaad56f4ce 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -829,7 +829,7 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
@@ -971,8 +971,10 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.601.g30ceb7b040-goog


