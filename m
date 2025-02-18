Return-Path: <linux-kernel+bounces-519805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF6A3A229
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151E8189880C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404226F441;
	Tue, 18 Feb 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqJqDvwa"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761926E637
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894704; cv=none; b=Tq0iqoMQKQ20aEepLO15mx8f6KjiMiIscHBS7MhaR5xLFy/Vqkqon6uY3TK45iAafzR+wDCg6veNRgY031M40RdCZC6I8Hmwwpy44PkfnoJWyLBxWIbH6xUrS2IrJT1ZMREkKAG7sF5oQLdHPJ1TcF/Xo07s4OpBMxw7mU/ciNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894704; c=relaxed/simple;
	bh=BLHeMe+3TTjPUWwgCHBuZW58e2Lj5qXGFdx+y/AyKtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qozFBRlXinZh44GXBGNRThJuut4tzUtlOiJQwdJOBxnEaVhQpIEtPAz1ymhMsg22eoyqAMcROe1U+phV1ipm8y35Qym3RYVwHHyhkB9jywRDlGoY7S7wfIS2K8LdHZ6xvQNgNk4Nhu21H9D7KBCsHSHZ5l9QrdhDBd7/74d1jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqJqDvwa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso46427435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739894701; x=1740499501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zXF2piNTepx0Zg/2eVcKc5ldHZcK58aUvEjPlpIgpc=;
        b=bqJqDvwaIzrLNbNmNP7bGeHhu23JTYnM0WFvFaltYgMBsZFOnFu9KuuHULaW0CQV1j
         QQ6nsNcx0z5oEyf3ZMcWMOD/d/WjsKw7ZuL0BE8ptmnaP9BrwpSJ47z1cJIt4rMEDHto
         yO8wqOdFXhwl+nFr4d4Bjz0x1YlvXM97EU027ah75rgEIAXO0B/Rcl4JfP11C2z/qW7P
         mNpiRdLNGlUQHKNtoEw/sf9X2JxCNnRsxYMhQZ6YEdLoLnen/Qj4OArOXfOJOuxipYL/
         kiu5piGlQEZa4DpLQWQARdWG2jyznQUm95SAHi890EwKirbatB4T2Id7DnuRFVzvcSj7
         b/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894701; x=1740499501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zXF2piNTepx0Zg/2eVcKc5ldHZcK58aUvEjPlpIgpc=;
        b=DSsw0GT4MI6D6K3gaIRI1UKXUOHqSveu7D+SIow21QcyLqSqADBtBAFwvLD7gX+CbY
         omzmJqYDoTCyVde4VFQkhQnYIFa+kU1KCvh/+zZhH0vXuz2E1dft55wDNFo9x1jigMgi
         NZTGx9V2OfIKLgSXqPzQkggttbm/M6Oj6xUpjnbArxc9WadL2XPcR/v/uv1cBlkbo3D1
         FSA8puI9i8b9WRcjJzOn15y24C0JWZ/HXP49MBXzlxmBjLuIkMuSXOMZyafhV0Z0xMJv
         WRa30I4grZdS6VLkBx9KoNO4NO2/6ndF0WYHGvaYkx/nY2efEX4rnKWqzT3etGANFxLE
         B/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXviu/Geunj4DvjP89+hQNJ61q6Uhex0ZAa19sE3dcXiYUx+m239P8DBfK10RNabqAK8CRpvYUOEt0FWO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5CUzRjPHLiHklofcly6m4y8mt8uIVUr6eEUExG0fRQJzg9U4
	QEk7QzE0HohCyvuHpFi/+lzea93o8ZKvQTEUBf8Sq5SjGEpUYk43gCusTsKtfYnA7RtTNwdaG4+
	Jtj1k0Q==
X-Google-Smtp-Source: AGHT+IF4gVclH+C3QVVjteR24jiAvFKwLkzPPhVrvIg++f+B93YulGxjCV63ocqZfYUGbBLyN3Gtdt9dY0Lh
X-Received: from wrbfr7.prod.google.com ([2002:a05:6000:2a87:b0:38f:3771:ea09])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6951:0:b0:38d:c44a:a64b
 with SMTP id ffacd0b85a97d-38f33f566f7mr13741325f8f.48.1739894701038; Tue, 18
 Feb 2025 08:05:01 -0800 (PST)
Date: Tue, 18 Feb 2025 17:04:35 +0100
In-Reply-To: <cover.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <d83f45b96a9c8d3c1a20a4ff518cf4c13bcacbe4.1739894594.git.dvyukov@google.com>
Subject: [PATCH 2/3] selftests: Fix errno checking in syscall_user_dispatch test
From: Dmitry Vyukov <dvyukov@google.com>
To: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Successful syscalls don't change errno, so checking errno is wrong
to ensure that a syscall has failed. For example for the following
sequence:

	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
	EXPECT_EQ(EINVAL, errno);
	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
	EXPECT_EQ(EINVAL, errno);

only the first syscall may fail and set errno, but the second may succeed
and keep errno intact, and the check will falsely pass.
Or if errno happened to be EINVAL before, even the first check may falsely
pass.

Also use EXPECT/ASSERT consistently. Currently there is an inconsistent mix
without obvious reasons for usage of one or another.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Gregory Price <gregory.price@memverge.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
---
 .../syscall_user_dispatch/sud_test.c          | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a67673299..b0969925ec64c 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -86,55 +86,53 @@ TEST(bad_prctl_param)
 
 	/* Invalid op */
 	op = -1;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel));
+	EXPECT_EQ(EINVAL, errno);
 
 	/* PR_SYS_DISPATCH_OFF */
 	op = PR_SYS_DISPATCH_OFF;
 
 	/* offset != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* len != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* sel != NULL */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Valid parameter */
-	errno = 0;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
-	EXPECT_EQ(0, errno);
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0));
 
 	/* PR_SYS_DISPATCH_ON */
 	op = PR_SYS_DISPATCH_ON;
 
 	/* Dispatcher region is bad (offset > 0 && len == 0) */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
 	EXPECT_EQ(EINVAL, errno);
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Invalid selector */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1));
+	EXPECT_EQ(EFAULT, errno);
 
 	/*
 	 * Dispatcher range overflows unsigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
-	ASSERT_EQ(EINVAL, errno) {
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel));
+	EXPECT_EQ(EINVAL, errno) {
 		TH_LOG("Should reject bad syscall range");
 	}
 
 	/*
 	 * Allowed range overflows usigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
-	ASSERT_EQ(EINVAL, errno) {
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel));
+	EXPECT_EQ(EINVAL, errno) {
 		TH_LOG("Should reject bad syscall range");
 	}
 }
-- 
2.48.1.601.g30ceb7b040-goog


