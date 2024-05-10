Return-Path: <linux-kernel+bounces-175089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCD8C1A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12D28153B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7F1FA4;
	Fri, 10 May 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4Rr3vEU"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBA646
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299508; cv=none; b=NsrOUXKZLJr3ekqJWKSo8CaCD5lwUNeRVzTDvCRynVBH+X2UGISlfh2XK8vyDRTmfavo1GBd1Ls7tKoFWKZ/JEeWdtGcnRjQOvuPBaud7j8vj7LzfbR7U36DUCEDOKAAt1eHBGD4Y1IXuGAtUCm9KD/MQxbXBI/dqkw8xYpWKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299508; c=relaxed/simple;
	bh=EavCetVSCgCq8a1RaVsXoOaflK2PYWCs6cIGsY45SPs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F7UHEg+Dm/69bIsgbvV8yLRkcDuXQIKd6G0m2qdJEvefBYAvFoTJ+ppelcxWE/kTUSz2+FBvnXx25pZOVeF1ftghUrZeNoWU4jkmvj8EtzDEJxXy/H21j1dAForNCO0VqqdyQT7eWXLmjMKYXlyCPNbrftaF0fTfwiO44CqqwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4Rr3vEU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so2969043276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299506; x=1715904306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=V4Rr3vEUcZWKPNh4YW0gJjYQr/4dOw5JseSRg5xD3YYEFpP0Xkw7t7/E+eZqVcO3pu
         59E86u9ohhWvmP6ZovTTGoki4ra03h8dndP7byhPDoAikm3V835l40RqrOfAlD4PwASd
         ubtIoHXl0KU+6LgGLMaR0AQ2xRus6ooyVctjt1aAkfVIFdCjIQHd3XCSsLCOCNLQhrpP
         O4EweZ3Lu+EUcrk1j5vjDfUWxMJNRosirtE7GPMndqBN/nEJHd0f7Ik0Orfd0UvTy4XM
         UuivO139DEYuhS7TAJaQvEmFe7ynt3s2NDNkeZ474PQdDMqOEUqmXhNmaCaLmkHnfWwW
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299506; x=1715904306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=SMQImFsaRRzHOLH11sct5Vqk+TamvPg4jIoaQbVU8QK0dFBgRZmsCTGcEMe6Ocr/vu
         HbC3Xa9nCqNJf9iMEnm3yFo/JgWxwr8pijGlzrsp0u1vHRn0EPrTOD4J52Fn2vjUk8mN
         buFN81BdupmNacpa7dXzXS7dPp2gRUBhZBxopOEo36FJ2doWv/sZQh/xYpSFcvYmfnqK
         3hp78o2WTyCRYmBt7ozor95Uzv0SxcPBmORlH78UqzXm7lVjtqNUr9wTlRwV3GljfIpy
         e9fAKVyyh1AoMRapcF6oRhqW5ycdP/nBdTvbkpwiLxxFBQzjMfpGqLznUKInwAZ0ggtE
         93oA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1ja+2lnKmSi9afIasXP4sIoHinDQnAnxX3iqeep3C4R6feDP5SB+oPfOGz31fhoLW1hDVSi3BKG4NhE8WOi13WY40NK+RmK3z8TD
X-Gm-Message-State: AOJu0YzYVk/LxwPLte1kvIz/BHaml8EITo6I9nNxmN/46rPFFrhzcNbn
	9HXjhXRftOnP28FP+ZAV4G3xyXUfnoLPLCihWJEdwwiub5KAJG6N+/LDN6SLqPDKI85tLxI0bPQ
	X
X-Google-Smtp-Source: AGHT+IHWZ1QbRc7CocmE11JfF95PsYEf4cv12KCkp3UCAxnICrsEj6dkC5JTWIEWOGCF8OhmKEJRJ8tMNX4=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr277203276.4.1715299505730; Thu, 09 May 2024
 17:05:05 -0700 (PDT)
Date: Thu,  9 May 2024 17:04:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-1-yabinc@google.com>
Subject: [PATCH v3 0/3] perf:core: Save raw sample data
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf: core: Check sample_type in perf_sample_save_callchain
  perf: core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 10 +++++++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog


