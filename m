Return-Path: <linux-kernel+bounces-397330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C49BDA8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99231F23FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DA7BAEC;
	Wed,  6 Nov 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMGLJB7W"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF110E3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854110; cv=none; b=Q1obXZFvv/V3C72LP0NQKPQ/D4HPO3tjnR5+P5crbxhayhMek7CEE7G7bu3wVGQnN7lSQi7hR3QOHUJd5c5yB7lSBos4HsDSYaVTcsGCC9QeLmc45Wk+XafQ/7/XAlOadtIRKmSHRuuLEGZGXrlD2jZj99UevOeu0ScWmPuxQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854110; c=relaxed/simple;
	bh=9I6xl/pCNtYb3pgbMGqxTrPrnk7hUSdh2wehgp4aL/0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YmODumuWRuZdDrxC4zxJPTA0dy64si7pxnOI8LVq8Gm0IhOPgtJV04xaNGOSL6JZ5ZG5jrxXhH/71n3j96kVkW1r+jDDjawQbHo34zrsaGN6Nf8xqRazQr85Gv1QCJeS+JhlmV7g1LnJj1YW239euu8AOl2sezoqHyDj/cQ/VLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMGLJB7W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso9784562276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730854106; x=1731458906; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYd57AoGodRvVgwIHi85ZBfZjyzkHdyJhjySvflJKD0=;
        b=ZMGLJB7WUhtq/nE1s3UeDjO0KNgsDo6DKs8Gz0cteN9z2vbjK+01wZ6c9hDBq3lMjz
         RgSFstfMrv7UYzYAx+p4hQdMT7MMjcZSygYokzVW+Ip3og7j6HO/8R9r0lPr4CHtrZdm
         McjZs2wYtHAd0MkCQYmsh8wtBcoAV1VA5SeOCbmFgwPp+LduoknEl77Q8rHryYJzsYC+
         3KFA0DBviyxT6r31AsgSZrNV3WSdJIVJ+GXcGFFt5Nwhm57xAy1pET5GD8KO3ifvuwe1
         jgdVn+NjpfRjoHLq/8Bz5BWH9ksn3JetkC+oVd4diV8e1m/Yf+wKed4TgBT7+2aAwAni
         v4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854106; x=1731458906;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYd57AoGodRvVgwIHi85ZBfZjyzkHdyJhjySvflJKD0=;
        b=G5edIydm7KBWnp9CinOh3oz6eV5TEESoTS310EeMvEFvCSYqSKezRn0dzNypWIw62u
         l+S4t/er5upbhSwvcJwdYurrPWmmhQMsbDYlq9f/9twTr4OO4UVZTXZcm6ZMZwQgeiUd
         RWMNvNzeqy5039Ecfr3qOyj0PLu5APyq3FhEQKbuye7LP4XqD0wq8+/+Bjnhtebcdk4F
         7xyI9+kEEft35k6Vj6JWiVZnW6LwlfoQZ8EEzvMU7xk6zIuRpMOpIGMyy0Z+rw04Epmu
         j5I1Ip/0bLuqmwYESuzZ6yay6eNJ/x8HvAV3Aza9I7VfFOAhvfS3o0jbkpzb7+/qJ7TK
         +1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTW0DJqjK5pjzgVvgSE14nxkwjLCPRBeb9h4OJ4vbf+A5p0X5r+tlpNitOQOWLHXeuMiBrvTNVF0+OGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6EaU7UMvNgYvCuIf16CoqtSMFHQyPUFXY/XWZaqWUmtmiP0j
	CT7PdaYNi0BfhqCUOXFe0382OrQ70+hDsjb4YDYYCfDRw3m0/+LC+GrKGQGjuKfj3S4/YF+bnLt
	DZFJI1w==
X-Google-Smtp-Source: AGHT+IEObSlB6Ht1DmKatDDLJH5puuB4Uxp9+SL2zbA9P+sOY39CyoDGJ97g9J4RcN87Uji5jwYp7xyib0mX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a25:9b42:0:b0:e30:c741:ab06 with SMTP id
 3f1490d57ef6-e30cf42ddb2mr16401276.5.1730854105236; Tue, 05 Nov 2024 16:48:25
 -0800 (PST)
Date: Tue,  5 Nov 2024 16:48:18 -0800
Message-Id: <20241106004818.2174593-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1] perf stat: Expand metric+unit buffer size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long metric names combined with units may exceed the metric_bf and
lead to truncation. Double metric_bf in size to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8c9292aa61d3..6b531d4f58a3 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -507,7 +507,7 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!metric_events[i]) {
 		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
 			char *unit;
-			char metric_bf[64];
+			char metric_bf[128];
 
 			if (metric_threshold &&
 			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
-- 
2.47.0.199.ga7371fff76-goog


