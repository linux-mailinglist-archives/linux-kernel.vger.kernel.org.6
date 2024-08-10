Return-Path: <linux-kernel+bounces-281876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7841894DC5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B70DB21717
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CA158536;
	Sat, 10 Aug 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mkVxGP8H"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EA14B953
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723287294; cv=none; b=pWKIfQauL3RUTRD1+v1b0ls2XPgtSUdlbMLNWJp8d8FWyOsdenl6bOn5cimzov5xVbwDL8hJxXQSaqZvck/XE23+2szvvz6S96kDun8008pDnYk7fyh7mrIbjzdz7vDtLM/67z2KQc126bEAwgJa54Ec401cSv+Bc4FvNMwZ5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723287294; c=relaxed/simple;
	bh=z3w93LOL9fjfsx7yQoNTkkHmxM3qflDq5L7Pix4aaTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qEZuW94Xmy4GbuYYp+f5Mt2Q1k5YEYnmExNsBlBw0KCvPD5wF7apKEBWxOD5LvdI5waf5C7Kfznmwes9hG7Eydz4JEcesqCvmjVpx9q+KGl7EfbfLML6ASjfSsCid2Qy2u/zTc/JgvrAt/2/mh5i6Mfm0RRbu3r7/PsAl1DM+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mkVxGP8H; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723287289;
	bh=z3w93LOL9fjfsx7yQoNTkkHmxM3qflDq5L7Pix4aaTg=;
	h=From:Subject:Date:To:Cc:From;
	b=mkVxGP8H23U0LplqYDIdTlhFsa2mW1AEX0dshPkRiyKkNN52oXaj01oorejhFo7ic
	 OP+WWw5Cm1XAbRmTd9lrVDf6NJpyPyonWwbakGmYWummzAICDmaXvBl5sISq5e19q+
	 YFCkQNB2l1UhioEBftgKI60JVjvDw6JT2pZwQ9pY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: LTO compatibility
Date: Sat, 10 Aug 2024 12:54:43 +0200
Message-Id: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPNGt2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyML3bz8nMykZN2cknxdY2NDC0PjJHOjRIMkJaCGgqLUtMwKsGHRsbW
 1ACqSMGtcAAAA
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723287288; l=3233;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z3w93LOL9fjfsx7yQoNTkkHmxM3qflDq5L7Pix4aaTg=;
 b=JMx7lt0QKLy1t5LX64vrAI+S89YNrOVhDVySC+CHYGavaSvqh2QTSgUJ20ioRQVbcomVcvxWD
 gwGGzYq1hBAC7Bq+a6VAcTskqxwbqGAE1rVEOfxkI02YSYgtZIyhkip
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A few tiny bugfixes and refactoring to provide compatibility with GCCs
and clangs -flto.

$ CFLAGS_EXTRA=-flto ./run-tests.sh -m user   -l
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
riscv:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning

$ CFLAGS_EXTRA=-flto ./run-tests.sh -m user     
i386:          195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
x86_64:        195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
arm64:         195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
arm:           195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
mips32le:      195 test(s): 190 passed,   3 skipped,   2 failed => status: failure
mips32be:      195 test(s): 190 passed,   3 skipped,   2 failed => status: failure
ppc:           195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
ppc64:         195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
ppc64le:       195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
riscv:         195 test(s): 191 passed,   2 skipped,   2 failed => status: failure
s390:          195 test(s): 190 passed,   3 skipped,   2 failed => status: failure
loongarch:     195 test(s): 190 passed,   3 skipped,   2 failed => status: failure

Note that on GCC two tests always fail, as with -fLTO the constructor
order is inverted, for which nolibc-test contains two testcases.
See [0].

This series depends on the nolibc LLVM support.

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103080
[1] https://lore.kernel.org/lkml/20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      tools/nolibc: crt: mark _start_c() as used
      tools/nolibc: stackprotector: mark implicitly used symbols as used
      tools/nolibc: x86_64: wrap asm functions in functions

 tools/include/nolibc/arch-x86_64.h    | 80 +++++++++++++++++++----------------
 tools/include/nolibc/crt.h            |  2 +-
 tools/include/nolibc/stackprotector.h |  4 +-
 3 files changed, 47 insertions(+), 39 deletions(-)
---
base-commit: 6164f3d0f577a2ab82b8235129fd20b2142e03b1
change-id: 20240728-nolibc-lto-331813b72a0b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


