Return-Path: <linux-kernel+bounces-406024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E09C5A36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EE7281375
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2D1FF7DA;
	Tue, 12 Nov 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyFVEn/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C71FF7D1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421395; cv=none; b=cTYQNIMIrKkRKpI+O2Xp1ALQRl08LMAa8bwIXmE3oONfosxJVBevydzY+OLTKMT0P/dVje+YKJrCeiko/wVHRZq7R4XrMT6p8wYhZh+/15i/ZAHvdst+Pgr3HHHEzmwGxNVIQ1HQQw8yuWO52JupCsHTavThGkTGWkpHHbMb62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421395; c=relaxed/simple;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/A9zWsPg3ZEO1J+4SSvd6Du+n35aHztjF+7rj1jlV7U0zRkMogqwQiSGqaAcwtGlUeomolKm1baXCzRE3tMi/Xcc2w3IO+6Y87DoHXKeqPVJ71Nn8t8XeJlJ5+TLa1Y/ffrE12LlX9T1/Auox1AA1JCEqsqn4b7y3joUi1jF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyFVEn/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB62C4CECD;
	Tue, 12 Nov 2024 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421394;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyFVEn/8b8SYeCixkycEflU9V1Nv1euMfVVBUOtwVyjlcC2VQlcqhbJl7f2VoN76V
	 1nb81V/s8I0I7lEBXgQp/nH2LoRG8n4eMaIdjrghrTqnr9TijqApQj5WE6yJuRHNaA
	 qcM4aDV2EN0puD9PL6RKIPWf95LUe8/4u1iLj+szXwgbibO1dgUai+t9cvJ0+xLS6M
	 q4iwOtGglEoikdeMRzy8mOCFaPzFcregl4+zxYlK18ymdAWwqx2klPgBCWQNpwtmlE
	 KIBoTA8HHl5GgWpjCR7oa41rUYcV+f8Pd4eZsYccjt2TaN0h2ZCKbnbgLotxpm8RaC
	 Q4oX3QH+jovwg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/21] kallsyms: Use kthread_run_on_cpu()
Date: Tue, 12 Nov 2024 15:22:32 +0100
Message-ID: <20241112142248.20503-9-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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


