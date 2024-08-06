Return-Path: <linux-kernel+bounces-276031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502D948D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7628635E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430C1C379D;
	Tue,  6 Aug 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38UH1bXY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E6143C4B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942818; cv=none; b=OMYfD4NbSRCa0OQJe0MrdK6OOOvoOXhScUKDTgWJzij/SJyD+iNzrhFcmDq2yK+u4cpwNy+RqLV4zNDvEkXVwiF+m5WFUoDRnbQbjlrgkKvTkLYFAqWJpnVkD/fs4AYNa4xQ/McMSkg42lKu1I+pWyVkQHInkcYvNnYf6iNxu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942818; c=relaxed/simple;
	bh=kusyX74anKUvJtCfxngX/OtY0QjoeJphsXn2Qty7pKw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=QMh5UwOwYnGmd2IRNBl/ie+VafO7cxlbbadhYlO8yLv/5dYtz+srff+GYu59AF0n/QfWLdDWLrMv9yEqDcC/T4zYWJiYGDrDCEyY00ZoOBEIT7MCOyWV3pvnnR/S4g/HZicKk5Beyti/aX6ejO4kNbzCofoLmok7857U7Nl8mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38UH1bXY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bbd1ca079so834508276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722942815; x=1723547615; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyUxj+djLdlRwekr4YmMJ+pDVibINgk9WOcX6Bxk2YA=;
        b=38UH1bXY6AqQqZcSWKZEnodwDLSnbaRYKgvfhJb3iGMBqTV/6ybZfqVl/7fJgyvC+R
         T2MRV1tEMeZg6dBQqmdbbA+toHwoIxz3CrA4Tj1fAhRgb0k574u+NWigAqRjdCKwEU9P
         Cfpapqs8NqLWFyZwkCFp6kz5fhI/V2weZhe4KCPHCnGW5Cy2CGLpfEmwqN2izMzJA6NW
         czbvx0E3hHCjPb4SeA99R+WcT+TzDVr50AYExHnle1eom/8LsVj7OaJbwGF3wMvvJh14
         lsZQo8c+JYEV1Gi3izhRjPdPeYpcvdHC91R0gH5tNEyEfB2Y+BhTCEdmpQLDnnbX840U
         WzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722942815; x=1723547615;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyUxj+djLdlRwekr4YmMJ+pDVibINgk9WOcX6Bxk2YA=;
        b=S8GK30a3e+kmENCUdaB3j3U+f+4QYlCUvf1y7V/Isb4pFIPwj5MmuBr85ZoB9x66aS
         zILI8AUbI7snXng365lDrqtlMDRZUpkBppfvz0IqorXdjhPeTt1jTJfZXGLV/iprezQk
         4KX96X7JLW5DFHOz9CWylQEdXLeZ+R6K/EJHeChoB07AWUjRSYVYZ/GzVfYttsayjUEX
         7ff2j70l7LlA4bUlpBpD0D+CgGWbVT4FEr8SBYHLdUvBGGCRKDUustAlYu4C8eQt0vz/
         JPJLctUG3WUILckjducOCuYg7h9gJBxbObjuUpdlsXXy0uOIxaBuimMoQS3IMmbuBmPZ
         wJOA==
X-Forwarded-Encrypted: i=1; AJvYcCWDn/7bO9loJAe20VpRzGvWM6WG4cr7AyVBO6C7FIlg4aKwLJG4iJkdGppivtpVFNrcwMBPmZAr0AatMU6EIf/+7UirvsUK+8QXCdKG
X-Gm-Message-State: AOJu0Yy8ueuWUfMBIRqbeTZjEI6Wp9rGo5Nvi1ZRD0O8umvDbONzspes
	fIvgTqYMYDLGQkHqEcJ6ekNKVLX0woUiUfLAnYhI1y7lk5/IR6z0UG3hyqwIhxkvpKbC6VCHmOA
	/6ggoc9TtYA==
X-Google-Smtp-Source: AGHT+IHheegWu/yI68m9kH9ZXwI+xsqn1YVqotildNKzDceR+E97lk+Px0u2KK3wI2oNacUveSQ1G3Vk3r+ALQ==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:fb:d234:7f21:d2f5])
 (user=suleiman job=sendgmr) by 2002:a05:6902:f11:b0:e0b:ea2e:7b00 with SMTP
 id 3f1490d57ef6-e0bea2e811dmr63020276.5.1722942815659; Tue, 06 Aug 2024
 04:13:35 -0700 (PDT)
Date: Tue,  6 Aug 2024 20:11:57 +0900
Message-Id: <20240806111157.1336532-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH] sched: Don't try to catch up excess steal time.
From: Suleiman Souhlal <suleiman@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, joelaf@google.com, 
	vineethrp@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	ssouhlal@freebsd.org, Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"

When steal time exceeds the measured delta when updating clock_task, we
currently try to catch up the excess in future updates.
However, this results in inaccurate run times for the future clock_task
measurements, as they end up getting additional steal time that did not
actually happen, from the previous excess steal time being paid back.

For example, suppose a task in a VM runs for 10ms and had 15ms of steal
time reported while it ran. clock_task rightly doesn't advance. Then, a
different task runs on the same rq for 10ms without any time stolen.
Because of the current catch up mechanism, clock_sched inaccurately ends
up advancing by only 5ms instead of 10ms even though there wasn't any
actual time stolen. The second task is getting charged for less time
than it ran, even though it didn't deserve it.
In other words, tasks can end up getting more run time than they should
actually get.

So, we instead don't make future updates pay back past excess stolen time.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..42b37da2bda6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -728,13 +728,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-		steal = paravirt_steal_clock(cpu_of(rq));
+		u64 prev_steal;
+
+		steal = prev_steal = paravirt_steal_clock(cpu_of(rq));
 		steal -= rq->prev_steal_time_rq;
 
 		if (unlikely(steal > delta))
 			steal = delta;
 
-		rq->prev_steal_time_rq += steal;
+		rq->prev_steal_time_rq = prev_steal;
 		delta -= steal;
 	}
 #endif
-- 
2.46.0.rc2.264.g509ed76dc8-goog


