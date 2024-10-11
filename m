Return-Path: <linux-kernel+bounces-361887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D511399AE73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8850D282A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512991E3786;
	Fri, 11 Oct 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IluXIpsN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917E1DC182
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684256; cv=none; b=IC3hbVzEJKXNRx345TvAHYlbNQLGyGGDuvV3h6rewd6J19odv9xgOI4EkrfB5soxs75zaNkLNbHBZQNsBzT4nFQ6y3OB+AmFhg/G0J8itgaUCRfH6DAtxkP4TASm+m6XknrDC1xkQxDpkHMTG/ip4uG2MIK3vFKWH21KPmLSK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684256; c=relaxed/simple;
	bh=U1UusGBDoXz2VQik++HD585jShgBarpm5ySs1yN9FYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aj2pq96QiRH2YPZMCgej6gibpIaB5yo/d+u3tSGQZT7K+E1lNWdBghYusB92DAGwsOxqiIE1tIZknOWmCKVWPxj7vFe3+Op0Vm0ZU5NdVPGJoX1ZUL3PXiLFyVMwlMA7I4IBzfaZtVQCUCyz5HscoF7HijCKH/3WEaa5y3SPelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IluXIpsN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e5e376fcso54195077b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684254; x=1729289054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13Gb0Qczu+RyP7NVli2dbJnILTUtWcNY3mpZFWZWiz0=;
        b=IluXIpsNeoZChxzimRLGOo2rvjb9/u1dxATObwn6M+RWX3+L4+ENQo1HFurxRZi6gR
         uYjH+PCRmq0N5/X9hwH6wMtzQOT6GXm+N4AhKW9PDlwmdCpzJQUBLG0b2zD3ywBTTDcY
         tMuFw2lXFNAjUFB/zJpb6tkmhJI+eoN7SCJ5Qbrn8Zfcr5w9WrvArlMqqZGuYoJXedQq
         5xt8Q31pqiJfkx381JQsj+WU4z6k6vNj7PRGaTJd525xNLEXD49QEfM03YrElMcknXUJ
         8U625p6NoldD48QYaKYVfmRxTy8lZqBMujgKxjKMoxJGe4jhFZRSorpZKYSeYrEkerpS
         YUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684254; x=1729289054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13Gb0Qczu+RyP7NVli2dbJnILTUtWcNY3mpZFWZWiz0=;
        b=RkVz48EYb1IF9kmD/askQ9rXfbukX7Wklupi8pYYlxZrP82+vqyYK5pazzU8tG48hf
         BadLjwhvt71kFVvtoaTPu7Ik5IbS1MJ/S0tYGq+M9ktl8NBnbCCfPFJxm+B8kdvKC813
         WgY/TocCJOS8a/Y6HYQDA/uxoXnL3Hmg3Gerdd2QttHAmVqXSuuThVPWZqAj2edL4ztN
         rnYqXOSQ0ihAr6UbQPnscDkwFCeVlzkQYIQltgz7EH1ouNkm77NfTVQH/S1Pvs56r/8U
         o6BkqVcZnOE0mQE/tDD2uyexijU85fLh4WYdmGMqvz+mDjpHptqC5hEhm2awviFJme/K
         tw1A==
X-Forwarded-Encrypted: i=1; AJvYcCUZEd7MKLNKZvrfB5ddLTT58lnQGzfxL24DclSqhgMY304KEZJEIfFTUu/yjxUdYOJ8GWPwWvk5y8P0T9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4wwdimaLoyW+I5TDkR3JmepfCvRU35ziNrwrIEA7g2e4ZXSk
	+ChqwCWgPgEhHKlNGKDQQGy73yPbwqDtRvKP4N8pGEoQaUWRmeRnUTMDXW5bFmbN09Z0B+mDw2d
	6GmHLDQ==
X-Google-Smtp-Source: AGHT+IE11H1f4e98EhsItbxbwHzB0EO6S8fZPPSaM5oenhtdfB16Jd4EVSiiCREhHL4t6gwxg6GG+jPU2FUi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:fc13:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e2919d828f7mr2137276.4.1728684253996; Fri, 11 Oct 2024 15:04:13
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:50 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 4/8] perf test: Avoid list test blocking on writing to stdout
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
2.47.0.rc1.288.g06298d1525-goog


