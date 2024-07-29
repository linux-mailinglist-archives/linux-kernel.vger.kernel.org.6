Return-Path: <linux-kernel+bounces-266177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CE93FC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66BB1C20FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AA15EFC8;
	Mon, 29 Jul 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qwz/LIT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E91DA24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272803; cv=none; b=bBzwrIvASpr7jCkHAXf3skUwSTodrnDFIv6Cq8mQ9/0MCHC/8Gakx+wN0QMjWe1g0BHafEzX9xtSN/nD6MlCPJo/rrywMIvMheUstjtfYc51QmoSICYCHk/O3CygnVWcAbpZcQOZwiQR+v0Zr+DDTlMSAFSSCEO5N8vEEug18a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272803; c=relaxed/simple;
	bh=H8LqM1vVwV4D2NOWzzUb8ajziic3Ihe9GcXyFxhFMrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMu8/y8uDak/B2qLrNGiuRbG7HT73MNMPDQPswNBo5yw+KA1Q3CWRDXWSzxrYc+YrYsxz8CVy8D2xonPVJm1WtlrjFN1fnujkPH/lU6EDMB8kDpjfUv6LHjBtjwcPafUWnOOe3TZ8c6CR8/T+U3SuBF8cYS6BQwSDiDHizWUdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Qwz/LIT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A741CC32786;
	Mon, 29 Jul 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qwz/LIT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1722272801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KzOgCsm4+QXyIMxKMBzF9Y+HbbcubFAkdH7t3Gz8ZQ=;
	b=Qwz/LIT9iIlWm2q6np3OpS55lH44ORkE+gXBQ2sKBmmdyAH7svVVd0nAiVA3ylXND+AFLJ
	tmx+1qc+9RY/R5VQ6Wp78SPxT4fzNw/MBc1S8v6mjM8tpOiVZ3Lo560oCwW04nVtwgDjD8
	yFKsKu/yzjl6JW/OsyA4t0JcgtVlvKQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a0b094c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 17:06:40 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests/vDSO: don't #include sodium header in chacha test
Date: Mon, 29 Jul 2024 19:06:33 +0200
Message-ID: <20240729170637.335506-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With changes in various kernel headers, there's a clash if we include
the libsodium header. This is especially hard to fix with build flags,
because we're compiling the assembly together with the C file, for
testing. Instead, just add the single library prototype we're using in
the file and don't bother including the real header.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index e38f44e5f803..ade9897535a1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -3,13 +3,13 @@
  * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
-#include <sodium/crypto_stream_chacha20.h>
 #include <sys/random.h>
 #include <string.h>
 #include <stdint.h>
 #include "../kselftest.h"
 
 extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
+extern int crypto_stream_chacha20(uint8_t *dst_bytes, uint64_t dst_len, const uint8_t *nonce, const uint8_t *key);
 
 int main(int argc, char *argv[])
 {
-- 
2.45.2


