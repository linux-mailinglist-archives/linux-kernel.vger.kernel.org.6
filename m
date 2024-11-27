Return-Path: <linux-kernel+bounces-423072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC049DA264
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE502B247CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E2146580;
	Wed, 27 Nov 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP7a7rFP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D1F9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689489; cv=none; b=MM6g86hSqu5/EWsByO36V8FVptLkvl313DSLoUlxMGHzg1YBTd77aJYUhhz27T5ckkJkH+rAdL6AG7yZkww16k0pYN2st3bh6EX0WDPSgD/URjc3k3x8psS7yubeoZ2D8MgzBgo6wlZsEX9aCXLQ8CzNAKm9/V0RP7nVoqZapmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689489; c=relaxed/simple;
	bh=dGtP0OFWPFMzdrmrsHo4j1Z7kYCtxwor60WjBaEEkak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5DnuheSrrxIPYswsisxODP/f7dplB8JoSHg+FuDt3z5H1sUu6lAYmLiN5swShnLkBVRJ9lspusSydM3nGz93JRN7ca4HCi4JrCZeInCz6Fl6J27O3VtQDqZM2cW5mH6Zu4ifSJFFcATX6zmpZ7oPy+X1UdDNMsstFbMJAWPIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP7a7rFP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G+YCBL5Fbtu9FqPpXsCFPCj+WxNq+b6w4EIVlKRXk0U=;
	b=fP7a7rFP5Nj4iomBPUz6ZJWf6krBj4412+oaZBP3dD7cKdBq8PortDN9GVHhb/MPGSW8XS
	jnk71jNrG4/O7LqNcMJvqrge5vauXpWCG0/SOCZ/D13YF9lze4oKOmLBBRiZeFRJK9rALP
	uH7rv5EyBuFD2KSs33765/fN8uMcoeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-7wWaZVxBN9eHQ7iTXZHc1g-1; Wed, 27 Nov 2024 01:38:05 -0500
X-MC-Unique: 7wWaZVxBN9eHQ7iTXZHc1g-1
X-Mimecast-MFC-AGG-ID: 7wWaZVxBN9eHQ7iTXZHc1g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a6483514so13252375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689484; x=1733294284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+YCBL5Fbtu9FqPpXsCFPCj+WxNq+b6w4EIVlKRXk0U=;
        b=N6s4jCiKcB45T7YQZfHVYLx1AwjLIJNXCoPKWOx9Haj5Z4lPt9n8lFk2MqrhzQY/10
         784j8dMZrOyPBPkOUbPRY1dRum86ieOibX/10HJCyZ0nt0iyNNWaWP6cw1RaLwy9YuGf
         JkL43zp2VEPcYSSDA9qRZGhCp3cbCPLWxTTn0bpSoG2WWssr1KZnRAh2+j93QTwBnoQf
         YBwsg3FAJVTdMtU+rxzh4zX5RQx+pFOJo8iSVIKY4AK+K2AYwHT6Yh2NfMhdKZeLSVFp
         H9GNk0wDTZRvXqcVr9/pG8ZsSrrEnhmLVIDP1yogcFIRJ3CnrzvNsi/kJP7yYFDhwKbS
         BWAA==
X-Gm-Message-State: AOJu0Yybrn4zmKSMfnA9aEwY1uINDxxiq8i8yFKbsv2TVXtUItoX2qtk
	Z6yVQeApgfi6bLx1hEqMsUNGDsffnF4n9sn5pplni0K12oKlvmSoLJR6FnZ26w3OehZNOrZS8IO
	4UMXbZVjRiXPEyqel3+JsQfJdXv+daBrdz+iE4WRxUWzj7QzNl3bt/URzHH475A==
X-Gm-Gg: ASbGncvrCWD/AgcTUV8ndcxKu0RVs4I4IKkVuEqSHSbe3oQBCz9EaMWdUShgoeNSAyw
	tgLIfwGBRWlQgC987rRnszr4Q6GT80O7Ri/reZX0Hx3MjjsUTiC2w13V3qeWpxDR51IhKkhg6wv
	XCcbEQR1AEwaSNawwuRbPoe3/cAiPASWwdyUPa802j9bkmI6lJxqqxmSm46aR0qqh6M3AD9+kST
	7jRmicdgtDvhMdB9VFyiRIWIBtHidUfkvSSAC9cdfoGfsWrfPC9YsRQhDMQC1KYYXNBY64/J/va
	8m8=
X-Received: by 2002:a05:6000:1fac:b0:382:4926:98fa with SMTP id ffacd0b85a97d-385c6eddc05mr1380232f8f.40.1732689484217;
        Tue, 26 Nov 2024 22:38:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYKQMJPg1pK+Yv9OE2yE9UfK7AcAnlLcZVCkycjl/FISYqlhmKJ2bvx8Wr13qgtwDOSA3c1g==
X-Received: by 2002:a05:6000:1fac:b0:382:4926:98fa with SMTP id ffacd0b85a97d-385c6eddc05mr1380217f8f.40.1732689483910;
        Tue, 26 Nov 2024 22:38:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedebfsm15403742f8f.100.2024.11.26.22.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:38:03 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Fix replenish_dl_new_period dl_server condition
Date: Wed, 27 Nov 2024 07:37:40 +0100
Message-ID: <20241127063740.8278-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition in replenish_dl_new_period() that checks if a reservation
(dl_server) is deferred and is not handling a starvation case is
obviously wrong.

Fix it.

Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..206691d35b7d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -781,7 +781,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	 * If it is a deferred reservation, and the server
 	 * is not handling an starvation case, defer it.
 	 */
-	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+	if (dl_se->dl_defer && !dl_se->dl_defer_running) {
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
-- 
2.47.0


