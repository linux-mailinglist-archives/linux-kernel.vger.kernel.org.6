Return-Path: <linux-kernel+bounces-528440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB498A417B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE87A1890C19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932821D3EB;
	Mon, 24 Feb 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYoysyTF"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BE21D3D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386742; cv=none; b=i+7Tb6Qc2WWGUkUfJ4GNAlmK1rUj/QvBogn3lb/szip24OHNY8N5QAvNkRiuZTQ8dC0tLIsdTqMGgiJNCAcsqQOhhqCXuJZY/8ZQrF9v+pxl56blCvg3uMhRBMClcPju1pGk0947w8ywVZR6Ek3F2c6GUZOgK7JYEn5cffV1wpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386742; c=relaxed/simple;
	bh=BLHeMe+3TTjPUWwgCHBuZW58e2Lj5qXGFdx+y/AyKtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wu16QdZ7RCK0uApYHJZVkEUu1A+NoMy75dIavFHoF/dkbsI5Mm2/HRGEcoLooGWIrHJCROzQMTlsFItR5wpkUjs6Qe5D6vfd2N7Nt6XlDU7DOGf7cM8sLclM7iTSozwncOETffcPHmo95rZCRcW6U21kA5QkQCQJcsF0vOeGius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYoysyTF; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5dedd3ee338so6277000a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740386739; x=1740991539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zXF2piNTepx0Zg/2eVcKc5ldHZcK58aUvEjPlpIgpc=;
        b=VYoysyTFhFUygj+PYbw74A3vjo3VvUXkyRCpzXwwe287qKyn2dYkP65BTf/xYayhLE
         2TkWYh0JBOaoAUFe7SsY+ZIvix/ZEGjmlM/bg/BMsSr5Qyv7fNj7YUwzetjEi4zMWXYY
         8LPWiEH9g1gJMMwsxu0hmoaLJh6NNwMn3WgTsF5clW4Nu22E0jxyOTaxDg3MNIh1Gpuz
         FXcYB3yuo427ZPOIW+eB+1q1lmAbvnuPcx5PfZWQbFUWR9JjjN3045cqVqzI5rip8Rzg
         AV5a3afnIHOH3r02NIyBeXOVzO1bL3IOgii4xbmNlRlSNhKPfBPAWNuDTDfWvD1AA3d2
         OxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386739; x=1740991539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zXF2piNTepx0Zg/2eVcKc5ldHZcK58aUvEjPlpIgpc=;
        b=w7Msa0JLAmi6Lymm9TRycghillMZHGVm0QWD/5XRBt/SZYc1Ml8zqPKXasYYEZIhTp
         NUe5yVzXwru10kECg0fIMgW21CJ+je6rsIMuyueULhJwLDFM6KDOU4kvPJc4PAgtU31L
         ZPOS3+dDrRmD/T+LaVb647NHC4gfuf2LdpuEzY49Jq4HbJM6JeO7dHKTdwFM0QdallLd
         scLN03SpYcREdxg/ptHUBR9ThneuuW6Nkh+kl6R9Tnkn/ZIFFyijEGsKzOXr9EP+tEIp
         v7NswBnKSQUFAhasgq4o9kxyin73o9vuxuw50AsR9CmtMVyWtwg80Yu5EnbfFBc5ZdK6
         uf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeGGlkwQOLGknU+0xz6E4xH+nta7Nnp/49LX/Tjslzs5hSooQF6LHOrnE5ULklqSDxgHuvdRGiTeDjjR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7DWZJngCOrFJpg3VCuM/YYlyvsax9QFu9UzlbL0JMXLe5v1Z
	u/uXK1KZrHVTX2mHY6/ngpvJ9p7gAOPJYXRRgV7xPTSdeJQ12TArPhanx8W+SLz2Z6+2sdMeh4F
	32Dc4Gg==
X-Google-Smtp-Source: AGHT+IGotoXsPbtymb0eBRMPCvN6au2B0HnC7Uy7NlhHpxM0D6D1UHiCRGgBBydFx3vW7kWX3pfcicgFvSZs
X-Received: from edzg17.prod.google.com ([2002:a05:6402:911:b0:5dc:df94:8dd0])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13d2:b0:5de:39fd:b2f5
 with SMTP id 4fb4d7f45d1cf-5e0b70b5f43mr11779456a12.1.1740386739344; Mon, 24
 Feb 2025 00:45:39 -0800 (PST)
Date: Mon, 24 Feb 2025 09:45:26 +0100
In-Reply-To: <cover.1740386567.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740386567.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>
Subject: [PATCH v2 2/3] selftests: Fix errno checking in syscall_user_dispatch test
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


