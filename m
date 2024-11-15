Return-Path: <linux-kernel+bounces-411088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6F9CF3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63656B472EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513E1E22FC;
	Fri, 15 Nov 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LcGGw/Fj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWS+AALM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D81D90CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691250; cv=none; b=fQrX+UAbRzuxv8Ej652SNFRXpOaDapWsKxWHfRoUQF5zAwWVyvaX+FNshFdaHWprJOhprzSKsOnKkduhdbc0NGzY8EnnIs6FZBKcC4QFzvIplyYP4pnGCHlqMwNegEV03X206JQQkawEQitA7kww05IwOCAF1pMkjoS9RV907IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691250; c=relaxed/simple;
	bh=ve5F7c3o4tqOGVkj9LxUhARv+iEtJK7WSacclgv+XmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP/XsygY77Te8NB0gtVN3bXT/RXqGa/ucxqPbOgYilbMlQJx1mHHURQ2uuYzZyQrIglVIGGsjASFDIeyNhv2/HO6l88u44w2OUXdWHriWhfR1tlZiR9y689wDcHY5832NUJ1Hjg2Fiu+hNqepGz+b1MiqoJyxj6rkIT0QhCv7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LcGGw/Fj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWS+AALM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYUftPAgoBwjrcE4s1jVdEi2kaOhq8RayKWSl+bNvM=;
	b=LcGGw/FjkYM9CM6ICi6VXyK4k5jluLMNxV4l3H35Qcty17bNcyyfUctfSc6jTrQwobGdSm
	T8i4DUwUiCmQtPsMO6WFhxtGYKlSPCtoQruqzRd1d3TF8hK5U4VKxLN6pO1HmeTY80cx2/
	65XqYR5EZ6iYT2UR3kf2Hf3OKqono653f1wVDzsboPIKmmbfSiyHAhDNeS5+EXCrH1Z8ss
	B1oCNtgNOPIsQZj6CaTIkX43DkGvMvRXG1cria5eu3k5M9elGSVgVAKAiNJuM3o/SinxY4
	IvD53ZbFe4zcZqi9PYZChwbRFVvpeH2IloTUfsAAdl5RPb1ABwCKqSB2jQsxNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYUftPAgoBwjrcE4s1jVdEi2kaOhq8RayKWSl+bNvM=;
	b=QWS+AALMaeOvqDygPrYaQ4Iavx0lUs8qLQXHfOdejZjZgbVfMT41eqWsX+0+V9n6uAtMRH
	jQMyQYsQ8n54gTDA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH v3 9/9] tools/perf: Allocate futex locks on the local CPU-node.
Date: Fri, 15 Nov 2024 17:58:50 +0100
Message-ID: <20241115172035.795842-10-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/perf/bench/futex-hash.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index f40b7df6ef3d0..7c8f3cff3c611 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -122,6 +122,8 @@ static void print_summary(void)
 	       (int)bench__runtime.tv_sec);
 }
=20
+#include <numa.h>
+
 #define PR_FUTEX_HASH			74
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
@@ -212,14 +214,19 @@ int bench_futex_hash(int argc, const char **argv)
 	size =3D CPU_ALLOC_SIZE(4096);
=20
 	for (i =3D 0; i < params.nthreads; i++) {
+		unsigned int cpu_num;
 		worker[i].tid =3D i;
-		worker[i].futex =3D calloc(params.nfutexes, sizeof(*worker[i].futex));
-		if (!worker[i].futex)
-			goto errmem;
=20
 		CPU_ZERO_S(size, cpuset);
+		cpu_num =3D get_cpu_bit(&cpuset_, sizeof(cpuset_), i % nrcpus);
+		//worker[i].futex =3D calloc(params.nfutexes, sizeof(*worker[i].futex));
=20
-		CPU_SET_S(get_cpu_bit(&cpuset_, sizeof(cpuset_), i % nrcpus), size, cpus=
et);
+		worker[i].futex =3D numa_alloc_onnode(params.nfutexes * sizeof(*worker[i=
].futex),
+						    numa_node_of_cpu(cpu_num));
+		if (worker[i].futex =3D=3D MAP_FAILED || worker[i].futex =3D=3D NULL)
+			goto errmem;
+
+		CPU_SET_S(cpu_num, size, cpuset);
=20
 		ret =3D pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
 		if (ret) {
@@ -271,7 +278,7 @@ int bench_futex_hash(int argc, const char **argv)
 				       &worker[i].futex[params.nfutexes-1], t);
 		}
=20
-		zfree(&worker[i].futex);
+		numa_free(worker[i].futex, params.nfutexes * sizeof(*worker[i].futex));
 	}
=20
 	print_summary();
--=20
2.45.2


