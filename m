Return-Path: <linux-kernel+bounces-376711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A899AB51A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842031F23580
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1F1C0DC5;
	Tue, 22 Oct 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnhyOn2a"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D201BF7FA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618258; cv=none; b=BUahoZOFjPOX9FhfIVWjIUKneOc1GrtIkvByokHoA6x8LVk/6iqAf71zqDlaAYC/2JON0VfoR9TWhqEXFeVN1/LYefHMildRAVvTTu7YFGH0GV+ctF5ToHjgdLYEXHgKJXxcYbn0ZBDt4tErzg0jS2ox5wwZiOcaVOJwYNNR0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618258; c=relaxed/simple;
	bh=GYxmpcXArXMONJWsRe5WPl7DZqsyI1iL6F7x/lVFYsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ja1vR4zKrq29bqMrz5vA4whqsekPhTL7OgLOuFuVfW3E2+eamC0lD8wp7WDKC6thg7dIAu7IsH+uRKZlvQCTkfP6wtFqqJ42zUVPlY7zjea64NIQpnR1V0Hwba26A+oYTQIZ8DC9BlUkrmdhnThyZia/tDpfEMLciJJcEGX7ShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnhyOn2a; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so10291322276.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618256; x=1730223056; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=gnhyOn2azr4kRVP169J0IKEj9kxRbxU71BVnPd3XFaS/ZDv4QcdTe3qreIy3a2zUUt
         M1Lqr2GBGhUjbcD8c/yDQnLE1qgRHrmBLMU+XNRI0ZKJdMa+XEjmZ49nZKsnW/W6SdvF
         LwZr3Np+br7++FL/8PHQuzRd5b103AXzmZOYtpI+zFxqkDYIkQiwOVP2Qg0WJ+rXiqht
         lsU/WM0YOsIC9pqqBBt2dxdE2hFe25432l7PQfZAvoeLQ9smDz3gQpvQe+xNWgE4pA+B
         +HCrtGDLhveRNTG6X2fuOH2rorC2pxUlSSxaAFvCepFv4QdIDEmYrK6cYEzUqX3aQaRZ
         j+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618256; x=1730223056;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=K+M6je+HooWwqkWUAlGeLMokzikDdS0Q0Au9Am3I+cpxlVnl4VgpR+PvLjV85txqPr
         P3WhZQZBAJfqkN+zcik+/Bs8xFilVqPlF7MKztcgOsJc5HyaKNGIA0Ts2JK4Mur9sNt4
         lyTooL3Bh/RoLxCmk2tQZKniE/kr2RV/kcsS36mJAA2/MuR9vM1JjaxUBiAJv5JQQjPD
         bG+OOvfosIfsQsHpySGYNSHONMTHEdWaTM2BRmbimdZCLJvIoOsHbMdjpoTG4CDB7/gM
         pdBWi76jEkNu3kyq+GR84cfI5woHzwJHmgFd1PnNFyH/OaBWRcivdxJYp+AhR9JVPnXv
         8ubA==
X-Forwarded-Encrypted: i=1; AJvYcCWIw88KSZ+Zp7UuoD76PaOBldTd749PdsdFDM+LzpnrtqVHiaayyOWTBsVhE5u9gVYvoE1WhRvKQMEZmPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFhhmjfmIkQGWyUd+zPua6po4AUS/hy+Kv6zsZZEIb5Vq96sr
	5WXtRY+B/LUldmu7AB+H5e+q52LE6GCeOM/kxqjnrylW8FtZgmN9kptd9OetWmnzGoU3TXGKEz7
	gNWCEUQ==
X-Google-Smtp-Source: AGHT+IHOiwWXO2ZHbTfv88EA0bDyZRXW/88QCQ9qRZQo6GdNscne5yPWZzbRQcgZmqadb3XY1CXrBgj64hyZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:360c:0:b0:e24:a393:bb8e with SMTP id
 3f1490d57ef6-e2bb158ba76mr21384276.7.1729618255720; Tue, 22 Oct 2024 10:30:55
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:01 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 03/16] perf python: Remove unused #include
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

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.163.g1226f6d8fa-goog


