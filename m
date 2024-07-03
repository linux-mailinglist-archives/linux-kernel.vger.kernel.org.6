Return-Path: <linux-kernel+bounces-239936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 402839266FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3900B242B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D1188CBE;
	Wed,  3 Jul 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tumwyInO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4C187540
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027294; cv=none; b=U9V1dtFtRbWsgKGiEN0cPjI1dyh+WmzPmk57IF6+ppXaAKuy0zrIlfpOaSg94FJVPQjd/dyDTk74aVJmh5z1aiHHnmzk0NFvkaVfo4GxNq9O2KGckPu7DyGTdul+5J3W4Hd3P0EqUrG/IKP79g3mPbW5d+MZlXFWNG77Co+2xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027294; c=relaxed/simple;
	bh=PyUC4JnOx8t49+z9OfoW03gptn9Bhl8DXa2Hy8+Ghhk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=O4ixu0rjWeSt5FyLtnJnjkThxyIkd3XtA0LRG9QU3O6ztnYjYKXgKMXsvW9iLKuvtenZLsD2fw0TOVnB45cTyrgLApIcHGS1T514crugsP2iTWwPJfAb+yAPjANCxThB7rFOWGlcp0r58BrqiGUKSXK77mNLHa8aIhUJnsPahjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tumwyInO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0342b6f7fbso9364935276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720027289; x=1720632089; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0FWSWvUbekODbWV63YGf3s/rZsG/y2vGmr0tGGkdh4=;
        b=tumwyInOQMVTUdUQfOcAnw6ccxJ5a1K0GQPopHDL7D3Hyac94/jprk2Z3A9TIZc8eD
         +60Z5kt+pfvxLd/EFKxnLS2IIpuuwc2po/RWFf8SD7DGe0IuAQKCJCWgszxvblTl9vnI
         VX3HiOWoDj+LWQE05SFUH//AVogKTANegkaVOuOZrTuhVDWCxNiUTFECDd8kAJwLO/kY
         DF3pchQR+urmu+DCf+eS7VkQYkmQpga5KZhFSCALAmdj0Suo0+vci9VGBQ13ixvQOidw
         AvhpU0mpBO+YjQ3WG87GZylDdxsnrmu/Vr0qnqL6wOpSaXk9Fj5c0DYSP0L3PLNElNOY
         OkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027289; x=1720632089;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0FWSWvUbekODbWV63YGf3s/rZsG/y2vGmr0tGGkdh4=;
        b=T52uE5h9jcEnp3bHBG8sYAuWVaQqE7i2SvUVIvjUZ2K37vvuyf9QCVjEyqtBckj8QZ
         d3xfA4drUIm8nS0+Q3PTYTE3fZZscBzz+CdZkvXhgQT9craqpgNc07vPoTvpSvF6KrzJ
         z0syj7BEzj8r4b59huA9c1qnabAoVIwud4D6ekp2IeUq0G7SCsHA3VgqYcAsnEuyvocZ
         KvSXuUv5bMaf+P8UXZx6gswNjH22bcxrFS6KvvnwxUE4jPaQBr8Fs0+1/+3CQEyAVmjC
         kpsvBHDD6dGZVmYUZl/9/YeZ8M1nJMaKCopLiQx2qvOTYRMk623QjY7vAeRKw9Sp5af9
         GA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ork6njHe8wE9n0sIzOQgQlJoqXqArEs3RPymLvYFAd1gdtuAgUzIWRp4WhqPeU3JzSEnYErpJTHSSqdHHhCF7L+MBhMYKQXkRZYI
X-Gm-Message-State: AOJu0YzO/cFklo3FDcDk6wkw7KTPoY8qKrVFBRJyuPugKW9lgMM/ZuXI
	oka2PXqxT/t29PTXM6zPaN1l+0U75mwX90knp1ErqrAtcyWpCwHfzqm+r2iVoeCz3HwAFjECBbY
	mW1aKWQ==
X-Google-Smtp-Source: AGHT+IGgzf2ypPsf+gg7WY15qEpj68EM85AeI9lS4mElKvh7OEaQdift7C8lBXTuoGY+dMzeU9TsXsOPncCe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdc2:f28d:3877:f0f2])
 (user=irogers job=sendgmr) by 2002:a05:6902:c03:b0:dfe:3a4a:bef2 with SMTP id
 3f1490d57ef6-e036ec62e39mr866543276.11.1720027289687; Wed, 03 Jul 2024
 10:21:29 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:21:17 -0700
In-Reply-To: <20240703172117.810918-1-irogers@google.com>
Message-Id: <20240703172117.810918-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240703172117.810918-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1 2/2] perf dsos: When adding a dso into sorted dsos maintain
 the sort order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steinar Gunderson <sesse@google.com>, Matt Fleming <matt@readmodwrite.com>
Content-Type: text/plain; charset="UTF-8"

dsos__add would add at the end of the dso array possibly requiring a
later find to re-sort the array. Patterns of find then add were
becoming O(n*log n) due to the sorts. Change the add routine to be
O(n) rather than O(1) but to maintain the sorted-ness of the dsos
array so that later finds don't need the O(n*log n) sort.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 5e5e05f86dd3..d4acdb37f046 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -206,11 +206,27 @@ int __dsos__add(struct dsos *dsos, struct dso *dso)
 		dsos->dsos = temp;
 		dsos->allocated = to_allocate;
 	}
-	dsos->dsos[dsos->cnt++] = dso__get(dso);
-	if (dsos->cnt >= 2 && dsos->sorted) {
-		dsos->sorted = dsos__cmp_long_name_id_short_name(&dsos->dsos[dsos->cnt - 2],
-								 &dsos->dsos[dsos->cnt - 1])
-			<= 0;
+	if (!dsos->sorted) {
+		dsos->dsos[dsos->cnt++] = dso__get(dso);
+	} else {
+		int low = 0, high = dsos->cnt - 1;
+		int insert = dsos->cnt; /* Default to inserting at the end. */
+
+		while (low <= high) {
+			int mid = low + (high - low) / 2;
+			int cmp = dsos__cmp_long_name_id_short_name(&dsos->dsos[mid], &dso);
+
+			if (cmp < 0) {
+				low = mid + 1;
+			} else {
+				high = mid - 1;
+				insert = mid;
+			}
+		}
+		memmove(&dsos->dsos[insert + 1], &dsos->dsos[insert],
+			(dsos->cnt - insert) * sizeof(struct dso *));
+		dsos->cnt++;
+		dsos->dsos[insert] = dso__get(dso);
 	}
 	dso__set_dsos(dso, dsos);
 	return 0;
-- 
2.45.2.803.g4e1b14247a-goog


