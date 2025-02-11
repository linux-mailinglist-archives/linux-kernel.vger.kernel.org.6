Return-Path: <linux-kernel+bounces-510075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB44A317C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA337A23BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D34263F49;
	Tue, 11 Feb 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Um0tHsY6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842A2676EE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309502; cv=none; b=h5g2NaOCmx3oys9MpdoBkzm/JpnXgFUof4n1qVr2AfmVhtTBesrE41B2H+UdpdXaHKouOrao1llthIFmhhOJ2c0QiHa7BT4u9eEhXzMgU5C+OIiWlYhRjrLiMgbpD25BWAwb2mzcZPoAsWSfH7YAp63PlYM+pXchfkvTy2061p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309502; c=relaxed/simple;
	bh=BFPUfUPV9C28sQ+5++oI/Mt7czcCX79RjU67ZXHg4wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tYrBh0OpgVMJGdZYBv7+V9y+GBuExdno3LUrTyBJUh8BwxdHFDAPWx27jE8bmPO5fj+jX870hTfcl1QgR11UJ4C1E0BEfkfSdQwo5ekGkxSLSB8lGdoEWAABSyQpaPJ8udvZLV5UgHw9WUH4BJJ1cTPY8jaQhLUYnkXhPnrP/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Um0tHsY6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f46ad8a390so76949457b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309495; x=1739914295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=Um0tHsY6LT7ErnQ3IgXlt5x1TUJXQLHyhzsFARvM7H/bD66BlktHfp/t2tQKT7Uur4
         5wONkOzjkV884wT+MFrDSgNW8rTCOZPFCrLjF36CW9SJK6bOh58M7O5OgtMWzrhauhuI
         H3RGErGbWC2lewru1bhzCCPsMspzgH9XftwA6GygYhzq3XFVL7NgMOo7osbWOP/L2ccc
         GOVoyKDPvdkr9pbnR9uju1CbcIZxImXK8LRg7ry3RkBREDe63T1ebfpklO9vi6InGIdr
         PmnIMofmTsUMhJpAInxWEbSnMBYT461FJspDAYRpDMAAY8V7CO70phJn2MTvckivDc7Z
         A9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309495; x=1739914295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=tHgxT9tvp/D8mbBzs+P0s6If1TEamQtBSJSGgzr4NFCajAwRlCcx72rq8VmpOsyNLO
         bAVOz9OAc0RWzTs9QBhHhjmjWj4cN/TxiYBvUsjn2R2ib5oCkjvzehjVhZ1rNW3zjP4d
         nU+lbv010KQzIIOUA8pG6U05qjGEaQlz4k456jGtRIdlRubxD8KUodCK4NR3lX4poJog
         szjdorBHCQ9jiQkI9t3G4qGWxd2x6uEhy9/B1u0cqqopbCwaQO7RMHDADmxNG+dOqED8
         F0MMrpX9KMKlvFPekGRWcNbddrdHudPfesHNJ4nFCXASr0gi978kgo8RuHcyzbVxL/7a
         s4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6/MXWR22LPU1pHBgqWOGTHVmURMEpaUIPhGFBIQuRHiEGd9Zt6LK8eeUyqMTcdPW3BtX0QFkQoH/KfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfrQQnPi3aHX6EO28kxt3Gew5jRiF8AMxymERnldFDH/2KLjS
	BMwoZIP5furWbX5MbG429Nqo1tgXIbAcdq0+KGB/bOECQfHIb5BPSmZDSRD8XeZV3W+rtaTzzdc
	L8OnHeA==
X-Google-Smtp-Source: AGHT+IHcP+fUgMI7D5VP489sJpp8yrK92+IZGMsVKgnNa6+/ErAQ38Qw7fxa/sOVeZ/4JY91WureC2X5HHwn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a24c:c86a:18a9:d15b])
 (user=irogers job=sendgmr) by 2002:a05:690c:5509:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6fb1f5957bamr98667b3.1.1739309495526; Tue, 11 Feb 2025 13:31:35
 -0800 (PST)
Date: Tue, 11 Feb 2025 13:30:31 -0800
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Message-Id: <20250211213031.114209-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v8 24/24] perf test stat_all_metrics: Ensure missing events
 fail test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Issue reported by Thomas Falcon and diagnosed by Kan Liang here:
https://lore.kernel.org/lkml/d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com/
Metrics with missing events can be erroneously skipped if they contain
FP, AMX or PMM events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 73e9347e88a9..ee817c66da06 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -20,7 +20,13 @@ for m in $(perf list --raw-dump metrics); do
   result_err=$?
   if [[ $result_err -gt 0 ]]
   then
-    if [[ "$result" =~ \
+    if [[ "$result" =~ "Cannot resolve IDs for" ]]
+    then
+      echo "Metric contains missing events"
+      echo $result
+      err=1 # Fail
+      continue
+    elif [[ "$result" =~ \
           "Access to performance monitoring and observability operations is limited" ]]
     then
       echo "Permission failure"
-- 
2.48.1.502.g6dc24dfdaf-goog


