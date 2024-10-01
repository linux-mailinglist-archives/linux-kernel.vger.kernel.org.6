Return-Path: <linux-kernel+bounces-346405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB698C45D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEAF1F22453
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790091CC15D;
	Tue,  1 Oct 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKHwz/3F"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4A1CC14A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803198; cv=none; b=Jt07Xs6TUEWorhG8ylLD/n3lOOjho2/BGNXe3+aedp7wpn7AZxbd9Wj8okukC6QtvCiCL2JefqO7nE4rC9ZW6UiRVRiHS9qV+OnuvKwe67nvqG6rfpjiUnh9E1XEecFAgeUjcA8rLvQX4peZf1jwmiOY7CpPTn0jYGe6yXDVwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803198; c=relaxed/simple;
	bh=D1I+znErvv2ZGHk/hWaf6nv2rg2aX8WrrqG/VhGXPe8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KUEiV5Tl7WrC0xw3DKDhPsUPBBQtIy7ntnzwuoSMtnt1xOKyS3QmDpy1OUnshT2mRjRM7VeloWGEMsXqX1PE3GR9U5Ril8zPvmraSw0ayCYFxNfkTOJBj6FkYnZrMZ9g6pbLiiJWHZo3Jy/SW+K5wVie34qGkG2glX90o9Nw7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKHwz/3F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so114776047b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727803196; x=1728407996; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Yd1Yr53YrfxOpH/9lpq+3hnpf3dAFLQn+BaRjtdhC4=;
        b=uKHwz/3Fiv42TsEFuEdWjPDWeObIJeV+m/HkcIcLWANpn1gIfPPv+S9VI3j9/ohzDO
         BafwKYt1GNhgRCUrsR4RsLJsEtNuj4lntC0NFgk3j8dowDw7F3z0MklT7ZMFIbRR53X5
         3xTpUB6TONbMqvy8MZqokjQoChp3ndEz991MaZGqgl9UjBZKpUTFSedt4ZSl1uEiDnkr
         s47Hs0+D6HnH3OILXoMmQ8rG4aL+a6ggYLMYAVjEbRZIq8/6gphf9TyS+Hxst8XmDf1M
         bAzlJwNMnEmWFvipbMnfWDkCs4jsAaZ9AN8jN0BEogvfVZoi9LBpMZf1ZHAAFTDToAPN
         LjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803196; x=1728407996;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Yd1Yr53YrfxOpH/9lpq+3hnpf3dAFLQn+BaRjtdhC4=;
        b=kWVGfL51rgXVRzuS67rjpzB3ZD0hK/BAjd/ULQ4YUa9Y7eSAFxk03ndXjyWzzZ91Ag
         onha+2YZr7lgoHjtQlc++32Ze9QxksPNYsQBETWtnvyjvjhgISpRzaJfmSExHHMKcJaj
         D3bWhCvlppozGPGm8DaLsO0F8dimn4yLX1PqYwE/SBo75jNmzXHTu2zdSKqpjt0JrvDN
         8Z7ewNdOBawZIJB8KisKKAI9SD9H61GwPTNvIp9fezlUjRA8zl80R5Fh5BMLg9zXTRHR
         3XFCPY9jkwCRCUqLv4yyOLJDfNnaS8PXFjSsqZJNB3qlHxmrqDdgDzBfYgGU9Qv4zgmk
         EfBA==
X-Forwarded-Encrypted: i=1; AJvYcCXhyKI5E2u467B4GJiabZG4f8ZLJ1IB8GYFE9ATYlQip0GiFu6dIjxAZGSZkb1BGa+FAFe8QmGn2VJ4sns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWmRYCPiA4XP1M078M8clFIXQxTSSegyABzv0DF5GIyHks+vY
	BGbMFEthdOSuP5YH1lrsZqxc/HB/cff5Z12O9vMLk/a+dZCFZBS0M02bolJNrzQwHzOHsUnYYEH
	038368w==
X-Google-Smtp-Source: AGHT+IFfhaTN7/d/0WbE9K0NB/X4JlB02wQpjBnPWWGJq7hpMZFevNVKUFYhXFCPwGlP2oFsvgkGAHoCH3K0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:c10:b0:6e2:ef1:2551 with SMTP id
 00721157ae682-6e2a306e3c0mr65597b3.8.1727803196476; Tue, 01 Oct 2024 10:19:56
 -0700 (PDT)
Date: Tue,  1 Oct 2024 10:19:48 -0700
In-Reply-To: <20241001171950.233723-1-irogers@google.com>
Message-Id: <20241001171950.233723-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v1 1/3] perf test: Add a shell wrapper for "Setup struct perf_event_attr"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "Setup struct perf_event_attr" test in attr.c does a bunch of
directory finding to set up running a python test that in general is
more brittle than similar logic we have in shell tests. Add a shell
test that invokes and runs the tests in the python attr.py script.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/attr.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/tests/shell/attr.sh

diff --git a/tools/perf/tests/shell/attr.sh b/tools/perf/tests/shell/attr.sh
new file mode 100755
index 000000000000..e094f3baffb7
--- /dev/null
+++ b/tools/perf/tests/shell/attr.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# Perf attribute expectations test
+# SPDX-License-Identifier: GPL-2.0
+
+err=0
+
+cleanup() {
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+shelldir=$(dirname "$0")
+perf_path=$(which perf)
+python "${shelldir}"/../attr.py -d "${shelldir}"/../attr -v -p "$perf_path"
+cleanup
+exit $err
-- 
2.46.1.824.gd892dcdcdd-goog


