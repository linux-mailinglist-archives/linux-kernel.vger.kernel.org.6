Return-Path: <linux-kernel+bounces-251337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828CC9303B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20C11C22616
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE211AAA5;
	Sat, 13 Jul 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="KktqahKy"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC68BEA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720846012; cv=none; b=B/07uFPmAyEQhTSBaSO3+SNGWZKYRjS0obSWl1Bz43zFHn3vbVyU6SpTYWOC09r5EOhM3mjQKpdrD4F7yG5znQXIDBgl23dzEQJc681Sc4uSfk9zIisFgffF9PZBMFZ2yDYDNoBMXbFpis5RzT874+QRkcydtFbA4bg5Es1S5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720846012; c=relaxed/simple;
	bh=yUxMoYz4CCDjOmOdnVZWwLqFwaeOCI07PUXn35dv/H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PQo+ypZZgOd4GnwJRNHU88kl3+BeUZMzUB2GVXOXPc26rxGKgZpRbrW72hFb78WHR5Ob6qYF/oVym+/SkoKJl55WJxjIIFD1EWQ4Fvsz1/NTFbVTt6cD1akCl5iITQpSSDGOGSdlzn41jpuQ3BrhxCA/PnTEY7huXiRhiLexU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=KktqahKy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1746029b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720846009; x=1721450809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ngGA87gIu2gLDykLQmgpZcotEbcUqXtVAAfGqFOqSg=;
        b=KktqahKykDOhA8ys/nhVmRxeZsWTLVnwtlMlc1VRXgSE/OWILKYlPRdGoGuBDxZr2M
         Nuuk8v2JzNt9xXxCenlsKMk0OwQOwaBD1M4JPB0OxnzTQ2JhgKbbpwEA3UsW4vKvrbqV
         XOkTlo3imNaKk5eaZKFT+351TmzDHYDO9/esRg/5/EV9UfKiRjnnK7wIHF1CrgSa1Kht
         556sHC53o5UJ4s6ydVHef+8cVZNLrqf7C5fvUPchwBmrK1+FXFZYgh9Q0AIkuEtjnZrj
         JG8hS7F0aDg7JmPH8Y2XdMfmx+Px2e2qokv66q5sOb8XtW/mUzFHNSCA9RDt+BaZ5kop
         QeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720846009; x=1721450809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ngGA87gIu2gLDykLQmgpZcotEbcUqXtVAAfGqFOqSg=;
        b=vXgdPzQ41VNe0a0gMoZDAMU0mytyJ9lozZOJfojtwAa+cndcLEXPI2tVYbCZDWILzO
         4MnjMTWdIYiKmYMEVtpIv5KHCFcmvrs4Vj7iehQbozMwGOesBNFlnmSUfoe3h397wJnO
         Tez1N+FKXBm3YGVZmv0Gow9NFe6YWNCeKPLufeUeLt7Kh8J1okMF7a8GvikEqRYupVxk
         t+mjJnir/e+8p86TOcPDYf/1DSheJijwvardh2sOMdaFP+cONgA3YFR1AwuUQ0inMqzC
         fftwwiPD+WciNfF05+14hvwcKE8tWONogiHaz2/bs4oIyNy4qtXtcBgznFNrlyMNgaBa
         729A==
X-Forwarded-Encrypted: i=1; AJvYcCV5w3Nx2i4GlPCF8uRtiSz45bV+oVXXVDkoOLtg/3SUpnmwqKRc8bDebIjSX2LOPMcX37IPIvHZzTRby+skN20iONujNevpteepSiq2
X-Gm-Message-State: AOJu0Yy8S4uc0fYFGsUCFJ6bxafl09YO5C2614LXBxxvXhzN2JzochXo
	VFIExu4HOMjOqH7fBqBblUYDTDbJqG+LK2GLXoXQZWGk+MH2M5ASIHoBciSv+g==
X-Google-Smtp-Source: AGHT+IG1InLizyBK8JWHNbJkRYA6Uea0HmsPCa6bhoVt3VeiBs0iiTknfl+THoAD5GvgweS3VdZrJw==
X-Received: by 2002:a05:6a00:4b51:b0:706:3d61:4b21 with SMTP id d2e1a72fcca58-70b6cae4c6amr6823942b3a.3.1720846008948;
        Fri, 12 Jul 2024 21:46:48 -0700 (PDT)
Received: from zhadum.home.kylehuey.com (c-71-202-124-49.hsd1.ca.comcast.net. [71.202.124.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7c5f3sm383461b3a.107.2024.07.12.21.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 21:46:48 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: khuey@kylehuey.com,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: robert@ocallahan.org,
	Joe Damato <jdamato@fastly.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	Song Liu <song@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
Date: Fri, 12 Jul 2024 21:46:45 -0700
Message-Id: <20240713044645.10840-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regressing commit is new in 6.10. It assumed that anytime event->prog
is set bpf_overflow_handler() should be invoked to execute the attached bpf
program. This assumption is false for tracing events, and as a result the
regressing commit broke bpftrace by invoking the bpf handler with garbage
inputs on overflow.

Prior to the regression the overflow handlers formed a chain (of length 0,
1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
(the tracing case) did not. Both set event->prog. The chain of overflow
handlers was replaced by a single overflow handler slot and a fixed call to
bpf_overflow_handler() when appropriate. This modifies the condition there
to include !perf_event_is_tracing(), restoring the previous behavior and
fixing bpftrace.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reported-by: Joe Damato <jdamato@fastly.com>
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
Tested-by: Kyle Huey <khuey@kylehuey.com> # bpf overflow handlers
---
 kernel/events/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..f0d7119585dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9666,6 +9666,8 @@ static inline void perf_event_free_bpf_handler(struct perf_event *event)
  * Generic event overflow handling, sampling.
  */
 
+static bool perf_event_is_tracing(struct perf_event *event);
+
 static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
@@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog &&
+	    !perf_event_is_tracing(event) &&
+	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
@@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *event)
 
 #else
 
+static inline bool perf_event_is_tracing(struct perf_event *event)
+{
+	return false;
+}
+
 static inline void perf_tp_register(void)
 {
 }
-- 
2.34.1


