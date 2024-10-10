Return-Path: <linux-kernel+bounces-358216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C21F997B86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E573B23722
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF2191F7C;
	Thu, 10 Oct 2024 03:55:30 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AA179A3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532530; cv=none; b=rZ4yc8aNcBYndrCvIfX2isueEDkEgzbI1ZZF8/1K5zxLoL/mDof3w/E0OK08ABshY7m8Bw8J7TOkvJWbWKc4C27vBgEFfsGuTm6HF6BPKBwkd246dsLyxo+Wi2Tp20+UCuPLcRBzRbvcvTmzv+5Q7thbBJy51nEwcS7ngpKOk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532530; c=relaxed/simple;
	bh=fSexSEz06jcATUnQm/WxKWDa0VIL8CAgQ/5r8+pRI5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxeoXc1ZOwGTk9WVsMgy/EZf11Ux0rmNsnzXhnNkpbsKwrmlUBx7EP4ywWPvuA9h1qY9nQ+SPz1Qlw80iJx7T4z79wXislRyk1bRIW/0K1imHxNz4/cdfI4mVyyVL+aQxyT9pNfANkw1r8SviDvHJGir5xggibVrW9HbAuUZLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 29461AA28E;
	Thu, 10 Oct 2024 12:55:26 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nBG7Yl1SloE; Thu, 10 Oct 2024 12:55:26 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 07967AA264;
	Thu, 10 Oct 2024 12:55:26 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH] printk: Allow direct printing for PREEMPT_RT during panic
Date: Thu, 10 Oct 2024 12:55:11 +0900
Message-Id: <20241010035511.289657-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

If PREEMPT_RT was enabled, printing for legacy consoles are deferred
by default, including after printk_legacy_allow_panic_sync() during 
panic which allows direct printing afterwards in case of !PREEMPT_RT.
As a result, printing of messages during panic for PREEMPT_RT
is handled by the console_flush_on_panic() called at the end.

In case if kexec was loaded, console_flush_on_panic() will not be
called and starts booting into the second kernel without printing
the messages.

Allow direct printing for PREEMPT_RT during panic so that messages
before kexec gets printed.

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---

I was not sure if the behavior of deferred printing for PREEMPT_RT 
during panic was expected or not. I think printing messages would be 
useful even if kexec was loaded in case if it fails.

Thanks!

---
 kernel/printk/printk_safe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 2b35a9d3919d..67a0510a8e12 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -44,7 +44,7 @@ bool is_printk_legacy_deferred(void)
 	 * The per-CPU variable @printk_context can be read safely in any
 	 * context. CPU migration is always disabled when set.
 	 */
-	return (force_legacy_kthread() ||
+	return ((!this_cpu_in_panic() && force_legacy_kthread()) ||
 		this_cpu_read(printk_context) ||
 		in_nmi());
 }
-- 
2.34.1


