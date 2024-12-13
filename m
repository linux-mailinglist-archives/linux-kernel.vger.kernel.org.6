Return-Path: <linux-kernel+bounces-445570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F129F17C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AD16C10B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90B194A6C;
	Fri, 13 Dec 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQu0MsXu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D7194AC7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123878; cv=none; b=pb5ugkUdjPqFZFy5x38wUThk7OfXbmIiKni4lNP9ApM5JdOc9sCUcjftEemjWumYCR+0xsjwfCBDw+MLNoJegaeHy9Ry+03T1gaqwcwl4+FXeS0G6/9rEfaePMDbnxFL1d8mQPy+JT3SHN3dgrJEJVIbfC31tYPPFUOZEPFQ5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123878; c=relaxed/simple;
	bh=4pKzkTV7w7BbOGxOqcD1NuW63SK6U/7k+L92iQDdz8k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A/vpYoMeQuXE3r24ic7eTqIBmV8C0F3hNFaCX+L9v9XLN82OMmeC5tC3UXLNLMCPQfQlhsyiMFePM8Cd3TYXtX4UTlB+WQQgJyZd5EGyeUCe5p0JhvWg7yX2xyCnnhEbXQkhe2P+ZYdapkcOESxyem1fmo07uJdD+VMyCIVROII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQu0MsXu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e38d8aaeb4aso3133940276.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123876; x=1734728676; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vioVLOwmrwPBoDuHBo/JSaFU3XJwmvCOkzBZLpYE96Q=;
        b=yQu0MsXuMk7sRRsTYFtqEO+sATyce382HPFl86s837Dq2rvhpaBSqjExIiEIzo2Efh
         2OpJP65Z0u963yd3ZSTCLgUT0s5iOek26u7EhFwDJ9JgnzYRtvk3Lg+vREDKwcGUvkkM
         DN1UGnl7rHA06II6CbxFy4t+o4D60RBmcLZpUTBM539E/+3V3kq54B633bBjSReG+P4p
         uXMmicUgmCdaKQJ7mIRyLiQSWjSl8LrRBoa3qs2Xizz13iFUKojDx+5bFvrEVESVegMy
         xicltQjMLPAGQYY+wXXhSEthWwwhYYit2fpUQr1mspA0dNjQJvNOJjWecOjJaNXpoLMA
         lbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123876; x=1734728676;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vioVLOwmrwPBoDuHBo/JSaFU3XJwmvCOkzBZLpYE96Q=;
        b=vqszeWcsJgLRl2maDV6kyOxCafURm00vM2g6nH+lUhqWiIPhn9sZvNWl4voql09AIu
         LtsDTB/k/o3Fj6D49SYL9a/GcviZTXYZZV/wMi5hVDCHMwkPbg5L9VXgwtGFx8IICfte
         2v310tkLGrE2blK/XEIX1ale6SyBbwJ0Qd7SQHQrqEwRKLo6IYrn9QwF3nZq3kMUn/gC
         0x9OSAiCHsBU6+9o9+OW3gnXGQPIYwElMT4GsuEp7dG4qSSJmTV+qSjbHXnfVQ/Bp9PK
         gdzSoeEPFvAhi7IZuHKDgVYrVarxO0t/NwXReCYnVsy3PFWzeOCJupAbrdm+2p0OPW56
         0Psw==
X-Forwarded-Encrypted: i=1; AJvYcCW4YJVwtRsj1k/HCaqrMrRYHKm+8YDwkdneLBd91J6jYul9ka1yIF7rOqy9uxUaq+QL5sDivWXpEzZmqa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FpP9Nsg9uI4VrvSccJ55A4jH/GElWYHg/YRZjVms+OskiPYs
	TjqX6Vugs+IoM3nVTypbESY24S7eNQp+ti29Jr9seQ5g6x/W2xthl0tQjz3NW/arX47h7WMqMfF
	lDduipA==
X-Google-Smtp-Source: AGHT+IFJoR+VUIap2R8w7wBB5lIJC6iiEWzTJTmaxzdCenTqSqXLAehauJytbWIoze/wqOYJJA/lOzwErMku
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:a34a:0:b0:e39:8650:5cff with SMTP id
 3f1490d57ef6-e434a06de27mr1841276.4.1734123876288; Fri, 13 Dec 2024 13:04:36
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:19 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 2/8] perf test trace_btf_enum: Skip if permissions are insufficient
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Modify test behavior to skip if BPF calls fail with "Operation not
permitted".

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 5a3b8a5a9b5c..737da3113966 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -23,6 +23,14 @@ check_vmlinux() {
   fi
 }
 
+check_permissions() {
+  if perf trace -e $syscall $TESTPROG 2>&1 | grep -q "Operation not permitted"
+  then
+    echo "trace+enum test [Skipped permissions]"
+    err=2
+  fi
+}
+
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
@@ -50,6 +58,9 @@ trace_non_syscall() {
 }
 
 check_vmlinux
+if [ $err = 0 ]; then
+  check_permissions
+fi
 
 if [ $err = 0 ]; then
   trace_landlock
-- 
2.47.1.613.gc27f4b7a9f-goog


