Return-Path: <linux-kernel+bounces-445576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35E9F17D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81E8164684
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7551EE026;
	Fri, 13 Dec 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvTYisBc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DC1EBA0B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123892; cv=none; b=oHzFbLqI/LtsBEUISW0jfkKnjCRpoNTRd4mGhlr6BpxcumRpPvpWdM4b93fRaYvfhlCWWOL84Rij0MJNF7RRG/ANO052tB0zykSsKxdwBxnn3/r6eXZVlRKfswpjeGVMAN9JiIFlQVcPgF2gV9/W0kLppo+PkAgfebfVuVDt6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123892; c=relaxed/simple;
	bh=mEVKQkxWRXJdiQoRyQuxChdbGiNav5HSCWY6DgzLwTc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OVRFBbbSVqzHdiu+XEs4ricpioCQV3nSXgn8Ity1w0FL/8Fm4xTpUBiMIRWBP3XUeoHzpnrj0ELzNOrfG55Yu9bmcI8BciJ3Xz5M5IBp6RqM1r0s+m9zww5x28Il/tVe8y//CzfmS7KBFFfOuSSxKfEEEUsLnogiFZfuezc5/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvTYisBc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef7c67eeb8so26859117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123890; x=1734728690; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJDiQRFCSz2pV8y7FxqzQDhy9JPoVRfT99ZbYeMgH0I=;
        b=qvTYisBcnfvpD/6+tR+dI7nxRScD5uSVyt9vrYXk0zc5UXaHZ4/JGVG0FYaNQAJGA1
         3z2bQQY1X9DpjuwAl/72Q/xy5dWPaDtCDe4eJLQozNZ5j0vqyXulVl02WgvJtB3yE4FV
         DvDmAgRvICpvsJcsxrQzq3sjPzV6+I7Ni3Ex1e97CGiFhCTw3Y/GGoX7MiCwckiUTwM1
         0WO5F7GJz9+PLL9jsNoAjPW2i5viRN9hG/V8LEH97yIUJuPdCGtT3R3pTM84ScCG8yS5
         kBfBC6SaZfm80pszmVWqQX/jDtCWPIxwQwBrmmgKwxs5xyeQbQUUza26gIoKpf/Y63uE
         aOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123890; x=1734728690;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJDiQRFCSz2pV8y7FxqzQDhy9JPoVRfT99ZbYeMgH0I=;
        b=vGuH9VsGpIh2ph7Z0GruotOQJSH34mF0XxdPhXlSBmVQtbAbu97jxIkhVL99OrY8qR
         m0unh385S1BVeCmw80pdWClj0TQefGKVFG6GNRCNs7LU0QvQU7qoGgY8961Nt94vF9jX
         gOHG4pc0Ie6rKpFps+r7CpjDQkKKbiCEM7E8+ZJbQBbjvaDuxJkwXohmRNXegIGZVo0t
         aNkiEvO+jY09xWKordO9cfZDunQq5YyA9XK1lZkRwU/8dS8/CiWbc0o3iinzZzUieBMZ
         nNK5ty8wE4QahD3JmSTvEWPiD7oekPb7bVr0DU7etipcOJhd7vERvQneHs9Ps0/N0tkp
         uAOA==
X-Forwarded-Encrypted: i=1; AJvYcCUxgWjgjqs2C72bKv8PpS86uNSVW9v11tYun4Qt6sM1nm50edIByl9h3IcRZL8IJCxiPf2AjQqDBk1i320=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsVuvHiU5PEH/kL6U5YWKWF8TcGzRvdI/9XOOMbeHLYy1yQdq
	xZ4gP26BfCFRv5UpyTqJq6obkCHg1cQgAfSfcI6VqIB4mWtt0ZYrFzroFE7/ZSTO3HT+ZFHq+hx
	LaIdiOw==
X-Google-Smtp-Source: AGHT+IHs+WAfXli6hbB79/PjfvyzF4H7kHc4JY48mxpcyZssQCRvhWFB5cQ1OWLUaDs/bXboaKHIfiq3EJXP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:245:b0:6ef:e0ce:df9f with SMTP id
 00721157ae682-6f279b74b43mr118527b3.4.1734123889783; Fri, 13 Dec 2024
 13:04:49 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:25 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 8/8] libperf event: Ensure tracing data is multiple of 8 sized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf's synthetic-events.c will ensure 8-byte alignment of tracing
data, writing it after a perf_record_header_tracing_data event. Add
padding to struct perf_record_header_tracing_data to make it 16-byte
rather than 12-byte sized.

Fixes: 055c67ed3988 ("perf tools: Move event synthesizing routines to separate .c file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d914..32b75c0326c9 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -291,6 +291,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
-- 
2.47.1.613.gc27f4b7a9f-goog


