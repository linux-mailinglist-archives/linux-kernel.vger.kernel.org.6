Return-Path: <linux-kernel+bounces-539556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEDAA4A5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2063189C2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB21DF268;
	Fri, 28 Feb 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1wq6nRt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8261DEFE6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781438; cv=none; b=OneygU8MapOJnRn2B9MdTXa4R/sVfAwkEITrCTH/VqiLN8mEKCsXvDMl6g+soN64o5QxKvGPVyvgKtME8x87s9gmgIE2WLXQMcI0usUv6UkbwLgVo6rEUScWd7EUO5pSQi8/c2dpVCJmZwtTDqoW7HQ1C5sG0fWOtzjqToVFMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781438; c=relaxed/simple;
	bh=jw2JvCMwh40S1sqr4HtAsdcBJhtA5W1IjdOGgQVIXGU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=LhFuaxxxrCvivttA2cUDWh69c7bOm05zgqZ8PdmfBuHQ7Gsuo0R86tYISQ8G9w4Q3xFWepiwVmF632GqqBYE0Z95gGUB8sphy8ZXY206KaoWpQ5isiF67g5yRoWsNS/DE8gxWVOqLGl8hBzrSGZlLRX1bfxtaEsKRMa+KxCPqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1wq6nRt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2bdb560ecso37496087b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781435; x=1741386235; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=deGH2VjmLT83Kk+l97C6+20x9ip/iQR0QehEJSDELbI=;
        b=z1wq6nRtNA9tyaDFtU95Xm6NvOZ/3VfqHXJVgl/GIcv4N6UNZPeFJNfWlfkO6uiyuI
         aEiIWtCHHO38azHEwAa8JMjPU6TqcOzi138EsoVWikJR94uaynb08ZT2nF38eX0QptZx
         hBEVl0OiIKvOsFJQx/sI3NaBSxPkxKAFiTiEvuyEXt3awMSAmrd8BviudIiE/4cfYjV9
         IUGM+g3UDh8fFRtlLxF65WZK6LhJsh+PIxJ8Y3BJ6stoD9//FPrBgy/3eUl5sydqXt+R
         XctqMJVdn22Rj2ptqtDWxuECEjp6ayYv7J6yURYUlz1WnQAY4jXezzuV8aAgG88s5vd3
         Iybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781435; x=1741386235;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deGH2VjmLT83Kk+l97C6+20x9ip/iQR0QehEJSDELbI=;
        b=uTFRHoLEAvEBnKXpflWF7TsyK9ggQyf51w8aUCyGfjOX7pGoCOM8KI97q6+iko/cYg
         TlW9I00bhtfTzoy+gdsQOQ3CZCaqo8CVIFQOXFEGMINFrdpcX1g04RawcE/0nm0Q7t/Z
         VSZ+Uo17GxlN+n88zHd/5WFWrF9lDopEWT4LZtOXmqrGBVcXEH8/pF4VYcldJuxDy/1N
         396bThKtw07p+Y66ANaHWY7+QYV5E7s2Hy0QOqqJ0ofaEfwMP60sUkrRPYv4kmzO1jd+
         czkS3ho6BOfkll5JAxoSX2KC/9Exs58v8P1OJj3hlJVrIJJvgTOuqOKvWGWGY8z/v9ZP
         Q+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXZHl5hOFIAcTc7ztz05x4w9oCdh8sY7krNaFnmVmSbwxxl2kXLlw8tcHdw7027jANUtQuItI/ZvyzBFZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGslv8H/qwobBnToVZqLy55l2J+yHRe90AT7nVfdnZmCFcePc
	T/TBOBiHkqyE8TwklUuKngJglx/URMp1ROpG7dyQu37HWXlRTBgNxJ5+ZX82Xb36InsDz0MkuJg
	g7N2eJg==
X-Google-Smtp-Source: AGHT+IFE7d3v320fruJZDyKQRPxtYcFs1S4WGsj03GrTm6oN1eMjN5dQCeQksAPTYLlZWWAXkO95dI7pXbC2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:528a:b0:6fb:78b2:8b70 with SMTP
 id 00721157ae682-6fd4a10fda2mr5924667b3.7.1740781435497; Fri, 28 Feb 2025
 14:23:55 -0800 (PST)
Date: Fri, 28 Feb 2025 14:22:59 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 02/11] perf evlist: Add success path to evlist__create_syswide_maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Over various refactorings evlist__create_syswide_maps has been made to
only ever return with -ENOMEM. Fix this so that when
perf_evlist__set_maps is successfully called, 0 is returned.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0dd174e2deb..633df7d9204c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1373,19 +1373,18 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 	 */
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
-		goto out;
+		return -ENOMEM;
 
 	threads = perf_thread_map__new_dummy();
-	if (!threads)
-		goto out_put;
+	if (!threads) {
+		perf_cpu_map__put(cpus);
+		return -ENOMEM;
+	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-
 	perf_thread_map__put(threads);
-out_put:
 	perf_cpu_map__put(cpus);
-out:
-	return -ENOMEM;
+	return 0;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.48.1.711.g2feabab25a-goog


