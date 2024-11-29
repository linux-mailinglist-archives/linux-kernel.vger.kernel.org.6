Return-Path: <linux-kernel+bounces-425765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C229DEACA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD87282198
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049411A2C06;
	Fri, 29 Nov 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWypiMfQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A921A0B13
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897096; cv=none; b=SmmfDu0sTV/2RlrzVnbdp/fYfjtMo+zPHxvjMBBjh89fKiuMZOGuVNJCs6Q8ioYHWsN6XH06jkfttzs2UsLOFeNS9n3hwa+0AfB5xBjlN6XL9qychnU0XS8BncpjPxhM2I3ifa18fLX4mxDfYpgMpsY/FWNt6o6T/Yf97IJ0T6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897096; c=relaxed/simple;
	bh=2L3jtpLBWH0l2P8fF1Ud91ho1zHZU8g440Ir3CBglIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+4hNEHknKy9IJU5YNLjIVrPKtzvujrwOwy+ifRQncR4kP+UX2Stm761OSQO90v8t/ZrpRo92BXkWeyQJctU638O4/JqLmIJO7/jQ67ZR4K7Bq2ZcaXIIPpWsUo2TovtJ3ylth19+EfaCBCAOQhE97WQNk8XKS7taAbA4XMsPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWypiMfQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so12802865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897093; x=1733501893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt0xGTxs8yGFD5cf7awbpbZkl9MBcuva2OpmOmzmwhc=;
        b=lWypiMfQKzFo9GuP11PoWs+idFuP7uPw8gievlY2TWFWOZTC6NkEisl0JqWa7NCbjV
         Imwq8rBtxDclwwAEdaAb8ZedSP5HhQHAxf5ONyGLHjJ9IES0RpC+XNxMmhr7KLroGo84
         J9O1gcSO/gABohE0OYSQqtzHvA/xeI9as+JxsPmvpl5Lx+OPsOsZ+u475Tu1VBMTV7+l
         saIQZY2v4OZEtbdrUVjUIioB/BuU5WjYc1RNKEAdZxrRWIdkiB3N4zNUSmAFcbw6Zalh
         mpu3ruMjiTj8Ht+WaLq+U+wMvhIsxGyfmji/acL0ev7LPeeYI9jjypn1n6zVvGjku3UG
         /aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897093; x=1733501893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt0xGTxs8yGFD5cf7awbpbZkl9MBcuva2OpmOmzmwhc=;
        b=Hi0ZxISAba8/0gS3AFF//AfZKqQyEHFD4NCtvDX0MjHjLfgbKGyn+HYHj4ZojOeGYQ
         3fPA29HDJbW5lzOlEt8BNDwepfyQFr+ItDcCLOAGblcbx5tiAcK5Yv407tekYGfWIS9b
         PBDPoDE7M3yX7PSP3JNqG0nC0zTQYwRJGuLgi5r6ecU7GSw/xDBV88DVTxAUBv1DREfU
         2UMj6ejX2POUDrYl/k2kxuVV1UwcQmxBTbirAMcenIG1ahWGv+o5d2/SnyuhCSKBVsH2
         2I/9qZZ+wGHPIoRUiNy7dJ89bpybiKVuRTW1f4wxe6yW22n6jPXC91dDgZm/EbmCeTgC
         VTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEPx8P2q/it68q9HrlchiYI1f29TK6SowOfFA1n8YKZ9RjAazBkpmZ1peH0MtfdLw2lrlUfZqSmoEXUKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8/Kbn+SCH2l6OSsSyno10hHzLIvYH3VhXwj4MCu+AMwxWe0A
	xz/WmVpBVDlV8+z6sV3hUbj0WQvU7dAK5+tQMac0PIRhOHUyx+E1g9ohLp2QMTc=
X-Gm-Gg: ASbGnctGomqBimenwxudsM1mKDydShLbxO+Rn9t52bLVY5N9DcWr7+oadDaRdt+B6LL
	fXudP/TfckpZzANYfi48oexQnCZAP20DymL6lp90ugNIuTzeU+5r4/r9GwCa4NXAHSkbE3Ds4Xt
	2K6dYUsaiWmDLmfHZnTDz3FBja3G2GsiY5beTontSy4jsSt/McC8jQGX+3dJLYWnh2/9ySaSUMA
	uvk+u8Ot5l1R5XZg+CmNHEOI/DgubDJruuqD8FfZSb7GbgDjHMR/1J7N20=
X-Google-Smtp-Source: AGHT+IFkZM0c9SimgPiTFNwzQREG6A3LmuZxD0DaX6XGbSX1og3VFsEOdO90EWGOxbv70Cs6YJUgmg==
X-Received: by 2002:a05:600c:34ca:b0:431:9340:77e0 with SMTP id 5b1f17b1804b1-434afbb0f4dmr71514855e9.9.1732897092945;
        Fri, 29 Nov 2024 08:18:12 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:12 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 09/10 v2] sched/fair: Fix sched_can_stop_tick() for fair tasks
Date: Fri, 29 Nov 2024 17:17:55 +0100
Message-ID: <20241129161756.3081386-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't stop the tick of a rq if there are at least 2 tasks enqueued in
the whole hierarchy and not only at the root cfs rq.

rq->cfs.nr_queued tracks the number of sched_entity at one level
whereas rq->cfs.h_nr_enqueued tracks all enqueued tasks in the
hierarchy.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3571f91d4b0d..866a1605656c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_queued > 1)
+	if (rq->cfs.h_nr_queued > 1)
 		return false;
 
 	/*
-- 
2.43.0


