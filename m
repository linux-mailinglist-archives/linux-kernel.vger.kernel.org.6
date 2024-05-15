Return-Path: <linux-kernel+bounces-180320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1078C6CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8271F233B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92F15B11F;
	Wed, 15 May 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqcJeDG4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516515B0F2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801793; cv=none; b=aLhbIJM72gchqDmJMepD0S0LvzTxwr5Xl/Ib9aC7jFSvxxut5L1WvyXEV65XZP6lRGt6008VhqJOeIm5H62Flyvqr6EfTIB3peVC/h10fOyyRpdqXcprxHQZQsuDhu0HeP7pr5S/ahaWIpfCB6t3ZRvc5eOMjPgF2uAIpVHavCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801793; c=relaxed/simple;
	bh=0lSt7QVBUAdOGQGjlbIPqXYDj232a+VWY9UlJ/ZrpNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggU3oCNLp44jFJ0Yw9dYeF4fROpflXv6yOUw5j3C0opgkr91XUhd9Qvcoc86pnZNei+diBznTixK6PQDUkPuUSJWJfyJuf0RFddPUMBvK3bgFmwfraMuvSnrDQhismDZX2SW+MgzLuseND3REggOHmf1mVy1pQcBNcJ43Wb2VqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqcJeDG4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so12202303276.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801791; x=1716406591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=nqcJeDG4VS51tGH0eNlWJoGayc4RrT+yo5IBujXLTc4nPTLlc2J4p0MMFR32Z7lSaz
         ppcz2KvOuj7LrhOsRg55PtbeID9JycUPJ3eBGVK/tNGq4VucWozqkxdSfOLbbpO17prQ
         sWuIwN/jjBE0ZVMEaXfgWjGSIq9S/BjpTOsyJ0pFRhip7B5v0uD4dEKyeFnTS0D5n18u
         ZOtkM/+FANKK4yv6kaJytaB+sGQZ0xeirNUOBMRqpsASkfeSJfn3MyxcKjiA2GpNJCoe
         VYBzMiX3v+wqmc/4Hv15pHNVBYWLdjNPr+sHBe+DMe/BXRA9qH02YVCEQXwRfaEcAhmy
         sgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801791; x=1716406591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmXNn2pYx8wzd3I64r7rBzQTUUgwVUdbiBLIDfo5/M=;
        b=LZaYHLDo3myNlfw70OOkkypmDJhtemvxM9KNoLqz8O9BN0zmXKmEFjYWXht1xT7ke/
         v3Bo2r3ejMQ1OUbc3gPCuq2PoOfhWF/hStxTo828Saw7t7SWYfOa7bncOdh+wmD6M5CO
         gc9DQ9gjU1t4h9VU0v+oMCaxH9mVmXdg79Hippk+Wxx88oVshQt8QYJtNJnxwnoJAkED
         zAuP6llICULGEaLBMNwpZWkLu+mNOnk4d4VW4T9jACKEhE12tpGEGZN0KMltlKCSzjKN
         AYQtnIspiEe+7L1DHHO6uPetW7rxCv4ctAOIVATNyw7kJ1UMO2qrnMchCYpwVqQPGHNZ
         PgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLgIjeKHUzj+E7LFGyKmvrBxT31cQJWA0+hHPm0RP1g4ZtQF9apXN6ptIkK1dXugEvLjBc439VFTBrIkrw1oEZS5mBzArh82uXStJf
X-Gm-Message-State: AOJu0Yx/uUsLPQ5ZzcW4o1t5RZibpilvYey+VFWVUv4U1lEtS5SPN/6W
	tdPXEfZNhANCF6uR+g/zRlKQf+hdHoA5BxEfkKSXCJdsUmzhP7yG1Hk/T4Ipq/AUH6K+FKk+45b
	R
X-Google-Smtp-Source: AGHT+IGytyoLkOH431aR7mF4/3pxrMXnoPzF9EPSCOORKbwwc0MQGbSUWr23nIhRDL3iPMPF3Uv+te+uzcs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:6902:2b83:b0:de5:2ce1:b62d with SMTP id
 3f1490d57ef6-dee4f4bfba9mr1543914276.10.1715801790944; Wed, 15 May 2024
 12:36:30 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:08 -0700
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-3-yabinc@google.com>
Subject: [PATCH v5 2/3] perf/core: Check sample_type in perf_sample_save_callchain
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_callchain() to prevent
saving callchain data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/ibs.c  | 3 +--
 arch/x86/events/intel/ds.c | 6 ++----
 include/linux/perf_event.h | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c3a2f6f57770..f02939655b2a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1129,8 +1129,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(&data, event, iregs);
+	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfed8417..c2b5585aa6d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1655,8 +1655,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1823,8 +1822,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fefac1a57b56..bda066c33120 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1235,6 +1235,11 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


