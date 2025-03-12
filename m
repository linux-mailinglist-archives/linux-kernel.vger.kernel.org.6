Return-Path: <linux-kernel+bounces-557096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E16A5D3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56BA1897C96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C8282ED;
	Wed, 12 Mar 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1zmn+t9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44969443
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738728; cv=none; b=kWuplRVRioKNjmpMEJt+3XdCAbH9Flzv0Xa1wxVuUWsYI/VowN49nRezS+I9F5Kg7LcsGwKgMtBisCi2KHCif3nE0XR5gogt7rsN7Ocs7amNX8JbWuoX30MUTUoShpgHPG2BhEYdDDy/SbPydQUbF51/vTwJByHxK1IXtg0wdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738728; c=relaxed/simple;
	bh=TuMadePkxb8jxDE0mIQj+ghINJIfrzK4xfCJJdF8X4o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=OeBnrJb5focUPSaC5ZumUq1xUW8+DS9iVV7YDbvmgzuFOZxkGYYVKdSEpv0S+ERO/BwGY0hAQcBnlvNFS2Q1brJe+/hVmfTeQ3C34i6TVXuXHSfZAAI/S9/gxk4cLoJNu3CU32u4TBZNfaNoHXrJPWI1ktG6PR/a98PF/EgUyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1zmn+t9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fddfe0448dso5242247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741738725; x=1742343525; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=REugdpu80t5x64k4y3HKelfVsb35Y8bQ1k2waLdzFQA=;
        b=N1zmn+t9aT05KmsoSA3UnDar3Lc9VgKgmFcm29+AMk5Ld7r/ryxTK/9/u+4dcyV0bJ
         GZhMZ9RXn3jFdSi7K0Mt1OahQgoMjj+55fzkP++p8ouvsbMwya0N3yUOVc5bg4o8TgZm
         4ZItuFfUEE8pU87cCrcpo0FOY3rCEAbmBMBdwFOKhdjxkSPaGfYdJRAg3WEvH6CsJjPu
         GzM3WLiVBRpVPQs/dRQczYxkXiM3/NkD6T87hZ0ZJHF7RcnbgwWi3GwI+L0Jfak8KPwf
         M+q6MEV2Av9yGkopNSzi7wDvZozoygJxLDvp57kIhoxqP2SKAUUcTHLG1FuOEjmsVIDI
         s4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738725; x=1742343525;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REugdpu80t5x64k4y3HKelfVsb35Y8bQ1k2waLdzFQA=;
        b=SQsVrjaVW+1bdVzxPe7IsuK+uwrONzf0F42h+vZKegxb0Cn4Xq+uJfEubbMxOu+tRe
         +5sXvDGwZNf9SPFm1UEHaRnn/Rix80D5QocnFBzYt4YTyviZYv+bROQe/szVKVyiUdKI
         LA3Y0EU68da77xTLxvtQl17hsnxwdgF6pUzRByaqpUy4l8aUsulZsQqa+DcqzCxiiiZd
         fDaJlCgJvQgIlu5lpL8MyqFmqqZNwNn1EIF7W6fcTZNrmrbe4oxvCtXAvrBXxbfL/np6
         zuEsvo62DK3enAERxWxDT9egt6yjofieQoAtpTESBYlPoa6Bih6LV2/dbpRgqxvLTvAz
         TslQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTyL9DMpwhOfVwJjiRFLDqpOjVL5Uf17VJnu3H288+iqEWkYejuorFVpSOfmmGg5ihMT5qLYDGZwWE+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyi8Epl5txcky3jquWHkPlLF9jfrZOoZQRW19GL771WoQautb
	rEo7rOs85t6wkDM9tyIZII086bW92Q+NYFkRhsnILWSGYB+denpQfNb0cW9lVQLn8Rz5xm6Sl/G
	gX0GFZQ==
X-Google-Smtp-Source: AGHT+IEZVGyVhHcp5La5S9mDdx95clLmTIYUzQuT/zjQobj8BfFNDhxkugMKrMJCb+8E3WAqToYxgeYiMeZ+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:650e:b0:6ff:1f10:31fa with SMTP
 id 00721157ae682-6ff1f105c4cmr278467b3.3.1741738725415; Tue, 11 Mar 2025
 17:18:45 -0700 (PDT)
Date: Tue, 11 Mar 2025 17:18:41 -0700
Message-Id: <20250312001841.1515779-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1] perf tests diff: Fixes to variable expansion and stdout
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When make_data fails its error message needs to go to stderr rather
than stdout and the stdout value is captured in a variable.  Quote the
$err value so that it is always a valid input for test.  This error is
commonly encountered if no sample data is gathered by the test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/diff.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index 14b87af88703..e05a5dc49479 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -39,13 +39,13 @@ make_data() {
   file="$1"
   if ! perf record -o "${file}" ${testprog} 2> /dev/null
   then
-    echo "Workload record [Failed record]"
+    echo "Workload record [Failed record]" >&2
     echo 1
     return
   fi
   if ! perf report -i "${file}" -q | grep -q "${testsym}"
   then
-    echo "Workload record [Failed missing output]"
+    echo "Workload record [Failed missing output]" >&2
     echo 1
     return
   fi
@@ -55,12 +55,12 @@ make_data() {
 test_two_files() {
   echo "Basic two file diff test"
   err=$(make_data "${perfdata1}")
-  if [ $err != 0 ]
+  if [ "$err" != 0 ]
   then
     return
   fi
   err=$(make_data "${perfdata2}")
-  if [ $err != 0 ]
+  if [ "$err" != 0 ]
   then
     return
   fi
@@ -77,12 +77,12 @@ test_two_files() {
 test_three_files() {
   echo "Basic three file diff test"
   err=$(make_data "${perfdata1}")
-  if [ $err != 0 ]
+  if [ "$err" != 0 ]
   then
     return
   fi
   err=$(make_data "${perfdata2}")
-  if [ $err != 0 ]
+  if [ "$err" != 0 ]
   then
     return
   fi
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


