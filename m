Return-Path: <linux-kernel+bounces-264521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0322D93E46D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55CA1F2172C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3A46450;
	Sun, 28 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="e/xkfjJ4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC1381B0;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161420; cv=none; b=TnuRb4hL+Trwo4xnWxDJhop/6ozhCj/JB4bFKuSXrVlWtS8vY8FU0aeyZTkTlg4eLGDExq9RplDgR/fLv+oMxsFGmQ39pXL0SzM/LpptK9r7wFOOZzKOZiMv2KdFK2URI9ggf7bUYMe82SMFPrG6H9m2Jb9EXr3jwpso6L/3wF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161420; c=relaxed/simple;
	bh=lo6aJXOfjDRlyr2OAinpgQZv73POOs4srT6onhZTZKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFMpW9x/bZcEeC+tK3McaJDRrF4gVtqZrJCDfjCyF14J1gAG7NisyrjS1UBTVFBoEdK1kqsuL+iaYYLuvpsskYQxyzdWFziHJiWYhk0xMKMOYhBln22P7+CDukrxNwfbiYgwBmvkldaWQ+pa8O0FA7Psw3HpcrFG1+t6yx9LFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=e/xkfjJ4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=lo6aJXOfjDRlyr2OAinpgQZv73POOs4srT6onhZTZKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e/xkfjJ4dJ0C5DlpCqrXWxE1GnoxaLPGlc9UdXAjlrbvWL/5I/vUmRyhdZrI//22c
	 cuRvssGzNW7XBY61+kzKL8yoJo3IidG0XrlQobsvTARmy7YvhYn//l6KF/9bcfl2+x
	 orfrnuit3Sv/16d5iD0yYPk4GKyopO9AbdN3BpPE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:00 +0200
Subject: [PATCH 06/12] selftests/nolibc: avoid passing NULL to printf("%s")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-6-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1027;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lo6aJXOfjDRlyr2OAinpgQZv73POOs4srT6onhZTZKw=;
 b=Dv4cgcH/AUMGAp4+z1OvGbmQf7Hxb7fm3mt3D/t8n3oidT0Z6dHwa/eyG8T7uid7U91jsBBHc
 Qa38QwRevryDjxUDkG6cBysPAwDFkvc5xwcN2K8QcwAO9E0yJCJJ7Ww
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Clang on higher optimization levels detects that NULL is passed to
printf("%s") and warns about it.
Avoid the warning.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 093d0512f4c5..8cbb51dca0cd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -542,7 +542,7 @@ int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (expr) {
 		ret = 1;
 		result(llen, FAIL);
@@ -561,7 +561,7 @@ int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (!expr) {
 		ret = 1;
 		result(llen, FAIL);

-- 
2.45.2


