Return-Path: <linux-kernel+bounces-190099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2D8CF964
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F314B22519
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D213C3D2;
	Mon, 27 May 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aYKL3EDM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DoZ/Rjz/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4313A890
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791910; cv=none; b=bEXLiC6n6Yuw9IXFwLyAi+SSFshpdAJOGVVCxkXwnFC6USWbDLk01+UuPf1ytofXE135baL0OCUSuiY5vNow6qshpki+wdK9pv1XVC/gQo29lu0OS31vfeziPLzbVDcIAOABOy4jSbzHc4chlp150fMvUzeFk+IsB5/PZot6cQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791910; c=relaxed/simple;
	bh=sIDwBVtEZ9II9z34FVW/arDvGAYqJE9qC2xSXnoiiY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNHojcFJHH18EWfVvMN2COeK1DJ1aU+Fl6/mqMRILfDKAysSSjw7T3JeOeJHX0VS4VkETGh6OD4zd0f5sHub8hMyFsik59fM2Rk4BweNiSiuuRkM97RPmJ+BeiKv4RtfjJpmRNZzgUJkrqKtxBhwdP6dj7fHVV+7MHey1XKkrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aYKL3EDM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DoZ/Rjz/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mlGKrKUI3gQEB07A6y9zFTpJYkffg7XWV4RkY45mg=;
	b=aYKL3EDMXfEN5u/BkUloG96mutWZq+ZZ3GeBeND/InbJGzc5EnHbsePE/NpwThihtR6Vhg
	puXFNVoM0uOPbwIfHvqs1ebeGgAqdw3VXdJWbBvQu4mpWqUZBg/d2tdnQmp2wfSgJcp2jZ
	NjYDP6n6gg9s9TvsxVBcStU0AZ1dZ7kJ+pKz1h/wUmzThq5VLmQLyaorznGhZaKDHhyVNe
	iq/Kbs6sC4YZsWOjXtW/GhQ9mGzCkC3Qd0wCHIIxPkuzrm1zqjvW9ouu/FWC88PMgW4txo
	H3OBJW7ehFmb9jaEcgF1m0AEjBwBPgVTS3zhu7Ds6SwiIA/SmEpwqxNqdmSjRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mlGKrKUI3gQEB07A6y9zFTpJYkffg7XWV4RkY45mg=;
	b=DoZ/Rjz/SfznAeRULibeob0mkM4fpJHPWg3TxM8CdhkJ8PfklVRabiYNlhirPCEGqarBwn
	9ywtzurOjt4ZM3AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lukas Wunner <lukas@wunner.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH printk v6 27/30] panic: Mark emergency section in warn
Date: Mon, 27 May 2024 08:43:46 +0206
Message-Id: <20240527063749.391035-28-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Mark the full contents of __warn() as an emergency section. In
this section, the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console output is
triggered when exiting the emergency section.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index de8115c829cf..ee03193f9495 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -667,6 +667,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -697,6 +699,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2


