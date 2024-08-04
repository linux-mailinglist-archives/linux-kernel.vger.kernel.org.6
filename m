Return-Path: <linux-kernel+bounces-273647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87105946BB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E61B220A3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA9012D214;
	Sun,  4 Aug 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4KoX+7A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wizBu2AU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82950208AD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732717; cv=none; b=SZiBZPwqysLojJpygnq4iAiDlkQcztwwnaD3ZFq4ohBuobxK1DQB6X7VzzPFESlL3d2OiSf/xH411CKbDhPpBBwJ/7QcJz7bHHrf1N3EHEv5LL4Kzh3nP5p7el33bFlaU38FZz2vkBZEF76WAT16wjSb6TlGbZMekthGsY8lrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732717; c=relaxed/simple;
	bh=/2k5Mbe/jx6LPirTRLARhhYIxJ772ebHt4mVYxVCiNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xq5sUD7Pz8KKTd/95OiWPEgZ+2b0jW68d7xuapSK7N66SVsvrwkOUHnfNxIdL4Sw83mVPqLChm1PbsROo9sZ5/xJPwHXCZq9LPGDwwDP5c7NCrm1UpBf98qhcHM3rcNfUQgtSreJYNBHlyteTSw1hVGgmGnQUs2R8YShUqRKT+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4KoX+7A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wizBu2AU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWjvOXkPQNS41YYvNIgIKfsF4CC3vfaJOPzid1/Jwk0=;
	b=U4KoX+7ArHiL98yZdLI2t7wAOrKsYMaD7d8/HgS1xl5JAFKJA1qompgxDNBB+GtiSK94vA
	EBGSLSUVKPpkiW0W88amvAtedhTGSGNktsbBHl/3IiHh0Zt+UVSgqCFGd/ekjo7ONW+NBQ
	5MPLPNcDXcufgR3U/idjk9LBZJ+MBJl+JgYS9rQyI/VRuypExmn6mIcmYlL0TNa/nHwrTr
	otskX/8d/oBwvs79dvxqSzs91Eq6o82pndxw+g0cCFORbbHbvll0AHda48rXDoiwyJ/wzq
	zRAOn5QbScI96ov5WG1Be0WcRkuIHbGLIVzqUM1qTmt4jaPqE4zfKXonnEaQZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWjvOXkPQNS41YYvNIgIKfsF4CC3vfaJOPzid1/Jwk0=;
	b=wizBu2AUYO8jnSUKBhQZowc5saL/7/opBTubvu1FiuVng1A4a89fTvLamUPMJj63KQSSrQ
	GGopMDGFP03xL7Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 28/35] printk: Track nbcon consoles
Date: Sun,  4 Aug 2024 02:57:31 +0206
Message-Id: <20240804005138.3722656-29-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global flag @have_nbcon_console to identify if any nbcon
consoles are registered. This will be used in follow-up commits
to preserve legacy behavior when no nbcon consoles are registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a172c545e8dd..2277871e1f12 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -470,6 +470,11 @@ static DEFINE_MUTEX(syslog_lock);
  */
 static bool have_legacy_console;
 
+/*
+ * Specifies if an nbcon console is registered.
+ */
+static bool have_nbcon_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -3638,6 +3643,7 @@ void register_console(struct console *newcon)
 	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_seq_force(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
@@ -3718,6 +3724,7 @@ static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3785,13 +3792,18 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
-		if (!(c->flags & CON_NBCON))
+
+		if (c->flags & CON_NBCON)
+			found_nbcon_con = true;
+		else
 			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
 	if (!found_legacy_con)
 		have_legacy_console = found_legacy_con;
+	if (!found_nbcon_con)
+		have_nbcon_console = found_nbcon_con;
 
 	return res;
 }
-- 
2.39.2


