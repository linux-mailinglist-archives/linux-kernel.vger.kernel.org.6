Return-Path: <linux-kernel+bounces-259957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8A93A079
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98728268B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857C152524;
	Tue, 23 Jul 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CSJkRm+X"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD8152794
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737229; cv=none; b=GFeBzaTwnT7/LewPywwhKm83htdWbBVwYKbSXXKfkgWycyJjFmiJUq8kk5U0yl46hERf4vIlAIVKPdQW0JeBoNamfARpD6f/Bfde0Eh2AfjpcV036SOAc+lb/e/Avt4g45XcnfHAHopeFk7VjF+u2aERsZ3XkC3KRSiU+EmF+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737229; c=relaxed/simple;
	bh=HLEaVpA6FMR4Zdz4p/Ldx5xmPCdzWU6LBAw32JR6Wds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcuewAtrJb0XBe2AE4HPlUE4vWaklRP5zXbi61XkrlZ9Pax3XQhJaXKmp0Ljcpw3HfP/UYxYyDna/0ZShK9Q0WCdnDyXnanC4TNSbzzZzAh95Ufz1JwYX8qggl/zqUlmNauKoSLiD7IHG7ioZ15wDGij6yfc96NuNdIOKBQ418c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CSJkRm+X; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-381f24d6bc4so20987865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721737227; x=1722342027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h7HTJePMWnYKEcUNwoiJ3GWGK3w1qTCbVkfmacFufI=;
        b=CSJkRm+XcjpF0C5aigFUh72SVw9D6hRs8KrUfDSMzxqCABnasGAM4k9j4YchF1Xjrx
         UDQ/v2IDIObYDiz7xa9bbidosnwXEnAm6/xxTM21w7q4ZkR3K6Xefr2lobhT9xVUwr4P
         n7knQYtPaaFdRna8w+IGlInrMqgqc3etytmBDcKwTYgwsUegsVtRjHftVQtq4CsS+5J/
         +VAkoIFNVMncdFZLNq+jYXh6+h3C5lG65pAs7eq6nvoAezQLYB42FjsNLkaA4VwLGke+
         wrK2ZTNoiavVgdjhAVxueSRETpi06MXxyV0qqvXcPWgHG2gIdmcdye8BkEnMoIFVElpj
         3+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737227; x=1722342027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h7HTJePMWnYKEcUNwoiJ3GWGK3w1qTCbVkfmacFufI=;
        b=LgBbpBX6NiRKUuv8/6P0K+WKU7lQqvzN9PBAahUhBWjgAWXJ+916liQYTIUY8oH7vs
         HrOO7q5iwZT27/ppKpF0Rk+72TcAh03u6yeEGxo8g8VDKyIe+nPnG3nReibDT0xgAtLK
         7eXnXSYlUQ3E1dUB5Yx+sv4nOjewfpd7MWzck/eczgLBU4tHA1cqw62b2G76yZd1+/30
         RFNhIiT304StpAid6vAgyWgbM3ZXIT5oT4mOA5Slk5D6gx9h/B6rLWrLoRXx+6dlPk+x
         6+3y/FOQlfj/iKV8aPwqdL/jtzEKRJzYZvPORY/ynUokkRTjY46opyLZU50fIfTHyEzL
         odbw==
X-Forwarded-Encrypted: i=1; AJvYcCVlFvFMfuJ5shfAu/AbZ9kSVFHrZ5zyYuL7s3jJ/XR8KTaZhWZlittY/e3DttKSIKwVXEW4tuxVXzSVJd8Di6w7JZa0Ucg5OPGq5Jex
X-Gm-Message-State: AOJu0Yxxn3qIHm0EDaeMhEe5RvmkCWKpU49ZTxtBRQVGC0C7j3qOC8rA
	trOw8fL7WzZMvG7TSLNL6U2GiIFssbMXtcA++lDizC9MNAI5P7T/CGhjYadjrWc=
X-Google-Smtp-Source: AGHT+IEW+HLKQYO1fFhqy+DCa9vHKXQAm3ABYaD8lWXBFQ6H5h6ujyMJp6R/JdkP4omppo4DAsg/Wg==
X-Received: by 2002:a92:c54e:0:b0:375:e93b:7c8c with SMTP id e9e14a558f8ab-399403c30b0mr126136105ab.12.1721737226824;
        Tue, 23 Jul 2024 05:20:26 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2820a945sm3261466b3a.74.2024.07.23.05.20.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jul 2024 05:20:26 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH v2 2/2] sched/core: Avoid unnecessary update in tg_set_cfs_bandwidth
Date: Tue, 23 Jul 2024 20:20:06 +0800
Message-Id: <20240723122006.47053-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20240723122006.47053-1-zhouchuyi@bytedance.com>
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kubernetes production environment, we have observed a high
frequency of writes to cpu.max, approximately every 2~4 seconds for each
cgroup, with the same value being written each time. This can result in
unnecessary overhead, especially on machines with a large number of CPUs
and cgroups.

This is because kubelet and runc attempt to persist resource
configurations through frequent updates with same value in this manner.
While optimizations can be made to kubelet and runc to avoid such
overhead(e.g. check the current value of cpu request/limit before writing
to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
we attempt to update with the same value.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7720d34bd71b..0cc564f45511 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9090,6 +9090,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	guard(cpus_read_lock)();
 	guard(mutex)(&cfs_constraints_mutex);
 
+	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
+		return 0;
+
 	ret = __cfs_schedulable(tg, period, quota);
 	if (ret)
 		return ret;
-- 
2.20.1


