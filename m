Return-Path: <linux-kernel+bounces-361886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8E99AE72
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382A11F2132C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030741E1A0C;
	Fri, 11 Oct 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhONqIVL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D611D31AF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684255; cv=none; b=GVLVtB+K7zEbjG/hHZDLVc73kMsoFwvQO57aOOJB6hRGo48kwIcv6jU+kyvK76e+jXXXGgcQ6ckt1Sa79DZk5ZXpXsa1Ezt2hBnX/EwbqgzwqvMKCmJyuAYqzUcQ6P6TFbVbfMfDZj42v1GbBXAJ4m2P4o2c8KBwer0M1iApl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684255; c=relaxed/simple;
	bh=ayFLEkZZxvRFtfh6rbDKgn18fu4jJI/W7wgdr0IoZZA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AVfmGL3yCEsAewWA7HOESWwhrSF7QxNF0clIBx0I7dQjFaXzxgNZxrEH8taXvPxxm65//TR21Bd4/vgyMAFvMNw6h2tYC043zK+skLXoeeUI7I/gawKGYN5IEkrJAWeYzXTj6cimo9+GOAUpgr6IuDuPuaiFnRXDBFsjL3fvoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhONqIVL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e294f38bddso42509717b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684252; x=1729289052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNrioubmXeLjE0G20Z4Gp3VHKZoRwxqkvbcLs4LSREQ=;
        b=EhONqIVLt+wav07/C3dbXenSbGmuaCdlXrHKR/be8tEXk//9oBtdBfrE84Ak0DgAZ0
         37bcXHwqWE4WWK3F/3duEmOKmbzpd2EFbt3OoJTagJ81axm6CJuqZ07n45f3OjFX9dC0
         oseFVsA/uAZ/obsCD1CdpVc3bFVoODhBsGxlduIL0wTqu7zQMV7/5dm/jqYUSb+bT8R4
         KJzGXjox5tyU9Y6r0SsN7EwFVJh9lksT+Bv8/Kt516hH8iymBnEOjFZwNZ97ChvHeHsv
         gs9l2qmU6KYmMSzp6Fz9J96nRjlCMCGiYNyLDLy3Z/V5rFBw+AoUSv3qPhd1Peu8h9uu
         hSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684252; x=1729289052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNrioubmXeLjE0G20Z4Gp3VHKZoRwxqkvbcLs4LSREQ=;
        b=Am+LHfT35nSVW6EuhEVnAC7x3/mWyJA+5V6fqxAWkr2RRTMPBW4i6APo3ZeTFBS17e
         eQGigaBPSZ+ppmT/Gd+8HuI51IU68d1hRCU8YqdmeqFTWXuy+CDzABcikqj0lSDX5jvZ
         GEd1obm4e6ouu9hD93f3X9d39AaoJsB5cx/3k7xbV6K0VYk0xbfV885uASdZMxsEliEL
         JD6UkD5D0dJWNQEf0KVn3CQKMUMQ8nWIc09MuNLkasvbQVnLRFJcE0ahfPSW4SNeanbx
         eAETBJ6uZMljPgxo/qDqkSgz5ySvzogk2EusvIeLNswMT0jZRdDUPVYoGCWcfVW6fNlp
         zkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1OAZl9Hk0e5Tk29bPIC1561QJ8TjOpVm54Cmv4hPE9nFB1qDh5tp6JGzxqC4UvOJFaKnUpPFBUqAUslM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPL7B6TM2fSOnC5bqxYC/YDDm7/NPIZmseG5KL33/8kayKXA+J
	/yPqn7/aJKtXypHpncH61sXrZ5Bb9KkG2fKyDIeqUpLDxz2UI+k9KSl+TEAb/ibaw62gfj7y1WG
	lZq17jw==
X-Google-Smtp-Source: AGHT+IH0cp7lEpJ+EU1fmq4BdA4UVq+vSksmc8806woiaMmF0NZBEKmS+zYZPslDPH3bhtxl8VmxpOa34DTG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:906:b0:6e3:189a:ad65 with SMTP id
 00721157ae682-6e347c71baamr1540377b3.5.1728684251913; Fri, 11 Oct 2024
 15:04:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:49 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/8] perf test: Reduce scope of parallel variable
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index bf03fb42420b..88ffc0feb51e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -565,6 +562,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.rc1.288.g06298d1525-goog


