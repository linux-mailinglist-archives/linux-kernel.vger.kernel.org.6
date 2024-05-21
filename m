Return-Path: <linux-kernel+bounces-185232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192488CB279
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1BB2264F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E4147C9B;
	Tue, 21 May 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqfsDjR/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DB3B1A1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310282; cv=none; b=alO0p4XV0E/lNcQCtnadKNTt6ArK76y2Po53hTYMECuIOySYwJfHAdudiehytnSaOxviqSNTLmKp6jQ+Hrx+8Ap2kpisDQu9CqZUkhaTdf9DukrR+nK6GyFLiWoDpMcrrnpcIV8ZRQ9mVcdR63KswzD2o0mIsATZDu6PVeCfntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310282; c=relaxed/simple;
	bh=CQhX3rHzsitnHPfXKQHoTLwMmtFJKqDCMNaUjS6EnNA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YjuPQ4vEkJQQadb6wBi0wgvTXTBeWrWsz0hVAK4vsl1vBBF3usI8d1qFyVcLpPNNHKbcQRks9gOirovhtMLSF86Hb9NCfjitOyGAHNfyOVG+n7P1dmNEx95LDl1sN/3F5J8C5+ncs2L8lCuEl//ekjXkeorXKBe5McJrL77/nkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqfsDjR/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so28252138276.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310280; x=1716915080; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUfTujR33N1wGIzFWyd3IGvA2YqCHOAb96ZV/yApJRQ=;
        b=kqfsDjR/2+71WblNqgOHbu6WvgolPFFZXzwadOTz+ixKpdE1fmO8LljJVw4PvgZLM+
         eA8vpInbpFeTvBaVBrdb9OiXiGDk10Wy7LJeNv4lb/k7+RzcbSJi7StK/WQxKA2A4Sxo
         K6ifexhv/tjEQZ37Vvm31UGFWfxmIPwJHutOpUvegUgBn6fzZu6UCFEQGhrbo/hgI3CX
         3JV4KdYM8R/BWxH3kdmmWPNeGMoggqPudhuiLkLbIcUaZ/BnMr/CMXRxe3vBWlHiFFfT
         Aa55AlMn5YlFfYu05io32p3339wr0T7PFj9cfRYd70wl0ux8GV2zBQFsS2K5qZB7/N7g
         GsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310280; x=1716915080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUfTujR33N1wGIzFWyd3IGvA2YqCHOAb96ZV/yApJRQ=;
        b=cnSn79econr+YT5nZgUDFFo+QL8X/SSRIuVNrJfH+ZHSO0bCZSJWYUWYb2JDH38YVa
         C4xT0xQeQXjBJ+g9YZCAdIPnHR4+d74duvweQxBqBDy23XfOQLZGDNr1++HGkZVubnwF
         fvX7MHRAcPG59viQpkInlw5T31VxgugjpdKo/tB+wBTeUHMWAiVHzTTauMx+wfjroWu9
         ifJgglbWIurVe9Qbvqaq0/iV9ax5eWseXgvl06ZMtg6I+6IthFn27H4YcvZxMXcFnj3s
         qHnbi6zVsc9Fo2bBZaa6B2Sj81rav0mFQ1H6QSgDihhJCF7yxKr3t+PGN2YXlubrwmu3
         xNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7mYEy6OZrmB3K0lrBn9jYV9jpdtdN0It6b39Q6p663UTvG6wQQD8sPR1rS87hMHD3kg5NpXv0fLBdw/Y8L0I9T2uKocvS7kH4bRvy
X-Gm-Message-State: AOJu0YwkMn1BUz8+HaYZJ9vNt5BHF+DtxpVBVXaVS+yoQfYGPvblH8AT
	dIfsJDJQYFdSM9P24Vju1i8/OPL4fhBzYp4jUumyFO4NwU98nAAOuKEuWnZOEJqH3txleTbFm1S
	diRerxA==
X-Google-Smtp-Source: AGHT+IEuLf9iy7F2mWUl3KPhny2cf+IIv1BpZOjLYfGWEbsRN5JmdbXDf2IAFJszFFLx+QPs+6hSVgUIXJLw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr8133573276.4.1716310280333; Tue, 21 May 2024
 09:51:20 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:07 -0700
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Message-Id: <20240521165109.708593-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 1/3] perf maps: Fix use after free in __maps__fixup_overlap_and_insert
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the case 'before' and 'after' are broken out from pos,
maps_by_address may be changed by __maps__insert, as such it needs
re-reading.

Don't ignore the return value from __maps_insert.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 16b39db594f4..eaada3e0f5b4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -741,7 +741,6 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
  */
 static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
-	struct map **maps_by_address;
 	int err = 0;
 	FILE *fp = debug_file();
 
@@ -749,12 +748,12 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
 
-	maps_by_address = maps__maps_by_address(maps);
 	/*
 	 * Iterate through entries where the end of the existing entry is
 	 * greater-than the new map's start.
 	 */
 	for (unsigned int i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+		struct map **maps_by_address = maps__maps_by_address(maps);
 		struct map *pos = maps_by_address[i];
 		struct map *before = NULL, *after = NULL;
 
@@ -821,8 +820,10 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			/* Maps are still ordered, go to next one. */
 			i++;
 			if (after) {
-				__maps__insert(maps, after);
+				err = __maps__insert(maps, after);
 				map__put(after);
+				if (err)
+					goto out_err;
 				if (!maps__maps_by_address_sorted(maps)) {
 					/*
 					 * Sorting broken so invariants don't
@@ -851,7 +852,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		check_invariants(maps);
 	}
 	/* Add the map. */
-	__maps__insert(maps, new);
+	err = __maps__insert(maps, new);
 out_err:
 	return err;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


