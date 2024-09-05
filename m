Return-Path: <linux-kernel+bounces-316698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75A96D2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F61F219D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC519754A;
	Thu,  5 Sep 2024 09:13:12 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D4B50194A48;
	Thu,  5 Sep 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527592; cv=none; b=TgnzpGLsXBxBkWhHr5tp0NTAYblQSNOphInh4eQH9iehVRsqCO5do8B2dQr+OsCQam/L01NvNsDG//dqk/pE6Wo/Jpazgw97PcgyY++gLqyV5Est6MjVNFV2bN3GJEDbJ7oEboqvNfuq1bMH1Ga65SAQV4arsnGTcYvFZSAbnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527592; c=relaxed/simple;
	bh=l482FcwAKIbf3f2AZAY2M8QuK+XWEKdTtapEqd+G24U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4uTyY2CdajE6+Zm10w4g3oGV18Ck7M2XyhAOhU6ovwVlehdsfHEqftHawCRFFw30dzW4w3qoYjvWl+kpZfVKRsSLb7xWLpwAN5eBE8JEuB7pGLiP3TPhhJSOm9uukR7X75SUU+R5rBqDhQJj2r6qq1SsoEDBv6mBVzw5T/tvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id C12986052BD9D;
	Thu,  5 Sep 2024 17:12:52 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] sched/headers: remove useless code in mm_cid_get()
Date: Thu,  5 Sep 2024 17:12:24 +0800
Message-Id: <20240905091223.2350061-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker (scan-build) warning:
In file included from kernel/sched/core.c:88:
kernel/sched/sched.h:3501:2: warning: Value stored to 'cpumask' is never read
 3501 |         cpumask = mm_cidmask(mm);
      |         ^         ~~~~~~~~~~~~~~

'cpumask' has never been used before, delete it to save some space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..d4088f1b8984 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3494,11 +3494,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
-- 
2.30.2


