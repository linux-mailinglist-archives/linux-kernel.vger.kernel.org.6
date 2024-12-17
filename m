Return-Path: <linux-kernel+bounces-448743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EA9F44EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44524165051
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D88175D50;
	Tue, 17 Dec 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFQleMFq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAED653
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419901; cv=none; b=tCDEY6JlHa7DpWSZqw9/4fwbc/eLN1cE4pmwlyZrZU4jV00iWllW8pceWzLIHwBK9rHV//X02g5LfY0LZwd4DuRZ1q0xD6vp2ikFfzMXIhZ1/bNeI/Cz8XeGm3ydcwa0y1C5WVDwLXKM3zLTbnC0osyZI12/SuolBr8XMuiPJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419901; c=relaxed/simple;
	bh=z0Hv0hVVIyXmW9YOJ0qnuaMS9KzgS+xJ3FwyQp/sMwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UNUjnKe9joiZpEZ8IfxcWbKvXjcj/7z17ojo/0ESD4EP4C9L2XFfJ0jWMs2HQLSxVJ6DvobDk1z1iylWksfzyPUoamOjEwhbVGR/2d+6CvOn4lRgMsnMBLhrm25dOC0ZJLWY41IgYpMB8RoSbOXnsIRvxt8PT5aKGHEAhdTAquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFQleMFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD7C4CED3;
	Tue, 17 Dec 2024 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734419900;
	bh=z0Hv0hVVIyXmW9YOJ0qnuaMS9KzgS+xJ3FwyQp/sMwk=;
	h=From:To:Cc:Subject:Date:From;
	b=lFQleMFqXPJo6+S0J63t2NDYVTwaGyebC69X2BsCilpEjS5FhZnRVd5t1eJ0Sf6qP
	 QEMLg5GZE0AJpKrlMKajZwwN5vIl8t1JKOt3Tf7qkn9QLw/C0wonnW7oQJ7jxhQpCw
	 A+XBVYPZOwLGTbH77rybe3qIPLEq5Y+Q/XE/cbP1MmOH9eTM6kuTX/BmaOqusXpA3b
	 Bla5/OXqpsqCZCpOQ09tbtvgWE7o8ZO0uDcDBTCyX9/iTFYEtnGb5l3O4z+Xt1YWbN
	 3cZLTYvSEGi1Q0NvXQtK9rPJ9aW0t0WDtUhFJ+gRL8d4cAajGrd7PJxqzLZgTIB+vQ
	 66U6wpEaNCKUA==
From: Arnd Bergmann <arnd@kernel.org>
To: Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kcov: mark in_softirq_really() as __always_inline
Date: Tue, 17 Dec 2024 08:18:10 +0100
Message-Id: <20241217071814.2261620-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

If gcc decides not to inline in_softirq_really(), objtool warns about
a function call with UACCESS enabled:

kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc+0x1e: call to in_softirq_really() with UACCESS enabled
kernel/kcov.o: warning: objtool: check_kcov_mode+0x11: call to in_softirq_really() with UACCESS enabled

Mark this as __always_inline to avoid the problem.

Fixes: 7d4df2dad312 ("kcov: properly check for softirq context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 28a6be6e64fd..187ba1b80bda 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -166,7 +166,7 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
  * Unlike in_serving_softirq(), this function returns false when called during
  * a hardirq or an NMI that happened in the softirq context.
  */
-static inline bool in_softirq_really(void)
+static __always_inline bool in_softirq_really(void)
 {
 	return in_serving_softirq() && !in_hardirq() && !in_nmi();
 }
-- 
2.39.5


