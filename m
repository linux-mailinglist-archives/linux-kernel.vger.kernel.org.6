Return-Path: <linux-kernel+bounces-331174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE397A95F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835ED1F236EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3A187FE6;
	Mon, 16 Sep 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQtkQA6p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA29187348
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526995; cv=none; b=iRDT6eDMiOk80TwxDPF7bjnys0XSo9j3Zsmn9caoJAFuHnrs+/DnIRmo+nqDjxxjoIWhYlGLYEi3UU40yrjexZNvEtwVFcx97WBO/hk+FWjMCJlXpQDuVMfhcY5oGcgDTdLU0EyVueOGkbvNywldZ60cG4c9BIlmATcG1sugIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526995; c=relaxed/simple;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPI6SAl1gqXviwzIsndIxx9/tWvC1wqUWAaGrGqpt61C806KKOcADCqW8hWuXulAGlk7rzoPWhRgVO2jP/oY8ZTB0uFzBzXp3HxGCbGBtJ/hqWhkucV54ujVBB7ZRHxjIHjF1wF+tUBso0fmMZQ/pVJoGnZEhzXhgSV6WeNVcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQtkQA6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEF3C4CECC;
	Mon, 16 Sep 2024 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526994;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQtkQA6poUDwgB5xEWIt215FswGm/yvybfI6UR88rN3iXO1gJU5nOMmpV0sn9wVAX
	 6/vuWFPV+5+JVZpnTnJr1KqkWV4m3v1RuLIXlFoK1IH4znBmGaBFIoH5zMF9HrqAAJ
	 p1mnDM8Inc/2hJq3iX3Vg03GY+iJpWJfqf0RgpZ21wOrfRv1hrsOu3CDS2EGz89qG7
	 vYCfrp/PuP+7ArKlOfchOCXqTim9YL8rkak+VwoUVJIft1lhRvUYSXMZ0CA5Clr++Y
	 RV8xbsLwCLeuTh/DjcVOmXoEHdNpRTy1rjR+C/KDGI0g0ToTlTt8pCEOiGyxlDpBM8
	 NZ3S5DVN17Hyg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/19] kallsyms: Use kthread_run_on_cpu()
Date: Tue, 17 Sep 2024 00:49:12 +0200
Message-ID: <20240916224925.20540-9-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
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
index 873f7c445488..cf4af5728307 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -435,13 +435,11 @@ static int __init kallsyms_test_init(void)
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
2.46.0


