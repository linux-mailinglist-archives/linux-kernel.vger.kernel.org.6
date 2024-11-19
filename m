Return-Path: <linux-kernel+bounces-413668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1C9D1D16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EBB283266
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211212BF24;
	Tue, 19 Nov 2024 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeBEjwDP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF312C7FD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979034; cv=none; b=XxtdRkrNG8XMfU6CL7dZzcKACPzNG1BXFrcGe893DPyozKgqPVdEbzWnqMaYG+Dy2J/Nr/uGAxp6VgTxaoyvzOsVOcQnQDGa3yF+X3oz0YGnPC70KrKIaC6aKZ0C2Z7URM3DqxW6smpd0eKlTRRXqUVw0HCl3cjYC+YKuB5+u8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979034; c=relaxed/simple;
	bh=S7D5C+bJCAzeCBN5GGs2u5xl+eAkYpdmeT4lCCcMaUQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=I6QGud9gZNXz9ugqSNqIGj9WUrynSRJEVEn3/baLFtuqhWuFS1ZlhhOl+4y3629eHh0YXlYolGUgyGtbXAwU6bq75aICwNiut5bTyTzc6dJ+1rVdqdZG7o0qn/QTv9CWbMeIzdfqEa3gy7EO7qpqivtdh2QdXYbNSRdmDRu7EG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeBEjwDP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e862eso64360217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979032; x=1732583832; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DnKYRzLOBQKhpteQUA9RyoAZyPDDZS21UzXGtb/zXA=;
        b=PeBEjwDP2QVlC/QgMOtFUZs2d0FfrktZLMm75AcSr2Vmlpm6MVz/6NVosce507R5lR
         UkWNfXCoB0HCc4tba4ucJzQs5Tf88NgV5I+6HYzqOYDJ6aJAw2EP29mVrqs/AhFMlyZJ
         I2O7DThR2djeADJUiPoI6DcXjlVbgM7HcEHOokcm3eo3ug6hSiagMhCAbZm+38NPbJkA
         vfPUxEha/nl87TCkrqXpR2RGlB+optM+TuN5J9FYu7VslYFV8rjU99OrP00hFpTAUlPV
         2q87YKsHY59QxuHhqjTQyhuB2Ricjbdka5V9dcpI/ZGLi6/MiAkie0qyE2ckOGE/ysLV
         +otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979032; x=1732583832;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DnKYRzLOBQKhpteQUA9RyoAZyPDDZS21UzXGtb/zXA=;
        b=Z7L0CxhPAjfPxNzEbwkSk/Tb0jnHmNP8B/SGoF6iiHM9xzsT5Z89Ug0QscChr9cwOF
         +2BI1lwJE4pgZPrUS0ytl9xxwZ4eyNCdQuvtWd0aA+fo5VHUQ5h4Tf40V6wHYkHzgBNf
         KrCvwCo189PNMuU37T88CBk+AwxKKjwx4lKZEfGy/VTFeB1e+AIE6N/UGGpWsCfy+tmU
         8cK+XLRdshkDMHJ+jFsn79nsk6NkcN/1gsh5jw00zVGjvkDmedFPvnZG0DSIa1LDU6Pq
         0eelVxSGUx71TyBegqBM9JhjJx60VoFdK50mQ1LIaqNX+9kSYswuNZeAM7MYoQFNOVGY
         j4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVGRzUK/I/Mroj4TjYLMWfOyobG5DFqfoMqJhLHh+eltV/vK+qLqoDEwFtERkTBlyu6bLSQlj/QG+i0P+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0nfHLMUW924vjQ4lnU2jtzMaeQDJrVHOfjXjV45lsVbHUAWK
	fDOAMQ8O4nBknOEu3AnvrnbPsL4QlFj1/OMuamcRMA9xIfu/k9aZ07M662ESUEgwEVXr7DJo+wK
	9fwMcYw==
X-Google-Smtp-Source: AGHT+IHd/+TZ9+u78b6TEoIZfyfyrMfN24E3uv7SGJBfMn+KQioUQ8Q0p8Ds6Xew41S+Veno0J/9F7rO5Vrh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6d0f:b0:6d3:e7e6:8460 with SMTP
 id 00721157ae682-6eeaa3008b1mr489367b3.1.1731979032547; Mon, 18 Nov 2024
 17:17:12 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:25 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 03/22] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e04c05612830..140437042a73 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/stat.h"
-- 
2.47.0.338.g60cca15819-goog


