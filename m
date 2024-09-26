Return-Path: <linux-kernel+bounces-341091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD233987B48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9242D1F2255B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C71B1515;
	Thu, 26 Sep 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HELp0UUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A81B1504
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390974; cv=none; b=D2KyPSgtMa9VkesE4H1TmpYX/d7S6Qv/hhfCINKTAOnX+VfNA2XOXfz53N+lI2QWfqChzsqZv9yvpqgq0thRoXsFUmop4LhrKHP/zxc8s0VrHiDegzXx6CM9iChrl+NK+EtlJHhDK3kXyd/+OQZGT0nb0XDp8KiFrt9YY3DejLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390974; c=relaxed/simple;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raskwDAb+jjK4DpT8nr59+/1zEN+KTerC/Li3YIE5UJXs6jYDBXmvpbdWmCpuoSMZBU9j0h+JN1hNgAOBVh1xFj8JRqJM/NIReOHH0lqz3QyAAlWxnpiWiwaf8TwI0GATUVxkKjZPerQ2blCPcwgvni6jxGMj3pnfBr8d3NUSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HELp0UUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D61C4CECE;
	Thu, 26 Sep 2024 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390974;
	bh=SrPlU9tOI0Lf76otTW5ESwvT98+pgbNcqxervWYqjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HELp0UUqg1+FQIIMC0NR8Sf8pG2tPjbxeayOqS91nDq2E7TQIkUS9lOo0UNjoQ3DY
	 iicgTnusuLGJtBQzmbCpt/OJFRGDEV0B23+K9jLrKvIU0dw58ANXoxiL9UGnKe9MK3
	 NQyx+spJlki9pUEpF/Ledwcxwdc2pOfwgZC0BgDnARyunvHOk/eSiHLIhK3usGS9wO
	 AlRuODGu2bkfkeEzIUK2E4XDsb6kkX529sXHLn5HVWCH+lII/OnQ9FqYXDX1Fh2RRw
	 2KnVvhxMnjI27mUDo/4pZWvSoAwYRXm1dSwiHRwB7XmMY4H9RvhEvcX6d9Ob8rY94B
	 vofw81gFSaUoQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/20] kallsyms: Use kthread_run_on_cpu()
Date: Fri, 27 Sep 2024 00:48:56 +0200
Message-ID: <20240926224910.11106-9-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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


