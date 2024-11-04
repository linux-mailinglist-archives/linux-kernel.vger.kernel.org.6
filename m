Return-Path: <linux-kernel+bounces-395193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D59BBA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03DAB22583
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAC1C4A31;
	Mon,  4 Nov 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diyB5BCR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0D1C4A01
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737171; cv=none; b=U8G393CfFsXILPrwLcptHeN3CraHJPPwAEcGxUev17UTIB43WWlAY8L/eg1W6ohSNibA6UOqxqEpzhyhd7kVsLibCOLRAA+AToLny0erME/Hw24nYYMBYXmbXMlNNLN+xAClpQscgwVtpxAr/1OoemCR7tt8lEJ3O1ASuvjTRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737171; c=relaxed/simple;
	bh=Z+EtvtNAVddb0LGVKPzUJYIz4oWFMbDXlfVxfY+njgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlNxidg62/bLSZsXQ/JnlfY0cJuUupe8ZFVIJA4wPM1MWrSpK3M3p7IJNVmquwojOSnsP33yTtkQ5EINv80V/8CgTIHSV1Px5gdHLY6css6mZitcbCC/DOLk+qpx52NPpKnR10Jc3qU9cv/RiIyeptJt7nYWj+T1DL0zk/7eKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diyB5BCR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e862eso19102737b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737169; x=1731341969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F81a+6CGvKtmngjrkoxGzbhKVD48308MotgDbr+zIK4=;
        b=diyB5BCRikRV80sb7qpnw3Y/dd3LS3Ho4L1SN+NKe0azpjw05jPIop5owEPrr/VKZN
         aFTaWrBAzmtfNmQ3ZX8GMZ5ekLlEP+WUzrprfrlGwnPfRRNakdrzoYayrahPySMhNVLx
         VHCMtVgxzB6az8f4b5N1BtKc06EWoSZMZkgXtWt96nZredqocQo9lYngTT127Tjys2GI
         v1RYptZ4xFrNAbFVVlMnBa7ls5ore5O2U6MS+ASj7IwVbyMKFHoUMvx49JgTz8Zgyf4U
         UZn1E+4D2xxe9FrXM5H5aFU6nQFUmjtJwiMVTgeDyWRZ1OqqFlI1y4N9VeWpv8U4vIDD
         wPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737169; x=1731341969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F81a+6CGvKtmngjrkoxGzbhKVD48308MotgDbr+zIK4=;
        b=vBZr/d6qyaxl4n2fB0Y9ZoTyF5rkdCQkHwGWIprGJacWr2KgYsq5vvFx9UVJiVkPfV
         uWIBsvcEG63/k5Kac88TCpXtksRvdiNtvvxV6CL0AEeuB6872pAAT9ya1YaxVsZkJk34
         9G/8ioi88qtF+ngIrYTomEbRuqgWljKvmVD+LGXWlgliXSEg87uO6BnO4ek/6FaJDFR0
         SuQU0a59XE+urDClUlckkUYQ6vu1r1+aWCHl6Qb3cyIlW4IS30lE6iDHj5LkQPjffOqm
         +/CyEl0SmRTg8bfs0dtNiuW02WzPmfd9sCvqTkk94useO2parCfM0de/vyD6DM2ligQQ
         BIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiU4iquhmB54JU4dkl0B4xo228p2uEODUwrggmbRC5WrBxyhe8ZNvJdDp1Kd6rL+02ryFrD2igr2RsqjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lOxSg4E9XVQseucKS/L+98wp6xzxa3bOY3XodbopC/SrTJpA
	bxJgs/Gupc47WhksobyWl9Ulk4YajO9gA88udRZ8B4rSzBSux1qr6zsx4MK0e6daTIfqr9c83Q=
	=
X-Google-Smtp-Source: AGHT+IEVgE/MIej8RE4qbEDqP1YW+GMNJ/swOW+IJ2MrFumHiQViz2zIr7y971A6SVkDwhd+PHYo+OVUbQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a0d:c601:0:b0:6dd:bb6e:ec89 with SMTP id
 00721157ae682-6ea55787f6bmr1375427b3.2.1730737168609; Mon, 04 Nov 2024
 08:19:28 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:06 +0100
In-Reply-To: <20241104161910.780003-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104161910.780003-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-3-elver@google.com>
Subject: [PATCH v2 2/5] time/sched_clock: Broaden sched_clock()'s
 instrumentation coverage
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Most of sched_clock()'s implementation is ineligible for instrumentation
due to relying on sched_clock_noinstr().

Split the implementation off into an __always_inline function
__sched_clock(), which is then used by the noinstr and instrumentable
version, to allow more of sched_clock() to be covered by various
instrumentation.

This will allow instrumentation with the various sanitizers (KASAN,
KCSAN, KMSAN, UBSAN). For KCSAN, we know that raw seqcount_latch usage
without annotations will result in false positive reports: tell it that
all of __sched_clock() is "atomic" for the latch writer; later changes
in this series will take care of the readers.

Link: https://lore.kernel.org/all/20241030204815.GQ14555@noisy.programming.kicks-ass.net/
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 kernel/time/sched_clock.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 85595fcf6aa2..29bdf309dae8 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -80,7 +80,7 @@ notrace int sched_clock_read_retry(unsigned int seq)
 	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
-unsigned long long noinstr sched_clock_noinstr(void)
+static __always_inline unsigned long long __sched_clock(void)
 {
 	struct clock_read_data *rd;
 	unsigned int seq;
@@ -98,11 +98,23 @@ unsigned long long noinstr sched_clock_noinstr(void)
 	return res;
 }
 
+unsigned long long noinstr sched_clock_noinstr(void)
+{
+	return __sched_clock();
+}
+
 unsigned long long notrace sched_clock(void)
 {
 	unsigned long long ns;
 	preempt_disable_notrace();
-	ns = sched_clock_noinstr();
+	/*
+	 * All of __sched_clock() is a seqcount_latch reader critical section,
+	 * but relies on the raw helpers which are uninstrumented. For KCSAN,
+	 * mark all accesses in __sched_clock() as atomic.
+	 */
+	kcsan_nestable_atomic_begin();
+	ns = __sched_clock();
+	kcsan_nestable_atomic_end();
 	preempt_enable_notrace();
 	return ns;
 }
-- 
2.47.0.163.g1226f6d8fa-goog


