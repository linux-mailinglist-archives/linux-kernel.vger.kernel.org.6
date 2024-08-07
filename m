Return-Path: <linux-kernel+bounces-278218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE494ADC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A60B21827
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7913E043;
	Wed,  7 Aug 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWNDyurz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C0137776
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046579; cv=none; b=mFxQE7AquFBbHYmJCfWsrB8wE/jMizZ/guQrN+k02ZAuLf2n8HISHzBcirnQCHuhS59dy96Tqz/n6LrBx3+pFsvxuNZTW5lspqGoWPICQMFLd1j0Wbjl5ycX5SsE756pxrbglDnKKZSkTv7F5wOw9UfH+Ugaq6QDxb/H3qVm2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046579; c=relaxed/simple;
	bh=9kOLAfsZJjFZ6fYtWV+X45xaPDhWdeE6pob4ljCqnAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm327tPATr1S+a5dN+2wjx7CcFWJxL3BbCNtYNjfdHnjBs5TPD/SsGRTa0yuVhlEe2VBAvMFXeiyNXzcUKK7KRbr2o44P43IYaYAIKFmsgR90M1/wWV9T0LdROM2btAxb90knrCF3FXOI3qjnP/21PDr9TSYtNTipg4t3iTQedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWNDyurz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCEC4AF0B;
	Wed,  7 Aug 2024 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046578;
	bh=9kOLAfsZJjFZ6fYtWV+X45xaPDhWdeE6pob4ljCqnAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWNDyurzi9fZ8XfRZCio7zORHgZ9iqX/Be7g7d4ZvVDgdncPETYUXXmsPQTtPRTnp
	 N2SsNgwVEG734wZszuKb27Awmj/0sLl1Pd371J5T2HSqUltsKTZSFq4OB/6aZ2mlQr
	 p668bTGN/Cy6UZtdKd2QCq1gk7FfMxRPHkMRphgqRT9+EPjH7gPRVPTgZjsgst/LDW
	 BzDj9qXA3LciJjCr9wOzsR0gy1sVA3PHnJk42GAS/tk1q88bpFahzyqnU9at0SLkXT
	 wdSGK7/yc8/WDKwpXG0zlJ/jrWb3ikNoujK8dLv6lBmNz4cigjTE3cnhfUPbcoEqth
	 9Gd1nBHv1B1tA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/19] kallsyms: Use kthread_run_on_cpu()
Date: Wed,  7 Aug 2024 18:02:14 +0200
Message-ID: <20240807160228.26206-9-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kallsyms_selftest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index 2f84896a7bcb..b5f3f14a01f4 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -455,13 +455,11 @@ static int __init kallsyms_test_init(void)
 {
 	struct task_struct *t;
 
-	t = kthread_create(test_entry, NULL, "kallsyms_test");
+	t = kthread_run_on_cpu(test_entry, NULL, 0, "kallsyms_test");
 	if (IS_ERR(t)) {
 		pr_info("Create kallsyms selftest task failed\n");
 		return PTR_ERR(t);
 	}
-	kthread_bind(t, 0);
-	wake_up_process(t);
 
 	return 0;
 }
-- 
2.45.2


