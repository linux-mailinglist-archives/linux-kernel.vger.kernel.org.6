Return-Path: <linux-kernel+bounces-518704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCDA39388
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F4D168397
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0388A1B4F3D;
	Tue, 18 Feb 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o3lZT6pj"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC337136A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861016; cv=none; b=SA4ADTTIVMzVhc3eBl3VSW3yMQC0OWLHh/XB9ZmWgo7Dt4GepCeMltrXyX28cs7ik40NUEjnY5tZdGlVQ8OwA33ZeAXb0LPJdDq1lZw6CrCc7aeiBpoe/PlBV4Gz5VrHxQJEgl5bpFeQ8uP8R3BDW/HZK0HAICbrdGGETW6tec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861016; c=relaxed/simple;
	bh=DH6mEWdqABSgULBLCgUsQFLw9L0yuVYugT+TapM2vvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d334k41ajFqnIL+p0qwUMbzhHEw19O+mroEfDx0jw+9ar9MBpE/Ps5ByhLf8SDJbRWb3j8ovKX6uvob8ExXbkvG2eaPJPtcHNpxJ++sQdP0en+cMvVJoy5ikgALuhKMk+DmqAhBYxGWzUqnaWCx0yG7sc2XjTOZvSin/IKcb/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o3lZT6pj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739861011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1r9PHZQUiX+ioK0bRPX2qDphzdD6Q4r1nsu6dbgXRmU=;
	b=o3lZT6pjwoUkOWRA1JshQuzyfE0W/ABDpVDJ3YDeXC4SKe3FRhQGt3ndd8zeaNHlnd9vK0
	Fjh76bM9grzbXxCQul2BYzFd7Frp4y3gigEUkBtFopc1Ugj/I6M3rDkDJa7Mp16zr8Cj1Y
	dWQvvsDn8ApRfrUxIYMmPkjqiFlHi6c=
From: Youling Tang <youling.tang@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	youling.tang@linux.dev,
	k2ci <kernel-bot@kylinos.cn>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] objtool: Add bch2_trans_unlocked_or_in_restart_error() to bcachefs noreturns
Date: Tue, 18 Feb 2025 14:42:30 +0800
Message-Id: <20250218064230.219997-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Fix the following objtool warning during build time:
fs/bcachefs/btree_cache.o: warning: objtool: btree_node_lock.constprop.0() falls through to next function bch2_recalc_btree_reserve()
fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function need_whiteout_for_snapshot()

bch2_trans_unlocked_or_in_restart_error() is an Obviously Correct (tm)
panic() wrapper, add it to the list of known noreturns.

Fixes: b318882022a8 ("bcachefs: bch2_trans_verify_not_unlocked_or_in_restart()")
Reported-by: k2ci<kernel-bot@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 tools/objtool/noreturns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index b2174894f9f7..6bb7edda3094 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -19,7 +19,7 @@ NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
-NORETURN(bch2_trans_unlocked_error)
+NORETURN(bch2_trans_unlocked_or_in_restart_error)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)
-- 
2.34.1


