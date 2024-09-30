Return-Path: <linux-kernel+bounces-344479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62998AA34
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A371B29366
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AB198833;
	Mon, 30 Sep 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILFyfSBj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7700197A87
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714753; cv=none; b=mu2RxP6rGdZAVa2oK8FJtm2hN9vtvTCfoBMhlp1rw+INgDy9kFHMnkuDT00OvxlPw2MhvLCVPJOOBI1kWp+PplrZ8mJGq9oeUM+zXf3bqnfWfJf9QGDXcVEugH5NUGfpEHlIQuc6oAZ4tsb1Th4KgbyJWe/IFwYEz3q1GJOQeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714753; c=relaxed/simple;
	bh=9RPESpt9lzGw9i0jAX+u14cWpN23K3CFm7HWiQVImAU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tyP3zaa/Px2Hn/el7fVKTXzB/eBFUfRb78r3EC5kVRYkIe+BPErVvo4SOIibIyfWWaWJtK80Rul9iAAV8oI741mzZA5lVTwv8x0Edkt9W9eD2qRNj37ApfpRHe5X9GManAEdoOmh1a9eSzV/qD73Rsly2XzJKH4KAi8xdIno1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maennich.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILFyfSBj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maennich.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624bfcso7921397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727714751; x=1728319551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zWKuyjNbXLDexNj/cvr78ALCXPnSxIrx3rpqUoVnGo=;
        b=ILFyfSBjSA5gBxL+cFH8HKCfqtx4ChmKegyiqXIsvgDGMTbxE3YzO7HjVBbdMEhFP1
         tK1kMOnTQ7CgBjlvWmrzIQCAmNdCFnRO2mtCPqmgkGSq94+Owc7iT9n7yw9fOM0CMrpp
         Gk0oOoxAGpuoKvzTTHSoOkUsGQsF/yXOoRIleyYgYWUK03HXlltTqWH835cnra8mzAhU
         gtJt0ondVqSjykRLH7aAMK0fik0AfYiGLkMSk4b3naMSu/I+CzT2mvvsUK3O/8UQkqb8
         xt9Ti+vkAIDZS2FdEowLuqrfyMo+A65jHSmETaHWxlTHjAdInkhmPT1AkYja8FYxvIdx
         aP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714751; x=1728319551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zWKuyjNbXLDexNj/cvr78ALCXPnSxIrx3rpqUoVnGo=;
        b=Rv82mL8UYjEFTJjF4vzwWy4KzV/G/B1qfQgmmWembUJ35RXddYQXJS2CDjIR8CAg02
         79AEzpk1R1mlBm1SoZw5MS9typNF0Mh4pNwNi6Llv7PCzX5Pk1/wZRS5PlxoUoIcZfjQ
         5kVZKNU/uhsr0ni/pedSQ+fNQT4RkarepYyA6ZrPGLUQAIkUlAnaw/Hh0FfibcYkGwPZ
         ugGvHWqrF52QdSTHKw8dd+4fe6sM5K1LGwFJO6vCOXYkABxHhKKIlKNGu3G0ABmBrUIL
         bVfqJljN43ncQUlrFFdoetvw8J5JGeJSckgrye/waazGF6Xz9/XvgQDpICjSN92WIHsG
         q3RA==
X-Gm-Message-State: AOJu0YwVIbUbTNnl8k3BPniNbfv8bszmVEq6WpLxzHmYmiFjG01SEUgb
	LDRfSrdilgTxPi9wbvpccNgErOIGahH0K3fgo3S/Kvi4SpMdf2kr+byEKvGrcHkLfV4bS02/CYv
	kP7YCsXm8hO0qJm4gk+1UWUzaYtiUP0teF2KZT0ilvIFvBb9XC+LjOu/9OiQL2Qrxk1O+xvKU1G
	9Go62XFLbVRIiq1G4YZVicKyEWf66Jmh1Q6+css4wmmiR3sLZgBmo=
X-Google-Smtp-Source: AGHT+IGlNF2+Q0QItxLUClhuabKeC0TfHXAp5/Kvm4M5qO8+pZ+rmR9AGXs++hxtnmmJsNdkCyF/A2gA0ysAzg==
X-Received: from licht.c.googlers.com ([fda3:e722:ac3:cc00:da:9058:ac10:e903])
 (user=maennich job=sendgmr) by 2002:a81:e349:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6e2473994camr519687b3.0.1727714749980; Mon, 30 Sep 2024
 09:45:49 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:44:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930164455.2060692-2-maennich@google.com>
Subject: [PATCH] sched: fix include for task_cpu_possible
From: "=?UTF-8?q?Matthias=20M=C3=A4nnich?=" <maennich@google.com>
To: linux-kernel@vger.kernel.org, tj@kernel.org
Cc: kernel-team@android.com, maennich@google.com, peterz@infradead.org, 
	void@manifault.com
Content-Type: text/plain; charset="UTF-8"

From: Matthias Maennich <maennich@google.com>

Commit 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use
common task_allowed_on_cpu()") moved the call for task_cpu_possible from
kernel/sched/core.c, but did not add an include of linux/mmu_context.h
where this symbol is defined. Fix that by adding the missing include.

Fixes: 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()")
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e2b7c5282f5d..a7832c53cc92 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/mutex_api.h>
 #include <linux/plist.h>
-- 
2.46.1.824.gd892dcdcdd-goog


