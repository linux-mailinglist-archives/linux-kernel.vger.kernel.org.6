Return-Path: <linux-kernel+bounces-309567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDC966CE4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC5AB22F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397519005F;
	Fri, 30 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHdxcIQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDD18E371
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060553; cv=none; b=UkWyPMdVjRwdHX7GUjaSRtfSgNEe16oUWKZBra62RnTcAE9cWt3H7AUOfnHhgnXxn/Er0rV2mfq6CCo5oA/AtMFZxqGbO0Acb+mK4TAXA+7P3GyXOcEqSulGwo6dMXOsKVXzL/4O3BG9SdhifWqTWNpgyKcQNwgjLM1tNFONN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060553; c=relaxed/simple;
	bh=4Ii+dUnPcg3T2XmEEMSdM+nVDagN9epzB1SA1hZllB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA4e3hlvzn/yeR7foiEU50TRs0p5LqM0753yZm44SQllL3u7iTB4xOr5VMhfucOGoWdeqUdWruRiPjAFq/Ait5AzjfCv5H4iBSzrsK9kZGxyj7FGpYP/Y3EkW4cTF0TdjqNbyvrzbkPJYVB4hkxgXFkB5XoMit0T7IgWDa3NvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHdxcIQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68147C4CED0;
	Fri, 30 Aug 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060552;
	bh=4Ii+dUnPcg3T2XmEEMSdM+nVDagN9epzB1SA1hZllB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHdxcIQSyj8sDVPy0zvrPbuqOj1SIuXRvBmMo9uKwkNYTAzoqTMuJxqcFPmmJFMIY
	 /S3L6onv2WToAAQyjjmSnzTc0LsPtjfyuJ6bxg5Vhh5jQiiJyTkFy5H/ciJgsRwU2N
	 zYVZWNohBgIdbuvd1ywt96hjxtCB5ec1k+ABi04otZ0WNoKcmDquA+sm4oEnaC5VXx
	 EDSDN7auI2K2OBpPn9fP3Iwoaqhkm+Z7EpOGMQfykMWoUcV6rctdm6zVL0AI+nwjmA
	 iVq/a046G9DD/Uk5WUzatN9S0KKFEBfidDFcWQiGWxE9Ky+6rIFQsyg6Ui8ks/f51S
	 z+oJz2DIOADtw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC/PATCH 2/4] perf/core: Export perf_exclude_event()
Date: Fri, 30 Aug 2024 16:29:08 -0700
Message-ID: <20240830232910.1839548-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830232910.1839548-1-namhyung@kernel.org>
References: <20240830232910.1839548-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And increase the dropped_sample count when it returns 1.  Now it can
track how many samples are dropped due to the privilege filters in
software events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 955d39543398..c93673a8d66a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1634,6 +1634,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4d72538628ee..8250e76f6335 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9978,18 +9978,21 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	perf_swevent_overflow(event, 0, data, regs);
 }
 
-static int perf_exclude_event(struct perf_event *event,
-			      struct pt_regs *regs)
+int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 1;
 
 	if (regs) {
-		if (event->attr.exclude_user && user_mode(regs))
+		if (event->attr.exclude_user && user_mode(regs)) {
+			atomic64_inc(&event->dropped_samples);
 			return 1;
+		}
 
-		if (event->attr.exclude_kernel && !user_mode(regs))
+		if (event->attr.exclude_kernel && !user_mode(regs)) {
+			atomic64_inc(&event->dropped_samples);
 			return 1;
+		}
 	}
 
 	return 0;
-- 
2.46.0.469.g59c65b2a67-goog


