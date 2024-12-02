Return-Path: <linux-kernel+bounces-427243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA09DFE88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE36281C89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915751FCD14;
	Mon,  2 Dec 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebT/ZFkX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2621FC7D1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134434; cv=none; b=N/8FuVJKl1ffcB/GeOBB3u8pGKGNyh7AN03ufuaTWy/zzDeQtDHLxH9loQGMSyc3bp4ie7BacNJPeAh0d3IqHuciW9KeyAMxmjEyOUroP+Nv9yt0JAUT9HCwhfYBlFcwG82xN9vsgDe5ZisrHxNkudPBQO8x4fzmqs1ZEgwDqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134434; c=relaxed/simple;
	bh=Nr+OTNG4k5iT+j0RvjuD1Z/ctc/Yl11P4vyMX+7bcIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3sIaNIQRRIb7SaJ3FejVGuWMUDJKIcnOkaqIPvZQqkfhlJRrpZr2y0PCOnAxABuPUFOapPusByJWsTJqQlYLfLBdyoN0c0QBJDsR4YFcW16mhMrSdd5WrZMTts+VosKLy8zXSUjt++WCfiClL7P2rXaPs3KqBqzmLwPoySYrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebT/ZFkX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so1090938a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733134432; x=1733739232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dgcub6nlBxwIuh/u7SOdCZprGRUzEEkxtj3Zg6FN9I=;
        b=ebT/ZFkX2JQi5AyPYQwWZ49T63oWsWirvS65NC0c3cDv86m6WWAi/R0FjMdaUVYi+3
         B7qSnRY1ONhbTfY7fnQRqICfv9+ncbyvF+xSewhniRwngUKWAVOnHM+00sUVLqJHn5nj
         boSOsbWIsJs1GYxeb3rf5aEVHInrYSrq2haHXxgXD3yGnh2Al8WWssB9YQjntEkOmPoo
         yIqMn6P+rdb7lBRwTQLCS5C2hO3jF4Kyx2D0SVvv4/OFzWJqQlBgR5EsZfnn0K7NdbGo
         h2v/RQEiWUgTyXgC2K46hQOTUE/kdFImLMOfWs9RqV+W6ljS5z0YElLkfevZyKTAtQZO
         FsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134432; x=1733739232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dgcub6nlBxwIuh/u7SOdCZprGRUzEEkxtj3Zg6FN9I=;
        b=ILGE9UCgwJCvKcp2AbTbweZQ5imyX6Rbpayyi+DWUfKKD7pGd9XHtqkm7hYiolIWYK
         IVK4VZejk8gWjTJFXpXe87kPL4q+PPYymmfIvC2ZCDbeROT6OT0lux+gUk/ULWeJRfL0
         CY9CqDius/bFIsjhxtaRG3SA/7iS+OaUFOjqD/8pzZ5ToDqxxtwYANXYmxL5I9dY28/z
         7u47M5+YSY6BotN3LjddBnWQjLrCY+BVg5idgC9EPf7PX4so3JkKNuikvtz+1rSvUfph
         qTUwlURVmIQcGc+Iq3IUJhh2Dk5llN8W+D5d0qJ7gA6Qf/7BqAkgTObQdSZ7vZ19TjJI
         w2RA==
X-Forwarded-Encrypted: i=1; AJvYcCWp+dTTbobECLdFUq3fKakepByrUuQ6ufJv9e+6libu03lsIxlyB31skt/pI0OfDx+kroU24n7Yz+6hL+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw994EMfqcwh5WT9mTpDBrNT+217A8RWZTR5dUoe4wcZCGe7awA
	nhELO1DM6XMtulADgI/lFC/yca7WuR+gzWwR6Su9vKeBMjPgUzPV
X-Gm-Gg: ASbGncsGJA/+xdAgblygLeFqrlMPzawq5NCDdB4xTPqgo0r46FA2GqRCkIGePzP+H4s
	k5vgpMTBuD3flHX7/6tqEKeIDZHYzk1xQZW+YAAPSdli1YTiT5ptrUKSutt5kud/6CF8U4Bs+AK
	vWe14sHyv6J0saQe+nmronBfNrTmj3Ky4Gmfo3rRex/T2jlteoQ5t6diTEG2+kyV02jS2HrcvuR
	3e2trFFLHUqpccyAqfyuNW8cuax0kf8dG+0qHbI6sB1A2848i9QFK9YBoUDGhUX1srLyw==
X-Google-Smtp-Source: AGHT+IEM5BINHGNiB2zmclPkXMP5IVfgovBK5iGLUW5m7BrB0szOilQQY/bVvLAqZ5QozZtU5RJvkw==
X-Received: by 2002:a05:6a21:789a:b0:1d9:1af6:94ba with SMTP id adf61e73a8af0-1e0e0ac5f8cmr32154338637.14.1733134431869;
        Mon, 02 Dec 2024 02:13:51 -0800 (PST)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:3e54:ee47:354b:12ba])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbf47sm8323380b3a.128.2024.12.02.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:13:51 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] sched: Fix integer overflow issue of cpu weight delta
Date: Mon,  2 Dec 2024 18:13:44 +0800
Message-ID: <20241202101344.97081-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the original calculation of "cpu_weight_nice_read_s64()", the type of
"delta" is set as "int", while "weight" is of type "unsigned long". the
actual difference between "sched_prio_to_weight[prio]" and "weight"
could go beyond the limit of integer when "weight" is large enough.

For example if "weight" is "2147555403" or larger, the correct "prio"
should be "1", however, in the origin implementation , the result will
be "2" due to integer overflow problem, because "71755 - 2147555403 =
-2147483648", which is exactly the minimum value of integer, the macro
"abs()" won't be able to generate an "int" value with "2147483648".

Obviously, for all the weight larger than "sched_prio_to_weight[0]", the
"prio" result should be "1".

Change the type of "last_delta" and "delta" to "long" can solve the
issue.

I think there's one point to concern, do we have a fixed range of
"tg_weight()" ? if it can go beyond "2147555403", than I think this is
worth to be fixed.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..be52a2fff1e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9917,8 +9917,8 @@ static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
 	unsigned long weight = tg_weight(css_tg(css));
-	int last_delta = INT_MAX;
-	int prio, delta;
+	long last_delta = LONG_MAX, delta;
+	int prio;
 
 	/* find the closest nice value to the current weight */
 	for (prio = 0; prio < ARRAY_SIZE(sched_prio_to_weight); prio++) {
-- 
2.43.0


