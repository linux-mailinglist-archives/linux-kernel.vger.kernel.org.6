Return-Path: <linux-kernel+bounces-264516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68393E466
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1D11C209BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF436AF8;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="doAWTjNN"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD218EAD;
	Sun, 28 Jul 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161417; cv=none; b=AbJhdi46b7O8szTP2Ktino0m7lFuUzKtLw1XDcOBcSifFIqhDRq2SnT/GsN/BQG1T/K8VKdsuhYo9OrwtiLmgqgAomYVYjQ4J2iIwbahz4G2Ogv37iKtn5ct8ku1UTgICTnlfL+WRybEEj/ISHnpuOpZovDOAUnSVAs5ldENsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161417; c=relaxed/simple;
	bh=GxSzGOHKEeRjWP3xVjt6xdWG7hTZQxCczvHBYzc4qlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e15F344Cj3ytVNFWyrbbIiDjH4cvRLtd2tPab0ZUaEeePCkZP6SZkTHmgdXxgqUhW4heNpkYafJyfjrDFna5FF1HpEsKUau4V71d5etxSHsIS65xbpiycjpLmrOKpt/x/bYdcpKvyb+BlDi603j5G/zPRlSmaSX/RYlaMcdG7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=doAWTjNN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=GxSzGOHKEeRjWP3xVjt6xdWG7hTZQxCczvHBYzc4qlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=doAWTjNNmXDHTRrVpHvfdLySLyundnPs+8qf6pP7RMI/VtoJbsMModZNxEJViF8Lr
	 Jnoff18zcsh+sFozWMX1P4KfB95ZV5WD3QT8I/54j+LPrwoL/JD3+WLIlSkLBv5+zN
	 3Buek6Xgrvv1GM1MlZwq3dywVN3unuEFur6fb9go=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:09:58 +0200
Subject: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1386;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GxSzGOHKEeRjWP3xVjt6xdWG7hTZQxCczvHBYzc4qlQ=;
 b=2zz/Gyo+bbly/Yk7JgL6hkfk9330xWmuID8rgFn7Zqmr7Qqg4q2o/ni8KIiSXdry/nKr4NAmz
 nLttwgOE1MlAbnXg6oS7gK1MDVUN+qC9WeF7og4+T2CPxo8MHIWAn6p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current entrypoint attributes optimize("Os", "omit-frame-pointer")
are intended to avoid all compiler generated code, like function
porologue and epilogue.
This is the exact usecase implemented by the attribute "naked".

Unfortunately this is not implemented by GCC for all targets,
so only use it where available.
This also provides compatibility with clang, which recognizes the
"naked" attribute but not the previously used attribute "optimized".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index fe3701863634..f77bb7d3e1a8 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -9,6 +9,15 @@
 #define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
 #define __entrypoint_epilogue() __builtin_unreachable()
 
+#if defined(__has_attribute)
+#  if __has_attribute(naked)
+#    undef  __entrypoint
+#    define __entrypoint __attribute__((naked))
+#    undef __entrypoint_epilogue
+#    define __entrypoint_epilogue()
+#  endif
+#endif /* defined(__has_attribute) */
+
 #if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
 
 #define _NOLIBC_STACKPROTECTOR

-- 
2.45.2


