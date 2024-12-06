Return-Path: <linux-kernel+bounces-434411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702879E666E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F26284C8B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86641D63D1;
	Fri,  6 Dec 2024 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fFqmvrw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FB1D5172
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460050; cv=none; b=XrTSc3ZI1KZFHvYaBDjJWTfvpFgXIS+S/4SwaTL0bvhpFgzsng1zQPrngG12l2FZZUBD4XqAvl5OUTUNrBVutAb/Q1tBdDeq9hWl7ykCnpy0YhMVxZ34T3KJFMN6J1rRe0eDYxTgAoBU/C5BIM3OUEq/FwbwKhJycEsu8wBG2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460050; c=relaxed/simple;
	bh=sy3VlSAHvcJviVgcFZMJmc7WftJUr4tw3K+lsQD12d0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OsPY2GLRTRGcfkZH3ZQqVCpfZHwpnmOeBpzZwgglJ1dbp3ebGPQ7Xuqiv31MOgnD9DHUavXQpY2XxAbEKT5hO491mVfG6++ywdIQ7pSnjdTw4RBIi+S9f3SYu4efMvzUPfyXo2vyHT4ZNQSYtygDMsKbkMEgFVnoVSKdYXgmTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fFqmvrw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38d8aaeb4aso2750295276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460047; x=1734064847; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TRhSW9l3K7YWslNZkoYOdpdUsj4ahnHxjZdZRRIcDQ=;
        b=3fFqmvrwIGiqy9GF1+OOOU9cW46/4/c2gQuloJRjqkfKedsYnPKoyOFK3NcgVFz19s
         atHTan8zq30epiOa6Bl6Awf04/U8wEG6tputXb7kTs2byk5IjlcrMVyj8F9BdxVuqLbr
         Rgjo00hwmaoMEvnS58rtCBFTUcAkuru6ARbP9Cv+7iAxF91lIdHJLOqjwI9i0R5JlMkt
         DiaQWZaInzcV8yTEsTMZJYcw75YX2ADdVtXeE5v/9Ib6gkACqqbNQxhfgidWffZSuKkG
         0rud4wZdGCVjwNU7Xj0B8Rr7bea85dyNVVJ39y+eVD2CFxQfy7kS+Tae4kcKgrv01H9i
         7cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460047; x=1734064847;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TRhSW9l3K7YWslNZkoYOdpdUsj4ahnHxjZdZRRIcDQ=;
        b=pFT6D8GGk/1xqMzpasAFDYVkT5Z8EGg8YzrLVuzKOLAlGVwzChKVFj9q1WkRpRaUIP
         h8AI1jPTYUGECw22FHosxCPeBGtLS6Rargx5GGHJIh2nE7cIhH67pX0dI3ELAJl5OvlL
         UQxYlkCXxBAhmqp849w8Z3XJdyTz0LhJlgEHxhvtwRDEDjUvzzsfkVnIcJEgyT1e36hd
         VYQBX7oZmOCBpl6MKp60mGSHA386aBBgJM5bPAy2ai6lDQV8v/+gIO4jmrTBEC2ZxiRE
         GhDgPwbM8w4EboW/PMxD93Ow8iB7768AeYBz9wu7AmihqTA7P8rm/bRnLLzsuYOGQ0vm
         AygQ==
X-Forwarded-Encrypted: i=1; AJvYcCV48aXz66tYPAGWq7GtZhmBuNCs3BBJ9SBxh3uYkq6A3hz//ttU3EuByY8GJFrEgaYnprNe9/GjNtJxn8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxqhqfW6aEW+LXSzsdbh21FNcgtgWZnK5g1Q5GudYOduY3KTF
	7rHQfWObYZ5sJC60IPcpRQIYhPcLsdqXn52TN+Fl3qLsItlr7AYppHZSUMTmXQmtpFPkk2AylxE
	3pDTi8w==
X-Google-Smtp-Source: AGHT+IFE2LwLNaSTO62nxIL6A+u7AnZGRX7WeJwZhuOzG3htBmKYKjKvD2BCbNixg616M4EERkMINqDwdmlK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:c5d4:0:b0:e39:8087:42aa with SMTP id
 3f1490d57ef6-e3a0b07a87emr817276.1.1733460047449; Thu, 05 Dec 2024 20:40:47
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:31 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 4/8] libperf cpumap: Be tolerant of newline at the end of a cpumask
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

File cpumasks often have a newline that shouldn't trigger the invalid
parsing case in perf_cpu_map__new.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3ea06865d4b0..20d9ee9308c6 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -240,7 +240,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		p = NULL;
 		start_cpu = strtoul(cpu_list, &p, 0);
 		if (start_cpu >= INT_MAX
-		    || (*p != '\0' && *p != ',' && *p != '-'))
+		    || (*p != '\0' && *p != ',' && *p != '-' && *p != '\n'))
 			goto invalid;
 
 		if (*p == '-') {
@@ -248,7 +248,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			p = NULL;
 			end_cpu = strtoul(cpu_list, &p, 0);
 
-			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
+			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ',' && *p != '\n'))
 				goto invalid;
 
 			if (end_cpu < start_cpu)
-- 
2.47.0.338.g60cca15819-goog


