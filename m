Return-Path: <linux-kernel+bounces-191519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B38D109F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8528102D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB113C9B3;
	Mon, 27 May 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zv3Fm8NW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798F13C3D5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853523; cv=none; b=XkK6lIY7Anh7PQVA+OwBirUbbk0M30lAGqD7r4OHkPfIbpUE2iIaze3Pf7oMStqyPToPDTZqaLfBVfdeaDcVFsDNsDW/55CXpYlw0SjwAahnl7KaRtv1R87c6QVbFzILT+0RqWqSeo5f4Szu+XSxuPMR/lf1Lzq/8qckJftx6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853523; c=relaxed/simple;
	bh=DukxrWCXAjyyH7zpUw9lAqh0pCE9UlNjO3BaKcx0yMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9SkmlfHJC0Num/Hibd+H4NP6L0SAeNmlL60BlggtKtXODJHRpGaWZbFuxEEpYvtLxRYw6OlbGXQaqVdbL5/Zlw42vYuM281hNBPFC2iOz748b6+sNyNWVkiAbPdKxjRYFDPima8YwkD30WvK7/77d4GArMmNMiwldYixs/Eq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zv3Fm8NW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354b7d76c52so189882f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853520; x=1717458320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=zv3Fm8NWfLrh94W5mbCakfMstwMO4wu8AdTeDfEvLpZSjKRj/4qeCIwudlWxcYS8ol
         p/Eb3wAeirABuNhlt5fJ69Pbrl6sTz4RECNH6BHdBgfxzo1Oz7afBzHmRWPChALa+v6n
         gIHFNppSN7onGqSKdvk00hjjUaltzuTdP5Oqmy7Lf0gaZ/fjX/oc8+6LY445PtIwURfp
         vVhZ1EoHqaVsXZRy3MdTpqE6o4Rf/CSPIPS93M4nXMU+0lBVSz63EvB9IDGG4SJOGrK3
         eKuNQaKYD6iobPN6WcIeIIJ+w552eGfxrJEh2VCugtOCUIddCiifv/EXBboMlW75GA9C
         kQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853520; x=1717458320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=PzN4QEFAQcIxugUjneiL5z9jHD/uWhab438mWuJgWAwGGmSCA1qOfAJq31WMO/hfJx
         2McSwSMd8crv3Ghqxbzt2bY5PM3ozm6Fpqifh/fhLkLRSoKkw3w1tdIKU8SXLqqtv864
         /mc2NUCzO0+c90U2CjMFuJiAI8w3SkwYblL5/OhGyjSwW++0X3nCz9/uyQ3/Wnp+66so
         Avm1QpYSrmrsWBtdjd13gka8JZsIpWhhiN2L2oCnJ1rT6OJejxURLXnu2BD+ozL1MIv6
         cHHi3g33Nlsw0AHGYp1JhjRGck9HI4Kar0WM5mxeP/fWOqZw/szq6WvUoULpI1r9H7Hl
         Mr4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0qAVCApk2KeeX2QczJx+5mHFKcsvvGBeht91SDnvdakG0LJjorlg8WA1ftWRb3v2P6UKZsKUlu8Vmz9oFgZMiXXLp/ifXSk/8wu9c
X-Gm-Message-State: AOJu0YxZe+jYGsArU86/Tixru+UZZx98mY/gVOTliUuu2inW77uv45hh
	cjWo+DXy++aGgMq42A0p8euEGDRe4qHUkRHm+7M/J1lCyyan3r1gLx7DTSbH61Q=
X-Google-Smtp-Source: AGHT+IGy/gagOKc04QMh7vQyWY1fx5jjEL/7vEbfZ1S7DNLjj4/0M9wIHpNhOOn/pNT8THqBrympIA==
X-Received: by 2002:a05:600c:3ca5:b0:41a:b54a:9ad8 with SMTP id 5b1f17b1804b1-421089fa29dmr70623995e9.0.1716853520726;
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/3] hrtimer: Convert realtime_task() to realtime_task_policy()
Date: Tue, 28 May 2024 00:45:07 +0100
Message-Id: <20240527234508.1062360-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527234508.1062360-1-qyousef@layalina.io>
References: <20240527234508.1062360-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Sebastian explained in [1], We need only look at the policy to decide
if we need to remove the slack because PI-boosted tasks should not
sleep.

[1] https://lore.kernel.org/lkml/20240521110035.KRIwllGe@linutronix.de/

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 89d4da59059d..36086ab46d08 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2073,7 +2073,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2278,7 +2278,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
-- 
2.34.1


