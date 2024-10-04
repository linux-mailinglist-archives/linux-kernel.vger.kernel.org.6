Return-Path: <linux-kernel+bounces-350047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D449298FF1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB55B21FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7513E898;
	Fri,  4 Oct 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9aEorJw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB38179BB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032004; cv=none; b=fK/kYUZ//Y+BujG3Q6rMmbe1bpg0IjWyZu6G4JxeAfLvB6OtFnAboidUuib9efb0cARv0+i0+qBNGw8F0IA00f18krS24Y1aGubEo0TKWjDzqR8ej5da0/D0lnQCpCUiFH+EiLRecS+hOlwdNKKCDwteZx1fk9oN3EyRWVoO3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032004; c=relaxed/simple;
	bh=fSi/DnRqOTTDowmfSZ5bZ6hGI+ihjfxBm59znB+ZY1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKHPqzz/jgPF+b01eBkdTZzDCRK9t8Z1xYQyYowFf8tDDO8JykthmptZotky8pFhMEHo8/cCa5FbosEwGQlMQ7d1UGx3f3DdZgDoVlF4A9JUmqTXR/itwUoW4LoJfiG5xISPI/WFMphsPzBOT82lks1+ApgelwiFYioG0IV0DkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9aEorJw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb2191107so16936725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032000; x=1728636800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghyrjKQPR6MAXEymJxap2yPvYqxKajoThOTWMdhxLdk=;
        b=T9aEorJwJepoxXXfOK/k4pp6cJ5F9DrVRzE0H1v4rIXiqdKqQsz+YjMFevLBLvNbnJ
         ihPdya5PqZEDqW+z5GdG6AZCcie6flWaHPmJa7bjUpoKo/SHoS95tGNinkBm9+lzcPfw
         QPqjl7YIomjW7KJUX6VnDnapd1fQe8Ez78mb4vHUoGZ6Dgm/AnP0tdsS6bNIPMvg9eF0
         QxUwT3jCwGtV/+nFH1SP608m4C6aWsq6ACuYxtSr9cUfvbkT4EGV5l0xtv0ZVPGxma3d
         MO3ZkocLhzExwT5goMPwqYomlHw1pxrPvB/aaXA18osKtxAxXqYIEsQKW2S+mMZAF00G
         zRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032000; x=1728636800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghyrjKQPR6MAXEymJxap2yPvYqxKajoThOTWMdhxLdk=;
        b=YMFj0NWNcUKErqeW+qjl1rFl38wwoSJ7CJGJX6yjgPuIO3fFSBHheAiYF1RJMy9CEa
         U8G9W+eO2OCjNURNRmnz2WX4A+t/7htq1rXzHlDgrP+LQtTCzXEu9CMD6ysqjbD5ipCz
         v3AUfryRwSku0Z5gelwCDEO28uPgjkGnz61AJB/Q2sRIQF4gfvqDVHDaTi9SQrwuyTG0
         SdmmbWm4Fy6ACyp73Jr1KumTqw9FURcUgOp5hsP6fd/0rlB7AEL2ucYDcbTqAfkzzKqR
         XmITKMlCO2dWukDKF7ZDdvr7Z0i9EZXPwg41O3XrxqBuhkXvG3llz37Q18tUUPslts8K
         UVfg==
X-Gm-Message-State: AOJu0Yy3Wiv35Bndj2T89w3GXgNwtBAhmIVM4EwWAD3quXmbgZtHHR2R
	myIUE47Pb6uJmGSkdWZErK94lMAbqh1o7FgWIJbwb8cH0sp+jzWtHe3p5BXa
X-Google-Smtp-Source: AGHT+IHyMfjfE9X8yw3eeuZMil/pQjXN1GC6KmK1zTbMsg4APUoK4scF+XlnFjeIZcYx4a+olPhvEQ==
X-Received: by 2002:a5d:5ccf:0:b0:374:c949:836d with SMTP id ffacd0b85a97d-37d0e7b9d9emr1203853f8f.37.1728032000167;
        Fri, 04 Oct 2024 01:53:20 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f74d9sm2845453f8f.7.2024.10.04.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:53:19 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2] futex: Rewrite get_inode_sequence_number() to make code simpler
Date: Fri,  4 Oct 2024 10:52:32 +0200
Message-ID: <20241004085257.10908-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rewrite get_inode_sequence_number() to make code simpler:

a) Rewrite FOR loop to a DO-WHILE loop with returns moved
out of the loop.

b) Use atomic64_inc_return() instead of atomic64_add_return().

c) Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
atomic64_cmpxchg_relaxed (*ptr, old, new) != old.  x86 CMPXCHG
instruction returns success in ZF flag, so this change also saves
a compare instruction after CMPXCHG.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
v2: Explicitly initialize "old" to zero before the call to
atomic64_try_cmpxchg_relaxed(). Rewrite commit message to
state the motivation for the patch.
---
 kernel/futex/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..ac650f7ed56c 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -173,23 +173,21 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 static u64 get_inode_sequence_number(struct inode *inode)
 {
 	static atomic64_t i_seq;
-	u64 old;
+	u64 old, new;
 
 	/* Does the inode already have a sequence number? */
 	old = atomic64_read(&inode->i_sequence);
 	if (likely(old))
 		return old;
 
-	for (;;) {
-		u64 new = atomic64_add_return(1, &i_seq);
-		if (WARN_ON_ONCE(!new))
-			continue;
+	do {
+		new = atomic64_inc_return(&i_seq);
+	} while	(WARN_ON_ONCE(!new));
 
-		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
-		if (old)
-			return old;
-		return new;
-	}
+	old = 0;
+	if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
+		return old;
+	return new;
 }
 
 /**
-- 
2.46.2


