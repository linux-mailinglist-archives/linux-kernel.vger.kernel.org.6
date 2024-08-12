Return-Path: <linux-kernel+bounces-283774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6B94F890
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EFD2826EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0C199230;
	Mon, 12 Aug 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SVjhD+ox"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF79194AE6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495830; cv=none; b=UrKtYZfcemoVLpo9oGSFHSUmX0H/+8+ib7ta4R0vOpQgIXyEsCYCrmKHfzj539ov921+RtNvU/YeGtxKg10p9rLFhDNzS/ocyAfrtKW/jKqH9JYpvmiZym88kOqUTTp6GL7RjiAUaGTbCnpPNf30VLelzh5y69/QWAUV/b4I8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495830; c=relaxed/simple;
	bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7ESdU6ssgTVtwpVWlf55062ZXrTKoi0HTFnFsSiHcl2K1ZRElUVakNbbCc4IBeNWEy4XxpHMxZhe6rvmBEsYabYuVbFPZ5vqkk/dLGps2oC4GUQOu2IkIcIDLiTNxTTXYq1zVNqAwrJzMKLYOE9VTkWGoSHXn5Po9n9Svgedv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SVjhD+ox; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723495825;
	bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SVjhD+oxE/Z6fpR8Qx6Odbc9QLFZ7aEky5n+RMi/ATgcjwu6fH/2xOrVe/J8rYKXC
	 3p9HR/6Y/BtrvtbjBiNQnWK75DCL98wxN/IiqyhJXnHUYm5nJFQAF4zOnHCprD/BVX
	 XZbRPBXm9YhUPA8nUHpMsxkLjr8XlJYvpMk4YrOU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 12 Aug 2024 22:50:18 +0200
Subject: [PATCH v2 2/3] tools/nolibc: stackprotector: mark implicitly used
 symbols as used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240812-nolibc-lto-v2-2-736af7bbefa8@weissschuh.net>
References: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
In-Reply-To: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723495824; l=1268;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
 b=OD+HTIBp9LlVZswB1833xxThdDWP2wtxNi66W2sfbN9yEPVKPWJgY9pm+/q5qobQfGg8sd9+k
 ob2SecVeRygA9/Qp0BjaY2bSfhhYT5wU0WGl7rviZlUocaX8cllqt/M
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

During LTO the references from the compiler-generated prologue and
epilogues to the stack protector symbols are not visible and the symbols
are removed.
This will then lead to errors during linking.
As those symbols are already #ifdeffed-out if unused mark them as "used"
to prevent their removal.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stackprotector.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 13f1d0e60387..1d0d5259ec41 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -18,7 +18,7 @@
  * triggering stack protector errors themselves
  */
 
-__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+__attribute__((weak,used,noreturn,section(".text.nolibc_stack_chk")))
 void __stack_chk_fail(void)
 {
 	pid_t pid;
@@ -34,7 +34,7 @@ void __stack_chk_fail_local(void)
 	__stack_chk_fail();
 }
 
-__attribute__((weak,section(".data.nolibc_stack_chk")))
+__attribute__((weak,used,section(".data.nolibc_stack_chk")))
 uintptr_t __stack_chk_guard;
 
 static __no_stack_protector void __stack_chk_init(void)

-- 
2.46.0


