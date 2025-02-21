Return-Path: <linux-kernel+bounces-525495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03595A3F0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E81D19C0AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555A205AC8;
	Fri, 21 Feb 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mohBH/a6"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F4204864
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130764; cv=none; b=ANO0/g0ODqh2mclv/Il+H7LBN7WU9I4L23939vM0m65MnxSxAWDtoOc8K0Kcgqm0RQdu7N5+SYNOfqQn44h5nxlNL4UyIqKqz+29dMT1nbD6fEdefiuiOrREuzSboLnXYjT5ZXH99OMt7FNqYheziJ66nmihLZgjDcDlzWWJI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130764; c=relaxed/simple;
	bh=yCknETG4UrQFty2aOKd7lsFQUmsaITxNXvRW1H8it88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks2BEvMMq+qXfgcGnvUBOWuh5eBuBq8l4+eKt7ipbYH2D/JQsead8A7pN9l9SnYJyIqeVSJzCe847f+n3pWWe+tFwTiVoM7xmDMtVCYttPMFymX2c0oXJZik6yHK5BWpR1dPzu4TFnfrxVSALbhjzKbgcxANLhKvblpU5gAxAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mohBH/a6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so3039892a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130762; x=1740735562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiO1FosDR2lrWYSluoJ0c1MfeSV2ozE15nkpwKYw8aM=;
        b=mohBH/a6WIGFXPVoeEPML6pqJA6k8s/ysuWV/Nip77IXP+N9uUtp65Y818kjRyZlpJ
         k3zdqaaX2IDzCywgej3Tq7GlOXPADR7DfeXVHCGsdX5vDorTevNIufkdB2EwXWB15V+h
         mr4FZNsUlgRCi62DueLQiCjf5+g6ltTYK1YHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130762; x=1740735562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiO1FosDR2lrWYSluoJ0c1MfeSV2ozE15nkpwKYw8aM=;
        b=pSzenP4EkmHgh6LY0fXlzZ/xb8XNpa2BJYamyxKLvWeCVB8tZSxJXWWaEBtr/cC/Zu
         U3pgrVh+aHdwYkeiAD+ZbQqTCMEgiGp6pJW6OMnVaF4fCw8M6ffElzooRp+NH2lhhU7M
         UBJ6M9X7eWciGyb9DkL+RYx2vrTfz2HFnoAm5GyC9Z3seb8P+TJeLAVCZRFKHMbUWTxf
         4k4zmWh+FoECVkMCdp4oTXtI5tdT0bvYFuP5GnL0Gl6o1KzPFND6aZUvQG12l0OWlGQ3
         oySBbJtTAzZmQLtzxtWZKMP/pdoADntDwDPML4Nx0bdPVux3bcKUjpJ+A4xy6Sd6oI4P
         Mltg==
X-Forwarded-Encrypted: i=1; AJvYcCUUIhKkj1QFD5aV6LdQA09rdY5mWGsgST183lPDWCRZDyRP1vDdowaQwHBSGVas1QR3ftcc/HBS5hCkG70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAauglc5vBa4VjhzrqH1XS9HefzHO7zf+gQoZG+vC2dg+OVhah
	rQHM2GENgNzvqUqf+M8Ek63imbRpkg1nt91Ip/jE/cjqxX5DPeSeG1ocGhL6LA==
X-Gm-Gg: ASbGncsUpSqo0qjO6v7cOsy3B07MWujVFtiUMiI7mgjkwY6xfwRJaebOpKI3Xgjl2XB
	3IgV4mWS0I9x8FD79aj427oa685ZUBP7xm9srDBt3TgXSgGwPxPxQKAzn/6YyfwiWuBfi9czY0S
	CmMNr97YDqaNzDt2zPALIKeEQN5Jf7g2k5Bny20Op7h63D19RCK98J+vp2UQmLYJ2ojqDzeb02I
	AJBGUo7AZDMwnqKsoXdVaV4qAR7rNnG0uOpWkwrhdlM7iSkWweHNRme+RDxd6LhV239RdH+1K3w
	hjW6OEltBprURrxZ/uQGJT5Uvbw=
X-Google-Smtp-Source: AGHT+IFFEglapRmDrpRV77iwnKxQ9APz+Jgfl7/ScCUUMY+lOfpVb4pqyKKGcqHkCqH1z6i+q1OeRw==
X-Received: by 2002:a17:90b:3d0e:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2fce78aec58mr4681268a91.10.1740130761841;
        Fri, 21 Feb 2025 01:39:21 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb065299sm981337a91.29.2025.02.21.01.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:21 -0800 (PST)
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
Subject: [PATCH v7 07/17] zram: limit max recompress prio to num_active_comps
Date: Fri, 21 Feb 2025 18:38:00 +0900
Message-ID: <20250221093832.1949691-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the actual number of algorithms zram was configure with
instead of theoretical limit of ZRAM_MAX_COMPS.

Also make sure that min prio is not above max prio.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f59fea0f04ec..a886827f0b3c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2031,16 +2031,19 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
-	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
+	u32 prio, prio_max;
 	struct page *page;
 	ssize_t ret;
 
+	prio = ZRAM_SECONDARY_COMP;
+	prio_max = zram->num_active_comps;
+
 	args = skip_spaces(buf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
@@ -2093,7 +2096,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (prio == ZRAM_PRIMARY_COMP)
 				prio = ZRAM_SECONDARY_COMP;
 
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			prio_max = prio + 1;
 			continue;
 		}
 	}
@@ -2121,7 +2124,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				prio_max = prio + 1;
 				found = true;
 				break;
 			}
@@ -2133,6 +2136,12 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
+	prio_max = min(prio_max, (u32)zram->num_active_comps);
+	if (prio >= prio_max) {
+		ret = -EINVAL;
+		goto release_init_lock;
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.48.1.601.g30ceb7b040-goog


