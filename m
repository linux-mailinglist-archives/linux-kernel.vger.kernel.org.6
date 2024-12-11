Return-Path: <linux-kernel+bounces-441549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B79ED00E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E18E188AD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303261DDC19;
	Wed, 11 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smcjqawM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775E1DDA3B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931657; cv=none; b=Jb+UDxbndP5Q4YowoUi7vorLCeT5iH9sCSWozJLyfXX6PmOVrDt0y1x+mpeTSUZabetON88QVKQv9sA55Qhtf0xDpMwKD3Z5GRDGOJMsFlBbK2lOvtX3khQ/OLqyZhaHiRPUFdCtZqxDIl8rL0B88H0Rw/cIUwzvqjAAJwZ8f+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931657; c=relaxed/simple;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHgCPYeeWmG/v15eZcCp5LJ1l+mhj+ZLnWqwyQ4Tb9FLLqHJtA/br502lhZfgq4QYLNMlMCChPkdaeBdx9xH6cplkq5/1aC02HtBbnBampuP7+6c7b9VrPZ7/cD47onbM7oEo6nNIrGtk906BnahdJPkqqovpt4UC999GEfErwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smcjqawM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD99CC4CED2;
	Wed, 11 Dec 2024 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931657;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smcjqawMGFcjfdp1oqJNoGmx5H7V55PYNCi6MqlCmWCeDkkYVxlJkQJrng2V7Z6v+
	 Z2DNnmq5bnmNbXa28c1PnQPNYvGreZA5+HVT1JSpkY7JVpwvSg2K+mybdFz+E1twrq
	 R4MPJEWT5oTBDqWkefLmsOX+a77u9Zt3YPF+gUKeJBbpsYrCD4cfqVfSKULkIPbIHP
	 vW4krRVRkD93O0gXb51IRi7Lldtt0syNqgRYG+/S84Xc064s7PoGMPrWohPy1MJqnt
	 z+eRLA9/4mXF+dAua/BcYbpduYv3qIouCB5/0oy85YNhUAsjcLW8KtFNNytvfcwKZq
	 6F+6xhAC2QoLw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/19] kallsyms: Use kthread_run_on_cpu()
Date: Wed, 11 Dec 2024 16:40:20 +0100
Message-ID: <20241211154035.75565-8-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
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


