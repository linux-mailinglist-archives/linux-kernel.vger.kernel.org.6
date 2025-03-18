Return-Path: <linux-kernel+bounces-565450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A6A66863
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A513B0975
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE9A1BD9C1;
	Tue, 18 Mar 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjg+fDHv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6319ABAB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272319; cv=none; b=G/M9V3hYRY5qrh9hclllT8SNOdiH+kDTLIxSVI1XtytpxF/cLIOYhxE3pPq6OHdqFNWAWb8xQGafbBFJluzzMNWThEounDWktHc5X9vSv7KoKnz2YICZA76luNYoAMsHop+SbkKsDt8uwGiRnwRZuRwmtyNR6CZK5YBKp+FLUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272319; c=relaxed/simple;
	bh=R9Xg6/Ngqi7cKsMGCB9U1IMDEdObQAmq0QYpQz3ckv0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qSBD5wG2XXVgBa6VVZKhfvbdzNgmyBq/AX9ij/9fjblft931u1XCoaE+WMa/8FTt7E0y2aM6iQrm56Up1ee1vO7O/rzDMSwxdzxwAaz6SIKT9eHrJ4RzFHQoTIG1J5TN+CDwWxqszQvIlWWVHR+nKaac3H06hSykLKsMtcwIXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjg+fDHv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e63458181eeso8195286276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742272317; x=1742877117; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=sjg+fDHvjvQIY9HiBYOWJjK7dS2bM7G2F/oQkfE4fItu+N2Xdq1LljzC2z0gFDC67U
         oI1LcRMyFEFSeAYa3UGsSSTmWgW4uKrkzAPA1AIgupQVdoTNFMMDHsJmWclZfK7urxU6
         F3XT5+6T0ICX/nyDyUqL21cKOuugxakQ/RefYbcP2xRB48zS1eAqFuheXI+rlKBoZabj
         B3u1Gh/4tqnFwP2x/ASXDja05auhmts/PxXLxCwrV0j4Ud5Uw+gtRaDN7oZRgBo5XTBu
         SLKlMTN1byTjP/CN49EY7yFlyYKWlNmeJ3fgXpPWBkA8k7hIFukSyLfgrmptAuzvJHwU
         3G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272317; x=1742877117;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=FdgVoyovEdxeCHWPmn6BupVG9P38SyTtH2SkSfeVxXcJ4hTkUC34jrhK3mI6xIXt33
         9pWlhs05jSMZVq7/aUwGxnfLbtsDlmlf3Ij5SSYNjCb6FlnSp04heb5nup3yXihe6P4Q
         KA40sPuAcThODZNQMpL4zOKAdKCEMklwJ+Oz1CiCmF2dTz5jVW4Ti9wPd/6blSCFN7/R
         m4NCdD7FxH05jy2gJebRPegHU7HVrKGe6262d6Bk2DLD7e/uPJ5eEYYNGq/pmgoEz5ts
         CXI2rfjHRRt6rvLuy3InDujUIY66QQSs5L+wTv53KWrwSq+hdf4sTnUJf5RaR1xdcWpb
         Ay0w==
X-Forwarded-Encrypted: i=1; AJvYcCW9LrTQYCnDDntHSsxs4XtSaTeZJANZuVzvIbNKdGIjGuRpQ5Wj9UD0XIpoSLE2D0gRHZrlzhY5ghCM5a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUfFLRN6yFhVHEfRtsoCmnzRuIrqHTurAYj2DyA3udPBaidSA
	21gOYDrmkh6Tk54bZDyXB7SkClXhi7NKbPCfYsumbiH2jK1LBj5iCz+TpYJuH/CbPM669aPSsnz
	nHuxKGQ==
X-Google-Smtp-Source: AGHT+IE9RLBPYYi01/nJ6WpnF2viapxrPRVS7wY4MLSGpo6dfqlkOjr5inF2G5LwZ0a2dZ+mLAaiBH+9FSni
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:ad4b:0:b0:e60:a0b5:e57 with SMTP id
 3f1490d57ef6-e63f64e8581mr7989276.3.1742272316696; Mon, 17 Mar 2025 21:31:56
 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:31:49 -0700
In-Reply-To: <20250318043151.137973-1-irogers@google.com>
Message-Id: <20250318043151.137973-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318043151.137973-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2 1/3] perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
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


