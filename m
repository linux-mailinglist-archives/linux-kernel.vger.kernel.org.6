Return-Path: <linux-kernel+bounces-174349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABCF8C0D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6AB21F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370614A619;
	Thu,  9 May 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSEdW5a1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B814A096
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246993; cv=none; b=CtyH/ZiGA4GHAhBbd3vmcOzTG1SgrTR74VN3G1UaRKVoFgXre2vxllb0kbsDG53qsGMz/9O7LK3YvKDcX7lfAg6N9Z4skR3wWvUJVCMDwLha3vP1YhN5+KCbhGAHx+lS7aYfvRcEr8nH6YHoBLLYh3+cnmNY1znwNbLcftDviVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246993; c=relaxed/simple;
	bh=guUV12xHeWZjLEN/heIpUBLc1w752dkq46c8cDI16K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGbyLyp9m2x9TNwvHef8F9riKIfHgMq69rE3HP8A6Wv2PCzzL4qJx2XHTfWoFVDUGzeMortz3WrUZTzysPy5fKVRlxsdp8uYk7hIoBb2PQsDqF/MopOowzNjRl4oXqEkcEeFtKASy1yIQZtzPUalFKphOIFsvO5xMmmlIG4Uv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSEdW5a1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41e82b78387so5073945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715246990; x=1715851790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeSjiIWiFPchsOxTg1Zyaw5gzDqd8TrDZhofZl4LluQ=;
        b=XSEdW5a1Rq2b4ZOj4PrSlOj78a41xaJglpqPG6S/RLNYOzmAHNmhfPPyi/5epov7Wj
         8jGcJZLadCDfqZN7l91wwPDgPHhjRNN5qHwsdbrxga3zRpd8QvFK8CqsImjUIfIQ3qXb
         hPJg1fKAnb74XaIPFKYx1CWpYVv15X7L+lijO75tkjalb5bqLQ+DqsR8Ey+i1sPR54bI
         43c4i5GRPCwQwsYeAZaNQKjepTFy/oNeFtfQpyaOi4mLUoOSRu+jcLWBhBcbhlwvOLXP
         Pdpqusq5/laRmv7marrHRbmum6hc/kyj2oeMTq1Rz6/USbIHrxLHty0dGmrOqSKzx4Go
         wOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246990; x=1715851790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeSjiIWiFPchsOxTg1Zyaw5gzDqd8TrDZhofZl4LluQ=;
        b=Fk7gbZm+H7IMjEInlPO+aLpUp0jkOntCX06GzEIcQapda64w0uA8HY3xgPugPhr5Ek
         FK719Xff5oxLDR7B7SGXdrzl9P/zdhuCXdXTdLBV4UsJOmHfOXGnOtg47MDyis5waXOt
         ijksVHf9cS5C6jd7uzKE3ANvchQdBDVfpmbLQVeG2+lrHcwOvOrhUwxqKXCN2hlheQ/w
         +QErnF0ioxgtZNyueY3bMdo5IUlNelhhXJh4nThDa7JeSkZ7AKJ7+gmuwDW9J70PW+N2
         5u2s6gG6/MLyJxIReMVEOtXcPZ0Zkmq0RllfhkeGXRfWDTUUwFMn1E0FK/tx0wCTRlCb
         Jwcg==
X-Gm-Message-State: AOJu0YyePnTxTFumFf685eAJoCBiMrQcJNk11ucWyyr1DphnW0/6rzrT
	NNFD9CHG3dfnPKpNXOkkuLyPOtTJ4BhOppmUmLqNWrxbWvrtEGeC
X-Google-Smtp-Source: AGHT+IHvj9qr06dOMV/u73WUyhnxCUsHdsNa1EU1XXGOfei6YvCq89ajcHsuZQJaIBIx4xmJmGBSGA==
X-Received: by 2002:a05:600c:4703:b0:41a:b56c:2929 with SMTP id 5b1f17b1804b1-41f721acb23mr43842505e9.34.1715246990351;
        Thu, 09 May 2024 02:29:50 -0700 (PDT)
Received: from localhost.localdomain ([85.255.237.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm19004065e9.17.2024.05.09.02.29.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 May 2024 02:29:48 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v4] time/tick-sched: idle load balancing when nohz_full cpu becomes idle.
Date: Thu,  9 May 2024 10:29:32 +0100
Message-ID: <20240509092931.35209-2-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508172621.30069-1-ppbuk5246@gmail.com>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nohz_full CPU stops tick in tick_nohz_irq_exit(),
It wouldn't be chosen to perform idle load balancing because it doesn't
call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
becomes idle.

Formerly, __tick_nohz_idle_enter() is called in both
tick_nohz_irq_exit() and in do_idle().
That's why commit a0db971e4eb6 ("nohz: Move idle balancer registration
to the idle path") prevents nohz_full cpu which isn't yet
idle state but tick is stopped from entering idle balance.

However, this prevents nohz_full cpu which already stops tick from
entering idle balacne when this cpu really becomes idle state.

Currently, tick_nohz_idle_stop_tick() is only called in idle state and
it calls nohz_balance_enter_idle(). this function tracks the CPU
which is part of nohz.idle_cpus_mask with rq->nohz_tick_stopped properly.

Therefore, Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_idle()
without checking !was_stopped so that nohz_full cpu can be chosen to
perform idle load balancing when it enters idle state.

Fixes: a0db971e4eb6 ("nohz: Move idle balancer registration to the idle path")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
v4:
	- Add fixes tags.

v3:
	- Rewording commit message.

v2:
	- Fix typos in commit message.

 kernel/time/tick-sched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..31a4cd89782f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;

-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
-			ts->idle_jiffies = ts->last_jiffies;
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			if (!was_stopped)
+				ts->idle_jiffies = ts->last_jiffies;
+
 			nohz_balance_enter_idle(cpu);
 		}
 	} else {
--
2.41.0

