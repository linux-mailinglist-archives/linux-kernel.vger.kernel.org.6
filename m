Return-Path: <linux-kernel+bounces-445574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E849F17CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DE16BFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FD1EB9E2;
	Fri, 13 Dec 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA48kZVA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A61A9B5D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123888; cv=none; b=cJfxnHLHdK7c/G67d1gHf8zIL4aj9eYtVEsgUI/P5eKIGhALAz/IdoqXwkMuZgm/Jcem66jBOxciXnAZ4hVb2Kqfb+YsUSwiZw2SDxjaX/K0Mj/LU025BoZUpBX+gvrUc7kaBhLKt9w1AEA8z/fhs0d5xxLme6mcpEpS4drmgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123888; c=relaxed/simple;
	bh=5BfNct9byh0W7AC8JMgEtJwAR7Xw+iCYGpMPgd4MCTk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=InKY8QJhUfVk5HWi1QRiJ9RF+GvepqwSghGIgKSpHTEBpIlPptAsh4qGTN65knm4p8szc38qRct+j/xnkcraO83n0UeutIcamkbu6Hq4/yPQZMvoUHku6d7FuTU6gDIy2QJ2SXYaXdCuOiH5FE9uAIvqxOgJhYwx75pOSYGUpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA48kZVA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef66fd6e78so26784467b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123885; x=1734728685; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qacuxPXKAwtJm5TN79eg+JxRwsGOSsBYxYDQ++eqYog=;
        b=XA48kZVAUrfWTBDXjz0jXrBBzFbDknSBz9MSMzV17wcTW5cBoomstUvDr4fXk9qLHE
         Obp1zaBIPtdK9UxUsBvezfR98ALdmz7bHv0EusHE5Z2qO+BRGPjFr/jAVBa4YxLzMak3
         Bq79DQIUVm7yll7HFmrbBAYZzOf36+KkNnrgvauJTbCh6M/4tFQLUV5d7ddzXDE0zpt8
         0MrRE65swRWmKon/Z7hMX6ERxCQoffIgYCMkLbmBdmDasrknJWidDce5tVcIxUVfHcqo
         2P1o3FY9rh2x2f0bVP2jXQrxYLR4/joHyk5YUBm4NIPU8l61pEnXXq9afxB4trXVaT5H
         Vkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123885; x=1734728685;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qacuxPXKAwtJm5TN79eg+JxRwsGOSsBYxYDQ++eqYog=;
        b=tteKyDzjWrxGQ9+MMAp3QqfcG4kB3Tt2DnB0dzSDiUqclvn8uxGzgamjAep6H+6kuI
         96FbpoAqQLGX5rHRONRi0fWs1vzk764rEM18kvY4sfve/BnZBoq+AEiLjSH0kMLIzNLe
         62fTSQev/V+0Qk42eDXamCpk8ijk+u4s2pfh0ASZasg0trAaRRvn52IzbdYf248q4NBf
         YtMx+JlKu/fkZoAemG37SDVIuujiea5UuYKoK7qqDNivL2QhCGfnPXMZWzQsoO256Pbn
         WRzv01KYbMGJSw2kWEu3DJQ8cjszw38m2HfxmO3jrQ5WhcSJtM0TdUXTWI+E18x5/opA
         oYvg==
X-Forwarded-Encrypted: i=1; AJvYcCUPN21vtcQEFUK+l93B8F/oNQpW0rgk01wyP5cKLEoj2WKF23dBmPgFYsNhE+P4+MUQtGpNXrwRVEYwDh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu58YzYvRHhCs3VcTDkCucSXFO50rIdh4LSKCd6WKH3HvSzG/M
	NWGh64n5m7sA8StlfmGuWcQcfMqJBBRBgljVptkJkwjh+w42Wa9f5fgzE18DYAR9Ny/zEMqSKO3
	5rfa9gQ==
X-Google-Smtp-Source: AGHT+IGqgycsnZKrksHy4v4iYMpl2ufouZips63Cp16d5p+/jtwg0UiMEdUsO1fDqochqw+p2D+Qij9DCsMk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b83:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6f27a84e636mr66297b3.0.1734123885537; Fri, 13 Dec 2024
 13:04:45 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:23 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 6/8] perf maps: Avoid UB passing NULL to bsearch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If maps_by_address is NULL it is UB to pass it to bsearch, and will
trigger ubsan, even if the nr_maps is 0.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..1830ae776052 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	while (!done) {
 		down_read(maps__lock(maps));
 		if (maps__maps_by_address_sorted(maps)) {
-			struct map **mapp =
-				bsearch(&ip, maps__maps_by_address(maps), maps__nr_maps(maps),
-					sizeof(*mapp), map__addr_cmp);
+			struct map **mapp = NULL;
 
+			if (maps__maps_by_address(maps)) {
+				mapp = bsearch(&ip, maps__maps_by_address(maps),
+					       maps__nr_maps(maps), sizeof(*mapp),
+					       map__addr_cmp);
+			}
 			if (mapp)
 				result = map__get(*mapp);
 			done = true;
-- 
2.47.1.613.gc27f4b7a9f-goog


