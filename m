Return-Path: <linux-kernel+bounces-309745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F842966FED
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FDF1C21D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029117C216;
	Sat, 31 Aug 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXeqqu1/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89517B4E2
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087882; cv=none; b=YjvsVjzQdVhs7/raFFv13MK628vxqCFecuNIK441oTwscaWrJvO7i/dtNbUow10AyOlvNIQOnBwsyaS8w9K8wBS26Pjv3DXOoRTCfAM81cU7HFy0PnGP1CojCG8sKHnTxi0tL3CxrR7wvoK7nAVg4ngEcnuRacXp5yHnCLEJ9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087882; c=relaxed/simple;
	bh=Zzp47YpjJrlq/7aNuFnEG/sx74AzSK2oA4jiAlYD1m4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VolgSsTr29KupfMoGRD/zG1cjphz0maLU++ZdLhhFcPZinuQ+vRRsp7FlFuZF7UpHPjzxbibH6YlEc3V4k+K6XOeYemCtJTjqhhBg5hoi0TffGzBONah+xi5s5/8mJkrBPe0McvNk+bad25IbLhbsg4Pru6cxTzlMv884cMwB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXeqqu1/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4daca4a4bso12685047b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087880; x=1725692680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=YXeqqu1/T7EB5q0Xc87ElZRffeI9/OqXF2z6+sv10twgx0LlS2FzfyLNqAb7runij4
         LU/YsVB9jIQMI/tG5y8ZR/OjQWwJaue32N12goBcQxD82fTCF8hrv5a/3u4oGfnSIqoU
         yS6Yp4B/hKjft/JeJbQiAdetOLqgTqJ6IVz+/i1VOexTsqs4KCm/iXv3w7HXWKJVAzqo
         E4K/yNQy559qDdX6BkXYGBZyy/5lJSFR9FI4NU6vdWYpxyRFgoUWzvu1nQvrO/B5RspJ
         /KSM9ehFLRqMx2z8vD+rONSrlz6hUc0nGkFBcIsjtCJ3k4cK0WlKcrEeq7vj+PXaL4Kf
         WD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087880; x=1725692680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=YtYPdcpcTzMACjaBfL3SoxGTjur1HyzdOTT02rNa0Pa/bM9oSD0p3AzPVcv+n9BJ8j
         SsRLyozbKzC1C7Gwum50IV33J0SzD7XqyorB55TfY75rKwDyqOeIGf/QPrR5shyPAQVl
         KpAwWlmCq9W+1tkz9eDHwZPPmy1zrWCF8fv/braAzAr7OTEZc3kZV1B6R0qPAv36VIQU
         uRQnRFVIwukD3HEZ5PPYj2A45ZrU91oHL6e4yfObU1s61SJtTfrRGz/RqwowxJgBdRQ8
         Jwgksg73JtzK4vJ/LoiXXL3+seKCuwmSUvgntxUy20v+OwWo+6goz8d6ms/E94/szaLv
         V+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEWNx0Xw3YPSl+jEDjP/FAtt1FuceqCSU/4ms960wbfXWAv7cMH8K9XRW8XE8AgCLNnwvYAFCDM2lbVFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHApzYwxCMBLFrdluDXdyrLULBj2xCeyHdMS93GOSdn+nUbKKU
	0Ti9eyKr+pEgUVh01jFHRMHjSoGijNcWyEK+jbxwcVKJ1R389Z4aXpDHPBtpGNl//zipC4XimKO
	Cv54BIA==
X-Google-Smtp-Source: AGHT+IG1XD+JUjlCpgglYclPZZLQJ4BWz+jqR+qm5DgB0ka+M75PUfqNm5Cwbhc6EFTAGgHWlo8uxtzePXRt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:6902:281:b0:e11:757f:30af with SMTP id
 3f1490d57ef6-e1a5c85d46amr83900276.3.1725087879809; Sat, 31 Aug 2024 00:04:39
 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:15 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 6/6] perf test: Make watchpoint data 32-bits on i386
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

i386 only supports watchpoints up to size 4, 8 bytes causes extra
counts and test failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/wp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index cc8719609b19..6c178985e37f 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -20,7 +20,12 @@ do {                                            \
 	TEST_ASSERT_VAL(text, count == val);    \
 } while (0)
 
+#ifdef __i386__
+/* Only breakpoint length less-than 8 has hardware support on i386. */
+volatile u32 data1;
+#else
 volatile u64 data1;
+#endif
 volatile u8 data2[3];
 
 #ifndef __s390x__
-- 
2.46.0.469.g59c65b2a67-goog


