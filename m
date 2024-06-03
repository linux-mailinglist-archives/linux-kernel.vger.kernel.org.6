Return-Path: <linux-kernel+bounces-199824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A48FA671
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE116B20F16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DC13DDBA;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ugy8mT27";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoHxWt/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029713D2B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457100; cv=none; b=Q3AW6nT94bsnMAHwZSLvcWor+Y9B2QYuyU9Nij+s3xA0cAlP8u698UkL57a9wCiMUexd8ivRuH9mVDt+nEpuRT5YEKtmq3eDH5W2Mesz+XmDsixRCl3BCjq1SAnm9CXB9lvxZWS1eilvNjdfj4JkShz2uop1/Q4B/NAEW6k/6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457100; c=relaxed/simple;
	bh=1GPxJsazjgFSmtvziKA2daYP2cJk4PeD/79aElPpmV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZL2POwXgCnrKRTOpMOCa6wqt1u35Nqb2QCe2ghp8BoI3I0WSbHM9A8G0Y/gAuffnxL4H86iVjOIFk7SWLgSr1RH8RVX/sYMmIhxp9QFtKJSonlNM8TWbkvo0Tgjk7aSoWpZExo9+h86WevrzQrG3+uZ0IvvNBtQZq6FmWZEO4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ugy8mT27; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EoHxWt/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3r539HPiGZ1ucztmTvwYfwwdyMDVQwx7ANJGpwQWgU=;
	b=Ugy8mT27KdRZEzx99VjJZzeebPpUyaWC554x2HvHaMK4xKaZlrkbdIG9Wu+Dy2RX6Iz9yv
	s2+BZXyqq6sENqhYcb/RJWKGbowNN9x3mY/UtKgP6Rs/mt3FGsizQsS85ePBz7tHJtkFxC
	LWl+rJPaNYFv1QRjKqMmKSaIxhP8NfWPCCAG/Zfj0Z+yB4eqm29PhYqs0Worv2Eif0q/tM
	zVVWNzDo/183+vRmg+t1PyDpSXfNHpQ7bUkxJs8WRJLV/DObJS8epL3+ayvhBbsEA0Vndn
	ro72ykqUn7MT2Hle36AmdHKC4vTH4AxWsYQU/agXxugV0wBoBbklm3qKf+TPXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3r539HPiGZ1ucztmTvwYfwwdyMDVQwx7ANJGpwQWgU=;
	b=EoHxWt/nLPkRcB9vqfRfKnHhGNiNmYiGJ/6KIay44Uw62QdQGjp8cqwYhJAlcfxXNWi6sb
	RSJc4NUoFRAcAqBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 08/18] printk: nbcon: Stop threads on shutdown/reboot
Date: Tue,  4 Jun 2024 01:30:43 +0206
Message-Id: <20240603232453.33992-9-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register a syscore_ops shutdown function to stop all threaded
printers on shutdown/reboot. This allows printk to cleanly
transition back to atomic printing in order to provide a robust
mechanism for outputting the final messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4ab47cc014a3..f60d47b5db8a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/syscore_ops.h>
 #include <linux/types.h>
 #include "internal.h"
 #include "printk_ringbuffer.h"
@@ -1703,3 +1704,33 @@ void nbcon_device_release(struct console *con)
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
+
+/**
+ * printk_kthread_shutdown - shutdown all threaded printers
+ *
+ * On system shutdown all threaded printers are stopped. This allows printk
+ * to transition back to atomic printing, thus providing a robust mechanism
+ * for the final shutdown/reboot messages to be output.
+ */
+static void printk_kthread_shutdown(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	for_each_console(con) {
+		if (con->flags & CON_NBCON)
+			nbcon_kthread_stop(con);
+	}
+	console_list_unlock();
+}
+
+static struct syscore_ops printk_syscore_ops = {
+	.shutdown = printk_kthread_shutdown,
+};
+
+static int __init printk_init_ops(void)
+{
+	register_syscore_ops(&printk_syscore_ops);
+	return 0;
+}
+device_initcall(printk_init_ops);
-- 
2.39.2


