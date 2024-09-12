Return-Path: <linux-kernel+bounces-327079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70569770D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D4228A693
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F11C0DCB;
	Thu, 12 Sep 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFjUEFEZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC213D530
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165683; cv=none; b=TBmL/+3mu85xyL20lVW/tpNr4BOg9vHwQFw9Zma1E3mO+p5ER1Luk21svSOFGJ7+J88wAsRXH7AYaVL+joKvGI/4oTkT0RTPgMC/XeXezTQOfbiey2dL3i93rB3WwRiFEtSMEB/Z0vHD57Bf/dHgHtOwJNdae2DkmMopOCZredw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165683; c=relaxed/simple;
	bh=ZTNWU3MNnSY7ovCjf7wOpRf0lxvteakNNbWNzL37rLE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GBB0fF/8gQyd0/nlHPGtuccLhTRnvqAAq1euNn6fWifruNeNLo6xz0lVQBelH6H2phe8BZ/dIePhLTeNdVcjSVGoY0oFqEZnTDn8B/PFjcifL6UcQTphYaRI6k7DLkZZlKZjuJ9GrAUgLbcQuETBnNSpoCRxN8FTYu2pgkY/zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFjUEFEZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c41dfso1856347b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726165681; x=1726770481; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MqrU1aCvZ5PLoScyw2apjWHZoKwbRrLtoVTExmPRRIs=;
        b=NFjUEFEZVqL/8KaCCBPehumSBn8YL53pEH446JYKImrDQXw3Lcqy0QGkure3gOxx00
         YgJlBdD0UfZ6fWI6l4JasE+KqRqlrywfxez5peodNJqDmtCj+V+GVwWCCY7iVvMmFEvo
         oC+k7NCWmRp4DYI7VkXlMWaUf/Rqop1comFm1hZDjr1/Jy3QWqiWU0yTlzsKUB54wzGl
         YmvrSomPKpyliKciLyKDtXm/tRlEj6WazKQoOtvAebGSCkcxUcQ9ONqRtCmCg1f0E9rQ
         LorOMdgBx1klv8vtfvWyYjE3HH9wq0ZWZjQgaWeDlFVGJDHqYcROX0Bzh/s/aF0ruV2l
         8Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165681; x=1726770481;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqrU1aCvZ5PLoScyw2apjWHZoKwbRrLtoVTExmPRRIs=;
        b=Ga7aIqL1NoTx4Q409fWQV4ZoXECDssjitnrQDrlO02HS/YFGrLIAmHZbaD3kjcebXt
         YOGnVih5GT+bFIMg/9Y6n/W1K7AkeAwKTVeF6qofECkjVXZRvt+eaeI41qVSFuIZdGbV
         m4A+MOcrXtpOPEJ90DCzHVPRh06lBOb7zFE8qkvh727Lcr1jx2DGkiTRm2MOSLHBqpQS
         VfCsz8xYWvpHVnYhOGy5gQh9wIXXU3Vx1p+9fVufsYPKzalwLjZEFe2QvRfhF7t54Jkn
         zAesKfTRVwlSwNZ1fbCKD172QoikFE8PBK7tTRbSOaA6Hiq0woi180NGqMVsYtd96tVb
         zOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlu7swGxFjTFS3HQMJisahF1wjD4ZhJpUjrNnD1aZPObJtwtolykD3fSO75b4P9whlOnnR9+nOXGdo0GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw5OP1CtwivchHw9j8QN/SbpFLO/xinmjee3ohyZAXiAN6bWv
	mRVMHbGagtsepgdTdzRUMIOmE/PUUmoyoZJAZj0oTgyg2AWUK8LzTID8J5/VzsbFYA4i+DLzh5/
	xN4MluQ==
X-Google-Smtp-Source: AGHT+IGv5tmZ+8WWr7aknF5n2SPKyiCdAg2Ml4Evr4pOKELFUjiTVZqg6lMPEe9BL0AMq+j7UxxRH1xsGX9z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a05:690c:720a:b0:6d3:b0a4:aaa6 with SMTP
 id 00721157ae682-6dbcc584e19mr119747b3.6.1726165681173; Thu, 12 Sep 2024
 11:28:01 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:27:57 -0700
Message-Id: <20240912182757.762369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v1] perf vdso: Missed put on 32-bit dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the dso type doesn't match then NULL is returned but the dso should
be put first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/vdso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 1b6f8f6db7aa..c12f5d8c4bf6 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -308,8 +308,10 @@ static struct dso *machine__find_vdso(struct machine *machine,
 		if (!dso) {
 			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
 					 true);
-			if (dso && dso_type != dso__type(dso, machine))
+			if (dso && dso_type != dso__type(dso, machine)) {
+				dso__put(dso);
 				dso = NULL;
+			}
 		}
 		break;
 	case DSO__TYPE_X32BIT:
-- 
2.46.0.662.g92d0881bb0-goog


