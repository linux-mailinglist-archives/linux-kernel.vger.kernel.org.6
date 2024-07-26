Return-Path: <linux-kernel+bounces-263776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E393DA54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0B1283000
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26A156256;
	Fri, 26 Jul 2024 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVRoiIez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBD156231
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031045; cv=none; b=ILKEOOdj+RSe1HMim0aWbHzkfqnQOTDRGPwRdgUJRwJeX1YfpEmrT1KeqPQFJf9MrLzlGiR6bw2T4jU+PncItkN+kFyQq1Sw6DarqW3+nA0u9bcffnBG9//vPYp+M6jL9vjQi1/xYC7WHCkA9mAfhe787ChCk78UWGjrdDYm6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031045; c=relaxed/simple;
	bh=9kOLAfsZJjFZ6fYtWV+X45xaPDhWdeE6pob4ljCqnAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzns4dZDDR3TDJiPfvSqCpDItHQFBOAdQadRt54IDTggpHMrNNJOsM3rXLepW+GpHb05fEVl4oFXz7GOJppSwDAH/Jq+i0R+ZMi90EvBeu+mesCrHRDd7s2vTf3+Mt2muyReUPMgIMbJYvinlBeI4UhDjhxamNBGmB9mY3VxyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVRoiIez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D64C4AF0B;
	Fri, 26 Jul 2024 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031045;
	bh=9kOLAfsZJjFZ6fYtWV+X45xaPDhWdeE6pob4ljCqnAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVRoiIezWu8rePHLxwFAy6FCDOnSxSxivQcPyRCd/kK9tf0ZRgdpOFzEVHMjY9pqf
	 vZzAPwo6A0euFdMEv8e0UnymlKAw0n6iOesYYWmYcWcdnx8JMNmjKc6cRIS5nwJGHn
	 bdjPFymOYh7cVZTjGzizyUqNAPBTx1jaVtoiSo1aTuHAmUyXWI0nMwZ5BZpB81Xmg7
	 UE/tZqGz+bYBP2cDiZDJR0RCuZiooAgEBMyGb1i5SycADhT8DXnh8EMRy7RV6cXdME
	 IhGnEiDvn5gpx+gJSTnrfu6h9Blr+BC1uz/oFD9sGcgJqAtxELz9H+ZAKw5H+FZ7Gi
	 CjV0Z9Kp41K7g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/20] kallsyms: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:44 +0200
Message-ID: <20240726215701.19459-9-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
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


