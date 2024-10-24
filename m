Return-Path: <linux-kernel+bounces-379371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84CB9ADDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D90B21191
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0921AAE19;
	Thu, 24 Oct 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAhqF73g"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25451AF0C9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755219; cv=none; b=QyOs8Vpj2r8RnwqXBsFu6u20ivTyl4Beg1UH+FS8vMycB4kF+XJbhCmmfy550M689SVOm8rHk9sgTPK2shEO9DfwJw3BxDPQCpAb5tVfT7gvk4bppoHdsfXVRsW8AytxHYebVqxO3HXCK1E54sgfRna7kSKkF915mxmKpDq7DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755219; c=relaxed/simple;
	bh=0odQGceZNBTkUJ7F9d7VELVpW9gytwTlwU17UG1a/+U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o6xvTZ01H7y5+M4IC9Hqj3Su9aXKw4EcDYWC2dzrlQsXVBFwwa2vvu9Td/oBSVprsUWh2ljEybaA7Mk60ezL/HbRlwZlIFlB95WwfMUVFgjc1nTv/dIvAyXpLab6M7Ndp4ENNWtiCOFROiJLAVrQjrR+f5v5IoE7NMJRTqmj5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAhqF73g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so12554887b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755217; x=1730360017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=DAhqF73gMsdPuRr+r90hmQB7GUvP+OwUu4nVIinIp1c3c5cYUQrBT+8BekrsAR9cJw
         8qY38NEzOVk4ea4HJEBP/VygbFGZSko/kbLlaymTKZllpsM+jaPp1YX7OfUXMq6Rfnj9
         AAmkoPdsewrsBXF5I7wcyDEGSpH7z18fLEwNu1vY4+M45f6KV2hguf4IOM0wh6nc3gDd
         OIEFqJBJBodc2sVkXD/zL0c5Boe/jg1/LLaXvY7Z9IqxlwJmhWgqcdGES5/n1gutlMuk
         5hkDk7vU7UILqGLf3Df5lAe+4MR6/Q64NEGPulkTEPF49jH5EYEQZ4V/Guwy21o0mX2C
         ZQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755217; x=1730360017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=eDFbHAfPwVJU6n7q995dwie9GLJvlVXALPZOxTSG8l/GzUP+WQ+oZGW7Q/nZkxTSGM
         WIQmgNzaD6nnxC91r23m/z0dlJKmAgEPjEmnTyshHbgycwY8ypByjHmHtIa5yM/Wdofd
         tkwlf2FO5aXBzq9z2TEdUXpZlRTCgm2CmtJi0DFJACZuGAiRpGVcvgo7Z07oen+SGeDr
         eYzA76PIoATH8cQz0w6y4L1OI9iFggSzRKS6xp/cPVTiYdYLjdpPP5gXRSqvcuVZ8Es6
         D+JJFJH3/ZiRe6NtvPBcI5f2AdZT8dy5H//YyZ702NmmvF0wA8VXWJeZ1p0jeYlx5rSb
         AOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlu0NbwHDqDnK70iUlcV/hOim8vPzaFjUv55sj+p64aS2rJ9LG4yMaQohm5HY34drxRzrCEQrRKoONhkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJnEeL+zwZgClUl3z9qg6Q/zKS7vuRCkDnIxvlD6p+T6nooLc
	r/uIfd6521qt2cbcOSd1PR9X73tKvP425O0j2okJQcIWZAKLDsb4TDW8GqT8CTjLQAaJIL+yRnS
	08w9ykQ==
X-Google-Smtp-Source: AGHT+IFFtCAXX1qu6Kjrfshreh94FSiauh3ke22NfApbqYF5WQtwb+Vjg397ye8X47fUQ6CqaBJChB4TkWZg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:4804:b0:6e2:1842:c2e9 with SMTP
 id 00721157ae682-6e8662f961dmr528997b3.4.1729755217042; Thu, 24 Oct 2024
 00:33:37 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:18 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 04/10] perf test: Avoid list test blocking on writing to stdout
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
2.47.0.163.g1226f6d8fa-goog


