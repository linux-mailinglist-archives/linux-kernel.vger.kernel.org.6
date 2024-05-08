Return-Path: <linux-kernel+bounces-173750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7758C04DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8907F2822A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E6130A51;
	Wed,  8 May 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlgk9djv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054912AAE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196139; cv=none; b=WpSkNlbzJAZea0ENs0RMfwvR67+lObK+COSI6r4ZPSQ1n4FsvaGmnMEq8VVGM/6JEUtDIQss0HXDb2T0p2mHtXvMwZYzqidWrLrTuqJYHrtJQRmETIa38yk94Dccj64s63f3aX4N9AcwgU1DpoTuFgBcQDZWmL3pp6b8PdDkYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196139; c=relaxed/simple;
	bh=lqqYhTHRkOHchj7ahusEqPtaPXdvyvpJQqB28P8Khpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIH4BZf5ErJoLojqoRYL0JEuc6hisgfFB06FxQgSWXpRKJelq5W+aUf8heRYS8iyd0aJpHRE+Me+ZGBmKkwSyY9NhHafe/ZP/iBACMCUM2kIuLdNZgg5eAGqthpV/2FJLPm3yX+QDGI8+VowDtxKcApKADAmbCsrGmkFjmQ6N6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wlgk9djv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34f52fc2191so28598f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715196136; x=1715800936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHdWFU3GAmv3dyZh/NErYLFPQ80pO8FEjOYvZYPGwK4=;
        b=Wlgk9djvmDnNOsXjQ7WMymA2UB61GzqcHjFYJaYrWjEb8+wfQJ5PxSIZkTbecGkkBu
         WIycnv5zCqI2YfKHlMXJCQKcabCNWiFq0BXijlTDjZ2r8Shpqu82l3eqMnyxHmcKczFR
         c4bDilEH8MAZGOa8QGLO+bsFDtHjWveOg/mcGhJnHLxgd/ieWtzQiWenqiwof0KtGL5k
         +OEu1bHcDztfSarnAmdNcfnqTBITE3se5u6BGUKjy5/8Gw5VDMz/1YlfyXvyreaRQJy7
         gZRw471ZFQVyXWk8pnmi4WEBznRTk7kIr6jy6WHWskinGmehqXrO3HJKFFtsZVcxEBJ0
         FzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196136; x=1715800936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHdWFU3GAmv3dyZh/NErYLFPQ80pO8FEjOYvZYPGwK4=;
        b=TxRPbvE1vegyOhpJhNlpmlHADUVEuL/nl70BzBxd7oJ1QzTA5O+lQr0r5pe/RmbJ8f
         QdU7hR4RPV8zMFpVlIXKrr5sYhPawx+MNSPcG0KMzvkB4cVlioVBWDfZZjTEsTnxi1dy
         FxXhtlNKGdOmGpbYT5Q093/Ogf+4arkWytYHqQieocvyhSHS3vBt6BiuKJ6ZFgU6X9Bh
         F2WwlYYMdvmnMwuhCdC+P0CBpaY2vqCbjoC0aTDsqM5R18/J/U7IUDEOA15+l/uN4PFe
         YU6qPEFJwXq7cwfpoDOFd5uxVjaXaY3Q9LqcsWS77HfS2J8hHkNJpNvLSl7YjZhzvbak
         ayng==
X-Gm-Message-State: AOJu0YzR0vxZiwbMcmCmJwqtnrNEjb4EYtgTY/2WJunXLpk715QJ0n5K
	ZTMpvx9JEGFJvEANhDSc2oaL8vsh6072ptLYCFj6AvfMXeIN7hRh
X-Google-Smtp-Source: AGHT+IH1LFIthPmm8rjO7cHBk7oP96R9pj5grKZFAIHcYCC1oLMrOqsbmEA9fd63ZrHawTu9t8W/yw==
X-Received: by 2002:a5d:690b:0:b0:34e:16b2:9abf with SMTP id ffacd0b85a97d-34fca339aacmr2603256f8f.33.1715196136172;
        Wed, 08 May 2024 12:22:16 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id gb30-20020a056000459e00b0034e0346317dsm15984822wrb.13.2024.05.08.12.22.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 May 2024 12:22:15 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v3] time/tick-sched: idle load balancing when nohz_full cpu becomes idle.
Date: Wed,  8 May 2024 20:22:13 +0100
Message-ID: <20240508192213.31050-1-ppbuk5246@gmail.com>
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

tick_nohz_idle_stop_tick() is only called in idle state and
nohz_balance_enter_idle() tracks the CPU which is part of nohz.idle_cpus_mask
with rq->nohz_tick_stopped.

Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_idle()
without checking !was_stopped so that nohz_full cpu can be chosen to
perform idle load balancing when it enters idle state.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
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

