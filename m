Return-Path: <linux-kernel+bounces-429872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8919E27EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66BB28878A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F031FE467;
	Tue,  3 Dec 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyaTzsI2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0sfbJnO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926A1FA85A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244226; cv=none; b=ZOap6HKZba3S7sk05e9J0JSjdFo1lsbRViUTCRtuVBxmobhLOtZ74p9rMOY98KI9UpCTE4GaKrj41+EMZiMJ2KCApuSMvlxR1ANAeLj120E5wVNVwM4HExIDk0gz4Ew0zAcwPnVVo3rSKT/1r152niDv/gWXuF/5Fv+gKaTW5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244226; c=relaxed/simple;
	bh=oBCl2xg1hBgwXDdOFVnS6Y5pFTfEYL/Bz1BD8yFVl24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYntrkOKvsadITJqIZMl93bquHAr7/yUo9BDA5sKk3kx+O9NnyN2TtyxFep9uWgyg86l54Kd3An2EgRp2Ul3K2S2+ru3JzXGblcQQH2NDLL56iplpQrPu5ocNhttgMFjUi0avUwid+MYsawv3xeGGhit3Pbz3fIAwGI+HDIRyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyaTzsI2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0sfbJnO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L65Sur2ZtMYl6cHzYDBnz6z7qp7UvxDlE/18U+/UkU=;
	b=yyaTzsI2ZfgofexCT8fP6/onFXsORN8ml3KEv+A4iKrpxAX4e0394J8o49EeH8b/g3EBlb
	fz75JHiJOYnn4KcYDMGp/gVtagdSMenrZnOyu8rkTcnorBR0i3KpgSAdkP/uoAX6icrToC
	sz7h0Qj/U5EYPGlP7Hc0vrZX7t/r+XNJI0hFfo76ZWooVwcfdoFJArCJnd5c1OcxXYiFIe
	PTzqLhMALwyzPbGeie5bukhNIDqLyXmx3e2LLGxUnmcx92Tf2cAxMZDrWlHIwzHdGnOMFY
	Y2PKms0xhUMYEr+lrOiCOcCalAILHuvSnLwAoFk0S3vQj1cbpp/nxuI5q4xHvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L65Sur2ZtMYl6cHzYDBnz6z7qp7UvxDlE/18U+/UkU=;
	b=r0sfbJnO1IiaeYZuC4fkvIyJ3CeUD+oPLmU9UsTw/lYsXJYvOGmjz7W2SxKjoWzN30dboA
	9UU8RqMNaq6C6IAA==
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
Subject: [PATCH v4 09/11] =?UTF-8?q?tools/perf:=20Add=20the=20prctl(PR=5FF?= =?UTF-8?q?UTEX=5FHASH,=E2=80=A6)=20to=20futex-hash.?=
Date: Tue,  3 Dec 2024 17:42:17 +0100
Message-ID: <20241203164335.1125381-10-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wire up PR_FUTEX_HASH to futex-hash. Use the `-b' argument to specify
the number of buckets. Read it back and show during invocation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/perf/bench/futex-hash.c | 19 +++++++++++++++++--
 tools/perf/bench/futex.h      |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index b472eded521b1..e24e987ae213e 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -22,6 +22,7 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 #include <perf/cpumap.h>
+#include <sys/prctl.h>
=20
 #include "../util/mutex.h"
 #include "../util/stat.h"
@@ -53,6 +54,7 @@ static struct bench_futex_parameters params =3D {
 };
=20
 static const struct option options[] =3D {
+	OPT_UINTEGER('b', "buckets", &params.nbuckets, "Task local futex buckets =
to allocate"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads=
"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in second=
s)"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes=
 per threads"),
@@ -120,6 +122,10 @@ static void print_summary(void)
 	       (int)bench__runtime.tv_sec);
 }
=20
+#define PR_FUTEX_HASH			77
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+
 int bench_futex_hash(int argc, const char **argv)
 {
 	int ret =3D 0;
@@ -131,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	struct perf_cpu_map *cpu;
 	int nrcpus;
 	size_t size;
+	int num_buckets;
=20
 	argc =3D parse_options(argc, argv, options, bench_futex_hash_usage, 0);
 	if (argc) {
@@ -147,6 +154,14 @@ int bench_futex_hash(int argc, const char **argv)
 	act.sa_sigaction =3D toggle_done;
 	sigaction(SIGINT, &act, NULL);
=20
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params.nbuckets);
+	if (ret) {
+		printf("Allocation of %u hash buckets failed: %d/%m\n",
+		       params.nbuckets, ret);
+		goto errmem;
+	}
+	num_buckets =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
+
 	if (params.mlockall) {
 		if (mlockall(MCL_CURRENT | MCL_FUTURE))
 			err(EXIT_FAILURE, "mlockall");
@@ -162,8 +177,8 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!params.fshared)
 		futex_flag =3D FUTEX_PRIVATE_FLAG;
=20
-	printf("Run summary [PID %d]: %d threads, each operating on %d [%s] futex=
es for %d secs.\n\n",
-	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shar=
ed":"private", params.runtime);
+	printf("Run summary [PID %d]: %d threads, hash slots: %d each operating o=
n %d [%s] futexes for %d secs.\n\n",
+	       getpid(), params.nthreads, num_buckets, params.nfutexes, params.fs=
hared ? "shared":"private", params.runtime);
=20
 	init_stats(&throughput_stats);
 	mutex_init(&thread_lock);
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc1..abc353c63a9a4 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -20,6 +20,7 @@ struct bench_futex_parameters {
 	bool multi; /* lock-pi */
 	bool pi; /* requeue-pi */
 	bool broadcast; /* requeue */
+	unsigned int nbuckets;
 	unsigned int runtime; /* seconds*/
 	unsigned int nthreads;
 	unsigned int nfutexes;
--=20
2.45.2


