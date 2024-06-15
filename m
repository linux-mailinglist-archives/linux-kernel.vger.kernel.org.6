Return-Path: <linux-kernel+bounces-215698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9CB9095F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9047B22B25
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A80F9D6;
	Sat, 15 Jun 2024 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQVWGsEs"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD69EAEB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718424844; cv=none; b=Zyr2NzEdPJTqhiHsNzysl4URrzmdvTylgvUw/pnS2fUHGybWb+TEJoxykho5uc7z0GVdyCAV4n4H/LgG3X0w6UlFOimIO81fMybhOg3zh2rtwbKdr7ze2gv9m7/2JWLIOMaGeBZgVzGw7XCrZqy7fxxYSZ0GcnMLmgVqkf8NW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718424844; c=relaxed/simple;
	bh=4nVFME92XAM0Tti6b7CHXtYIglbBOaeANfecGgoQSk4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S3kqO+kfKQhMjhiqW8nMWbq61FXx0mmvombQbrpbG91k2UBGC6dMZYj5d0ehsp2OXw5hlP9TtF9RrpKiNTYUv/RuySsT7IxTpH/QqkFdYAebcUX43Tjaun+r5oRD8eWTI7/VcGmtFcdXR8UNTUZT/vZHyJnHUSwy8S27lttuzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQVWGsEs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631282b19afso42511237b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718424842; x=1719029642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a9azksK9xGfpOX43dWN6y+uE0VIvCKdzcELjkRMS5p4=;
        b=MQVWGsEs4DkDm5J3hEcDeQi37FBmyLm7YQerQkI4YTIHgUY03xy2+H1ACFQGFgIJDy
         Pt8NvUE+ljIzjTeiiZnIU54jQGr6B1sKAFoFGKdZUABPoTSBEqGPrMmwoIk9B16undTi
         IrmV5LyzzIDOPi7MVHtfiZIR8z50Sa2+7aQkgVKxbkfn2Q+rc31ArqT9ciKutmuQKuvW
         9zFOg7txWLBP69C4LKeYrgrqHadP5W0aNHaR+EJCrF4bTD7XsLmfWgOFsbSCoMFYP+v4
         8IvywBC2ODo/LRs8MBw1DKd824dwwlXzK0QrtIE4d0LhdIQB5rouiamQs5DJOO3WQsPw
         hWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718424842; x=1719029642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9azksK9xGfpOX43dWN6y+uE0VIvCKdzcELjkRMS5p4=;
        b=mkLghZoXlOjwxS0iDMOc1n5hAe7SVIgbLQmKhpUjpTRR36pGKIyR0tQYb6khp74Mzt
         4N6Di07M4OiMOw0BBg5hPUG1VdJv+4ejCai02A6V5ueSjEJWEgVgtXIcSSIgGLmg8q5D
         yGwgrP3rKnMOQ8TjagMF2uUoYNWJAt6H3bRdBSJXeYzYZNcAkUGcLxHVIIVRf/mB5m8J
         8ntezPoacu6bHwo0jWCvPx8WRHcOI5EcHXPA0+ceNp8tmx5/9nBO+ktfFUnsTw4+3Db5
         Aj5y0kg7/L5pGI+JnRjqEQweBxtAI/8hl3oJpb6H1r5fxr9tr7SDCdTYeBFHwlxuUgwb
         92gw==
X-Gm-Message-State: AOJu0YyP9kdfCMgDaZiHJhAI2HSRyUfQ4HKoFHeYxH3XL+mwZOeUR2/K
	fWBFP6glktwbNV+Cy/O4LBI7Z09PoyifbKEc0vYXe72fzcthIZvZNkeR/xEd2gUm0RLmSfadFUe
	00A==
X-Google-Smtp-Source: AGHT+IEYUNOVoOSzNb2YCc3a1+OxWOPIX9ICmHFIB7KV8Njt6KL7ktMx/4IcUzQTJQN+7k+I7dEDB5etX2o=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:92f9:5432:a95e:d0e8])
 (user=surenb job=sendgmr) by 2002:a25:6942:0:b0:dff:2349:bd59 with SMTP id
 3f1490d57ef6-dff2349c28emr501332276.1.1718424841890; Fri, 14 Jun 2024
 21:14:01 -0700 (PDT)
Date: Fri, 14 Jun 2024 21:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615041358.103791-1-surenb@google.com>
Subject: [PATCH 1/1] lib/dump_stack: report process UID in dump_stack_print_info()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

To make it easier to identify the crashing process, report effective
UID when dumping the stack.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/dump_stack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 222c6d6c8281..ab31f53d23da 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,8 +54,10 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT "\n",
-	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
+	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT "\n",
+	       log_lvl, raw_smp_processor_id(),
+	       __kuid_val(current_real_cred()->euid),
+	       current->pid, current->comm,
 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
 	       print_tainted(),
 	       init_utsname()->release,

base-commit: c286c21ff94252f778515b21b6bebe749454a852
-- 
2.45.2.627.g7a2c4fd464-goog


