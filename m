Return-Path: <linux-kernel+bounces-308144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29E9657D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D331C21909
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BE1531F0;
	Fri, 30 Aug 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSZu/w8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6026CDBA;
	Fri, 30 Aug 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000711; cv=none; b=XcmiCg1r1da270kyXqJgJ4CLnKxo77xnrl/lRl7Zd/HIXy76B4GGkr359itQz9fcBciC/jrvniwsFlOClXmvosSMUiia7qhAL2ci97H/2UNTtt+ExIwkf3Q4E7ya4fwuGRjXKc8vQzG8T+9ilSwk6m5S4FtL/tEqerhthUvLmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000711; c=relaxed/simple;
	bh=l7/nDEE1MX86mKrPXhx4ECRvV7lM/5hZGbDxDxymaoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMpEcPyCf8u412mJQX4Vwt21jAUzXIBZahM+ofv3OuubPgGk8Z8V1TYJShidJRkE/FLIEkl/p5zrrNjvWYyD4BGZuG5X9Yx4zyA0UKSqyc6/gbuxtSh2RNoG5rFdwz40+60dQMo7IG7YMlv530T9vQk+BksBEugifBxg8tEobOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSZu/w8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8520C4CEC2;
	Fri, 30 Aug 2024 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000711;
	bh=l7/nDEE1MX86mKrPXhx4ECRvV7lM/5hZGbDxDxymaoA=;
	h=From:To:Cc:Subject:Date:From;
	b=gSZu/w8aYVrAzMOhJlI2Z61ZkTR2iWmFdvKF0bEIG82077RcpbHu6f616YrbCm/3p
	 s3TNV49rc18keRoKlKFhwsNuBy1jJfe4f/dlHgRvPCNPg6RHVOjn8wcSji4kFVfa/P
	 Stk0mcldAmMZW7tJsvFEubrjqAkR2V6WBy/GZiA2BGWtmhahMm9QMo7nB4Qe/0Xn2v
	 Ebz2BHE+qGyoWm9BPKCq6/7q7skiKlPUuxDqo1o0W+Z7iLSxy17iZbxHfUToDvRfOq
	 mj11hwALPpDfMkeI0XnbEA1IuW2OoQBJVNFG59RlBW3SdyX5b0q93PmL5X2uxpIUWx
	 f7vx82vem0+jw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 1/3] perf lock contention: Handle error in a single place
Date: Thu, 29 Aug 2024 23:51:48 -0700
Message-ID: <20240830065150.1758962-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has some duplicate codes to do the same job.  Let's add a label and
goto there to handle errors in a single place.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index d931a898c434..e8a6f6463019 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -439,11 +439,8 @@ int contention_end(u64 *ctx)
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
-		pelem->lock = 0;
-		if (need_delete)
-			bpf_map_delete_elem(&tstamp, &pid);
 		__sync_fetch_and_add(&time_fail, 1);
-		return 0;
+		goto out;
 	}
 
 	switch (aggr_mode) {
@@ -477,11 +474,8 @@ int contention_end(u64 *ctx)
 	data = bpf_map_lookup_elem(&lock_stat, &key);
 	if (!data) {
 		if (data_map_full) {
-			pelem->lock = 0;
-			if (need_delete)
-				bpf_map_delete_elem(&tstamp, &pid);
 			__sync_fetch_and_add(&data_fail, 1);
-			return 0;
+			goto out;
 		}
 
 		struct contention_data first = {
@@ -502,10 +496,7 @@ int contention_end(u64 *ctx)
 				data_map_full = 1;
 			__sync_fetch_and_add(&data_fail, 1);
 		}
-		pelem->lock = 0;
-		if (need_delete)
-			bpf_map_delete_elem(&tstamp, &pid);
-		return 0;
+		goto out;
 	}
 
 	__sync_fetch_and_add(&data->total_time, duration);
@@ -517,6 +508,7 @@ int contention_end(u64 *ctx)
 	if (data->min_time > duration)
 		data->min_time = duration;
 
+out:
 	pelem->lock = 0;
 	if (need_delete)
 		bpf_map_delete_elem(&tstamp, &pid);
-- 
2.46.0.469.g59c65b2a67-goog


