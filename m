Return-Path: <linux-kernel+bounces-281873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3094DC5B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF4A1C20B06
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549C157E93;
	Sat, 10 Aug 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mcsQlUod"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A128DCB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723287293; cv=none; b=olq57sRUL7Y/LYttKruw8e9Jtal8xycTNfCiosDp+otXiTIuQozuhnPTkTavw5qg6iEQMnKelJYh4lj8/66bOi0MLX1dKlMjKVelzpmyf6yqDi200ViUM9shFKxUXRs0gj8uWUtPztDCpuHLrGQKjSGCyIR3VreB3FzgXeS8K3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723287293; c=relaxed/simple;
	bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJvjCunzxxSGQjE43GAEwY3z7ueQ36dQayB85C5E7dMAjIpf1bU4PaioXu2MHLp25NKyqfYmyV44MISoxItZhwF5hnCVYy4CejJqVKNWNO/ZAMFcWjo2gCMvBN5H7nxnNbsDFgO70EYKiBF9V04K+2/guak3zBZ27uB+Mo+T9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mcsQlUod; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723287289;
	bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mcsQlUodksbtOpks/g2H3Q5g7chnrQ25wCxDado+C70n9LkFZMH51SnJnjYSQR0jI
	 P7Uad2MSpaPXX2QM3++XZhu0E8ya9an2TicUNdqf4tZo4njYIz0ZNYP7NYWZAoSsw+
	 k0z8kNnfJWda31kW0I3h37KFMk/C8v0kMnLbwBvM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 10 Aug 2024 12:54:45 +0200
Subject: [PATCH 2/3] tools/nolibc: stackprotector: mark implicitly used
 symbols as used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240810-nolibc-lto-v1-2-a86e514c7fc1@weissschuh.net>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
In-Reply-To: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723287288; l=1268;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/6UR9g86XgMBxrxchwxIH+6QiNLYmtw9EUkdltAltxY=;
 b=BD2VLzZM4cq9AS+CnW2Wa1elmV3h7CGqngIzFor2mev/TbPcJsIXTj0/of44hgd/G/0spUaoc
 7q1uGxYRIolBzifdDRg/Ex2ywNfCXomoWc+QPnce9ClZYknlJhGCxvD
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


