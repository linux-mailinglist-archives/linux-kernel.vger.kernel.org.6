Return-Path: <linux-kernel+bounces-542558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE54A4CB15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF00E165BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B422D7AF;
	Mon,  3 Mar 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzCGItWC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BA1F4C83
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027090; cv=none; b=UEqBW6YRymTTlD612kIHnFav1phUoKVO5mBNv3XuriCNEr6SBMBb9kB/cvWEJNN+J+LFsQ3YjBomj0T12IXq0MmqVQjQAXltRAkBAfN6dn9djoha+DqM3Zi08SYByWxSnScp0rGhwPEpgNWHAwD8BfduH5czorXRkvRRPIWnrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027090; c=relaxed/simple;
	bh=Fz4BS/Vg+ztFmKoB5uFHKm4U972UGyjePv1Mi5IOyEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LpEwIWlCLbewsil4/gH8Pe6eJ5T++qL89fYgWPLAehijVjHLAqNDQsH8xiFsVbwuBJTSiT/ifTr8f8nnwrBPapK0q7ZJ7cqcxkm17E24ErfCZ7xjTfq29LkPvZq7tSkGcaNXXaETnwn6wpsGNYqlkE3yLJn5uKKBwjPzZwW7jLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzCGItWC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2236b6fb4a6so114428415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741027088; x=1741631888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0n5Ij/GC54RvDvnK6g7/btcCTWJl8RBy1WWJKX7RCoA=;
        b=lzCGItWCNcHdNoE0Bd+Ch+v4Cd+InUnFyNDoCkmQCAGxofsktBbhL9vlsaVsfUWjwS
         OaMqDfWaClqDRtlbgabI+LUCCb+wbNjBIejJslHBis3yenFAq84rktJe+IRFmjvO9IG/
         MlAvs4xS913aSvbiEO8BphUZm7lIaJJM1Y4QOruusD5dpjxKZsQkPjnGKD/bXOyX5FOt
         fC23SrmNZ1GPwoHaxReRJXXnnKqkKVe9qL1SyBtqKB7jjDFyeq5K3QtVBaM6JK7vbXCL
         hcamZ2s3tAwLJ7t64l+RkVNqyc7rbSLy3eyHjsYJlr6w1hFw5qZqBwLJixFyPtx8b4j4
         7dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027088; x=1741631888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0n5Ij/GC54RvDvnK6g7/btcCTWJl8RBy1WWJKX7RCoA=;
        b=PZ73SNUN9gUGH/zD10BIFOW3S7L56s3k1N0NEvpME0glqpyRngwfzroIJdgzeR6oTJ
         AP0SgVEAX3PFFFXn5l83KDrv8fUCHl+GYh7DMiVNs448vsHXJhGzM5YT0U/5b2k2aSh9
         KPjT8ZIR1wqEiFhmYpbzEBZcz3FayyP0REgID4Tj/5XHh2J8fm3j/3oF8GCT6EnvBWvN
         Srp9rzoMZhjUtTYwJGlOc3nqwhj/SjN6J66uJZ11y5Un3gBLw2HMcIpVnbud3ERvxgV9
         tz8Ka1Fm3zzBlb4I4RWgxdkgvGptSBH1lgIch1+PRZNcVYW26kq+P3wS44Xitvn833nZ
         dj/A==
X-Gm-Message-State: AOJu0Yyawoeeck0HPzB90mn0hNEh3g5XVcj7LwrEaiKG35GpfhE2Zhj8
	qrDlu2hEygX2c6zL34Y3chKjDwb3LS9gS6P/GNPiRUlH8gH6pRV9a2zuEntb3Xj2eYL6E+BIcLn
	TbHvR0kTjUH+EmhjGSWYLANWjf2fOAtXcjcYSqueSw+gOqWUGmi90weg6I35hp5HqzvVS/Hxw2N
	qnQAa+/ltsJLiTtf2Sbvxj8qoW52uqwjZRdZ+68T8/
X-Google-Smtp-Source: AGHT+IF7N99nVKtpgNAPCqgRLWq6Q93oywmTub2nLDo3/44ngoJtqGwWcHAxjZlq8BLd4a1gYBKFiylLqpc=
X-Received: from pfbfb32.prod.google.com ([2002:a05:6a00:2da0:b0:736:6fb6:804])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1252:b0:223:6254:b4ba
 with SMTP id d9443c01a7336-22368f74884mr210678055ad.13.1741027088588; Mon, 03
 Mar 2025 10:38:08 -0800 (PST)
Date: Mon,  3 Mar 2025 10:32:41 -0800
In-Reply-To: <20250303183646.327510-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303183646.327510-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303183646.327510-2-ctshao@google.com>
Subject: [PATCH v2 2/2] perf record: Fix a asan runtime error in util/maps.c
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com, 
	leo.yan@arm.com, james.clark@linaro.org, christophe.leroy@csgroup.eu, 
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If I build perf with asan and run Zstd test:

  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
  $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
   83: Zstd perf.data compression/decompression:
  ...
  util/maps.c:1046:5: runtime error: null pointer passed as argument 2, which is declared to never be null
  ...

The issue was caused by `bsearch`. The patch adds a check to ensure
argument 2 and 3 are not NULL and 0.

Testing with the commands above confirms that the runtime error is
resolved.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/maps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09c9cc326c08..41a99e1f4b50 100644
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
+			struct map **maps_by_address = maps__maps_by_address(maps);
+			unsigned int nr_maps = maps__nr_maps(maps);
 
+			if (maps_by_address && nr_maps)
+				mapp = bsearch(&ip, maps_by_address, nr_maps, sizeof(*mapp),
+					       map__addr_cmp);
 			if (mapp)
 				result = map__get(*mapp);
 			done = true;
-- 
2.48.1.711.g2feabab25a-goog


