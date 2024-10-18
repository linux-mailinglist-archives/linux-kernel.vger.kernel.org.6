Return-Path: <linux-kernel+bounces-370969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78449A347F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF951F244B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EC188710;
	Fri, 18 Oct 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps08zssN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB4188010
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230459; cv=none; b=XlbjgTsDcWwEbjOKUMKuhZ2+UMVK5XANCT21zQzddiGmoyRaZgOmt1+FC18Z6lh2ZBGqxDiaZruYXCeMlR9Ctx03us6Vxh09S1oaYV0VkwCay8L6n4aLORy0jdBsRBesHV4TZM3fvw5f3E9GGS0zvhk/EpBi1rIv8HCtjpASJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230459; c=relaxed/simple;
	bh=8e+Q4WMgAUC2AFJM3Jw3+2noMVxztKU1eVkUFIbNsps=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dcnzNI8mHFMFFtSPZhz7DBPf7HvPEjGCx/ZurGVdpDFaNtuCq3IdF8it1lPsBMjWu2q2dQW2rCIzjqI0f+F9WIYSBLjDjufaEdChqUhODNBhKJhIdHZQ68V2v3SyynZdwIJe6Iz0mWZrzFxmCN6b4pLbes325aE7jaH3sOvAlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ps08zssN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e389169f92so36843737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230457; x=1729835257; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsQN3YhU9LCKt/5hTOi9Jor4dADGagl+y4jf9jVpPl4=;
        b=Ps08zssN5ONC9+CQaSo4wU5tjyplHArMK1p+w5m90xZycfER+KEqskIcNLRjMJaLev
         Dfj+/47BTpFPIKtjhVoTGmUyr58wnhgE6mnB9mYHkBUuG8aWCk+EyS8VOuy7c3AJvRJB
         Q1b6giwrgyqPGzfYOuQFy243DFe+C85JTP4oNPhXqrhZAh5XpY4mVQpeec1pZUjJTnhA
         LAub9wTS4p6ire3V+mX4NMDTYKw4gJMUkX+mX9HxlgrkhJ69B4D6mlP7SqK+o2ux1anZ
         n0Fj29nUfJYUf7RRQPSStWKkL7A/jo8Su7LYXtZ18bT8qhzKmma8OLFJA6VsFKWTblW3
         PBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230457; x=1729835257;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsQN3YhU9LCKt/5hTOi9Jor4dADGagl+y4jf9jVpPl4=;
        b=KgW1UHz2n6EqWypR4zjP8Alsju7TSHL+XXtSXsCsLj7ou9DsaS2BOy9w6kdnSlqXSJ
         SEABXhlx5lL215okN1W0iXjx6zW+4zChjqGnsP5b+NWbMjSDa5oZ46jnos5F/gHwALpJ
         Cy/bkRsHZ3jI96gT/c673O/Ip8i/R5HR5QuE4g62Guz0z0t+bq8o1AV9HPSrqidn38Gk
         9ltQWZt04yNXBio56UbXmGVck7q4BL0goom7AKL+KV+jtr7AwK2ne0emqYhdenhDiTOx
         3INA9MdYZhE6qY5kCV+tIlYmQ4u2+fIoIkCZ91tnxROAVkNP4WHMhN4C6TCYWopxHr3F
         Cwpg==
X-Forwarded-Encrypted: i=1; AJvYcCVMvPYFmGN5Pd4fwRo6lx6SqBHEUjwCcO0Jn9NspzYcO3RDGjwk1IzdvSxtX7FkXY6iSL1t7M1aIY0kZrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c5T/MMTMQ4g8cf8PmvaraKNxqKS5HbXb6UaelelOdY6k529w
	+ezFsKPUewTFwbmAmbE85K7un2VSvmt4g1mb/g5yfx0Ck4KjcMblJqL9Exk1YyLtUtV6FU0MYpF
	kKJd8Ng==
X-Google-Smtp-Source: AGHT+IHSV0g8KfPFuSViNtTcPi2t1fku8t5liAXZpggq3Om56o6vHxc+L8l4VTrp8YyleL4IZ9CPDAkYsoM2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:680a:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e5bfce3afcmr74567b3.4.1729230457316; Thu, 17 Oct 2024
 22:47:37 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:14 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 4/9] perf test: Avoid list test blocking on writing to stdout
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

Python's json.tool will output the input json to stdout. Redirect to
/dev/null to avoid blocking on stdout writes.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 8a868ae64560..76a9846cff22 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -24,8 +24,11 @@ trap trap_cleanup EXIT TERM INT
 
 test_list_json() {
   echo "Json output test"
+  # Generate perf list json output into list_output file.
   perf list -j -o "${list_output}"
-  $PYTHON -m json.tool "${list_output}"
+  # Validate the json using python, redirect the json copy to /dev/null as
+  # otherwise the test may block writing to stdout.
+  $PYTHON -m json.tool "${list_output}" /dev/null
   echo "Json output test [Success]"
 }
 
-- 
2.47.0.105.g07ac214952-goog


