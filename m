Return-Path: <linux-kernel+bounces-367237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A679A0022
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76771C241D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A432189F30;
	Wed, 16 Oct 2024 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvRHk3HW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681418A6B8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052683; cv=none; b=oKzow3adS5QLeT0pBrO/E1bbDVrfO4F5LgN/1XvdVJIjcx96PyKUGYBcLe4z1WJ269RqkfzOR2ew/CNYrVr198LdIoEL4UAdwmy1KDVplRPs+W/XRKlsT5Psmn8uSrr1raxwzEn1tE6jdMfweQuxEyL1IQDlw63nN92k1lTwiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052683; c=relaxed/simple;
	bh=bhHQDJnTJ4bocwSVO6+nzPhKgwvVlYSgBM/QGoZ266E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FDEN4Wi0rRlZmK1Iglf0guHMnQL+V90uTnqKtytOKMxtGRvAPKe3JMqakw5s/ZtMKH3PiZT5KiZdlspCEv6Sa5eBShJ8Tr4YWkjuAhu9S4WHFUuy3c0UExp3wdd6iQm3MMAz0Td95AaV7bnGbI1Oh5qGsmvyaRaZ8MrVtY8F18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvRHk3HW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3231725c9so92070477b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052681; x=1729657481; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzM1nmvTrqtIbytQymy654+4zTDkQaKxO+Kef60mREc=;
        b=NvRHk3HWU3mKE3/g82sTr9qoxDJLo5p/km4krRReTHWNLSHm5GolMAVjasphZs1PkA
         X4OenCk0113XMBh2N1fKY/DZB1ijv8lVkFnaZ7KifSMrgwKuGv2KzyvfJozoeNPzQhnv
         xnXWe+UZwUGUV8SuqjXc4pCBXHc4unpXYmQJABJAUj0UPdy7yTOP8Dz0Gac7keTg7NjJ
         q/c2EryYcbds6qQhKs1xF+5CAL5vD3C2v/JGuPT2jv+DaGIvWeIZ5j6AI7x0rHZ2Mq2t
         wOv8UiqVd9VgdqX6+6GKS1PTjd+WHtk2RkIX+f7NXwcfGsW8kce6U/A2L+Av+tVQdVpP
         NyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052681; x=1729657481;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzM1nmvTrqtIbytQymy654+4zTDkQaKxO+Kef60mREc=;
        b=Xg8CEWUShwliun16JYAZZD7ZhveseUrgDDoqRhhcNFSzF1QelE3mnVObM+z+44uWoM
         RTWkCtNhwBMqgGSzRABVZJWzZ4a6xLRli+k24KbK14Gc+nx7qxAQnLFCuRViOluqBGgg
         02TY+g/p+78ThC9DFcH6f5ovYYiDGgHLw71zr0d7sPjXFBeam6ptLyYOtAlw05WVLi3i
         9x6MbIjSKot3tHeAnhC1qjU1t13QTGBicsJQZ/0WjOrDl+rOcOyE+VWQA92/Ryu2xuoh
         edm7Viq2xnV8heK2J+aOENdp0fTu7QeDrt1UslTiMunn/cJ6wCnZBPsEcUDMhHOIiMwT
         dSeg==
X-Forwarded-Encrypted: i=1; AJvYcCUBX0NW5RAHZbtUv9rhZRo8S4h6cLNFg/Iy5UMzFf0gHO3uTJT3azZ+eh52CzFyN4MZugs4qQXHebIHbE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDt08jle0Vdxt0eJx9RSs96TbN83FinuY/VNMcpv67N962UbR
	ZCXn5LGMWCVSydlhRqiL7Q2SJu6n/1m3HMYEH+LoX6hd/BoNJROhHJl+jQVWC9MZdRJgQnaElPk
	zQ6KyvQ==
X-Google-Smtp-Source: AGHT+IHj/KEQGpPTZ4ugd9O5Z+R4HSHPtTwcD6Do2ajnxTnL5lk3DXKs7OIutPqYknLJgG/exImnYAY0f88/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:acce:0:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e297859d818mr2423276.10.1729052681221; Tue, 15 Oct 2024 21:24:41
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:02 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 03/16] perf python: Remove unused #include
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
2.47.0.rc1.288.g06298d1525-goog


