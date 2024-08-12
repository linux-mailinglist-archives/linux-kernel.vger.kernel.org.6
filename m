Return-Path: <linux-kernel+bounces-283123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C562594ED7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4A3B22E39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF217C20F;
	Mon, 12 Aug 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jp28N/u3"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326817C7A2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467466; cv=none; b=H8uCFBjVXVpaBoy6nUaC6wkG8N8LbV3cikzAmQdYGWp+pX7+CXNjweWYiCBrhTUrV9Kv7pRiOqbaeMpu6cV471OTGiAKSa8Mh7i7tEk5gutmCbIOvwdj4HQMiXa2aVSgtmePldKc4zs4m1QRfpvB0FlEOr8mvmEgCaQVQFuqV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467466; c=relaxed/simple;
	bh=h81+Cf/FoIZArgzM6U1M000nT8tJrt3BvAa1EBt9mlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La1se7wWqrBKqnaapW2Q9cxl7Md6Lu2XFA4bjwnYuCSAdWnBZ8dRM3hTr4wCvjoMgzPhYzV8Zez6+D5SSIfWZ/Q6DoUHtrNKfM8RN/k5u1QoQ4m7g1UxyqRgHhk0jBn3CMhXdaFov1lvGzF6PB08OYwipSA+8l/3fdTR9ykBZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jp28N/u3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2644815a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467464; x=1724072264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwsD6mRq8PotE0EC67/Ywu4UmR2u6X+2YPXiDZOTRo=;
        b=jp28N/u3NsM2SHHQWhp0prleYeBYN456Y5vtCJGXJsODa2wRvkc/GACe5npFY82/24
         0z9IiZYZ25fRU06QqMDLYwhNtQq0wi2eztCvSmMTm6mxJCJQlq4+d6gJrlhSxs2nMI8L
         vj/kzobj4cWizYOE9QJ4WZfDtuNe/U5VRZ8tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467464; x=1724072264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdwsD6mRq8PotE0EC67/Ywu4UmR2u6X+2YPXiDZOTRo=;
        b=gTYgkjTwRQ0mih1nEqTH/+HyYkgXv8J05p78er/J3jGDWsof8FdbksDgB9nLCe06hR
         wKZ1h65Im5ebk2yITXICtDW2dGV8P5/P/bD56jBk0LGqosMnPV9zpCjLDRDbZ8fqWJ/K
         zVZnxMwyhldX+54OpU/qBGMFgTaPhyVN3zR5CG2urAqLJDnhVRfjWph3Jhe6WDeIkHIm
         1Go5qRlj+NsbagEBUSuo7UTnBt6UUCo53BVJjlSkk6Llbt+aVqmXLk99rHt5Hktn0OFd
         KmedPT7lpdvFM72VPZw8hIzGUvb4fkESrQ5Z8I9IAlk1De2UEzrZPBeGO4xS1ZuUMDzn
         060Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQUWFa5pBM/Momrq2/HqEl4c8kzsOnFMKbcHmUHa66Cty8swtl7C0gbkR/B/uNzgDbmPAlY5tekajCEIqkcR1Ab98CkL7Nx9xelA2b
X-Gm-Message-State: AOJu0YxT54BgcfZGQVINew95e7QQo6JcRea8fF538oDwjTp/mwn9J6xr
	QZCBGxo3DN1k3kotLdOUs0McPQPW6zH3MEGPZ7Pt60LxC45zVOLBZjRVNgUprtM=
X-Google-Smtp-Source: AGHT+IHrTHT2rsvnZv/5M1nDOg/Mw5GaQZCHX9VDi3Sxjxr2CexacVo7Wrdip4TS79zOg2LzcHRmsA==
X-Received: by 2002:a17:90b:350c:b0:2c9:64fb:1c7e with SMTP id 98e67ed59e1d1-2d39250f830mr128288a91.14.1723467464066;
        Mon, 12 Aug 2024 05:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:43 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/5] net: Suspend softirq when prefer_busy_poll is set
Date: Mon, 12 Aug 2024 12:57:05 +0000
Message-Id: <20240812125717.413108-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout sysfs is nonzero, this timeout is used to defer
softirq scheduling, potentially longer than gro_flush_timeout. This can
be used to effectively suspend softirq processing during the time it
takes for an application to process data and return to the next
busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 net/core/dev.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index bf45c90aebcd..a19470253eb4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6214,7 +6214,6 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 {
 	unsigned long flags, val, new, timeout = 0;
 	bool ret = true;
-
 	/*
 	 * 1) Don't let napi dequeue from the cpu poll list
 	 *    just in case its running on a different cpu.
@@ -6230,7 +6229,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = READ_ONCE(n->dev->gro_flush_timeout);
 		n->defer_hard_irqs_count = READ_ONCE(n->dev->napi_defer_hard_irqs);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = READ_ONCE(n->dev->irq_suspend_timeout);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = READ_ONCE(n->dev->gro_flush_timeout);
 		if (timeout)
@@ -6349,7 +6353,6 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bool skip_schedule = false;
 	unsigned long timeout;
 	int rc;
-
 	/* Busy polling means there is a high chance device driver hard irq
 	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
 	 * set in napi_schedule_prep().
@@ -6366,9 +6369,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = READ_ONCE(napi->dev->irq_suspend_timeout);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
+			if (napi->defer_hard_irqs_count)
+				timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


