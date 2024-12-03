Return-Path: <linux-kernel+bounces-429871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB519E27EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80356288AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D1D1FDE05;
	Tue,  3 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBcpRnSr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/ISmL5H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AC1FA856
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244225; cv=none; b=sRKR7jVq5ywVOR1L2EDxbjEO4XMY4dnzIDE4R2Lt886Gi7s5jTj5sIfxW4YK6fdkmunnSBQrF8N5hchXNGKr3yF55BJ53E6TKiG6asUE/t/3HSeIDGAc0ZybJE2R42Sou7UhTaQarQSVrIYcgB9aNJoeYAKvw7kH8cEpaNpbjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244225; c=relaxed/simple;
	bh=lg8axIUYclb2T6+boQQvvI4x/adQdWN/2MeRAxM1I+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLHQuTCZy9rqbzhZPbE2hrPmjVApgn8Ttffjm6DpYWAblHQEFfBV0bzmbmYOGeM87NkcgEYter+B3nUCCV0Lp7AJA+OS6XkOxIXuaCA/2V/y5KCU6aRVzSHt8sAyZ6IW0x6Idc/aA3+AH5pgJxj6AC6aOEvn31UB0qUe+mzHpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBcpRnSr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/ISmL5H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6O0H8PocWBBcPGtHkLgMVhBIfVergybbi7OL8FwAuw=;
	b=DBcpRnSrvKq6BYw4qSNnTpbp5w1GXXkZ4+lWDZsmzIoYZU2gdMLICwjQ2GDUgBhi3sbwG6
	f6TcqeTuhvvVtyigVSbRtGnmk7r6ROzxsveu0VLk+TW9CaUvJ5PoQjTcnCGwSLk3Ih0Ifn
	/HEmglVhVxRsfkDPWmwa1gyLRIsgUPGz/oZCS03LetXFaoKQ4lHHWAMekKxt+kwaFpCRK8
	f5RdnLzdICm7aE0CdCQVjFo+89Rlm4IMBa2/fjCR8QYVp5WnFrXv8N381xegdIkY8DUG6l
	XxEbr3YqXmP2hvcauGMojhoHDL+grOP7715OGth8J1WoZioVh+BVOcKcW6kH7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6O0H8PocWBBcPGtHkLgMVhBIfVergybbi7OL8FwAuw=;
	b=a/ISmL5HlE1mncnUp/VtOQw2xilo06rJ0JxH5DNqCjxZGawJ4StqmK62DXYqcxNgg7Unj+
	H9S5QPNqL7HkGvCw==
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
Subject: [PATCH v4 11/11] tools/perf: Allocate futex locks on the local CPU-node.
Date: Tue,  3 Dec 2024 17:42:19 +0100
Message-ID: <20241203164335.1125381-12-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
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


