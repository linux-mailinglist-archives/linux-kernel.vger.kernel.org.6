Return-Path: <linux-kernel+bounces-185233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4238CB27B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1962B232B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5397148846;
	Tue, 21 May 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oH5M9QeO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A991482E8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310285; cv=none; b=hjlhtCQ5G0hxHX9Fpq+CM7gIwt9An1cIDGs5znPcrnLn/1agMr83m7+OBsfNkjZS5uUNYKhnX5L8L5GXnhLC6NG/Ve0DhSRnYK82HjSCXMkjgUVrXTx2l5XnZeIGGEAd65x4VocPN5AYtCHhQVTXg4lAIzu0xy6nW5rQBk1y97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310285; c=relaxed/simple;
	bh=tPSaX4kgNdawUQHbzIdUZTi3pOEIe8Q/D+semVgAOx0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AdcBXJWNA1pdiLFzAinDICRtEwfM7EYjNNDM8jnOkhIeGSnI4ago/b83tZirGX65TGnPTPzpViPP0PjIrfg+9tju60OA6vWtbAMy5z8tuxFB1fso9MOtm8cP4E3dm69ZX8uO6XoW1fEcjC96+ZuwGrsLE85doOZuBo4DvYPxZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oH5M9QeO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso22686513276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310282; x=1716915082; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GALuswTvDeGvafJWqEPTd/XeiOrV3kZLnFJgLvJhAUk=;
        b=oH5M9QeOWNJ5FA32CxInPMESnNIyVjCjh/aLTTsj6CqTrWrYTUuFj9iy8yHmUkJJ8E
         B9MeDbzvriMI11GPyS0TKouTQtBOWYKFRumAh96PoxEFUhISwzlKuKSWbdY3iXnboT+3
         5rtZTI8Lsna1Y3UdX24N/V1aRzlO07p/sDupKgTBMBmaQ9dT+QirLKdzK5+4a4MbpLsv
         vgpXEldtscNcLE07NcfdDtJkEXVXLRtLVOeQu/QP2tMJQgL3xHNnIMdwn5lwa/2TsD3K
         7tvtliCDI6aNBhWWwvMBeWGDjWLrRdO5JO4g7mFZe6K65TabhPBv4Av4z8+3W7isIGLJ
         zI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310282; x=1716915082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GALuswTvDeGvafJWqEPTd/XeiOrV3kZLnFJgLvJhAUk=;
        b=scVntJDgNhy4+k7iWIkED2P3FbmVtbYw9ZOSY9cIUatHbLmhsReGPKtiag1QVJEfHM
         TCAuKjd/ZttIZ0ymdz83FEi9UPnZO2qZGCQ/vUKFt5BYBC5lse8LCyrBouRhL1TAZVq/
         qU/R405vl5y76c2oOPrsNcAgVEw0zqgl74EZ+T4BIpcI1Q46+1zFVLveGmn1oiQg07xK
         ikwurjvmw8X+ypt6ZK5QK2q/1r0Ax+t+rarqqtmJV2qADgMNQE982eW4tz0N2GHmb6+F
         TWF6H4ffzKlJd8EY+jLdqBRWckUXEGkqxVZYv18Da8SZ6Xko0NQg6kv9id+goewL5B8Q
         V1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn7r1edrHeVvSwlZRNGSNfFWnLQ5IUYa6i9SEWi2KsKJGdUSYQcRu+WSa8+NhRhqsCvSb6PZU2wcjJQNI4ALtjEgxDsgxf6h2YBLHX
X-Gm-Message-State: AOJu0Yx1XFw9VoK2p5D09QLeuaFS0UoMF8191hWZi2zS6uXJvcjkEiPW
	44s+k4w2WN1FgFhlzLs25JDOgWHjhk79T5/ENTX9T5dsT26sO8n/k6SXqQGvseoLYmRdXfr5MvN
	6o02nVw==
X-Google-Smtp-Source: AGHT+IHyxz1G47wF2s3bV2sJZ7BCwtJ5wIApcqKBerxN0xjf64+D1FZUO9DZ+jkVlmIRif26c1JY6TzDlsqS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:c10:b0:de6:1301:600a with SMTP id
 3f1490d57ef6-dee4f374414mr8390517276.9.1716310282509; Tue, 21 May 2024
 09:51:22 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:08 -0700
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Message-Id: <20240521165109.708593-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/3] perf maps: Reduce sorting for overlapping mappings
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an 'after' map is generated the 'new' map must be before it so
terminate iterating and don't resort. If the entry 'pos' is entirely
overlapped by the 'new' mapping then don't remove and insert the
mapping, just replace - again to remove sorting.

For a perf report on a perf.data file containing overlapping mappings
the time numbers are:

Before:
real    0m9.856s
user    0m9.637s
sys     0m0.204s

After:
real    0m5.894s
user    0m5.650s
sys     0m0.231s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 55 +++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index eaada3e0f5b4..f6b6df82f4cf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -744,7 +744,6 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	int err = 0;
 	FILE *fp = debug_file();
 
-sort_again:
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
 
@@ -820,36 +819,54 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			/* Maps are still ordered, go to next one. */
 			i++;
 			if (after) {
-				err = __maps__insert(maps, after);
-				map__put(after);
-				if (err)
-					goto out_err;
-				if (!maps__maps_by_address_sorted(maps)) {
-					/*
-					 * Sorting broken so invariants don't
-					 * hold, sort and go again.
-					 */
-					goto sort_again;
-				}
 				/*
-				 * Maps are still ordered, skip after and go to
-				 * next one (terminate loop).
+				 * 'before' and 'after' mean 'new' split the
+				 * 'pos' mapping and therefore there are no
+				 * later mappings.
 				 */
-				i++;
+				err = __maps__insert(maps, new);
+				if (!err)
+					err = __maps__insert(maps, after);
+				map__put(after);
+				check_invariants(maps);
+				return err;
 			}
+			check_invariants(maps);
 		} else if (after) {
+			/*
+			 * 'after' means 'new' split 'pos' and there are no
+			 * later mappings.
+			 */
 			map__put(maps_by_address[i]);
-			maps_by_address[i] = after;
-			/* Maps are ordered, go to next one. */
-			i++;
+			maps_by_address[i] = map__get(new);
+			err = __maps__insert(maps, after);
+			map__put(after);
+			check_invariants(maps);
+			return err;
 		} else {
+			struct map *next = NULL;
+
+			if (i + 1 < maps__nr_maps(maps))
+				next = maps_by_address[i + 1];
+
+			if (!next  || map__start(next) >= map__end(new)) {
+				/*
+				 * Replace existing mapping and end knowing
+				 * there aren't later overlapping or any
+				 * mappings.
+				 */
+				map__put(maps_by_address[i]);
+				maps_by_address[i] = map__get(new);
+				check_invariants(maps);
+				return err;
+			}
 			__maps__remove(maps, pos);
+			check_invariants(maps);
 			/*
 			 * Maps are ordered but no need to increase `i` as the
 			 * later maps were moved down.
 			 */
 		}
-		check_invariants(maps);
 	}
 	/* Add the map. */
 	err = __maps__insert(maps, new);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


