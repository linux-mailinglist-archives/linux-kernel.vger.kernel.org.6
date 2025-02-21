Return-Path: <linux-kernel+bounces-526757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A3A402B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CB23BE9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDA7255E55;
	Fri, 21 Feb 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lEGlMg0a"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B524C67B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177095; cv=none; b=sX6o2ybh2aaxSoscm0rjj3EFd5hFE2GctVCcDOOBfnvdVMJrUUX9LSoiFJrutNpfSK8Q9EZCyoHLhmu3rPQWx8+e95Za/VTijxJ5pNTrVjIb0v4ZUIlubudqLNBsELtjsUzJBlBVX3kJLk2yYATgTzRszBw0uEqVxAK7HAQyGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177095; c=relaxed/simple;
	bh=rvsJ9whoHJf9+NBMDuW5cJOov1X5AGgzTWCv657vSYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Van9pDe/xSheR9Uw2seaIdv8eDZYIuzhQBCbfgeBcJCZ6BU7A3VdBFMYgzkhcDk8bhFQ+oWllxXJGzRMOZOW9x/mHcsfq4OmwhnXRo+hzSM8/Uoishtrt732ZolxynyWVMYghBWsaTeDd+D/5iPYyC+zjGmxyIxYQBM3em+zgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lEGlMg0a; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2211cd4463cso54073585ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177093; x=1740781893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqs0vWPwH5ieqcucXqEdSYkl3M4q+06+7pDXyJI2dK4=;
        b=lEGlMg0aQuBE7LMuydTY4ZK7A25ILqyVkiivSZY9e7gFsEZjGs1FJEwvZljh3ibE4B
         e+/OZ12y8fVhgJXOJlWZb9a/z1CPvJYjpNfn/Jk6Rs0mbriGfLMj94JT4rvYpMvjnRX8
         ttfIT6FYCwgCAoZwoaQiQQEJv3LyNncaUAvy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177093; x=1740781893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqs0vWPwH5ieqcucXqEdSYkl3M4q+06+7pDXyJI2dK4=;
        b=SgNrtv/1sOCN7pAikfi27vrlJsFz/0zcZRZFFvREJPdfRqZRfRhxsBzCANV+dsj4NP
         kwoXDw8X+6tDjvzqtqorMMqBGYOFd9WzGzk/gIOMNoPWlpySEHuBJnWoYj3ZlcgE+57P
         joTO8eODGTXM7AknM5HtOp/zIBy1EpC6O8I+u2Nrvg6NMa8kwDAGDHVsFIPkw6yV4S6s
         8+tyCcJMvZ0syUqW2zFYfwpiMwety+qh+tc8rQTVaPF+Bcy0jv0n45G8J1Xu5TNpk4BU
         R1qqCilEACNLlgBGVXFhpFGG6ec8+OqnQ5QCs7SrSTF0QhlnhH4a18S1gw2VjN4fGUHo
         Vtlg==
X-Forwarded-Encrypted: i=1; AJvYcCUfDrsI6P+cFrRHznf+YsArLWK4T/GOlsvmKumMJAE4S4/EbnD5fDNB6N82uh6Huy5i/vTHQUx6oMFXnuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eHy9NmvOcal3PmRkQ/d8qYol172BoQi+cCTC9NEkUJetfQ1z
	wfoFD4+Q9VmFgxdhV0MSpmFkP4sZ5/zq+kYB9d4fe22ZYk4xuxz3jnWl0oqDuA==
X-Gm-Gg: ASbGncv2oEQ9B8tm51xPEaF5jsbjvVg9hfmYIeWECHUA4cKeUmtb+vx2PydZK0aCH/q
	JnFdXg2dLwm7F970IW0oHOfS+j72dpMmqoOkw2JNidzTMtMPjyopDkEjVNgnMMlVpQfGd/GnAny
	Wmt14zVQa+hVJzJ65klfznltveP1Gqtt3DolSYzOlsajJon+ZGpD6MJe1MkZ3f1mQEf9Fw3VA54
	M1NXEN1yDq69rDei7xGn3vqRAKrINR/LVL72Trh2Pu4TnyEYVkSr6iBDoB9KDtdJBX194ot4Jym
	83yDmPY6uOgmi0/SEmUT6jKC9ys=
X-Google-Smtp-Source: AGHT+IEILYc33c4jVA0dGK0BjQpLec5ckC66yqnrCIt209YHXfUD6zSxKU4JtkKRoduvqU5N8dK06Q==
X-Received: by 2002:a05:6a20:12c6:b0:1ee:e7d0:5c54 with SMTP id adf61e73a8af0-1eef3dd815dmr9388338637.37.1740177093080;
        Fri, 21 Feb 2025 14:31:33 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7325f063782sm13714610b3a.148.2025.02.21.14.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:32 -0800 (PST)
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
Subject: [PATCH v8 15/17] zram: do not leak page on recompress_store error path
Date: Sat, 22 Feb 2025 07:25:46 +0900
Message-ID: <20250221222958.2225035-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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
index 1ce981ce6f48..1da329cae8ce 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2022,7 +2022,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2166,9 +2166,9 @@ static ssize_t recompress_store(struct device *dev,
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
2.48.1.601.g30ceb7b040-goog


