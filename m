Return-Path: <linux-kernel+bounces-346972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3798CB80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22595B22F82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840119BA6;
	Wed,  2 Oct 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfNSxh97"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDF39FD6
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839256; cv=none; b=lyjUt/2l9dv7ypDdJI8q5gUa5jaAOU1uCVFHSD5KzOiHl6BHuQYux8GTIRzZE1z/mO2U7L3RowcFRgFagC6J0wymokW6ZThW+XH2M41qrf1ADm2P+InwhIHJ3R93S8lSQPTZHjPAbgtBwSQQfbFtyJ2UAk9y39hifUAONM0ZCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839256; c=relaxed/simple;
	bh=fMXDe6FzbtYxqcCD7arXivj4L02uApdRNk9Y9SSBnoc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=S5IxQqJNXOuAjx27jHsd7pmh6W2MuUk7g32gPaQ9BYRdPmbCTzAFFABR8sEwXwWpgQb2iVIwcRVjAil1zVJwASbvYahiZ/Ah6wbNSINW5bpYNm3AdZXebKieuHqPnqn/Own4FT0hiQI+pIRjQIILzS6pkbbZTlVb8ewGoxbe7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfNSxh97; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28d22276dso37326307b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839254; x=1728444054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNJbO3ECVgjqRfVy41pUI42bkQNVjMupI2VGD0uB/As=;
        b=FfNSxh97dI38VfoDUvqOtlWME9n/i2k8Bcov/5B6Bbw07crr4YXhkZJFV1u2cUI9fF
         8wWuDs6RNa4R5B/5SK6VZXi04uuETQX5sQt6Vj6IQkSlzmdZAUHPK50K2XsOOI/mYfUH
         1J9V8xyKJLvs4A193+TIZt+pMBD8dmS5rzye+AxZkt5lrS4Kon0FabCUQQbI+xo056Zb
         QyKgt+RMcbO0qvUWqhMFJBuCls196IeTdZ0xKEG9dBNyTbWLQ8PmmgmGWo4nB9JqCm2S
         2OC4sFLKnqrMYQoOgu00JR0Dg1yHA0g7TXUWYiKQg5bvzOXGn6avmMqb29gk64iBdcBA
         Y47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839254; x=1728444054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNJbO3ECVgjqRfVy41pUI42bkQNVjMupI2VGD0uB/As=;
        b=hdCStO5n5fnlcsO8kZhVyHegV64jYB9KXlNleVP5Rl2hQyjjA+yW5L08Jzoh5xBm1Y
         /gi0gOr85582hk3zUvq2E4yaD8Ucfy1+PnpL1h3okYg8fsu1UUMYpf4rAlXZwSHUn9+P
         B2JLyaiavFiutrae+PZoYC3AnlMY2p8fFSt8yuWxQTYckmo4hoGwFZ15kygw5+Nz5UQK
         Mtz7bj4NCvj8t8AmZzE3P99creNDXjZRYFmRdiHYQy5VDaSetCtBugwK6KM4d4QrZORJ
         wtJk2NWgy6N6IO/o528NCMoC5GeUAWvxZaF8PEq28zUgF1bzwpi7VTuXlqaZVFhnWXg7
         1VeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIteiNP1f5DOgOwbVFDu73ykT29SYbe03s2d3igeR6XUaNjBv0KpGcA2tepTh+3J5IlYJXzaNO6klycY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AcmSShvHlSdVbTrW2aCpVgUuBlhJmImWmX9KYgVBL/I/JxCV
	+3qYw5upcZYiOo0E1/uF4m3vu0kZ5x6oSCWSW2qvTuacDGHZobhXfl0JNu4GQDZPv1tzA2nu4qk
	hcAz/Lw==
X-Google-Smtp-Source: AGHT+IGyarEeuwdMvust1yq5sAQKvw4va1UKOfQvuvp37bcj1JGnGgp0h/YfXIu9yL4w1PHiMsTtvB//he04
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a25:6992:0:b0:e17:8e73:866c with SMTP id
 3f1490d57ef6-e2638443a7amr7352276.10.1727839253957; Tue, 01 Oct 2024 20:20:53
 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:16 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 13/13] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index dea005410ec0..7e3cd6c5e35d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.46.1.824.gd892dcdcdd-goog


