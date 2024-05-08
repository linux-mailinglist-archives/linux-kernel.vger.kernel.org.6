Return-Path: <linux-kernel+bounces-173624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A58C030D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEED7B20CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A35127E27;
	Wed,  8 May 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJaB+TtC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AF10A28
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189187; cv=none; b=YfZMbCikacKgPQgC8Btpxq/FM1bT/K1Kdzjl7lJVHH/gHgXkM2IMHPOaGLNYpw8qTNyOdhNkR0n+M8arG24Xa1VhpnDZdEW0byTv62ze1aXxhHYJ9Ml8z71lNq8IOhDR8uLLAqhFbYS2RfZzQEsYo3M3ZTffCMjHcC25fmNA98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189187; c=relaxed/simple;
	bh=WDqAlbsNHJT2hM1NYyc6kmkejLq/GvPP4lLbyiAl2HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3el4RKcL99acZrjdYnQbARe2CWF9zfYOWf1xRZOglPYdWDIGyyMxowKm8/W6VYEiiH46ASN4slWFcFRmDm7pEj0EOuh+drUrv4FfkLhdh65Gww8KBg0t/VLlWsWK3uG+yl4tAMKzQacgzJp4QIkD0pSX3GoaYao4qUmgry5Ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJaB+TtC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so32459055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715189184; x=1715793984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+N+ZnUOgf2mygsXax03p3JjiZPmj9PGmZaXcZS3l4U=;
        b=gJaB+TtCA5lJzn/AbC/a7TYERNijBwq/7qbz+2xhOkhkV7qC6M0cB5CMS9xrwjFvaX
         kXhBRvcWYNwO18oh21WU6oWcnODhk9g2OkwCkf2zQ/hWhxKOqdRgmQ9g7bvYSYbyGgKM
         aPCETDbGmdqgQUxwO9bae27W6QaNz6vyViCxfdQzqzNntimVP2NDSCzhl5yOU8denkcZ
         KG9b4U8ASAKCHFQqFqkgk+51Ya/1O4O5VtJZ3gYG0SMAsIx2OPT5dJW06Mz4p7ahZWWe
         qKVW6RIxdOmpbBDggheNM70ocEx3P/KnorbwAbZOTNTLjhKAoFaObxRg38ypgzwZ8YGY
         2izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189184; x=1715793984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+N+ZnUOgf2mygsXax03p3JjiZPmj9PGmZaXcZS3l4U=;
        b=bh9xi8k+Y2YX9sSsJm3DU1U2HPGAjQjmN9SzaQ75rt1JNdVsmqLHYcGsNwbSzEE0Ln
         OYIQ7dxhHChpNymsQlTyjRTDelSDAXTqi1wxmuU1srYX7fYg0oh+sNmhd7xGSVujK4Kk
         Ar9/tuhc7MPfnBsZo6IbO5fZNCMrqGTvFxKivGEN34Rrcb8WquX8zWLJMpjYvMIuAE7c
         McIE/cKGxmM+qtyM1Pgq17UKaq7tlpgivgk/3bxLpgixhwfZzMDTm9Xc46Lg74b2rYRq
         vVftUY6B0eGAmbFwcWTKQp/MVcdQ3a9++/V2+ZrcVTy3Q7QlCVOCLn905Zj+9MU1vMQs
         OBEQ==
X-Gm-Message-State: AOJu0YxAkYcnNsz04Dl8p8uPRoncjxth01AV4H6h0HupIj3WyaxvHWBE
	zDNOf1xSK4kKDwmLnXhOm8t1OAz9sslQpYcTuBCI3qVK4wyYvEyM
X-Google-Smtp-Source: AGHT+IHWFTxwNE/7l1cOSz6SFJJlfMfnhAi6SJfbqHVR2nwjkPa2GWXIBhnMJrcdsU87elLOvkhQUQ==
X-Received: by 2002:a05:600c:1d18:b0:418:2a57:380c with SMTP id 5b1f17b1804b1-41f719d6179mr26790595e9.26.1715189184230;
        Wed, 08 May 2024 10:26:24 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f8811110asm30448725e9.35.2024.05.08.10.26.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 May 2024 10:26:23 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] time/tick-sched: idle load balancing when nohz_full cpu becomes idle.
Date: Wed,  8 May 2024 18:26:21 +0100
Message-ID: <20240508172621.30069-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506213150.13608-1-ppbuk5246@gmail.com>
References: <20240506213150.13608-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nohz_full CPU stops tick in tick_nohz_irq_exit(),
It wouldn't be chosen to perform idle load balancing bacause it doesn't
call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
becomes idle.

tick_nohz_idle_stop_tick() is only called in idle state and
nohz_balance_enter_idle() tracks the CPU is part of nohz.idle_cpus_mask
with rq->nohz_tick_stopped.

So, nohz_balance_enter_idle() could be called safely without !was_stooped
check.

Fixes: 0e7767687fda ("time: tick-sched: Reorganize idle tick management code")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
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

