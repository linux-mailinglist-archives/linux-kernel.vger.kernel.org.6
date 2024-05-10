Return-Path: <linux-kernel+bounces-175092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D78C1A36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006AD1C23272
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21FEAC7;
	Fri, 10 May 2024 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTKTDe4E"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78ADDBC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299521; cv=none; b=Khhg2Pq51NiToAM0Xnbu6E9yfLuVZgD1dXTg/diONZOodx66Zjps1Qa/lWwjzAZzSValEQWE/QFv8Zhouqy7o9qhlSCyGEvD2yNbHqnm5j3DvrjfrPefNydlMmw0VRXgvSBPWtl+6aTvcIgWLPjriLrGQyrABiDRFjB9YpRFHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299521; c=relaxed/simple;
	bh=xySRyI8fWJdGd1hvqSCkes+7dSi689oW4NVcWrWQsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j92DMkqgw3iDeALrMj7QZt6ig8nZ4fvK3qck2M+NX+3rNePEUVugD+GtbHPaBs63P0aNM77E4r6ftrJNvTp074MXwcCrABgnmb//NDwqlqoLtv08Hm5nGU3cWpeUv4Qb8YgGeT/+YF5+Kq8tJnTEIn3LAok+rZgIbUMqIQI5DtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTKTDe4E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so3234801276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299519; x=1715904319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=XTKTDe4EPTurS2SKwFqR7PkVU3LvxxYAbu/dK4qgaLimIGi2uGhPId6QkW30uWPen3
         izqk7FUkKf2Gq4X2wtdBXyH/vbBFMKgNSaJa5Zw49q8TW4DlJBynlm2vXPq9IdVLGKBc
         7An7SPQCVRcLD/VqCM6IpkfwRrKk/ijzi6/AixbBxj/HwfcqlZWs/I0E0tw2HVizMQ7k
         sqI3blZk+9HtGCE5vOxzOZKJrWb65kq/qODReAEjTYyDbBnSg61200N+Z1y80NKxdcLM
         w0CKwOkq63Jgkde3Jn2XyUS7ORgQrYPXSZyywLwJjnzmiWvnOcVOltG9khL+h0gP+asz
         uj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299519; x=1715904319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=sVhA94RA2ToMhxWUI+xmhYpvJd3Ts1iVU8up+wG1nSeu1fJMZBPrtSmNdn1qD0V1x1
         18pe+H3rm6tfTwNmSoHwQTjSaSEynfUPfLtOsgs0rASWBzlGevp2nrWCN/YLQYleT6zM
         ofT7c2ut/PBp8khx9EH1CaiAfcqo3PLkOBygzjgQmN+GAb/JFiDmsdREycp4S45eie0h
         kEAbnSs2kSyNWsyAXAwikbqEJ1F0mxmtczOBVLA6pumZGl02JvBqST4uXyfGtftqkc6S
         Edhe3LQsPQV3+CNeO+sKBKLjNilXBJJFCCxiCYdm6O1G2MPeXfn/pCNvvp/x/GR7UmLL
         VdCA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcnhy3n/SjLjN8PYyVO/3WY8wzUS6pDXdT5cXNuD1B/dYMu3qx3rXZNDXyskWmLzJJwXIOKc82Oo7SA/13xJ7gpNTdfXNscN0llcG
X-Gm-Message-State: AOJu0Yzuae7pXnPOwYP5vzvDB9fw74kWMzZweWzwIwa+W+u50MZpokfB
	fBtbXL8TY/2PKjed2K3BbctR1QifUUQh3CCpb03OtPJBPiiqYS5lwszQQbc16J4ZNM9hJtFv96W
	s
X-Google-Smtp-Source: AGHT+IF498/68RpmB4z9MHx6KskdlnzgbG1TZRc9f+jHckfKoi5UxYsNcH8Irswv450KU0mFxHjOCG/IrhI=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:6902:2b03:b0:dd9:20c1:85b6 with SMTP id
 3f1490d57ef6-dee4e48f302mr379961276.2.1715299518995; Thu, 09 May 2024
 17:05:18 -0700 (PDT)
Date: Thu,  9 May 2024 17:05:01 -0700
In-Reply-To: <20240510000502.1257463-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000502.1257463-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-3-yabinc@google.com>
Subject: [PATCH v3 2/3] perf: core: Check sample_type in perf_sample_save_callchain
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
 include/linux/perf_event.h | 3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 9fc55193ff99..8617815456b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1232,6 +1232,9 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.118.g7fe29c98d7-goog


