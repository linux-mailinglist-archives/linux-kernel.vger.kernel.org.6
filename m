Return-Path: <linux-kernel+bounces-532360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99FA44C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6149171F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FE20C49C;
	Tue, 25 Feb 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXLE/Qnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BD1A0B0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514114; cv=none; b=rXxAoZGnQdhKS9cKpQnZCU5SlHi4UQetGtc21mWH0mKJhjmbQFJhyWxKfXJZ5GbQSgNP/7vhs1xPmmH8wCxpoecpLnWsamY3UoW85DgFHG4wk1Ws1k99CVuoRGscyol9ldXP6VVGdUHfxPK/kfdj25dQrJaeljvbCoSG2yTFUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514114; c=relaxed/simple;
	bh=n3+MMDAPtTCs/1iTDunsmqHajEcFiEAtGY10JIW4VaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=foeKNqXkrNBbSG0jzQU9ZdUQ1s0N5qxYe/4+KwINphA7k/+5erCNvkJk3/owR2/u6P4I7XhleZHtkdorrKvhjThpjUoykEGY2+v7gefV5IKS/J/f8vO2nIcD49wkJdsfLFhy6lL3G1o4Rfja94MR3lCaXrU4YFCkN6yqwbUoZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXLE/Qnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D583C4CEDD;
	Tue, 25 Feb 2025 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514114;
	bh=n3+MMDAPtTCs/1iTDunsmqHajEcFiEAtGY10JIW4VaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OXLE/QnveyxCr5zLkoC0yrS/U3aswTSaM33S30kbH6fyME46ZYHXNEcB9O4WmsFJK
	 rMdRnMv2W7OUpz7DYZCyLO0yRjKHyWfAX7m5hGBbb12y6qfYw1qlaRkwKCDQXuHn25
	 aVZfhxy6w4kU9wUCdFwdp+rO1xLJmFGDzjeoqtu4OcPxcAk3RIYQW3sSlUaSlKrJ0A
	 qYn0IA1B/Al7Ca0Bhxy2wb7/D6QHHE6RFEOhrJ4UCAX3VgYhJL/xOBW6mgyQ/0qytx
	 pZf+crlYC7cz5RoyoPNIt7n3esvDCAtdrK505kzBQshhCCwO2nrQqILuvboKIYUxcx
	 7KmFKwHpQlhtA==
From: Arnd Bergmann <arnd@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Waiman Long <longman@redhat.com>,
	Carlos Llamas <cmllamas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: change 'static const' variables to enum values
Date: Tue, 25 Feb 2025 21:08:26 +0100
Message-Id: <20250225200830.4031742-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about 'static const' variables even in headers when building
with -Wunused-const-variables enabled:

In file included from kernel/locking/lockdep_proc.c:25:
kernel/locking/lockdep_internals.h:69:28: error: 'LOCKF_USED_IN_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
   69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:63:28: error: 'LOCKF_ENABLED_IRQ_READ' defined but not used [-Werror=unused-const-variable=]
   63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:57:28: error: 'LOCKF_USED_IN_IRQ' defined but not used [-Werror=unused-const-variable=]
   57 | static const unsigned long LOCKF_USED_IN_IRQ =
      |                            ^~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:51:28: error: 'LOCKF_ENABLED_IRQ' defined but not used [-Werror=unused-const-variable=]
   51 | static const unsigned long LOCKF_ENABLED_IRQ =
      |                            ^~~~~~~~~~~~~~~~~

This one is easy to avoid by changing the generated constant definition
into an equivalent enum.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lockdep_internals.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 20f9ef58d3d0..8b4cd6540e49 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -47,29 +47,31 @@ enum {
 	__LOCKF(USED_READ)
 };
 
+enum {
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |
-static const unsigned long LOCKF_ENABLED_IRQ =
+	LOCKF_ENABLED_IRQ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE |
-static const unsigned long LOCKF_USED_IN_IRQ =
+	LOCKF_USED_IN_IRQ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE##_READ |
-static const unsigned long LOCKF_ENABLED_IRQ_READ =
+	LOCKF_ENABLED_IRQ_READ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE##_READ |
-static const unsigned long LOCKF_USED_IN_IRQ_READ =
+	LOCKF_USED_IN_IRQ_READ =
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
+};
 
 #define LOCKF_ENABLED_IRQ_ALL (LOCKF_ENABLED_IRQ | LOCKF_ENABLED_IRQ_READ)
 #define LOCKF_USED_IN_IRQ_ALL (LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ)
-- 
2.39.5


