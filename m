Return-Path: <linux-kernel+bounces-185234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C614A8CB27C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B651C216D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF20148FF0;
	Tue, 21 May 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yK8zbv7f"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78414148837
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310287; cv=none; b=i37Uq9qpKJXqQsXNAcr8r9Bgfobn3NXaGLpR6/10ht38eVfOOohGt+hy1AHTbc8X60Ycwju2Wr0ET1xJEZUekdYkWIKYezhaPlAzwvPiKXF4oNgYFb7YXFJTigJbhPO01Wx8fbGNNPs4F/yYZUijW6YrKLitIiqVgg/FOreuf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310287; c=relaxed/simple;
	bh=Dhw2Jh5mBReYK2KdFz4zu0dZX2l7oWPnI/weHg4qPJE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kcFD3q8AH4XDDqfEZ4lrcCV4pHuFUkYY05JfFekUKNPPZeRc9YgxnicPQUlI1XzWur/cXLpR43J3MyOFSVNIusTpbVxIi6wSpHJNsJ9ujV11HJxDKDzFOSGvleL38zTlXItgRQGK1jhegiYmqJEGMFd3IsdNyOp/6iWojUIOj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yK8zbv7f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de468af2b73so23312062276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310284; x=1716915084; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrE0BOJf8HvNnLMD4w6E9MqTE92sz3IiyAicOOYr1ws=;
        b=yK8zbv7fnnKrxUw0bdPK3liBpBANcPMlNCLuGxIGFX/f8eyTeirdtbmOYA8fX4y6E5
         zJ8QsSXuLxsdVDLkzjvj/KuHCPI4bNu08ag7y1JOzHG5IahRCpQIQlT9s8ytzSkXgmTD
         IYaPKoQ8fSiISN70uF0p1IEYCyhuVnFkagzCll74ZgbnsN45q8vkFcec/qd9j0vcJO4q
         6FQ6TnTHtxNR/TLMfoJyqiCnVqZEEtbgXHWRPGNEK1mTQCr2Kvzn/tjJjC3FJJ9VriTr
         dSW1YgheM+udjzN8B/oTcXj+KL16eXHkcRXZjd9ZBoGtDsi8BcEYXvgFSRZsggS83xev
         ZfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310284; x=1716915084;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrE0BOJf8HvNnLMD4w6E9MqTE92sz3IiyAicOOYr1ws=;
        b=opisP/JBZWBeN/j0iJuGAfDyVBMjJCgYvKlBqrIYoZdGpLDk7T9qREIfH9AByeWUs5
         G9+67+W48OuUslkMKWymDZAhcltWo3ClbyIwvUrSKbEQCvLcmhw6ClLKdJXzDM8tSwOh
         fevpoHCYXKlcRQE5mtj+2YxSACw/iM3iuYpwGImBiWU7sc5uEUWKKf0Sxbj3qKNkguhZ
         eAK+WsTI/hHBKx9CanW/djrYFeRnPHCWRyI9+oDTMx0QtirYbQUKI8vWGVljZ0A1G/8b
         aaw+W+eL+CtOj2MnFvbyOqXAPkkojl0aClFiNOcqOeI+TJ15+nudAdARIjBRAC1b9W1I
         77Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVe8V5hpqeWx9hBTfamTjzouWsipxMocEMOAeZDU/fC6scXmAvsQ3zDF71gyr/fptM9dAA1GK6yEoUf7vQ27TLt/d5SqGcl4YuhIZF+
X-Gm-Message-State: AOJu0Yyx1Kp80jd3bctxD74CmqJCeHcHWt3Mt0ijb62tcOf38MKSJAZ9
	yt8BgJwH2B3KfRqBdAL1/6aop50WH0K0g4qhSgr4VT00HErPf8nneWWiyryTAEGQy+4efFiOglk
	u/6mV9g==
X-Google-Smtp-Source: AGHT+IHTBwsqs2wQ8TlnvMpoDM7P28140rp8Mfd1Iad6gC/LK63BwUOu/9UX9LlDgAfvx3yzOt1h8kHrBWwS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:df4:9b3d:66a9 with SMTP
 id 3f1490d57ef6-df49b3d9b15mr2457254276.10.1716310284725; Tue, 21 May 2024
 09:51:24 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:09 -0700
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Message-Id: <20240521165109.708593-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/3] perf maps: Add/use a sorted insert for fixup overlap
 and insert
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Data may have lots of overlapping mmaps. The regular insert adds at
the end and relies on a later sort. For data with overlapping mappings
the sort will happen during a subsequent maps__find or
__maps__fixup_overlap_and_insert, there's never a period where the
inserted maps buffer up and a single sort happens. To avoid back to
back sorts, maintain the sort order when fixing up and
inserting. Previously the first_ending_after search was O(log n) where
n is the size of maps, and the insert was O(1) but because of the
continuous sorting was becoming O(n*log(n)). With maintaining sort
order, the insert now becomes O(n) for a memmove.

For a perf report on a perf.data file containing overlapping mappings
the time numbers are:

Before:
real    0m5.894s
user    0m5.650s
sys     0m0.231s

After:
real    0m0.675s
user    0m0.454s
sys     0m0.196s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 65 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f6b6df82f4cf..432399cbe5dd 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -735,6 +735,60 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 	return first;
 }
 
+static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_index,
+				 struct map *new1, struct map *new2)
+{
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	struct map **maps_by_name = maps__maps_by_name(maps);
+	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
+	unsigned int to_add = new2 ? 2 : 1;
+
+	assert(maps__maps_by_address_sorted(maps));
+	assert(first_after_index == nr_maps ||
+	       map__end(new1) <= map__start(maps_by_address[first_after_index]));
+	assert(!new2 || map__end(new1) <= map__start(new2));
+	assert(first_after_index == nr_maps || !new2 ||
+	       map__end(new2) <= map__start(maps_by_address[first_after_index]));
+
+	if (nr_maps + to_add > nr_allocate) {
+		nr_allocate = !nr_allocate ? 32 : nr_allocate * 2;
+
+		maps_by_address = realloc(maps_by_address, nr_allocate * sizeof(new1));
+		if (!maps_by_address)
+			return -ENOMEM;
+
+		maps__set_maps_by_address(maps, maps_by_address);
+		if (maps_by_name) {
+			maps_by_name = realloc(maps_by_name, nr_allocate * sizeof(new1));
+			if (!maps_by_name) {
+				/*
+				 * If by name fails, just disable by name and it will
+				 * recompute next time it is required.
+				 */
+				__maps__free_maps_by_name(maps);
+			}
+			maps__set_maps_by_name(maps, maps_by_name);
+		}
+		RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_allocate;
+	}
+	memmove(&maps_by_address[first_after_index+to_add],
+		&maps_by_address[first_after_index],
+		(nr_maps - first_after_index) * sizeof(new1));
+	maps_by_address[first_after_index] = map__get(new1);
+	if (maps_by_name)
+		maps_by_name[nr_maps] = map__get(new1);
+	if (new2) {
+		maps_by_address[first_after_index + 1] = map__get(new2);
+		if (maps_by_name)
+			maps_by_name[nr_maps + 1] = map__get(new2);
+	}
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps + to_add;
+	maps__set_maps_by_name_sorted(maps, false);
+	check_invariants(maps);
+	return 0;
+}
+
 /*
  * Adds new to maps, if new overlaps existing entries then the existing maps are
  * adjusted or removed so that new fits without overlapping any entries.
@@ -743,6 +797,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err = 0;
 	FILE *fp = debug_file();
+	unsigned int i;
 
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
@@ -751,7 +806,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	 * Iterate through entries where the end of the existing entry is
 	 * greater-than the new map's start.
 	 */
-	for (unsigned int i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+	for (i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
 		struct map **maps_by_address = maps__maps_by_address(maps);
 		struct map *pos = maps_by_address[i];
 		struct map *before = NULL, *after = NULL;
@@ -824,9 +879,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				 * 'pos' mapping and therefore there are no
 				 * later mappings.
 				 */
-				err = __maps__insert(maps, new);
-				if (!err)
-					err = __maps__insert(maps, after);
+				err = __maps__insert_sorted(maps, i, new, after);
 				map__put(after);
 				check_invariants(maps);
 				return err;
@@ -839,7 +892,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			 */
 			map__put(maps_by_address[i]);
 			maps_by_address[i] = map__get(new);
-			err = __maps__insert(maps, after);
+			err = __maps__insert_sorted(maps, i + 1, after, NULL);
 			map__put(after);
 			check_invariants(maps);
 			return err;
@@ -869,7 +922,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 		}
 	}
 	/* Add the map. */
-	err = __maps__insert(maps, new);
+	err = __maps__insert_sorted(maps, i, new, NULL);
 out_err:
 	return err;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


