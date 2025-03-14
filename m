Return-Path: <linux-kernel+bounces-560644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522DA607AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989F617F8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85E7346D;
	Fri, 14 Mar 2025 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwfGTSZu"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D7288DA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921722; cv=none; b=YHxn1m+bveJQ9tiFyYrKJdiShUxRU3W46m37PljK4DphdrDIeb3a1vu6kE5agi5mdHF3me/9gGMSPtfloTTa5ambnkAQjSrTrb56vKQr/2YjDNGsA4+5Vy+AU30R376Enww+dhfRNeG/AGYgOCKNXri8yxxUgzyUPYCPk8lAXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921722; c=relaxed/simple;
	bh=R9Xg6/Ngqi7cKsMGCB9U1IMDEdObQAmq0QYpQz3ckv0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BKPFfZ1rOfZ4BXkJbL2H+YxEdYBLZw5ThHTyvK1hT+SAP40zKTcC5Ag/O2N84drIHzNlTSKjz0nyUpFNxImzc0KhLbuKP+97ndCfAHCLGAjnNtsdAFZ6vD9YrmbYyTkIIxG0y693rSv2XJcQuHXqccDTJciAJEC8gjhSeRrG/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwfGTSZu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2bdb560ecso26707957b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741921719; x=1742526519; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=MwfGTSZuQdrUAI32ckXcqWdyHs58EtI+LwkiejTL05qxpSSQMeUHl82UZVexMeHQnT
         yXZ/y0LIfWnWDcY3j0etZUmv6WtH48ztThuscJornocBd4P8QGX9RosNL6fqG4WAcH7F
         YcScxw+MMtNjoN7sPjpqYaQu0Nc43YREN7ztgabTmVqXVex49OO4s1QoabgfnsZmjlU6
         7WSEnLyWaV2RxweTGo9p33RmpR1vINE560/oANTTdrhBqwvlGwdos0wSEqdsCW3gstlN
         MuJK+XylGjG5iHdRLuhiHWKXntfcOicZ3gdoDj0UYshi3TDEegAWwoL+GUh+MerAhrzS
         uNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741921719; x=1742526519;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=E6bYpFy7NrPbX+yWKWXO78fng+RDHvJBDuALo9IBH1G75FEni/QxN7oB5xXrShzQ3J
         IPNOI1YaDm3OwwptI9q0ziYLSWYef8MBD8O949XW8OqJ0FID1VT9Aq/SsxsDzuaTVy+W
         TmJ8eLYDODd5+dfXMafJ+z09fRwTdve4RXN0iP/if6jhUIrPmVQwHi+/Hs/IkPO576gN
         QfOWyYRxrYU5LVNf7VfZ89hAAA92dEuamFtgaX0BHtFVz6SGQcEZEboSsCcS1H0+cBqq
         Zpm/gbEq6idBI39FZm1RZClDqaUtpN9VLsISiCGF30L7H9x9UbEikDOICttuQixONssw
         noBw==
X-Forwarded-Encrypted: i=1; AJvYcCU4oXlYfL55r4aKF09uKRnmOVJZIHj+CC6owMMf1tya3riMKZ0FuVt2JzQZAAT6yWhr9USAOGxQpb7Om8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzyPwaUZSE6TgspcFr1byslaBDjNf748/bSes00bTpeNjCjJV
	HXKxDpmZ7d3UYmJf/ahG2S1HUWWVfawqF4tu+wlpKfyH/3Tycpu5s4nquIoSI+3qHp/1C9To+3m
	wp6icZA==
X-Google-Smtp-Source: AGHT+IETMPFBJExY/EgyF1LGf10HrNsQ9tDE9+N9OXpEXNBDMGqejGQyQjz8s+91H9Szbm5Jc1mVnI3nNDqk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:cc2:382:11b4:a6ba])
 (user=irogers job=sendgmr) by 2002:a25:cec9:0:b0:e5e:1554:41a4 with SMTP id
 3f1490d57ef6-e63f65e2be5mr496276.6.1741921719423; Thu, 13 Mar 2025 20:08:39
 -0700 (PDT)
Date: Thu, 13 Mar 2025 20:08:34 -0700
Message-Id: <20250314030836.1129407-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v1 1/3] perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Used to annotate when locks shouldn't be held for a function or if a
function returns a lock that's used by later mutex lock unlock
operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 40661120cacc..62d258c71ded 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -33,6 +33,12 @@
 /* Documents if a type is a lockable type. */
 #define LOCKABLE __attribute__((lockable))
 
+/* Documents a function that expects a lock not to be held prior to entry. */
+#define LOCKS_EXCLUDED(...) __attribute__((locks_excluded(__VA_ARGS__)))
+
+/* Documents a function that returns a lock. */
+#define LOCK_RETURNED(x) __attribute__((lock_returned(x)))
+
 /* Documents functions that acquire a lock in the body of a function, and do not release it. */
 #define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
 
@@ -57,6 +63,8 @@
 #define GUARDED_BY(x)
 #define PT_GUARDED_BY(x)
 #define LOCKABLE
+#define LOCKS_EXCLUDED(...)
+#define LOCK_RETURNED(x)
 #define EXCLUSIVE_LOCK_FUNCTION(...)
 #define UNLOCK_FUNCTION(...)
 #define EXCLUSIVE_TRYLOCK_FUNCTION(...)
-- 
2.49.0.rc1.451.g8f38331e32-goog


