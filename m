Return-Path: <linux-kernel+bounces-376777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988C9AB5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFB7B23168
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593611CB315;
	Tue, 22 Oct 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlP1q6VT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0F1CB31A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620400; cv=none; b=RWJ4famc5PWEuwbXyu/vfd+en+2m4C0Gg05jaueTDg1JnvWlT+UXqZHVvL/r6gkZmDZPpwrDD7OErmHmVfgIAS8S+B/8xJrRHBY4UhMihfjfu2dt5UKk8s047UcQqVYVFCZWfSwnsPemzKeO4BlI4KvqEfRibusDVl02PjlIKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620400; c=relaxed/simple;
	bh=raAc7l7+e6idjT0jvMkbeIhgwYBlvolRxU41kRdYBDY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rQP5CQYwIA/f4Hf/BOhV3MX5IiTod/0IVJrjnwtQ7SR9ftmCsng5Lm0OpuS5XLx29hylFuRDja9mN+JrRd/Jypf0ORtJNx/rkeHXJs7513s/q+hlLuxD4YBexjg4aBFM7EQqwvV/JUYuurZUpRkSHMgu4Es4QQSsWNkADI1MWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlP1q6VT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31e5d1739so106818517b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620398; x=1730225198; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZE4khg3hVWn747RG5rCs/fiqdzgdZsOYLI35TpLPnqU=;
        b=vlP1q6VTX1uOJ1p2NfIoBJD5jScMfTbWb4y9YJzDHhy7FwDuYWPvC2LQFnIkFmtoZD
         YdnVxAOjQuPlPakj1O6nX9gXUSWbfGLcaVGzuQ/KecaGnKf8SVe3nTsIzF9kdwEpmSnT
         O9YSgK9KjGZlHHoZKoB/45M+t/vSMfHqc1YqQXjhCQEkU2NWUnDEfS3gbQ8FG3L8Z4pz
         3NTJ743l7xL18VUrzA9WRsVFJrImDcT+/CThB9aVfaFU9DZLbn7/iaO3nnVejfRKPHrx
         17CwNru3t02YKr4DZkOb1ajs/ErgjdrobDeFr0aW4Yk4D+q7xeUcbp5V30WCnTRax0Kk
         559g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620398; x=1730225198;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE4khg3hVWn747RG5rCs/fiqdzgdZsOYLI35TpLPnqU=;
        b=kkLpQ2wJDsP6FbDhbqEZx2mv3Zylum23D1V+q+UK3w1Vg/FFAb4KvzebVqyF+dralI
         E3YhQCONeI/UtL92iBKXFjQnUmY1XW/xU2oLK8BOGNSkU7x0ChVRljvkU5X23DW3AgMY
         T5pVfTytmPp/nZqdUbsig6EhBGJBIDiiPThPOqxg61ri9wy9713zfkn9hywXkUkhjfaQ
         HCWR7EfYgLrgAn0g/sVsmEJ31npWiOvm9FJwccHLHZY5ZZF2simzLFi1VPhHg0TDFq7B
         ydIUnc0GyBFZJuY0sHtlXRwEXMQCwaqfWdyo70JzWqDbsxyvT3GHaAfkvSMJVgfPWUSX
         YobQ==
X-Forwarded-Encrypted: i=1; AJvYcCW68QdisnIt5LkmHxvqs82B9zlB8swF6zpuH0xLEsjDSezZ/lO60vBK5WucBVOfe4ov0SqBwd6fj1fELX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIMJnB0QH54bf1D+SbBhdNIwVoyYq5zq6eVtmlqQzY9lF4Pyx
	o6v+DUpM4B/6SExoxjNjoBi52sRESVt5NvKXR1kM0Phu6tEqi+JzNa0WWcO+pe1PvDxp7hImiij
	1wTT6oQ==
X-Google-Smtp-Source: AGHT+IFY42xpVIqwy/PLKWqYkV7Dh3ULqLd+brSMo2MMREjD/kH2QEjNWxekmpVPCZaO/0nWYg8m6558YIAF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6681:b0:62c:f976:a763 with SMTP
 id 00721157ae682-6e5bf61b030mr5277577b3.1.1729620398304; Tue, 22 Oct 2024
 11:06:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:06:23 -0700
In-Reply-To: <20241022180623.463131-1-irogers@google.com>
Message-Id: <20241022180623.463131-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v6 5/5] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
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
2.47.0.163.g1226f6d8fa-goog


