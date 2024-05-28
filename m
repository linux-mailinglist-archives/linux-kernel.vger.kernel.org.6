Return-Path: <linux-kernel+bounces-191854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CC8D1526
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8922EB22B18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455673470;
	Tue, 28 May 2024 07:15:51 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E5CB171750
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880551; cv=none; b=qwBDtcH6d3xm2Se/W/9kIFsO2/kjrT+9HVVCCWMaH7Cs674dfh2QDSgvCvpJuYgNHdo4H3M80xuCRIlwO1ihw0DpE4PpRqlg6EklmJbVxnYEFw4t1aRXTkvTt+WfatO5tFGJQhL2Q8ip80ejJsCh5iR3wL9bdanLhEH2VSrjMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880551; c=relaxed/simple;
	bh=63kmL1bSMZDegOF14Oz7zv6wc4NYKe2HUnMjWCJeKBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KKJPWBWtzwfTLY5AtwachzJ8pxzBXyKwyZTKqIVHtrMtBNtLAJdWFDYUEH8hJfYPz85eEAt8H6qYW0MCcqYCaTSJHJO6LmFOD6tSMpiAYyuygqYukgv56PqsV4R7PLXS+lGk8aEGCgUIGCDkovd+mUQxiqqqb0OeBE30nmDG3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 56E3462506E8B;
	Tue, 28 May 2024 15:15:43 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sched:=20core:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20core=5Frq?=
Date: Tue, 28 May 2024 15:14:46 +0800
Message-Id: <20240528071446.59197-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

core_rq is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e32fea8f5830..346159a24705 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6485,7 +6485,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
+	struct rq *rq = cpu_rq(cpu), *core_rq;
 	int t;
 
 	guard(core_lock)(&cpu);
-- 
2.18.2


