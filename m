Return-Path: <linux-kernel+bounces-440812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614849EC49A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DCB168612
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD311AAE33;
	Wed, 11 Dec 2024 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVrTkFho"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F405661
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897417; cv=none; b=JiX8L7QI9dFkiXmjnZ+B3ANQtBf+WvxsE8MZkBKNt0HozZcRGpSwsweEVydXFJOqfwwf6NevvsYmDtL5U35WcVWWc692bWdTb8l3ppWrR3JOVa5qivsW3BO95R6hpgy33iRXExyB0kWizmCmPHgI+ysAGTtxBxtHRZraW0NR2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897417; c=relaxed/simple;
	bh=siB3POHAJhPhtOCnGjqwdvgxAy76GqJ8cKANN3vULWQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fQPxE+KzHlQADCPpmXGmotWiJG+67cvtpEWyW0+lIrKizmVshPs/klMXd+G9EC2p3xV6kDaJ5Ge+P6aN7c9WFWT63eefGfaSfq6Ofr5VTqAqOKs2qCnyeWhdunZ9HNPESFV6Z/G2IT3h/tGQ/LKtSrBLmG5w8nQoQl2GymOdsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVrTkFho; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f003073a95so36875787b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733897415; x=1734502215; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wicU6seNwvDcjZ41ouZnUov6zgQAVi5FudB1RU4tYYA=;
        b=QVrTkFhoZycyD2umTXBe6RZfF5FskldbvYw7ZD4i5wTC+2zpMHfWTTM0J6r6ZAUCsu
         QNxIvOaxd1TsW6w/F30pmbWA5Ry75pxDRtsNlVrENoxSnwfDbdWulSsoYZkXx9M/AZEI
         nkbvH5gfI/I7Af9o7uY7w29OVZzKushzYZmdWHg/29WNSsXT//1ZHB1M1oL9z2t3tbde
         v30WeW3XqGpGk3XjH106CMlm0VIgfuoX7HGB00j8CSK813+UWM8Jp+QT3wIMK1VHizpV
         fsBZM90/W2Mjk7le0uqBjmtb+bEod6tLXIzPtRhNeG5KFgMH6w997I6fpIdDJ7QZei4u
         U5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897415; x=1734502215;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wicU6seNwvDcjZ41ouZnUov6zgQAVi5FudB1RU4tYYA=;
        b=ZtlZg+gheeImJv+9PTX+HfUIRLy8rBJJJLBVbhVsNZ8qUVUkd1l+2f6ujB5Dqfpxvk
         js457mWcF31/1CdnJThbY4YYu71Zu3Q7dFb2IY/9IUtzO0E4fdP6x3gEOpptqRu12Wjb
         hyYiObZ5Ved4Rzv5oa+9lD+malU1uYQXFPIH7oKPnxMQBKvKtyupqNcx5LchaqyJjRVb
         JqtFwRH7HbosvS+5TL4SAooaCtDW9aeiUfxsBdKI6jMoAxrQguNcOHxE4lOZYnUXRIl8
         m37e1EqbkCYLvkGnxMONDzBrEISTHF442DMSrjol3CGcT44ZKEkYuiYdid/Fsi17IAi5
         buhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSE2UtglIyYPdivaoFt8wawS9okFIQCp0mQ+XATqg/+VFOd52TSzNioDJacm61gDT4y3K2Lxu9DKJM4us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3g6MDs5dwtKwL4cNMfozDUWAV1P/6+M+XH/N1+AEHfc1Ajk5
	6FeVDhY3cCZtxErOMz3hibi1o3IzPMZ6Z9Oo4OUdYDJugNQih+rVqIZjO+J3vw0J7hUfGJUn4Lm
	fdn0zLA==
X-Google-Smtp-Source: AGHT+IHvfM85i3MUlGtDrNiEWrC9LTxIGDdad30vwdTb3uWTqyTehgqfaWUncQPRrSdhWBXVu6QEto8fhrCR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:bbed:4ddc:59bf:36b8])
 (user=irogers job=sendgmr) by 2002:a81:c748:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6f1480362c2mr62147b3.3.1733897415035; Tue, 10 Dec 2024 22:10:15
 -0800 (PST)
Date: Tue, 10 Dec 2024 22:10:10 -0800
Message-Id: <20241211061010.806868-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf test stat: Avoid hybrid assumption when virtualized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cycles event will fallback to task-clock in the hybrid test when
running virtualized. Change the test to not fail for this.

Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 5a2ca2bcf94d..60cea07350e1 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -165,9 +165,13 @@ test_hybrid() {
 
   if [ "$pmus" -ne "$cycles_events" ]
   then
-    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
-    err=1
-    return
+     # If virtualized the software task-clock event will be used.
+     if ! perf stat -- true 2>&1 | grep -q "task-clock"
+     then
+       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
+       err=1
+       return
+     fi
   fi
   echo "hybrid test [Success]"
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


