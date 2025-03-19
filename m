Return-Path: <linux-kernel+bounces-567918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9FA68C00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ACD168627
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2024254AF6;
	Wed, 19 Mar 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT8nvTEn"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87620D4F6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384430; cv=none; b=B06f82Ou7OrhSbtf7xmE6O5l9+bOs6p4SeDL3C8wp8CMk6mlNm8RQpNS38VS49ABXU45uRGxSso6NPffyW0aDpW3m55XT0I//gW0una5+45+NrjgOJ3rQibnsZJRHZXyINoozUOx4ABshfPwEaZwjfiujtIytUez1CkEiVaJ01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384430; c=relaxed/simple;
	bh=Z7OKUwlor6Y9CPPSkGccOzDohs/lbs3P6mrHMhcYAUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thzd6aS66ev3FkcHtMU/pSzqO0gJuuR5wBxewD1Xkl+WSNaDIoglLj3fmDwpYmM+DdzvKX5qKoKuo144wASBEjNLd2m6OFMSiT9tlQOi5PQJ3oZFNpbufEeQPVd2HVhQrSpdbf+zu1TnB8iwp/ApupRskpMegnqwv+9X2hi30vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT8nvTEn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso29751445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384425; x=1742989225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEGmhoMrp6tKSJUS9RACSKaL0Pf/gr6G5NruMelMYn4=;
        b=WT8nvTEnMDF9DrH2snseexcEhWibpZJoIDjVVpVTUG6SkYotLedk41by5WfmF/Q5b3
         immeZAi6epe0b0FJVxEZ7oIwvs6ekaSYFk8oqqfDxVQ2SFEQTUKvlLm4YfVPHaBQMh10
         rR/Bf81mnQjlB46Po0oqmD+hkBPF68XpNaZo16zPMtVlZvpwlkoevsPnRsUH5T2VKgAR
         0v1+ToM4+Zo58iTFULN97AWoLD9P2f3KsN+bc6bI139HHw/Pc4ttsxK/YoeMlIEUnJ2W
         WlLs/iwpAtdNgMbq+bW3xZZSPbkOJW6R4p6BxEHIjBsIF5Lssm0qK0uptQaCNbJGOy1K
         /MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384425; x=1742989225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEGmhoMrp6tKSJUS9RACSKaL0Pf/gr6G5NruMelMYn4=;
        b=rPZ9zyAIr7dwo7wqTfsOhoL3rTBkGQqKpZLPePKDgaZogeX6vRTMHkpZ6Mv1M7iHu3
         iM08dRqgXQwKdn2wh039m6iA4nN3PINNXilHq5kyPahFRQ6VxA3UAOTK4UvlRHcTsgjq
         UOI2xxVDmttCBKgfK0+dq5f8rNAl17MZzUd2XABGbA31zK9wCXgmWkx0LsbpVnUqiH3y
         oYO6H3+IHl/423XzvmlvfDM+K4vTwjyTFz54VmeDrMd5wPhG2dOV/QSDryl6gn4Ho3FL
         hZISKhNGnq5lYgFPs0pCqj42rblmLglFz5e/eTKCwJn33O4a4MysbLwSJabmztpZhB4a
         xjkg==
X-Forwarded-Encrypted: i=1; AJvYcCW3lo3I8AfwVoIV8eemgWi5GrGwL5miY3lgz9dBnc2KbgnXliporw076CqF5IiGxY4jb5lC6lPx5+vTmr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXw9yC+ZN5KMKmIOl5pDmUjrAa0/d4BA8D5rqcqR+Qacdem3Bk
	mfyr7gBNeRH02skO1sX/yZxETCOqiYPf/cnQadhp1jzrn33ddJ5BXxgnOmnJQ2k=
X-Gm-Gg: ASbGncvRhAhh/NlDtwxsiqZhTTQhV84d9oGLYYxXUUBFaK/7H+xQ6j2ulyRVsWm3T06
	Bbc82eFZtSE2eGMRLgzs4pF+Pc5aKd6SDfWWMyqeDWHBL8xPOcAhuJr4tguo9NMzqmKMk9sxivw
	qMeSVxWdQiYHaGdywL6w/jbbSwXyelCY7Znq1rYcDBgZE/HWYenhMddp5oRsf1pYFUAAYP+4sAq
	12p0yeOKl+wu0/B5pEz9IGpq67BIzMmtFvUDHJSmtBijFSuyAW8ew5wAkAKgN9qQZdQGVQ/48n2
	0wXNBkdezXPWzOSrI+T0jHSTv6QS37WYn4gZhnBcwuW5npA=
X-Google-Smtp-Source: AGHT+IHErJqbLloSDBbOuIMsGZc52pXdp8yVfNacWZgluboER0gYnZa1nw5E4AGXF/1lLUTa3d8FAw==
X-Received: by 2002:a05:600c:358c:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-43d437c1a31mr21789045e9.14.1742384425235;
        Wed, 19 Mar 2025 04:40:25 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f58aa0sm16163745e9.21.2025.03.19.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:40:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libperf: Don't remove -g when EXTRA_CFLAGS are used
Date: Wed, 19 Mar 2025 11:40:09 +0000
Message-Id: <20250319114009.417865-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using EXTRA_CFLAGS, for example "EXTRA_CFLAGS=-DREFCNT_CHECKING=1",
this construct stops setting -g which you'd expect would not be affected
by adding extra flags. Additionally, EXTRA_CFLAGS should be the last
thing to be appended so that it can be used to undo any defaults. And no
condition is required, just += appends to any existing CFLAGS and also
appends or doesn't append EXTRA_CFLAGS if they are or aren't set.

It's not clear why DEBUG=1 is required for -g in Perf when in libperf
it's always on, but I don't think we need to change that behavior now
because someone may be depending on it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/Makefile | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa04..478fe57bf8ce 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -54,13 +54,6 @@ endif
 
 TEST_ARGS := $(if $(V),-v)
 
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
 INCLUDES = \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
@@ -70,11 +63,12 @@ INCLUDES = \
 -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
-override CFLAGS += $(EXTRA_WARNINGS)
-override CFLAGS += -Werror -Wall
+override CFLAGS += -g -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += $(EXTRA_CFLAGS)
 
 all:
 
-- 
2.34.1


