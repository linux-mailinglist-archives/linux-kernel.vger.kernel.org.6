Return-Path: <linux-kernel+bounces-228992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B291991697C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6473A1F2109F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6E16D30B;
	Tue, 25 Jun 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgt2fyT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B916C87A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323582; cv=none; b=s4yhmwm6rUC2BJyqLPsBezGE20FuSIUMMwHYDgfwwWFn7rpMZGI9v/O4kxBV01ZEu2UbT2NsIOkfpf6j2/dWgtChMOSbqpBcMhPkuiQljljPsghqBIJz+JdgKnuYZvmLush/RyYQOTJBt2OwopUAluOIFsxQFkJwfdfI67ak/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323582; c=relaxed/simple;
	bh=xcwSoktWtb2GRPN0qb4RAhRIXNrCFWUhJrYeNl3lG5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8TglDWpBN+cRo6FMN97i/B6uTJsbTxlnvyb9O5OEoKofX4kILigYZH7HyerGaTTVWECnKbNDabwlWXwTl2IiX/jV0eZHFXoDj6vOY35fgapFR/TLN5bPkg3rXtpSOkKEXeM39w22UdILxH9i58SeKr8sMcpSfSXaqItp3VHfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgt2fyT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C613C4AF09;
	Tue, 25 Jun 2024 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323581;
	bh=xcwSoktWtb2GRPN0qb4RAhRIXNrCFWUhJrYeNl3lG5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hgt2fyT92tOPNdLavtHVDgjO5wk805rmWMAbRmSYeCjCPjs/Xwtz6/qvRFHptYbML
	 gu07aPk6N4Svolo1Lzy7PBVDtOrZY+QpbeCDpwdvs1rYBo5KwcoV1yYlPCMV8xSkT1
	 aS7VzWxcZcRsmvheTWCiB71O+7Iu85baTVSQoHxmAPZAyxTvar/ptQLGJ/D9PBBFYN
	 x7ACrgkxXykgHhPJtWOJm20tWxBbKzIIX17i+7R0LSIjkerL7lgy4YqQLJa1rSQ6mW
	 S3xD6IShUAvedq2dDaiaiKU4xK0+jXhzzzgET3LDY1uIMNQSXo/UBTA451u7s4fpnH
	 D2/UjzGxQ8IDA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 4/6] tick/nohz: Move nohz_full related fields out of hot task struct's places
Date: Tue, 25 Jun 2024 15:52:42 +0200
Message-ID: <20240625135244.20227-5-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nohz_full is a feature that only fits into rare and very corner cases.
Yet distros enable it by default and therefore the related fields are
always reserved in the task struct.

Those task fields are stored in the middle of cacheline hot places such
as cputime accounting and context switch counting, which doesn't make
any sense for a feature that is disabled most of the time.

Move the nohz_full storage to colder places.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..d531b610c410 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1039,13 +1039,7 @@ struct task_struct {
 #endif
 	u64				gtime;
 	struct prev_cputime		prev_cputime;
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-	struct vtime			vtime;
-#endif
 
-#ifdef CONFIG_NO_HZ_FULL
-	atomic_t			tick_dep_mask;
-#endif
 	/* Context switch counts: */
 	unsigned long			nvcsw;
 	unsigned long			nivcsw;
@@ -1350,6 +1344,14 @@ struct task_struct {
 	struct task_delay_info		*delays;
 #endif
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+	struct vtime			vtime;
+#endif
+
+#ifdef CONFIG_NO_HZ_FULL
+	atomic_t			tick_dep_mask;
+#endif
+
 #ifdef CONFIG_FAULT_INJECTION
 	int				make_it_fail;
 	unsigned int			fail_nth;
-- 
2.45.2


