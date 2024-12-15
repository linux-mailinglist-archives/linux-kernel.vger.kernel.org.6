Return-Path: <linux-kernel+bounces-446632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3D9F2758
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0797F164E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647A1D2B34;
	Sun, 15 Dec 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMbSF9Wj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPuphqC/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95A1CD213
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304019; cv=none; b=oONqyPzdAj5TTwQ9QMqY69Qh4EXzBWvPSNn2fcXgJjomOcj1Sp/FEMqDSLpeAGiC/LkYVP3qNFsMlGs0GqmtcMcxB4N5WktP268qyxhDmxh5BtBHM/w26ycqwHfsrLz+k4Xv0JP00XoQaWFxOGZchAkTwaKDtWFk+f2mTzaZbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304019; c=relaxed/simple;
	bh=Wza0NVogmEzWlHk3L0MKCrq8xu+lZPkmjetxS0L4yJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwsGwQuDLhpZ1zglXbHIDHBNrc33Yemqn3f3jQ5WXD4zJ73vbm/ucX5iSnIR4WSvP6FpkdhIpfUOty9PP0DKz07peA2KeyrK08Oo6OG0eIsLAh7EB8UgmxUoRYhCoKvVtsMeHXdDjEloDzlySciHoUfXoU5MD0k9GVsc39Qbq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMbSF9Wj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPuphqC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0sAWYJTAdfyW4L0KBHcmylrIRN9HFXqGitHstMvgdc=;
	b=QMbSF9WjSp/0pQ46sR4e+aRSKX/Lo+mCL/z9NLz7sCYYeSo4zMFbOgIJ9g17RGaamIwKAn
	BSBnEjL+8GktjoqGmXyBE+qA8xwNO4R5FrEefZhUn2gwDSCi+RSAn87wlrbS4AgFS6hEpv
	SpCnuz/5N/FXuWKywH/1AWem7pNCB+tFe7hRMUR8j2cJebmq4agGAspV6iuBIdrTyi39+E
	AO3UgQTm4OYMNdqjftxpmqD4tb2wlfxisjjbRSQ/82UBGwSq+31PTKt2mwwvKCglOdVuX1
	sHCgRLxj1sXYyj/nRdvMyIhn7b/E8c29eot4ArqLhD8uapNkzSo0zk/XDdHSeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0sAWYJTAdfyW4L0KBHcmylrIRN9HFXqGitHstMvgdc=;
	b=JPuphqC/2rGj45e1A0xYzvgaZ2BetSh6jY2X0mHrlZHGBhKew6+HF+HB5s1MYwTW3lcGPz
	KO00MzWRX2wab4Aw==
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
Subject: [PATCH v5 13/14] tools/perf: The the current affinity for CPU pinning in futex-hash.
Date: Mon, 16 Dec 2024 00:00:17 +0100
Message-ID: <20241215230642.104118-14-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
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


