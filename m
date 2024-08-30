Return-Path: <linux-kernel+bounces-309021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31F96654B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FB31F252BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C81B4C56;
	Fri, 30 Aug 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NlyH9y61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2D1B5815
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031479; cv=none; b=BhxbV/CwkgL8nnk/7AVuowSb+eZILvDqTcAHRPAS6fwOP58YeFePgmcnuUKwe/lQJUldBoD5h0V7WM9hKMNl/DkzOyalSgpk7pbP6agjlGeP2lyTgVvf6rUvO2Df+qg5X4e5+lr4ZnwQa6jxy9hs1i3iCb/RFWcVKTky05K7uPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031479; c=relaxed/simple;
	bh=7gVWwKSUS0f9va6BqOKjHv3OfRCpNDvRp6SK7Qem5OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI30fdvLrpH3UY04njxD7OouV/DHJKlVe/DI1Y6hvyBo20GcROyewqtreDZJcr26ILSkYJNcpkgocV3rPF0a3IvJtm0Gg3JbqbRhQN8InwtmDWxg2i2FiCUzDYOEjeO/fRxZ4CK8X20Izgt+OyhXSJPdtMzEFtlQV1wAWslIz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NlyH9y61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D2C4CEC2;
	Fri, 30 Aug 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NlyH9y61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725031475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H+DnOiSvWu2n527v5L4litbqZMChzIRLpR199s5kAI=;
	b=NlyH9y61BCnFuaaQjlcdD76NUEJ23iegUi+HqKlaRMxazLTWfTO9Jy78+mkdKT9G2tB/5X
	uhdMGQ/D+EBXE1aHgVm4iNYHeBVdqIM0IEqZN1Oy72v5jXIPbBtp9JIRYLSD3YbQQ4i4cR
	zEvcjubwa1/efzp+2CAIbcBSLSFY2s4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 87ea9d78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:24:35 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: broonie@kernel.org,
	adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests: vDSO: quash clang omitted parameter warning in getrandom test
Date: Fri, 30 Aug 2024 17:23:52 +0200
Message-ID: <20240830152429.490640-1-Jason@zx2c4.com>
In-Reply-To: <ZtHjejGdhZnZu4WQ@zx2c4.com>
References: <ZtHjejGdhZnZu4WQ@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with clang, there's this warning:

vdso_test_getrandom.c:145:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  145 | static void *test_vdso_getrandom(void *)
      |                                        ^
vdso_test_getrandom.c:155:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  155 | static void *test_libc_getrandom(void *)
      |                                        ^
vdso_test_getrandom.c:165:43: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  165 | static void *test_syscall_getrandom(void *)

Add the named ctx parameter to quash it.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This will go in random.git alongside the stack of other fixes to this
area.

 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 351daeb649c8..8866b65a4605 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -143,7 +143,7 @@ static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
 
 enum { TRIALS = 25000000, THREADS = 256 };
 
-static void *test_vdso_getrandom(void *)
+static void *test_vdso_getrandom(void *ctx)
 {
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
@@ -153,7 +153,7 @@ static void *test_vdso_getrandom(void *)
 	return NULL;
 }
 
-static void *test_libc_getrandom(void *)
+static void *test_libc_getrandom(void *ctx)
 {
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
@@ -163,7 +163,7 @@ static void *test_libc_getrandom(void *)
 	return NULL;
 }
 
-static void *test_syscall_getrandom(void *)
+static void *test_syscall_getrandom(void *ctx)
 {
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
-- 
2.46.0


