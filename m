Return-Path: <linux-kernel+bounces-544284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D977EA4DFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423283B2AE9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B93204F6E;
	Tue,  4 Mar 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVqPUoBs"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF20204876
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096221; cv=none; b=Ay+WMKVk64PXGGI7vztDYzqapWMsyrMvAMpVYVieWQ6Xki9zd88Np0aO3Gsr+N49Z4OknjdKS72rl7js3wzqQQtKGrmt53Jus5Kz0lvagxcb8NaN5pl8pFvdhIv04hSAaMnUfKrtwMKgI2UT8JBcE3X+0BEdAKnOkvXOoLb/MyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096221; c=relaxed/simple;
	bh=hRzu6kp4SOTwRfsDfhB16qNKM3knvwFdXsrorg2sjmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHu7s1x8GHkfKYco6UcNidUyWdPc9hlF/tGZDx9uQlugKkqAi7u795GCxia7Nh6hhi1sfcrryFYJVDfJKv3WWgdH5QHpvm7ifb5w3moPrjYzpAqTy8izyQS6jFPQKuTNMzvu0Os4Hb/SUKHCalQN1zMoNTWxRv0GZYR8f7DohOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVqPUoBs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390edaee0cfso3164968f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096218; x=1741701018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRHArMWT/Sx8ZVXkckGXvrA6XesJCKhcfFByDHuvd1M=;
        b=BVqPUoBss8NlzXWXN66ILA4bV2Dg13/uv+cErN05NEU9gVZ+WaHtqdNdHAn7HmoODk
         uKmcYe91zerCdFuUz0hYLVX7kkdVRXNDg/GTN9bM2tmVwcdlivVeuWpdYZI8yTUx1rMM
         H1cBu/O2YzK47BFR8P8ISQjAlTcuCzfYxPNVdSX/Ns0nEia8RKobqsX67sa6PMJCSu0d
         1HmWeDJ0GD5ecvhMXNfHddQEGbdh6JV+fUS5zhUYyE6MTPUvFFljFKlwQFFNo2qCDNp+
         b/Qgm9KmonZmVwgYALHvIXHRuHZxiWQ/91EC0HghlCgbTz/YjJfqKx4hxfrWnWMIfnJ7
         7qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096218; x=1741701018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRHArMWT/Sx8ZVXkckGXvrA6XesJCKhcfFByDHuvd1M=;
        b=lAqyk8A+4Ufxn+sNEAT/378l7Mfodk2rfIkAgGBF1S15Q/Do9VsFypi10iZqOtfoQm
         /tdocyoNjAvXq8HbipdxE9rSpKdPVHk7FlxkEYKCPJuQYujAcj146tMhwwxiQcluohWG
         lm0AM9FZZE0Jq5BK4f67KfbqWLffzNozTGVWdrgVVjFYspaceb/3quzkHvLCszCQXxDe
         8F9lUTfca7yON8l5/33EeJ8dq7TNrtkfB3RIXLmBDkzPJTxx74doOXbmKw8pJS5iBSC+
         c8iU40xwuRzAeurbeIowRovWTbtZkNahTKW3S4SfcKGzxu/n/DCAWsWy1Zoq1rHThBHj
         O3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHjY/r2Ru3isRbv4ofVuPFf4F8/8o3ME+7dTQh3gCwpWxCdBFUo5P2jWb1wILYxedXjTSK8EhJs+tR5DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeThL0kK5QKgt7bCrJeguqjTxiG9Xgpcsoiq+r7reORfpd/Eow
	WNorcXjXUg5CF3LJUc9pWV5ktxIscqaRZ4IFrofnlD3B2K+7B6QypcfqWl9ZPZE=
X-Gm-Gg: ASbGncvgdgvFKp16YWg2tDSaNIng9dHsOjz7XklqkGTTbELcCdT66AXkpKmfC1JIRKg
	tk749WeR+8tyE0szCMGGu+/QOBI/WgW2JZdCbn7yLd27goUUP4faYsBgXY+DeE71Rju+dpRiu3v
	O+xiwnH466RrYdCMVJq3IuK9lE1wLwaHtlWJWLp61XMvBAj2cTBSS1CPt3zn+HCqKsj43cR6DvH
	OHwFogaIDjRKFRVabZ1kacbkG+954gObOLLL5RY9TbqwePGRvdaz3qmxRRmQNNhd9qDTgwaM9XI
	mH8ZyOuH1ZSW9IfXen9VpbXfZ5kNuCgEEBtXglALLcc4TAS+
X-Google-Smtp-Source: AGHT+IEmlyWKXFsEmvTB1STpuKG7ePek6osp09kKieoUt7uf/fFOTnVV2uNEUjj2FiPFbEJGtMnXfQ==
X-Received: by 2002:a05:6000:4029:b0:385:fd07:8616 with SMTP id ffacd0b85a97d-390ec774897mr15404671f8f.0.1741096218001;
        Tue, 04 Mar 2025 05:50:18 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:17 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 04 Mar 2025 13:49:15 +0000
Subject: [PATCH 3/3] perf list: Don't deduplicate core PMUs when listing
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-james-perf-hybrid-list-v1-3-a363ffac283c@linaro.org>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Commit 7afbf90ea2e2 ("perf pmu: Don't de-duplicate core PMUs") fixed a
display mismatch related to deduplication within a single PMU, but it
didn't fix the case where deduplicated PMUs aren't listed at all.

Fix it by using the same function which takes is_core into account,
except in the use_core_pmus block where it's always going to be true.
Before this change, -v would be required to get the same behavior for
core PMUs. Now it's no longer required:

Before:
 $ perf list | grep br_indirect_spec -A 1
 br_indirect_spec
    [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53]

After:
 $ perf list | grep br_indirect_spec -A 2
    [Branch speculatively executed,indirect branch. Unit: armv8_cortex_a53,
     armv8_cortex_a57]

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmu.c  | 5 +++--
 tools/perf/util/pmu.h  | 2 ++
 tools/perf/util/pmus.c | 8 +++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 57450c73fb63..caff0d309012 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -834,9 +834,10 @@ static int is_sysfs_pmu_core(const char *name)
  *
  * @skip_duplicate_pmus: False in verbose mode so all uncore PMUs are visible
  */
-static size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
-				   bool skip_duplicate_pmus)
+size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
+			    bool skip_duplicate_pmus)
 {
+	name = name ?: "";
 	return skip_duplicate_pmus && !pmu->is_core
 		? pmu_name_len_no_suffix(name)
 		: strlen(name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b93014cc3670..ce6a394a695d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -297,5 +297,7 @@ struct perf_pmu *perf_pmus__find_core_pmu(void);
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
+size_t pmu_deduped_name_len(const struct perf_pmu *pmu, const char *name,
+			    bool skip_duplicate_pmus);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index cb1b14ade25b..1acc27af4d02 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -358,12 +358,14 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	if (!pmu) {
 		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
-	} else
-		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
+	} else {
+		last_pmu_name_len = pmu_deduped_name_len(pmu, pmu->name,
+							 /*skip_duplicate_pmus=*/true);
+	}
 
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
+			int pmu_name_len = strlen(pmu->name ?: "");
 
 			if (last_pmu_name_len == pmu_name_len &&
 			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))

-- 
2.34.1


