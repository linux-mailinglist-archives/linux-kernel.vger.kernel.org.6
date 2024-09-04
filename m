Return-Path: <linux-kernel+bounces-314232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8196B04A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD6AB24834
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3780839F4;
	Wed,  4 Sep 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIEev/LT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED682D70
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426379; cv=none; b=bJ8HV708TBRLHMkvbgVKot59yyaTyMBCYKwp0k/AVzcG//LpzjQGuZkVZJaZWUM62Prg+uGYWfGED77QFQ/HFncGWOHfz2HurQ/xbdTzoUSQ7r/PFcdIOktDkOdX8Xc2+8niQfSZi72Iq661XwO41/j0kgX55AyoDK8+AS+Bhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426379; c=relaxed/simple;
	bh=5gbFoYoAAv+z9iYcQzJxmKjtjoR9rkjq5SseKmfmyZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nJSvn/DvOAO1BhBhp8KzLOe1iebv8h5edR27A2HKUC8oqaTyLuya2yOeVCnJLK1h7JuDzZ4GJE8HHp3eUmQQkIbFt6bdHCJNTFX8DlEJajoeXXu6pUlr2Hmyzru3Npcfgkn8d1wt0vpBfBR6BTXCOMXi6BgJ/7n3S4Yi0y6SRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIEev/LT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so647040276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426376; x=1726031176; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=dIEev/LT0tVFVoGVDQ8xeMbMYQPfE0flENwv2EnvRzsXU74zXnKv4TmFTP9B6oWePJ
         rok0fsLKGKAnndf7hipzxxEHSuQjt7hsMpVDeA1iCGXfU15Dh9cnvIROrumVN/oaDNub
         dHeO6eCyFhrAHNh4B7LYzOWfhcRC9HceHvuQIrWyr+F1b2cXiedbMPYtuuBrqJL6Bjj+
         s7DL21ZC5XnOF3On/2RF/Ue8AoXxyM8+tFlCbgXR9mNnSPKRFDhxvVKaAXhNMkAbqe9q
         DNxj2Lx95DyZNO0EZr9wP/RqjvDStf+JdUqotvYyJGnCKp5niCRb9aH4o7P2uF5myurv
         VtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426376; x=1726031176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHNCvvAGAccTwrROKiH6oXmaoTXEGMqssDdptckzxqE=;
        b=sG8qNcU2iKUGak/w/6WvhI/mC++cEt8JiIq16SyfcIj+Cc2T6V9U7MSGWWEeb//+yj
         FP87ht1+FoDvkxNNvMpnUXP96EXOyvC/ZFepREFESSYosJ04E6+7aDlCjY2xrYEa5D4y
         +P1eGZ6yMzNHmTrqMNpOGA+n2uo7b5Lb5dKrUyDZHdOvrVI88UQXiSm24G8yGBXBlBY6
         H9aUe6vQl+01GclbVYc2psLfgh8N2vXAn5JiUE4OdrmOgjh22sAmTiFyk1DxwlTJ/CqF
         bZxVyIDcG1JLaJXpREikr7BA6SzkWOHIgxQVhVu6vSR2VOHHfBHNWTio05W+EByeLujR
         B7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4yr+shholH2649Agd5bXZG7Wl3r26GywYmsbCnQ/ctg8nHrIn1nXzhhVPZ72ULKQ2UkbfjtDgcpP+Fq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmYLWqaKqhWsQ8ifpK6+xV0UrTCY+qYyD/T9721uKniOTt8z9
	iDqNJ6k28xm0M8vi0TO/eNIZlt1KgPLs9mGajczRRpT4ICi89qBjVOg6Ga0Psa1PjlTg7pq0jw4
	BpDCeBQ==
X-Google-Smtp-Source: AGHT+IEupBwmUm23ZC3atPykx32oeSSY4wdjHgf0pXl/xtwsMA3w4GLoNXNlyNOOpoOYurol5dpFUa5UWNpw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:c754:0:b0:e16:6b7e:5d81 with SMTP id
 3f1490d57ef6-e1d10adf9demr11060276.6.1725426376549; Tue, 03 Sep 2024 22:06:16
 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:03 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 3/6] perf test: Skip uprobe test if probe command isn't present
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
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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


