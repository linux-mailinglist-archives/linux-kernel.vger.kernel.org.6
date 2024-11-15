Return-Path: <linux-kernel+bounces-411086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F49CF2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAF91F22FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323051E1A3D;
	Fri, 15 Nov 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAxdx/Gu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knwb9IIN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994861D8DE0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691249; cv=none; b=hi4MI0uJCMJ2i8NBIuLUhnVs5C55497PRGtCZS9Cu54bjrabnuWxHc3GvccSZhTqVbhU0vnzjtn0q/DgK6xc2eBaEvMAFMxUrIGUQCNK3DPFRJjFNYyQsgiw7aSAB7IIXsR5M3Ii5gTEfVwqqbXT74S4fAjIDxfwf7a2vGjkCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691249; c=relaxed/simple;
	bh=IVK4Dsc/GpAtVlvaa/UZo/8T7lHRrgN1aJSTQfnI5OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjY1BtLYIzUKNdNpxEv0JmECoiEwA6L292asKFPpy7fREcP/4dxY/RrDFtNTqcKcbYLYlT1LwZ+C61yKYcPMMSP2HPWv3GRg0GyFBFt1+SwcBDdRKgPkz/G9TejjcOsttmLZw97d6vc2LxPbiQbXQMFdG7zqGouWm1n3mdttcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAxdx/Gu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knwb9IIN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaWwegc6n6sICWXGqXLO2VC/9Q5mBnHbY++fhoom6jY=;
	b=lAxdx/Gurfqf9CaFhtNojG8ANvxlf09NXaPUAHy5yIx/ctjhmPfg7ShZE7unpobae6t+NJ
	mmZd+ZtDeefCVnBUm0KhO89Epb+bRvPV/O9DLy+n93rulfmimXdirg/UdFzZccpm4JLobe
	h6NKNW5ejQ9HBIM2PKoZmWdvEYE8g03GQzJkfnSNQnn8snsPUOVNxCD/TrdMyNZDV8DFwy
	i3tOCLIOzQZ3EedHvjTwLg6s2BFAhwxGpVa89aOfnf0+RGKZTMKPUIPHrGlvmQGKpVZ36H
	CuXGSGpJLcEk7F6OwRlvBPlF7892BQQuynNUIkHkCO1hm7mwDhB/mW7dcl8W7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaWwegc6n6sICWXGqXLO2VC/9Q5mBnHbY++fhoom6jY=;
	b=knwb9IINridXiNY0mdsR/4MgkNmjWhRuYP0VNkUaygZpPT18wYu2i5LrB83Cs6fAu+KuqY
	2dQsoMR7Fup7OnBw==
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
Subject: [RFC PATCH v3 8/9] tools/perf: The the current affinity for CPU pinning in futex-hash.
Date: Fri, 15 Nov 2024 17:58:49 +0100
Message-ID: <20241115172035.795842-9-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to simplify NUMA local testing, let futex-hash use the current
affinity mask and pin the individual threads based on that mask.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/perf/bench/futex-hash.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 1f7a33f8d078e..f40b7df6ef3d0 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -126,10 +126,24 @@ static void print_summary(void)
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
=20
+static unsigned int get_cpu_bit(cpu_set_t *set, size_t set_size, unsigned =
int r_cpu)
+{
+	unsigned int cpu =3D 0;
+
+	do {
+		if (CPU_ISSET_S(cpu, set_size, set)) {
+			if (!r_cpu)
+				return cpu;
+			r_cpu--;
+		}
+		cpu++;
+	} while (1);
+}
+
 int bench_futex_hash(int argc, const char **argv)
 {
 	int ret =3D 0;
-	cpu_set_t *cpuset;
+	cpu_set_t *cpuset, cpuset_;
 	struct sigaction act;
 	unsigned int i;
 	pthread_attr_t thread_attr;
@@ -167,8 +181,12 @@ int bench_futex_hash(int argc, const char **argv)
 			err(EXIT_FAILURE, "mlockall");
 	}
=20
+	ret =3D pthread_getaffinity_np(pthread_self(), sizeof(cpuset_), &cpuset_);
+	BUG_ON(ret);
+	nrcpus =3D CPU_COUNT(&cpuset_);
+
 	if (!params.nthreads) /* default to the number of CPUs */
-		params.nthreads =3D perf_cpu_map__nr(cpu);
+		params.nthreads =3D nrcpus;
=20
 	worker =3D calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
@@ -189,10 +207,9 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_attr_init(&thread_attr);
 	gettimeofday(&bench__start, NULL);
=20
-	nrcpus =3D cpu__max_cpu().cpu;
-	cpuset =3D CPU_ALLOC(nrcpus);
+	cpuset =3D CPU_ALLOC(4096);
 	BUG_ON(!cpuset);
-	size =3D CPU_ALLOC_SIZE(nrcpus);
+	size =3D CPU_ALLOC_SIZE(4096);
=20
 	for (i =3D 0; i < params.nthreads; i++) {
 		worker[i].tid =3D i;
@@ -202,7 +219,8 @@ int bench_futex_hash(int argc, const char **argv)
=20
 		CPU_ZERO_S(size, cpuset);
=20
-		CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, size, c=
puset);
+		CPU_SET_S(get_cpu_bit(&cpuset_, sizeof(cpuset_), i % nrcpus), size, cpus=
et);
+
 		ret =3D pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
 		if (ret) {
 			CPU_FREE(cpuset);
--=20
2.45.2


