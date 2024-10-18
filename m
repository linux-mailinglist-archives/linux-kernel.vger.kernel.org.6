Return-Path: <linux-kernel+bounces-370968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1C9A347E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262141F242CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B0187FFA;
	Fri, 18 Oct 2024 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKH7YbVs"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3B18755C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230457; cv=none; b=VarEZ5nkpA+CiKX+xBSywx12tJtwx1OGdxSRH2uKj10Cb8sKzxSzSFkNc935G+NNTVvY9V5b30GbCKmPpTU0sddPtaoqU+GhPdvDxS8/KJ5OiIy8uyaCdBXbJ+H5l3hHk3QVhKa+wAcKkoFeh+tbFw8KmwmAwzmKxwO69lMiox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230457; c=relaxed/simple;
	bh=AAtaACQPcJ/vEDycDGlrqtwZ+/7iyw1bRicZ1mXbDEs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M1OOOXZ4NqrlA0MleBqMYQ+xFUJOYFTSZ7KlZtSpesgV8nMeK73YdUHoZ/EftRSisa/9hjLJ4vDFaqeJrD36dbE+GOtjmT6g2Qoq1SjBy/b/GN5WWd18aOko3QdWNuLm350wZZlnhxUo800O/GBZKjFVH3Pn80qWiPzVwbkeFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKH7YbVs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so3465072276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230455; x=1729835255; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzOzjVPX++lTeYMMDuPz7oJrYRHg6W7qrKeeR8mkY0E=;
        b=NKH7YbVsHHUIRJ3nB6w+/trq0I6Im0mOtQT4IEZvwmybNV3o4LzA6pSUVYC3rVC+cx
         EFD1KVc5oXe8qmEo7f5VO3aDcMdft0im8etCFsQEF+SvokHjD/DPqeMON/pwGAzUuXqA
         mcoJciVRTd/k3sQKVg6O/234o8nJsgIACvhWroYCAI2WEKAatrYUUJDORFVtxtsORaMn
         E6vyTVkqVIPQYNjejPhejuUeqzciVuRyMsNEhVqO28zzuurEz25atFmDBzM6bFSyOKcD
         469e168rQfmIKuWw1iqhZobE0CDRcnru2JUuG95dkhp79RG+Qwyib+/HeWn3ONgG0y2y
         zvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230455; x=1729835255;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzOzjVPX++lTeYMMDuPz7oJrYRHg6W7qrKeeR8mkY0E=;
        b=Bq0krjGepwmE0WY753MJA2URIbBQSf3wtHKAsgAtlrJqfso2y5wSBcl+ll5GK3fV9O
         RfV2nHiNze/d00P2jxD3XMRqworL+CSTaUed8TQl8DM0fSQnVOhDWgjZyn5DBQIxBvW6
         gfBQH6rV7thI6iYCfc4JZa4L+U2q5OeGMAJgFZ1Gw3w89I0y8I85v64lJ5zXpbcAOSno
         EBWGfVuPvEOngaKOO55lZKSFKKawO+yjDpbqhmo68gDDb7sEq5H9eZ0Tfy/ffKo9dtBn
         Jcm5bh4EUlpg5+cagY6uPixoZ19oj+Tj5/OT3qMQMFtTNl4cRbSMJscN2MZea+fLr03z
         vtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+bsIt8DcMcJ3fChAIoib07f0hN5UJL/E/PbPRcV69kuqlGNHrz5/0Y6Ho0/84pS9Tg/paoybkTBAA7QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmhJJtXZ+t/s7+g15ulJ+P5EvXg/AaRCmtdCF+spjCE7J4ZFQ
	FPJeQNhwCoDw20zgj0wCj4yWhkWXa1NOgbpOdUBzQyu7yoxr195Ans7TQQVE02Rw/hkM4kGTkez
	sUHUyyg==
X-Google-Smtp-Source: AGHT+IG2GJKR44wUCxIVr6fn7zKLqbFnjefjdb7hukVEXHDUIcwE1VUYtt4Nc8ZXYmRbJiNsCn+SXgFEeYo/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a25:1e87:0:b0:e28:f6b3:3666 with SMTP id
 3f1490d57ef6-e2bb158606emr808276.7.1729230455199; Thu, 17 Oct 2024 22:47:35
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:13 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 3/9] perf test: Reduce scope of parallel variable
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
index 381363fc766a..db6cc83ba505 100644
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
 
@@ -566,6 +563,12 @@ int cmd_test(int argc, const char **argv)
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
2.47.0.105.g07ac214952-goog


