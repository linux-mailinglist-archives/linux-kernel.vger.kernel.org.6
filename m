Return-Path: <linux-kernel+bounces-348992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C438498EF01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DFB2223B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E116F8E9;
	Thu,  3 Oct 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHXRwx5Z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28E1552F5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957970; cv=none; b=ltfZssGMS4SogdebTgpgICy23GWe9XjuuoGWfioqA4HA2dG25QRZAErSnj1AuNENy/Vgb8BkHJCVcUsWuQAz/7oH6WTbXLXPOfYcMrbuFY8pe+JH3AXMSipon44iWEIWU7g0Dx3hFFRchXl8oYem/P72wyBDACjxTzbEpy/adCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957970; c=relaxed/simple;
	bh=KEB/8k8ndhKBSOJo3WBnuriTOumG50bABJplbiXwiOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJxZ8KRuKXR5REPLhYzF4fCg5YcEJ1hbEosTYJLwb07y343PqTmIkRic/+U619slcqfVLe1irBG7WElZRze8Gx1eNMg5DRMFWAvgrV2P8QAyfk52E73Q6lbNb9ieszSpcK0nyPTxRk+Hs34RPTjg5Cdarkjd5ZgEYe3QcTx1h8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHXRwx5Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so7158445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727957966; x=1728562766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbuF/8FozxAMN0AkIZbUG6wZ9o6r0Q1LLXmokEER4ko=;
        b=dHXRwx5ZUmnT2uk6fA3E7Dl+5tALiXjG6CVDIAGRWDHic96Ol3eeHvFB2vLCkvxF91
         Urw4T1xQec42+c8O/+nzKrvMfV07915nEMqg0Cuvvh0ysHRBlDmKkNcIzcJUZPYtxZfL
         RbkypjS9SawgoPOHcWNB3QEk7po+MtWUiUAUB7Mfxjk7R9L9HkRBAXbqOtDmSq6YBbqc
         A/E8xzUMykH7lQqwuSrosjLermAr+pPxklchz4+iEmhveKVzl63hqFxyvNey+GkQ1/6w
         mSQnuzY0hegXWhxibXqWP3PXcUVKWbE9oRqumSdtJQaq4zz7tKK1eU211WDzn7A8Luao
         W3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957966; x=1728562766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbuF/8FozxAMN0AkIZbUG6wZ9o6r0Q1LLXmokEER4ko=;
        b=rHancmfymEezoyd0YLFjUtVggsHteswtC8mrvm4EhjxE1NoWkq3FgyeBfk9qYE0ysi
         GCPtSj84mzJ5qZZE8XwEiw+XYWcisxeAThZB6OKQL21WxKgqUOqBj0N8Gn2c2gQiMIG4
         Drbz2+fOyqUUffE5a6ItDuTsM+vOLtP5ubEixrt5UqtveXrNO2VWvCD/yMDVWn5bGjzr
         Ufy2+Xt9nbGqc744/wIIV842dZWioEm1Bm/BU0QI2LWxgRCLAoJnUI4YxqxiwFm28v0e
         85/OVU2M+31GeGlYVERhQyfTgr4wiyFunLJsPoYpcYDKx509SiFMM0d+e9/juhYLVctF
         PvWQ==
X-Gm-Message-State: AOJu0Yx2wtTpFMYW9slama1YJjvjUpikEEe2J3M55yqIoP6UdQo5WGtp
	gXC0NxWdGRbU6Fd5Z3Y0R1bmXR+Rc99/kPtrmYIVzw6nFw0KhSWEKzq7081B
X-Google-Smtp-Source: AGHT+IFv0CMXYVQP3sFtIRHqIaw4TuGxJo9M+D0iWqklrn7xbM6Dw6KqvCn6uux9JIrAjxm5V3naWg==
X-Received: by 2002:a05:600c:45cd:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42f777b9022mr45916815e9.14.1727957965390;
        Thu, 03 Oct 2024 05:19:25 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802b2805sm14291615e9.44.2024.10.03.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:19:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] futex: Improve get_inode_sequence_number()
Date: Thu,  3 Oct 2024 14:18:55 +0200
Message-ID: <20241003121921.922394-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rewrite FOR loop to a DO-WHILE loop where returns are moved out of
the loop. Use atomic64_inc_return() instead of atomic64_add_return().

Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
atomic64_cmpxchg_relaxed (*ptr, old, new) != old.  x86 CMPXCHG
instruction returns success in ZF flag, so this change saves
a compare after CMPXCHG..

Note that due to early return, "old" equals to 0 before
atomic64_cmpxchg_relaxed(), so initialization of variable to 0
is not needed.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..665501c885d0 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -173,23 +173,20 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
+	if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
+		return old;
+	return new;
 }
 
 /**
-- 
2.46.2


