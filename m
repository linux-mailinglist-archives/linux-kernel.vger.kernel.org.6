Return-Path: <linux-kernel+bounces-412812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5379D0F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332921F2255D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56391196C7C;
	Mon, 18 Nov 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkNB8kqQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA81974F4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928401; cv=none; b=NGOuC75oJcbAoK+ZHALmDZCeyBtnXbA7CmEXkEgErovCRLHU5ElGihctMk9SGK7qk+ZeCnlxq2qIzSvvpqmki7gDjce7bXcflcJTObKz2VpEn/MoPH8hGTN7I8oRg42/LJ9VZtaPhf7shEU1IB30KIFeHHhgzSvZQdddP0dM0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928401; c=relaxed/simple;
	bh=9iHeh6xMm7yXqKpv7F15RY9RJRPpGuA3RD+xeN/9V1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnPyZK6F4UEVWuPRUBVGK7jjUNStjfEIqJaHgFGEujlpH6Gwu3sRG3s0mSeLFqZTAQetsJ9UkLx1comOeGnPwjFx6ovjdz4kFOobsH0ToGP4PfAtazQ1AZYoTaCR0lWcEHM0VbGCN70jZUK2c7FdpCNGrILHis9lIp63C5OS5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkNB8kqQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbca51687so14732855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731928400; x=1732533200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgC0rexsVpW+myzPDefvL1rWG8Ceo5IoIQuTb2L+vc8=;
        b=mkNB8kqQYaEN1m2Uo3bUwGsU6fAQc/qnNHiDWGcDaUUIkEYF6kSyr43ERrJvWFWp2G
         xTSmC32pZW0rYjPZ4KG7IQ+1D1P24L7x5KDuByHUH/zvoSBJszZ2JXV45gDEIa81aS/O
         Vuaa4K4BX2sYwuz0YS8QoldeUCwHJ3vpe2ERUCeGaAy2Z27EQ5W0dD9sXQuke3qb1sPE
         w/RJp3V5pUpVlv6TmPucTY98oUw98GZMclw/kYBEysVyBjVMPwHpq0nTm3o6+xkfUJIp
         KMGiK1GorEIf/hP5/jKvFW6aZ7sESZ3aByFC63Y3FiprvEjCdI8GY5vpeE0xzOqpTYOy
         BIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928400; x=1732533200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgC0rexsVpW+myzPDefvL1rWG8Ceo5IoIQuTb2L+vc8=;
        b=V5BtbZfruGksO8v10o3LCrbNfjsQfJTFnRi8NVn6+MCxjTiuJaM9p1PtviqHbV18yx
         MCHnXq867bkDp9b/n1k7Ko52lH7BU5A/xUaLLycIsLmHKIihEJb4U3bWtaPtI0U4t47I
         MF5LTnxldJ0uA2FI1P2V8qcggnQ007l03KNyhsr6THrCbuwwXIR0BqDgMNjuGducY4hR
         tzGMAGQjJS6yWjyZnrAPwlTwofN9JhCYJQouPrG5MgORUnGb8n/QIldWm4YsGaEnUPeF
         VKDzY/M95Oo1piUlq1kUZHvBb1xr0psBQoltBCr/QACPhwtbkKHY/4BpPjHdcag94bEr
         V0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfX+Rl2IbUw3CjW/tMOXKPDtHIs9QRIbNjtYW2HWiiUj53Zl/irMVIy6x/qhhsH8p8H/xmcjwZeCWJq0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgytGswKoKsLQulHhGdJ6LXXtZUX/MXOuVewW1Cl23uYrujijt
	eX7bKMF6olUQxTkYpuLFvYfbUndb5uWKUrZ1nw0fPF3oHLxbBd0D
X-Google-Smtp-Source: AGHT+IFaUi0IjT0SgKwOFTnQHO0Wbc9G3R85hGtbV2Elwig7kzN3Rrz5trNSE9qniZ3PXeWM5JSwJA==
X-Received: by 2002:a17:903:18f:b0:20c:6bff:fc8a with SMTP id d9443c01a7336-211d0d6f2bbmr144887995ad.2.1731928399582;
        Mon, 18 Nov 2024 03:13:19 -0800 (PST)
Received: from HOME-PC ([223.185.133.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f3698esm54169435ad.130.2024.11.18.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:13:19 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH sched-next] sched/cputime: Fix unused value issue
Date: Mon, 18 Nov 2024 16:43:14 +0530
Message-Id: <20241118111314.58481-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes an unused value issue detected by Coverity
(CID 1357987). The value of utime is updated but has no use as it is
updated later on without using the stored value.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 kernel/sched/cputime.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1acd9..3dea3636a260 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -571,13 +571,9 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 * Once a task gets some ticks, the monotonicity code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
-	if (stime == 0) {
-		utime = rtime;
-		goto update;
-	}
-
-	if (utime == 0) {
-		stime = rtime;
+	if (stime == 0 || utime == 0) {
+		if (utime == 0)
+			stime = rtime;
 		goto update;
 	}
 
-- 
2.34.1


