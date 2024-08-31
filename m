Return-Path: <linux-kernel+bounces-309742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6E966FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2721F22E36
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505B170A16;
	Sat, 31 Aug 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piMKGFgF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F0170855
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087875; cv=none; b=dxVSg1ODamenvASCbUvN4MfApgmoQ+lZOvixVCZFr2gGUMgBTLG4u0iU74Y0sgVN3hmDWbvh3n6c8k5kz1wjoSMtTJgpTMeQIA2QpCRI1MAhIaR2wCFdi8ub45XHCtrccdCDQ+Eiw2BoLtxPo6LuiEM7fQwy/5MfRY1ylQ6ir/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087875; c=relaxed/simple;
	bh=5gbFoYoAAv+z9iYcQzJxmKjtjoR9rkjq5SseKmfmyZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZB3SEjEHI7TkCOPA9r2Jxw1e8rD6P5x2JZ54EOrFiN2nZ7EMHq/wBQZ//gy5jNjWXQSg7XUs/7nNUUQ3p7009LBp4UlVpWxvAB99Lz07mUxE8QeBHVrGjK5pLVaQllrFgO75EmLp7GoDuLZ9DNNuWDhJKf9aeDJeGeCP/PsOfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piMKGFgF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b41e02c255so52023357b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087873; x=1725692673; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=piMKGFgFqa9wQ1E5K2F437ur+RkQq/2mcjFbrElaAr9+UTZChhqSBkxRH+bYcm9d8v
         29F7EQQqoahoIsnt13NTdeaBP/zJAUuvjYnJ/uwJXcQOb91+UiBHAs+vP4ssnRq/4lec
         bh+b4jJBSa0n0gT55xnqWWZ2xtYKI97OuDGgKluKa13d3jUwfOsYE23b4VcaJgqXsRUU
         otB40M3VXHoM3eNXEDe5me8hKdh+LQ+sFoYYNBaP8J3Llr7t/5iP5kvSe/9CS6NggNRU
         cxzncTdTltmFDTgJHniTxibEX0ye4NofJSja4onT5av6kI4dKvh8ojS24ev+HebPDse0
         eifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087873; x=1725692673;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=JXr4G64+Etd5Ax0k1ef0N3MF6f8WN0rxJItva+xHZXb6AV0orTqruNdBekcajwDnjO
         gC+xXBniWlwLK1/VjIHm+/+oSr/oXyRbvMtwSKDFv33OzrH0ZxiQQuY5PDWm5F+/pc6B
         ibq4mdkAQ8J8HAUUCscX0DwdmlsD6ANecwNUOTLXLjPRlgOVNbLFqtPIMiUPGz2pvXnL
         V/jq4ZcARBPjEJpBjTFkuWyXg4hO0uKBeLiQ5jApuz7ZrvSLdEi2BJ+YJbSdSSi65xoh
         19lFjpU2rIox5dgNn09SX2z8tRAEH19YN3qoNG082LEup9UzMs1BJdvCiY1TqDMzQtmU
         5Z9g==
X-Forwarded-Encrypted: i=1; AJvYcCUtr9u6kyjW48lAUIoNHDf333jf472sjV8gPUewnWtwBGlU1Cap7/2uuhm0jVGHILKiU1wA0yKGpas0Mdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYFGwe+VfP9b5yj6HF6qw6cHFpuIjHp6rBfiyVzNcP3YZAz+V
	pyOcjazdpMjx4BBKUQseafAOyoZ8OUhGWBZyV0/msnRvfr/Gwik624PLCUjZs7v6YxaBqWWpL6b
	cKHA7XQ==
X-Google-Smtp-Source: AGHT+IHP+Q4nMc9YeG5NMkEAMx87MhHBoryoHgfbR7qMaWbgos9SQIWlIWLQeYrfoOeLCo+Z/SO7M3dGHGl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6d40d88f6a3mr1853387b3.2.1725087872962; Sat, 31 Aug 2024
 00:04:32 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:12 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 3/6] perf test: Skip uprobe test if probe command isn't present
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The probe command is dependent on libelf. Skip the test if the
required probe command isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 82bc774a078a..33387c329f92 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,13 @@
 
 set -e
 
+# Skip if there's no probe command.
+if ! perf | grep probe
+then
+        echo "Skip: probe command isn't present"
+        exit 2
+fi
+
 # skip if there's no gcc
 if ! [ -x "$(command -v gcc)" ]; then
         echo "failed: no gcc compiler"
-- 
2.46.0.469.g59c65b2a67-goog


