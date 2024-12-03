Return-Path: <linux-kernel+bounces-429869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF39E27E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88646288ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9F1FC7F9;
	Tue,  3 Dec 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k34AECJC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5rWl00I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D11FAC25
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244225; cv=none; b=jKPhVh47ZxsNcbqWTaSWkhlJuiksoBKdlzNfZnN3SkjS5DKPQ37SL1uvY1uNREatEJ17DrkJQj/CgS5S7vH1EuY/yhkvRK6kyZ7x/2BOQb/14OFMvOh0UmxnISgQ1OOIU3ubnd2mQdEaDzES4vPALkln4N6EojajJW9kwWZiTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244225; c=relaxed/simple;
	bh=Wza0NVogmEzWlHk3L0MKCrq8xu+lZPkmjetxS0L4yJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZRkdvu0R72XCqB5hCQ+kpvn49mq3Y3s6eslOmCJ1D9eu77xBinsrKFAij5LJ2GiZ4DEaSBIHLTJEfeDm2v1q0atlPjXft7sUNbj0m8ySqTUxhlola38BMsFom60FZ/d5fZuP1yw2IHsjG5E/SiPLFPyzvyvZMBUDkLKs5veCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k34AECJC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5rWl00I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0sAWYJTAdfyW4L0KBHcmylrIRN9HFXqGitHstMvgdc=;
	b=k34AECJCqpyYje6MdUzAb8klCv7g3VFljE5SoccNrpJVhJC6WHjJ6xxj3I6XjeEdO9SUuu
	OYia/PyM2915O/lnIOd/YVRVLoYUTAtXPqJkRLBdsPAAV1oibq1xVv7K5n7nIl0dpFVVCx
	wohPxyR31/zCjIj7bWYNkt9j/1pCguf5257L/1h0EzzmFSTCB5NADtU2fbOOtpdeC/O5Sg
	v7QOYny5v/IiZB/IndhnGn44jSgeJFXgGDHdMFMyb6MYCMJ86msyUPnFv8UTSR38Vi/y+M
	QR9poG/aIbcyGid2pPBUkTWStzqVy0qOxxu8ZhGatwFpxMgwqqLLkIpwXU3Vnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0sAWYJTAdfyW4L0KBHcmylrIRN9HFXqGitHstMvgdc=;
	b=s5rWl00IhZX5N4IBcJNQs/yw4WQIe1cHYaW4tt1HNnYQcmn7hD3lmSjYr//B96IVYdIxR9
	t/YjbP8hupcn46CA==
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
Subject: [PATCH v4 10/11] tools/perf: The the current affinity for CPU pinning in futex-hash.
Date: Tue,  3 Dec 2024 17:42:18 +0100
Message-ID: <20241203164335.1125381-11-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
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
index e24e987ae213e..216b0d1301ffc 100644
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


