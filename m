Return-Path: <linux-kernel+bounces-201354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601D8FBD75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88B11F22E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31614BFBF;
	Tue,  4 Jun 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQuK7mO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE13BB24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533609; cv=none; b=VoRwJHtoWV+WU/6N198JBA8n/wmJUc0KIG48qg0VO7sAead0GmxtpxNR6PUqbgcPesi8EzCsKbSV5ENty3lAobMd4cUBVtimhLcVMYphdk7gmo9WgB3JQzAnI7bYeUpKFslo/57rWr/Ke5sxR7K2DPiTWnYNsyUhQMj9VnYfDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533609; c=relaxed/simple;
	bh=OA4jXIR7HzNnpaEbG8qQ2TpYGmLYNKQZaYWLgI4fz70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjrEkKe+ZXWe1WNkR7GgY60cEmyZC0NrLT7uZUcxssXl1V4i5NiJr4EhVg9GRLQlyJQZiA7WcYigUh2rGxhMtYQ/LrnRabh+IG0h/OnGZp65xPCb/vr5xIFLMQe0jBx+upaY0SgdVut8Nk3RNLXo6EqrFHDVCg0dgZlx23iqzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQuK7mO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5893C2BBFC;
	Tue,  4 Jun 2024 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533608;
	bh=OA4jXIR7HzNnpaEbG8qQ2TpYGmLYNKQZaYWLgI4fz70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQuK7mO8wi/Niq/PkspASgP/nPjYY3fsO3u+c0iQ72Y+DdLzwdW5KhZx9S1D90eF5
	 H5zIDaBAQkbsSDTRfhShL+zOdJ5gUIdTgKx8xy++sd8dntdLIr8LRIgNkPiwC/qB+Y
	 1IO0oO9SYbRYojZHcFodL+pK2d35OT5g4lgrsSAvULWdc+O0ubFaKETiRai07Nuwoa
	 lyUJdv49tW37eVsQAY+IKuPFongImcl5sGRj+bCLgra8GaXTFFMuZRffYCI0xfs642
	 gzTxpdwkarELkZS7vB4/8dEktBGZeUMyjI/xDdAtFgHqIQbAlaet5xhSW1Y0pOgMLp
	 MCMWsJuD2dyYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 77B2CCE3ED6; Tue,  4 Jun 2024 13:40:08 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: elver@google.com,
	andreyknvl@google.com,
	glider@google.com,
	dvyukov@google.com,
	cai@lca.pw,
	boqun.feng@gmail.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH kcsan 1/2] kcsan: Add example to data_race() kerneldoc header
Date: Tue,  4 Jun 2024 13:40:05 -0700
Message-Id: <20240604204006.2367440-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ecf1cf53-3334-4bf4-afee-849cc00c3672@paulmck-laptop>
References: <ecf1cf53-3334-4bf4-afee-849cc00c3672@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the data_race() kerneldoc header accurately states what it does,
some of the implications and usage patterns are non-obvious.  Therefore,
add a brief locking example and also state how to have KCSAN ignore
accesses while also preventing the compiler from folding, spindling,
or otherwise mutilating the access.

[ paulmck: Apply Bart Van Assche feedback. ]
[ paulmck: Apply feedback from Marco Elver. ]

Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/compiler.h                      | 10 +++++++-
 .../Documentation/access-marking.txt          | 24 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8c252e073bd81..68a24a3a69799 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * This data_race() macro is useful for situations in which data races
  * should be forgiven.  One example is diagnostic code that accesses
  * shared variables but is not a part of the core synchronization design.
+ * For example, if accesses to a given variable are protected by a lock,
+ * except for diagnostic code, then the accesses under the lock should
+ * be plain C-language accesses and those in the diagnostic code should
+ * use data_race().  This way, KCSAN will complain if buggy lockless
+ * accesses to that variable are introduced, even if the buggy accesses
+ * are protected by READ_ONCE() or WRITE_ONCE().
  *
  * This macro *does not* affect normal code generation, but is a hint
- * to tooling that data races here are to be ignored.
+ * to tooling that data races here are to be ignored.  If the access must
+ * be atomic *and* KCSAN should ignore the access, use both data_race()
+ * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
  */
 #define data_race(expr)							\
 ({									\
diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 65778222183e3..3377d01bb512c 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -24,6 +24,11 @@ The Linux kernel provides the following access-marking options:
 4.	WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
 	The various forms of atomic_set() also fit in here.
 
+5.	__data_racy, for example "int __data_racy a;"
+
+6.	KCSAN's negative-marking assertions, ASSERT_EXCLUSIVE_ACCESS()
+	and ASSERT_EXCLUSIVE_WRITER(), are described in the
+	"ACCESS-DOCUMENTATION OPTIONS" section below.
 
 These may be used in combination, as shown in this admittedly improbable
 example:
@@ -205,6 +210,23 @@ because doing otherwise prevents KCSAN from detecting violations of your
 code's synchronization rules.
 
 
+Use of __data_racy
+------------------
+
+Adding the __data_racy type qualifier to the declaration of a variable
+causes KCSAN to treat all accesses to that variable as if they were
+enclosed by data_race().  However, __data_racy does not affect the
+compiler, though one could imagine hardened kernel builds treating the
+__data_racy type qualifier as if it was the volatile keyword.
+
+Note well that __data_racy is subject to the same pointer-declaration
+rules as are other type qualifiers such as const and volatile.
+For example:
+
+	int __data_racy *p; // Pointer to data-racy data.
+	int *__data_racy p; // Data-racy pointer to non-data-racy data.
+
+
 ACCESS-DOCUMENTATION OPTIONS
 ============================
 
@@ -342,7 +364,7 @@ as follows:
 
 Because foo is read locklessly, all accesses are marked.  The purpose
 of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
-concurrent lockless write.
+concurrent write, whether marked or not.
 
 
 Lock-Protected Writes With Heuristic Lockless Reads
-- 
2.40.1


