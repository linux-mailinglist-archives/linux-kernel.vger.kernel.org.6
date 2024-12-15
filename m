Return-Path: <linux-kernel+bounces-446631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A29F2756
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BAE164FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBD1D1F57;
	Sun, 15 Dec 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FX5qm10x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUYKyebN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDD1CD210
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304019; cv=none; b=qEzQI3MyvGvi4tZbQnSdIVCTxxpiB9zUQ4WvKESweyCbFnDRSMzfCLYhVTUoTn2GoWAmSEO0sAw9ny9mOv28hgtW7YkueZDL32ZuBdeeFWJZXXCWVRJ5UdZWF54tSiwNAYnQQGyZ1e8s88GMZGZqkBXtKdryxJAA3o5MH0e6Ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304019; c=relaxed/simple;
	bh=lg8axIUYclb2T6+boQQvvI4x/adQdWN/2MeRAxM1I+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPyj8da/MPI0f+BQzImEYrhULAb7QmHBBp7Y/57fgFXwvkmoxCge4+MR+5p0vz8t9MFRDUuYVUzNXZeAu5YqAvS7VVSM7zaYled/oFW3rSHDS4d1uZ26KuVNmsjUz/WZlz3gMbl0u9tAcrXJDX9bI2b1WQyknU9TITkk19z38Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FX5qm10x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUYKyebN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6O0H8PocWBBcPGtHkLgMVhBIfVergybbi7OL8FwAuw=;
	b=FX5qm10xvvJ0YL1mdxdCaowGcj/a1h95ddaSUKlSFvHjx92wsu+zcSCVVrx7g69tv4RLC/
	X1cEVWwR/JIOx7huR/VlF1IsnJ7pxmhKnsxMNKUSFNz+G/y1Nmczl0QneKGTFMY5Z1N/jv
	SNMzkCtTG8CltVzipwkQc/c3h2hV9IusrnfiZANS4Y1rUe5WUGJzrHCfF5edbSujwWyytP
	geCRMjRNp0mU1MXJbcoDB5YwHJ4LNsmN7mVvSmW5xZ7p1Vk43uOLglM2E+NHWAD8SIBExU
	JENegw3uD87tR9kr1Y+z6WwjBj3N4AahBZV4QhyA7tV2Qz5S/ujyRPMCtOyYvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6O0H8PocWBBcPGtHkLgMVhBIfVergybbi7OL8FwAuw=;
	b=kUYKyebNmTw2maS7BNcOM4Kybnyjb1oYoQmo7i3E6g+3qWoV1TeiOHVQ9vQNTmcKFIluDP
	+obnWx5fvygNxoBw==
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
Subject: [PATCH v5 14/14] tools/perf: Allocate futex locks on the local CPU-node.
Date: Mon, 16 Dec 2024 00:00:18 +0100
Message-ID: <20241215230642.104118-15-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
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
index 216b0d1301ffc..4c7c6677463f8 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -122,6 +122,8 @@ static void print_summary(void)
 	       (int)bench__runtime.tv_sec);
 }
=20
+#include <numa.h>
+
 #define PR_FUTEX_HASH			77
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


