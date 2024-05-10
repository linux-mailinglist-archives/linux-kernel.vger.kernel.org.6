Return-Path: <linux-kernel+bounces-176134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA578C2A65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232B4287257
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26781481B3;
	Fri, 10 May 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSaQXoHg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DB4CB4E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368490; cv=none; b=WLXsYRN/lW/X1sxw/TBUmF/BF5mX9HG7bQTZjIdrQsU27Z5bbR5471EQJ/lr0dxHqWvq5o7RrapzTK0AGMbdZQO591PbT+DIaGssUCyhjSvEd6t2b1wvJN8U5wRQFtdsRVZaXGQKwi2A337yvDlQUchCsFJc+1jDqPQoMUb+SXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368490; c=relaxed/simple;
	bh=xySRyI8fWJdGd1hvqSCkes+7dSi689oW4NVcWrWQsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwGPnGS68GBcsj42SfYxYazY8O2nMxWR3c5c/wE441m+Ln54/QS80ytmxbmbL+NNVtyvyNGoS29jfbI0dcRJf1J1XRn0sgcl4+XJcYPbLSUwNVYaC/9GFhQw0QqNdDbBcdlnLRnYxqdiC2Le/xjV8davFvKIcN5AJb0ixNrVH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSaQXoHg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4b79115so42932957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368487; x=1715973287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=qSaQXoHgu4hfbDE/cIkZEw6Ew0LbYgFz9l7ztaGnCoT5/dLE35EIeKiLj5a8yLNN6+
         fBcboHCaDTkn0Pwms7ZPf2z6Sy1oc4t1tccnn0f+u+DbtEoM+yXIxYYCGyOlh00cFS5c
         5IC/3hUH7Dzm9dNPX57EDQJWjdwB2dY6zttQug9LitzPc9mINKmHxxfCad5j3Quwg+sZ
         4X/jliMWE99hWEPxZiXEl4L0TaEJRB7IafgD0+W7+/e8wZCFP8v5C0kvLS1DMP2j88Ly
         c9GaWsC3p5XRoRs62A1ang6NyqJhdQJWAGyBnsdj+Ftc1eXh5kQJlY+CUDfGrsCNFwMr
         7Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368487; x=1715973287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=Q7KWVLxAvI18BnUJk5AuYh6nH2JMDbTqM3JGyCP1MBXeznRhtGVQc47/x+T0BbCFCE
         wkL4N3FjHxtD1+p88oY7kJah0oS+PhUvTlPMnD1Ds/vokIz6JjkvEPXnoydIi8qK5Yqp
         aDctU2Y1VPaCoFvdj1/d/xoCQ33Dejx76mTA05qomyCTFAuPN2z0cCO7nSGvsyuisSng
         QTUPqcDSbCjPoD4Xhki/zUqwGGnibYGbSVAZjbNDqpqPNrrahopoCoB6bKQE8QkvYoNM
         aoYdc6rzizzl2ug8Y0y6JTycS/1nnayEzPgst7AzyLRrigMasN7+EDl/9dT0NXVekvAu
         8F4w==
X-Forwarded-Encrypted: i=1; AJvYcCV4HSFpSTHqzjTSETBzfDwcILi3hJoa0yeqLnglJBW6Tu0HvEKP4bkTx8/j2cI/K3dlZ3cESuT1xFbSi7eobfAJuluRTZe2iSN1LYYb
X-Gm-Message-State: AOJu0YwfOg9J5VhcPxl4VKR68gWkTU4/C42w9N2JeZ67mVmxbTjS8ul+
	0CYfqlbP/IfQBdOoeFm5mpYFQbzy84tF9kbhF9rRqew4iXWAwliZmrAg+UAs3EKZXFhcdSV8wwh
	L
X-Google-Smtp-Source: AGHT+IFbibY3ioQqzSPpipnTS4oiCEdHlz4wSzLfk21TQTFTF9AEOsn9D0hZruEjBe8PV6hrEYBa6K6kD8c=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:d3a5:c745:caa1:83ed])
 (user=yabinc job=sendgmr) by 2002:a05:690c:3512:b0:61b:e6a7:e697 with SMTP id
 00721157ae682-622b00380d6mr9399547b3.9.1715368486960; Fri, 10 May 2024
 12:14:46 -0700 (PDT)
Date: Fri, 10 May 2024 12:14:22 -0700
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510191423.2297538-3-yabinc@google.com>
Subject: [PATCH v4 2/3] perf/core: Check sample_type in perf_sample_save_callchain
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


