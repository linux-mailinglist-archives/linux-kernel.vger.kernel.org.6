Return-Path: <linux-kernel+bounces-425767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067739DEACC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC22282679
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A81A256A;
	Fri, 29 Nov 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDBZcSBh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D11A257C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897098; cv=none; b=kDax8yEZcdkSUvtl3+Ffdr+MvIabq3gf7AWevFECDg/cFXeatZzstvQaeiCZ6G2NwX4KhacxZh7ELUlXSKaA1fk+aDu2C1evfgfHrlwWIRx8gsY4D97jsikoIDjvB5AIFQX6E7Owyyzkst3TXaUUuoA/9iskQGVCQ7/4lm5P6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897098; c=relaxed/simple;
	bh=YlkIcmm94An7lV0pkjTIvCSU74kX7a9jFjvLJ9SPrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWVeWhB+TvWfmcQT65T+o1AWu0xvLNCAGTURU3tuFbM7X7I9slmXbRAZh+xlwrXVISYZdxKlIq49REBlfIMv0hy9kKH1cmj67kulVD17wuNUNp7hy8OMakEWHmJ3rUDUNnnV6o2Z4BKxD3AhxTwsT8xfoSxXPu/+4XDjG9xRwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDBZcSBh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43494a20379so18662765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897095; x=1733501895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVXqZCMu8xwpkslZ2hg8FShI0ONQIAKRUsutZKpKVHA=;
        b=vDBZcSBhzL5P1T9IqPlk2nskgN2YARoH+HO6DIL9mM2WDbIzythqUkOAINsTkJic29
         SjyaP4kwYA9kh0TZLhPdZPE6Xx+fenjBXKzXR6EoLCKlcGLPiW406a4hIuTnuRhI5Bt0
         Hi+hdf/yiEgLScJxfzjzyXW8+YrKyLo1FbyMkA6FxVN9jK5adN/is4RJnHFRvHQuGnu/
         o23U9+JBXUWsXpPm0fYPB5yiGLMr1ptk2SQDGT2gWKbgXTLIwCBQysBZYFcUV+GyLuHV
         acS0MwJNC1E8aO2MhleSnZY0Yl2rPDCUomQVqu6uPm6nVYRo282571m/TkugxqRiv1hr
         5roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897095; x=1733501895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVXqZCMu8xwpkslZ2hg8FShI0ONQIAKRUsutZKpKVHA=;
        b=EC4HzXcSR2f46XXLXZSLnyUEE3jU5O8ixsVmCUuZNvXJQj60fTL6bCTlmlxoHBnPnP
         UAPwHeDDcfcTYOnNHtXDu1w2x4u5Qm8929NyQ5Eo77GNed6WZO/dJ7v2jPmSvgAwcLyY
         et77DKGtHz0Vp0Q4KrVfIlUqnO3WuxvmUAaBKT/LUAaxaamLfPto162D+D2NspPnNEgu
         5srCfR++CoSOiZDE8egp702b5fAVKN+gtEv5M1mcZU/VTLJId+pHtCABg3x6AyiiNdZL
         bSVbE1CyUXnD7ECMkFiSOE+cFblahQuKWcnV+1NsxWQmU3/lYpK4dIm7ziE6u+xvTBW2
         W/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUi2MZl6ej6Ff1LDv671srsd+Kj+FsSEnw+z60o6y3rieZAzMY2xhhxyn/zV5dgxtCUqH+JLEkKhPZACRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMRvjbTKK3PETZ4khuMo2xnyf1DpWAjCinq9KmIM8Ig64xrgo
	wlEz6i5cJrgD58suuwy47RidK6eu7zkbFuoDkymgRYUqVxaPRlRpVRoxf/0A104=
X-Gm-Gg: ASbGnct4axzVFVPGl/LnCdIoFHOY5DUMbfbMq8AugaImc5YagIqfKvDLtYQ57wUtL31
	rQtnXJ9zbYPvnKjP/Xf//FlN4+wAcda0bJ6Z9kvr7v9Idmv1hBzd/aGmJYhMh+Ntse+md+8xenf
	TBzwuxRfMSnKEDcMm1NvFRZ+AxqkvOwPD8LiBue9ZMMY0V/zBjuUT6cXAibfUMAXDoiX8PGz+Z1
	54F7+8RmkMJzXrLroIbTBsOdat4z/wU6PdAAcOHKV1lNOwmYj5tBbfdUDA=
X-Google-Smtp-Source: AGHT+IEA4WsTI+4NtsvW+R6TBXAs/4KeBqQkZDtbHYGltNPgZ4YcEuM2oS7x8HvfZlJiaa2HisRkGw==
X-Received: by 2002:a05:600c:154d:b0:434:a555:d0d with SMTP id 5b1f17b1804b1-434a9e0e21dmr108116145e9.29.1732897094371;
        Fri, 29 Nov 2024 08:18:14 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:13 -0800 (PST)
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
Subject: [PATCH 10/10 v2] sched/fair: Fix variable declaration position
Date: Fri, 29 Nov 2024 17:17:56 +0100
Message-ID: <20241129161756.3081386-11-vincent.guittot@linaro.org>
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

Move variable declaration at the beginning of the function

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c34874203da2..87552870958c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5632,6 +5632,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se;
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
@@ -5642,7 +5643,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		return cfs_rq->next;
 	}
 
-	struct sched_entity *se = pick_eevdf(cfs_rq);
+	se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		SCHED_WARN_ON(se->sched_delayed);
-- 
2.43.0


