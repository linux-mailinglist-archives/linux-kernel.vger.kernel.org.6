Return-Path: <linux-kernel+bounces-349591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046B98F8C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1698FB2185E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF21AF4EF;
	Thu,  3 Oct 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnbSWH7Y"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEC1ABEA7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990255; cv=none; b=SPL5H61Yq8LVVgQQl9fQkIR9UmL64KC4Kj6FpCl/AAQD9A+/yv93pDXgJVhPNiGA8WJXJ73EBzIpq6ubIICNxmyDcMRLe5IzluU31atSe5rHjfE6kNSCrGeqhGNQ6cJUMO5TQdyvRpsRYadOKDqxQHmIeTJOK1asCpD7Lk19178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990255; c=relaxed/simple;
	bh=IROd3VJkoeniPwTUOiMyty21qBg2Z2tb1n98wFzPBTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mrFRgq2jPsFFGEoIAurDdIeh/RtAEqr0ruZ59+mC7GDIQOzk9F8XJErVYWLP7SdGBWgtXw0aJ9fd3RAgXQizgglFmzeCzUzGWqvzep9OJX+HgCWMGZhM/8E0Lq1HT6bxh9b4j+q1ivVQcevXub/rkfcMxL4iqv6jAP7jqDoFszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnbSWH7Y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71dd55880d3so2381584b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990253; x=1728595053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVeNglwTN7akCXDmRlldGSc/rW6sZdc88WuvUouG7/c=;
        b=hnbSWH7YlL3X/wYMAgb3TFfF40v7w+qxHnxhifvKLBdUkXB95ZyTucmd6dzSXl1mCk
         EHO8h7cVX1eBHSUJHgqHFpZxTwWWmsKCLHssen6/n1stpajbl8kL/XOETYBXHzRlVViJ
         ct6GGlcO6DGUU2xVIpH/H3n/Qp0pM74U79GAuAXeFY48WNkBAC6kkZhg4dRSDvygLAqG
         DEjp8cg5yYrEsM2i+z8YTCxjjvRPoq/qg7gZessSu4lygobIvFKVhZ0LqLFlSnxJkeBH
         N6bSQS8daJppIdYazpO91jt72zDLvD+f8Or43dxu65na0PmcXF2Vqbp3pI5ihd7AdIIX
         f+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990253; x=1728595053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVeNglwTN7akCXDmRlldGSc/rW6sZdc88WuvUouG7/c=;
        b=BP4a3dvZ883vywzpaOM/X01C4ppqlmrzop13W9OrTYU0VVzPs8P/0Mo9nHWvbUszpP
         IG47CkoFR5cwF4DrsudTzTCKSbKipwWVpgZUam5IKLpEQ8pgbsnYoBM0GXgM22WyEgVX
         5NEoEFo52Vr1lkDCcEzeLKpogqR+a3y5j9jq9g5zh1hlFy0nA1JQDHoN6mq7IiH7s0ga
         IEsKWgLJPMKEgIXSTx7hbqHuXZwIu/B4VrnNqVKd0GLVx6TS5vhUgH0fIV+Kh3adwapN
         p4ErDFnFnTiCWvxtaPGeL+q8i9hZgN53AHHJ7N5GeE+lHVuAeblnaIZmGUWTe0vAjR9y
         HJcA==
X-Gm-Message-State: AOJu0YzoBGVfuOE9MWCRJFot996+1Hvkt2k1DVfvWZsvbexJjl102+aF
	Fg9DltumdpnhGhmRPr5nTmwGrap9/g0OSed5sBhwJzYVWnDKHicu7DVq+7BFFghHK29Fbp/JquU
	+jg==
X-Google-Smtp-Source: AGHT+IF1wAIWxriS35+1+9s9R25YDFII/xuSGjwNB1DYXJzZFTeclXhMlYEUs67ru5vh0bxduTAAmrtUyuM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:858b:b0:717:8e0f:3e5c with SMTP id
 d2e1a72fcca58-71de24930e7mr686b3a.5.1727990253229; Thu, 03 Oct 2024 14:17:33
 -0700 (PDT)
Date: Thu,  3 Oct 2024 21:17:11 +0000
In-Reply-To: <20241003211716.371786-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003211716.371786-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003211716.371786-3-edliaw@google.com>
Subject: [PATCH 2/2] selftests/mm: fix deadlock for fork after pthread_create
 on ARM
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Android with arm, there is some synchronization needed to avoid a
deadlock when forking after pthread_create.

Fixes: cff294582798 ("selftests/mm: extend and rename uffd pagemap test")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 3db2296ac631..c8a3b1c7edff 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -241,6 +241,9 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
+	/* Ready for parent thread to fork */
+	pthread_barrier_wait(&ready_for_fork);
+
 	/* Read until a full msg received */
 	while (uffd_read_msg(args->parent_uffd, &msg));
 
@@ -308,8 +311,12 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
+		pthread_barrier_init(&ready_for_fork, NULL, 2);
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
+		/* Wait for child thread to start before forking */
+		pthread_barrier_wait(&ready_for_fork);
+		pthread_barrier_destroy(&ready_for_fork);
 	}
 
 	child = fork();
-- 
2.46.1.824.gd892dcdcdd-goog


